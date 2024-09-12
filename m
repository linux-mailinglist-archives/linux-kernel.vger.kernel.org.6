Return-Path: <linux-kernel+bounces-327426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A39775D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6AB1F24433
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2991C3314;
	Thu, 12 Sep 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axfbLoFL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A471C2437
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185573; cv=none; b=Cp10NjWPEZud4x84VFb4d8IBXK6po+8BWZymyxoX+E4d11ua47HR67xEaYiklM7/f9uGoxPVcK84k6wyI65r//438nBdvz4PeisTynR8Y3KiCRHYEYwX7G9GG+R+fPx8zbVFeTBe96OePPZHFmFL3CEBg1CPCLEIrqfoIBd5X6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185573; c=relaxed/simple;
	bh=XM26KY04ontlPzRH6lr5nNeJEXahsYuW2BFBiWDXduA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUCzS0r87otY19Xfn6IMasUHtOBqkMvPdNxdNH5yLu66qardCYwbmH0jfJDM8/6VZ2/MzrRrQf9rgQmtF41tfXtNS0d0NR4QhFC6aQ7AK1NqAWc1jfyoW3XO3Ghediejgovr5kFA2j8SwvrWoCOvWZfrwKFvzj02cfvEmmAXZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axfbLoFL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so14552255e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726185570; x=1726790370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tE0HBhgO7TYhcl7Kky6Fq8pKd+iF5PibST+mAJygZU=;
        b=axfbLoFLWaav67UqSu54YUh5mh9Gl6YtLvey/jNvFPCuQ8OM5TTTNEE/gztlEbX3Ov
         OHtQafAR4iPiWZmQEdQGkTcIgaYiZTz7wXCliK+O0e3gBRyCSMgGSO8/1BVyC/PVo7y6
         dcUI0LMfIgehp+JXqKacFGrCjuWPyAJvDkkObjYIvzPl6W0e5pHTPzC7I2GLhqq/r5gO
         wqqcomJ2etx9zRg6P2//fVx4Z0QAR3EQxXQb4yGokVaS94Kfu4+08YSWFZ15FGq4EMTW
         VsDqruTIaP7dl7XLNALl4WxdSSFlmAZOehdxLg+pwqHztqDgXw9K8Mz+dNMYBGsfOBL2
         J5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726185570; x=1726790370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tE0HBhgO7TYhcl7Kky6Fq8pKd+iF5PibST+mAJygZU=;
        b=tj7tlPy+E+101It61OHJZ+KSMnDgyNh1pztBCtfJ5znih7yq1V8jYc7c7ocJ1qEWi8
         Tax3sVKBpjsncHkfEeVFcAsroQVOxCiRihmYatzUeEnDW10WwcETwACeXO+MuhhFyM3X
         M+DXdAf91245K4OdEMzZCeveYSZMu+VhhpnwEDHoj0Wn6noVdIG9pf2AsAQ332boh4Qt
         ca2mM5DQKLTKsMqzv7y+x03xhJ2Ag6i9Z8iFoKICdCAYnr9zZtBZ4UsVTvtbxOTRbNXH
         pBgUiutzNgZLhNDEqWSDfa0zUqqTQZgL2/vnD6x5qNZIJSPhIUxFJdEHYsldU9QxmAIi
         Itjg==
X-Gm-Message-State: AOJu0YxiAahAmbJYNceIv+jVkCGPquJn63wZbB795VWxRwRvOW4ixqRt
	ayh73xC3zqjN0YfdVL0MO+kroNy6dhWNiRjLnZBkwmzTGnp7dt0MxmGsmg==
X-Google-Smtp-Source: AGHT+IG8/eOyaI60P5sNZBMnbGJZP5T8A6n4do+AVNu7Mg+dpDP6xcJpxplk2Efv2Uxor4tjXfwbhQ==
X-Received: by 2002:a05:600c:1c9d:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-42cdb538dacmr37471785e9.10.1726185570238;
        Thu, 12 Sep 2024 16:59:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054f97sm6025175e9.4.2024.09.12.16.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:59:29 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 1/2] uio: uio_dmem_genirq: Make use of irq_get_trigger_type()
Date: Fri, 13 Sep 2024 01:59:24 +0200
Message-Id: <20240912235925.54465-2-vassilisamir@gmail.com>
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
 drivers/uio/uio_dmem_genirq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 13cc35ab5d29..c70dd81bfc61 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -210,8 +210,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	}
 
 	if (uioinfo->irq) {
-		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
-
 		/*
 		 * If a level interrupt, dont do lazy disable. Otherwise the
 		 * irq will fire again since clearing of the actual cause, on
@@ -219,8 +217,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 		 * irqd_is_level_type() isn't used since isn't valid until
 		 * irq is configured.
 		 */
-		if (irq_data &&
-		    irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
+		if (irq_get_trigger_type(uioinfo->irq) & IRQ_TYPE_LEVEL_MASK) {
 			dev_dbg(&pdev->dev, "disable lazy unmask\n");
 			irq_set_status_flags(uioinfo->irq, IRQ_DISABLE_UNLAZY);
 		}

base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
-- 
2.25.1


