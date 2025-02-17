Return-Path: <linux-kernel+bounces-517211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF83A37DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC18F7A4041
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F371ADC81;
	Mon, 17 Feb 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fv//+QtX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6319E7FA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782704; cv=none; b=d2f6f4yZDHV4QKLlje62jLfR8005XRGmyJvDCBfaD0llelxY9CNbSOsLoJjouleAMkFstESHeAuuXqcv9UKwow705rKT4KI/kEsZSrw6hdoESh++RTuNL/C3qhk0fzt1LtrL9wQouiAg5UUZRmjFY7K1VBaewMaeTxR1DmH+Ppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782704; c=relaxed/simple;
	bh=yfLmkM6qEAtePtmZAV08Oc3zFbXuNPHytenOkvHgx/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G22uRTliWYrO0i1j9jnsBG+uOXrxm5Fmi8P7RR1fn37enlmSqwC3P3BSxuhrU9k52G9b5cx2rIK+PS+NVD6ZLgJ6OZK61TloVjlYlZCtqcFUxup0zhuZzkoZgFDWVvMposPaMwmJnlfqSx/jligkQzomvhbPyRqqdgz1qK0gfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fv//+QtX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2210d92292eso39663755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782702; x=1740387502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muAXlG/uZk+Ut1w5NICM8ivKf832EJKGEf1Ht7zOCxs=;
        b=fv//+QtXMvX9e4r14q4FktPSlo8mG+9ZI5qR1G2GDcSqAwiDlP15PT5sj1bqy0sACU
         UZ1Kr/nrRYCS5LkhigQXFRoGhgYrK02HsdZctqKKU3tLfHUHogVTQK250MCrpUeJuhYS
         vALAqwcqXCkbo0f9Z7Fzunmre5U711VQ6X1tjxalUg55WRojdhgUGflvBtzlaCP8JSG2
         hWXQWT0fbBwTAy5owfYtjZ8wzxA5pZr0VAoP3oTJeWhnzRCHJ/OBWiFwz07TH9ZtyDvZ
         qk4rS6YhiAfrfrzb9YGyhGg/10k11qCm+lkfum7t943EmpDqxp5XfMIL5jKSkEfH/57x
         pLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782702; x=1740387502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muAXlG/uZk+Ut1w5NICM8ivKf832EJKGEf1Ht7zOCxs=;
        b=iBUf+tvGPtgxgauAnt3P2Q9AMl5m+onsZ8PgcQeoNnnGJS+FSxTCEJMJC6d35B+g1H
         x5jADdiOJLQAGCObeKrSbPal/8RIdzqOgeTiiROdfu98Sp/Cmez93dJUfJLOeCKrOXlr
         WF2ZC8CWxy7EknYgnO6G9S+WopSfZ4qGIG2uL62Yxs8I6D5iRRhG/0zIOOB4k2ovmDsv
         9TIhDg8R+B8t1nwWnniN6i9LDRuki3UxLy5PwmKo1sMyHgjXVHEzRVHCH0iiWAStPTS/
         Q14mWePzY8P+kJ4VKuKezKtkStVaeHrJ6wYr+ptwrwRLn595yjKbGK2jce22p4LJC8QZ
         dRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWek/EO7OhJvarRsbD7RCPmThZK5OyzM6P9BIrAzG8fdVeYmSxyTnvC2hRsJbAtvq4trNrgpnBDCIpcwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyV3a2oyOCRu5Vqn/5R8OtcNOnj7L6lq3cRTBQlAhnlPgLqUPV
	izrHCdzecQjuhYZydZekK+hhcRv7nXbazh4hs76ADYRvIKyNAXsB/qiX1ZCQ0V4=
X-Gm-Gg: ASbGncs38cCwu3AzsSNd3qH4i/bACI8PNfd9hQeRIc+JxdbvsOBJcvHowHLwk4pshec
	2nrBvhRrrRAZjuMw4SiOSDZ/xfCuZCikFazo8eVtDStokYDBOxVrFcRlMsDWY0CtNEZU8f5wQbv
	l0SRErAfGrErzSKafC9ys7vlSGfnI3sZubRBP0EaW6E3CeQ3mvgGLMbzZSMweCpKqaT++dKbbOZ
	JtiIcVekjgr2gagZNaeZ+WjVY7l06F42BoEL3538fZpeRZ4xnpYUM3KKOdRoA8eX8UQGlIgaXzC
	Idz/gwWTHH/zy2PMscwL8EFG23yOdD0RQ9lkxYIvzUxFSzNSBY33DaU=
X-Google-Smtp-Source: AGHT+IGeeSKqQaB04W0hYbcp5SOMBU/2KVamXBnyldtu8MmORMjRPb5xrOZF3XnR9hLS8Nh0YSNDYA==
X-Received: by 2002:a05:6a21:1693:b0:1ee:8099:e657 with SMTP id adf61e73a8af0-1ee8cbe7bb4mr16765666637.40.1739782702160;
        Mon, 17 Feb 2025 00:58:22 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:58:21 -0800 (PST)
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
Subject: [PATCH v6 04/10] genirq: Introduce common irq_force_complete_move() implementation
Date: Mon, 17 Feb 2025 14:26:50 +0530
Message-ID: <20250217085657.789309-5-apatel@ventanamicro.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

The GENERIC_PENDING_IRQ requires an arch specific implementation of
irq_force_complete_move(). At the moment, only x86 implements this
but for RISC-V the irq_force_complete_move() is only needed when
RISC-V IMSIC driver is in use and not needed otherwise.

To address the above, introduce a common irq_force_complete_move()
implementation in kernel irq migration which lets irqchip do the
actual irq_force_complete_move() and also update x86 APIC to use
this common implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/x86/kernel/apic/vector.c | 231 ++++++++++++++++------------------
 include/linux/irq.h           |   5 +-
 kernel/irq/internals.h        |   2 +
 kernel/irq/migration.c        |  10 ++
 4 files changed, 123 insertions(+), 125 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 736f62812f5c..72fa4bb78f0a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -888,8 +888,109 @@ static int apic_set_affinity(struct irq_data *irqd,
 	return err ? err : IRQ_SET_MASK_OK;
 }
 
+static void free_moved_vector(struct apic_chip_data *apicd)
+{
+	unsigned int vector = apicd->prev_vector;
+	unsigned int cpu = apicd->prev_cpu;
+	bool managed = apicd->is_managed;
+
+	/*
+	 * Managed interrupts are usually not migrated away
+	 * from an online CPU, but CPU isolation 'managed_irq'
+	 * can make that happen.
+	 * 1) Activation does not take the isolation into account
+	 *    to keep the code simple
+	 * 2) Migration away from an isolated CPU can happen when
+	 *    a non-isolated CPU which is in the calculated
+	 *    affinity mask comes online.
+	 */
+	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
+	irq_matrix_free(vector_matrix, cpu, vector, managed);
+	per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
+	hlist_del_init(&apicd->clist);
+	apicd->prev_vector = 0;
+	apicd->move_in_progress = 0;
+}
+
+/*
+ * Called from fixup_irqs() with @desc->lock held and interrupts disabled.
+ */
+static void apic_force_complete_move(struct irq_data *irqd)
+{
+	unsigned int cpu = smp_processor_id();
+	struct apic_chip_data *apicd;
+	unsigned int vector;
+
+	guard(raw_spinlock)(&vector_lock);
+	apicd = apic_chip_data(irqd);
+	if (!apicd)
+		return;
+
+	/*
+	 * If prev_vector is empty or the descriptor is neither currently
+	 * nor previously on the outgoing CPU no action required.
+	 */
+	vector = apicd->prev_vector;
+	if (!vector || (apicd->cpu != cpu && apicd->prev_cpu != cpu))
+		return;
+
+	/*
+	 * This is tricky. If the cleanup of the old vector has not been
+	 * done yet, then the following setaffinity call will fail with
+	 * -EBUSY. This can leave the interrupt in a stale state.
+	 *
+	 * All CPUs are stuck in stop machine with interrupts disabled so
+	 * calling __irq_complete_move() would be completely pointless.
+	 *
+	 * 1) The interrupt is in move_in_progress state. That means that we
+	 *    have not seen an interrupt since the io_apic was reprogrammed to
+	 *    the new vector.
+	 *
+	 * 2) The interrupt has fired on the new vector, but the cleanup IPIs
+	 *    have not been processed yet.
+	 */
+	if (apicd->move_in_progress) {
+		/*
+		 * In theory there is a race:
+		 *
+		 * set_ioapic(new_vector) <-- Interrupt is raised before update
+		 *			      is effective, i.e. it's raised on
+		 *			      the old vector.
+		 *
+		 * So if the target cpu cannot handle that interrupt before
+		 * the old vector is cleaned up, we get a spurious interrupt
+		 * and in the worst case the ioapic irq line becomes stale.
+		 *
+		 * But in case of cpu hotplug this should be a non issue
+		 * because if the affinity update happens right before all
+		 * cpus rendezvous in stop machine, there is no way that the
+		 * interrupt can be blocked on the target cpu because all cpus
+		 * loops first with interrupts enabled in stop machine, so the
+		 * old vector is not yet cleaned up when the interrupt fires.
+		 *
+		 * So the only way to run into this issue is if the delivery
+		 * of the interrupt on the apic/system bus would be delayed
+		 * beyond the point where the target cpu disables interrupts
+		 * in stop machine. I doubt that it can happen, but at least
+		 * there is a theoretical chance. Virtualization might be
+		 * able to expose this, but AFAICT the IOAPIC emulation is not
+		 * as stupid as the real hardware.
+		 *
+		 * Anyway, there is nothing we can do about that at this point
+		 * w/o refactoring the whole fixup_irq() business completely.
+		 * We print at least the irq number and the old vector number,
+		 * so we have the necessary information when a problem in that
+		 * area arises.
+		 */
+		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
+			irqd->irq, vector);
+	}
+	free_moved_vector(apicd);
+}
+
 #else
-# define apic_set_affinity	NULL
+# define apic_set_affinity		NULL
+# define apic_force_complete_move	NULL
 #endif
 
 static int apic_retrigger_irq(struct irq_data *irqd)
@@ -923,39 +1024,16 @@ static void x86_vector_msi_compose_msg(struct irq_data *data,
 }
 
 static struct irq_chip lapic_controller = {
-	.name			= "APIC",
-	.irq_ack		= apic_ack_edge,
-	.irq_set_affinity	= apic_set_affinity,
-	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
-	.irq_retrigger		= apic_retrigger_irq,
+	.name				= "APIC",
+	.irq_ack			= apic_ack_edge,
+	.irq_set_affinity		= apic_set_affinity,
+	.irq_compose_msi_msg		= x86_vector_msi_compose_msg,
+	.irq_force_complete_move	= apic_force_complete_move,
+	.irq_retrigger			= apic_retrigger_irq,
 };
 
 #ifdef CONFIG_SMP
 
-static void free_moved_vector(struct apic_chip_data *apicd)
-{
-	unsigned int vector = apicd->prev_vector;
-	unsigned int cpu = apicd->prev_cpu;
-	bool managed = apicd->is_managed;
-
-	/*
-	 * Managed interrupts are usually not migrated away
-	 * from an online CPU, but CPU isolation 'managed_irq'
-	 * can make that happen.
-	 * 1) Activation does not take the isolation into account
-	 *    to keep the code simple
-	 * 2) Migration away from an isolated CPU can happen when
-	 *    a non-isolated CPU which is in the calculated
-	 *    affinity mask comes online.
-	 */
-	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
-	irq_matrix_free(vector_matrix, cpu, vector, managed);
-	per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
-	hlist_del_init(&apicd->clist);
-	apicd->prev_vector = 0;
-	apicd->move_in_progress = 0;
-}
-
 static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 {
 	struct apic_chip_data *apicd;
@@ -1068,99 +1146,6 @@ void irq_complete_move(struct irq_cfg *cfg)
 		__vector_schedule_cleanup(apicd);
 }
 
-/*
- * Called from fixup_irqs() with @desc->lock held and interrupts disabled.
- */
-void irq_force_complete_move(struct irq_desc *desc)
-{
-	unsigned int cpu = smp_processor_id();
-	struct apic_chip_data *apicd;
-	struct irq_data *irqd;
-	unsigned int vector;
-
-	/*
-	 * The function is called for all descriptors regardless of which
-	 * irqdomain they belong to. For example if an IRQ is provided by
-	 * an irq_chip as part of a GPIO driver, the chip data for that
-	 * descriptor is specific to the irq_chip in question.
-	 *
-	 * Check first that the chip_data is what we expect
-	 * (apic_chip_data) before touching it any further.
-	 */
-	irqd = irq_domain_get_irq_data(x86_vector_domain,
-				       irq_desc_get_irq(desc));
-	if (!irqd)
-		return;
-
-	raw_spin_lock(&vector_lock);
-	apicd = apic_chip_data(irqd);
-	if (!apicd)
-		goto unlock;
-
-	/*
-	 * If prev_vector is empty or the descriptor is neither currently
-	 * nor previously on the outgoing CPU no action required.
-	 */
-	vector = apicd->prev_vector;
-	if (!vector || (apicd->cpu != cpu && apicd->prev_cpu != cpu))
-		goto unlock;
-
-	/*
-	 * This is tricky. If the cleanup of the old vector has not been
-	 * done yet, then the following setaffinity call will fail with
-	 * -EBUSY. This can leave the interrupt in a stale state.
-	 *
-	 * All CPUs are stuck in stop machine with interrupts disabled so
-	 * calling __irq_complete_move() would be completely pointless.
-	 *
-	 * 1) The interrupt is in move_in_progress state. That means that we
-	 *    have not seen an interrupt since the io_apic was reprogrammed to
-	 *    the new vector.
-	 *
-	 * 2) The interrupt has fired on the new vector, but the cleanup IPIs
-	 *    have not been processed yet.
-	 */
-	if (apicd->move_in_progress) {
-		/*
-		 * In theory there is a race:
-		 *
-		 * set_ioapic(new_vector) <-- Interrupt is raised before update
-		 *			      is effective, i.e. it's raised on
-		 *			      the old vector.
-		 *
-		 * So if the target cpu cannot handle that interrupt before
-		 * the old vector is cleaned up, we get a spurious interrupt
-		 * and in the worst case the ioapic irq line becomes stale.
-		 *
-		 * But in case of cpu hotplug this should be a non issue
-		 * because if the affinity update happens right before all
-		 * cpus rendezvous in stop machine, there is no way that the
-		 * interrupt can be blocked on the target cpu because all cpus
-		 * loops first with interrupts enabled in stop machine, so the
-		 * old vector is not yet cleaned up when the interrupt fires.
-		 *
-		 * So the only way to run into this issue is if the delivery
-		 * of the interrupt on the apic/system bus would be delayed
-		 * beyond the point where the target cpu disables interrupts
-		 * in stop machine. I doubt that it can happen, but at least
-		 * there is a theoretical chance. Virtualization might be
-		 * able to expose this, but AFAICT the IOAPIC emulation is not
-		 * as stupid as the real hardware.
-		 *
-		 * Anyway, there is nothing we can do about that at this point
-		 * w/o refactoring the whole fixup_irq() business completely.
-		 * We print at least the irq number and the old vector number,
-		 * so we have the necessary information when a problem in that
-		 * area arises.
-		 */
-		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
-			irqd->irq, vector);
-	}
-	free_moved_vector(apicd);
-unlock:
-	raw_spin_unlock(&vector_lock);
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Note, this is not accurate accounting, but at least good enough to
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8daa17f0107a..56f6583093d2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -486,6 +486,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @irq_nmi_setup:	function called from core code before enabling an NMI
  * @irq_nmi_teardown:	function called from core code after disabling an NMI
+ * @irq_force_complete_move:	optional function to force complete pending irq move
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -537,6 +538,8 @@ struct irq_chip {
 	int		(*irq_nmi_setup)(struct irq_data *data);
 	void		(*irq_nmi_teardown)(struct irq_data *data);
 
+	void		(*irq_force_complete_move)(struct irq_data *data);
+
 	unsigned long	flags;
 };
 
@@ -619,11 +622,9 @@ static inline void irq_move_irq(struct irq_data *data)
 		__irq_move_irq(data);
 }
 void irq_move_masked_irq(struct irq_data *data);
-void irq_force_complete_move(struct irq_desc *desc);
 #else
 static inline void irq_move_irq(struct irq_data *data) { }
 static inline void irq_move_masked_irq(struct irq_data *data) { }
-static inline void irq_force_complete_move(struct irq_desc *desc) { }
 #endif
 
 extern int no_irq_affinity;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a979523640d0..d4e190e690bd 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -442,6 +442,7 @@ static inline struct cpumask *irq_desc_get_pending_mask(struct irq_desc *desc)
 	return desc->pending_mask;
 }
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
+void irq_force_complete_move(struct irq_desc *desc);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
 {
@@ -467,6 +468,7 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
 {
 	return false;
 }
+static inline void irq_force_complete_move(struct irq_desc *desc) { }
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index eb150afd671f..e110300ad650 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -35,6 +35,16 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear)
 	return true;
 }
 
+void irq_force_complete_move(struct irq_desc *desc)
+{
+	for (struct irq_data *d = irq_desc_get_irq_data(desc); d; d = d->parent_data) {
+		if (d->chip && d->chip->irq_force_complete_move) {
+			d->chip->irq_force_complete_move(d);
+			return;
+		}
+	}
+}
+
 void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc = irq_data_to_desc(idata);
-- 
2.43.0


