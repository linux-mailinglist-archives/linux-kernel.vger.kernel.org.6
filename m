Return-Path: <linux-kernel+bounces-565182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51375A66297
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0036D17CFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F796204C0A;
	Mon, 17 Mar 2025 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6XPN0qd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C35202C40
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253671; cv=none; b=I50kExvJnYRwqRwJL2xrlwmbk6dqu+fCPHgj8KP4+pjLhYdvy3FUJUiHA+ZexV0S6j5lnabapK7mOsAJXQi/Mcu6WCwppJbzr1zhtSDHh9wLFK5IAW85lxAGEc8Orh1FAudie+/a5sIzPv5FDPGJKSWGX22I7IVKN7ysjR5v8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253671; c=relaxed/simple;
	bh=thZig93pGamR0fzTSt/D8t8Dg/04R+h7w6uzT5A88YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8nOC3jY+tHNC+978LPzfExTvNiaI91QHCOHN8A6hIgVPcVzPPXaUX3dhMslDKpPzimWceu6drgGVa86xUQTL+1L39JwbPwNkD6//Y1gApvxf0Wb6rQhQI9QMUudhBzBYTEoaxoAFGvs5JW9ITWceggH/HzuDyPWZBJkhyC0eCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6XPN0qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFE2C4CEE3;
	Mon, 17 Mar 2025 23:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742253671;
	bh=thZig93pGamR0fzTSt/D8t8Dg/04R+h7w6uzT5A88YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6XPN0qdiZ6pR7yLw2woYaWesucZNCm3nyU9v9u/uPKaNallNUoIBNhNyys2pKhrq
	 OwPBw4edEz/7su6AXE4NQTnR0JfOv3xDCTkqQczIfaLAYHvKIebg4Zjr88lHRewjvg
	 ET22UnfOuTCZO0SApRCY80vnbwGw9Xll26bKNEGzVUvV5D6cdO7isMZ7forUyeV/SP
	 H6paUTjUW7XF2MWLC3QREk0XI+doJ4ntcPH8snbLbIRRqdcKI3yDygHBVtBEaup87W
	 Wgka3IV4sP18pTLtqHgVUVhBgCAdFMP4jeccFNT2RR1fI/RJlt7riMBrmT5vBlJFYV
	 rCZpwUpU+u39w==
Date: Tue, 18 Mar 2025 00:21:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] x86/asm: Use asm_inline() instead of asm() in
 __untagged_addr()
Message-ID: <Z9iuYk-3YNKLAJip@gmail.com>
References: <20250317113013.182359-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317113013.182359-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Use asm_inline() to instruct the compiler that the size of asm()
> is the minimum size of one instruction, ignoring how many instructions
> the compiler thinks it is. ALTERNATIVE macro that expands to several
> pseudo directives causes instruction length estimate to count
> more than 20 instructions.
> 
> bloat-o-meter reports minimal code size increase
> (x86_64 defconfig with CONFIG_ADDRESS_MASKING, gcc-14.2.1):
> 
>   add/remove: 2/2 grow/shrink: 5/1 up/down: 2365/-1995 (370)
> 
> 	Function                          old     new   delta
> 	-----------------------------------------------------
> 	do_get_mempolicy                    -    1449   +1449
> 	copy_nodes_to_user                  -     226    +226
> 	__x64_sys_get_mempolicy            35     213    +178
> 	syscall_user_dispatch_set_config  157     332    +175
> 	__ia32_sys_get_mempolicy           31     206    +175
> 	set_syscall_user_dispatch          29     181    +152
> 	__do_sys_mremap                  2073    2083     +10
> 	sp_insert                         133     117     -16
> 	task_set_syscall_user_dispatch    172       -    -172
> 	kernel_get_mempolicy             1807       -   -1807
> 
>   Total: Before=21423151, After=21423521, chg +0.00%
> 
> The code size increase is due to the compiler inlining
> more functions that inline untagged_addr(), e.g:
> 
> task_set_syscall_user_dispatch() is now fully inlined in
> set_syscall_user_dispatch():
> 
> 	000000000010b7e0 <set_syscall_user_dispatch>:
> 	  10b7e0:	f3 0f 1e fa          	endbr64
> 	  10b7e4:	49 89 c8             	mov    %rcx,%r8
> 	  10b7e7:	48 89 d1             	mov    %rdx,%rcx
> 	  10b7ea:	48 89 f2             	mov    %rsi,%rdx
> 	  10b7ed:	48 89 fe             	mov    %rdi,%rsi
> 	  10b7f0:	65 48 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%rdi
> 	  10b7f7:	00
> 	  10b7f8:	e9 03 fe ff ff       	jmp    10b600 <task_set_syscall_user_dispatch>

So this was a tail-call optimization that jumped to a standalone 
<task_set_syscall_user_dispatch>, right? So now we'll avoid the 
tail-jump and maybe a bit of the register parameter shuffling? Which 
would explain the bloatometer delta of -172 for 
task_set_syscall_user_dispatch?

Could you also cite the first relevant bits of <task_set_syscall_user_dispatch>?

I don't seem to be able to reproduce this inlining decision, my version 
of GCC is:

  gcc version 14.2.0 (Ubuntu 14.2.0-4ubuntu2) 

which is one patch version older than your 14.2.1.

I tried GCC 11, 12, 13 as well, but none did this tail optimization, 
all appear to be inlining <task_set_syscall_user_dispatch> into 
<set_syscall_user_dispatch>. What am I missing?

Another question, where do the size increases in these functions come 
from:

>       __x64_sys_get_mempolicy            35     213    +178
>       syscall_user_dispatch_set_config  157     332    +175
>       __ia32_sys_get_mempolicy           31     206    +175
>       set_syscall_user_dispatch          29     181    +152

(I have to ask, because I have trouble reproducing with my toolchain so 
I cannot look at this myself.)

Thanks,

	Ingo

