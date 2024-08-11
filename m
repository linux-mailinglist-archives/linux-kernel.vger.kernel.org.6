Return-Path: <linux-kernel+bounces-282431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041994E3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4761F21DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75427166F3C;
	Sun, 11 Aug 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="v5FoRuiJ"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81243163A9B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418979; cv=none; b=Blm76YrPDCaCwYCmoBgHGvj32+UvqEX9lZwC6JEVQgrWgrYgIFfrbYWlFTz8YudoBDGvF5cfgIFL/dCkm7v0diwi/LdwJJYFZoPt+ELSMP7jZ+za3E7taSU0QiB50T8aIT6nbbQ4i675vXSDd/V1qkMMOgaMTVb0hgneau/Ivo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418979; c=relaxed/simple;
	bh=38KwpPi1+krdaAaOQLyfVYfixCNAVPls5Br2PNVF+HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbVWnqdqW3TPdM7o9VWribaj06XtWBLOwKMlPT3+AresNSefv8ofcvGyYVSBdDPqXN37jmPkSGjmhSW7+ehsenPkQLjfUNTliDN9WunpFF+Oii22ui4MKmwyWwBS4DawG2A06NODOwDjAz2LVZvOqWN5qOB+AynCmxQZsJGU+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=v5FoRuiJ; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 9061 invoked by uid 990); 11 Aug 2024 23:22:54 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Aug 2024 01:22:54 +0200
From: Florian Rommel <mail@florommel.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: [PATCH 1/2] x86/kgdb: convert early breakpoints to poke breakpoints
Date: Mon, 12 Aug 2024 01:22:07 +0200
Message-ID: <20240811232208.234261-2-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240811232208.234261-1-mail@florommel.de>
References: <20240811232208.234261-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) BAYES_HAM(-2.999844) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=38KwpPi1+krdaAaOQLyfVYfixCNAVPls5Br2PNVF+HA=;
	b=v5FoRuiJxqJNSvjLIq8pQWukOpRs4IAkkhdvEjSJy3z3k55rr+fZGadcyRfo0f3PHouo50SrxL
	r4cCknCxCHfeLA5/T5/aetabNgUvURg8PUmKXCdZTjsEv9q/39GIBfMi0h99/QCV+ZRHqfLC6NY5
	IG1IALNUbvA8GG6g1G5Cq9BvSLvwJbFmXLKVaWrNph931tKbM1S7KFvK3v67hthnHg2DodR0KR/F
	lwyDmv2QEeZaL3O9BYKScJYRq/009ZPpK782pz4G/XAT005pTEzos6RCnA14CEjap9OhDFBixfYu
	l7UCFiP08a8dTt8vbpYIyFs2ViexWtxaHMUbnF+sbm1Bpx4XNq77VRkj2iXBrevAggI+rGpsbXgI
	RCNonZMrZi4hSofKZvlPJnwgLwEWgtL1RxwwhGbZ0nhS0x/HwrUeAbCGRtjO6mrz3MCd6hY7Y59j
	rFXKRehUVk7Tc4U+Z+d4B8RlD7DOabH1qvvdpYrKFZPddKCCNdsSD5MeDi8/3VdIkAf+wFEp/GdW
	dARDuoBgnqnHWUDoPbRmFF5f5y+xbj6R2gs89ReVUZk6TrsbUJjeTcA10iKEoxPDEG9h4FB9Bwtb
	x909/13uj+ppKzDqFN08XduTu0zfO+eX43uo1bFvYW2cI7LQTY0Kcgns3TESSr9aMLtA2aQbdwWs
	8=

On x86, after booting, the kernel text is read-only.  Then, KGDB has to
use the text_poke mechanism to install software breakpoints.  KGDB
uses a special (x86-specific) breakpoint type for these kinds of
breakpoints (BP_POKE_BREAKPOINT).  When removing a breakpoint, KGDB
always adheres to the breakpoint's original installment method, which is
determined by its type.

Before this fix, early (non-"poke") breakpoints could not be removed
after the kernel text was set as read-only since the original code
patching mechanism was no longer allowed to remove the breakpoints.
Eventually, this even caused the kernel to hang (loop between int3
instruction and the function kgdb_skipexception).

With this patch, we convert early breakpoints to "poke" breakpoints
after the kernel text has been made read-only.  This makes them
removable later.

Signed-off-by: Florian Rommel <mail@florommel.de>
---
A patch for this problem has already been proposed by Stefan Saecherl
and Lorena Kretzschmar [1].  Their solution is different from the one
I suggest here (it fixes the problem on removal, not "in advance").
Unfortunately, Lorena and Stefan's patch has not been accepted / the
conversation has fallen asleep.  One point of criticism concerned
possible problems with reused init code pages.  This should not be a
problem with my patch.
[1] https://lore.kernel.org/all/20201214141314.5717-1-stefan.saecherl@fau.de/

 arch/x86/kernel/kgdb.c    | 14 ++++++++++++++
 include/linux/kgdb.h      |  3 +++
 init/main.c               |  1 +
 kernel/debug/debug_core.c |  7 ++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..64c332151af7 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -623,6 +623,20 @@ int kgdb_arch_init(void)
 	return retval;
 }
 
+void kgdb_after_mark_readonly(void)
+{
+	int i;
+
+	/* Convert all breakpoints in rodata to BP_POKE_BREAKPOINT. */
+	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
+		if (kgdb_break[i].state != BP_UNDEFINED &&
+		    kgdb_break[i].type == BP_BREAKPOINT &&
+		    is_kernel_text(kgdb_break[i].bpt_addr)) {
+			kgdb_break[i].type = BP_POKE_BREAKPOINT;
+		}
+	}
+}
+
 static void kgdb_hw_overflow_handler(struct perf_event *event,
 		struct perf_sample_data *data, struct pt_regs *regs)
 {
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 76e891ee9e37..c07855d388b5 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -98,6 +98,8 @@ extern int dbg_set_reg(int regno, void *mem, struct pt_regs *regs);
 # define KGDB_MAX_BREAKPOINTS	1000
 #endif
 
+extern struct kgdb_bkpt kgdb_break[KGDB_MAX_BREAKPOINTS];
+
 #define KGDB_HW_BREAKPOINT	1
 
 /*
@@ -360,6 +362,7 @@ extern bool dbg_is_early;
 extern void __init dbg_late_init(void);
 extern void kgdb_panic(const char *msg);
 extern void kgdb_free_init_mem(void);
+extern void kgdb_after_mark_readonly(void);
 #else /* ! CONFIG_KGDB */
 #define in_dbg_master() (0)
 #define dbg_late_init()
diff --git a/init/main.c b/init/main.c
index 206acdde51f5..33b6e092fed3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1441,6 +1441,7 @@ static void mark_readonly(void)
 		mark_rodata_ro();
 		debug_checkwx();
 		rodata_test();
+		kgdb_after_mark_readonly();
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
 		pr_info("Kernel memory protection disabled.\n");
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_STRICT_KERNEL_RWX)) {
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index ce1bb2301c06..9dd6b69f1679 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -98,7 +98,7 @@ module_param(kgdbreboot, int, 0644);
  * Holds information about breakpoints in a kernel. These breakpoints are
  * added and removed by gdb.
  */
-static struct kgdb_bkpt		kgdb_break[KGDB_MAX_BREAKPOINTS] = {
+struct kgdb_bkpt		kgdb_break[KGDB_MAX_BREAKPOINTS] = {
 	[0 ... KGDB_MAX_BREAKPOINTS-1] = { .state = BP_UNDEFINED }
 };
 
@@ -452,6 +452,11 @@ void kgdb_free_init_mem(void)
 	}
 }
 
+void __weak kgdb_after_mark_readonly(void)
+{
+	/* Weak implementation, may be overridden by arch code */
+}
+
 #ifdef CONFIG_KGDB_KDB
 void kdb_dump_stack_on_cpu(int cpu)
 {
-- 
2.46.0


