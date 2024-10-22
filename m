Return-Path: <linux-kernel+bounces-375450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FEC9A961C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E6AB2172A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB912C81F;
	Tue, 22 Oct 2024 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKGXCrBb"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596018037
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563396; cv=none; b=scccrUDUQG3BejApEgsk7OqDYkUiRy7+eO9rsAXdroBVFHRStWWujx6TwzNhOeNcJSF+TRoMOJ+CWq1UrLW+mU1cbQ4Wjk/YyYMRAUcqqMBWz693UnzY7X3PddjKXzQI/Z/l0/aPjv8r4p8Ummbnt3lQgi1yyKcfYmA7JiBwxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563396; c=relaxed/simple;
	bh=lZ8LOhrXELCzlUAANkuRIJBGFid1yI0VOtGi3sl/API=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLiksNVtuYwomHDLGuAxAvM8hjbR41+owVrF6//2dxFMPo8pVGJyhVWNaQcou+w4B03gV+HZPmqZdQae6Hc192em5BdCl1zH7siEA1vT+DhVGKFmsAkrGyKxbJuo1K4cubaYxG6kXEIBPnwoAWNcRzbBnWka3GY3kutBxp9kPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKGXCrBb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 02:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729563392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PABLEHqBbAv1qMkTJjeTZTBdgWmacrEo5Nko1BqIF7g=;
	b=cKGXCrBbe7avH8stOZa0m3hcV2m3v5VtvuUVlDbRpzzJP/zprBM1TZ4J98IephmMqZZAdT
	Ca1mUUAC7DnmWDhLPTgmp6GkYWO3553X7ClvIUaoGEpv8l/26d43hncbDMviQQy7uk1DHE
	tQanb2y8UP0dpEQrFFpdQcov6WZ57Rw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <ZxcK_Gkdn0fegRl6@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <d50407d4-5a4e-de0c-9f70-222eef9a9f67@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50407d4-5a4e-de0c-9f70-222eef9a9f67@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 12:49:28PM -0700, Hugh Dickins wrote:
> On Mon, 21 Oct 2024, Roman Gushchin wrote:
> 
> > Syzbot reported a bad page state problem caused by a page
> > being freed using free_page() still having a mlocked flag at
> > free_pages_prepare() stage:
> > 
> >   BUG: Bad page state in process syz.0.15  pfn:1137bb
> >   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881137bb870 pfn:0x1137bb
> >   flags: 0x400000000080000(mlocked|node=0|zone=1)
> >   raw: 0400000000080000 0000000000000000 dead000000000122 0000000000000000
> >   raw: ffff8881137bb870 0000000000000000 00000000ffffffff 0000000000000000
> >   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> >   page_owner tracks the page as allocated
> >   page last allocated via order 0, migratetype Unmovable, gfp_mask
> >   0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 3005, tgid
> >   3004 (syz.0.15), ts 61546  608067, free_ts 61390082085
> >    set_page_owner include/linux/page_owner.h:32 [inline]
> >    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
> >    prep_new_page mm/page_alloc.c:1545 [inline]
> >    get_page_from_freelist+0x3008/0x31f0 mm/page_alloc.c:3457
> >    __alloc_pages_noprof+0x292/0x7b0 mm/page_alloc.c:4733
> >    alloc_pages_mpol_noprof+0x3e8/0x630 mm/mempolicy.c:2265
> >    kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
> >    kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
> >    kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5500 [inline]
> >    kvm_dev_ioctl+0x13bb/0x2320 virt/kvm/kvm_main.c:5542
> >    vfs_ioctl fs/ioctl.c:51 [inline]
> >    __do_sys_ioctl fs/ioctl.c:907 [inline]
> >    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
> >    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >    do_syscall_64+0x69/0x110 arch/x86/entry/common.c:83
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >   page last free pid 951 tgid 951 stack trace:
> >    reset_page_owner include/linux/page_owner.h:25 [inline]
> >    free_pages_prepare mm/page_alloc.c:1108 [inline]
> >    free_unref_page+0xcb1/0xf00 mm/page_alloc.c:2638
> >    vfree+0x181/0x2e0 mm/vmalloc.c:3361
> >    delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
> >    process_one_work kernel/workqueue.c:3229 [inline]
> >    process_scheduled_works+0xa5c/0x17a0 kernel/workqueue.c:3310
> >    worker_thread+0xa2b/0xf70 kernel/workqueue.c:3391
> >    kthread+0x2df/0x370 kernel/kthread.c:389
> >    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > 
> > A reproducer is available here:
> > https://syzkaller.appspot.com/x/repro.c?x=1437939f980000
> > 
> > The problem was originally introduced by
> > commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
> > clearance"): it was handling focused on handling pagecache
> > and anonymous memory and wasn't suitable for lower level
> > get_page()/free_page() API's used for example by KVM, as with
> > this reproducer.
> > 
> > Fix it by moving the mlocked flag clearance down to
> > free_page_prepare().
> > 
> > The bug itself if fairly old and harmless (aside from generating these
> > warnings).
> > 
> > Closes: https://syzkaller.appspot.com/x/report.txt?x=169a47d0580000
> > Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: <stable@vger.kernel.org>
> > Cc: Hugh Dickins <hughd@google.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Thanks Roman - I'd been preparing a similar patch, so agree that this is
> the right fix.

Thank you!

> I don't think there's any need to change your text, but
> let me remind us that any "Bad page" report stops that page from being
> allocated again (because it's in an undefined, potentially dangerous
> state): so does amount to a small memory leak even if otherwise harmless.

It looks like I need to post v3 as soon as I get a publicly available
syzkaller report, so I'll add this to the commit log.

Thanks!

