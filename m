Return-Path: <linux-kernel+bounces-249878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56E92F10B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3641F22F25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF619EEAC;
	Thu, 11 Jul 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2Axne4Hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D68BFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732939; cv=none; b=dqG6s0CcFjOHgary/8cz/IT4VBvbBQYDKN+LaYRHN2nIVcInI/ug57bPzMtnUjJ+1Hs2jN0xuPp5E4UCce9FiyWPGnimtS1J4OPd/gPL75pgKUJgaXWtHx9mrBmh9H8uaZR3WodVnAkFA8ZCwddwdsRJi83HnJbm3zw/lyatnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732939; c=relaxed/simple;
	bh=/mbJ+XRONhT7IsDgSCXno0F6qXvQkSst1AklRybqCpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KGHDMZ5ghdfThsTbzTLKokKYEYuCR0U+Oiq7lVPnf/0eHtxO/6LqfzHI/Ter7+mepWhvzJSTt13YIUNmU66WGWrqQ/qbKn08lnDJCsugdcmoDAPCTl9b44gICf+B3IA4JEXnwsHocIUuPeGEc2cBr42nRUZj9+CyJFPxLFGEs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2Axne4Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B24C116B1;
	Thu, 11 Jul 2024 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720732939;
	bh=/mbJ+XRONhT7IsDgSCXno0F6qXvQkSst1AklRybqCpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2Axne4Higf0e5oaGs16W1MWLjsHliczx94EyuzlopmRuR4GNroE40Fe/leNt32sQI
	 XQ5+AAi5W97H1FlEBbOtUnWsVe1omKxakNtH/oWWl/NQkwn/mAqGWkV6LYOdDxW4a7
	 J3RzJRo860mSG0KlyWqAOZY/ERBtnEIABDdQSGb4=
Date: Thu, 11 Jul 2024 14:22:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pei Li <peili.dev@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
Message-Id: <20240711142218.d7a6cec31366044cbb96a312@linux-foundation.org>
In-Reply-To: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
References: <20240710-bug12-v1-1-0e5440f9b8d3@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 22:13:17 -0700 Pei Li <peili.dev@gmail.com> wrote:

> This patch fixes this warning by acquiring read lock before entering
> untrack_pfn() while write lock is not held.
> 
> syzbot has tested the proposed patch and the reproducer did not
> trigger any issue.
> 

Thanks.

> ---
> Syzbot reported the following warning in follow_pte():
> 
> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 rwsem_assert_held include/linux/rwsem.h:195 [inline]
> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 mmap_assert_locked include/linux/mmap_lock.h:65 [inline]
> WARNING: CPU: 3 PID: 5192 at include/linux/rwsem.h:195 follow_pte+0x414/0x4c0 mm/memory.c:5980
> 
> This is because we are assuming that mm->mmap_lock should be held when
> entering follow_pte(). This is added in commit c5541ba378e3 (mm:
> follow_pte() improvements).
> 
> However, in the following call stack, we are not acquring the lock:
>  follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
>  get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
>  untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
>  unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
>  zap_page_range_single+0x326/0x560 mm/memory.c:1920
> 
> In zap_page_range_single(), we passed mm_wr_locked as false, as we do
> not expect write lock to be held.
> In the special case where vma->vm_flags is set as VM_PFNMAP, we are
> hitting untrack_pfn() which eventually calls into follow_phys.

I included the above (very relevant) info in the changelog.

And I added 

	Fixes: c5541ba378e3 ("mm: follow_pte() improvements")

and queued the patch for 6.10-rc7.  Hopefully David can review it for us.



