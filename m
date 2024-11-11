Return-Path: <linux-kernel+bounces-404582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265209C454C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFED282BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9641C8FBA;
	Mon, 11 Nov 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF31TO/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787871C4606;
	Mon, 11 Nov 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350909; cv=none; b=C/0NGzhrmllgNluBOhnVdTxWYf7IhWefFEZKRijfAXpZ0IGgkXUDGe3Wy/D9AtFROyDbkxdYCjVFpM/SY5XJdGUN8i9NJmFZR1k2Z+EfoCepwA+4QKHUFmONUQ3ilZp6V68VIU5gHn6ZJNV0URnhnh26/W2zpBxX5m513iimXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350909; c=relaxed/simple;
	bh=fo9PUvD/w/Jw96ccQE/VLMRIjZ1+9DHuusd3x0qGuUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/s9Xh1E622rWlUtFhrn0CIVQR5QsY5GjhqucxpZyf9MatzCkkyHsohrlPB+AXaIGnkjyn+OY3dFJCx8oX0mJIqrCylvT6q/Vkt1KSqSe2Xk0kpYCEFGoEcZ+dw1XWLQxDY8p6Jge3aghdP6zqyskYVcICVCzu8JHAEUjLkSKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF31TO/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D4C4CED7;
	Mon, 11 Nov 2024 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350908;
	bh=fo9PUvD/w/Jw96ccQE/VLMRIjZ1+9DHuusd3x0qGuUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mF31TO/RneFZnXX8VGhqYGz+VVOqe1RHzqP+ovsKPkwdLD7TwB/5e8McE8eBv96/d
	 F0gSTW1/uvClIncULjgsP9jC8K6pEvAqIjWsO/hAM2q//lC7cR1+bReAqd6/20qfQT
	 sTNXVnUTEpK6Jbz4b7xtaxvN6bxXEO159U1TZ+CwRnM++5Mnso4ILyP1nFBrBP62w2
	 2M3QpS6tPLRQLSBvTfAVZloNrfut6zAuUgzU6pFLBx1LqmJlPUxsPpWIficwG/qWU3
	 mbsX83kFtqRPgheZU4POa2mvV5an70qki//SbN3oBYg8h04fvKqbWQbEmCIbzT9qLp
	 xDWRJC25vvS/g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:48 +0000
Subject: [PATCH 16/17] ASoC: max98926: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-16-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fo9PUvD/w/Jw96ccQE/VLMRIjZ1+9DHuusd3x0qGuUU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFjMfsPyW3EWIbKJk5TYP5E3HNo8fGeaVIyw
 w3KEUICerqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRYwAKCRAk1otyXVSH
 0EClB/97isMV/gN9+A7C036JvODF4mxxd7PpjYk8HbzMQ0OiyDZZuhY2RYuH/axiWfiymmiNebK
 2CmMKhenprWHG/fc4ZnDEJZKz5dp4WiQdxcsyY7HCZjezMZXZuaqahtHC9UCnPykPb9h6eAEfve
 uWYl2sOqnAkv4sLG1qL+NLPsj5sTNHvSPsd2B2Ju5eKf9ojPNfL0vkAe2xuuLFUo1gMiirZbVp+
 Y07Ilgg3kYc0NNRXm4lwuCnmjqPlNSGYXfQAHZDUlke198IJoP6V3iFmf8ncuxfhLBBxb933kUP
 W1KuyrFkRmfUA15HwytJvQpIPH3dxSHam09mv3WG9Owusugl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98926.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index ae962bda163ebfcd3f9c689d8137bf57e98021b0..ef672a2fcce1bd2008992faa8c39964bbd9657c1 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -506,7 +506,7 @@ static const struct regmap_config max98926_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98926_reg),
 	.volatile_reg	= max98926_volatile_register,
 	.readable_reg	= max98926_readable_register,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static int max98926_i2c_probe(struct i2c_client *i2c)

-- 
2.39.5


