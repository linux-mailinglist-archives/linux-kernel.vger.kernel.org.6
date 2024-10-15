Return-Path: <linux-kernel+bounces-366088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5111B99F0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D24C1C20CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C91CBA0C;
	Tue, 15 Oct 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG/Gq1gy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD561CB9FF;
	Tue, 15 Oct 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005004; cv=none; b=LOkmLWw+g49EojrIsjSlCIAEZsWR+G4631nkNuSBpxbYs1VplbIiokyJfg/kPPZvW5EoQlJFweE0fV3LPIWfugyBv/Oclhw4/wjTxMoZzisBMGdUtadho68rsj06n9L4iGkk37xLI0f7PgYPJ9jnSL1Pj7aoxmVAAThko26jnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005004; c=relaxed/simple;
	bh=XNOT20YzB4vYewS+APrhVTDzfvkQCe35h99SfISE8h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDjjOvDnGoJAhb7jpMpryZGmVuBFsLLKfkAbWD7zIfuyFWdo1hBtZSIR5mGhpF+KFrfFHXUHmTg2moTBTs796/GB4G+eoZLU+2NLU9fpa5rBcxD288fsgOMo8Jkog2D5AnEw2FVCiUSc1z6m6yvefGdYb/SwUpHQkvW9f55v60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG/Gq1gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06467C4CEC6;
	Tue, 15 Oct 2024 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005004;
	bh=XNOT20YzB4vYewS+APrhVTDzfvkQCe35h99SfISE8h8=;
	h=From:To:Cc:Subject:Date:From;
	b=pG/Gq1gyPMhMtzDquoOzHLHu1hTZJCc22ixnM0lbTYg36EfNQ3JapbW2MJ9+rvkfg
	 +cdpwUeTqzufgtQQaAzHDTNZxjdDeXXFPqNwxTU7sy9SInys/uiOq5Bx5dnl2YT+Vn
	 +rPkOOFvQRAuiqWHgnQLP85xaKN2eziRqDVYahWEdZDkkmimYMFumMCdmHIXMvCkMu
	 B7y6QSc/SdLRJq4MdQbvcauSATMQKOxNphvT5B3AaNsBha3VKnOoCx1RtPaTPzIRBL
	 0CGLNeoUGY196b34z3praMGHpjlrveYNVKKCClFHuLXDuyRSSEaK4T93f/xztjX5sg
	 a+hy1L41wzdgw==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>,
	tangbin <tangbin@cmss.chinamobile.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: loongson: make loongson-i2s.o a separate module
Date: Tue, 15 Oct 2024 15:09:54 +0000
Message-Id: <20241015150958.2294155-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An object file should not be linked into multiple modules and/or
vmlinux:

scripts/Makefile.build:221: /home/arnd/arm-soc/sound/soc/loongson/Makefile: loongson_i2s.o is added to multiple modules: snd-soc-loongson-i2s-pci snd-soc-loongson-i2s-plat

Change this one to make it a library module with two exported symbols
that will work in any configuration.

Fixes: ba4c5fad598c ("ASoC: loongson: Add I2S controller driver as platform device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/loongson/Makefile       | 10 ++++++----
 sound/soc/loongson/loongson_i2s.c |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/loongson/Makefile b/sound/soc/loongson/Makefile
index f396259244a3..c0cb1acb36e3 100644
--- a/sound/soc/loongson/Makefile
+++ b/sound/soc/loongson/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #Platform Support
-snd-soc-loongson-i2s-pci-y := loongson_i2s_pci.o loongson_i2s.o loongson_dma.o
-obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PCI) += snd-soc-loongson-i2s-pci.o
+snd-soc-loongson-i2s-pci-y := loongson_i2s_pci.o loongson_dma.o
+obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PCI) += snd-soc-loongson-i2s-pci.o snd-soc-loongson-i2s.o
 
-snd-soc-loongson-i2s-plat-y := loongson_i2s_plat.o loongson_i2s.o
-obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PLATFORM) += snd-soc-loongson-i2s-plat.o
+snd-soc-loongson-i2s-plat-y := loongson_i2s_plat.o
+obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PLATFORM) += snd-soc-loongson-i2s-plat.o snd-soc-loongson-i2s.o
+
+snd-soc-loongson-i2s-y := loongson_i2s.o
 
 #Machine Support
 snd-soc-loongson-card-y := loongson_card.o
diff --git a/sound/soc/loongson/loongson_i2s.c b/sound/soc/loongson/loongson_i2s.c
index 40bbf3205391..e8852a30f213 100644
--- a/sound/soc/loongson/loongson_i2s.c
+++ b/sound/soc/loongson/loongson_i2s.c
@@ -246,6 +246,7 @@ struct snd_soc_dai_driver loongson_i2s_dai = {
 	.ops = &loongson_i2s_dai_ops,
 	.symmetric_rate = 1,
 };
+EXPORT_SYMBOL_GPL(loongson_i2s_dai);
 
 static int i2s_suspend(struct device *dev)
 {
@@ -268,3 +269,7 @@ static int i2s_resume(struct device *dev)
 const struct dev_pm_ops loongson_i2s_pm = {
 	SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
 };
+EXPORT_SYMBOL_GPL(loongson_i2s_pm);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Common functions for loongson I2S controller driver");
-- 
2.39.5


