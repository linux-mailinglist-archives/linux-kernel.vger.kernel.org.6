Return-Path: <linux-kernel+bounces-272256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F877945957
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB3228443E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D91BF322;
	Fri,  2 Aug 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N9wAxqu3"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFC1BF301
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585471; cv=none; b=Tepl0bV/cL9yCz+mFUk8YVLcJ8eXPkJ8Ph1CEujgN0JkK1VwBsmNIMzmmoGBJ4VI2PWaeyeAHjoU6OhRC3PfOly3wwz0aOhPVCOMskIQEeGappszQ/8wiX4uBYIj4pejvY1bbLI9xuzVfNGiNarx91glCRtAN+SMxTa5UNn65VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585471; c=relaxed/simple;
	bh=GTlEp9LoYSjilnZXEMPY8GrWKFWUdyd0rNu3KWzNnr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ez5jieoAVnHGjecd7ZHVT3oE1OIP5Sl/b0Cus9pCWqamuo38kwcE+Fivq0nr/OtOU/QQe2Yqa1LE1dyyJL6JVRQfIYryYQXhOY8JVHkvcp1LsKddW5XEwXFvZgO6HUkMJtm3Jz8oMa0148HSdh6uSf8VcUG6V3bKNz/89S+JT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=N9wAxqu3; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d59e491fefso3574072eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722585469; x=1723190269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSk2SRb06KZUAv0d+mrcW9m53Z2saj4GCHKLYd5CkJM=;
        b=N9wAxqu3b7MkcNjFhmOQJ1YA5Or/kZ9wTxA3tLusbFWZ3zYxQivk8UOvoj51GRIoni
         vLD/NbTvrIziwAd4Fgufv6si83hRTDUETiMeaHiSAawQkMfQ0wcv3k/u/iuc1fgfrjzV
         dgzV9UYKQadb4++EQV/JcwC84SbP+07N7lMK2vIiuiKK0r49g3quqlvhkqjSOpbePaFE
         rkGdHViwvMtD0fn5ctjKcfCIRX1M3bHRc9xBMjXzk2yGZFaPRU7vFjOgVeOVcM5rxSBG
         hI5844+P1y9ijMdgWmSGZRoIVr1l4pkmBtL/HPklu0/JAuvJmOsSFnP+uXTjsDPOw/+X
         nXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585469; x=1723190269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSk2SRb06KZUAv0d+mrcW9m53Z2saj4GCHKLYd5CkJM=;
        b=Pq0RQpV+IglHKhXht4NkZYN3bbbxUuxBTcGgdNjylSFvKS4ur2IB0lu4AOZk6zVgJW
         5YuLoTonYNlBOUA9XFrCXDbnwUVTgYXgt2oVz0NnR+/JE485WU9Bit6iRnp3ugJpRnjc
         iCsY17n8URr4u8IB1m2D4fMVLSeZa5F9HrLvvvmtbf7CFMPgNLf88wmETw19stigpLK2
         Fld+08EJfvBti2JBmETprL0TZ6OGalfSSxmySkzzbGojHQrehJ7985YLNUG+TMvC/zjJ
         6wjiQQVZI8bL3/tbQcbudyPjcDAmvTVqz8guWN1p3qjz4x+BttQhaaKhRKh7nD+/LIct
         Chlw==
X-Forwarded-Encrypted: i=1; AJvYcCULShS2OUPnY15fPnrb5m32E0vxZc7PM56H9CKiWzJsPsuGhENA4ce6xUQTP2a0pX0cwyWN6GU913Rxg0HK8WsGMBzepCBhRBuQtTj/
X-Gm-Message-State: AOJu0YxB5J5NLmk4JzS7BIY5sJLPqGBFITe80RD+NGy2MJ6TtWZdjwtc
	MQC9V3I4ikPN+WUBb1UdW4qKOk2EMX+iIsBLQqwAQWUFR+FQl6U9dngYsvPmTH4=
X-Google-Smtp-Source: AGHT+IHt3LTQ4erd6SES1d05LGiiptuVS1mFE1tdYsly2nwg/Kfko1wMAuTecScTfUxFzVbUZAIqpA==
X-Received: by 2002:a05:6870:9a23:b0:261:1cd4:cd9b with SMTP id 586e51a60fabf-26891af6e71mr2621695fac.17.1722585468686;
        Fri, 02 Aug 2024 00:57:48 -0700 (PDT)
Received: from Vincent-X1Extreme-TW.. (2001-b400-e3d0-aff4-6515-fef1-f4cc-f5cd.emome-ip6.hinet.net. [2001:b400:e3d0:aff4:6515:fef1:f4cc:f5cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc471sm886279b3a.165.2024.08.02.00.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:57:48 -0700 (PDT)
From: Vincent Chen <vincent.chen@sifive.com>
To: anup@brainfault.org,
	tglx@linutronix.de
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vincent.chen@sifive.com
Subject: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
Date: Fri,  2 Aug 2024 15:57:41 +0800
Message-Id: <20240802075741.316968-1-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the debug message of driver/base/dd.c is enabled, the following
error messages are present in the boot log:

[    0.207941] platform d000000.aplic: error -EPROBE_DEFER: supplier
28000000.imsics not ready
[    0.208115] platform d000000.aplic: Added to deferred list

The reason for this error message is that the probe of APLIC is executed
earlier than IMSIC. This error also causes all the platform devices
connected to the APLIC to be added to the deferred list. Because both
APLIC and IMSIC are registered by device_initcall, this patch adjusts the
compile order of APLIC and IMSIC to ensure that the probe of IMSIC is
executed earlier than the probe of APLIC.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/irqchip/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 15635812b2d6..3c09666569d6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,9 +96,9 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic-main.o irq-riscv-aplic-direct.o
 obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
-obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
-- 
2.34.1


