Return-Path: <linux-kernel+bounces-422440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01A9D99AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51E1281FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB91D5CDD;
	Tue, 26 Nov 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/q26viF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2781D5AC2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631571; cv=none; b=Y28FaxlKzllwNK5atteayzLYbhVO4Jjj8swzreoeEXN+7oBMRQOuK3oDkQmc1o7/SBFrin0dj8oLMrcSsBWRIKebZNHPcW4Uc12KQyqpY+X/IgqMgPFvK5EizS21ZdF+BVbbJqmTaqN5p//+VQbCXgQaoxCW5XdK6MZ2QT96S9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631571; c=relaxed/simple;
	bh=dQRhJy3Wh/XAeespnPYlzWHTBZvlLsZVW/rgRLQ331k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSrtOqJukdMPtSp06R9yDYU3alcMmKdmrREdph1Ckp7EHLp19wefTU4gVvY/9m8SCKbhnO6QWrskEfGmnjVliEoTQtfwcNlL3gZma99OK0uUYd/Gg8IMyYBEsRv8238w1XxaYb4ZKLabveiAwZA5mNiPlgLnmkZUsDy2eUNgpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/q26viF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J+ieYSkNG6qdtjOppQ0piLEhSHHCuA2LQgzIKmNMU7k=; b=c/q26viF8OKVC2MKdaH6X7QSmt
	J9jlqCV4YgL35D3gyqySLbyoV0XRwNgGIc4IdEs5u9zt8i3iu7EpK1taJ5A5ccat1hOZib4VP/Qtt
	H8DLyHAkM7tdQtcqcF6cT2R+diW1czdRdho3SjBsINeiBRilKr1+Vzsy75F/uXfeM6wadQ5/uyUGA
	Ju58M6kLCrcT1Dww+VLb1H4u84p9GHVVgka9PsFqVFMFA6tPfhxpG1Vi0yD5uU71jLC1SzsSjILhp
	ybMIdqm8a+Xc1ptPKCcohtIrVWw4I3T8TXmbchrfXPBVIsPdmDB1jO0uk1xgrmJcKSsIOzShMA24u
	nkyPReoA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFwcO-00000001DpV-37NG;
	Tue, 26 Nov 2024 14:32:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E883E3002A2; Tue, 26 Nov 2024 15:32:43 +0100 (CET)
Date: Tue, 26 Nov 2024 15:32:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] objtool: Handle special cases of dead end insn
Message-ID: <20241126143243.GN38837@noisy.programming.kicks-ass.net>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-3-yangtiezhu@loongson.cn>
 <20241126064513.bf6yq56eklyo4xvt@jpoimboe>
 <bb36374e-aca2-92e1-209d-1524e31147ab@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb36374e-aca2-92e1-209d-1524e31147ab@loongson.cn>

On Tue, Nov 26, 2024 at 06:42:15PM +0800, Tiezhu Yang wrote:
> On 11/26/2024 02:45 PM, Josh Poimboeuf wrote:
> > On Fri, Nov 22, 2024 at 12:49:57PM +0800, Tiezhu Yang wrote:
> > > There are some "unreachable instruction" objtool warnings when compling
> > > with Clang on LoongArch, this is because the "break" instruction is set
> > > as dead end due to its type is INSN_BUG in decode_instructions() at the
> > > beginning, and it does not set insn->dead_end of the "break" instruction
> > > as false after checking ".rela.discard.reachable" in add_dead_ends(), so
> > > the next instruction of "break" is marked as unreachable.
> > > 
> > > Actually, it can find the reachable instruction after parsing the section
> > > ".rela.discard.reachable", in some cases, the "break" instruction may not
> > > be the first previous instruction with scheduling by Machine Instruction
> > > Scheduler of LLVM, it should find more times and then set insn->dead_end
> > > of the "break" instruction as false.
> > > 
> > > This is preparation for later patch on LoongArch, there is no effect for
> > > the other archs with this patch.
> > > 
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > 
> > I'm having trouble understanding this commit log, is the problem that
> > the compiler is sometimes inserting code between 'break' and the
> > unreachable() inline asm?
> > 
> > If so, this sounds like a problem that was already solved for x86 with:
> > 
> >   bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into _BUG_FLAGS() asm")
> > 
> > Can you check if that fixes it?
> 
> I will try, thank you.
> 

I was poking at the reachable annotations and ended up with this:

--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <asm/break.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -37,21 +38,21 @@
 
 #define ASM_BUG()	ASM_BUG_FLAGS(0)
 
-#define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+#define __BUG_FLAGS(flags, extra)					\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
+			     extra);
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
-	annotate_reachable();					\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(0);						\
+	__BUG_FLAGS(0, "");					\
 	unreachable();						\
 } while (0)
 

