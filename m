Return-Path: <linux-kernel+bounces-517207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC1A37DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224B87A306D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CCD1A9B5B;
	Mon, 17 Feb 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Vyk1P1Qk"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACF1A8F68
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782679; cv=none; b=ixTmSEnYM29e2u0BBA/Uh4ni6VdR3+d9TSYO60TcjwQ+jduJQ3lWqeo/COXfAbSv5iy4TFFAcdTmXydRrgBqwrLU0k9VwtqPYetVVp2U+knoPrLZ1mnY+OfpeMV09MQRzDknyQRGzG/zYm90pp3FD2pwTO4c6W7msn2fQ40+2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782679; c=relaxed/simple;
	bh=cA1sVz4q2Oqx8B9mzL6c4pNCSDxS/s6iPI+hzJGQ4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tz7ndASa9Qkwe4/ZwIg15FNXYKevRTxD9ku8UokozwMBaaRxKCOgChIaHfjudC0FidzSt8LQDhkCseLDUR2H+YF/dbVqH1x46LjnwPJ0EnlRmsnu5nqoF4Ss3eLsAdEKcRXWmJyB7ocHf0IwP/9sNSu1UK/GfD3+HXVvca5TvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Vyk1P1Qk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc3fa00323so3830761a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782677; x=1740387477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Atdfv1u3QJvV1o68tlPZkH3S4E5LyywsJGNj7mblCio=;
        b=Vyk1P1Qk3rBdIkLYMxD8cJpLt2oGNXCIzVcx2XD/PqfC+5knrWvTjjtrxZxP8khf+5
         CAEKL3sbubez34V3BU4M84/SQekVOXn2HPGETC08Bd4OsWXnmoxEb20IMoBefFjPmXmg
         gS48kT7cxJlRP6INSsownW/E19tat0RvzEE82WrCytQgjvIufzqTpKHdCxVRtGlrvADf
         kx+qWE+WqRg5RqXNPo7sWv0aUkKBk43/JAab+/pF/TvXR54COWUNpQBQVXRJ6CL2z5m3
         kbCVmgtL+qX5OZvZQGckcbiV7V63zZBpNf6lwaWY5iUAeHejxy2K1qshc6hv0hrVCY8p
         MniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782677; x=1740387477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Atdfv1u3QJvV1o68tlPZkH3S4E5LyywsJGNj7mblCio=;
        b=eVoN1/4jqWzgP5iIzErvrK44e3OqkycjBrfWjctb8e6Jbt+ojLl7w4LHnoeIPmYMmq
         KsDO5DiitHqkYqH01oEXFRCfuggcKb0JxnCnAFf7Rh5Vku7prNY95aMC5km0wtCkEhly
         Jxv9tkXhBqIMSjvIhUkRPTkBjJ0fX5DDdB8cqnaw+N4mcSqwSIeLVcEtRLo2z8o+fraZ
         jiRr9HPoXCK9M1DSGkbNBf5omJAsgtGPI6zus5UmS5L8G3G5K7N/xsHvz7kiAi7BoQms
         Hx42orwUPByEqfFhxxM9eh1DZeR4I1Gdyxc+XX+j3UeEEB5Z1ZCA8zAXTnEM8UUdOS5v
         NvDw==
X-Forwarded-Encrypted: i=1; AJvYcCXyDUIXWDEBgLQJCsjJZRjLJ4TDUMKMWM3M/E43r/MbRisu8jHTv5dd7F/5WmB4dFK5intsRqrZKNwkApk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeb3QEIxnsYAeMSikuChYlh0ltNE0UlqLMZD0Yoo0Wj/jn9CR
	VaZs0XRXodNDqlDgZrpiSpHgY7IZQhXKjyQDUL+oMeI0LrIxMrXkWvnVGEqi6CM=
X-Gm-Gg: ASbGncuN7e1YQhdSsf75Kh32m8+U15/0jXesIOvN0NM/Ad+v/4atHG940rXsW/Mc/AC
	aMzPuCS7lG4TxYj+jBL1hJPwLILugyDiHGfnWK/dR2IgglU/OjR37JWfz/Q9QLoo11HgPpj+WjR
	KkINPsz2lhclfEzdEWRJt/U+KdT5NhEOOX/YMHMT25TC9QoJ0yjtSG1sm4vdRZEmg1ta/me+tLn
	GEdAZ57A37FXSApG/GsCubjPQCw+7VHKWpBXGPBkzg95GRMhiqPI3W678Y82NHQqd75HY8rMbuk
	HCJ5bOMCCiZ12hR55szeoeBRf3PinALnigJKT9mEp1ngzC6QjjuuU/c=
X-Google-Smtp-Source: AGHT+IFPW0gjXYzToorJlW4AuIzo5YfoCgQvbwScUi6k6HolCkujw1LAnVbhNnt/U0DkIfz+68pqpQ==
X-Received: by 2002:a05:6a00:cd4:b0:725:9d70:6ace with SMTP id d2e1a72fcca58-73261798a0amr14960838b3a.6.1739782677006;
        Mon, 17 Feb 2025 00:57:57 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:57:56 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 01/10] irqchip/riscv-imsic: Set irq_set_affinity for IMSIC base
Date: Mon, 17 Feb 2025 14:26:47 +0530
Message-ID: <20250217085657.789309-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217085657.789309-1-apatel@ventanamicro.com>
References: <20250217085657.789309-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Jones <ajones@ventanamicro.com>

Instead of using imsic_irq_set_affinity() for leaf MSI domains, use
imsic_irq_set_affinity() for the non-leaf IMSIC base domain and use
irq_chip_set_affinity_parent() for leaf MSI domains. This is required
for moving the IMSIC driver to the common MSI lib which uses a generic
msi_domain_set_affinity() for device MSI domains.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index c708780e8760..5d7c30ad8855 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -96,9 +96,8 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct irq_data *pd = d->parent_data;
 
-	old_vec = irq_data_get_irq_chip_data(pd);
+	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
 		return -ENOENT;
 
@@ -116,13 +115,13 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -ENOSPC;
 
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
 	/* Update irq descriptors with the new vector */
-	pd->chip_data = new_vec;
+	d->chip_data = new_vec;
 
-	/* Update effective affinity of parent irq data */
-	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+	/* Update effective affinity */
+	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
 
 	/* Move state of the old vector to the new vector */
 	imsic_vector_move(old_vec, new_vec);
@@ -135,6 +134,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.name			= "IMSIC",
 	.irq_mask		= imsic_irq_mask,
 	.irq_unmask		= imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
@@ -245,7 +247,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 #ifdef CONFIG_SMP
-		info->chip->irq_set_affinity = imsic_irq_set_affinity;
+		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 		break;
 	default:
-- 
2.43.0


