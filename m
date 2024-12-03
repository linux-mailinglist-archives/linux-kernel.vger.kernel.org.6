Return-Path: <linux-kernel+bounces-430362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F79E2FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E164161BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D61FA177;
	Tue,  3 Dec 2024 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXCi/ww/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38C1FA84F;
	Tue,  3 Dec 2024 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268910; cv=none; b=Ll/4T/Gg5O6k3Q/yEeScrPXBucHVQXFaqJaEevnaHNjaGNWKHw/267nHswWFsMw2uxiSDn4PnaoR7b4/hKCnPlPvas147V+uiQM09yfIMu/wWcPio3UKvX7fqIe+WWZWsrf54TpmsGobJdkzBwLs0pil5qvxvmfSULPHAWNOS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268910; c=relaxed/simple;
	bh=Is58uFdXkqEN8yblmrKf5YgZlnLeIDtbd3AgrLB1FNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eh3vMP6mB8Oy15u6ctQS3u33HBqN3/TF5gzAo4C2tdEF9MY47OBL4XORqITNCgsowUKtpgJdaLnLkSZq7Vh/HtoP8fOY8MOSI3NKFYYjOfw3L3SX4Mg2SqXgLGerIaWtyApDB4HttirFqYl74T2qIGLq3C6ucZq7QBaru8RxSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXCi/ww/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7252fba4de1so5393039b3a.0;
        Tue, 03 Dec 2024 15:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733268907; x=1733873707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RN+w/AnDTOQLBmTcQCYhikmp2ylyG0FJde4LA4/pRHI=;
        b=HXCi/ww/PoMi7X1homutYXHE+oFtAsTdRTaNRCX3BQCGgh7u+lkD44gaYQo2S5XprV
         Q0V6+wcXiQVKAnXFA78jsxpMYfJktnw7bPzzy+fqwCletbammZBMBqmkXdsvLdrGeo3L
         fJk2XYcVf4Dorz7Su8XuW00DtWuSMdJpGqKFjvWu1CFqY71MsmbZvFYu+hwo6GfCo24v
         MzoZpKBwhA4ja/RyINBZ5BnVsKbfIOX5pqOSqxfhL92LTacee3E1QOkrsQCGCIb/dsf6
         G3SZe93C0jmay8Qp6Am2gM15wMK0P9EPn3LuvlKHXo7X9awePGPYJMsd609NsH5GyK3a
         vWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268907; x=1733873707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN+w/AnDTOQLBmTcQCYhikmp2ylyG0FJde4LA4/pRHI=;
        b=skJSpXr8WteB1uZ8+I7RYXCzZ9MIpZOyBETTXzDgeLSNrQErXbe6YWmlEt6slSYlZ4
         /Mp7epH1T5s0ToUVwaeQysFQM5BTczq80DzELDuVF2CnxMnSuwgKioVTHmkDfh3hiSnC
         uDDYmPmoygd3FxBN1loZ419A4FwwkVFxsTuED7uoVhdmbfnuIYQsqAJNb5WFHg1qWebf
         ZG3qU+HrLyhkUxGuojlQxTL/fFmrHBX1iRSYb+AnHG3BtsgE/Qb/gMASRNKaux2uyY0B
         R0lC70GzCxYofpQCwVjyhUkElmRJZUZQ53yXFbmX9BZYPOuJl3anyJoxxbe/aFL4RGac
         o0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmimrKg0VNBhW3Y0buSSuagDDFpWqhPXTtXxFbQHYw5Egf7iv/UpkQNg7RS9mJH1SG74WD/wNt9cQ4epU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tSgJu6x550n9l1ujoCWCCJSTOepCu7Xsbvu/3glZzh0k/rZq
	IodHOYMxiH/CbnIdccjlB6zDVSkYdCD6jMP+lnkNzuLeeM7/Nwa6PFHLQmy610M=
X-Gm-Gg: ASbGncs96DQ9uAB+OBLYo9nzelEWG0VRGFHFczXBX0tC5+KiDqWgzmtOmccU9fpNR0q
	D9WBqKmNAvDfz+d50MXXpb8eT3+/UPscg4+rmH0Ungozhg8fVPsH/e0QNzP7XuuddrAkIj6h6YK
	1z1zJHvmf0QXxV694lwoFPD5vQLrlJGNrfZzTowx8u/m4tP+yB87+QyJENbiVxmp8H73olWYDt2
	lggxY0RaLGX5bbVv3/rvJkMmg==
X-Google-Smtp-Source: AGHT+IH+aJe+KPtnseRrJSzCmkLhHWXBX93CUUQahnewy6Lp+NI8jS9q7JKCkwv0dstq61zgAXoJlA==
X-Received: by 2002:aa7:88d3:0:b0:725:4615:a778 with SMTP id d2e1a72fcca58-7257fa5f065mr6201964b3a.7.1733268907521;
        Tue, 03 Dec 2024 15:35:07 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184ad5csm11035838b3a.199.2024.12.03.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:35:07 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/x86: intel: int0002_vgpio: use gpiochip_get_data
Date: Tue,  3 Dec 2024 15:35:05 -0800
Message-ID: <20241203233505.184612-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using container_of, we can pass the pointer to
gpiochip_add_data and use it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/platform/x86/intel/int0002_vgpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
index 0cc80603a8a9..7ce0774b3896 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -102,7 +102,7 @@ static void int0002_irq_mask(struct irq_data *data)
 static int int0002_irq_set_wake(struct irq_data *data, unsigned int on)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
-	struct int0002_data *int0002 = container_of(chip, struct int0002_data, chip);
+	struct int0002_data *int0002 = gpiochip_get_data(chip);
 
 	/*
 	 * Applying of the wakeup flag to our parent IRQ is delayed till system
@@ -211,7 +211,7 @@ static int int0002_probe(struct platform_device *pdev)
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_edge_irq;
 
-	ret = devm_gpiochip_add_data(dev, chip, NULL);
+	ret = devm_gpiochip_add_data(dev, chip, int0002);
 	if (ret) {
 		dev_err(dev, "Error adding gpio chip: %d\n", ret);
 		return ret;
-- 
2.47.0


