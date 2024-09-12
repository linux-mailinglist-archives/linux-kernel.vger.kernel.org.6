Return-Path: <linux-kernel+bounces-327427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE44B9775D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06EB284995
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD21C460B;
	Thu, 12 Sep 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxxotc9k"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E6191F8F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185574; cv=none; b=LFkHKNDFYjBeBEAEkpIL8xpeCv8Ai1LAkHOGYvf6VqLAk/GXdgeHeFHz5K/a8e5LGZS9syM+AE6qEeu/B/QVjnkGwRAf8tp7CmRW/Pz1oy8xszSAiFpYOhJA4QBVwf3Wyc8VHIm2axKz7fvlDBZG6Ag9xFblY55BchtF7xtRj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185574; c=relaxed/simple;
	bh=Uz4OnRttDvhzBzZk/QxnnlfpqcWYDtNHnm6F0HsXFbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOjqrf5EfizLZdusK7chg03hgvqrC8MaRJ/vU9Fff8BL/BlQC13VedR8XnPBlZI753FosbJsLHO/0JTwLDq8MpRUQewLVN12V/DaTWE8XfcXWEjrcH1cZ5D3/QfTM05g7k6rLOxNZ6BvlYRE1xyVSfwOBJS+UX9tSTRhfPE6z2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxxotc9k; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cafda818aso14402095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726185571; x=1726790371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/lTQ7rZqFMn2EztlgqbzRX/ndyTuFKOTLsZIF22LaY=;
        b=Uxxotc9kJYz6bILoEZYZ5ux3k/XKy5bqx5BC6wD3ihXdGEj5xjYxjJbZDceu77+/O/
         2lqzpOe1n+7Qm8EtyxkeC3Cs7DjL+wix4shEASEdptu+EBr4KAlTp/pTKnvWAbp6VJ4G
         vfwzHWwPBuKy+sXhqgpLPdsrJPcWyE1xqUwt9TMAyQ8NTa6kYrsEDbYVekg0CQi5QRuS
         ZwGJQhHFYHX5iNX9pd2OcsrveyyYsXz2X+nXpEPL0iNTblxZ8L2RSZ5+cS/jitcxBp0H
         3S7cCwoilaJrBVK1ojx07Vn6Q62KEQF+60gzPGr8uotzFYnVrL/ARiUOnJKANsgk7bZT
         733A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726185571; x=1726790371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/lTQ7rZqFMn2EztlgqbzRX/ndyTuFKOTLsZIF22LaY=;
        b=wXFbyDZSGSEzGSs1cqKELK2H8iO/Hw38xjwfqhZaaP6VjkD29abKueb3UetxM4NJ6G
         7ydg0IpVw1PhI1KF1w5r46VnrB3/wnnPk0zqH678TGTAl6ADMi9iAiA5w+R+sZFuAGD7
         1s/VDMwsDTu9t5OH8cfDjc91DWC5i2fDREQ9cWfkXkjQf5zsYjWxv1MEkjILCa88JNHb
         FZxkFTjMeZjNUrrKB/cRTC18f6UGpxRA7JyTeMxqRiY0z/A6j7PXbKFCFnhWirdyQP6e
         fr9t26W8X0ll8u59BL3xx5xwoYZpP0KjYCYskOdSdcKE4gLwIUBNUxIsgn7+8fvUFvYl
         BUMg==
X-Gm-Message-State: AOJu0Yz/4tP2brIs9mGRpwYN9KyAIavLcU4XatWcL2pJv+LzW8rSKAXF
	VsSy+QzNPJPyCNiSqs7uEYiJXj+sWS7u8DwIbZAstucTqQzn51NCEPnjjg==
X-Google-Smtp-Source: AGHT+IG071/PqqdTENxulYYhvsYlH6vCJSzJ76evQcAjt+YhZCxg+fXnXqCcg86abhSnOANsR1ZooQ==
X-Received: by 2002:a05:600c:4fc2:b0:42c:af2a:dcf4 with SMTP id 5b1f17b1804b1-42cdb56ae3dmr33300245e9.27.1726185570921;
        Thu, 12 Sep 2024 16:59:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054f97sm6025175e9.4.2024.09.12.16.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:59:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 2/2] uio: uio_pdrv_genirq: Make use of irq_get_trigger_type()
Date: Fri, 13 Sep 2024 01:59:25 +0200
Message-Id: <20240912235925.54465-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912235925.54465-1-vassilisamir@gmail.com>
References: <20240912235925.54465-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the following case:

	struct irq_data *irq_data = irq_get_irq_data(irq);

	if (irq_data && irqd_get_trigger_type(irq_data) ... ) {
		...
	}

to the simpler:

	if (irq_get_trigger_type(irq) ... ) {
		...
	}

by using the irq_get_trigger_type() function.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/uio/uio_pdrv_genirq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 796f5be0a086..2ec7d25e8264 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -173,8 +173,6 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 	}
 
 	if (uioinfo->irq) {
-		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
-
 		/*
 		 * If a level interrupt, dont do lazy disable. Otherwise the
 		 * irq will fire again since clearing of the actual cause, on
@@ -182,8 +180,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 		 * irqd_is_level_type() isn't used since isn't valid until
 		 * irq is configured.
 		 */
-		if (irq_data &&
-		    irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
+		if (irq_get_trigger_type(uioinfo->irq) & IRQ_TYPE_LEVEL_MASK) {
 			dev_dbg(&pdev->dev, "disable lazy unmask\n");
 			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
 		}
-- 
2.25.1


