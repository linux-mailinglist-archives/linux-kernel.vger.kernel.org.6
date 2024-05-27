Return-Path: <linux-kernel+bounces-191482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB628D1023
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CF91C211C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46F168C19;
	Mon, 27 May 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hV0TiAH4"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E22168C0F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848097; cv=none; b=TRYUDCnxIbaLI5sJma6pi3JVfUHuT222wh+5uVREEWUl7qPrIU/M6kMMSl6D7q9Ia4ea6XtfIbMnPMKsHvukBySgzOVf39Zy8PmUbWXm1G1szFzlmhuMkN4H1ckjVQcxQj65VGA3K2GYIykkA6EqPAJJHiWN7maWWazKCxw9Nzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848097; c=relaxed/simple;
	bh=j5oibcSxm589l45pASxdb6FBfqDZis92OeGGMsGwS5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnstKAfi/HfWqS/+wza+PSflzINbmyV3Nzs0tA2uV6WCsAPVuQcLlPPSZeHC0TA4fABlo7IFbWNOGOPgvEivx3FiZLtoYnkIjbcaoyDCm37FQKGwTgalbjogDKHuEouHp6yhlIkV1P2xVBhYFi6DRQiAoN9KBjkUY4wGyGQjK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hV0TiAH4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-794ab0eb68cso266823585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716848095; x=1717452895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jUWOrWtAumoYo2sLzptzNq1yzATfRDQ5UlFzB+phU8=;
        b=hV0TiAH4JtvZbNjrd+EdHK8MTCdVgwhE0oaYfGd8P7L6NQwLsfXzlK++jauXTcgryS
         MiA21iMYbBKtx8njq/EOsyWpsnNiOI5wlfs8FCkh+lryTU2tBjznboVS0SBgubkBozY1
         huaEa2E5C9Oz6eSKP7kOHzh2CdYh6L/pWYSwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716848095; x=1717452895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jUWOrWtAumoYo2sLzptzNq1yzATfRDQ5UlFzB+phU8=;
        b=Sq3zO53THN3u2KvmaQiL7iXB2O52wfyTcKmfN6/nOu09BvjkP183GCKH1NB7OYU5mj
         zUn5lcBpKxEkJ8wcLJkoUD5JAZFE8gwgrXQsagz2oACMp5pTniXLOK2wyJiZ1l4iym23
         CZ+KJU73j1R02XsdbXUl5OK7H6ze2oz6EDGyz7CR3fRgATBXvMRfCeeY7Tc4n+qpf5xO
         2xHFgTsHIca+9x3pK2V7QUNyDWy9PCEu03dN0hpo16cN2lPoEP4WfxlWdcBGwcdK2jIM
         p5k4HgPsJ8dZ3c+TS3Kt4Fdw4ojBpo5ScyZ+cxxfe1gqJ0UNunex4V9eQRNcOEwkVC3L
         53pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXhTMk1WW1OSSXaNVV3buL420f7XL7HDMklDyf0B5IOzR5+nmn9ieYpsT2CbXflfgPzr195V8FTVXGS3tbaE5vpkYhyE+c1AvNQEf6
X-Gm-Message-State: AOJu0YzPvA9JP3h9oxhJDTVp+Cq8idytW20RFA9ThhTCfvrQzh6lVCOG
	OMBOM9GZ0Lmw6X7+XW3MItslZSJfCrBkzxTYgpNpNv4EoXXYvf9e4JGPoujldg==
X-Google-Smtp-Source: AGHT+IH61nEbsekzVgq75aSLN9qBFGg8M7QYRex7VvK2gWNTLHBeGwYaWZIgZ47+V7LN3MEcjYOvvw==
X-Received: by 2002:a05:620a:5816:b0:790:9f13:2ed0 with SMTP id af79cd13be357-794aa7ec9b7mr1708984285a.22.1716848094986;
        Mon, 27 May 2024 15:14:54 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca58e6sm329740885a.18.2024.05.27.15.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 15:14:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 22:14:46 +0000
Subject: [PATCH 2/3] media: pci/ivtv: Replace request_mem_region with devm_
 variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-devm-itv-v1-2-f5829b8e7674@chromium.org>
References: <20240527-devm-itv-v1-0-f5829b8e7674@chromium.org>
In-Reply-To: <20240527-devm-itv-v1-0-f5829b8e7674@chromium.org>
To: Andy Walls <awalls@md.metrocast.net>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The managed device resource version of the function greatly
simplifies the error handling.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/ivtv/ivtv-driver.c | 45 +++++++++++-------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index 7599fffb0c9d..96f40c9685d2 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -814,24 +814,24 @@ static int ivtv_setup_pci(struct ivtv *itv, struct pci_dev *pdev,
 		IVTV_ERR("No suitable DMA available.\n");
 		return -EIO;
 	}
-	if (!request_mem_region(itv->base_addr, IVTV_ENCODER_SIZE, "ivtv encoder")) {
+	if (!devm_request_mem_region(&pdev->dev, itv->base_addr,
+				     IVTV_ENCODER_SIZE, "ivtv encoder")) {
 		IVTV_ERR("Cannot request encoder memory region.\n");
 		return -EIO;
 	}
 
-	if (!request_mem_region(itv->base_addr + IVTV_REG_OFFSET,
-				IVTV_REG_SIZE, "ivtv registers")) {
+	if (!devm_request_mem_region(&pdev->dev,
+				     itv->base_addr + IVTV_REG_OFFSET,
+				     IVTV_REG_SIZE, "ivtv registers")) {
 		IVTV_ERR("Cannot request register memory region.\n");
-		release_mem_region(itv->base_addr, IVTV_ENCODER_SIZE);
 		return -EIO;
 	}
 
 	if (itv->has_cx23415 &&
-	    !request_mem_region(itv->base_addr + IVTV_DECODER_OFFSET,
-				IVTV_DECODER_SIZE, "ivtv decoder")) {
+	    !devm_request_mem_region(&pdev->dev,
+				     itv->base_addr + IVTV_DECODER_OFFSET,
+				     IVTV_DECODER_SIZE, "ivtv decoder")) {
 		IVTV_ERR("Cannot request decoder memory region.\n");
-		release_mem_region(itv->base_addr, IVTV_ENCODER_SIZE);
-		release_mem_region(itv->base_addr + IVTV_REG_OFFSET, IVTV_REG_SIZE);
 		return -EIO;
 	}
 
@@ -843,11 +843,6 @@ static int ivtv_setup_pci(struct ivtv *itv, struct pci_dev *pdev,
 		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 		if (!(cmd & PCI_COMMAND_MASTER)) {
 			IVTV_ERR("Bus Mastering is not enabled\n");
-			if (itv->has_cx23415)
-				release_mem_region(itv->base_addr + IVTV_DECODER_OFFSET,
-						   IVTV_DECODER_SIZE);
-			release_mem_region(itv->base_addr, IVTV_ENCODER_SIZE);
-			release_mem_region(itv->base_addr + IVTV_REG_OFFSET, IVTV_REG_SIZE);
 			return -ENXIO;
 		}
 	}
@@ -1006,10 +1001,8 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 
 	/* PCI Device Setup */
 	retval = ivtv_setup_pci(itv, pdev, pci_id);
-	if (retval == -EIO)
+	if (retval == -EIO || retval == -ENXIO)
 		goto free_worker;
-	if (retval == -ENXIO)
-		goto free_mem;
 
 	/* map io memory */
 	IVTV_DEBUG_INFO("attempting ioremap at 0x%llx len 0x%08x\n",
@@ -1023,7 +1016,7 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 		IVTV_ERR("Check the output of 'grep Vmalloc /proc/meminfo'\n");
 		IVTV_ERR("Use the vmalloc= kernel command line option to set VmallocTotal to a larger value\n");
 		retval = -ENOMEM;
-		goto free_mem;
+		goto free_worker;
 	}
 
 	if (itv->has_cx23415) {
@@ -1038,7 +1031,7 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 			IVTV_ERR("Check the output of 'grep Vmalloc /proc/meminfo'\n");
 			IVTV_ERR("Use the vmalloc= kernel command line option to set VmallocTotal to a larger value\n");
 			retval = -ENOMEM;
-			goto free_mem;
+			goto free_worker;
 		}
 	}
 	else {
@@ -1057,18 +1050,18 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 		IVTV_ERR("Check the output of 'grep Vmalloc /proc/meminfo'\n");
 		IVTV_ERR("Use the vmalloc= kernel command line option to set VmallocTotal to a larger value\n");
 		retval = -ENOMEM;
-		goto free_mem;
+		goto free_worker;
 	}
 
 	retval = ivtv_gpio_init(itv);
 	if (retval)
-		goto free_mem;
+		goto free_worker;
 
 	/* active i2c  */
 	IVTV_DEBUG_INFO("activating i2c...\n");
 	if (init_ivtv_i2c(itv)) {
 		IVTV_ERR("Could not initialize i2c\n");
-		goto free_mem;
+		goto free_worker;
 	}
 
 	if (itv->card->hw_all & IVTV_HW_TVEEPROM) {
@@ -1253,11 +1246,6 @@ static int ivtv_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 free_i2c:
 	v4l2_ctrl_handler_free(&itv->cxhdl.hdl);
 	exit_ivtv_i2c(itv);
-free_mem:
-	release_mem_region(itv->base_addr, IVTV_ENCODER_SIZE);
-	release_mem_region(itv->base_addr + IVTV_REG_OFFSET, IVTV_REG_SIZE);
-	if (itv->has_cx23415)
-		release_mem_region(itv->base_addr + IVTV_DECODER_OFFSET, IVTV_DECODER_SIZE);
 free_worker:
 	kthread_stop(itv->irq_worker_task);
 err:
@@ -1414,11 +1402,6 @@ static void ivtv_remove(struct pci_dev *pdev)
 
 	free_irq(itv->pdev->irq, (void *)itv);
 
-	release_mem_region(itv->base_addr, IVTV_ENCODER_SIZE);
-	release_mem_region(itv->base_addr + IVTV_REG_OFFSET, IVTV_REG_SIZE);
-	if (itv->has_cx23415)
-		release_mem_region(itv->base_addr + IVTV_DECODER_OFFSET, IVTV_DECODER_SIZE);
-
 	pci_disable_device(itv->pdev);
 	for (i = 0; i < IVTV_VBI_FRAMES; i++)
 		kfree(itv->vbi.sliced_mpeg_data[i]);

-- 
2.45.1.288.g0e0cd299f1-goog


