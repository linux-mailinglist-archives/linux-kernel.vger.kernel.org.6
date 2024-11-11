Return-Path: <linux-kernel+bounces-404571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA529C4540
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1570283D57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39F178368;
	Mon, 11 Nov 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxhEObrr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75991B85C1;
	Mon, 11 Nov 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350893; cv=none; b=e7m2bRfz/90clWfq2cxwGJO287pxRoN7cMFXSxSIYZyIUyOLMulDOZoqfMl2VLPJXRqZs8zyFAm/5jX5d7JJD2IhTsqjii6RITIk0YUhIjHkimaeE77zFBnx99nwOAWMIjSa5bg1DQMBtaMyYFwTDtHWUhM0IYV6ybDs8sLdAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350893; c=relaxed/simple;
	bh=NmuyRa9uhWU3ZTAuPcy1hh1G475jgsgt++UPzNyes3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vs+i4jJJpBfczYkdvNimqT9J668fjJVUhgkupaMeh8v6QetHde6fzQGZypVd0lyrsoGTcxfxRD1OYLDSSnF3w3qedlyS79kRtPAU5KeYX2hXKH1byKichsE4pxy9Zy3P/lFfMEU61bIpxzzIgDlDrxggqdu1TcZlmuimnN96CNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxhEObrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F48EC4CECF;
	Mon, 11 Nov 2024 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350893;
	bh=NmuyRa9uhWU3ZTAuPcy1hh1G475jgsgt++UPzNyes3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MxhEObrr1ARE7oficyegXj5QcIIlSd+bbc5g77Xe39cw/tAsgLNe0UJ9NJpZ7uN1B
	 C5z5WTfYLI2w54Fx1sR2ifVtK060gZ80swTZcT1V1CuM98VmYb/KuiN9V7hMW6mHQc
	 grvMDFXO35z2m8Mxao0+QqpiHGpGyu5k7lAq6WvED2uNPy+8ABGzeWCuiCzPmg1SJv
	 kICBntqo4w+aBeMKngSeUf+chdxcsu6yLvUFoXntCwHwZnGA3DYvobLNns/OpByviY
	 fOumVLhhn9MtOo4v63llyb35cbub5OoEQKCalAPqaBYbRLYx9at93d4pmX0RnghXRz
	 o7SnjH+1rEorQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:37 +0000
Subject: [PATCH 05/17] ASoC: max98371: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-5-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NmuyRa9uhWU3ZTAuPcy1hh1G475jgsgt++UPzNyes3o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFb34FCK+HFVB6J0T5jlmQuZh+FAzHSJOmaY
 KxZ8IT+9DuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRWwAKCRAk1otyXVSH
 0HDyB/0U5pvPkxMDGBUaUNRlb1YdxsLsHj+Qn8OlasbXuCyjQxvGSukkwPHeXFCF1j28WA9gXZe
 Tms2AoLIKoEQ1IGYkRAoWrlnXVBTTtMuVOwKqp/yahoCH4m2iCGw1WCmtfCoR3rytR27RZHdiDQ
 E578sppUb/nyxZabC/RovzC1T2ACkWOaeQUvpM9K/mpP1Lp5LeNAvh+1lUTuOolexy+GUsXTziI
 afeBBYQf+C1lFhttltxpX8jD5PRKm/C6xUkOOtr9PCMt1bMruKd0IsoT6o9rEWIaIxGesyyE0/x
 0lcIcB6mpPlV68eS6fgN17cpucFbhg6fLVMdz6siCAURMXD0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98371.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 852db211ba1e72335857af32f3ac7b0445b89acb..0938272a2b11c919dd5ef507a08e14fa4f54fa4a 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -361,7 +361,7 @@ static const struct regmap_config max98371_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98371_reg),
 	.volatile_reg     = max98371_volatile_register,
 	.readable_reg     = max98371_readable_register,
-	.cache_type       = REGCACHE_RBTREE,
+	.cache_type       = REGCACHE_MAPLE,
 };
 
 static int max98371_i2c_probe(struct i2c_client *i2c)

-- 
2.39.5


