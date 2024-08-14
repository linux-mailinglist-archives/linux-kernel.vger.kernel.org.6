Return-Path: <linux-kernel+bounces-286133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD01951702
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30DA1C2138C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C31422D3;
	Wed, 14 Aug 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="Tn8BuF/b"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19A139D13
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625561; cv=none; b=F9gwZc082w1jZyDuIBmsY0E2Y1c83OtI1jXbXm+x8aX6LN4RVXPHSnv1EbhlRrq06Q4RzF6qXVUVoBhZh10EanJoUc4rSkAOafFYYnMZEOhDGg2y11xriRkhB40Tan+U20pu+yfwzttYgvH3CVGzaW8CMFiGbtk54QpTumbUylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625561; c=relaxed/simple;
	bh=VtfiUuMXenuWNAXIoZBKbUbOReRzsrPylqGtkuxcw1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZxdoTt+XpEy7JaYG/6zz/nc/rkRcuMUiU+0Gp3pOWKM1oEzaF0C3n6B2Jk9Rc2IuLyM2MAVCTQ1O5/953K8QH0F/QQQXmVIgl2Okw91QrPZYpjTpMactDeoH2lkuEAgmFaIx4l+8xLhJWiHJfsPaCeDqWEYsbVpcs83v6j3IBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=Tn8BuF/b; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 18519 invoked by uid 990); 14 Aug 2024 08:52:35 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 14 Aug 2024 10:52:35 +0200
From: Florian Rommel <mail@florommel.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Daniel Thompson <daniel.thompson@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
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
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Florian Rommel <mail@florommel.de>
Subject: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
Date: Wed, 14 Aug 2024 10:51:41 +0200
Message-ID: <20240814085141.171564-1-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <87wmkkpf5v.ffs@tglx>
References: <87wmkkpf5v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.998549) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.098549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=VtfiUuMXenuWNAXIoZBKbUbOReRzsrPylqGtkuxcw1Y=;
	b=Tn8BuF/bdNtBWz5NzWM5EnbZyVq55TjTiZbVKX+Qn/z6rwj/L4L4le0oDeou83bKlooeoRPiVP
	ad0E779lFp3RCUjI84ZBORu/WdpUBdlAi+1d/OnJnFWWd9+8nEatsWI5q1zqk7BaosiDT3AU9Awc
	MDumtJHMP9oHH8wles6kcn+WIePzb0IJdLIYmpuH0xSFXq1RQqkrVB+t0P2zc9lTWFxuQB7A8wgT
	7VHj9eHIhYnynFhj01B1rU5nkK8ezGNb+QUmymqHaJgHWlSORjyhQSJRTfCEzP0UxDbYZGJxr8jq
	jNwRLR344EZpZ6UVub8wdIC2q7ArxZDJrpByZ1ag35N0wjQ5fCedz2Y/bmUZXbsywSkCcKnwNwF4
	7CwH/LGkDyFOh9RBXPDZUAuBsCm4JN80iADyrsZNasxSFXF60xP0a3u6IjdfsTJ6YEPrkRrM8WoB
	zB8kLFSAVwrcLVKfhD5fmkccUANV9P7NIzt8kZy8+g6lLntsnJoEZJeLsWgnSyaRDVEl0YsT6Xh6
	GamOnUlxqkW9x21l7Q0Yy39FPlvejVSPQQ8v1q+PxSQMS9jSZIV65GW3avBCbNryosKQPpvhzJhV
	EI9vZb++Jti8QpDx2O8IC7f4yAflBRnN/20t1SQkteALAIimyArlDxn4fFnj5ThE5G8imzkQ/gGP
	c=

Experimental implementation of Thomas' trampoline idea.
Link: https://lore.kernel.org/all/87wmkkpf5v.ffs@tglx/

Every breakpoint gets a trampoline entry containing the original
instruction (with a corrected displacement if necessary) and a jump
back into the function to the logically subsequent instruction.
With this, KGDB can skip a still present debug trap for a removed
breakpoint by routing the control flow through the trampoline.

In this experimental implementation, the actual removal of the debug
trap instructions is completely disabled. So, all trap instructions
planted by KGDB currently remain in the code, and KGDB will skip all
these breakpoints through the trampolines when they are in the removed
state. There is not yet a dedicated breakpoint state for the
to-be-removed-but-still-present breakpoints.

Inspect the trampolines via:
(gdb) x/16i kgdb_trampoline_page

Signed-off-by: Florian Rommel <mail@florommel.de>
---
I have been experimenting a bit with Thomas' idea of the trampoline
approach. It seems to work so far but of course has a lot of rough
edges.

I am stuck for now, as I am not sure about the best way to implement
the safe context where KGDB finally removes the int3 instructions.
Maybe, this is useful.. at least it was a fun ride.

 arch/x86/kernel/kgdb.c    | 128 +++++++++++++++++++++++++++++++++-----
 include/linux/kgdb.h      |   2 +
 kernel/debug/debug_core.c |  12 ++++
 3 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..e09090f14894 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -35,6 +35,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
+#include <linux/execmem.h>
 
 #include <asm/text-patching.h>
 #include <asm/debugreg.h>
@@ -42,6 +43,11 @@
 #include <asm/apic.h>
 #include <asm/nmi.h>
 #include <asm/switch_to.h>
+#include <asm/insn.h>
+#include <asm/set_memory.h>
+
+static void *kgdb_trampoline_page;
+static void *kgdb_trampoline_page_curr_slot;
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =
 {
@@ -402,6 +408,60 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
 	}
 }
 
+static int kgdb_init_trampolines(void)
+{
+	/* FIXME: We should reserve enough space for all breakpoints
+	   or make the trampoline table dynamic somehow.. */
+	/* FIXME: Currently borrowing EXECMEM_KPROBES */
+	kgdb_trampoline_page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
+	if (!kgdb_trampoline_page)
+		return 1;
+	memset(kgdb_trampoline_page, INT3_INSN_OPCODE, PAGE_SIZE);
+	set_memory_rox((unsigned long)kgdb_trampoline_page, 1);
+	kgdb_trampoline_page_curr_slot = kgdb_trampoline_page;
+	return 0;
+}
+
+static int kgdb_make_trampoline(struct kgdb_bkpt *bpt, void *orig_insn)
+{
+	void *kernel_addr, *slot_addr, *jmp_addr, *jmp_code;
+	int slot_size;
+	struct insn insn;
+	u8 insn_buff[MAX_INSN_SIZE + JMP32_INSN_SIZE];
+
+	if (WARN_ON(insn_decode_kernel(&insn, orig_insn)))
+		return -EINVAL;
+
+	slot_size = insn.length + JMP32_INSN_SIZE;
+
+	if (!bpt->trampoline) {
+		/* FIXME: Not enough space for all possible breakpoints */
+		if (kgdb_trampoline_page_curr_slot + slot_size
+		    > kgdb_trampoline_page + PAGE_SIZE)
+			return -ENOSPC;
+
+		bpt->trampoline = kgdb_trampoline_page_curr_slot;
+		kgdb_trampoline_page_curr_slot += slot_size;
+	}
+
+	kernel_addr = (void *)bpt->bpt_addr;
+	slot_addr = bpt->trampoline;
+	jmp_addr = slot_addr + insn.length;
+	jmp_code = text_gen_insn(JMP32_INSN_OPCODE, jmp_addr,
+				 kernel_addr + insn.length);
+
+	memcpy(insn_buff, kernel_addr, insn.length);
+	memcpy(insn_buff + insn.length, jmp_code, JMP32_INSN_SIZE);
+	apply_relocation(insn_buff, slot_addr, insn.length,
+			 kernel_addr, insn.length);
+
+	if (mutex_is_locked(&text_mutex))
+		return -EBUSY;
+	text_poke_kgdb(slot_addr, insn_buff, insn.length + JMP32_INSN_SIZE);
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
@@ -598,6 +658,10 @@ int kgdb_arch_init(void)
 {
 	int retval;
 
+	retval = kgdb_init_trampolines();
+	if (retval)
+		goto out;
+
 	retval = register_die_notifier(&kgdb_notifier);
 	if (retval)
 		goto out;
@@ -708,11 +772,18 @@ void kgdb_arch_exit(void)
  */
 int kgdb_skipexception(int exception, struct pt_regs *regs)
 {
-	if (exception == 3 && kgdb_isremovedbreak(regs->ip - 1)) {
-		regs->ip -= 1;
-		return 1;
+	struct kgdb_bkpt *bp;
+
+	if (exception != 3)
+		return false;
+
+	bp = kgdb_get_removedbreak(regs->ip - 1);
+	if (bp) {
+		regs->ip = (unsigned long)bp->trampoline;
+		return true;
 	}
-	return 0;
+
+	return false;
 }
 
 unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs)
@@ -730,12 +801,33 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
+	char orig_insn[MAX_INSN_SIZE];
 
 	bpt->type = BP_BREAKPOINT;
-	err = copy_from_kernel_nofault(bpt->saved_instr, (char *)bpt->bpt_addr,
-				BREAK_INSTR_SIZE);
+
+	/*
+	 * FIXME: Currently, debug traps are not removed, so all logically
+	 * removed breakpoints are still there.
+	 * For now, abort if the trampoline is already present.
+	 * Later, we should use a dedicated breakpoint state to signal this.
+	 */
+	if (bpt->trampoline) {
+		bpt->type = BP_POKE_BREAKPOINT;
+		return 0;
+	}
+
+	/* FIXME: What if we cannot read all of MAX_INSN_SIZE */
+	err = copy_from_kernel_nofault(orig_insn, (char *)bpt->bpt_addr,
+				       MAX_INSN_SIZE);
 	if (err)
 		return err;
+
+	memcpy(bpt->saved_instr, orig_insn, BREAK_INSTR_SIZE);
+
+	err = kgdb_make_trampoline(bpt, orig_insn);
+	if (err)
+		return err;
+
 	err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
 				 arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE);
 	if (!err)
@@ -755,16 +847,11 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
+	/* FIXME: Do not mess with early breakpoints for now */
 	if (bpt->type != BP_POKE_BREAKPOINT)
 		goto knl_write;
-	/*
-	 * It is safe to call text_poke_kgdb() because normal kernel execution
-	 * is stopped on all cores, so long as the text_mutex is not locked.
-	 */
-	if (mutex_is_locked(&text_mutex))
-		goto knl_write;
-	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
-		       BREAK_INSTR_SIZE);
+
+	/* FIXME: Removal is not necessary anymore.. for now */
 	return 0;
 
 knl_write:
@@ -772,6 +859,19 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
 }
 
+int kgdb_validate_break_address(unsigned long addr)
+{
+	if (kgdb_within_blocklist(addr))
+		return -EINVAL;
+
+	/*
+	 * With breakpoint trampolines, there is no need to further validate
+	 * setting and removal of breakpoints.
+	 */
+
+	return 0;
+}
+
 const struct kgdb_arch arch_kgdb_ops = {
 	/* Breakpoint instruction: */
 	.gdb_bpt_instr		= { 0xcc },
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 76e891ee9e37..19c2d8ee8124 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -79,6 +79,7 @@ struct kgdb_bkpt {
 	unsigned char		saved_instr[BREAK_INSTR_SIZE];
 	enum kgdb_bptype	type;
 	enum kgdb_bpstate	state;
+	void			*trampoline;
 };
 
 struct dbg_reg_def_t {
@@ -324,6 +325,7 @@ extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
 extern char *kgdb_mem2hex(char *mem, char *buf, int count);
 extern int kgdb_hex2mem(char *buf, char *mem, int count);
 
+extern struct kgdb_bkpt *kgdb_get_removedbreak(unsigned long addr);
 extern int kgdb_isremovedbreak(unsigned long addr);
 extern int kgdb_has_hit_break(unsigned long addr);
 
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index ce1bb2301c06..60bc63d1000a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -393,6 +393,18 @@ int dbg_remove_sw_break(unsigned long addr)
 	return -ENOENT;
 }
 
+struct kgdb_bkpt *kgdb_get_removedbreak(unsigned long addr)
+{
+	int i;
+
+	for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
+		if ((kgdb_break[i].state == BP_REMOVED) &&
+		    (kgdb_break[i].bpt_addr == addr))
+			return &kgdb_break[i];
+	}
+	return NULL;
+}
+
 int kgdb_isremovedbreak(unsigned long addr)
 {
 	int i;
-- 
2.46.0


