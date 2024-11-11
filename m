Return-Path: <linux-kernel+bounces-404583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC09C454E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471371F22816
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F1D1C9B8A;
	Mon, 11 Nov 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBkoF6FI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB841C9B71;
	Mon, 11 Nov 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350910; cv=none; b=XZjG6V1VnvajfVQufdJEihidgX2e17lCpe47jiWiaXkVtabLqSkOPgAvXtp7S7mFRbYE7ouzTy0+F1fdJh9Mrvzy3QrkLgtmu/aGcyHxxn/xJk9V82Z+WyeU7dAtrSFS6CDvPhq0Wm5HoXlU2WelJ6a70n1pFbqB4c9ImZzvXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350910; c=relaxed/simple;
	bh=RodbN1OVE2eV4MkRdbJ5zWPOqcRJzErI3f2nitm7I+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qG8rA4TU41OH2jBzTx7tBHht+V3c04wJh9vk1ZcqdEuoLo6ollGsRx2ngNl0fwjMYbxEuuEnfYiAOcXUKS/dxJYdGDukiYrFxC+tGNPkJbOG19exPnLm14jISnREDLGx74TTsi4doslKSYliUQ7hW73bCo65hCJyrJ8GZqxxR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBkoF6FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5040DC4CED4;
	Mon, 11 Nov 2024 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350910;
	bh=RodbN1OVE2eV4MkRdbJ5zWPOqcRJzErI3f2nitm7I+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GBkoF6FIafe2fOLHVPB8gIt88idY91yVLDk0nV5EdesuheQXHJB8VnQ8DnCLDVAMz
	 y2s10TI9uZUPtB+DZcy379wojWMoEZsiyAQVN4bXwC1lZRzYK8M/UPoEt2dEhTieSh
	 BEV2qtjTx/2Nz0aQ9AW/0r5sB9jhL3whvd1qKJ5+k7hpfb6EJ0p06TsIFI7EwaWZpl
	 Crgmovi3FU+qxOSVxAO5HsQEzAFCnDJqo0gaJtNmnYW6FCZBu7wTorY+BKoSdIKrlF
	 bhWddIG8r6FwFAOt77WTADXozJs5LeGAtfCOoyyLl5ZcNKxsFeYaAfVNqWz441zbYf
	 F3wzFpm83a/CQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:49 +0000
Subject: [PATCH 17/17] ASoC: max98927: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-17-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RodbN1OVE2eV4MkRdbJ5zWPOqcRJzErI3f2nitm7I+U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFkiA7hP5ww+OMHu9RNIUlhqt/XDbAJpHC5N
 1WcGNhk7PiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRZAAKCRAk1otyXVSH
 0ArlB/0UtlHuCCDtllgn6kt3/WojNnQ/2M8XWkQozSHeYBbykqCdtAMAv4r6Q/CGeYVO29OGSv8
 p0JY/rQpfqpaczYtykxCnLG5htUVszpPelJZHPMleg5umc9UPVT8iN686nHrcwSL7oe7Teg3qeu
 5c82gtp+qZh7WEnNv6mvraQIRO8IeodjIPehdVpIa6SVEv9JIZCEGeymW0of+zg53Whm8he709D
 9i0dLM4ptVRt+XTGcQUPEohp14gY1hSh+68Dum8vGXGUrS/WeuU9LeznL340oUwiRlPUXy5LZiX
 IItISiqGYVlXLP232mOXoPkuMNys7tQfc7neH2F+JAT9wVsF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 747aa6f1d54f0dea1dfba798c6cf462c026a5050..e878a2b55996ef3ce3d93138d7b68c969b6d6b82 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -777,7 +777,7 @@ static const struct regmap_config max98927_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98927_reg),
 	.readable_reg	  = max98927_readable_register,
 	.volatile_reg	  = max98927_volatile_reg,
-	.cache_type       = REGCACHE_RBTREE,
+	.cache_type       = REGCACHE_MAPLE,
 };
 
 static void max98927_slot_config(struct i2c_client *i2c,

-- 
2.39.5


