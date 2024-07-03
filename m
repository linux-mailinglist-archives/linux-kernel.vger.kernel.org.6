Return-Path: <linux-kernel+bounces-239405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D65925FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F355B2B3D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731D171E60;
	Wed,  3 Jul 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pTQzAAcD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kr3j+wlE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC2137910;
	Wed,  3 Jul 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007786; cv=none; b=F86ZfjOTMYxpi03xI/I9aEHDAzythHgz1alUI6qJK60HrlultUB/5l88/huxAAa5xaF8jweG6MFHQuTOLFp83oJU5pRh5z877KsLQwrys31FQB6/6bOsoEguBJvlNa17OEYS6JJyxlpqeAzTSIPuWN6/3hG5tLE+hrh/s4+sy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007786; c=relaxed/simple;
	bh=F0WVTVTfWLcxzvi2Uj1O1lUjL6ujJxPJi8QDJYpvoIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fVDqbPeZVi+ZWXP1+bEf/rFDV0g9pnpqEpvRhOJ99UH8eFmvF5vOlx5/vbyw273mzuzGvFUgAyYjxC2ATwogADKoxlCfJx3lIQuMoo0ehOic9IIXOiowSHtcY7EH5vUgp9BNU8K5/hCnuoNNAWkGqGDA3z2oRU5Q12vDdLqHAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pTQzAAcD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kr3j+wlE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF0AD21BBA;
	Wed,  3 Jul 2024 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720007783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XzAsO4d1d00dRfQB1nR62M6eaIXlE3bQZcqYbGriBsU=;
	b=pTQzAAcDqJmole7r5v4jQwXVeryo/tA+4yahr8+LZeJKq92VIczvqcR4lYyept6nG6F0lI
	Yw1uVagsZEAwIs5o81m7zCPE3xXMvNIwNPMoHzV53/vGS9pwD1l5UUspEGdWHoNfH/yFjE
	djQY6ETiNJmhdqrLUniSW6PwTDCrmkk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Kr3j+wlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720007782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XzAsO4d1d00dRfQB1nR62M6eaIXlE3bQZcqYbGriBsU=;
	b=Kr3j+wlE/+h4wDKMXy1ATwP3RAF2pXLjM6KGxWF76GHX2hAEZL6sRt3OX1hXS56Sjpcu29
	dCg7CL686RjZX9Ru6p9TCp5oaBz+YLuuNGCfv5WRCyOVGa4SyAfJI7ne6SrSyK2S5xdqkL
	8nHe7UhQdvW9Ii/buZXo1O5djP8Mge8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DB5013974;
	Wed,  3 Jul 2024 11:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F36yGGY8hWYhDwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 03 Jul 2024 11:56:22 +0000
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
Subject: [PATCH] xen: make multicall debug boot time selectable
Date: Wed,  3 Jul 2024 13:56:20 +0200
Message-Id: <20240703115620.25772-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CF0AD21BBA
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Today Xen multicall debugging needs to be enabled via modifying a
define in a source file for getting debug data of multicall errors
encountered by users.

Switch multicall debugging to depend on a boot parameter "xen_mc_debug"
instead, enabling affected users to boot with the new parameter set in
order to get better diagnostics.

Add printing all arguments of a single call for better diagnostics.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 arch/x86/xen/multicalls.c                     | 120 ++++++++++++++----
 2 files changed, 99 insertions(+), 27 deletions(-)

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
index 07054572297f..abea216f07f4 100644
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
@@ -50,13 +46,84 @@ struct mc_buffer {
 	} callbacks[MC_BATCH];
 };
 
+struct mc_debug_data {
+	struct multicall_entry debug[MC_BATCH];
+	void *caller[MC_BATCH];
+	size_t argsz[MC_BATCH];
+};
+
 static DEFINE_PER_CPU(struct mc_buffer, mc_buffer);
+static struct mc_debug_data __percpu *mc_debug_data;
+static struct mc_debug_data mc_debug_data_early __initdata;
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
+static void print_debug_data(struct mc_buffer *b, struct mc_debug_data *mcdb,
+			     int idx)
+{
+	unsigned int arg;
+
+	pr_err("  call %2d: op=%lu result=%ld caller=%pS", idx + 1,
+	       mcdb->debug[idx].op, b->entries[idx].result, mcdb->caller[idx]);
+	if (mcdb->argsz[idx]) {
+		pr_cont(" args=");
+		for (arg = 0; arg < mcdb->argsz[idx] / 8; arg++)
+			pr_cont("%lx ", mcdb->debug[idx].args[arg]);
+	}
+	pr_cont("\n");
+}
+
+static struct mc_debug_data * __ref get_mc_debug_ptr(void)
+{
+	if (likely(mc_debug_data))
+		return this_cpu_ptr(mc_debug_data);
+
+	return &mc_debug_data_early;
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
@@ -69,10 +136,11 @@ void xen_mc_flush(void)
 
 	trace_xen_mc_flush(b->mcidx, b->argidx, b->cbidx);
 
-#if MC_DEBUG
-	memcpy(b->debug, b->entries,
-	       b->mcidx * sizeof(struct multicall_entry));
-#endif
+	if (static_key_false(&mc_debug)) {
+		mcdb = get_mc_debug_ptr();
+		memcpy(mcdb->debug, b->entries,
+		       b->mcidx * sizeof(struct multicall_entry));
+	}
 
 	switch (b->mcidx) {
 	case 0:
@@ -104,20 +172,15 @@ void xen_mc_flush(void)
 		       ret, b->mcidx, smp_processor_id());
 		for (i = 0; i < b->mcidx; i++) {
 			if (b->entries[i].result < 0) {
-#if MC_DEBUG
-				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\t%pS\n",
-				       i + 1,
-				       b->debug[i].op,
-				       b->debug[i].args[0],
-				       b->entries[i].result,
-				       b->caller[i]);
-#else
-				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\n",
-				       i + 1,
-				       b->entries[i].op,
-				       b->entries[i].args[0],
-				       b->entries[i].result);
-#endif
+				if (static_key_false(&mc_debug)) {
+					print_debug_data(b, mcdb, i);
+				} else {
+					pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\n",
+					       i + 1,
+					       b->entries[i].op,
+					       b->entries[i].args[0],
+					       b->entries[i].result);
+				}
 			}
 		}
 	}
@@ -155,9 +218,12 @@ struct multicall_space __xen_mc_entry(size_t args)
 	}
 
 	ret.mc = &b->entries[b->mcidx];
-#if MC_DEBUG
-	b->caller[b->mcidx] = __builtin_return_address(0);
-#endif
+	if (static_key_false(&mc_debug)) {
+		struct mc_debug_data *mcdb = get_mc_debug_ptr();
+
+		mcdb->caller[b->mcidx] = __builtin_return_address(0);
+		mcdb->argsz[b->mcidx] = args;
+	}
 	b->mcidx++;
 	ret.args = &b->args[argidx];
 	b->argidx = argidx + args;
-- 
2.35.3


