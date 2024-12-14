Return-Path: <linux-kernel+bounces-446117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584EE9F2010
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE401887F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295B1A8F6D;
	Sat, 14 Dec 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oOOMCvLc"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA11A01C3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197174; cv=none; b=siOf+HDJAMydWCuBf2Jb6FvklXs1zz+wxy7JtUNJjwxU4gqZ9X/pr95toYjSp73lyOAjSeEvtajpU78QIw/uSNeaLXv6kPuDj//u9rHM/ZWHqqZLGreNBgDcMv939ZtgbNfP7gtTBnRVgJjVvGvB65l6z+UEhJVErQg8VuRoTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197174; c=relaxed/simple;
	bh=AjbhMTp1aGsIYrzh3IEvyIDO76drMFMoCVTh2CxsqAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK+tN5xJEJ640JllrQwxwhiZiLFoIBz9sqsQwM6yIRRvuB2YwNq42WyGqLjyZPOWnE4RYlH1K1254Lp++35aruy81R3YQ3/9Ko0N1OlOsrtA2z2rRLhsu7lgtUoX8vUkKdvNOFzjp7hqW6gTuwmMfFp/IUzHkfaxCeM/4lS70lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oOOMCvLc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2efa856e4a4so1965655a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197172; x=1734801972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBfvQ3kWrJIo4ZX2fO574K2xNLHLI8xt5fD3UcZCgGE=;
        b=oOOMCvLcVOBma1klJHjQ79q6oTk3wV2YREnsTmPzeZQkz1KXorbk62zaJO7QUfqj1E
         X9lJE1W1UBBzjrddZTvr6jKgwk/4/JSedHWT3pvCShCegep3F2YXhZyDiq67uIk44qYT
         xv7P2e5LiFq3aZ+7W7bZaoyvT+zU6HsBaXOmSlkmVWkQbayVmt9qj9OhdvjW8iL8q0HV
         OWdklbOWrlZ7VDiCZ112URuQdUZPNxaRK4lnJaRVP/5uiqp/UNfaXVfrS5wILpfQo83D
         ntk22amYgJey9JkUrfowk9wfBloZf924hGQslZDDkwnvnK9m76w13Vw7/CtkAbHASDbq
         UHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197172; x=1734801972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBfvQ3kWrJIo4ZX2fO574K2xNLHLI8xt5fD3UcZCgGE=;
        b=skSlj89SPhWfzucf7E8+OnOOo5KWMkCcMfRam7U/IHMEub4A61lqaRacZpjIKyoMiX
         N861CHf7mJooJIJvoX7wxue+NsqsJsGsoza1aq7kL2eZ5lo6pXvjaiL3DuUNti+vk+nO
         Z1t6EdgZCGeLtMj+/zffxTEa7ixEaRuY93ILBTidPFjCugssGUuH5VNF2quZK5JUjxFg
         VNqK/RcJTXeGwVwZNpmhUXjlRPDSEgLVQRoUK1dN2S981GEx6POPjXdPOFICvvqTNJQN
         DbIx0hxYgvNvDdP0iyrqQzxFnX+5TjeCdUjFow5/Lg77tR93vIHs9q80PT8FMnMKWtUr
         VW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq9Llsli7e/8/QNWsUC/Mw1+GY8JHL+azLuSjp8ddxb3jDrMNRnIpwRcYSEHK9aoPklEBEipxK+0bylzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeTdzfyfPwm3qDdUPu5cCO/4X00p7o7nPVUwSKJGCdzAPgqYY
	lVIWIZFMpfkTDNEUtVtmeaNOqD8Dt47Rt8+wrTkbvVGMRVs0jXhyiCpDGu7y3rY=
X-Gm-Gg: ASbGncvvSkKlcaU1dwq9lhw2RdDgWHtlorhCkJctsNFYbqOUgu9eWauN502GB1ltN6R
	Dx5HcTbE5XfOMTjq9jQtvoyzHfT2qWelzTt/iuYli82Y8+PO6sETqp70xcbRZP2609xsvjAYdAZ
	5+Fsr4sB7qot1sdO1sLcKXwO5VN+C41TiMTXcrTL7P2DNlCHGTHYlwL1emG3/xns49z/k/qeCoO
	tSp9dHFyeWWebF15m1K2EqYmJxkD4BGX0wy9fT3C1sx25zKAn5GuuUWrGMTl1p4XVZ3c1ZsnS+s
	Pb6Moz7YgQKpbF4=
X-Google-Smtp-Source: AGHT+IHTs9Samt1nUdMUjND/qbDSnn282FzLK2X5JD8ULRiRDj00BeL2dfgDijLQRIK8XWPNIoxzrQ==
X-Received: by 2002:a17:90b:180b:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f28fb6efa6mr13056275a91.12.1734197172388;
        Sat, 14 Dec 2024 09:26:12 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:11 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v2 01/11] irqchip/riscv-imsic: Handle non-atomic MSI updates for device
Date: Sat, 14 Dec 2024 22:55:39 +0530
Message-ID: <20241214172549.8842-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214172549.8842-1-apatel@ventanamicro.com>
References: <20241214172549.8842-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device having non-atomic MSI update might see an intermediate
state when changing target IMSIC vector from one CPU to another.

To handle such intermediate device state, update MSI address
and MSI data through separate MSI writes to the device.

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    |  8 +++-
 drivers/irqchip/irq-riscv-imsic-platform.c | 27 ++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.c    | 50 ++++++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.h    |  2 +-
 4 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index c5c2e6929a2f..73a93ce8668f 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -77,6 +77,12 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	struct imsic_vector *vec;
 	unsigned long local_id;
 
+	/*
+	 * First process pending IMSIC vector enable, disable and movement
+	 * on the current CPU.
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
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index c708780e8760..b44eb0b3990b 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -97,6 +97,7 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 {
 	struct imsic_vector *old_vec, *new_vec;
 	struct irq_data *pd = d->parent_data;
+	struct imsic_vector tmp_vec;
 
 	old_vec = irq_data_get_irq_chip_data(pd);
 	if (WARN_ON(!old_vec))
@@ -115,6 +116,32 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 	if (!new_vec)
 		return -ENOSPC;
 
+	/*
+	 * Device having non-atomic MSI update might see an intermediate
+	 * state when changing target IMSIC vector from one CPU to another.
+	 *
+	 * To avoid losing interrupt to some intermediate state, do the
+	 * following (just like x86 APIC):
+	 *
+	 * 1) First write a temporary IMSIC vector to the device which
+	 * has MSI address same as the old IMSIC vector but MSI data
+	 * matches the new IMSIC vector.
+	 *
+	 * 2) Next write the new IMSIC vector to the device.
+	 *
+	 * Based on the above, the __imsic_local_sync() must check both
+	 * old MSI data and new MSI data on the old CPU for pending
+	 */
+
+	if (new_vec->local_id != old_vec->local_id) {
+		/* Setup temporary vector */
+		tmp_vec.cpu = old_vec->cpu;
+		tmp_vec.local_id = new_vec->local_id;
+
+		/* Point device to the temporary vector */
+		imsic_msi_update_msg(d, &tmp_vec);
+	}
+
 	/* Point device to the new vector */
 	imsic_msi_update_msg(d, new_vec);
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b97e6cd89ed7..a8645084bd8f 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -126,21 +126,21 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 
 static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
-	struct imsic_local_config *mlocal;
-	struct imsic_vector *vec, *mvec;
+	struct imsic_local_config *tlocal, *mlocal;
+	struct imsic_vector *vec, *tvec, *mvec;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
 
 	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
 		if (!i || i == IMSIC_IPI_ID)
-			goto skip;
+			continue;
 		vec = &lpriv->vectors[i];
 
 		if (READ_ONCE(vec->enable))
-			__imsic_id_set_enable(i);
+			__imsic_id_set_enable(vec->local_id);
 		else
-			__imsic_id_clear_enable(i);
+			__imsic_id_clear_enable(vec->local_id);
 
 		/*
 		 * If the ID was being moved to a new ID on some other CPU
@@ -151,26 +151,47 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 		mvec = READ_ONCE(vec->move);
 		WRITE_ONCE(vec->move, NULL);
 		if (mvec && mvec != vec) {
-			if (__imsic_id_read_clear_pending(i)) {
+			/*
+			 * Device having non-atomic MSI update might see an
+			 * intermediate state so check both old ID and new ID
+			 * for pending interrupts.
+			 *
+			 * For details, refer imsic_irq_set_affinity().
+			 */
+
+			tvec = vec->local_id == mvec->local_id ?
+			       NULL : &lpriv->vectors[mvec->local_id];
+			if (tvec && __imsic_id_read_clear_pending(tvec->local_id)) {
+				/* Retrigger temporary vector if it was already in-use */
+				if (READ_ONCE(tvec->enable)) {
+					tlocal = per_cpu_ptr(imsic->global.local, tvec->cpu);
+					writel_relaxed(tvec->local_id, tlocal->msi_va);
+				}
+
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
 
-			imsic_vector_free(&lpriv->vectors[i]);
+			if (__imsic_id_read_clear_pending(vec->local_id)) {
+				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			imsic_vector_free(vec);
 		}
 
-skip:
-		bitmap_clear(lpriv->dirty_bitmap, i, 1);
+		bitmap_clear(lpriv->dirty_bitmap, vec->local_id, 1);
 	}
 }
 
-void imsic_local_sync_all(void)
+void imsic_local_sync_all(bool force_all)
 {
 	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	if (force_all)
+		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
 	__imsic_local_sync(lpriv);
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
@@ -190,12 +211,7 @@ void imsic_local_delivery(bool enable)
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
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 391e44280827..8fae6c99b019 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -74,7 +74,7 @@ static inline void __imsic_id_clear_enable(unsigned long id)
 	__imsic_eix_update(id, 1, false, false);
 }
 
-void imsic_local_sync_all(void);
+void imsic_local_sync_all(bool force_all);
 void imsic_local_delivery(bool enable);
 
 void imsic_vector_mask(struct imsic_vector *vec);
-- 
2.43.0


