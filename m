Return-Path: <linux-kernel+bounces-247484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E492D000
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409A8287F54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317618FA35;
	Wed, 10 Jul 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sdQ92Wiq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sdQ92Wiq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728913AD22;
	Wed, 10 Jul 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609307; cv=none; b=WTJZUVkXpu+Fr1TVZMFNWetSo5asqpWnMH4WJ58RUP3rReeQOdaVLtB1ne5PTJrr4JTL/Xz+hx/BVP3Idubt8elTwdedKttgW3epHUfhbl4iVxGljFegvhjAN/FLHV1lc+/uX67dTqlOSAekgYEmACuBpGKsPVLA3ztgysRLyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609307; c=relaxed/simple;
	bh=9MzSqZA89i3yAjv7qMUx8Jm9CyLjSJ/e1nb8slOEcP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSbW1tNGCcBMwDib/MGH9ZMugTE7hmf7YUo0gUwKqWyCX9iiFJuc1gK/F+gqcpUrWb9tMVHf2yUzO3AnfJ0RRoLYEuIPY1dIYM76krWREaAjjWXx9cBsXy/mYJtuM5W/JXhnU0XS+kLP+dkYsCCE9RAfY9qizYqTvSw2zkQH7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sdQ92Wiq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sdQ92Wiq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A953021BB7;
	Wed, 10 Jul 2024 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720609302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ltOTFVyo5Uy/X1RTKFluQ2RUhWSohIyrX25ZCB/KpNE=;
	b=sdQ92WiqNXgpT5tzis+FpuQEk0LBdUw6aNmj4gQ10TlzwkR+qnyOjBEX/qlQOxDBb0iKr1
	vy9lHeVcK9GhczwP+i+OKlemk4D/11MwIJLAG0Gj8b1bXp+gfDKYvUWhZ3Nwcp8UN+RXtt
	ZJrnKD6uclL6CKlyFCscNkDJ3WfcfXo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sdQ92Wiq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720609302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ltOTFVyo5Uy/X1RTKFluQ2RUhWSohIyrX25ZCB/KpNE=;
	b=sdQ92WiqNXgpT5tzis+FpuQEk0LBdUw6aNmj4gQ10TlzwkR+qnyOjBEX/qlQOxDBb0iKr1
	vy9lHeVcK9GhczwP+i+OKlemk4D/11MwIJLAG0Gj8b1bXp+gfDKYvUWhZ3Nwcp8UN+RXtt
	ZJrnKD6uclL6CKlyFCscNkDJ3WfcfXo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28E201369A;
	Wed, 10 Jul 2024 11:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5GKDCBZqjmYbdwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 10 Jul 2024 11:01:42 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH] x86/xen: remove deprecated xen_nopvspin boot parameter
Date: Wed, 10 Jul 2024 13:01:39 +0200
Message-ID: <20240710110139.22300-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[suse.com,lwn.net,oracle.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,kernel.org,gmail.com,lists.xenproject.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A953021BB7
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

The xen_nopvspin boot parameter is deprecated since 2019. nopvspin
can be used instead.

Remove the xen_nopvspin boot parameter and replace the xen_pvspin
variable use cases with nopvspin.

This requires to move the nopvspin variable out of the .initdata
section, as it needs to be accessed for cpuhotplug, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 -----
 arch/x86/xen/spinlock.c                       | 20 +++++--------------
 kernel/locking/qspinlock.c                    |  2 +-
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b33d048e01d8..2074ba03f2e3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7439,11 +7439,6 @@
 			access functions when running as Xen PV guest. The
 			default value is controlled by CONFIG_XEN_PV_MSR_SAFE.
 
-	xen_nopvspin	[X86,XEN,EARLY]
-			Disables the qspinlock slowpath using Xen PV optimizations.
-			This parameter is obsoleted by "nopvspin" parameter, which
-			has equivalent effect for XEN platform.
-
 	xen_nopv	[X86]
 			Disables the PV optimizations forcing the HVM guest to
 			run as generic HVM guest with no PV drivers.
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 5c6fc16e4b92..8e4efe0fb6f9 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -18,7 +18,6 @@
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
 static DEFINE_PER_CPU(atomic_t, xen_qlock_wait_nest);
-static bool xen_pvspin = true;
 
 static void xen_qlock_kick(int cpu)
 {
@@ -68,7 +67,7 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin)
+	if (nopvspin)
 		return;
 
 	WARN(per_cpu(lock_kicker_irq, cpu) >= 0, "spinlock on CPU%d exists on IRQ%d!\n",
@@ -95,7 +94,7 @@ void xen_uninit_lock_cpu(int cpu)
 {
 	int irq;
 
-	if (!xen_pvspin)
+	if (nopvspin)
 		return;
 
 	kfree(per_cpu(irq_name, cpu));
@@ -125,10 +124,10 @@ PV_CALLEE_SAVE_REGS_THUNK(xen_vcpu_stolen);
 void __init xen_init_spinlocks(void)
 {
 	/*  Don't need to use pvqspinlock code if there is only 1 vCPU. */
-	if (num_possible_cpus() == 1 || nopvspin)
-		xen_pvspin = false;
+	if (num_possible_cpus() == 1)
+		nopvspin = true;
 
-	if (!xen_pvspin) {
+	if (nopvspin) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
 		static_branch_disable(&virt_spin_lock_key);
 		return;
@@ -143,12 +142,3 @@ void __init xen_init_spinlocks(void)
 	pv_ops.lock.kick = xen_qlock_kick;
 	pv_ops.lock.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
-
-static __init int xen_parse_nopvspin(char *arg)
-{
-	pr_notice("\"xen_nopvspin\" is deprecated, please use \"nopvspin\" instead\n");
-	xen_pvspin = false;
-	return 0;
-}
-early_param("xen_nopvspin", xen_parse_nopvspin);
-
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 1df5fef8a656..7d96bed718e4 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -583,7 +583,7 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
 #include "qspinlock_paravirt.h"
 #include "qspinlock.c"
 
-bool nopvspin __initdata;
+bool nopvspin;
 static __init int parse_nopvspin(char *arg)
 {
 	nopvspin = true;
-- 
2.43.0


