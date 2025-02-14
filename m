Return-Path: <linux-kernel+bounces-514887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA347A35CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDAA1894D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3127266575;
	Fri, 14 Feb 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZTa1fSZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9857265CD1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533676; cv=none; b=VaeyvXIAJT+TWOLiwlnKpuaqsvzfHGjPW17aAbwydy52WCXvBJpxofxP6QLDy/mhWnLftq7Gd+qzJk8p0NNxgHvOof5UlWHl+RPb0H+2th0sqPCXLOThIhJ8jHTx9TDmyrjlH+mwCUK5fHYK84KO3mdwy+TgclbX0QmEG4JRiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533676; c=relaxed/simple;
	bh=aVgUx88kEl7lJykIBQ151ja7csomMZwy9qb3bZX2VWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU8rJXaF+ELurJLoR/SWrDeLVV5Tv9rsPAB4gDDbA89quggYaixfkz77BpeTUaPKjvzJArnZzqkAq9z0XVlrEQSM8qPrs4n26Jd8LBCZi2qoBT9p0E3Vmnc0Jlhi6cl9s/XnEUloPfhH3eEpZF8GHmloSQrGYh6lP0H7jzk94nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZTa1fSZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so13324035e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533673; x=1740138473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV/wHIcyPiJMDVxZsFhDgKvFfe1nNbR9A63exHbBC8Y=;
        b=KZTa1fSZ8i2dWULizmm6rSUf598jm7wfcIA5TWClp3xWMsC4i2aItC5gTz4I7P+/6t
         z1z5zpWFRkarQ0dPHLrDYayVBo+x/je/P43Pt3yJ6EwlGCg15AbHQCpBA844/rQ5ljhO
         QLVNVdeX60dMpUyCOfgatYo8UmEl0VUnA6leeFXn/WPMFPcysnMFqr9FaXQ/Xm43E1Xz
         aGom+SCHm1F4g42MwmYNuNSashIwk9plquJ1ZYQlWBC2VLuarP718PezrZKHF/0SVWHl
         lD6OuZqWKTP+I1JpX+Iq+XE/Gp0dQ58lCrvwKZNPVSWVnVWlq5zwn2o4LlonkUSSfziC
         l0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533673; x=1740138473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV/wHIcyPiJMDVxZsFhDgKvFfe1nNbR9A63exHbBC8Y=;
        b=pXfthqGYRp9qSO8rRe6AKr1YR7inoKDQTYM/Jb6jYxLa0b9nvsz2SyRrFsnkmiBDLG
         l1Z0q1/3HqGUsvtH3FjVwpJUnYLJUKI8RqOiO1Wvh1vMW5eBTiciBlxi8v6qP9mw4Y4r
         NDleQv4LP2JHz/BUIC7iWoa1Y/PJVqMW1Z0Y2OUBhexm/Rkzj16b5Ms8L+opS2hC2hle
         TgOwoZg7H+8Ut9YrVyHYT6RvxhGT8VszAr/OUdTf2UWKluEN/Dj3ttxl0k275qSoYdAS
         fxrtQOckLL/p+462wLsKFtdLhtsd13Is8/pzRWXS0JUIr9z50WjqS+mWkJ8jCXwMOInk
         +q6A==
X-Forwarded-Encrypted: i=1; AJvYcCV21ImrIRSvGUdjVzBdxw7BWXviU1rmP/49pxnwMCKp668jm+P7BDJwkEh9isifXKAcxT22Rp6YqAWargU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQz4mdYETh/Eg6OgJYol4g5SAhkZx9netqWuSpLm6QcrXPhCTZ
	gGDaaXNmZKR+L6daMixdpykKklLTBM0kU+Z4sKejq/D2O/kU4iLq
X-Gm-Gg: ASbGncvaEhbFTeBKHXiSZ7LQK/jtDu52jPGfGM//zCLoLxAOM2NMu/JdoRmt0J05eu6
	2Ay5zPTSWtqSuYuFv2clRaeqaDtzJMHWnkKMeIJ2KtRYxpmeX58aD2Qms5TIJTjmRKEj0kdyDvJ
	XdCmVuILm46xP0dFAOKP+T78fn9wJkl0n/FDpgM5ebBLjeBP02AgiqCk3TPBXfIOEhJLQA58iwf
	0D2zZoIFp3gYQSI6Y1wlKUSItm/FJIJRWhwz8PQJXE+atl6Wggfxb9tq+DPt1f8IhA93eBfyb9E
	RFVDBvm1RdWJY0ATw7gXcdRqpPQcF7GLiT1rj5d8inZmnbEPaJ8=
X-Google-Smtp-Source: AGHT+IFJz7z4il1DFNeT4rPu0PDh1kHLOWbD2DZnmKMPGgAexEJbFEFDsP1t2ZmaaGzmCBim1WVMTg==
X-Received: by 2002:a05:600c:5492:b0:439:45e2:897f with SMTP id 5b1f17b1804b1-43959a39e2amr150237205e9.11.1739533672855;
        Fri, 14 Feb 2025 03:47:52 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:52 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 15/17] staging: gpib: pc2 console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:06 +0100
Message-ID: <20250214114708.28947-16-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx

Turn long pr_err into comment, short message in dev_err.

Change pr_err to dev_err where possible.

Use error return codes consistent with messages.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/pc2/pc2_gpib.c | 51 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 3eccd4c54afa..6711851301ec 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -4,6 +4,9 @@
  *    copyright            : (C) 2001, 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/module.h>
@@ -268,7 +271,8 @@ static int pc2_generic_attach(gpib_board_t *board, const gpib_board_config_t *co
 	 *  is adapted to use isa_register_driver.
 	 */
 	if (config->ibdma)
-		pr_err("DMA disabled for pc2 gpib, driver needs to be adapted to use isa_register_driver to get a struct device*");
+	// driver needs to be adapted to use isa_register_driver to get a struct device*
+		dev_err(board->gpib_dev, "DMA disabled for pc2 gpib");
 #else
 	if (config->ibdma) {
 		nec_priv->dma_buffer_length = 0x1000;
@@ -280,7 +284,7 @@ static int pc2_generic_attach(gpib_board_t *board, const gpib_board_config_t *co
 
 		// request isa dma channel
 		if (request_dma(config->ibdma, "pc2")) {
-			pr_err("gpib: can't request DMA %d\n", config->ibdma);
+			dev_err(board->gpib_dev, "can't request DMA %d\n", config->ibdma);
 			return -1;
 		}
 		nec_priv->dma_channel = config->ibdma;
@@ -306,8 +310,8 @@ static int pc2_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	nec_priv->offset = pc2_reg_offset;
 
 	if (!request_region(config->ibbase, pc2_iosize, "pc2")) {
-		pr_err("gpib: ioports are already in use\n");
-		return -1;
+		dev_err(board->gpib_dev, "ioports are already in use\n");
+		return -EBUSY;
 	}
 	nec_priv->iobase = config->ibbase;
 
@@ -316,14 +320,14 @@ static int pc2_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	// install interrupt handler
 	if (config->ibirq) {
 		if (request_irq(config->ibirq, pc2_interrupt, isr_flags, "pc2", board))	{
-			pr_err("gpib: can't request IRQ %d\n", config->ibirq);
-			return -1;
+			dev_err(board->gpib_dev, "can't request IRQ %d\n", config->ibirq);
+			return -EBUSY;
 		}
 	}
 	pc2_priv->irq = config->ibirq;
 	/* poll so we can detect assertion of ATN */
 	if (gpib_request_pseudo_irq(board, pc2_interrupt)) {
-		pr_err("pc2_gpib: failed to allocate pseudo_irq\n");
+		dev_err(board->gpib_dev, "failed to allocate pseudo_irq\n");
 		return -1;
 	}
 	/* set internal counter register for 8 MHz input clock */
@@ -384,18 +388,19 @@ static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *co
 	case 0x62e1:
 		break;
 	default:
-		pr_err("PCIIa base range invalid, must be one of 0x[0246]2e1, but is 0x%x\n",
-		       config->ibbase);
+		dev_err(board->gpib_dev, "PCIIa base range invalid, must be one of 0x[0246]2e1, but is 0x%x\n",
+			config->ibbase);
 		return -1;
 	}
 
 	if (config->ibirq) {
 		if (config->ibirq < 2 || config->ibirq > 7) {
-			pr_err("pc2_gpib: illegal interrupt level %i\n", config->ibirq);
+			dev_err(board->gpib_dev, "illegal interrupt level %i\n",
+				config->ibirq);
 			return -1;
 		}
 	} else	{
-		pr_err("pc2_gpib: interrupt disabled, using polling mode (slow)\n");
+		dev_err(board->gpib_dev, "interrupt disabled, using polling mode (slow)\n");
 	}
 #ifdef CHECK_IOPORTS
 	unsigned int err = 0;
@@ -407,36 +412,36 @@ static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *co
 	if (config->ibirq && check_region(pc2a_clear_intr_iobase + config->ibirq, 1))
 		err++;
 	if (err) {
-		pr_err("gpib: ioports are already in use");
-		return -1;
+		dev_err(board->gpib_dev, "ioports are already in use");
+		return -EBUSY;
 	}
 #endif
 	for (i = 0; i < num_registers; i++) {
 		if (!request_region(config->ibbase +
 					i * pc2a_reg_offset, 1, "pc2a")) {
-			pr_err("gpib: ioports are already in use");
+			dev_err(board->gpib_dev, "ioports are already in use");
 			for (j = 0; j < i; j++)
 				release_region(config->ibbase +
 					j * pc2a_reg_offset, 1);
-			return -1;
+			return -EBUSY;
 		}
 	}
 	nec_priv->iobase = config->ibbase;
 	if (config->ibirq) {
 		if (!request_region(pc2a_clear_intr_iobase + config->ibirq, 1, "pc2a"))  {
-			pr_err("gpib: ioports are already in use");
+			dev_err(board->gpib_dev, "ioports are already in use");
 			return -1;
 		}
 		pc2_priv->clear_intr_addr = pc2a_clear_intr_iobase + config->ibirq;
 		if (request_irq(config->ibirq, pc2a_interrupt, 0, "pc2a", board)) {
-			pr_err("gpib: can't request IRQ %d\n", config->ibirq);
-			return -1;
+			dev_err(board->gpib_dev, "can't request IRQ %d\n", config->ibirq);
+			return -EBUSY;
 		}
 	}
 	pc2_priv->irq = config->ibirq;
 	/* poll so we can detect assertion of ATN */
 	if (gpib_request_pseudo_irq(board, pc2_interrupt)) {
-		pr_err("pc2_gpib: failed to allocate pseudo_irq\n");
+		dev_err(board->gpib_dev, "failed to allocate pseudo_irq\n");
 		return -1;
 	}
 
@@ -630,25 +635,25 @@ static int __init pc2_init_module(void)
 
 	ret = gpib_register_driver(&pc2_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("pc2_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		return ret;
 	}
 
 	ret = gpib_register_driver(&pc2a_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("pc2_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pc2a;
 	}
 
 	ret = gpib_register_driver(&pc2a_cb7210_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("pc2_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_cb7210;
 	}
 
 	ret = gpib_register_driver(&pc2_2a_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("pc2_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pc2_2a;
 	}
 
-- 
2.48.1


