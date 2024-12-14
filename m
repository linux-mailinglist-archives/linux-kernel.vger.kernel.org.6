Return-Path: <linux-kernel+bounces-446124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8849F2017
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DB01887EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661E1AB517;
	Sat, 14 Dec 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OvOE5bLe"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68771A8F9C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197223; cv=none; b=eG/KeFwDwI3yDpS63V5cGW1Sx608s6fgoS7PciYNDx5TbMGf3drjc50eeXidWL8+WkOl2SyyUgHXy2hLsQVN6FBnD8TWP9Vna+tRIhs/RVgvXo8Y+mAgAciyRZSBL2rS1/apzB5LcD6BuVp15OmiVkKCR5kecmZv1obC6gm1lhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197223; c=relaxed/simple;
	bh=0ljoGbT/LRu6wccIGReKAg8EOuGxkwBf9UmQIRwMDWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cbdtkzdh86P4R6u7q46KVEVLRyoXspi4Ia4cpmGlKMvG9x0XUrQU9EgvstATCb/qkcaQB1R0uUSwFRJ7tQERLpugyaVIqgPPLyyJZyt6OaRap+N4J693YQJkmIlDsSVeSX0xUiyGDvdSVlM4dnKnfzvuoVtb9WtEG6ZDWJyZu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OvOE5bLe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee74291415so1871190a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197220; x=1734802020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKWIt7ITp/X88ndEH7it4rZ1geXjjPOabq3XOqds9DM=;
        b=OvOE5bLe/eGNyQJCMTRKgX3GUi+jkh0YZTDsSDnLjZlzFV7Ie2duFePdEjPVgbIgBB
         6t6Ts8yMUh7Wdw6pvNhxirxS6bTWXifstv4FoFGZK6Odh3FJuXDGPAsHPFqlVHyM6Pkh
         /4HhISNxYGuGyEPnRa1PbAKI/LC3vZz81HWfuvPjD04Xm5yqHZ0SDrcyQ7L5tCkIrI9n
         8r+DfFIBjNKNAr08cD5wUVUqtvsgXvflFiw3s4U+haW0k63TB6+n0vAdH22XlW9DEC4l
         UsbE52MOWYxaQ0Ka0sPbt8/rX7XL5GT7wJCobYSZE6Lr43LYpkr4b3vVvt1mBoecV+v1
         emVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197220; x=1734802020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKWIt7ITp/X88ndEH7it4rZ1geXjjPOabq3XOqds9DM=;
        b=DuPpWAQKPBb6R8np2u3yYL+hJIWqub8A+mPPP8diSF9wy5Qn6G6yPNHNZ8OfNlgNO7
         mXTkbsIM7oFy2oXm37QDKweq6L340xoo/9YM1g6Vd0++2MujKtRSv+Wd/TawxExpl9gj
         j95dwx8NO9D+mRpHDL6Fig3lNVlGl7sI7fyIY2R1+zj31fGiaXlg0AwLa3m5ol2EfiHI
         v5F71jPsNJgNYGd85J5kuVqHpkt5Dy7MHE2CmPo11PuMj+OLZ205wPH8NGWB6kC4GK9/
         qKljBwE2Y4wI29ymu0G81cOF+m8UuF1XJuy+GU6S6H7HIR5IFSTT4Qu3ceC8m+Fjof42
         Vssg==
X-Forwarded-Encrypted: i=1; AJvYcCVjqDNgr75Pi8AcZNeHqm5bu5ei9tvaUXDycTS9QdZjry5lODc4tjiuPnQHjzBAINYIyuIuNQV+xs7TENY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XYbgzeuFthWhuUyL1z3wXjeNHwl72198EzGOvKRGvbo4v0T8
	72jCo2R5l1zXSzc+vNadG/TOl4Q1LANL5MoeyowqE1YnOJNsX+4IAELxNoAjxLQ=
X-Gm-Gg: ASbGncsWS+M/fMmcfoYe7XIKwliYUdaIbTQeCG2G+p9kNWMCt1jnbkb+755eIsGLUuC
	xY6OrV3qBWveZZwWMp7aSWYFeBMFXddnqG8yLSS6EJtb3TxIkxxK+i2THbgSgSA3PX2g54QkVyE
	l/UQis0tBvTdlN1q1QOg3a1V2gmU1lCtdz1/QmtzOGSJb+oxLuzOOa2TZiC1s79JFHd5PEa4O1W
	tE03XUqvb2o8A6DsZGXGPfQYvTzwNMhEx3NPxDsuVMEHVUhdMSct9FEE5QfMU/Yk8Kj/eN6PMbD
	XLv9SAQHvsU3shQ=
X-Google-Smtp-Source: AGHT+IGQwf+KWHUKDSuNXTV8W8BsAm/unz0Vds64eL7itxYSGgZbtZcUWjgcYwS8LtLhLbggFNNyJA==
X-Received: by 2002:a17:90b:5112:b0:2ea:4c4f:bd20 with SMTP id 98e67ed59e1d1-2f2904a724dmr9248924a91.32.1734197220158;
        Sat, 14 Dec 2024 09:27:00 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:59 -0800 (PST)
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
Subject: [PATCH v2 08/11] irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector
Date: Sat, 14 Dec 2024 22:55:46 +0530
Message-ID: <20241214172549.8842-9-apatel@ventanamicro.com>
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

Currently, there is only one "move" pointer in the struct imsic_vector
so during vector movement the old vector points to the new vector and
new vector points to itself.

To support force cleanup of old vector, add separate "move_next" and
"move_prev" pointers in the struct imsic_vector where during vector
movement the "move_next" pointer of the old vector points to the
new vector and the "move_prev" pointer of the new vector points to
the old vector. Both "move_next" pointers are cleared separately
by __imsic_local_sync() on the old and new CPUs respectively.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 60 +++++++++++++++++++------
 drivers/irqchip/irq-riscv-imsic-state.h |  5 ++-
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index a8645084bd8f..da49a160ea09 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -124,10 +124,11 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 	}
 }
 
-static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
 	struct imsic_local_config *tlocal, *mlocal;
 	struct imsic_vector *vec, *tvec, *mvec;
+	bool ret = true;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
@@ -142,15 +143,33 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 		else
 			__imsic_id_clear_enable(vec->local_id);
 
+		/*
+		 * If the ID was being moved from an existing ID on some
+		 * other CPU then we clear the pervious vector pointer
+		 * only after the movement is complete.
+		 */
+		mvec = READ_ONCE(vec->move_prev);
+		if (mvec) {
+			/*
+			 * If the old IMSIC vector has not been updated then
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
 		/*
 		 * If the ID was being moved to a new ID on some other CPU
 		 * then we can get a MSI during the movement so check the
 		 * ID pending bit and re-trigger the new ID on other CPU
 		 * using MMIO write.
 		 */
-		mvec = READ_ONCE(vec->move);
-		WRITE_ONCE(vec->move, NULL);
-		if (mvec && mvec != vec) {
+		mvec = READ_ONCE(vec->move_next);
+		if (mvec) {
 			/*
 			 * Device having non-atomic MSI update might see an
 			 * intermediate state so check both old ID and new ID
@@ -177,11 +196,14 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
 
+			WRITE_ONCE(vec->move_next, NULL);
 			imsic_vector_free(vec);
 		}
 
 		bitmap_clear(lpriv->dirty_bitmap, vec->local_id, 1);
 	}
+
+	return ret;
 }
 
 void imsic_local_sync_all(bool force_all)
@@ -190,9 +212,16 @@ void imsic_local_sync_all(bool force_all)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
 	if (force_all)
 		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
-	__imsic_local_sync(lpriv);
+	if (!__imsic_local_sync(lpriv)) {
+		if (!timer_pending(&lpriv->timer)) {
+			lpriv->timer.expires = jiffies + 1;
+			add_timer_on(&lpriv->timer, smp_processor_id());
+		}
+	}
+
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
 
@@ -232,8 +261,8 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 	 */
 	if (cpu_online(cpu)) {
 		if (cpu == smp_processor_id()) {
-			__imsic_local_sync(lpriv);
-			return;
+			if (__imsic_local_sync(lpriv))
+				return;
 		}
 
 		if (!timer_pending(&lpriv->timer)) {
@@ -294,8 +323,9 @@ void imsic_vector_unmask(struct imsic_vector *vec)
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
@@ -305,7 +335,10 @@ static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsi
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
@@ -338,8 +371,8 @@ void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_ve
 	 * interrupt on the old vector while device was being moved
 	 * to the new vector.
 	 */
-	enabled = imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
-	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+	enabled = imsic_vector_move_update(old_lpriv, old_vec, true, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, false, enabled, old_vec);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -402,7 +435,8 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask
 	vec = &lpriv->vectors[local_id];
 	vec->hwirq = hwirq;
 	vec->enable = false;
-	vec->move = NULL;
+	vec->move_next = NULL;
+	vec->move_prev = NULL;
 
 	return vec;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 8fae6c99b019..f02842b84ed5 100644
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
@@ -87,7 +88,7 @@ static inline bool imsic_vector_isenabled(struct imsic_vector *vec)
 
 static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *vec)
 {
-	return READ_ONCE(vec->move);
+	return READ_ONCE(vec->move_prev);
 }
 
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
-- 
2.43.0


