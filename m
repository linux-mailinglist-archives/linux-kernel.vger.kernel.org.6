Return-Path: <linux-kernel+bounces-397850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400DD9BE161
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047E6283A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63E1D90D7;
	Wed,  6 Nov 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RVDddowh"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523C1D6DA9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883319; cv=none; b=r+QBXoS41rg7SBnt9yzQwV42fsxIeec+3sHoEtesmI33q2UEyDH76t8u0q0DSCFC2snmSsaJlxlZgYZvmSPGCgUE+AJ4b5uzgpqwXV5K2c9dTMigKPvR4YR78vhPagYg0srGGX2T+1EzAObVvVz+AKW0ywhMjPTQMrfru1hkww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883319; c=relaxed/simple;
	bh=h6Ixu3RgfB/yKWn7YlzSBsiXSugceNv8TIHypQHazUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMLaV0b/olvuGwKQNtgiz32wwUyPHlY7g/uAHzZtEs1K6ig6FFRWiCC2/hq2WoavMhx3wjZr2gksj+dbkHe7RsDHomeR6sqhMyzvZnVSmxFAEHvXar0hgwu8HL9XODeVQ305UGB9qSEs1iiOU6y1g915SckCug88k0CcLtq2wlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RVDddowh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 43EF81C0002;
	Wed,  6 Nov 2024 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=260i8Kmy1qIGGfd2CxjTGXG+BKpSWuDOsQ7KscW8IdI=;
	b=RVDddowheMh2Y67227SddCz/E09oO7H6Uo62/Qz482isvIR8bpHboW4ogqNv0HRNzNx+HQ
	RROWE8ReS8ZJySauLtKzS+nbf/jphrpqUt1iA0YwlOK/2pme7oYlSRl6axRD0HcH0Bit1Y
	9X0vSqiNbAiQ4h9ffLnx4Z6mYjU89P1/nYQ9iYAaH72pZpyEyXD1+3Oh7HaIB8lwQY1uug
	TU0twGZmgzdfDHhHxiRBLdOVqcBkwxbhgDCjc9z7WItkeWMCtTj25QKJyVyDoomx3nJoRv
	3mSKKrEja8YKpU62+oPD3S0VUHfM+ULHIeJkhu4mlINbj8l+HUqYD73nIQqltg==
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
Subject: [PATCH v2 3/6] mtd: rawnand: davinci: Always depends on TI_AEMIF
Date: Wed,  6 Nov 2024 09:55:04 +0100
Message-ID: <20241106085507.76425-4-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
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


