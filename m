Return-Path: <linux-kernel+bounces-517215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D606A37DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932881897A68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E31A1A5BA3;
	Mon, 17 Feb 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P9zx8gM4"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B91A5B98
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782727; cv=none; b=cGYy6l1m6xTmDhMv4FldEQDocMKqNE7m93eA6r7xU9YYQmSqc/vq5ORyIhR/Mzckb/ryB03adQV1IZ0SPhptdyjoeVrzJHkktIWwdBTCzZdvTN0+GoMswcQmu5zGvBHC5ge2LzwOrAste8pKrXqweRIJ+pwTm+tDDgdq+dnlVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782727; c=relaxed/simple;
	bh=RPo428/+3N8qHEtW1RONCU54MpHrxK6R0GBkMkmhafs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbvcpey/fPSSoygH8iLTIXseAI7Wpw564USPepkDtZ2axmLhbTGmNEikhfkFAT0oQfXdTmIVaGS8NVYLgILfgMjgdQJPxtd8JbnsjNpnIdPyirViMo0FGoSZYSL0doZf793X8jnZ/f514Akjukn3mazIqPHdwyyoN92R/esYJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P9zx8gM4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220dc3831e3so57398525ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782725; x=1740387525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSbtd2A+IfFNBQ5eBtv/V1kZK2ZwPWt/jT9RsNuUoAs=;
        b=P9zx8gM4yLF93l2RFgKu8sB23M8a7JEVnN/nXtSOpcT6KYGS5/dmPhljIrO4VtdYjy
         2CBfGkxq0SwXb8o++f8eXORmuDfql2C1a8h/C2A43Bo2DwQ2K5I5yZ1a9yk2u8ivDP2X
         uFC6baDRAD241chkZNlrgE698wQWRdRRNfv98J0uzHsoGVdVTnk22dIxGvaznPWaVs2V
         t2IkSEyUfGVcwW+CUBk8uXmWpQch1aQ7IuLxMZZ74vXZXcqXl9lycAZoFMkLCO3dtFdx
         3BhBeA2DC+I6zZnzWQVcQBPw28esh4HSmCLBfq4kxxImLK5bNxW2zR0I3CnqEGTz4G7w
         3J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782725; x=1740387525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSbtd2A+IfFNBQ5eBtv/V1kZK2ZwPWt/jT9RsNuUoAs=;
        b=vDDZ2R8NauWBj08w3rmsq50NDxt7tGUQwfFNxWu0aauSbRyxQHMRE4hjZoZy8NginH
         u2qZRGzJQZNx4lPjnKuAKmm8f5tbP72YyIdn+DVYcmXr8KTvfO7+58moFeP89ppti8Da
         6tAtaV+MKlcNqUipPIG1QqUj7QzsawGaz8E2DwYlu2afngTRoYqHjM21o5VH+JBL4YNY
         ogn/mOdpKV/sX3GvpLH/C7KnR8DZ4oJmWN9H1XN3r0W3hIg2kynjFeFpJP6KlHMfdd4y
         QRt/Oz5xu1VTWFL0xIwfmoO/8ADQQ8AvnjjzwyKj0dtOdREzWRcCrjCGSDmD7IgebcjW
         tdcw==
X-Forwarded-Encrypted: i=1; AJvYcCWHFrBmVcWNALgR9J0S/p79xPiuQ5kK0RhH1BjKrKGYt/kZZFxFXNiFUDr7oLmY6NlDcXFYAtNvtZprSxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvKtM0ETpA164/Sm4KKKZ7j7fNwum2gkJf1SiCPM3FPKsVtCr
	QAdOtIsmj2W0FSOuYuazIevrqnU1m9HZ5EB4dTFHztvx/SpRXtp4VIm+g/EllK8=
X-Gm-Gg: ASbGncvtrBV/EF/WDTgJTA+PzETEu0Pr/C5ZVf51m20OmUIIDeGorM/R/a1xP+4/MgP
	/zK6NKJeM72TnQ0pF94rviIQh6I1YLB+4bGxJbc8FgwK01m3GE5KmHZizdpRjrdH9qbPxNlhMh3
	aJVDnFkwVllNoLP8fKHIzEwlPpEAk07cfm100h18SW628IHsBUTxNSIE/MZfKGcL8HtgVHtfVwc
	EnsGHQPqAskRlQzpBCjL3jyabvczepLqXr9Imef2zD4oJLTEEqSKRar1RMHgVkVoD/di5knkjfx
	kpAPuQOXh2beaLx8g4w7aPR5esEHJSkBJcgAAsMWMHZKostgUrSygPw=
X-Google-Smtp-Source: AGHT+IGxqt1/NXuR/2jkVfU876iHwX+bRPYBCe6t0MKtB0yrApmwkzYXbLbKcxfdEmKjCUbS0U/rew==
X-Received: by 2002:a05:6a00:9456:b0:732:57d3:f004 with SMTP id d2e1a72fcca58-73257d3f4d5mr18708318b3a.6.1739782725252;
        Mon, 17 Feb 2025 00:58:45 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:58:44 -0800 (PST)
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
Subject: [PATCH v6 07/10] irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector
Date: Mon, 17 Feb 2025 14:26:53 +0530
Message-ID: <20250217085657.789309-8-apatel@ventanamicro.com>
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

Currently, there is only one "move" pointer in the struct imsic_vector
so during vector movement the old vector points to the new vector and
new vector points to itself.

To support force cleanup of old vector, add separate "move_next" and
"move_prev" pointers in the struct imsic_vector where during vector
movement the "move_next" pointer of the old vector points to the new
vector and the "move_prev" pointer of the new vector points to the
old vector.

Both "move_next" and "move_prev" pointers are cleared separately by
__imsic_local_sync() with a restriction that "move_prev" on the new
CPU is cleared only after old CPU has cleared "move_next".

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c |  8 ++-
 drivers/irqchip/irq-riscv-imsic-state.c | 96 +++++++++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.h |  7 +-
 3 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 275df5005705..553650932c75 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -77,6 +77,12 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	struct imsic_vector *vec;
 	unsigned long local_id;
 
+	/*
+	 * Process pending local synchronization instead of waiting
+	 * for per-CPU local timer to expire.
+	 */
+	imsic_local_sync_all(false);
+
 	chained_irq_enter(chip, desc);
 
 	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
@@ -120,7 +126,7 @@ static int imsic_starting_cpu(unsigned int cpu)
 	 * Interrupts identities might have been enabled/disabled while
 	 * this CPU was not running so sync-up local enable/disable state.
 	 */
-	imsic_local_sync_all();
+	imsic_local_sync_all(true);
 
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b97e6cd89ed7..96e994443fc7 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -124,10 +124,11 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 	}
 }
 
-static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
 	struct imsic_local_config *mlocal;
 	struct imsic_vector *vec, *mvec;
+	bool ret = true;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
@@ -143,35 +144,75 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 			__imsic_id_clear_enable(i);
 
 		/*
-		 * If the ID was being moved to a new ID on some other CPU
-		 * then we can get a MSI during the movement so check the
-		 * ID pending bit and re-trigger the new ID on other CPU
-		 * using MMIO write.
+		 * Clear the pervious vector pointer of the new vector only
+		 * after the movement is complete on the old CPU.
 		 */
-		mvec = READ_ONCE(vec->move);
-		WRITE_ONCE(vec->move, NULL);
-		if (mvec && mvec != vec) {
+		mvec = READ_ONCE(vec->move_prev);
+		if (mvec) {
+			/*
+			 * If the old vector has not been updated then
+			 * try again in the next sync-up call.
+			 */
+			if (READ_ONCE(mvec->move_next)) {
+				ret = false;
+				continue;
+			}
+
+			WRITE_ONCE(vec->move_prev, NULL);
+		}
+
+		/*
+		 * If a vector was being moved to a new vector on some other
+		 * CPU then we can get a MSI during the movement so check the
+		 * ID pending bit and re-trigger the new ID on other CPU using
+		 * MMIO write.
+		 */
+		mvec = READ_ONCE(vec->move_next);
+		if (mvec) {
 			if (__imsic_id_read_clear_pending(i)) {
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
 
+			WRITE_ONCE(vec->move_next, NULL);
 			imsic_vector_free(&lpriv->vectors[i]);
 		}
 
 skip:
 		bitmap_clear(lpriv->dirty_bitmap, i, 1);
 	}
+
+	return ret;
 }
 
-void imsic_local_sync_all(void)
+#ifdef CONFIG_SMP
+static void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+	lockdep_assert_held(&lpriv->lock);
+
+	if (!timer_pending(&lpriv->timer)) {
+		lpriv->timer.expires = jiffies + 1;
+		add_timer_on(&lpriv->timer, smp_processor_id());
+	}
+}
+#else
+static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+}
+#endif
+
+void imsic_local_sync_all(bool force_all)
 {
 	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
-	__imsic_local_sync(lpriv);
+
+	if (force_all)
+		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	if (!__imsic_local_sync(lpriv))
+		__imsic_local_timer_start(lpriv);
+
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
 
@@ -190,12 +231,7 @@ void imsic_local_delivery(bool enable)
 #ifdef CONFIG_SMP
 static void imsic_local_timer_callback(struct timer_list *timer)
 {
-	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	__imsic_local_sync(lpriv);
-	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+	imsic_local_sync_all(false);
 }
 
 static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
@@ -216,14 +252,11 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 	 */
 	if (cpu_online(cpu)) {
 		if (cpu == smp_processor_id()) {
-			__imsic_local_sync(lpriv);
-			return;
+			if (__imsic_local_sync(lpriv))
+				return;
 		}
 
-		if (!timer_pending(&lpriv->timer)) {
-			lpriv->timer.expires = jiffies + 1;
-			add_timer_on(&lpriv->timer, cpu);
-		}
+		__imsic_local_timer_start(lpriv);
 	}
 }
 #else
@@ -278,8 +311,9 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
 
-static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsic_vector *vec,
-				     bool new_enable, struct imsic_vector *new_move)
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
+				     struct imsic_vector *vec, bool is_old_vec,
+				     bool new_enable, struct imsic_vector *move_vec)
 {
 	unsigned long flags;
 	bool enabled;
@@ -289,7 +323,10 @@ static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsi
 	/* Update enable and move details */
 	enabled = READ_ONCE(vec->enable);
 	WRITE_ONCE(vec->enable, new_enable);
-	WRITE_ONCE(vec->move, new_move);
+	if (is_old_vec)
+		WRITE_ONCE(vec->move_next, move_vec);
+	else
+		WRITE_ONCE(vec->move_prev, move_vec);
 
 	/* Mark the vector as dirty and synchronize */
 	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
@@ -322,8 +359,8 @@ void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_ve
 	 * interrupt on the old vector while device was being moved
 	 * to the new vector.
 	 */
-	enabled = imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
-	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+	enabled = imsic_vector_move_update(old_lpriv, old_vec, true, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, false, enabled, old_vec);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -386,7 +423,8 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask
 	vec = &lpriv->vectors[local_id];
 	vec->hwirq = hwirq;
 	vec->enable = false;
-	vec->move = NULL;
+	vec->move_next = NULL;
+	vec->move_prev = NULL;
 
 	return vec;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 391e44280827..f02842b84ed5 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -23,7 +23,8 @@ struct imsic_vector {
 	unsigned int				hwirq;
 	/* Details accessed using local lock held */
 	bool					enable;
-	struct imsic_vector			*move;
+	struct imsic_vector			*move_next;
+	struct imsic_vector			*move_prev;
 };
 
 struct imsic_local_priv {
@@ -74,7 +75,7 @@ static inline void __imsic_id_clear_enable(unsigned long id)
 	__imsic_eix_update(id, 1, false, false);
 }
 
-void imsic_local_sync_all(void);
+void imsic_local_sync_all(bool force_all);
 void imsic_local_delivery(bool enable);
 
 void imsic_vector_mask(struct imsic_vector *vec);
@@ -87,7 +88,7 @@ static inline bool imsic_vector_isenabled(struct imsic_vector *vec)
 
 static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *vec)
 {
-	return READ_ONCE(vec->move);
+	return READ_ONCE(vec->move_prev);
 }
 
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
-- 
2.43.0


