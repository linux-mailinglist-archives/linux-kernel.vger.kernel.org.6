Return-Path: <linux-kernel+bounces-429716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93B9E2133
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF859286517
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F911F76BF;
	Tue,  3 Dec 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VD0KFiHA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C51F76B7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238489; cv=none; b=s9SF5lQ+0BwPN/XF1mlUPPgGu0zNOVSvXAN7NUWLUwqqEutrR6MW64674O1GjNPIWciHocQJXVxOigsMQNZ+Mk77c1mLQmrfkMHebJWXpf/icEpQ06LfzNcftwYDQyGBvb3Otdp0WK+EdKp/oU8OGSBj9yFCkq6msPzhBtzSucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238489; c=relaxed/simple;
	bh=Q1ktawck32uSPedZRE7jVvjq8cNEHCOqcblu1NfPF1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUw8i383MOWBbEW6hP//Hb7h5n8tOm0T6a7BKaEt8UlxKS/11lUaBzGaQsyuZ0LnMCmqgGVs6p8rilPbCjJ+SCv05fNY4bxD6hx1a8BivbadiNS0bZovph5VcfbllPzpoY4RZitSX0iIrXn3mBgkZocr6cLXE4wrnDUxrqp7ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VD0KFiHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733238485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CtMCDurGwRoeWF6CpqiSRY67gb09X/3dzd+TMhMfkKM=;
	b=VD0KFiHAlGrxOOEhMG6n8kSj2iLpjfkG10rHGV1t4nhSfTOcD+ZHp5+5PL6n7SjywPnBoo
	atV7vuq9tHLvac5lJOzCeR4dlp8fC9M9pbNXaGsIbFnKEM078NN5JBysmxqSKDaCff7gz7
	kSHDMzWEdtvgTed4NwpAWwI5sUgbdVA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-T81WEZWSObKQMnEuXFbNbg-1; Tue,
 03 Dec 2024 10:08:02 -0500
X-MC-Unique: T81WEZWSObKQMnEuXFbNbg-1
X-Mimecast-MFC-AGG-ID: T81WEZWSObKQMnEuXFbNbg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10A271955EB3;
	Tue,  3 Dec 2024 15:08:01 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.66.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 783321956089;
	Tue,  3 Dec 2024 15:07:58 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
Date: Tue,  3 Dec 2024 10:07:32 -0500
Message-ID: <20241203150732.182065-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Depending on the type of panics, it was found that the
__register_nmi_handler() function can be called in NMI context from
nmi_shootdown_cpus() leading to a lockdep splat like the following.

[ 1123.133573] ================================
[ 1123.137845] WARNING: inconsistent lock state
[ 1123.142118] 6.12.0-31.el10.x86_64+debug #1 Not tainted
[ 1123.147257] --------------------------------
[ 1123.151529] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  :
[ 1123.261544]  Possible unsafe locking scenario:
[ 1123.261544]
[ 1123.267463]        CPU0
[ 1123.269915]        ----
[ 1123.272368]   lock(&nmi_desc[0].lock);
[ 1123.276122]   <Interrupt>
[ 1123.278746]     lock(&nmi_desc[0].lock);
[ 1123.282671]
[ 1123.282671]  *** DEADLOCK ***
  :
[ 1123.314088] Call Trace:
[ 1123.316542]  <NMI>
[ 1123.318562]  dump_stack_lvl+0x6f/0xb0
[ 1123.322230]  print_usage_bug.part.0+0x3d3/0x610
[ 1123.330618]  lock_acquire.part.0+0x2e6/0x360
[ 1123.357217]  _raw_spin_lock_irqsave+0x46/0x90
[ 1123.366193]  __register_nmi_handler+0x8f/0x3a0
[ 1123.374401]  nmi_shootdown_cpus+0x95/0x120
[ 1123.378509]  kdump_nmi_shootdown_cpus+0x15/0x20
[ 1123.383040]  native_machine_crash_shutdown+0x54/0x160
[ 1123.388095]  __crash_kexec+0x10f/0x1f0
[ 1123.421465]  ? __ghes_panic.cold+0x4f/0x5d
[ 1123.482648]  </NMI>

In this particular case, the following panic message was printed before.

[ 1122.808188] Kernel panic - not syncing: Fatal hardware error!

This message seemed to be given out from __ghes_panic() running in
NMI context.

The __register_nmi_handler() function which takes the nmi_desc lock
with irq disabled shouldn't be called from NMI context as this can
lead to deadlock.

The nmi_shootdown_cpus() function can only be invoked once. After the
first invocation, all other CPUs should be stuck in the newly added
crash_nmi_callback() and cannot respond to a second NMI.

One way to address this problem is to remove all the panic() calls from
NMI context, but that can be too restrictive.

Another way to fix this problem while allowing panic() calls from
NMI context is by adding a new emergency NMI handler to the nmi_desc
structure and provide a new set_emergency_nmi_handler() helper to
atomically set crash_nmi_callback() in any context. The new emergency
handler will be invoked first before other handlers in the linked
list. That will eliminate the need to take any lock and serve the panic
in NMI use case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/nmi.h |  2 ++
 arch/x86/kernel/nmi.c      | 40 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/reboot.c   | 11 ++++-------
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 41a0ebb699ec..6715c123eff4 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -56,6 +56,8 @@ int __register_nmi_handler(unsigned int, struct nmiaction *);
 
 void unregister_nmi_handler(unsigned int, const char *);
 
+int set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler);
+
 void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index ed163c8c8604..d551f2814cf2 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -40,8 +40,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
 
+/*
+ * An emergency handler can be set in any context
+ */
 struct nmi_desc {
 	raw_spinlock_t lock;
+	nmi_handler_t emerg_handler;	/* Emergency handler */
 	struct list_head head;
 };
 
@@ -132,9 +136,18 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	nmi_handler_t ehandler;
 	struct nmiaction *a;
 	int handled=0;
 
+	/*
+	 * Call the emergency handler first, if set
+	 * Emergency handler is not traced or checked by nmi_check_duration().
+	 */
+	ehandler = READ_ONCE(desc->emerg_handler);
+	if (ehandler)
+		handled = ehandler(type, regs);
+
 	rcu_read_lock();
 
 	/*
@@ -224,6 +237,33 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
+/**
+ * set_emergency_nmi_handler - Set emergency handler
+ * @handler - the emergency handler to be stored
+ * Return: 0 if success, -EEXIST if a handler had been stored
+ *
+ * Atomically set an emergency NMI handler which, if set, will be invoked
+ * before all the other handlers in the linked list. If a NULL handler is
+ * passed in, it will clear it.
+ */
+int set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler)
+{
+	struct nmi_desc *desc = nmi_to_desc(type);
+	nmi_handler_t orig = NULL;
+
+	if (!handler) {
+		orig = READ_ONCE(desc->emerg_handler);
+		WARN_ON_ONCE(!orig);
+	}
+
+	if (try_cmpxchg(&desc->emerg_handler, &orig, handler))
+		return 0;
+	if (WARN_ON_ONCE(orig == handler))
+		return 0;
+	WARN_ONCE(1, "%s: failed to set emergency NMI handler!\n", __func__);
+	return -EEXIST;
+}
+
 static void
 pci_serr_error(unsigned char reason, struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 615922838c51..c1c8e1334343 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -926,15 +926,12 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	shootdown_callback = callback;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
-		return;		/* Return what? */
+
 	/*
-	 * Ensure the new callback function is set before sending
-	 * out the NMI
+	 * Atomically set emergency handler to be invoked first before other
+	 * handlers. The action shouldn't fail or a warning will be printed.
 	 */
-	wmb();
+	set_emergency_nmi_handler(NMI_LOCAL, crash_nmi_callback);
 
 	apic_send_IPI_allbutself(NMI_VECTOR);
 
-- 
2.47.0


