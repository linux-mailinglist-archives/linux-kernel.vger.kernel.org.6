Return-Path: <linux-kernel+bounces-410701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CF9CDFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D428248E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F91C233E;
	Fri, 15 Nov 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZgOtMjxh"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AB1C07D7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677201; cv=none; b=BiKFrZbA09C69pUk+VpgCAtQFEf3RHP1V/0byJtC+3adhSUwFFWk5+WA+iJI7IzVDQuaCLp1oy1hlk3UldYLV0t4Z3rPoKzbSC6BrVomQHhk//SPGbrFCdDRztIomjTH+ayEPIYDcRGQ1erR9sB89jfcWfTMUCxjoMHZzcfkYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677201; c=relaxed/simple;
	bh=h6Ixu3RgfB/yKWn7YlzSBsiXSugceNv8TIHypQHazUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mebub9jmbz5Ug4TO+LtwHWNo6sH+UcsOR2mzi0lH/3bPd712zNGC3JsbVjKSJFkTYJaUkR+DeV5yAQicTfko50qAgk55VB8DtvolXpvH1rhX2m7tHysLyPgP/BIHNG7DFA043C9JvH3c5Ehx0OLnvDq+kisKTuoZkgWP8WFiUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZgOtMjxh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0854D20012;
	Fri, 15 Nov 2024 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=260i8Kmy1qIGGfd2CxjTGXG+BKpSWuDOsQ7KscW8IdI=;
	b=ZgOtMjxhfqqfhb5wrw/ZDK8XDQSDWY20uGO3MZUwkVWkmm00QyDJaZw2skYrQVKHys1kCA
	I1emB6bMqJglIBeq/p+aDxDoO1wdZSK2pflR+t4XTFKS7TuX+scFlSTeYs2YClD44bL2Ez
	Gtt3Ig5Cd0FGJAOCskYDkCB51Juwfbpee6w4B0nr4ShUOKc4zxIRd26LRuyLVsSsHnhaZW
	hNzjaOAghVnKpMq+qdcTLuj/5ywSi7YJnDJH++ly3i+GhwUafEICO6vJID818fVc2eOcZ/
	yMV6TgXa2hjxNBaisFdNzFuQA0LHZYFj9PNsObjB5em4oqYTYMq7XwODteLHWg==
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
Subject: [PATCH v4 07/10] mtd: rawnand: davinci: Always depends on TI_AEMIF
Date: Fri, 15 Nov 2024 14:26:28 +0100
Message-ID: <20241115132631.264609-8-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
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


