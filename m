Return-Path: <linux-kernel+bounces-286690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D008951DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3221F2235D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA31B5804;
	Wed, 14 Aug 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aZyojXWX"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD551B3F2A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647416; cv=none; b=pzILKF1QaxW82bRDFF9Q4CCMTJ19YG7tZC6ROthTUnO/vYfITPdMiZGMOJ/rf9mVFGvYORTPEB2/Rd7zdjycLn2cq4yIsc5gBrDHtsnHVKBbFz9yKCa7bHXYmOjUFHG1I9o3MNHuGEHFHVTmkTXef8VMtArXSHWxs746Z+kBltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647416; c=relaxed/simple;
	bh=/RfyejebA2PdHTi3Z7o/WjXiT1fmdRhuwDw7CyQe+IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duBCeSYBSgAUtgJuI+FvBK+/WJqgU3S9UsIGeCgd7yIpcHiLko/jYSrbEMv2LwJ9hKvfw+iiCH1eV7tm1CooH5GpH66YYthnvQ8Y4dy9WXMzzGrw11l9ankgy6ZmaB3fzKvUe6IMhU4DjMYmXFWlws93zHNa0A6srDcvWx81Drk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aZyojXWX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41A92402E8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647409;
	bh=sxLtNA8jlC2UdtFSfJSplJrgcfSiQ+BvRmrjXsCvtrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=aZyojXWXk6kVEPjLQLsZPfc7+y5DtkJE0z6HdgydLNNJGeJyUb1zPSjwmozQFmfVP
	 Bfwh22gcZdB85BicWogqesOlwsnXRSvZjGz2B7X7wDW3CxHRWseYowAYR0pal9Aes2
	 QczuvtGEGfR0sOhO090hIvXR/v8hFXwJWO0JCu+BD+GGGhzCCdKzLm5Bh+2cLtTEhz
	 vWjIoN09UdHXSnQPqBrKyxCWN+cSOff1mn7nDAKQeg3i40gsheSr4ws6zwnFKXCMxp
	 sSvIL20qgOH6cvCZIxbWEk5KTMor947hdURdijxV5u6DUG95UmMfS5dnGeCILb12a5
	 fi1G4jYMMBTDg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bb88479be6so4601a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647405; x=1724252205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxLtNA8jlC2UdtFSfJSplJrgcfSiQ+BvRmrjXsCvtrQ=;
        b=BxpkM6eRJUKrk5kRpWKJv0CwOy12I4ox/DZq9L9FQ+Jsm5J7MECsELNmaodUZPuyWa
         OOgZhZDH+qMwGWWBj61qLc+KN2qc1OqlC2YXNSvuINXe9sBsu7PDTMVFTk9MvC0dDr5n
         GnYS/FP7fD8+A5ZspHHYIKjNc5Uv4iV5BupeSOs7A+loS4AlaXPuhFmYbezxWi/r7P1q
         PAbj5cVx0ELRa06+25nFI1xeo9EtDZYMNZFmn980OSMJWtfkPpLKLiqI9Pf8Qzz/ITRn
         Psd/yS1jpQIU8RfzeRjbgEktGSJi3pfqv5ZCCPNCCKxePEFQgpnAE7fSKZGmdgvHB9Lw
         dRhw==
X-Gm-Message-State: AOJu0YxEU227l+iXk5DJXdZ+xeNaVidYLJyBdIjN7loITl+dJRt//Wxj
	/YkchutucoxLa1yq3WsctkhcBrtSEVQPdx4QsatqMC1NC/DI3poGB+dU/m53ohkURxIYR3Yjk3R
	vNaBJFVd8JM5jzIcuCnUnO4kQ45xdt+Zy/syM5Wc6dBECgDrPN4qD9d+0rlIMKTmSGVeSHUEgsL
	cx6Xk/DYqcKw==
X-Received: by 2002:a17:906:d7d3:b0:a7a:bcbc:f7e1 with SMTP id a640c23a62f3a-a8366c32951mr208989566b.15.1723647405484;
        Wed, 14 Aug 2024 07:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc/yfSJrvFTuMnyZ4+Y0SRDIMqZrC+J2GedSuxes8D5p74/pWwqtE1Vv2fGbgkAkF4zdDaxg==
X-Received: by 2002:a17:906:d7d3:b0:a7a:bcbc:f7e1 with SMTP id a640c23a62f3a-a8366c32951mr208986766b.15.1723647404802;
        Wed, 14 Aug 2024 07:56:44 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:44 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 1/9] Revert "irqchip/sifive-plic: Chain to parent IRQ after handlers are ready"
Date: Wed, 14 Aug 2024 16:56:33 +0200
Message-ID: <20240814145642.344485-2-emil.renner.berthing@canonical.com>
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

This reverts commit e306a894bd511804ba9db7c00ca9cc05b55df1f2.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..8fb183ced1e7 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -85,7 +85,7 @@ struct plic_handler {
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
-static bool plic_global_setup_done __ro_after_init;
+static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
@@ -487,8 +487,10 @@ static int plic_probe(struct platform_device *pdev)
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
+	struct irq_domain *domain;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	bool cpuhp_setup;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -547,6 +549,14 @@ static int plic_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		/* Find parent domain and register chained handler */
+		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+		if (!plic_parent_irq && domain) {
+			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+			if (plic_parent_irq)
+				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+		}
+
 		/*
 		 * When running in M-mode we need to ignore the S-mode handler.
 		 * Here we assume it always comes later, but that might be a
@@ -587,35 +597,25 @@ static int plic_probe(struct platform_device *pdev)
 		goto fail_cleanup_contexts;
 
 	/*
-	 * We can have multiple PLIC instances so setup global state
+	 * We can have multiple PLIC instances so setup cpuhp state
 	 * and register syscore operations only once after context
 	 * handlers of all online CPUs are initialized.
 	 */
-	if (!plic_global_setup_done) {
-		struct irq_domain *domain;
-		bool global_setup = true;
-
+	if (!plic_cpuhp_setup_done) {
+		cpuhp_setup = true;
 		for_each_online_cpu(cpu) {
 			handler = per_cpu_ptr(&plic_handlers, cpu);
 			if (!handler->present) {
-				global_setup = false;
+				cpuhp_setup = false;
 				break;
 			}
 		}
-
-		if (global_setup) {
-			/* Find parent domain and register chained handler */
-			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
-			if (domain)
-				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
-			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
-
+		if (cpuhp_setup) {
 			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 					  "irqchip/sifive/plic:starting",
 					  plic_starting_cpu, plic_dying_cpu);
 			register_syscore_ops(&plic_irq_syscore_ops);
-			plic_global_setup_done = true;
+			plic_cpuhp_setup_done = true;
 		}
 	}
 
-- 
2.43.0


