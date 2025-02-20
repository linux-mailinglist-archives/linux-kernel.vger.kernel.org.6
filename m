Return-Path: <linux-kernel+bounces-524799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EDA3E742
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789ED1897513
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3C213E9C;
	Thu, 20 Feb 2025 22:09:25 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3081EEA56;
	Thu, 20 Feb 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089364; cv=none; b=Oi3M6KXaKofdaS2Kr59mKZQrV0hOnZREWRxmt5Zb1j6++z0tYUB8IveJ9tFUCMfkB5mgN8gDonbG3NPMT4InKsYqsbFm1ruPb7jeAhVS0++d3SULVn9roRYwqIE5ulpsbL3SVsonn7iEzw8/pv9ydMDpmL3htPC7iNR8nTBPdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089364; c=relaxed/simple;
	bh=+BSfG7XSQPs3WSZSD8uNQu9wxfwrYohVa9iEe4Bw6bo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rmhsML17S2CW/G8lBG6c9x2TVLx9TYXPE6pY2zQ1OzcNZxhOfqmizOEMsOaD2DWsox7YcAAl9dvQiQ5GJIQQL+E/5bwCEW1RHtB5fNmYqno6SWAbC5lcgoLG4E8zRUdwbwaMy8NGa4xXB9o5pZ20R/McRYAGqVPUXHLDF/Bj2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 89C8092009C; Thu, 20 Feb 2025 23:09:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 829CB92009B;
	Thu, 20 Feb 2025 22:09:20 +0000 (GMT)
Date: Thu, 20 Feb 2025 22:09:20 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@unseen.parts>, Matt Turner <mattst88@gmail.com>, 
    Arnd Bergmann <arnd@arndb.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
    linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data
 consistency
In-Reply-To: <CAHk-=wgBZk1FFOyiTKLnz4jNe-eZtYsrztcYRRXZZxF8evk1Rw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2502202106200.65342@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <CAHk-=wgBZk1FFOyiTKLnz4jNe-eZtYsrztcYRRXZZxF8evk1Rw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Feb 2025, Linus Torvalds wrote:

> > 1. A trapping unaligned LDx_L operation results in the pair of adjacent
> >    aligned whole data quantities spanned being read and stored for the
> >    reference with a subsequent STx_C operation, along with the width of
> >    the data accessed and its virtual address, and the task referring or
> >    NULL if the kernel.  The validity marker is set.
> 
> So I have a couple of comments. I don't care deeply because I do think
> alpha is dead, but for completeness:
> 
>  (a) I don't think the task checking is correct.
> 
> You're only checking the task pointer, so what can happen is that a
> task exits and another starts up with the same task pointer value, and
> it all matches across one task doing a ld_l and another doing a st_c.
> 
> Does this matter? No. You'd literally have to *try* to create that
> situation with identical mis-aligned addresses and data contents, and
> an exit after a 'ld_l', and doing a 'st_c' in the new task without the
> matching ld_l.
> 
> So I suspect this works in practice, but it's still worth mentioning.

 It's an interesting corner case, but executing STx_C without preceding 
matching LDx_L is hardly useful and depending on the circumstances may or 
may not cause unpredictable results.  We can make it a part of the psABI 
that such usage is not supported.  Otherwise we could clear `ll_bit' in 
a task's termination path.

>  (b) this is not truly atomic wrt concurrent aligned non-trapping
> operations to the same words. Or in fact to current trapping ones,
> since you end up inevitably releasing the spinlock before the final
> stc emulation.

 It is not supposed to be.  The only objective of this code is to protect 
the *unchanged* part of the longword/quadword.

> I think this is fundamental and non-fixable, because the stc is done
> as two operations, and the first can succeed with the second failing
> (or they can both succeed, just interleaved with other accesses).

 It is absolutely fine and by design.  Atomicity of the unaligned store of 
the quantity itself is not guaranteed by this sequence, just as it is not 
with the original one using a pair of STQ_U operations, where a concurrent 
write to the same location may cause the parts of the quantity to become 
inconsistent with each other.

 If the trapping code wanted to make the data quantity accessed atomic, it 
should have declared it atomic as well as made it aligned, in which case 
the compiler would have done the right thing, including padding/separation 
from other data objects where necessary for the minimum width of data that 
hardware can guarantee atomicity for.  And then we would not have arrived 
in this emulation path in the first place.

> Again, I don't think we care, and it works in practice, but it does
> mean that I *really* think that:
> 
>  (c) you should not handle the kernel case at all.
> 
> If the kernel does an unaligned ld_l/st_c, that's a fundamental kernel
> bug. Don't emulate it. Particularly when the emulation fundamentally
> is not truly atomic wrt other accesses.

 Good point actually, I think I mentally drove myself into a dead end 
here.  Yes, absolutely, it is not expected to happen unless we have a bug 
in our code somewhere!

> Finally:
> 
>  (d) I think you're doing a few too many inline asms by hand, and
> you're masking the results too much.
> 
> On the read-side emulation, why do you do that
> 
> +               "1:     ldl %3,0(%5)\n"
> +               "2:     ldl %4,4(%5)\n"
> +               "       srl %3,%6,%1\n"
> +               "       sll %4,%7,%2\n"
> +               "       zapnot %1,15,%1\n"
> +               "       zapnot %2,15,%2\n"
> 
> at all? Just do two aligned loads, and don't mask the bytes around
> them. A *real* ldl/stc will fail not just when the exact bytes are
> different, but when somebody has touched the same cacheline. So if the
> aligned values have changed, you should fail the stc even if the
> change was in other bytes.

 We do need to extract the bytes desired for the result of LDx_L though.

 Yes, it can be done in C, but the same stands for all the other emulation
pieces here and yet they use inline assembly.  GCC is happy to do byte 
extraction itself where necessary, it has machine description patterns for 
that as it a fairly common operation (it does not for INSxH and MSKxH 
though, they're handled as intrinsics only, which however we could use 
instead).

 I think there is value in consistency, and with this piece written as 
inline assembly you can spot the difference from the other variants right 
away.  Or I could rewrite the byte extraction in C across other patterns.

> And doing two aligned loads don't need any inline asm at all.

 Neither does unaligned loads, as GCC is happy to emit LDQ_U itself where 
necessary, but we want to catch exceptions or we'd get an oops rather than 
SIGSEGV.

> On the st_c side, I think you're repeating the same inline asm twice,
> and should have a single helper.

 The masks are different as are displacements, but a good point otherwise.  
I think this guarantees the prologue to the atomic loop to go away, which 
is a good thing, but I'll yet double-check the quality of code produced.

> Is this a NAK for the patch? No. But I do think it should be massaged a bit.

 Thank you for your review, I'll post v2 once I'm done with the massage.

  Maciej

