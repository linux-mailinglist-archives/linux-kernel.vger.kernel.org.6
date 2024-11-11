Return-Path: <linux-kernel+bounces-404574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4479C4543
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505D51F22DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B941BD4FB;
	Mon, 11 Nov 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt4KOAgz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC021BD009;
	Mon, 11 Nov 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350897; cv=none; b=RZ+3EFobTlQzuSD0WSgYP3qjOTFCZBKPQvbH5CRIwqDXmREhkN8wH9qNrpZEB45qW1JKFfvzVW7X4qbvaL8OayD8flcqAyapmKmee59Jo/wKp27sQ1gerl18LA2Lz/TvdRXrujyAa0Lfu1laEdWrB1xlxuAHF/uHL7lKjTEsNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350897; c=relaxed/simple;
	bh=Sg/ApRY/YXeSjnCD14FRpE/MzffjlFkefkQ5VNeDdtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFANVTd67XuVI6hnIedCxbF4NRfMUOqyU10J893Gv2fEAvLlIPM+B+w7/hTFp6n9rwlXpxKnSZ27nmpyKJ6mkY80+FoFOymoJkgx9App02fzis3gignFgSTgAxBIvRsKPTWjCzGG9N0C6LI/WB4d/xNuwhmtXx3llWsow+THIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt4KOAgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FF2C4CECF;
	Mon, 11 Nov 2024 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350897;
	bh=Sg/ApRY/YXeSjnCD14FRpE/MzffjlFkefkQ5VNeDdtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tt4KOAgz/khDKrak2lFeeaAZb/MwfSCyzAr4zyMRRUAP8WI1t6TFeEjxu7M+3x9dI
	 rd1GTGF90E+WP9VRrITkFR/Rl5Mf78luTYygTr1ESwHGcYnYwYA3LnmTWH2WYhPIP1
	 /TQ6+WuAerVs964FBGxxlkciMUp+n0e+W9wPJt9yw5hoFDogrsU7utkM3ycbFqO7pq
	 RaxVRGvx5ZmENxDa5XYu1XXoIuZ7Vw4sSLOBBGbwfOJqhMuwjTDv16Dj7+z3dKlowT
	 MzyJqP5110jiimMMNZXXdiymLW7NZZDldSEUrNsBRs6vKFLROyWX3jtHSiEI6+U3MA
	 0/7M16R7Bukow==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:40 +0000
Subject: [PATCH 08/17] ASoC: max98390: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-8-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Sg/ApRY/YXeSjnCD14FRpE/MzffjlFkefkQ5VNeDdtw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFdgZR6JLUIeRGPfDYIBqJPFCKVoKDq0hSWe
 TSX5tMt19yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRXQAKCRAk1otyXVSH
 0F+vB/432Vq64VcBhhu3DMuzeatyWQvCr50pSiGcR2EoIx2/h2CcO4w0Ov0eP1mQ459dskyw0TO
 P6s00dmD9tGDiXY1yrIQJpZ8CHJRk196DkOE0/jZV1Ee0A/wLaSpuntrwy8tBrbf/xdvVJIbvI9
 L+ez70+k3QBbRKV5O/+NOoT9eZnq16/nlDpsJoGuQzGLRW+AHNRj26AKFA8E9V1wpjJDC6c3yNP
 y91WpkiB19s972fPohdIUK2wnhUbo0j53ev4Ksc79EkAHHNV6P5EWZODnVhPdIc6ypxpUaFNqwI
 gV1gRAmBkMsT1KHXCalRl4K8MhOBRcsqcBPqh+j4FwNGqoLX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 1bae253618fd07d2d796a47267829d42a3d14fe3..ef60fb6af2b1c474c4812e49293d37bfcb1c0f40 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -994,7 +994,7 @@ static const struct regmap_config max98390_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98390_reg_defaults),
 	.readable_reg	  = max98390_readable_register,
 	.volatile_reg	  = max98390_volatile_reg,
-	.cache_type       = REGCACHE_RBTREE,
+	.cache_type       = REGCACHE_MAPLE,
 };
 
 static void max98390_slot_config(struct i2c_client *i2c,

-- 
2.39.5


