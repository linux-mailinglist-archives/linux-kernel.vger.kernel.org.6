Return-Path: <linux-kernel+bounces-345677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673F98B94D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0581C2258F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5219D08C;
	Tue,  1 Oct 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZjLb9ZZH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7023209
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778093; cv=none; b=EzWxFEzr/GxsmsAsr+IkDCxUsYvJ+BhDKBhVD/7fKLcxMR0OU1z+MHfMv7VxHZabMVWWKtA8Cj9flKip3q/nGF2+4CIcbn1jIaXbf6KwCx8Fqr1BSEQv6Po1brZ+0E/uAf8Kfl4IZGNmlQOgGbY2LxIcL9NbRDwzU2JBpgrjrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778093; c=relaxed/simple;
	bh=bx/G2mnxkbSROBkKX4L9dhHpv7zwREf5iCZsWqGYvKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXpCXpoj2DsusWEjun/q8/XwVH3rFkb55PR+nKrOGpGueNJ9oXfZTRPjoWLcC+o5zANaSLoHe7UNZEqCDIAJTQ8fopFlPCyLvxM1JOwJhblRYtp3BTvAlU9KUsX1weq00tyEWg2j/GrTdO1Z1q8+nEC3eBB2ewc3F+qvp67mmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZjLb9ZZH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8bUWLkm/SauB9H4hqtrHRke+Kp8bBDyP98cNmkoSzec=; b=ZjLb9ZZH/2IUSuVgvwjc7R3tEj
	HLeGd0eAC7Tc9qvTrnd7UqY5FxIjJH23QgbpiTXSvFr4P6GMQ93OCaeEWnCOx5rDwT3y2Zl4nUDHj
	jMeG3C78pGT3as4ceq8DvFwQ+U4naNP98veTDSLVjEp32RmhcO/SkbYkVfTmObtEhfqoXqVGLUgfS
	QsW0WKmDLZSaUHEw/5JbXVR6UdLsisGFhkACUr3xLKKeA1XoUTx4t3Fl/8rSrT9u6VH3j+KvnzUDm
	np0mws0HFvj2ruabE4ryUZptQDlPZe791UQJi6cZ2TqaxM1VkfXpcSLDpBMGwdwRC4+3y3w0ruC4x
	nbeIEV/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sva0P-000000030Zi-2ZH5;
	Tue, 01 Oct 2024 10:21:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 501DF30057A; Tue,  1 Oct 2024 12:21:20 +0200 (CEST)
Date: Tue, 1 Oct 2024 12:21:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 11/14] llvm: kCFI pointer stuff
Message-ID: <20241001102120.GL5594@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.498161564@infradead.org>
 <CAADnVQKQED2pit_DcpDWPuueHH3RLXe4pB++tU888EU=8UrNpA@mail.gmail.com>
 <20240930082726.GF5594@noisy.programming.kicks-ass.net>
 <CAADnVQK8s4N_W_BH5zPZ7V-NW9FRegK27Nk-67UqiJzCxrdtxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK8s4N_W_BH5zPZ7V-NW9FRegK27Nk-67UqiJzCxrdtxQ@mail.gmail.com>

On Mon, Sep 30, 2024 at 09:59:11AM -0700, Alexei Starovoitov wrote:
> On Mon, Sep 30, 2024 at 1:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Sep 29, 2024 at 10:53:05AM -0700, Alexei Starovoitov wrote:
> >
> > > > +  // Extend the kCFI meta-data with a byte that has a bit set for each argument
> > > > +  // register that contains a pointer. Specifically for x86_64, which has 6
> > > > +  // argument registers:
> > > > +  //
> > > > +  //   bit0 - rdi
> > > > +  //   bit1 - rsi
> > > > +  //   bit2 - rdx
> > > > +  //   bit3 - rcx
> > > > +  //   bit4 - r8
> > > > +  //   bit5 - r9
> > > > +  //
> > > > +  // bit6 will denote any pointer on stack (%rsp), and all 7 bits set will
> > > > +  // indicate vararg or any other 'unknown' configuration. Leaving bit7 for
> > > > +  // error states.
> > > > +  //
> > > > +  // XXX: should be conditional on some new x86_64 specific 'bhi' argument.
> > > > +  EmitAndCountInstruction(MCInstBuilder(X86::MOV8ri)
> > > > +                 .addReg(X86::AL)
> > > > +                 .addImm(getKCFIPointerArgs(F)));
> > >
> > > If I'm reading this correctly it will be an 8-bit move which
> > > doesn't clear upper bits.
> > > If consumer is in assembly it's ok-ish,
> > > but it's an argument to __bhi_args_foo functions,
> > > so should be properly zero extended per call convention.
> >
> > These kCFI 'instructions' are never executed. Their sole purpose is to
> > encode the immediates. They are instructions because they live in .text
> > and having them this way makes disassemly work nicely. As such, we've
> > taken to using the 1 byte move instruction to carry them with the least
> > amounts of bytes.
> >
> > The consumer is the kernel instruction decoder, we take the immediate
> > and use that.
> 
> I see... and after decoding imm bits in mov %al insn the kernel will
> insert a call to corresponding __bhi_args_* stub that will use
> cmovne on corresponding register(s) to sanitize the value?
> That was difficult to grasp.
> A design doc would have helped.

Does something like this help?

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 31d19c815f99..b6e7e79e79c6 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -44,11 +44,28 @@
  *   call *%r11
  *
  *
+ * IBT+:
+ *
+ * foo:
+ *   endbr64 / ud1 0(%eax), %edx
+ *   ... code here ...
+ *   ret
+ *
+ * direct caller:
+ *   call foo+4
+ *
+ * indirect caller:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   call *%r11
+ *
+ *
  * kCFI:
  *
  * __cfi_foo:
  *   movl $0x12345678, %eax	# kCFI signature hash
- *				# 11 nops when CONFIG_CALL_PADDING
+ *   movb $0x12, %al		# kCFI pointer argument mask
+ *				# 9 nops when CONFIG_CALL_PADDING
  * foo:
  *   endbr64			# when IBT
  *   ... code here ...
@@ -91,6 +108,57 @@
  *   nop4
  *   call *%r11
  *
+ *
+ * FineIBT+:
+ *
+ * __cfi_foo:
+ *   endbr64
+ *   subl 0x12345678, %r10d
+ *   jz   foo
+ *   ud2
+ *   nop
+ * foo:
+ *   ud1 0(%eax), %edx		# was endbr64
+ * foo_4:
+ *   ... code here ...
+ *   ret
+ *
+ * direct caller:
+ *   call foo+4
+ *
+ * indirect caller:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   movl $0x12345678, %r10d
+ *   subl $16, %r11
+ *   nop4
+ *   call *%r11
+ *
+ *
+ * FineIBT-BHI:
+ *
+ * __cfi_foo:
+ *   endbr64
+ *   subl 0x12345678, %r10d
+ *   jz   foo-1
+ *   ud2
+ * foo-1:
+ *   call __bhi_args_XXX	# depends on kCFI pointer argument mask
+ * foo+4:
+ *   ... code here ...
+ *   ret
+ *
+ * direct caller:
+ *   call foo+4
+ *
+ * indirect caller:
+ *   lea foo(%rip), %r11
+ *   ...
+ *   movl $0x12345678, %r10d
+ *   subl $16, %r11
+ *   nop4
+ *   call *%r11
+ *
  */
 enum cfi_mode {
 	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */




> I wonder whether this whole complexity is worth it vs
> always calling __bhi_args_all()

That's one for Scott to answer; I think always doing _all will hurt
especially bad because it includes rsp.



