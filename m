Return-Path: <linux-kernel+bounces-517216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F7A37DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA83B378F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513BB1A83F5;
	Mon, 17 Feb 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oSOWmpQQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608A1A314E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782735; cv=none; b=c2COAPjub2U1MXacw0hoYsbV7AgW8t/qLklxy4IA4KsYHHlp6PsKSBNVkDE3LGTkLwc8u++X++7hdkfF4IEt34qg6HHiQAZUTgFHCQE5J5+W8HrdJ3e0OnkKW/LqTjjLp1rMRLrWEkyiuC0pzxRXaYHmbjJq7B2fd6DsHv50gxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782735; c=relaxed/simple;
	bh=mFFEh8+hZeEVXl9Ut+Oj3ibjoUtqS7w8eehuqLHhRt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz3u7SgC9P2RW5Npwxyb6ec4vP4CI1qI4mDG+hppJiAvbSxIJaWibAQYtQmjAMUExXDVPeBNG2JWS2GPIWDAjHZD3mebLoVkiygFBYI++jc7krVAg1kdmZgmyUDNgWhZslxPgHs4KEkL32I4H6FL1eoY/CejP3uFw4aVyWfLe9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oSOWmpQQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e83d65e5so59704055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782733; x=1740387533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoqQmmMLZnhmH7e8y5iCPOfAA2UjM+1/YD5gOA06f3E=;
        b=oSOWmpQQzqVZiyD4LovIEWCs7VoMAsLfiLKg+Dx19Hr0VzO5W2ioB5838kiSKaCX4G
         WBxjGQG2tm8pJJZKROGEsmGy/x595OoqlFeLUEby0xs8tIwQF1TKD+DuTh4CYGYAX3ti
         2H38B/Wiox+A/YiPt0BPiWTVghS59pF0Kq1ZE17OWMSS9ah3B97GapWJkpzCtLutA2UB
         8krvpIDUBhYZVHf2foC0Ejm4ft+kUSqPbtgh2r/AIwPu8zq51q1aoEe5spG6v9+SRU3H
         gkAslBGTvK9MzykryRIVxQINUyapoZNV9EeayrP4FO5WAaQ7FQkP7WnZuV6cd4E4GpNc
         dILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782733; x=1740387533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoqQmmMLZnhmH7e8y5iCPOfAA2UjM+1/YD5gOA06f3E=;
        b=vYVY9qEhOqYG9FiZe85zV6G/2NknhSeQzl35xjcFUzt5T8+jDFu9fCYHPX5256ano7
         dtkNJ6Ku9Qxkcc77de4LIFYk5dtHadj57DeM1jpJteTPxrwxwzO2Rxikj1eqFj1gwv+O
         Hxi0U3tYbclvL2coHG0zsKeNcGF5VyKqVmeGK9xDIxfjjJvKtP7jQv/3VIyAb2q/EW+A
         8+5joa0RcNEcWChfU4CjtRgYgDFGdeTjDjxCEE2L+XuLIjGihyYVwATcdtCzBOqqqWhA
         x19JHsPW78LKRlB3XR1hlLmDU7UeGTPhg751Q6ra2VMY4Io3MKr2u/oJPlMPswKJEESu
         bbkA==
X-Forwarded-Encrypted: i=1; AJvYcCWJhuhEW1t+IgEVn6YEnTL8CT81dZalrmUcNndYUD+j3bGeHacNlE79xZ4IjvhFOwNVIPX7KkmfKXcViCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRe6ZcxbqQxZvAYtDiTUkvyI9GnOAXMNbWd5x9cG1E9AdIag1
	pZYc5QxxK9lTYREY49kKstgOh54Z0q2TzUtS86TWL42HVoj3k83ZYAPV6MtxeCU=
X-Gm-Gg: ASbGnct+DlSLeuChOwFu7o1a/l+kgIITjyBKMyHzCr8Hg8wfi0sKMsu5AvLLP9wPJXV
	eTRIgJOdAWmo+wPBfCSbYsXaR7s7zZTFntPCFZJsUE2Vipxj7viKnE6l/LWa4tYbWfbGiSeIxRA
	SU76qbhpYlwMlWUnPzCSYyeYHLxIGez8nTMqEZ4aDHblYC2jr6ti4suL2L+uoTfC+dtvq634jDw
	MEsURrXjYao59GOLjZWtY829palyQYi4sNAOXmeVEj869TcN0JHHJlRANaUo39W6SaUleVK2NQP
	GTmyLG/kzXubQdwDyghH7nODTs60iBrHYxD+hfS1mWiMxxSgvbhy+wI=
X-Google-Smtp-Source: AGHT+IFBSmav50eb95KMP+Wa+2zHfS16N6A6ml9KRa5tGTRfbaBtV9X2/4WT6iaEXHAuO8XqxuEKDQ==
X-Received: by 2002:a05:6a21:6d95:b0:1ee:5e7e:bcc2 with SMTP id adf61e73a8af0-1ee8cb176f4mr14239238637.23.1739782733442;
        Mon, 17 Feb 2025 00:58:53 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:58:52 -0800 (PST)
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
Subject: [PATCH v6 08/10] irqchip/riscv-imsic: Implement irq_force_complete_move() for IMSIC
Date: Mon, 17 Feb 2025 14:26:54 +0530
Message-ID: <20250217085657.789309-9-apatel@ventanamicro.com>
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

Implement irq_force_complete_move() for IMSIC driver so that in-flight
vector movements on a CPU can be cleaned-up when the CPU goes down.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 32 ++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c    | 17 ++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 9a5e7b4541f6..b9e3f9030bdf 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -129,6 +129,37 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 
 	return IRQ_SET_MASK_OK_DONE;
 }
+
+static void imsic_irq_force_complete_move(struct irq_data *d)
+{
+	struct imsic_vector *mvec, *vec = irq_data_get_irq_chip_data(d);
+	unsigned int cpu = smp_processor_id();
+
+	if (WARN_ON(!vec))
+		return;
+
+	/* Do nothing if there is no in-flight move */
+	mvec = imsic_vector_get_move(vec);
+	if (!mvec)
+		return;
+
+	/* Do nothing if the old IMSIC vector does not belong to current CPU */
+	if (mvec->cpu != cpu)
+		return;
+
+	/*
+	 * The best we can do is force cleanup the old IMSIC vector.
+	 *
+	 * The challenges over here are same as x86 vector domain so
+	 * refer to the comments in irq_force_complete_move() function
+	 * implemented at arch/x86/kernel/apic/vector.c.
+	 */
+
+	/* Force cleanup in-flight move */
+	pr_info("IRQ fixup: irq %d move in progress, old vector cpu %d local_id %d\n",
+		d->irq, mvec->cpu, mvec->local_id);
+	imsic_vector_force_move_cleanup(vec);
+}
 #endif
 
 static struct irq_chip imsic_irq_base_chip = {
@@ -137,6 +168,7 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_unmask		= imsic_irq_unmask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= imsic_irq_set_affinity,
+	.irq_force_complete_move = imsic_irq_force_complete_move,
 #endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 96e994443fc7..5ec2b6bdffb2 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -311,6 +311,23 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
 
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	unsigned long flags;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	mvec = READ_ONCE(vec->move_prev);
+	WRITE_ONCE(vec->move_prev, NULL);
+	if (mvec)
+		imsic_vector_free(mvec);
+
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
 static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
 				     struct imsic_vector *vec, bool is_old_vec,
 				     bool new_enable, struct imsic_vector *move_vec)
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index f02842b84ed5..19dea0c77738 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -91,6 +91,7 @@ static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *ve
 	return READ_ONCE(vec->move_prev);
 }
 
+void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
 
 struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);
-- 
2.43.0


