Return-Path: <linux-kernel+bounces-193882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A98858D339B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4803BB26BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB7E16E89A;
	Wed, 29 May 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu0r1WZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD515FA8A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976141; cv=none; b=C2XhytqG9CJvZTD4aJ3SoaOjjHmBwGnCByqYf0t2ucur6eh+PaQzUEBRFx4FK/ehux5LehNxDWPVIyH45wSJuiKXcFIsDz67JWLLPfI+BHyEOkMqZPGBm1POh6VeRhNLwGuJA/iASxWf/zyiiTeh3ArnFUl9OsobVPtHlctSdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976141; c=relaxed/simple;
	bh=8ujELDT4/VemDIoPdgqNcPZ20d2mihyif7bauGvChb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ysu0mrARdhFxZaoGiz2ak/jiURttuZrIUTl3OjojM9Srsyjmfyiuioon1zCxU3XMCTdqRD4P7aytPxxG61/Qz5Qmqj/Yatq0qzGwScKJnFixwZkPep4ye5b3WbtPuKd+u96ijWKKm6tzc5YUm8AdeDi3GkeYc4foMRrx7kHw1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu0r1WZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F378C2BD10;
	Wed, 29 May 2024 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976141;
	bh=8ujELDT4/VemDIoPdgqNcPZ20d2mihyif7bauGvChb4=;
	h=From:To:Cc:Subject:Date:From;
	b=Pu0r1WZ4Do3sEl6hi2unaAzAefPeO2N6ZGLfLyHPZ5IR5gM3X/CqxNQuIG6Pu0am8
	 EViy1WiZ4UFu16Cb7Ath9xrRne03lZByHFZmpb3Pg5XgjjR3KgqGIcy5p5MNtuEFG+
	 MdNqkvwSWH0k2UeH61WuBgUKDGN6bvN+huPHbKv9ZUg7uPPUXntcjVtjXzViOtbMdw
	 2y/c2lMV4lXD3jR7B2ArGCkq3QGxBYq108HOgGtXSbIQQHpzpfar92rClsjmMOeVcb
	 8StLn0mgvthQ/paouX03Dq+A160NZeLRlob+eVRZrIHxL9qv0GClCe0rtxivOrGn8o
	 eHOGkge403M6A==
From: Arnd Bergmann <arnd@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Min Li <min.li.xe@renesas.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Okan Sahin <okan.sahin@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: rsmu: split core code into separate module
Date: Wed, 29 May 2024 11:48:47 +0200
Message-Id: <20240529094856.1869543-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Linking a file into two modules can have unintended side-effects
and produces a W=1 warning:

scripts/Makefile.build:236: drivers/mfd/Makefile: rsmu_core.o is added to multiple modules: rsmu-i2c rsmu-spi

Make this one a separate module instead.

Fixes: a1867f85e06e ("mfd: Add Renesas Synchronization Management Unit (SMU) support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Makefile    | 6 ++----
 drivers/mfd/rsmu_core.c | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..db1ba39de3b5 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -280,7 +280,5 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
-rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
-rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
-obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
-obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
+obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
+obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
index 29437fd0bd5b..fd04a6e5dfa3 100644
--- a/drivers/mfd/rsmu_core.c
+++ b/drivers/mfd/rsmu_core.c
@@ -78,11 +78,13 @@ int rsmu_core_init(struct rsmu_ddata *rsmu)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rsmu_core_init);
 
 void rsmu_core_exit(struct rsmu_ddata *rsmu)
 {
 	mutex_destroy(&rsmu->lock);
 }
+EXPORT_SYMBOL_GPL(rsmu_core_exit);
 
 MODULE_DESCRIPTION("Renesas SMU core driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2


