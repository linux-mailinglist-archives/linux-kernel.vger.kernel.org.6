Return-Path: <linux-kernel+bounces-342140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC885988AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0071F24199
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA61C6888;
	Fri, 27 Sep 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jXkJBXjj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B111C3F3B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466664; cv=none; b=erPM827v2yKxbsZySISMPn5Gw2Vj84CG8mkJrJqap1/HuklCDwM6YHe5LXYwwqL+AcuzvEKNGU46qEV7A+ZqotjuUuMNb9W9TcK9ov9gwpt87QxOfA8XcpM5nYuIcljplI/cTaEHROLA/5PPnKftkeP+Sce9f73JA+0AorISefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466664; c=relaxed/simple;
	bh=py351CAWFlpDz3zpAmSiVjHSczEFA6gMsdfJlNnaVlw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=awxhwCXwkj1ghFYGFROvQfmvYK5n1B2GYzhkByr8fXoJMQTAeeYCLDsTol1MVtjMeR4f7qJ11tKa7QsPkWasTk56P1pPwzVvLuE/A3KiC6Qo1dOyQswHnIX0s2a1+0ZQQ6iqbtoVxy6DumZdt3ki8jUytf0uslLbzVt+dBe39LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jXkJBXjj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=clz+4HfhflDwK3Xr2tLt2iX5CBtaxE7c7ymYTUq298k=; b=jXkJBXjjTICTsfXA3JjdRp7jTS
	lJIxgoX2jEc1dhrwQORV3ojKs08HUmu1mLpYpYtKYzcSyXnWOTgkYkh/8kSegtMwgUlqcEfQYyDZH
	CS9xkiNnqM7B7X7LZBtNSwyj+8mTiPACN2gJIVeylNzmjE/4qMoBdxDR40qX8mzS0YVcc8l0G6mYM
	DW1jhqkSkuHoBrGDz6hzVeeTrNWe81glnYSotmktBJJwWapJJtL/LcXrL0/SOIP/SHe9kvgjIZRj3
	9QYYwEFmfoPYdGzSxTyMnQZ9djWI6Mt0s8G2AC6F2zZO+aYmXW631IKmKSn43KVJGgcSpNzVvCgn+
	fp/zC3wQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzH-00000002Onx-2UXh;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D2C8B308CBF; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.498161564@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 11/14] llvm: kCFI pointer stuff
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Quick hack to extend the Clang-kCFI function meta-data (u32 hash) with
a u8 bitmask of pointer arguments. This should really be under a new
compiler flag, dependent on both x86_64 and kCFI.

Per the comment, the bitmask represents the register based arguments
as the first 6 bits and bit 6 is used to cover all stack based
arguments. The high bit is used for invalid values.

The purpose is to put a store dependency on the set registers, thereby
blocking speculation paths that would otherwise expoit their value.


Note1:

This implementation simply sets the bit for any pointer type. A better
implementation would only set the bit for any argument that is
dereferenced in the function body.

This better implementation would also capture things like:

  void foo(unsigned long addr, void *args)
  {
    u32 t = *(u32 *)addr;
    bar(t, args);
  }

Which, in contrast to the implementation below, would set bit0 while
leaving bit1 unset -- the exact opposite of this implementation.

Notably, addr *is* dereferenced, even though it is not a pointer on
entry, while args is a pointer, but is not derefereced but passed on
to bar -- if bar uses it, it gets to deal with it.

Note2:

Do we want to make this a u32 to keep room for all registers? AFAICT
the current use is only concerned with the argument registers and
those are limited to 6 for the C ABI, but custom (assembly) functions
could use things outside of that.

---
diff --git a/llvm/lib/Target/X86/X86AsmPrinter.cpp b/llvm/lib/Target/X86/X86AsmPrinter.cpp
index 73c745062096..42dcbc40ab4b 100644
--- a/llvm/lib/Target/X86/X86AsmPrinter.cpp
+++ b/llvm/lib/Target/X86/X86AsmPrinter.cpp
@@ -143,11 +143,28 @@ void X86AsmPrinter::EmitKCFITypePadding(const MachineFunction &MF,
   // one. Otherwise, just pad with nops. The X86::MOV32ri instruction emitted
   // in X86AsmPrinter::emitKCFITypeId is 5 bytes long.
   if (HasType)
-    PrefixBytes += 5;
+    PrefixBytes += 7;
 
   emitNops(offsetToAlignment(PrefixBytes, MF.getAlignment()));
 }
 
+static uint8_t getKCFIPointerArgs(const Function &F)
+{
+  uint8_t val = 0;
+
+  if (F.isVarArg())
+    return 0x7f;
+
+  for (int i = 0; i < F.arg_size() ; i++) {
+    Argument *A = F.getArg(i);
+    Type *T = A->getType();
+    if (T->getTypeID() == Type::PointerTyID)
+      val |= 1 << std::min(i, 6);
+  }
+
+  return val;
+}
+
 /// emitKCFITypeId - Emit the KCFI type information in architecture specific
 /// format.
 void X86AsmPrinter::emitKCFITypeId(const MachineFunction &MF) {
@@ -183,6 +200,26 @@ void X86AsmPrinter::emitKCFITypeId(const MachineFunction &MF) {
                               .addReg(X86::EAX)
                               .addImm(MaskKCFIType(Type->getZExtValue())));
 
+  // Extend the kCFI meta-data with a byte that has a bit set for each argument
+  // register that contains a pointer. Specifically for x86_64, which has 6
+  // argument registers:
+  //
+  //   bit0 - rdi
+  //   bit1 - rsi
+  //   bit2 - rdx
+  //   bit3 - rcx
+  //   bit4 - r8
+  //   bit5 - r9
+  //
+  // bit6 will denote any pointer on stack (%rsp), and all 7 bits set will
+  // indicate vararg or any other 'unknown' configuration. Leaving bit7 for
+  // error states.
+  //
+  // XXX: should be conditional on some new x86_64 specific 'bhi' argument.
+  EmitAndCountInstruction(MCInstBuilder(X86::MOV8ri)
+		  .addReg(X86::AL)
+		  .addImm(getKCFIPointerArgs(F)));
+
   if (MAI->hasDotTypeDotSizeDirective()) {
     MCSymbol *EndSym = OutContext.createTempSymbol("cfi_func_end");
     OutStreamer->emitLabel(EndSym);
diff --git a/llvm/lib/Target/X86/X86MCInstLower.cpp b/llvm/lib/Target/X86/X86MCInstLower.cpp
index cbb012161524..c0776ef78153 100644
--- a/llvm/lib/Target/X86/X86MCInstLower.cpp
+++ b/llvm/lib/Target/X86/X86MCInstLower.cpp
@@ -897,7 +897,7 @@ void X86AsmPrinter::LowerKCFI_CHECK(const MachineInstr &MI) {
                               .addReg(AddrReg)
                               .addImm(1)
                               .addReg(X86::NoRegister)
-                              .addImm(-(PrefixNops + 4))
+                              .addImm(-(PrefixNops + 6))
                               .addReg(X86::NoRegister));
 
   MCSymbol *Pass = OutContext.createTempSymbol();



