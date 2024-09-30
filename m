Return-Path: <linux-kernel+bounces-344312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B2798A822
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6279C1F23C98
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0A1917FF;
	Mon, 30 Sep 2024 15:08:48 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280A1CFA9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708928; cv=none; b=QTf+8RUKl0Why+NxRC+LuoRIyGgxTyPZin95r/gLrCUYP+OouM22eCp2CuwFhZX0CbPdzrpMMUY8+4+1rUX+AqNvMlRiXLvlCFxdN99w9/GMLyNLFdxmQ13hHQ8AvYLYdcjBGKOTK8FufjQ3HSHJeac8KPODoc6+UsB/V8HcCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708928; c=relaxed/simple;
	bh=WuOaC9ECc/H2/m1Rb9WfqGcF0/Q4WHJgf7O61i9a10g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lTC8Hd7bg3x7VBsHOmIzmNd0fMXJiwTxPa49qfrD1CtW4aL4jMwk7a6gdvIqgMkmF8fF1FWVJHGGfBkUZEMpNpjCgs57Tx+mcScHhzc//bCkWgdW5v7TwmIFef+/EI+5OWhEGfVTZeE8kDd2jK0/poEIIw/Fq++YDquKiV3mI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:99bb:7ad4:7fac:370a])
	by albert.telenet-ops.be with cmsmtp
	id Jf8b2D00E4pGYif06f8biQ; Mon, 30 Sep 2024 17:08:37 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1svI0h-000wdt-PO;
	Mon, 30 Sep 2024 17:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1svI0p-000acd-68;
	Mon, 30 Sep 2024 17:08:35 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] soc: fsl: cpm1: qmc: Do not use IS_ERR_VALUE() on error pointers
Date: Mon, 30 Sep 2024 17:08:31 +0200
Message-Id: <8b113596b2c8cdda6655346232cc603efdeb935a.1727708905.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ppc64_book3e_allmodconfig:

    drivers/soc/fsl/qe/qmc.c: In function ‘qmc_qe_init_resources’:
    include/linux/err.h:28:49: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
       28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
	  |                                                 ^
    include/linux/compiler.h:77:45: note: in definition of macro ‘unlikely’
       77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
	  |                                             ^
    drivers/soc/fsl/qe/qmc.c:1764:13: note: in expansion of macro ‘IS_ERR_VALUE’
     1764 |         if (IS_ERR_VALUE(info)) {
	  |             ^~~~~~~~~~~~

IS_ERR_VALUE() is only meant for pointers.  Fix this by checking for a
negative error value instead, which matches the documented behavior of
devm_qe_muram_alloc() aka devm_cpm_muram_alloc().
While at it, remove the unneeded print in case of a memory allocation
failure, and propagate the returned error code.

Fixes: eb680d563089e55b ("soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/soc/fsl/qe/qmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 3dffebb48b0daced..659c579d751d7240 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1761,10 +1761,9 @@ static int qmc_qe_init_resources(struct qmc *qmc, struct platform_device *pdev)
 	 */
 	info = devm_qe_muram_alloc(qmc->dev, UCC_SLOW_PRAM_SIZE + 2 * 64,
 				   ALIGNMENT_OF_UCC_SLOW_PRAM);
-	if (IS_ERR_VALUE(info)) {
-		dev_err(qmc->dev, "cannot allocate MURAM for PRAM");
-		return -ENOMEM;
-	}
+	if (info < 0)
+		return info;
+
 	if (!qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, qmc->qe_subblock,
 			  QE_CR_PROTOCOL_UNSPECIFIED, info)) {
 		dev_err(qmc->dev, "QE_ASSIGN_PAGE_TO_DEVICE cmd failed");
-- 
2.34.1


