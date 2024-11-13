Return-Path: <linux-kernel+bounces-407327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B859C6BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF61B28795
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2B1F9ABF;
	Wed, 13 Nov 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IMq96P9I"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C31F8F09
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491388; cv=none; b=Qo+55k16pz1jqVDbrUuxa0BbyjXMW1mpF/aXrXLMoqjlHM7TTTIiFSE4T20hzWhJ+tTXfiBIN3jVISKzChUuWovL+oSMlobQCKeOhGeP7dhFRQPomqz6xI1SgJup8skgfYpA6FhfG2IocEj7x45lkgLJ34zrccNrFZXboLMCWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491388; c=relaxed/simple;
	bh=h6Ixu3RgfB/yKWn7YlzSBsiXSugceNv8TIHypQHazUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XklbF/Ehtk71PSyGzJ+kbzgrsiIeF+uELSfthdyvcnm2XEG9/fUKQ35N6SF/VRwYeHpUH9jfLfdqdnhoiUf+HJMQMxXQOEH+NGUESTevBB3LufoIazxe3JXFHf5+vlzec+1+Jt7JqIkQSMelXRMGvIoW7dBvPwWwEwE65HlslrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IMq96P9I; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D46D2C000E;
	Wed, 13 Nov 2024 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731491384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=260i8Kmy1qIGGfd2CxjTGXG+BKpSWuDOsQ7KscW8IdI=;
	b=IMq96P9In6IIpdHVT6qJIa3yVx92sCrs2ivv9hdzVcY3aaZbT369sgXTGVN/d/OZR0e7/K
	ZA47g3QqlSDTjktZoJrkHNf7/hmc3rYHhqZ89LXL1W/qBChmNhq+8PmCuN8aCPDelDUM7J
	3lHb7TPnGjimMm2QvHyEtsiPRHaCnDhbYs+QVmtNNRr/7Zm6yBdS5Ij1e8K6bf8qlbAj8U
	6dd8GFtihedzk66zZX+7ykVRIjwCVjHm90427ZX0jFK/BPjgOeAHCajN7n1uhzwDDKRuxO
	wyp6wCe63JLZQ5mgtCrpWU8d0vaCLKZoX5VPa8SMn2K3h6sk9rKLm6eauaVygQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 4/7] mtd: rawnand: davinci: Always depends on TI_AEMIF
Date: Wed, 13 Nov 2024 10:49:35 +0100
Message-ID: <20241113094938.44817-5-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

DAVINCI_NAND depends on TI_AEMIF only when ARCH_KEYSTONE is selected
while the NAND controller is also always a part of the AEMIF controller
on DaVinci SoCs.

Set a dependency on TI_AEMIF regardless of the selected architecture.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411020140.3wsKJOSB-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202411020957.X1T8T9ZR-lkp@intel.com/

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index d0aaccf72d78..bb61434347bd 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -279,8 +279,8 @@ config MTD_NAND_SH_FLCTL
 
 config MTD_NAND_DAVINCI
 	tristate "DaVinci/Keystone NAND controller"
-	depends on ARCH_DAVINCI || (ARCH_KEYSTONE && TI_AEMIF) || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on COMPILE_TEST || ARCH_DAVINCI || ARCH_KEYSTONE
+	depends on HAS_IOMEM && TI_AEMIF
 	help
 	  Enable the driver for NAND flash chips on Texas Instruments
 	  DaVinci/Keystone processors.
-- 
2.47.0


