Return-Path: <linux-kernel+bounces-292832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2459574FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892B2281DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F421DD3A4;
	Mon, 19 Aug 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdhVOjeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C71553BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097083; cv=none; b=DXI65syAWTmRkIXDAkZ2DRIcIoTEGIJosS0qg+NZGivewWaHfyJFCPhaloAyvQuSQWFI/UiKa4xDW18tTnvHmWXgOFppj7hWsJj7bokQUd3VfPqyVNAczh0/s5Q5Oy7iJolRVN7q8TpQ3gNVPeMI0fMXyF+xnfxxICDyhEPi1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097083; c=relaxed/simple;
	bh=McJ9UJAr4K3xYwTvvJs50F0sBT4fzSmHo3T/Mzh4kTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx+2yXPtH6Kymp75av9w06zq3Lagcj6+VDODpowEWlG3AP8pOZP3vmvseVkcHE9qa2tGcnjGpRUdaYquRTURY9BnePaQb2EK0ejyoNxp043hhPwk6tsxCRUYe2540g1ccknWWKajWTpaX072BV0tWB3Ym2KtXXaAH0pwRqQiIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdhVOjeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE098C32782;
	Mon, 19 Aug 2024 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724097082;
	bh=McJ9UJAr4K3xYwTvvJs50F0sBT4fzSmHo3T/Mzh4kTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdhVOjeuaWsPp1GeaLjwewGgxv58pOwEVGsCcjyDXDJ8LVA717cim1U2OXxi7lKrH
	 6YRjLWNnxvpo+cSVJTdTgEfqUQZRWGjHE1RU+HCopNCHPxbfHU+Xbbhiw8bnsSUPqX
	 5XUmS+NaCIOwPjv8CxONOAqCIrB4TxMeNhsF6Da/MBWmtafIC/Z1tWflXBSM89zBcF
	 cb8mQeAfYRubTrea091EZ8Ee1KBsirUCQN0Evtl16LqIvq1QDudx1FzaO8oqpgnc2J
	 88gAGQVcxouO9ALNbezvS79ZVonjBatsr0qBamzNkGigQpSIt1OtB64LwphFi+kN2M
	 ovy1vttjH7M9A==
Date: Mon, 19 Aug 2024 12:51:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu, jeffxu@google.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-ID: <20240819195120.GA1113263@thelio-3990X>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>

On Mon, Aug 19, 2024 at 12:29:34PM -0700, Linus Torvalds wrote:
> On Mon, 19 Aug 2024 at 11:53, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> >
> > Modules linked in:
> > Pid: 24, comm: mount Not tainted 6.11.0-rc4-next-20240819
> > RIP: 0033:0x68006f6c
> > RSP: 000000006c8bfc68  EFLAGS: 00010206
> > RAX: 0000000068006f6c RBX: 0000000068a0aa18 RCX: 00000000600d8b09
> > RDX: 0000000000000000 RSI: 0000000068a0aa18 RDI: 0000000068805120
> > RBP: 000000006c8bfc70 R08: 0000000000000001 R09: 0000000068ae0308
> > R10: 000000000000000e R11: ffffffffffffffff R12: 0000000000000001
> > R13: 0000000068a0aa18 R14: 0000000000000015 R15: 0000000068944a88
> > Kernel panic - not syncing: Segfault with no mm
> > CPU: 0 UID: 0 PID: 24 Comm: mount Not tainted 6.11.0-rc4-next-20240819 #1
> > Stack:
> >  600caeff 6c8bfc90 600d8b2a 68944a80
> >  00000047 6c8bfda0 600cbfd9 6c8bfd50
> >  68944ad0 68944a88 7f7ffff000 7f7fffffff
> > Call Trace:
> >  [<600caeff>] ? special_mapping_close+0x16/0x19
> 
> Hmm. No "Code:" line? Did you just edit that out, or maybe UML doesn't
> print one out?

Nope, no editing, it is straight from my terminal. I guess UML just doesn't
print one.

> Anyway, for me that special_mapping_close() disassembles to
> 
> 
>  <+0>:  mov    %rdi,%rsi
>  <+3>:  mov    0x78(%rdi),%rdi
>  <+7>:  mov    0x20(%rdi),%rax
>  <+11>: test   %rax,%rax
>  <+14>: je     0x600caa11 <special_mapping_close+24>
>  <+16>: push   %rbp
>  <+17>: mov    %rsp,%rbp
>  <+20>: call   *%rax
>  <+22>: pop    %rbp
>  <+23>: ret
>  <+24>: ret
> 
> which may just match yours, because special_mapping_close+0x16 is
> obviously that +22, and it's the return point for that call.

Yeah seems like it, objdump -dr shows:

0000000000000027 <special_mapping_close>:
      27:   48 89 fe                mov    %rdi,%rsi
      2a:   48 8b 7f 78             mov    0x78(%rdi),%rdi
      2e:   48 8b 47 20             mov    0x20(%rdi),%rax
      32:   48 85 c0                test   %rax,%rax
      35:   74 08                   je     3f <special_mapping_close+0x18>
      37:   55                      push   %rbp
      38:   48 89 e5                mov    %rsp,%rbp
      3b:   ff d0                   call   *%rax
      3d:   5d                      pop    %rbp
      3e:   c3                      ret
      3f:   c3                      ret

> And your %rax value does match that invalid %rip value of 0x68006f6c.
> 
> So it does look like it's jumping off to la-la-land, and the problem is the code
> 
>         const struct vm_special_mapping *sm = vma->vm_private_data;
> 
>         if (sm->close)
>                 sm->close(sm, vma);
> 
> where presumably 'vm_private_data' isn't a "struct vm_special_mapping *" at all.
> 
> And I think I see the problem.
> 
> When we have that 'legacy_special_mapping_vmops', then the
> vm_private_data field actually points to 'pages'.
> 
> So the 'legacy_special_mapping_vmops' can *only* contain the '.fault'
> handler, not the other handlers.
> 
> IOW, does something like this fix it?
> 
>   --- a/mm/mmap.c
>   +++ b/mm/mmap.c
>   @@ -2095,7 +2095,6 @@ static const struct vm_operations_struct
> special_mapping_vmops = {
>    };
> 
>    static const struct vm_operations_struct legacy_special_mapping_vmops = {
>   -       .close = special_mapping_close,
>           .fault = special_mapping_fault,
>    };

Yes, that appears to fix it for me. I don't have much to say about the
rest but others might :)

Cheers,
Nathan

