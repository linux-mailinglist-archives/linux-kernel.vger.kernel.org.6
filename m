Return-Path: <linux-kernel+bounces-247337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290592CE27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC0E1C226DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC418FA09;
	Wed, 10 Jul 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="daUgGD9t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VNjObKCs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54484A5B;
	Wed, 10 Jul 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603678; cv=none; b=HzYH6nwZw1FP9a1gpaU++pXvA+8iC0IBQ94yVfFsj+5vJvmJvkFrNu1Fby4jihKnKJhpCEP3FaEjvJn9S73yEEzd+fmyWL+e981e+T+PCnbeUe/urSnvszfQ3PDZ45hqBjLcIqY3TqAiRVrC9uMjnqQ/GIoYjj4y621VUcz1Btg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603678; c=relaxed/simple;
	bh=VEqA41itZfYP/d964jrgEgto9VD/PxH1g3l/LYZKcGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzDcNWNPs1Ad65N1kzNm21Dob0pg1X4/K1wNnYyOFmdYaIeR3NRxuMU9Lvo03lS0TQcUPipXRpSZdYb+jEd50haQmEdV9zlxSXFWJrXYnz/3IWGUJ5T+HhGeGMeyHX+gqX5TnT04N4BqT8YCdHMhSfUnJAO2NFkIKYwHuYVsKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=daUgGD9t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VNjObKCs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F09E01F824;
	Wed, 10 Jul 2024 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720603674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvkLuMdtx87SaARp851BXKgU7x+Jf7wtc4J0og1cdRI=;
	b=daUgGD9tEMuNPzUgpg/FQZ7RXfLbw7PD673gmBqu0GAQ1EHGap50iw99rOTyB2Jie4ovOP
	alKzOglb8/g5W2QVPudBnakYBl/9ke77Hk0B/q8GWscRpBEpyCdplcnzQFxE/VejuamPlx
	2w/ZUCOLaw3uA94uVi3Ui/7kG6qycpU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VNjObKCs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720603673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvkLuMdtx87SaARp851BXKgU7x+Jf7wtc4J0og1cdRI=;
	b=VNjObKCsO11Do8K01whufQ0VT1CjbyhKjCTvzRHWR/YBxTTNV8YvonFIb04cdBbJ15utIl
	L6F1XDtd3jVpsRltj4cuXAPG6uzOEolcKDAPmX2uU+yGUbZjosV29utrn3VkZX0ZVSqPlf
	PML+I4PQU2pW7x5kLsxihGTa+nzdo5A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F64137D2;
	Wed, 10 Jul 2024 09:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BpvjIhhUjmY+WAAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 10 Jul 2024 09:27:52 +0000
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
	xen-devel@lists.xenproject.org
Subject: [PATCH v2] xen: make multicall debug boot time selectable
Date: Wed, 10 Jul 2024 11:27:49 +0200
Message-ID: <20240710092749.13595-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F09E01F824
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Today Xen multicall debugging needs to be enabled via modifying a
define in a source file for getting debug data of multicall errors
encountered by users.

Switch multicall debugging to depend on a boot parameter "xen_mc_debug"
instead, enabling affected users to boot with the new parameter set in
order to get better diagnostics.

With debugging enabled print the following information in case at least
one of the batched calls failed:
- all calls of the batch with operation, result and caller
- all parameters of each call
- all parameters stored in the multicall data for each call

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- fixed argument printing, added parameter printing
- in debug case print entries without error, too
- rename struct member from debug to entries (Boris Ostrovsky)
- get rid of get_mc_debug_ptr() (Boris Ostrovsky)
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 arch/x86/xen/multicalls.c                     | 125 ++++++++++++++----
 2 files changed, 108 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 27ec49af1bf2..b33d048e01d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7427,6 +7427,12 @@
 			Crash from Xen panic notifier, without executing late
 			panic() code such as dumping handler.
 
+	xen_mc_debug	[X86,XEN,EARLY]
+			Enable multicall debugging when running as a Xen PV guest.
+			Enabling this feature will reduce performance a little
+			bit, so it should only be enabled for obtaining extended
+			debug data in case of multicall errors.
+
 	xen_msr_safe=	[X86,XEN,EARLY]
 			Format: <bool>
 			Select whether to always use non-faulting (safe) MSR
diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
index 07054572297f..a8d699687d5c 100644
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -23,6 +23,8 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/debugfs.h>
+#include <linux/jump_label.h>
+#include <linux/printk.h>
 
 #include <asm/xen/hypercall.h>
 
@@ -31,18 +33,12 @@
 
 #define MC_BATCH	32
 
-#define MC_DEBUG	0
-
 #define MC_ARGS		(MC_BATCH * 16)
 
 
 struct mc_buffer {
 	unsigned mcidx, argidx, cbidx;
 	struct multicall_entry entries[MC_BATCH];
-#if MC_DEBUG
-	struct multicall_entry debug[MC_BATCH];
-	void *caller[MC_BATCH];
-#endif
 	unsigned char args[MC_ARGS];
 	struct callback {
 		void (*fn)(void *);
@@ -50,13 +46,98 @@ struct mc_buffer {
 	} callbacks[MC_BATCH];
 };
 
+struct mc_debug_data {
+	struct multicall_entry entries[MC_BATCH];
+	void *caller[MC_BATCH];
+	size_t argsz[MC_BATCH];
+	unsigned long *args[MC_BATCH];
+};
+
 static DEFINE_PER_CPU(struct mc_buffer, mc_buffer);
+static struct mc_debug_data mc_debug_data_early __initdata;
+static struct mc_debug_data __percpu *mc_debug_data __refdata =
+	&mc_debug_data_early;
 DEFINE_PER_CPU(unsigned long, xen_mc_irq_flags);
 
+static struct static_key mc_debug __ro_after_init;
+static bool mc_debug_enabled __initdata;
+
+static int __init xen_parse_mc_debug(char *arg)
+{
+	mc_debug_enabled = true;
+	static_key_slow_inc(&mc_debug);
+
+	return 0;
+}
+early_param("xen_mc_debug", xen_parse_mc_debug);
+
+static int __init mc_debug_enable(void)
+{
+	struct mc_debug_data __percpu *mcdb;
+	unsigned long flags;
+
+	if (!mc_debug_enabled)
+		return 0;
+
+	mcdb = alloc_percpu(struct mc_debug_data);
+	if (!mcdb) {
+		pr_err("xen_mc_debug inactive\n");
+		static_key_slow_dec(&mc_debug);
+		return -ENOMEM;
+	}
+
+	/* Be careful when switching to percpu debug data. */
+	local_irq_save(flags);
+	xen_mc_flush();
+	mc_debug_data = mcdb;
+	local_irq_restore(flags);
+
+	pr_info("xen_mc_debug active\n");
+
+	return 0;
+}
+early_initcall(mc_debug_enable);
+
+/* Number of parameters of hypercalls used via multicalls. */
+static const uint8_t hpcpars[] = {
+	[__HYPERVISOR_mmu_update] = 4,
+	[__HYPERVISOR_stack_switch] = 2,
+	[__HYPERVISOR_fpu_taskswitch] = 1,
+	[__HYPERVISOR_update_descriptor] = 2,
+	[__HYPERVISOR_update_va_mapping] = 3,
+	[__HYPERVISOR_mmuext_op] = 4,
+};
+
+static void print_debug_data(struct mc_buffer *b, struct mc_debug_data *mcdb,
+			     int idx)
+{
+	unsigned int arg;
+	unsigned int opidx = mcdb->entries[idx].op & 0xff;
+	unsigned int pars = 0;
+
+	pr_err("  call %2d: op=%lu result=%ld caller=%pS ", idx + 1,
+	       mcdb->entries[idx].op, b->entries[idx].result,
+	       mcdb->caller[idx]);
+	if (opidx < ARRAY_SIZE(hpcpars))
+		pars = hpcpars[opidx];
+	if (pars) {
+		pr_cont("pars=");
+		for (arg = 0; arg < pars; arg++)
+			pr_cont("%lx ", mcdb->entries[idx].args[arg]);
+	}
+	if (mcdb->argsz[idx]) {
+		pr_cont("args=");
+		for (arg = 0; arg < mcdb->argsz[idx] / 8; arg++)
+			pr_cont("%lx ", mcdb->args[idx][arg]);
+	}
+	pr_cont("\n");
+}
+
 void xen_mc_flush(void)
 {
 	struct mc_buffer *b = this_cpu_ptr(&mc_buffer);
 	struct multicall_entry *mc;
+	struct mc_debug_data *mcdb = NULL;
 	int ret = 0;
 	unsigned long flags;
 	int i;
@@ -69,10 +150,11 @@ void xen_mc_flush(void)
 
 	trace_xen_mc_flush(b->mcidx, b->argidx, b->cbidx);
 
-#if MC_DEBUG
-	memcpy(b->debug, b->entries,
-	       b->mcidx * sizeof(struct multicall_entry));
-#endif
+	if (static_key_false(&mc_debug)) {
+		mcdb = this_cpu_ptr(mc_debug_data);
+		memcpy(mcdb->entries, b->entries,
+		       b->mcidx * sizeof(struct multicall_entry));
+	}
 
 	switch (b->mcidx) {
 	case 0:
@@ -103,21 +185,14 @@ void xen_mc_flush(void)
 		pr_err("%d of %d multicall(s) failed: cpu %d\n",
 		       ret, b->mcidx, smp_processor_id());
 		for (i = 0; i < b->mcidx; i++) {
-			if (b->entries[i].result < 0) {
-#if MC_DEBUG
-				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\t%pS\n",
-				       i + 1,
-				       b->debug[i].op,
-				       b->debug[i].args[0],
-				       b->entries[i].result,
-				       b->caller[i]);
-#else
+			if (static_key_false(&mc_debug)) {
+				print_debug_data(b, mcdb, i);
+			} else if (b->entries[i].result < 0) {
 				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\n",
 				       i + 1,
 				       b->entries[i].op,
 				       b->entries[i].args[0],
 				       b->entries[i].result);
-#endif
 			}
 		}
 	}
@@ -155,9 +230,13 @@ struct multicall_space __xen_mc_entry(size_t args)
 	}
 
 	ret.mc = &b->entries[b->mcidx];
-#if MC_DEBUG
-	b->caller[b->mcidx] = __builtin_return_address(0);
-#endif
+	if (static_key_false(&mc_debug)) {
+		struct mc_debug_data *mcdb = this_cpu_ptr(mc_debug_data);
+
+		mcdb->caller[b->mcidx] = __builtin_return_address(0);
+		mcdb->argsz[b->mcidx] = args;
+		mcdb->args[b->mcidx] = (unsigned long *)(&b->args[argidx]);
+	}
 	b->mcidx++;
 	ret.args = &b->args[argidx];
 	b->argidx = argidx + args;
-- 
2.43.0


