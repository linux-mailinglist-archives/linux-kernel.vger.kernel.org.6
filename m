Return-Path: <linux-kernel+bounces-256031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441339347F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AA01C21908
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC25FB8A;
	Thu, 18 Jul 2024 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HKjJ0PhF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HKjJ0PhF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D053362
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283667; cv=none; b=Y0fM9rMJjzOokLICc286xilHcaR8GB9W0hcqKxTbLcAnx2g0uEjSqarkSBhjUrRGjNJGtF6btNxZ9c56Q4bmv7hI2g7Hyy68YBsOGRBIbZkaLX4FiMoMVTAkXf8DY/PPAVfz8BzAisewPNZfV4VWKpQhg58g/ALcNONnpmHTEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283667; c=relaxed/simple;
	bh=gGz0l902kfEVcR8MSaMwvHy2BXLgkgxvSdDHDf31CXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBfPWsLFAPYyxYz6DJjI6FAxyDh87GMq3upl/sRvnkZmXEbqTjoHHjC9u2HVxr3ckvVBObfvwNhs4+P0qJLVbK9QSCcyb3cOm6IUw7LEyamZsiO46/Qjsk5K9jzTk1YfNdgxY0475Sgi5NbSmIDsaxm/F+b1kjTDYWjI45TCpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HKjJ0PhF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HKjJ0PhF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5AEB21AE6;
	Thu, 18 Jul 2024 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721283663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IZsuj30RepdbHrRngKm0/gc+colbM4Uy/bJMOVwbzVI=;
	b=HKjJ0PhFREtjhT54kYs6YZhvcuxQfuFZI1CmUcE/tBMB04/RA3QGLiDbv+Q/kHOSiquq5b
	Q2JgR8CjOKtKSW74OyCobBlkm+CmKis8gr8JJs6CiLH+2KRplb5DMPLOVkUD4I8gCFmyK7
	yl3xy1+oCYqtccoT5uO4Um5yCAJfews=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721283663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IZsuj30RepdbHrRngKm0/gc+colbM4Uy/bJMOVwbzVI=;
	b=HKjJ0PhFREtjhT54kYs6YZhvcuxQfuFZI1CmUcE/tBMB04/RA3QGLiDbv+Q/kHOSiquq5b
	Q2JgR8CjOKtKSW74OyCobBlkm+CmKis8gr8JJs6CiLH+2KRplb5DMPLOVkUD4I8gCFmyK7
	yl3xy1+oCYqtccoT5uO4Um5yCAJfews=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D4CA1379D;
	Thu, 18 Jul 2024 06:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LnNfEU+0mGaGfAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 18 Jul 2024 06:21:03 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] xen: fix multicall debug data referencing
Date: Thu, 18 Jul 2024 08:21:00 +0200
Message-ID: <20240718062100.5357-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The recent adding of multicall debug mixed up the referencing of
the debug data. A __percpu tagged pointer can't be initialized with a
plain pointer, so use another percpu variable for the pointer and set
it on each new cpu via a function.

Fixes: 942d917cb92a ("xen: make multicall debug boot time selectable")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407151106.5s7Mnfpz-lkp@intel.com/
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/multicalls.c | 19 ++++++++++++-------
 arch/x86/xen/smp_pv.c     |  1 +
 arch/x86/xen/xen-ops.h    |  3 +++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
index d4cefd8a9af4..10c660fae8b3 100644
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -54,8 +54,9 @@ struct mc_debug_data {
 
 static DEFINE_PER_CPU(struct mc_buffer, mc_buffer);
 static struct mc_debug_data mc_debug_data_early __initdata;
-static struct mc_debug_data __percpu *mc_debug_data __refdata =
+static DEFINE_PER_CPU(struct mc_debug_data *, mc_debug_data) =
 	&mc_debug_data_early;
+static struct mc_debug_data __percpu *mc_debug_data_ptr;
 DEFINE_PER_CPU(unsigned long, xen_mc_irq_flags);
 
 static struct static_key mc_debug __ro_after_init;
@@ -70,16 +71,20 @@ static int __init xen_parse_mc_debug(char *arg)
 }
 early_param("xen_mc_debug", xen_parse_mc_debug);
 
+void mc_percpu_init(unsigned int cpu)
+{
+	per_cpu(mc_debug_data, cpu) = per_cpu_ptr(mc_debug_data_ptr, cpu);
+}
+
 static int __init mc_debug_enable(void)
 {
-	struct mc_debug_data __percpu *mcdb;
 	unsigned long flags;
 
 	if (!mc_debug_enabled)
 		return 0;
 
-	mcdb = alloc_percpu(struct mc_debug_data);
-	if (!mcdb) {
+	mc_debug_data_ptr = alloc_percpu(struct mc_debug_data);
+	if (!mc_debug_data_ptr) {
 		pr_err("xen_mc_debug inactive\n");
 		static_key_slow_dec(&mc_debug);
 		return -ENOMEM;
@@ -88,7 +93,7 @@ static int __init mc_debug_enable(void)
 	/* Be careful when switching to percpu debug data. */
 	local_irq_save(flags);
 	xen_mc_flush();
-	mc_debug_data = mcdb;
+	mc_percpu_init(0);
 	local_irq_restore(flags);
 
 	pr_info("xen_mc_debug active\n");
@@ -150,7 +155,7 @@ void xen_mc_flush(void)
 	trace_xen_mc_flush(b->mcidx, b->argidx, b->cbidx);
 
 	if (static_key_false(&mc_debug)) {
-		mcdb = this_cpu_ptr(mc_debug_data);
+		mcdb = __this_cpu_read(mc_debug_data);
 		memcpy(mcdb->entries, b->entries,
 		       b->mcidx * sizeof(struct multicall_entry));
 	}
@@ -230,7 +235,7 @@ struct multicall_space __xen_mc_entry(size_t args)
 
 	ret.mc = &b->entries[b->mcidx];
 	if (static_key_false(&mc_debug)) {
-		struct mc_debug_data *mcdb = this_cpu_ptr(mc_debug_data);
+		struct mc_debug_data *mcdb = __this_cpu_read(mc_debug_data);
 
 		mcdb->caller[b->mcidx] = __builtin_return_address(0);
 		mcdb->argsz[b->mcidx] = args;
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 7ea57f728b89..6863d3da7dec 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -305,6 +305,7 @@ static int xen_pv_kick_ap(unsigned int cpu, struct task_struct *idle)
 		return rc;
 
 	xen_pmu_init(cpu);
+	mc_percpu_init(cpu);
 
 	/*
 	 * Why is this a BUG? If the hypercall fails then everything can be
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index e7775dff9452..0cf16fc79e0b 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -257,6 +257,9 @@ void xen_mc_callback(void (*fn)(void *), void *data);
  */
 struct multicall_space xen_mc_extend_args(unsigned long op, size_t arg_size);
 
+/* Do percpu data initialization for multicalls. */
+void mc_percpu_init(unsigned int cpu);
+
 extern bool is_xen_pmu;
 
 irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id);
-- 
2.43.0


