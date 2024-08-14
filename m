Return-Path: <linux-kernel+bounces-286692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06196951DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F071F226CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED71B86E0;
	Wed, 14 Aug 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oZntMBf+"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABA1B4C29
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647418; cv=none; b=NEHfOADB1cVJ5OfciF5WPAktRUKpUU9MSAsMswY2F9TN9g8sQApE4A/H50iHk6To8ydIQXZguuZdQPivvvUvrfTmcL1iLTkB6LbULuPcPddQBQdYQDZF4384oMusU7wJewX+CHRaxrc+3KfksgKCIgGjePKT8Z7BQpacwXE8V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647418; c=relaxed/simple;
	bh=KP653k6cXI0Mk3KiF19Y9/Uvlpr+bC3wTnNdlHe35j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIC9V00DvPhcunxmRSQKg0Kh0DlAHrEOScbBoByz1YIYb20Bexf7QPvG3j6OXg9MYGWuyKAmouIvDtfEcNhx1VADETQMDp8r9cn/pltn2Im/bZyntpyKRtVV+1/DEXTERhGUgnkT5sROCE2PGFt43waEQT0Fqr0Cu/IaYBmsdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oZntMBf+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3089840302
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723647411;
	bh=EVnujh8KUTCiCooAY0SE0ZN2aSfYIbE0OsxWHQEB47A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=oZntMBf+q/bAlzoNmOQYdB31lpfY+7KscsqvPU0JiLpvfgb2GVCIx/adi64rQHkbs
	 2vbPQewo7u0FFquW1k6jGIWE7FmTmkA6UJxfCTgL4H+K/JlkduPGYOXTEfg9kC0DL9
	 Q4ZM1HNfHB0Z6NwPWeeDts1Piy5AgqJQyvqkM9T+mXETBn1RFqORN0vfNem+XoBji/
	 Ii4obeHxhtSR29QYAYeBkf3k+3NNadDzf+9GvZfLap5x9Sd5DVlaP5p4H+NfHDBNtt
	 xflO3z3od5IEYcwBidcdVIy0ya6kG+FAtZQTXcrR1V7ZtEZcleZeEAgEykDTTVqkxS
	 /pxk95/NVbsBw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7aa26f342cso512072266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647407; x=1724252207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVnujh8KUTCiCooAY0SE0ZN2aSfYIbE0OsxWHQEB47A=;
        b=FV7UHCylRszkqKm3sXqfIFfXGZaDKs/Y8KzWnOy57jxevpCzRCstM76ToD82wgUMNc
         pE5lnAsMlzxRMWhyeENHZpnd6P23ogjvul6RgpA28KoubSBkFAXlfo2lK2vQcSF789DG
         9dXbkM+1FvQQZSZAfGSepuYFvT6ny+6AfRWnxNKaA6RMfOEWcT0sERXXzf4tFGjtcEY7
         MDIA6h+EAO2eR3evWoJQiyyyKLO0XDoZ4FQKJDMgXZBZNqojLxCJTOrOVBJKZZX6FnG0
         rmhaUN/Yjm6JxcCDUwrHLJ46k7qLWjQE/t8pHHVh4AX9TGiFWslJJUAFYLHBF+SA4P+D
         KHDA==
X-Gm-Message-State: AOJu0Yyf/6gVvhMMX0efL/DbVe5TV6xfu0iFjjcECfHUW6eLj+eaDhjI
	M6U1/p0I/36tR5yFVMQQPc61yS7loaMZX3S7wEoLXwBc+syJUECDoWwusDSHjXlkUOpZRPwce4M
	IL9EJL0nSUKHRQv4NxvviSCDSrzrnokIpTlR5eHO3OHr34zxXD74FZMDBa3thZGfE753eGlJyC/
	XQ1tDvVsjBOA==
X-Received: by 2002:a17:906:cadd:b0:a7a:b620:aa3a with SMTP id a640c23a62f3a-a8367034961mr201276866b.52.1723647406658;
        Wed, 14 Aug 2024 07:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLxomAnKFjWs6A9VwCQwHg3vLbUdpfFg+VMb2VSAn6s+ZN+y2p/gB4Mu5QbgZontrDcC2N0Q==
X-Received: by 2002:a17:906:cadd:b0:a7a:b620:aa3a with SMTP id a640c23a62f3a-a8367034961mr201273066b.52.1723647405821;
        Wed, 14 Aug 2024 07:56:45 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:bbf4:eba3:898f:7501])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bdcbsm182316866b.105.2024.08.14.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:56:45 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 2/9] Revert "irqchip/sifive-plic: Avoid explicit cpumask allocation on stack"
Date: Wed, 14 Aug 2024 16:56:34 +0200
Message-ID: <20240814145642.344485-3-emil.renner.berthing@canonical.com>
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

This reverts commit a7fb69ffd7ce438a259b2f9fbcebc62f5caf2d4f.

This is a prerequisite to reverting the patch converting the PLIC into a
platform driver. Unfortunately this breaks booting the Allwinner D1 SoC.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/irqchip/irq-sifive-plic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 8fb183ced1e7..f3d4cb9e34f7 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -164,12 +164,15 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
+	struct cpumask amask;
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
+	cpumask_and(&amask, &priv->lmask, mask_val);
+
 	if (force)
-		cpu = cpumask_first_and(&priv->lmask, mask_val);
+		cpu = cpumask_first(&amask);
 	else
-		cpu = cpumask_first_and_and(&priv->lmask, mask_val, cpu_online_mask);
+		cpu = cpumask_any_and(&amask, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
-- 
2.43.0


