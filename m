Return-Path: <linux-kernel+bounces-286691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8E951DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D071C2146B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE41B5838;
	Wed, 14 Aug 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gptT81ef"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7881B4C37
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647418; cv=none; b=FmoTdNasVKOcFHTAGiiYKW5lRIVzikBk8yHDU8WvOcNIyr0TGuyILHUY7vs9Aao2TWjjKszZ4LZqDJrwzn654Pyrriuub8XaSuCpdz+RXToLhxPwYE880kW1Cksl2ZMIQKrila0/x6SYDo/m3+PPLxjoaQlLPx7CxJoNHaXjsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647418; c=relaxed/simple;
	bh=kYcTs99ca5DC+FKRk1t8RRd9jM6uKw7+HHkjyUYjdT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TODsYmm2J8LVq8yGKcMOEXYgFsqcWlKq7w/tyUIWYapsp9NCKYmMvUODWwxfoXDyRdzoT4KYJDfTj5kOhsdVOIqYMluWTa82KtRR1l+V2+bAuJXaseZrTz6jUn7cb/Y3EanFhULGiJyUnt8IxwFplDSaXPoZ6Fj84qijm9a+Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gptT81ef; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C2E1A41234
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647412;
	bh=CX0Ehp5ml6WOE9Qikg2fnkaf9KKI21cRzGrnDKkzd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=gptT81efN3a8Y4n4joTH0sLMg9aSg/6oZATN3zbB/ryO0KbaFN0Dy2/i70Nzmhn90
	 bRysP83XSZQoTy2kJSFtJfz4iMe4cjyu01GdTj6JA/96ldGYDgrtfUodIl+hHM0iEV
	 SgUrzRTaMVig2B9RKFlO/HNVhpb+jjRnpv7mhGsg0XqzbtgH5RN0vdH5UOxL97r7S5
	 ld5RwSdTm62lqf2TZT0bpfk9DjupXSQkHwIowp1YY0bFV1wXgT1jlxd5nGVWDMx1K1
	 AbOLSkOuJymkhFXjt2PPY26k17U297nqXC0kYy9gWx4rMZDtQEHbjSzhTj4DKw10Xv
	 js1JmzF/zGD4w==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7bcaa94892so504975066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647410; x=1724252210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX0Ehp5ml6WOE9Qikg2fnkaf9KKI21cRzGrnDKkzd2k=;
        b=KFSJ7w9Rw4AxRdu+1Gpisv92iA2ZdVEzuL/E1Q/nTusOsfW0lsfSCAnhOEPeWO0kNb
         k21upVPC9w2gCu0tuS22qRk+3hygySiQhvfieaRxmCLVCK/1heCkcm2dp+2vEm//scvs
         C1oer3G3jt9S0pODGpbeYKQ/UGIxHkIoMcR+OFdcvhtXD3A1ncZvem4vUSiy96tetOb8
         P5UyxZGOCwEF/RSu4q6mLEiPI/p0jix0De9m5hSyckXW74rplnTP1tB8NHMjqQA71rKs
         hf5bIGrrtBp9IW3AA0+MY/sYPAGr1PBta4rcv8tI5yZc5/EYNjG0Sio1nkCmVr74xE6w
         7NIg==
X-Gm-Message-State: AOJu0YwoKHt6AZdB+6IS2hWufTClUt2kQR67LGYnF7BDZEuGgo2j1pvZ
	KokA7o8F7ZaNFShT0u2fhMxnWK0jJfOBY5SiBZXeeh13djLVCNpoWg/ICMr6hdsJ5WW+cmbFN0Y
	eaGPO0f+HToCBl/mckCZ/7RbXBI+uIYteZiq43hrGZPjWBGag9rrCFsWN4aIttpxemvBoPCp/AH
	jRgQyekiEsaA==
X-Received: by 2002:a17:906:7952:b0:a7a:ab1a:2d64 with SMTP id a640c23a62f3a-a8367110460mr191610466b.58.1723647410125;
        Wed, 14 Aug 2024 07:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8EoPiheZDl/XaOz+iEJprer/FvXWlwGIqv0DClmcSJg+8eKp8MwPZxtItNQsSjm8fghSEGg==
X-Received: by 2002:a17:906:7952:b0:a7a:ab1a:2d64 with SMTP id a640c23a62f3a-a8367110460mr191607966b.58.1723647409411;
        Wed, 14 Aug 2024 07:56:49 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:48 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 6/9] Revert "irqchip/sifive-plic: Use riscv_get_intc_hwnode() to get parent fwnode"
Date: Wed, 14 Aug 2024 16:56:38 +0200
Message-ID: <20240814145642.344485-7-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6c725f33d67b53f2d302c2c4509deae953fc6ade.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 85e94b8f4c06..7dbc662a229c 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -429,7 +429,6 @@ static int plic_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
-	struct irq_domain *domain;
 	struct plic_priv *priv;
 	bool cpuhp_setup;
 	unsigned int cpu;
@@ -509,11 +508,11 @@ static int plic_probe(struct platform_device *pdev)
 		}
 
 		/* Find parent domain and register chained handler */
-		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
-		if (!plic_parent_irq && domain) {
-			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+		if (!plic_parent_irq && irq_find_host(parent.np)) {
+			plic_parent_irq = irq_of_parse_and_map(to_of_node(dev->fwnode), i);
 			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+				irq_set_chained_handler(plic_parent_irq,
+							plic_handle_irq);
 		}
 
 		/*
-- 
2.43.0


