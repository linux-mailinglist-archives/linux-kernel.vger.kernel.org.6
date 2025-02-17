Return-Path: <linux-kernel+bounces-517217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0210A37DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3057B3B3D36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828741A8F82;
	Mon, 17 Feb 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pRDEdXXx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5731A314E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782743; cv=none; b=UuyTJ4C4TSFm+d0nYq8ZPl3vCRvjtPl3HlyIK2iq50kIwxO/VXjSM1RZQZWuQh8bzNqnnOdXpNTzzT+lITwjDkPQLuGnjLqWIiOrbwN6di9RTiZxOykjRhTXv/48OoGTEw6fUPBhVrWwDv59lEJzhrLstaST0a70tUx1pN8MnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782743; c=relaxed/simple;
	bh=a6c0Uq7JBdxZXw7kUxhrWKbabcgA5MuMPGG3EqfXL64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWaXJWgeE3LsIwEs+KjKhJsaAnqNq+5Q+3NyEzTE2a+2OtUi90DKdpXC/NT8Mgdm2licB4rpAS5DK1T9j6A86J6Ll0zOREQISxe5TkgdPkme0J1vNIuq/CNK8+pqAOkElLdLqvi0DZfag809a98Z5Kp3yxmujYTSOhDlSPLDYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pRDEdXXx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f61b01630so79537135ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782742; x=1740387542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koCL3sGSNowxnA2uthh7D1mm9ult5obqPLO5TypzPmY=;
        b=pRDEdXXxokO+M2WhFucDV+HQ9HUS7av7a7PRHS1ulbIvholmc5VAXboqho1+wY5BUi
         cSt8GbQlkA8ZmP1y4+MtCflLKAux1cckRs0PVQ+XhC2Ld1dMCRxBDgVlb/kVv6WedwPI
         UlLzS4qdOKlY4tgSd54pWpNdZB4XmvSW+c5OzkqAeFxoiG0t8W9T/xDW6I9buh+njwbm
         5lvSHLclm8fsvf7wjt1FpUmId4+GJB67rCAE0KzgvI1BMxDFAdrhgu4nqw7rwKZejMz6
         MEeQv0dlPB7mTmeU7D29sg4WLh34ElzRjpSn9mZP8i0+36flOtlF9Of+W9Jc0S0lGhUL
         sPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782742; x=1740387542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koCL3sGSNowxnA2uthh7D1mm9ult5obqPLO5TypzPmY=;
        b=JeWbNlx6p7T7UVh3RIHm60Ifj/nGbuxE84+RgRDt7t5EDCPtxAsWux9JxR8UyXMl3G
         Lmi/RXZVwJydOVgmRujMeEKGOol9ZIiDrc9mn66D2CPQKe1fT8kL6oQeQ1Aq2yL8u/11
         vUi66wEHu9vg5WIgEXkslydNMOFqry2hjBjy9fpFnMpElzfh7J5wCPGM6yDG1cnYAfJJ
         tNbrstxh5a5QkC/h+P375KRDq9nkk5RrHAg6IBS6imPoI37BW0jyQOv6ikcOMc9xIG7n
         JpkpyZJIwR165dlK4HNPNbL6oWi+hyf5Sy6UrUt9QpceT0peQvubSawn5Sj2LXrMpavZ
         RRBg==
X-Forwarded-Encrypted: i=1; AJvYcCXdDe1L238wwD9PHO906cr/KPBn7YDQ8Fz4X2d62TTzfIOMlp+TVDVjYMxlB2ORKoyya3OqVfG/F3KOiXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIzsDn/thXHc4/oguKFwSWtRKQE9MPUyJ+sbSJsWslnZSc7L5
	JtTH+FtXQBJGfpSuWBVYUWzvLgROR6ovX0SH3yDBPXkfl0JX/adUyG7uxLtv0oc=
X-Gm-Gg: ASbGnctdn9I5lW4BTQKmOxAgb0DlJI4efWw+kHvV+xUrwVAYAUCdFkZ2fRIKlR+W3xe
	7ZkZhNjsd/GifvxM5AtkaJB4b+DeMhv3TJp2XzgsknkJdJGpQNyxAXvAY3r/K7JhUnmT9hmb4Ns
	orx/zF9ai70QWDDoC0zL3Zundn4lryyg+Bom6KG2qW+rkh+X11GVbe3CBEb4HSELsZCmlmAFItW
	6KuuTbCKwi34XOB9c+EplsqmwDS0GKfVx8xE/KP4ZtPN57WW3tbg56T5HQuABCnr6ttHLhXItjY
	Yn4RYHp6SCMwLlK53U5871gAh1gNWZVuK5bM5pDv51StZhObjPNxuq8=
X-Google-Smtp-Source: AGHT+IHbBvzPw0Wn7/Eyf5Y7dSkIAJVrU71JRxh4insgq9Beex3YYjwNlgnCYaOLqfIHDCH+B/xxjA==
X-Received: by 2002:a05:6a00:4fd2:b0:730:949d:2d52 with SMTP id d2e1a72fcca58-73262158ademr14543775b3a.3.1739782741534;
        Mon, 17 Feb 2025 00:59:01 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:59:00 -0800 (PST)
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
Subject: [PATCH v6 09/10] irqchip/riscv-imsic: Replace hwirq with irq in the IMSIC vector
Date: Mon, 17 Feb 2025 14:26:55 +0530
Message-ID: <20250217085657.789309-10-apatel@ventanamicro.com>
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

Currently, the imsic_handle_irq() uses generic_handle_domain_irq() to
handle the irq which internally has an extra step of resolving hwirq
using domain. This extra step can be avoided by replacing hwirq with
irq in the IMSIC vector and directly calling generic_handle_irq().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    | 6 ++----
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 8 ++++----
 drivers/irqchip/irq-riscv-imsic-state.h    | 4 ++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 553650932c75..d9ae87808651 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -73,7 +73,7 @@ static int __init imsic_ipi_domain_init(void) { return 0; }
 static void imsic_handle_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int err, cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	struct imsic_vector *vec;
 	unsigned long local_id;
 
@@ -103,9 +103,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 			continue;
 		}
 
-		err = generic_handle_domain_irq(imsic->base_domain, vec->hwirq);
-		if (unlikely(err))
-			pr_warn_ratelimited("hwirq 0x%x mapping not found\n", vec->hwirq);
+		generic_handle_irq(vec->irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index b9e3f9030bdf..6bf5d63f614e 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -111,7 +111,7 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -EBUSY;
 
 	/* Get a new vector on the desired set of CPUs */
-	new_vec = imsic_vector_alloc(old_vec->hwirq, mask_val);
+	new_vec = imsic_vector_alloc(old_vec->irq, mask_val);
 	if (!new_vec)
 		return -ENOSPC;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 5ec2b6bdffb2..d0148e48ab05 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -422,7 +422,7 @@ struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int l
 	return &lpriv->vectors[local_id];
 }
 
-struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask *mask)
+struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask)
 {
 	struct imsic_vector *vec = NULL;
 	struct imsic_local_priv *lpriv;
@@ -438,7 +438,7 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask
 
 	lpriv = per_cpu_ptr(imsic->lpriv, cpu);
 	vec = &lpriv->vectors[local_id];
-	vec->hwirq = hwirq;
+	vec->irq = irq;
 	vec->enable = false;
 	vec->move_next = NULL;
 	vec->move_prev = NULL;
@@ -451,7 +451,7 @@ void imsic_vector_free(struct imsic_vector *vec)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
-	vec->hwirq = UINT_MAX;
+	vec->irq = 0;
 	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
 	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
 }
@@ -510,7 +510,7 @@ static int __init imsic_local_init(void)
 			vec = &lpriv->vectors[i];
 			vec->cpu = cpu;
 			vec->local_id = i;
-			vec->hwirq = UINT_MAX;
+			vec->irq = 0;
 		}
 	}
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 19dea0c77738..3202ffa4e849 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -20,7 +20,7 @@ struct imsic_vector {
 	unsigned int				cpu;
 	unsigned int				local_id;
 	/* Details saved by driver in the vector */
-	unsigned int				hwirq;
+	unsigned int				irq;
 	/* Details accessed using local lock held */
 	bool					enable;
 	struct imsic_vector			*move_next;
@@ -96,7 +96,7 @@ void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_ve
 
 struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);
 
-struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask *mask);
+struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask);
 void imsic_vector_free(struct imsic_vector *vector);
 
 void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int ind);
-- 
2.43.0


