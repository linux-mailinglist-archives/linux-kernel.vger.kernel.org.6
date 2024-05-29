Return-Path: <linux-kernel+bounces-194715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E48D408F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A691F2304F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0061C9EBA;
	Wed, 29 May 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WEUQPtZp"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC1225D6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019702; cv=none; b=rVcSX31US99W7DGmvB2EMPkSNzLlhMKqJmP8IHv2lSjeOono5FQkWe5Bl+Kju8YPp9l+ZzFuUhDN5qxi6q/hZNorLDRGcM2ZPBJnKw93HBqtY3X9Migm+e7nfC20I0VCIW5GGz7oZdcee0NGsDOmqFqh3Iv7MWVMxtaRWAiQpRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019702; c=relaxed/simple;
	bh=bb+7BuK0NZRBRVvbgmkO4IJd+qu6rkoMLoWbdB812aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3jYQBCo+TZQERUCgXNc8JxRTQu8878gshN7QGn8JPduRsPTOqt31jJp2rsiALlT8z8NNInam1/RrMulkYIy7mWYkz3ZVJhMEVYbnmd6qeq5elog4yvIWLyItH967bixkC4gBUwLx372zxR8phCUY4lAymShi9+ak20P9wi3VnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WEUQPtZp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bff93fac37so42712a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717019700; x=1717624500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkamhnzZzL+d5XOCP7ZQRgk3oaOwgUEN9NLGiuPviks=;
        b=WEUQPtZp1sNQvrNa+p99AF1pphRah1mtuN4N8YtI9fN/qE7QwAffkNE5wqRB2CqTgX
         On9XarbRMqAlTAgeWxJVsnYEd8EEk6d1BBZO7Fi3TqGPqMEqzPtbDUgb/iEGbwnOVCYJ
         72DkHxm3Fnuy9WJRA7SLfMtmdG4iDYpnxAFCKk2WpPB/6Ih6goFvujRBdpnJXumNtoJi
         20mFWwJTIrTw00GlCLQkQPPHUIePQYOCrupPMpaH47L7Gq8jgGeArR5O8yZnMjhdAAyB
         AvvmNsKAMGkSpNm7qk0XCuJn+FokRrhZj9CYaggPv0KFtBxgvo3YfT2CluuE2VoReANh
         U20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019700; x=1717624500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkamhnzZzL+d5XOCP7ZQRgk3oaOwgUEN9NLGiuPviks=;
        b=BDuZfSsC5fqQAyoco9PExov0FnZdJjE7Ot5XzShYgouCMlplF6AjxfcTzfspglzR9E
         IhcG01tM/93VfWuSg8bdggDLSfl20LDs0R0bCW9ozq0a8pd9+TGkV0ZnVhF7/mQlIxMV
         U/Lpg0h/hQQ8YajiipHBms+axxvW7aQxP4Wqp2YZPZrJ5rcuNzqanx7OcIITyIaDGhe3
         33jJS45yYovi4xs8s0Wv5qrjvDSyoxZdflgQ0kBATfDmc2i7cKMpvCS/MqOoowNxJ1eZ
         AWzAfeb7elSnf8i0JF8Zfynjkz/bxZpnEkoAcyFIntmr+I6oftoxs/iTB/21wzoWaQqH
         2j/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8baCeeDATNoT1Fh0pJI9BOHZGLe9yCXIM6F/3OTslOmMUpTOGP/RvPsGf9zC/S+1M7zI+Ks/N8Oa2hvdyWx5+acDaDQNUH7iTOdHT
X-Gm-Message-State: AOJu0YycB0on23358GKxD0BvBMg2n4Xx9BMkZmKUVqhOlB4x8njHz3eS
	r6a/AN/d+uY9MmYQG31V2yDHulJJL4K4oL1rw9i05go93hAq1exEgUueNxeHAmw=
X-Google-Smtp-Source: AGHT+IEyd+1nf+mYeXxqbzWxP0KkmJ38q4hcn4FSLb1gMwyFmtQyII9SHwxxRo8Vj3wVM4NLSPx0tg==
X-Received: by 2002:a17:902:e806:b0:1f2:fe82:21e9 with SMTP id d9443c01a7336-1f61983aad4mr3454005ad.46.1717019700374;
        Wed, 29 May 2024 14:55:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c994a66sm104445115ad.182.2024.05.29.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:54:59 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] irqchip/sifive-plic: Chain to parent IRQ after handlers are ready
Date: Wed, 29 May 2024 14:54:56 -0700
Message-ID: <20240529215458.937817-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the PLIC uses a platform driver, the driver probed later in the
boot process, where interrupts from peripherals might already be
pending. As a result, plic_handle_irq() may be called as early as the
call to irq_set_chained_handler(). But this call happens before the
per-context handler is completely set up, so there is a window where
plic_handle_irq() can see incomplete per-context state and crash. Avoid
this by delaying the call to irq_set_chained_handler() until all
handlers from all PLICs are initialized.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/r/CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com/
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 8fb183ced1e7..9e22f7e378f5 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -85,7 +85,7 @@ struct plic_handler {
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
-static bool plic_cpuhp_setup_done __ro_after_init;
+static bool plic_global_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
@@ -487,10 +487,8 @@ static int plic_probe(struct platform_device *pdev)
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
-	struct irq_domain *domain;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
-	bool cpuhp_setup;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -549,14 +547,6 @@ static int plic_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		/* Find parent domain and register chained handler */
-		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
-		if (!plic_parent_irq && domain) {
-			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
-			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
-		}
-
 		/*
 		 * When running in M-mode we need to ignore the S-mode handler.
 		 * Here we assume it always comes later, but that might be a
@@ -597,25 +587,35 @@ static int plic_probe(struct platform_device *pdev)
 		goto fail_cleanup_contexts;
 
 	/*
-	 * We can have multiple PLIC instances so setup cpuhp state
+	 * We can have multiple PLIC instances so setup global state
 	 * and register syscore operations only once after context
 	 * handlers of all online CPUs are initialized.
 	 */
-	if (!plic_cpuhp_setup_done) {
-		cpuhp_setup = true;
+	if (!plic_global_setup_done) {
+		struct irq_domain *domain;
+		bool global_setup = true;
+
 		for_each_online_cpu(cpu) {
 			handler = per_cpu_ptr(&plic_handlers, cpu);
 			if (!handler->present) {
-				cpuhp_setup = false;
+				global_setup = false;
 				break;
 			}
 		}
-		if (cpuhp_setup) {
+
+		if (global_setup) {
+			/* Find parent domain and register chained handler */
+			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+			if (domain)
+				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+			if (plic_parent_irq)
+				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+
 			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 					  "irqchip/sifive/plic:starting",
 					  plic_starting_cpu, plic_dying_cpu);
 			register_syscore_ops(&plic_irq_syscore_ops);
-			plic_cpuhp_setup_done = true;
+			plic_global_setup_done = true;
 		}
 	}
 
-- 
2.44.1


