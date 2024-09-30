Return-Path: <linux-kernel+bounces-343695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39B989E73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81C51F215FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCE18990C;
	Mon, 30 Sep 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M4rkG22R"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EF1885B4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688793; cv=none; b=EZqNfWl6ux6AWRuMFBxhxp3+uENuim325uI2+kk9ypOC8fmbXyeshDVwaozpfLxPcFRzuzNlhjcfcR5d4h2e2uX1ghwYIEH5l5sp/jDOmtaxsWS1+o++OAFg2LAorKuyJ5mcKzfrIdxSECKlWcz/wmqwaXef3E/m4THX8Vk6vbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688793; c=relaxed/simple;
	bh=MfD4X47i/yN6AHsAgI2rvTWVa9zIAO+TLc7ixKjbdjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnKn+3I4negTqDITvyK148bsyBsZUsbeqHZ+8SJ6glp8bHAkFl05TAkqFqUkocUsuFhwpxXvGBR/ZgkDHBHOoZ1iqCXU6GCsvK4Icj8xw8ft0tqPZvfoV2Q0KuvSSxwrycQihNpoqW1FvTVeRnHuXkzDrqDNZhUaUn3Wa+qTHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M4rkG22R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wlJjmpLZcW8TIOz9J05tMCIaj7+zoMy0Tpn83Sjdtl4=; b=M4rkG22R0LuK7St+l1aRGp9IUn
	sg89TAj8/2m44K91JqIot6HB+s/TUjEaZclY5XcK3iFDgVTx4QKyfX0SEl7oqomth8lqarSJMCrh7
	IFe5WHBhadWmHekIbwp7nLP64ddxxEsEAaq5/2nSGCSk63+DCnBsqMpMxsYWKwkeZD4rNJ3H0DNo7
	8OjgnC2DAYVP+b3Ud1YDo/3wwGmCy0Qdv0lA94FI26Vk41HBTXP0l2lmEftDWZHb4WIVbdk+GYlRF
	JWaajkpH0onkUzNgi4ybwfLwRJJZWCKJm+xasegxguNe6p53APKCv2DvtJnATSDZQ6tZplZTnoKNj
	iWovpjXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svCm6-0000000GuB7-1rak;
	Mon, 30 Sep 2024 09:33:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0EE21300BAE; Mon, 30 Sep 2024 11:33:02 +0200 (CEST)
Date: Mon, 30 Sep 2024 11:33:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	alyssa.milburn@intel.com, scott.d.constable@intel.com,
	Joao Moreira <joao@overdrivepizza.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
Message-ID: <20240930093302.GB33184@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.069013308@infradead.org>
 <CAADnVQ+BASJ7kcW4Kz_NsXM0U1+GrMHNVBOro8aO0-OyEry4Ww@mail.gmail.com>
 <20240930083026.GG5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930083026.GG5594@noisy.programming.kicks-ass.net>

On Mon, Sep 30, 2024 at 10:30:26AM +0200, Peter Zijlstra wrote:
> On Sun, Sep 29, 2024 at 10:32:38AM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 27, 2024 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1027,19 +1027,9 @@ static const struct bpf_func_proto bpf_g
> > >  #ifdef CONFIG_X86_KERNEL_IBT
> > >  static unsigned long get_entry_ip(unsigned long fentry_ip)
> > >  {
> > > -       u32 instr;
> > > +       if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
> > > +               return fentry_ip - ENDBR_INSN_SIZE;
> > >
> > > -       /* We want to be extra safe in case entry ip is on the page edge,
> > > -        * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > > -        */
> > > -       if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > > -               if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> > > -                       return fentry_ip;
> > > -       } else {
> > > -               instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > > -       }
> > > -       if (is_endbr(instr))
> > > -               fentry_ip -= ENDBR_INSN_SIZE;
> > >         return fentry_ip;
> > 
> > Pls don't.
> > 
> > This re-introduces the overhead that we want to avoid.
> > 
> > Just call __is_endbr() here and keep the optimization.
> 
> Well, I could do that ofcourse, but as I wrote elsewhere, the right
> thing to do is to optimize get_kernel_nofault(), its current
> implementation is needlessly expensive. All we really need is a load
> with an exception entry, the STAC/CLAC and speculation nonsense should
> not be needed.

Looking at things, something like the below actually generates sane
code:

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca87..84f65ee9736c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1029,17 +1029,10 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
 {
 	u32 instr;
 
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
+	__get_kernel_nofault(&instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE), u32, Efault);
 	if (is_endbr(instr))
 		fentry_ip -= ENDBR_INSN_SIZE;
+Efault:
 	return fentry_ip;
 }
 #else


Which then leads to me rewriting the proposed patch as...

---
Subject: x86/ibt: Clean up is_endbr()
From: Peter Zijlstra <peterz@infradead.org>

Pretty much every caller of is_endbr() actually wants to test something at an
address and ends up doing get_kernel_nofault(). Fold the lot into a more
convenient helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c         |    2 +-
 arch/x86/include/asm/ibt.h     |    5 +++--
 arch/x86/kernel/alternative.c  |   20 ++++++++++++++------
 arch/x86/kernel/kprobes/core.c |   11 +----------
 arch/x86/net/bpf_jit_comp.c    |    4 ++--
 kernel/trace/bpf_trace.c       |   14 ++------------
 6 files changed, 23 insertions(+), 33 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2845,7 +2845,7 @@ static bool is_uprobe_at_func_entry(stru
 		return true;
 
 	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
 		return true;
 
 	return false;
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -65,7 +65,7 @@ static __always_inline __attribute_const
 	return 0x001f0f66; /* osp nopl (%rax) */
 }
 
-static inline bool is_endbr(u32 val)
+static inline bool __is_endbr(u32 val)
 {
 	if (val == gen_endbr_poison())
 		return true;
@@ -74,6 +74,7 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
+extern __noendbr bool is_endbr(u32 *val);
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
@@ -102,7 +103,7 @@ extern bool __do_kernel_cp_fault(struct
 
 #define __noendbr
 
-static inline bool is_endbr(u32 val) { return false; }
+static inline bool is_endbr(u32 *val) { return false; }
 
 static inline u64 ibt_save(bool disable) { return 0; }
 static inline void ibt_restore(u64 save) { }
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -852,16 +852,24 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+__noendbr bool is_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return __is_endbr(endbr);
+
+Efault:
+	return false;
+}
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr, bool warn)
 {
-	u32 endbr, poison = gen_endbr_poison();
-
-	if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
-		return;
+	u32 poison = gen_endbr_poison();
 
-	if (!is_endbr(endbr)) {
+	if (!is_endbr(addr)) {
 		WARN_ON_ONCE(warn);
 		return;
 	}
@@ -988,7 +996,7 @@ static u32  cfi_seed __ro_after_init;
 static u32 cfi_rehash(u32 hash)
 {
 	hash ^= cfi_seed;
-	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
+	while (unlikely(__is_endbr(hash) || __is_endbr(-hash))) {
 		bool lsb = hash & 1;
 		hash >>= 1;
 		if (lsb)
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -373,16 +373,7 @@ static bool can_probe(unsigned long padd
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	u32 insn;
-
-	/*
-	 * Since 'addr' is not guaranteed to be safe to access, use
-	 * copy_from_kernel_nofault() to read the instruction:
-	 */
-	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
-		return NULL;
-
-	if (is_endbr(insn)) {
+	if (is_endbr((u32 *)addr)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -625,7 +625,7 @@ int bpf_arch_text_poke(void *ip, enum bp
 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
 	 * with an ENDBR instruction.
 	 */
-	if (is_endbr(*(u32 *)ip))
+	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
@@ -2971,7 +2971,7 @@ static int __arch_prepare_bpf_trampoline
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-		if (is_endbr(*(u32 *)orig_call))
+		if (is_endbr(orig_call))
 			orig_call += ENDBR_INSN_SIZE;
 		orig_call += X86_PATCH_SIZE;
 	}
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1027,19 +1027,9 @@ static const struct bpf_func_proto bpf_g
 #ifdef CONFIG_X86_KERNEL_IBT
 static unsigned long get_entry_ip(unsigned long fentry_ip)
 {
-	u32 instr;
+	if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
+		return fentry_ip - ENDBR_INSN_SIZE;
 
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
-		fentry_ip -= ENDBR_INSN_SIZE;
 	return fentry_ip;
 }
 #else

