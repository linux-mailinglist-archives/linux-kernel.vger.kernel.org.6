Return-Path: <linux-kernel+bounces-404568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EE9C453B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4476F283CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41441ABEC6;
	Mon, 11 Nov 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljTTbi+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B071AB6C7;
	Mon, 11 Nov 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350889; cv=none; b=ZzIkBQbn7y14WK86fIQWketjUBjrxhLQ+GoGfozTEedmUh23b0CU1n6dB94vbh+9W3KtTr3MSP3HwPtjFedxmIDEJ44Rg0uINjwwHAjAHs+kT7h8SHJOz5wfwUIFA/E10tGu8DmIu9o5+XeDub5iaOiprkypa/sbIMx5shvrI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350889; c=relaxed/simple;
	bh=w+FPXJJpCTiI1mxu9iw6K7a7RbAeN/EuOkZsEADJhaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrIwRRfqUefzd+GkY7nzndwiQcTtpwC3o3Lk/+H6EBQ0LJgWGSywtXIsByKUXhX4/qehVifIfMtTHZXVIDyweiE8WdNhP5PFZ6ltgOQl8/RXm8AQz+w8NC62TtMjjq1Vo6vKz9VGSLHL2c8vvAAnZLzSYLnQF14d3jPqot7JE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljTTbi+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF3C4CECF;
	Mon, 11 Nov 2024 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350889;
	bh=w+FPXJJpCTiI1mxu9iw6K7a7RbAeN/EuOkZsEADJhaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ljTTbi+r1KgTwLkTQXWv0wQpSu54iZyk2i01CBfhUU7PVgY+gQhwTSaz02YpyznI6
	 V1VtRCk/LfncZijWpxEtpBJ5PrdtGji4RFEX02P77bS5PKCsb1HZazTt9aWfQoRIeU
	 rV6xSBQUzFe6BqjWLqWHgPVSt+t6UTFQBzAxMQlR16tYBBGlMrYRmqynjtR0IJK2la
	 JTmAhZeh7tuiERgo2XV5h33/O6SqjVijG+O57F4NTBIqP7ZS3bzowNakgPUDvSsnr0
	 IB7UB3kKpSOvTWPvvyV/QUl1pM1RAY/vcgrcrUP5VDZNu5jGdxEdJVQkd1qsCqhy1+
	 BUbeypU0ALAbQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:34 +0000
Subject: [PATCH 02/17] ASoC: max98095: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-2-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w+FPXJJpCTiI1mxu9iw6K7a7RbAeN/EuOkZsEADJhaM=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnSjwIjDT35khMtZpdtndMZxpv2+Vhdarc2nVyXLbi0ja
 2J/0b+T0ZiFgZGLQVZMkWXts4xV6eESW+c/mv8KZhArE8gUBi5OAZjIigXs/x3vndH9LldpLan3
 9cWMtUdD2+359txPv7Zfv81WKKWBs8anTs75VZbBroQncfVtUTYumsURKsKrHmkfcZzDLqfY6PI
 h4Knfgmu+mjJtagoXtbR8dNdYa/m5Xk7TPfRMJaBh0s+Yo7HFzFem3hd6c2bu2gNTk3buecp6/Z
 94dN3l7TO03124FOUV9cKwbfJ8J0VhwQS9adNc9MSczsVtY3whyu1tEJOyun9awG+2uQ55IT9VL
 abPqGB4768pNWFXyjGHbR9LN/BeyP7B/sbjz+Kyhm0qco/vVHmb5r24pFPJeunpuvnOQu/WxM9d
 uXHDncP3+F12ZewI2a6+ufx/X2hSd+d7rkTWyng7xzfrAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 2adf744c652634a1539f7c20ca9102e5e8768b01..0454cea0fb13272434a7ed7d023bf519c8a00607 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2530,7 +2530,7 @@ static const struct regmap_config max98090_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98090_reg),
 	.volatile_reg = max98090_volatile_register,
 	.readable_reg = max98090_readable_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct i2c_device_id max98090_i2c_id[] = {

-- 
2.39.5


