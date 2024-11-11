Return-Path: <linux-kernel+bounces-404579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30A9C45AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9EB215A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE711C3F00;
	Mon, 11 Nov 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN/tRC3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC81C245C;
	Mon, 11 Nov 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350904; cv=none; b=iWxDpyb8gr6E+gpcnraJ93/cC+YallF/MMYSCMbm7JN5jEkPav06yJPX4aWZ+DeNpuOO9CljPCaEnc6DwbcB48iyIkMXM7kvek4uCiMxh7xyw8rvOZFHg13dlD47XXKedckxtgk7UIkGkd/FNDnDRBhHjQ/QVnVbT/0uvXB7XKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350904; c=relaxed/simple;
	bh=Fb5bYJb4cDLgS7XI/uRkL1dDz/+B1UGZw28kauC5T2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=miKGudrAtpHXz9mewSgaBwGB5svwEUSiLpwLJZYANy77V7QGFD0kPHtyP4R31fJHSfHNSMR1O7XX9C2o/Lir1vLTK/cQGLf1z9nX9FeXzGj9Ot8tyhO5Odpccwi1jxQuCyof7mGW/lHDwVPnkAQ5tfaGQXPOmMX88Zo0/TsRWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN/tRC3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB5C4CED7;
	Mon, 11 Nov 2024 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350904;
	bh=Fb5bYJb4cDLgS7XI/uRkL1dDz/+B1UGZw28kauC5T2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QN/tRC3cXul52EIsQ2ypPPVhctpTr8Nz2Xlsi+eXnecNz9X+tAhH2dC6Bhg9/7gfG
	 IEiiQvP8TICJ2ziOUGDTlBSdp19ZFFGboDoJqkNiH196fMreoN+BjJykSL2wABCfUr
	 MCHV2qFv72i8bjnyTk+0D/SxsMkuD8N6Nw/kvg5kjbKxfkCpGMXlftJHPmoWTTIJAu
	 2GPBacLqzSCV7jwqGbV+y/zKA7+U1VGQBjrZt7uB/HBDgvFckWiKKC6oqb9hPriHUU
	 Q8zxNs3kW9ZHYZ9YOxiZpzpzTs4Ff5nMCA5qU1I09P8h2wbyOalv4YLrYKKZczoh2A
	 j0CD5gAGUaO4g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:45 +0000
Subject: [PATCH 13/17] ASoC: max9867: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-13-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Fb5bYJb4cDLgS7XI/uRkL1dDz/+B1UGZw28kauC5T2U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFh0BvKzTcBjnRuQY2+1u6/BkKtmNACpu1Tu
 0bEQTgqwiOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRYQAKCRAk1otyXVSH
 0H21B/9mYlsQDd4D+RdzuGDVXHoKKaAyqzCnJHvpZA+l8k/lTAxXKZ4KHpeO8ftWKtHSBLO+Cqg
 5rGnp5jt/9xr3x10XqSA+Ae2Kvz5sl8vRQwJSzfO7UIptneQYf54m9SjHkeSG8d6i0t+hv/2doa
 jfFpxfzqEue2JuxgCNUyaOFiA8UiQtYEBYYSq3Nz3jrMneFBQ4wd4AzSJTPwrNK1IDe3MWEhiTS
 iCBMdg9YRG6qfbrsZrstQoNrL6QFggt30PKFTDYNy5G49afs9euPTe/vLKGsKX8iQKLEN9yriJ6
 C7jpCRK9I7Lnux4H0Xi+CRwWyG+04xVc3oJEHH7MxkRMaYc7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 50db88fce904ff674c5a1dfc676de58c0ae5c4dd..7a69f82839aa91151174b5ba5dc7b8a3e7958385 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -644,7 +644,7 @@ static const struct regmap_config max9867_regmap = {
 	.val_bits	= 8,
 	.max_register	= MAX9867_REVISION,
 	.volatile_reg	= max9867_volatile_register,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static int max9867_i2c_probe(struct i2c_client *i2c)

-- 
2.39.5


