Return-Path: <linux-kernel+bounces-341938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F958988897
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62D92820D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D1715443B;
	Fri, 27 Sep 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9G6tOiW"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2851C172C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452479; cv=none; b=GXFxdaIked8liTRUQ3flQvwvoGCUGUQyBifzcoL78R1wroX6CwXCqrfnr07rXor4JHZAneFIKDfQAkAHeG8S51aWc171/OrhOqYTHLJeJcR3Wb3J7LZevrUn3VE3l8q4uiJuhgRvhLoWaztBlnyARytKxW4E0WWo2SeSIh6Sj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452479; c=relaxed/simple;
	bh=ep0RvRtv73mutGyS8SaEhoi+6lj917nsCDWLGYkd0eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cjJ0Aeb4QKugcuL+LabD+d92HQVsdGwdxgg8S2sBneEiprs7VqVT0wUJS+5FR4zTSiePWZSDIG/V4b8Xu1RAmr9SDP0oR/onAyyhqHvuWCfKwKjh40G4RTJ/SfGWsbNno9FqccabQsb9bMJzUwA+STQ338BwjasP/m0nnNrfl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9G6tOiW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d446adf6eso329295566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727452475; x=1728057275; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTWcf3wEQOp0ZG+W1Uw3hN1FUsd0hqHBQyj5b1PZ/g8=;
        b=T9G6tOiWrPlfX92E87K7rAZER78d+xb06DIeNa4uaVZOdJCmV9Lc80Jr9El9oGyGxs
         XrxgfR3uYOj6bVfc2zFilt1KOsjgDOntsyJZjpi8W1+39tRm65pf3ltGMdhC4O94y04p
         3uzGW7oaULMmSswMCAHF0BNTekBMCrf+DqzDetIzHW3fBufj0qQlfsn+ZrsWjbicGRbM
         ur4tN/YjpYnrAGHgB8qRVvfI/Nr/K4PhBHM5QA5I014tHoeOZxvRNOhfZZcW9O1VvPw8
         6+f+su8JNsnmkItZ19Gp0Xb0gmcJLjrMQeJ1145YAZijVF2QZsg7a/F/XTqRvFyNhUp5
         ZgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452475; x=1728057275;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTWcf3wEQOp0ZG+W1Uw3hN1FUsd0hqHBQyj5b1PZ/g8=;
        b=QB6OcEEoSv07tvNHT5W46d4leacn/G3F/aH2NeJl3lDfxaJfo0hvEVsPMTPGNt2IMT
         pLGYTZFwCEUtLnmQyMh3vLCHD1wjMfnIXKYp8RUK0Aj32sB3dLzdl/kAONtS33sy49W8
         QjlztvTbqx2Z+DIUuas0Z+mFW05tKlwvGNkTuopJV+KabmrpaGrxpWFr4T7t4mRFtoWj
         79/SeRGDOpKUXqzKQD6nPNb36tby3jiRDaDEIkh5X8KX4U3WDFL5e5xM4FJ40ivGBnrD
         KmMN0uGKKqu/NbIJc9YlkidIPVH/xw/rCyVbaAX36EvXSal0dEUMGSk/uAmBd8YOCaT/
         lkeg==
X-Forwarded-Encrypted: i=1; AJvYcCVIQZg1plGN9iiu5B2sw5T4vUwJOWa46mTtkUx3Gzf4Ubir6l48Zu7bm1VrMqqqZIWqYR+7C/KX5OaQJOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYeo4GckkfeJrnKvbBE5gssvlilEF9oZnT9nDcWDKyjw2t19J
	duLV9lRJKZvnj4wht0R5G2NiWYfv9+wwL7l1JRycKFo/Q3411cbG4uH1rtveoqVYW+z+atevQwH
	4
X-Google-Smtp-Source: AGHT+IETEFZCtphrEJ+iZKtr2ARdxALMycDyn4/kYKJb4Tv/4K8oebKQCLUJkqMC4yJc8htLh0JeQA==
X-Received: by 2002:a17:907:74b:b0:a86:7e7f:69ab with SMTP id a640c23a62f3a-a93c49087f3mr354566466b.15.1727452475311;
        Fri, 27 Sep 2024 08:54:35 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bc6fsm145874966b.184.2024.09.27.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:54:34 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Sep 2024 17:54:28 +0200
Subject: [PATCH] Revert "mmc: mvsdio: Use sg_miter for PIO"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-kirkwood-mmc-regression-v1-1-2e55bbbb7b19@linaro.org>
X-B4-Tracking: v=1; b=H4sIADPV9mYC/x3MSwqAMAwA0atI1gZq8VevIi6kjRqKVlJQQby71
 eUs3twQSZgidNkNQgdHDluKIs/ALuM2E7JLDVrpUhndoGfxZwgO19Wi0CwUP4OmrW1lWldaQ5D
 0LjTx9Z/74Xle1lZaiWkAAAA=
To: Nicolas Pitre <nico@fluxnic.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Charlie <g4sra@protonmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

This reverts commit 2761822c00e8c271f10a10affdbd4917d900d7ea.

When testing on real hardware the patch does not work.
Revert, try to acquire real hardware, and retry.
These systems typically don't have highmem anyway so the
impact is likely zero.

Cc: stable@vger.kernel.org
Reported-by: Charlie <g4sra@protonmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mvsdio.c | 71 ++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index af7f21888e27..ca01b7d204ba 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -38,9 +38,8 @@ struct mvsd_host {
 	unsigned int xfer_mode;
 	unsigned int intr_en;
 	unsigned int ctrl;
-	bool use_pio;
-	struct sg_mapping_iter sg_miter;
 	unsigned int pio_size;
+	void *pio_ptr;
 	unsigned int sg_frags;
 	unsigned int ns_per_clk;
 	unsigned int clock;
@@ -115,18 +114,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		 * data when the buffer is not aligned on a 64 byte
 		 * boundary.
 		 */
-		unsigned int miter_flags = SG_MITER_ATOMIC; /* Used from IRQ */
-
-		if (data->flags & MMC_DATA_READ)
-			miter_flags |= SG_MITER_TO_SG;
-		else
-			miter_flags |= SG_MITER_FROM_SG;
-
 		host->pio_size = data->blocks * data->blksz;
-		sg_miter_start(&host->sg_miter, data->sg, data->sg_len, miter_flags);
+		host->pio_ptr = sg_virt(data->sg);
 		if (!nodma)
-			dev_dbg(host->dev, "fallback to PIO for data\n");
-		host->use_pio = true;
+			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
+				host->pio_ptr, host->pio_size);
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
@@ -137,7 +129,6 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		phys_addr = sg_dma_address(data->sg);
 		mvsd_write(MVSD_SYS_ADDR_LOW, (u32)phys_addr & 0xffff);
 		mvsd_write(MVSD_SYS_ADDR_HI,  (u32)phys_addr >> 16);
-		host->use_pio = false;
 		return 0;
 	}
 }
@@ -297,8 +288,8 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 {
 	void __iomem *iobase = host->base;
 
-	if (host->use_pio) {
-		sg_miter_stop(&host->sg_miter);
+	if (host->pio_ptr) {
+		host->pio_ptr = NULL;
 		host->pio_size = 0;
 	} else {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
@@ -353,12 +344,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 static irqreturn_t mvsd_irq(int irq, void *dev)
 {
 	struct mvsd_host *host = dev;
-	struct sg_mapping_iter *sgm = &host->sg_miter;
 	void __iomem *iobase = host->base;
 	u32 intr_status, intr_done_mask;
 	int irq_handled = 0;
-	u16 *p;
-	int s;
 
 	intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 	dev_dbg(host->dev, "intr 0x%04x intr_en 0x%04x hw_state 0x%04x\n",
@@ -382,36 +370,15 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	spin_lock(&host->lock);
 
 	/* PIO handling, if needed. Messy business... */
-	if (host->use_pio) {
-		/*
-		 * As we set sgm->consumed this always gives a valid buffer
-		 * position.
-		 */
-		if (!sg_miter_next(sgm)) {
-			/* This should not happen */
-			dev_err(host->dev, "ran out of scatter segments\n");
-			spin_unlock(&host->lock);
-			host->intr_en &=
-				~(MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W |
-				  MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W);
-			mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
-			return IRQ_HANDLED;
-		}
-		p = sgm->addr;
-		s = sgm->length;
-		if (s > host->pio_size)
-			s = host->pio_size;
-	}
-
-	if (host->use_pio &&
+	if (host->pio_size &&
 	    (intr_status & host->intr_en &
 	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
-
+		u16 *p = host->pio_ptr;
+		int s = host->pio_size;
 		while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
 			readsw(iobase + MVSD_FIFO, p, 16);
 			p += 16;
 			s -= 32;
-			sgm->consumed += 32;
 			intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 		}
 		/*
@@ -424,7 +391,6 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				put_unaligned(mvsd_read(MVSD_FIFO), p++);
 				put_unaligned(mvsd_read(MVSD_FIFO), p++);
 				s -= 4;
-				sgm->consumed += 4;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
 			if (s && s < 4 && (intr_status & MVSD_NOR_RX_READY)) {
@@ -432,13 +398,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				val[0] = mvsd_read(MVSD_FIFO);
 				val[1] = mvsd_read(MVSD_FIFO);
 				memcpy(p, ((void *)&val) + 4 - s, s);
-				sgm->consumed += s;
 				s = 0;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
-			/* PIO transfer done */
-			host->pio_size -= sgm->consumed;
-			if (host->pio_size == 0) {
+			if (s == 0) {
 				host->intr_en &=
 				     ~(MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W);
 				mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
@@ -450,10 +413,14 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
+		host->pio_ptr = p;
+		host->pio_size = s;
 		irq_handled = 1;
-	} else if (host->use_pio &&
+	} else if (host->pio_size &&
 		   (intr_status & host->intr_en &
 		    (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
+		u16 *p = host->pio_ptr;
+		int s = host->pio_size;
 		/*
 		 * The TX_FIFO_8W bit is unreliable. When set, bursting
 		 * 16 halfwords all at once in the FIFO drops data. Actually
@@ -464,7 +431,6 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 			mvsd_write(MVSD_FIFO, get_unaligned(p++));
 			mvsd_write(MVSD_FIFO, get_unaligned(p++));
 			s -= 4;
-			sgm->consumed += 4;
 			intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 		}
 		if (s < 4) {
@@ -473,13 +439,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				memcpy(((void *)&val) + 4 - s, p, s);
 				mvsd_write(MVSD_FIFO, val[0]);
 				mvsd_write(MVSD_FIFO, val[1]);
-				sgm->consumed += s;
 				s = 0;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
-			/* PIO transfer done */
-			host->pio_size -= sgm->consumed;
-			if (host->pio_size == 0) {
+			if (s == 0) {
 				host->intr_en &=
 				     ~(MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W);
 				mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
@@ -487,6 +450,8 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
+		host->pio_ptr = p;
+		host->pio_size = s;
 		irq_handled = 1;
 	}
 

---
base-commit: 075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
change-id: 20240927-kirkwood-mmc-regression-986c598d4c9e

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


