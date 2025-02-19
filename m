Return-Path: <linux-kernel+bounces-521522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2635A3BE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBDF1895F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDAF1E0489;
	Wed, 19 Feb 2025 12:46:21 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8C1A28D;
	Wed, 19 Feb 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969180; cv=none; b=XaREMKuE3bFE3Wq5SQOkqTGFqHb9flwo1U8E6DFQjmoFl1R+7HRTgHN+1esyY5nSXJJak+iOVKqaw2xPUS+6ubq3wtUHgpRb5Vtp3O5okuS+zGlemWpSJscszUQ8udvawf5SFdwNCvVq8QKrxyvwuoDM5mkvKLpJ3wPfHFq7PVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969180; c=relaxed/simple;
	bh=fVwBG3Xva3bKUeKJhEl0OyuOLo2jA+4vhSFxu2M8Wlw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=pEd0QmcRCIzA+wQU0fb4gc8s1clMTbZVvYfDJdFcviYxnxRnRCYf/cZ/UgByd/XJuEu0rFF+7XFeqqKAbn7vzwstlUHiM2ecsNgz2iSbmriHPD9Ypx8RnxyKUi/XSu0GKP9cf0SnrTdFqlVBU9cx5OgUYKmO1FOAIz018xtVAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6397B92009C; Wed, 19 Feb 2025 13:46:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5F98E92009B;
	Wed, 19 Feb 2025 12:46:07 +0000 (GMT)
Date: Wed, 19 Feb 2025 12:46:07 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@unseen.parts>, Matt Turner <mattst88@gmail.com>
cc: Arnd Bergmann <arnd@arndb.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data consistency
Message-ID: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Complementing compiler support for the `-msafe-bwa' and `-msafe-partial' 
code generation options slated to land in GCC 15, implement emulation 
for unaligned LDx_L and STx_C operations for the unlikely case where an 
alignment violation has resulted from improperly written code and caused 
these operations to trap in atomic RMW memory access sequences made to 
provide data consistency for non-BWX byte and word write operations, and 
writes to unaligned data objects causing partial memory updates.

The principle of operation is as follows:

1. A trapping unaligned LDx_L operation results in the pair of adjacent 
   aligned whole data quantities spanned being read and stored for the 
   reference with a subsequent STx_C operation, along with the width of 
   the data accessed and its virtual address, and the task referring or 
   NULL if the kernel.  The valitidy marker is set.

2. Regular memory load operations are used to retrieve data because no 
   atomicity is needed at this stage, and matching the width accessed, 
   either LDQ_U or LDL even though the latter instruction requires extra 
   operations, to avoid the case where an unaligned longword located 
   entirely within an aligned quadword would complicate handling.

3. Data is masked, shifted and merged appropriately and returned in the
   intended register as the result of the trapping LDx_L instruction.

4. A trapping unaligned STx_C operation results in the valitidy marker 
   being checked for being true, and the width of the data accessed 
   along with the virtual address and the task referring or the kernel 
   for a match.  The pair of whole data quantities previously read by 
   LDx_L emulation is retrieved and the valitidy marker is cleared.

5. If the checks succeeded, then in an atomic loop the location of the 
   first whole data quantity is reread, and data retrieved compared with 
   the value previously obtained.  If there's no match, then the loop is 
   aborted and 0 is returned in the intended register as the result of 
   the trapping STx_C instruction and emulation completes.  Otherwise 
   new data obtained from the source operand of STx_C is combined with 
   the data retrieved, replacing by byte insertion the part intended, 
   and an atomic write of this new data is attempted.  If it fails, the 
   loop continues from the beginning.  Otherwise processing proceeds to 
   the next step.

6. The same operations are performed on the second whole data quantity.

7. At this point both whole data quantities have been written, ensuring 
   that no third-party intervening write has changed them at the point 
   of the write from the values held at previous LDx_L.  Therefore 1 is 
   returned in the intended register as the result of the trapping STx_C 
   instruction.

8. No user accesses are permitted in traps from the kernel mode as the
   only LDx_L/STx_C accesses made to user memory locations by the kernel 
   are supposed to be those from handcrafted code, which has to written 
   such as not to trap.

Since atomic loops are used for data updates the approach works equally 
well in both UP and SMP environments.  No data atomicity is guaranteed, 
but data consistency is, that is concurrent RMW accesses won't clobber 
each other, however if the same data is concurrently written as already 
there with a regular write between emulated LDx_L and STx_C, then STx_C 
will still succeed.  Likewise if data is modified, but then restored 
before STx_C has had a chance to run.

This fulfils consistency requirements and guarantees that data outside 
the quantity written has not changed between emulated LDx_L and STx_C.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 This has cleared the pair of `-msafe-bwa -msafe-partial' regressions 
observed in GCC verification (the third one was a Modula 2 frontend bug, 
now fixed in the compiler).  I have verified individual misalignments with 
a small program by hand as well, for both the data retrieved by emulated 
LDx_L and the data stored by emulated STx_C.

 The kernel itself built with `-mcpu=ev4 -msafe-bwa -msafe-partial' boots 
and has passed GCC verification, and triggered no extra unaligned traps.

 Full verification was run with 6.3.0-rc5 and Ivan's stack alignment fixes 
applied just because I was confident already that version works correctly.  
Interestingly enough no kernel mode traps have triggered with a kernel 
built with GCC 12 (and with most user traps coming from GCC verification):

kernel unaligned acc	: 0 (pc=0,va=0)
user unaligned acc	: 1766720 (pc=20000053064,va=120020189)

but with GCC 15 a small quantity happened (even before I ran GCC testing):

kernel unaligned acc    : 78 (pc=fffffc0000ad5194,va=fffffc0002db5784)
user unaligned acc      : 883452 (pc=20000053064,va=120020189)

It seems a compiler regression worth checking -- the trap recorded was in 
`icmp6_dst_alloc' with a pair of quadword writes to `rt->rt6i_dst.addr', 
which however by its type (`struct in6_addr') is only longword-aligned and 
indeed starts at offset 148 from the outermost struct.  I have a sneaking 
suspicion one of my earlier GCC changes might be at fault.  At least I now 
have a test case to experiment with.

 I've also built and booted 6.9.0-rc3 as at commit 82c525bfafb4 ("alpha: 
trim the unused stuff from asm-offsets.c"), the last one before support 
for my system was axed.  It has passed the verification with my small 
program (available by request; I'm not sure if it's worth turning into a 
kernel selftest).

 NB I'm going to ignore the 72 errors checkpatch.pl issues for EXC usage.  
The coding style of the new additions is consistent with the rest of the 
file and any change to that would best be made separately (but I fail to 
see the point).

 Questions, comments, concerns?  Otherwise please apply, and I'll proceed 
with the rest of the GCC effort, followed by cleaning handwritten assembly 
up that uses STQ_U in our port and in glibc.

  Maciej
---
 arch/alpha/kernel/traps.c |  409 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 400 insertions(+), 9 deletions(-)

linux-alpha-llsc-unaligned.diff
Index: linux-macro/arch/alpha/kernel/traps.c
===================================================================
--- linux-macro.orig/arch/alpha/kernel/traps.c
+++ linux-macro/arch/alpha/kernel/traps.c
@@ -368,6 +368,13 @@ struct unaligned_stat {
 	unsigned long count, va, pc;
 } unaligned[2];
 
+/* Unaligned LDx_L/STx_C emulation state.  */
+static DEFINE_RAW_SPINLOCK(ll_lock);
+static struct task_struct *ll_task;
+static unsigned long ll_data[2];
+static unsigned long ll_va;
+static bool ll_quad;
+static bool ll_bit;
 
 /* Macro for exception fixup code to access integer registers.  */
 #define una_reg(r)  (_regs[(r) >= 16 && (r) <= 18 ? (r)+19 : (r)])
@@ -381,6 +388,9 @@ do_entUna(void * va, unsigned long opcod
 	unsigned long pc = regs->pc - 4;
 	unsigned long *_regs = regs->regs;
 	const struct exception_table_entry *fixup;
+	unsigned long flags;
+	unsigned long la;
+	bool ll_match;
 
 	unaligned[0].count++;
 	unaligned[0].va = (unsigned long) va;
@@ -439,6 +449,65 @@ do_entUna(void * va, unsigned long opcod
 		una_reg(reg) = tmp1|tmp2;
 		return;
 
+	case 0x2a: /* ldl_l */
+		la = (unsigned long)va;
+		if (la < TASK_SIZE)
+			break;
+		__asm__ __volatile__(
+		"1:	ldl %3,0(%5)\n"
+		"2:	ldl %4,4(%5)\n"
+		"	srl %3,%6,%1\n"
+		"	sll %4,%7,%2\n"
+		"	zapnot %1,15,%1\n"
+		"	zapnot %2,15,%2\n"
+		"3:\n"
+		EXC(1b,3b,%1,%0)
+		EXC(2b,3b,%2,%0)
+			: "=r"(error),
+			  "=&r"(tmp1), "=r"(tmp2), "=&r"(tmp3), "=&r"(tmp4)
+			: "r"(la & ~3ul),
+			  "r"((la & 3) * 8), "r"((4 - (la & 3)) * 8), "0"(0));
+		if (error)
+			goto got_exception;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_va = la;
+		ll_task = NULL;
+		ll_data[0] = tmp3;
+		ll_data[1] = tmp4;
+		ll_quad = false;
+		ll_bit = true;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		una_reg(reg) = (int)(tmp1|tmp2);
+		return;
+
+	case 0x2b: /* ldq_l */
+		la = (unsigned long)va;
+		if (la < TASK_SIZE)
+			break;
+		__asm__ __volatile__(
+		"1:	ldq_u %3,0(%5)\n"
+		"2:	ldq_u %4,7(%5)\n"
+		"	extql %3,%5,%1\n"
+		"	extqh %4,%5,%2\n"
+		"3:\n"
+		EXC(1b,3b,%1,%0)
+		EXC(2b,3b,%2,%0)
+			: "=r"(error),
+			  "=&r"(tmp1), "=r"(tmp2), "=&r"(tmp3), "=&r"(tmp4)
+			: "r"(va), "0"(0));
+		if (error)
+			goto got_exception;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_va = la;
+		ll_task = NULL;
+		ll_data[0] = tmp3;
+		ll_data[1] = tmp4;
+		ll_quad = true;
+		ll_bit = true;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		una_reg(reg) = tmp1|tmp2;
+		return;
+
 	/* Note that the store sequences do not indicate that they change
 	   memory because it _should_ be affecting nothing in this context.
 	   (Otherwise we have other, much larger, problems.)  */
@@ -513,6 +582,134 @@ do_entUna(void * va, unsigned long opcod
 		if (error)
 			goto got_exception;
 		return;
+
+	case 0x2e: /* stl_c */
+		la = (unsigned long)va;
+		if (la < TASK_SIZE)
+			break;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_match = ll_bit;
+		ll_match &= !ll_quad;
+		ll_match &= ll_task == NULL;
+		ll_match &= ll_va == la;
+		tmp3 = ll_data[0];
+		tmp4 = ll_data[1];
+		ll_bit = false;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	srl %6,%5,%3\n"
+			"	zapnot %3,%8,%3\n"
+			"1:	ldl_l %2,4(%4)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	zap %2,%8,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stl_c %1,4(%4)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(la & ~3ul), "r"((4 - (la & 3)) * 8),
+				  "r"(una_reg(reg)), "r"(tmp4),
+				  "r"((15 >> (4 - (la & 3))) & 0xf), "0"(0));
+			if (error)
+				goto got_exception;
+		}
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	sll %6,%5,%3\n"
+			"	zapnot %3,%8,%3\n"
+			"1:	ldl_l %2,0(%4)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	zap %2,%8,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stl_c %1,0(%4)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(la & ~3ul), "r"((la & 3) * 8),
+				  "r"(una_reg(reg)), "r"(tmp3),
+				  "r"((15 << (la & 3)) & 0xf), "0"(0));
+			if (error)
+				goto got_exception;
+		}
+		una_reg(reg) = ll_match;
+		return;
+
+	case 0x2f: /* stq_c */
+		la = (unsigned long)va;
+		if (la < TASK_SIZE)
+			break;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_match = ll_bit;
+		ll_match &= ll_quad;
+		ll_match &= ll_task == NULL;
+		ll_match &= ll_va == la;
+		tmp3 = ll_data[0];
+		tmp4 = ll_data[1];
+		ll_bit = false;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	insqh %6,%4,%3\n"
+			"1:	ldq_l %2,8(%5)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	mskqh %2,%4,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stq_c %1,8(%5)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(va), "r"(la & ~7ul),
+				  "r"(una_reg(reg)), "r"(tmp4), "0"(0));
+			if (error)
+				goto got_exception;
+		}
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	insql %6,%4,%3\n"
+			"1:	ldq_l %2,0(%5)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	mskql %2,%4,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stq_c %1,0(%5)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(va), "r"(la & ~7ul),
+				  "r"(una_reg(reg)), "r"(tmp3), "0"(0));
+			if (error)
+				goto got_exception;
+		}
+		una_reg(reg) = ll_match;
+		return;
 	}
 
 	printk("Bad unaligned kernel access at %016lx: %p %lx %lu\n",
@@ -624,24 +821,33 @@ s_reg_to_mem (unsigned long s_reg)
  * so finding the appropriate registers is a little more difficult
  * than in the kernel case.
  *
- * Finally, we handle regular integer load/stores only.  In
- * particular, load-linked/store-conditionally and floating point
- * load/stores are not supported.  The former make no sense with
- * unaligned faults (they are guaranteed to fail) and I don't think
- * the latter will occur in any decent program.
+ * We have three classes of operations to handle:
  *
- * Sigh. We *do* have to handle some FP operations, because GCC will
- * uses them as temporary storage for integer memory to memory copies.
- * However, we need to deal with stt/ldt and sts/lds only.
+ * - We handle regular integer load/stores transparently to faulting
+ *   code, preserving the semantics of the triggering instruction.
+ *
+ * - We handle some FP operations as well, because GCC will use them as
+ *   temporary storage for integer memory to memory copies.  However,
+ *   we need to deal with stt/ldt and sts/lds only.
+ *
+ * - We handle load-locked/store-conditional operations by maintaining
+ *   data consistency only, within the two adjacent longwords or
+ *   quadwords partially spanned.  This is sufficient to guarantee an
+ *   unaligned RMW sequence using these operations won't clobber data
+ *   *outside* the location intended but does *not* guarantee atomicity
+ *   for the data quantity itself.
  */
 
 #define OP_INT_MASK	( 1L << 0x28 | 1L << 0x2c   /* ldl stl */	\
+			| 1L << 0x2a | 1L << 0x2e   /* ldl_l stl_c */	\
 			| 1L << 0x29 | 1L << 0x2d   /* ldq stq */	\
+			| 1L << 0x2b | 1L << 0x2f   /* ldq_l stq_c */	\
 			| 1L << 0x0c | 1L << 0x0d   /* ldwu stw */	\
 			| 1L << 0x0a | 1L << 0x0e ) /* ldbu stb */
 
 #define OP_WRITE_MASK	( 1L << 0x26 | 1L << 0x27   /* sts stt */	\
 			| 1L << 0x2c | 1L << 0x2d   /* stl stq */	\
+			| 1L << 0x2e | 1L << 0x2d   /* stl_c stq_c */	\
 			| 1L << 0x0d | 1L << 0x0e ) /* stw stb */
 
 #define R(x)	((size_t) &((struct pt_regs *)0)->x)
@@ -666,6 +872,9 @@ do_entUnaUser(void __user * va, unsigned
 
 	unsigned long tmp1, tmp2, tmp3, tmp4;
 	unsigned long fake_reg, *reg_addr = &fake_reg;
+	unsigned long flags;
+	unsigned long la;
+	bool ll_match;
 	int si_code;
 	long error;
 
@@ -794,6 +1003,61 @@ do_entUnaUser(void __user * va, unsigned
 		*reg_addr = tmp1|tmp2;
 		break;
 
+	case 0x2a: /* ldl_l */
+		la = (unsigned long)va;
+		__asm__ __volatile__(
+		"1:	ldl %3,0(%5)\n"
+		"2:	ldl %4,4(%5)\n"
+		"	srl %3,%6,%1\n"
+		"	sll %4,%7,%2\n"
+		"	zapnot %1,15,%1\n"
+		"	zapnot %2,15,%2\n"
+		"3:\n"
+		EXC(1b,3b,%1,%0)
+		EXC(2b,3b,%2,%0)
+			: "=r"(error),
+			  "=&r"(tmp1), "=r"(tmp2), "=&r"(tmp3), "=&r"(tmp4)
+			: "r"(la & ~3ul),
+			  "r"((la & 3) * 8), "r"((4 - (la & 3)) * 8), "0"(0));
+		if (error)
+			goto give_sigsegv;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_va = la;
+		ll_task = current;
+		ll_data[0] = tmp3;
+		ll_data[1] = tmp4;
+		ll_quad = false;
+		ll_bit = true;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		*reg_addr = (int)(tmp1|tmp2);
+		break;
+
+	case 0x2b: /* ldq_l */
+		la = (unsigned long)va;
+		__asm__ __volatile__(
+		"1:	ldq_u %3,0(%5)\n"
+		"2:	ldq_u %4,7(%5)\n"
+		"	extql %3,%5,%1\n"
+		"	extqh %4,%5,%2\n"
+		"3:\n"
+		EXC(1b,3b,%1,%0)
+		EXC(2b,3b,%2,%0)
+			: "=r"(error),
+			  "=&r"(tmp1), "=r"(tmp2), "=&r"(tmp3), "=&r"(tmp4)
+			: "r"(va), "0"(0));
+		if (error)
+			goto give_sigsegv;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_va = la;
+		ll_task = current;
+		ll_data[0] = tmp3;
+		ll_data[1] = tmp4;
+		ll_quad = true;
+		ll_bit = true;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		*reg_addr = tmp1|tmp2;
+		break;
+
 	/* Note that the store sequences do not indicate that they change
 	   memory because it _should_ be affecting nothing in this context.
 	   (Otherwise we have other, much larger, problems.)  */
@@ -877,12 +1141,139 @@ do_entUnaUser(void __user * va, unsigned
 			goto give_sigsegv;
 		return;
 
+	case 0x2e: /* stl_c */
+		la = (unsigned long)va;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_match = ll_bit;
+		ll_match &= !ll_quad;
+		ll_match &= ll_task == current;
+		ll_match &= ll_va == la;
+		tmp3 = ll_data[0];
+		tmp4 = ll_data[1];
+		ll_bit = false;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	srl %6,%5,%3\n"
+			"	zapnot %3,%8,%3\n"
+			"1:	ldl_l %2,4(%4)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	zap %2,%8,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stl_c %1,4(%4)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(la & ~3ul), "r"((4 - (la & 3)) * 8),
+				  "r"(*reg_addr), "r"(tmp4),
+				  "r"((15 >> (4 - (la & 3))) & 0xf), "0"(0));
+			if (error)
+				goto give_sigsegv;
+		}
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	sll %6,%5,%3\n"
+			"	zapnot %3,%8,%3\n"
+			"1:	ldl_l %2,0(%4)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	zap %2,%8,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stl_c %1,0(%4)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(la & ~3ul), "r"((la & 3) * 8),
+				  "r"(*reg_addr), "r"(tmp3),
+				  "r"((15 << (la & 3)) & 0xf), "0"(0));
+			if (error)
+				goto give_sigsegv;
+		}
+		*reg_addr = ll_match;
+		break;
+
+	case 0x2f: /* stq_c */
+		la = (unsigned long)va;
+		raw_spin_lock_irqsave(&ll_lock, flags);
+		ll_match = ll_bit;
+		ll_match &= ll_quad;
+		ll_match &= ll_task == current;
+		ll_match &= ll_va == la;
+		tmp3 = ll_data[0];
+		tmp4 = ll_data[1];
+		ll_bit = false;
+		raw_spin_unlock_irqrestore(&ll_lock, flags);
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	insqh %6,%4,%3\n"
+			"1:	ldq_l %2,8(%5)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	mskqh %2,%4,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stq_c %1,8(%5)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(va), "r"(la & ~7ul),
+				  "r"(*reg_addr), "r"(tmp4), "0"(0));
+			if (error)
+				goto give_sigsegv;
+		}
+		if (ll_match) {
+			__asm__ __volatile__(
+			"	insql %6,%4,%3\n"
+			"1:	ldq_l %2,0(%5)\n"
+			"	cmpeq %7,%2,%1\n"
+			"	beq %1,4f\n"
+			"	mskql %2,%4,%2\n"
+			"	or %2,%3,%1\n"
+			"2:	stq_c %1,0(%5)\n"
+			"	beq %1,3f\n"
+			"	.subsection 2\n"
+			"3:	br 1b\n"
+			"	.previous\n"
+			"4:\n"
+			EXC(1b,4b,%2,%0)
+			EXC(2b,4b,%1,%0)
+				: "=r"(error), "=&r"(ll_match),
+				  "=&r"(tmp1), "=&r"(tmp2)
+				: "r"(va), "r"(la & ~7ul),
+				  "r"(*reg_addr), "r"(tmp3), "0"(0));
+			if (error)
+				goto give_sigsegv;
+		}
+		*reg_addr = ll_match;
+		break;
+
 	default:
 		/* What instruction were you trying to use, exactly?  */
 		goto give_sigbus;
 	}
 
-	/* Only integer loads should get here; everyone else returns early. */
+	/*
+	 * Only integer loads and stores conditional should get here;
+	 * everyone else returns early.
+	 */
 	if (reg == 30)
 		wrusp(fake_reg);
 	return;

