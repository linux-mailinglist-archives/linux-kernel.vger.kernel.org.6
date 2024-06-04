Return-Path: <linux-kernel+bounces-201405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422908FBE12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004B828671E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0714D29D;
	Tue,  4 Jun 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="goYC5QZY"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F214BF99
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536571; cv=none; b=udifJYm+U83tUdghVWUGcbNDGxWPBZQS+XHGksL3vkqwqqALi3pEnk8hHji/ouF7w0GpPWLA9BqViFTISoIZTGSep2OG3OBkQ4JC3SZGZC/rrGAQvO6M2bN6UIuKmldgsFEiOZjDbBapm+hVdNlc2fftG4KYNjCB9vb28wAaqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536571; c=relaxed/simple;
	bh=2DD/kGQouJsnqGRFVITaf9uQ2MSslRqtd0UUnPUDx70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmjS8OpZTxPIRtEu5Lolw2xvKuAjMKwlpXCGk+S7mMCXTWptoMxFnGJ0dGJQI18rB6SbsK2Jcoh4TGcD1gpeSnqWUhLxl7lqJrRsJtAMQkLZv/qIQY5vy0va5D3NAr86yfG4Ex4O8zqpN585S3oEfQGazlBRGOfZbqtSwkEvdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=goYC5QZY; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=jNaCNho3HkpDyJKsOVs+JnrFnTAQRUo8cA0Au9KuneI=; b=goYC5Q
	ZYCkI43IZ1cDYG9/MiRnx4/qitPVvR9trSSdIkyUU9HOKNbtOHE06oYckn/gBdwL
	4AaIoV2WUrWwltIDSzIR6kfyepo4XckxtcR0N5nA2CGe8C8OHH3OrkPqhXHYfxSD
	ceOIC5tTEInewC7QCNN650EZMgoIdAfBDPF9MByFZZzNxiLSJwq3L/ZNuBbjC0Oh
	BYKJEVngtBHWUmm+MGcuBdxKTmZ5j43gg/N8NOpZGlGYeOSe/eDSK45V2nBZ7c4J
	uVdSA5jxQPkj5GkOAmRi9I+qO9loA/7FSoeAqtX5+juIUH43s1Mh1+c8O7VgOgUk
	PZhCC5QWGnLY+TfA==
Received: (qmail 2450944 invoked from network); 4 Jun 2024 23:29:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:29:27 +0200
X-UD-Smtp-Session: l3s3148p1@Lcj4JBcaAtpehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 2/2] mtd: rawnand: intel: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue,  4 Jun 2024 23:29:21 +0200
Message-ID: <20240604212919.5038-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
References: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index f0ad2308f6d5..78174c463b36 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -295,7 +295,7 @@ static int ebu_dma_start(struct ebu_nand_controller *ebu_host, u32 dir,
 	unsigned long flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	dma_addr_t buf_dma;
 	int ret;
-	u32 timeout;
+	unsigned long time_left;
 
 	if (dir == DMA_DEV_TO_MEM) {
 		chan = ebu_host->dma_rx;
@@ -335,8 +335,8 @@ static int ebu_dma_start(struct ebu_nand_controller *ebu_host, u32 dir,
 	dma_async_issue_pending(chan);
 
 	/* Wait DMA to finish the data transfer.*/
-	timeout = wait_for_completion_timeout(dma_completion, msecs_to_jiffies(1000));
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(dma_completion, msecs_to_jiffies(1000));
+	if (!time_left) {
 		dev_err(ebu_host->dev, "I/O Error in DMA RX (status %d)\n",
 			dmaengine_tx_status(chan, cookie, NULL));
 		dmaengine_terminate_sync(chan);
-- 
2.43.0


