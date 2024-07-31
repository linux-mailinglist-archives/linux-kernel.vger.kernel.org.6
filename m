Return-Path: <linux-kernel+bounces-268829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2949429F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8021F22D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9001A8C1F;
	Wed, 31 Jul 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oCWGlq+7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568A1CF93
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417119; cv=none; b=jiAhXymhPHzcowb206sBL2SLi9DikY9vL7paoHFambuojEEm6k6gCaNysZFBYt2DIPjCQY54/LXsrc1sltgBc+8Phi24JZES5WltwwYkiGEh0h54g7arbPGghLAvzM1AwHyuCLD/fTl54KQ1iV8ce0tvudTxCVo/NGx7nyB/mXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417119; c=relaxed/simple;
	bh=9Yb6j7jGTbH7d3cHRo2GNECWrPdXh3RG9PXt1tO6z1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcuhuR94DY+BmJd9+9GOPwxg3sO4u+BEuoR52O2Q9OQpOfi9FaxznNnUCHWAFC9CNUT+mz+yvAPoGZX7Xm6hymy3VVwrtQ9OIkSDZzO8355sQYSfrG+HbIxUxCNQm5KO3O0Eaf33jeH4GvyERjHyJASv8kyOUA0Zv4JtUBMZil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oCWGlq+7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jLNWTLyRSLiY0M2hXNGR369KX9s09k8VZo8zfT3w1VA=; b=oCWGlq+7+bP07TpOHOBykkm64r
	LG2PKNb01XEo2VMBaA/Bb4Q6v+vsrUQj3ZIhtg5piUzJOkE07sDE9EQaiR19pWX7OzgwxfBEnmiaw
	nh+9ghQwy2c2FZuQy6Z3pCk7IyMhBN+JX7P18rwWJ1bmdt+R4nXrd73qVTX6fVbL+k/eZGe5CdhaM
	lKKtIAjbxtJ4yZyRfVs/qUJC8gmSEbS4RKEhhHHA+KdzFsF17jyPQCgNO3ye4+AXesJNJxS0c+tit
	kGq3hrzdOeDkrmCDcLSBpP+e6tdLr56nYsl0pEemFPdX0Vzhl2nvMaGBhP4A77oz36o9+db7JrkIJ
	fdhblR/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5N7-00000005BB3-11qs;
	Wed, 31 Jul 2024 09:11:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A326300820; Wed, 31 Jul 2024 11:11:48 +0200 (CEST)
Date: Wed, 31 Jul 2024 11:11:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731091148.GW33588@noisy.programming.kicks-ass.net>
References: <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
 <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
 <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
 <20240731082111.GAZqnz97mCll6rDyV-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731082111.GAZqnz97mCll6rDyV-@fat_crate.local>

On Wed, Jul 31, 2024 at 10:21:11AM +0200, Borislav Petkov wrote:
> On Tue, Jul 30, 2024 at 04:54:43PM -0700, Linus Torvalds wrote:
> > You also seemed to say that it only happened with some CPU selections.
> > Maybe there's something wrong with the ALTERNATIVE() cleanups - I'm
> > looking at that new "nested alternatives macros" thing, and the odd
> > games we play with the origin and replacement lengths etc.
> > 
> > That all looks entirely crazy. That file was hard to read before, now
> > it's just incomprehensible to me.
> 
> I'm sorry to hear that. The reason we did it is because it was starting to
> become really unwieldy to add a yet another alternative choice N in an
> ALTERNATIVE_N call...
> 
> Anyway, I'll try to reproduce here. In the meantime, can anyone who can
> reproduce - Guenter, Jens - boot that failing kernel with
> 
>   debug-alternative=-1
> 
> and copy dmesg and vmlinux somewhere for me?
> 
> It is a lot of output so make sure to catch it all.

So what I done instead is add: nokaslr to CMDLINE and -S -s to qemu and
am staring at the failing kernel in gdb.

So far all the alternatives in the affected paths look just fine.

Not that any of it is making sense, notably:

Code: bf 1e c2 e9 23 06 00 00 66 90 8d 76 00 fc 6a 00 68 f0 bd 1e c2 e9 11 06 00 00 8d 76 00 fc 6a 00 68 54 c5 1e c2 e9 01 06 00 00 <8d> 76 00 fc 68 b0 e9 1e c2 e9 f3 05 00 00 66 90 8d 76 00 fc 6a 00

decodes to:

   0:   bf 1e c2 e9 23          mov    $0x23e9c21e,%edi
   5:   06                      (bad)
   6:   00 00                   add    %al,(%rax)
   8:   66 90                   xchg   %ax,%ax
asm_exc_invalid_op:
   a:   8d 76 00                lea    0x0(%rsi),%esi
   d:   fc                      cld
   e:   6a 00                   push   $0x0
  10:   68 f0 bd 1e c2          push   $0xffffffffc21ebdf0
  15:   e9 11 06 00 00          jmp    0x62b
asm_exc_int3:
  1a:   8d 76 00                lea    0x0(%rsi),%esi
  1d:   fc                      cld
  1e:   6a 00                   push   $0x0
  20:   68 54 c5 1e c2          push   $0xffffffffc21ec554
  25:   e9 01 06 00 00          jmp    0x62b
asm_exc_page_fault:
  2a:*  8d 76 00                lea    0x0(%rsi),%esi           <-- trapping instruction
  2d:   fc                      cld
  2e:   68 b0 e9 1e c2          push   $0xffffffffc21ee9b0
  33:   e9 f3 05 00 00          jmp    0x62b
  38:   66 90                   xchg   %ax,%ax
asm_exc_machine_check:
  3a:   8d 76 00                lea    0x0(%rsi),%esi
  3d:   fc                      cld
  3e:   6a 00                   push   $0x0

And that trapping instruction is the CLAC nop (still a nop in the
faulting kernel image):

(gdb) disassemble asm_exc_page_fault
Dump of assembler code for function asm_exc_page_fault:
   0xc2200350 <+0>:     lea    0x0(%esi),%esi
   0xc2200353 <+3>:     cld
   0xc2200354 <+4>:     push   $0xc21ee9b0
   0xc2200359 <+9>:     jmp    0xc2200951 <handle_exception>
End of assembler dump.

And then we have the endless stream of:

  asm_exc_int3+0x10/0x10

which really is: asm_exc_page_fault+0x0/0x10, but that cannot be,
because then we'd have #DF much sooner.


The restore_all_switch_stack+0x65/0xe6 thing looks like so in the live
kernel image:

(gdb) disassemble restore_all_switch_stack
Dump of assembler code for function entry_INT80_32:
...
   0xc22008c5 <+353>:   mov    %cr3,%eax
   0xc22008c8 <+356>:   or     $0x1000,%eax
   0xc22008cd <+361>:   mov    %eax,%cr3
   0xc22008d0 <+364>:   mov    %esi,%esi		<--- here
   0xc22008d2 <+366>:   testl  $0x2,0x34(%esp)
   0xc22008da <+374>:   je     0xc22008e8 <entry_INT80_32+388>
   0xc22008dc <+376>:   mov    %cr3,%eax
   0xc22008df <+379>:   test   $0x1000,%eax
   0xc22008e4 <+384>:   jne    0xc22008e8 <entry_INT80_32+388>
   0xc22008e6 <+386>:   ud2
   0xc22008e8 <+388>:   pop    %ebx
...

So that is indeed BUG_IF_WRONG_CR3 and the JMP got patched to a NOP2.
Nothing strange there.


So yeah, no clue still.

