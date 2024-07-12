Return-Path: <linux-kernel+bounces-251168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BDD930178
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548A3282BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788149624;
	Fri, 12 Jul 2024 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z5dFQlJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16C482C1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818563; cv=none; b=NkEW9Bto9Psy9wT9HsCAHq67V/9qoviLlRlPru3ddUt3grL6j4HL58J6Op2/K6PuKLyrrps6zGiRMcV7A9UG+QkEviDlnVJ6/2yAgMnVho5/6XRddGoKzKlLJ82R2yDSiXrVRruh5N5j9Oc9iTRE6DHXUuXpnz0FsqPWfyrbUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818563; c=relaxed/simple;
	bh=R274oE0i6C8f+zj2r4ya+8raQGqMtavQcoAxIuhk+o4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NYW5nNx6dEeqrGdTkyfBzuAEUdg+U/gegvuMtfNg+5pBJF+E9Levt7fsB8v3sRAZsCD9OCIbsOtdq+S/47Gciu5WKGm7qsLh0KKBl/lsxhJ42UiUNCExQriZZZpy1kv4weFlNkiFGuqPh9pPjsjh5EChYMNdXdyqK4+HPe+bS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z5dFQlJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2976FC4AF09;
	Fri, 12 Jul 2024 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720818563;
	bh=R274oE0i6C8f+zj2r4ya+8raQGqMtavQcoAxIuhk+o4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5dFQlJEQZ5wQfYBl99RcFCGNf/3DQY5ic+0EOdONPRQp3/avV6RRICnHA2x8mMAE
	 8u8dWV0GEaFuWWgbsTkl3oJ2kNTmzQ0dDvrfvlKhliDGb3mhAMJjLInZ89U73JSaSg
	 A9MHPJTwJG375Y/ixCHg/rAppIhzvJBEP0COpoAA=
Date: Fri, 12 Jul 2024 14:09:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memory-failure: fix
 VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
Message-Id: <20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
In-Reply-To: <20240712064249.3882707-1-linmiaohe@huawei.com>
References: <20240712064249.3882707-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 14:42:49 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When I did memory failure tests recently, below panic occurs:
> 
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
> kernel BUG at include/linux/page-flags.h:616!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
> RIP: 0010:unpoison_memory+0x2f3/0x590
> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  unpoison_memory+0x2f3/0x590
>  simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>  debugfs_attr_write+0x42/0x60
>  full_proxy_write+0x5b/0x80
>  vfs_write+0xd5/0x540
>  ksys_write+0x64/0xe0
>  do_syscall_64+0xb9/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f08f0314887
> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>  </TASK>
> Modules linked in: hwpoison_inject
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:unpoison_memory+0x2f3/0x590
> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> The root cause is that unpoison_memory() tries to check the PG_HWPoison
> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
> triggered.

I'm not seeing the call path.  Is this BUG happening via

static __always_inline void __ClearPage##uname(struct page *page)	\
{									\
	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
	page->page_type |= PG_##lname;					\
}

?

If so, where's the callsite?

> This can be reproduced by below steps:
> 1.Offline memory block:
>  echo offline > /sys/devices/system/memory/memory12/state
> 2.Get offlined memory pfn:
>  page-types -b n -rlN
> 3.Write pfn to unpoison-pfn
>  echo <pfn> > /sys/kernel/debug/hwpoison/unpoison-pfn
> 

I guess cc:stable.  It looks old?  Can you help to identify the Fixes:
target?

Thanks.

