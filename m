Return-Path: <linux-kernel+bounces-314451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D2596B37C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543FA284221
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746517279E;
	Wed,  4 Sep 2024 07:51:17 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A61482FE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436277; cv=none; b=nsgzO8Bo56RtQEA+/1abz8rhJKe/EOC78nJcIkNKXxMXKgwQpm/ONdOZ2SCV1KCBRE1KCZ/zw9tNE5hPG+/ygqvbu6vwuxDsCZ8E8JyyeGWaXcEQ9mOUTN+XQlWioLBwBCNiLtdgGm6wNbqVzzfJOKnOi5L4t758S/bCxRKFGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436277; c=relaxed/simple;
	bh=rryD/qsb8DpQ62iy4z1sC76lv2cKkZWtVUpI7BBhplw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKOW/XbnBZ4L/uOxTh8MFdRdtMuM7TV8gQXkHGR0CfLwc96Zlokxiyj76HwInngoP0HsANywFtRsJhfiNpkTTlNTUbON/4cTy9MTf/xOt0EU958vLXYbe0DB0fpJfJBrY51pW3BSGBoPJmSgGoADiyZmVExBuOrQMgIFRd/RaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzF6p01Lkz9sSK;
	Wed,  4 Sep 2024 09:51:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qYpIcXmvmtsx; Wed,  4 Sep 2024 09:51:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzF6n6Qj6z9sSH;
	Wed,  4 Sep 2024 09:51:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD9C48B77A;
	Wed,  4 Sep 2024 09:51:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kKaLfropVvtH; Wed,  4 Sep 2024 09:51:13 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6886D8B778;
	Wed,  4 Sep 2024 09:51:13 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH] soc: fsl: cpm1: qmc: Fix dependency on fsl_soc.h
Date: Wed,  4 Sep 2024 09:51:09 +0200
Message-ID: <fcca0369d0bcd527aa77bccdfc0894faa029cead.1725431771.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725436270; l=1853; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=rryD/qsb8DpQ62iy4z1sC76lv2cKkZWtVUpI7BBhplw=; b=MoREKiPaV3SOEi6ZoLBSiakHPY29fDl3VZo5OxZ7yS4wsedLZM56lTJcG7q0NEx3Y/32lEuWl rxHnulqNuMsAr43O7Yx4A8IYxOOiajrhd8br9uf6JzrT0P7k2RsPM/X
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

QMC driver requires fsl_soc.h to use function get_immrbase().
This header is provided by powerpc architecture and the functions
it declares are defined only when FSL_SOC is selected.

Today the dependency is the following:

	depends on CPM1 || QUICC_ENGINE || \
		   (FSL_SOC && (CPM || QUICC_ENGINE) && COMPILE_TEST)

This dependency tentatively ensure that FSL_SOC is there when doing a
COMPILE_TEST.

CPM1 is only selected by PPC_8xx and cannot be selected manually.
CPM1 selects FSL_SOC

QUICC_ENGINE on the other hand can be selected by ARM or ARM64 which
doesn't select FSL_SOC. QUICC_ENGINE can also be selected with just
COMPILE_TEST.

It is therefore possible to end up with CPM_QMC selected
without FSL_SOC.

So fix it by making it depend on FSL_SOC at all time.

The rest of the above dependency is the same as the one for CPM_TSA on
which CPM_QMC also depends, so it can go away, leaving only a simple
dependency on FSL_SOC.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20240904104859.020fe3a9@canb.auug.org.au/
Fixes: 8655b76b7004 ("soc: fsl: cpm1: qmc: Handle QUICC Engine (QE) soft-qmc firmware")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index 5e3c996eb19e..eb03f42ab978 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -48,8 +48,7 @@ config CPM_TSA
 config CPM_QMC
 	tristate "CPM/QE QMC support"
 	depends on OF && HAS_IOMEM
-	depends on CPM1 || QUICC_ENGINE || \
-		   (FSL_SOC && (CPM || QUICC_ENGINE) && COMPILE_TEST)
+	depends on FSL_SOC
 	depends on CPM_TSA
 	help
 	  Freescale CPM/QE QUICC Multichannel Controller
-- 
2.44.0


