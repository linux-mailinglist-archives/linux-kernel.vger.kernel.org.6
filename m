Return-Path: <linux-kernel+bounces-386841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7CE9B4883
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D32B227C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5C205155;
	Tue, 29 Oct 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Zwsn8yEj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aM0WKcLg"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBE2040B8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202299; cv=none; b=isWLA0hypxYBHTAaYKBl4Jgg8x8K05XLhHD2dZBjMAOW+8HxRJhaT6VEntiru7JCFw0w1qbsHtG8x/9BNioV/aYkW71mg1e0EB0psV5ukq9l9y3shjxcCNJ35ILI1zmE2v+OyVi8E9M+Xu1u7W45jaGHr1T83gazZnhmrnDhtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202299; c=relaxed/simple;
	bh=cGwghqZtH3FdxZgTxx8DicSQ+LBxrNTUaOlul740FdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfWZ8g29Jjlf+yC729PVYP4mQCWBUF/FVN7utp067vU9YZplPBZJAhSuxgB5pdiyX9+0wIZblpbRNCFU8l+K+tTPTgPHmloLhu3kieHAGH6VQ7XCPtw5Y5qLccOLU0bzWgfiNInMSBmR/C5kB9O/RRED+J38WqI33OIo2PtM3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Zwsn8yEj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aM0WKcLg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 76D8513801B6;
	Tue, 29 Oct 2024 07:44:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 29 Oct 2024 07:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730202295; x=
	1730288695; bh=2yhhCgEHp5rC8pZ/9rE4AScoEjDNa/UwiC/T7RhrIdY=; b=Z
	wsn8yEjjtdzjavd5ocNP+hcLG+HfNeFZ0Fd9Snt5DscpWZOJz1CfAfhM/KCZKMCY
	yGFPd2sbVwks020nkRzKjFM9T/vgEjPYj5I2/0ReNIvgFuQg5TheBEO3AtWu8gVv
	ZkMg5m7AL5zkcPdUh7kbq/tDg3ccbFXsg8d9EpoNA6q9mauHeYu+c+2ah2zx2c/m
	L7kLh/RNBmI27mPlWF7wkKLcH2OXKPpahIh6V7Y1AYFD4Gj1qeCXhn4FU9SIC+Mz
	d8sy7jgksIopAt/acCGj/XmnZ6muUAOEhYLVWhP7kLOdSR/gSMMCCvO7RD+ZWANN
	D9YRg8OrLjwVwenrPC5YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730202295; x=1730288695; bh=2yhhCgEHp5rC8pZ/9rE4AScoEjDNa/UwiC/
	T7RhrIdY=; b=aM0WKcLg2sBIyUZBXeJdy9Zdoy6sUNI0dlbY+QM10NVIjGTIc7S
	JRuiIwc3RkHaLAgdpKJDu7S0X39cCMT2oTd7MvxK0AB46Vxq1baSTLEwuWWZxJUK
	8PSdPGy8GjiMHxB3O/V+hp1I1n1TTGWg6OF8FzVd7QvRBuE8bElR30QUwKRCFMCk
	Vw3XdRtXY9gSKbdnvnlCezEoUzOyraxnpYcNGlbVgaCwAg5XKcgcmkZc3XDJo+Va
	BaZNjsdTOZNgw0fhHKGjpB7I5j3DkNMZO3vc3Lar8wJFXE+h4gyd4o5Z7uuccQ9w
	Ms4wRpiW2b7v2vPIsUMhHRXQ8p6z8aeSyMA==
X-ME-Sender: <xms:tsogZwmwGvH8hWt_-Z9qIo7slcJLDn_KdyRm_VRvNADgi33eBQbWcQ>
    <xme:tsogZ_0lxwBd7WzjlREVKSpNBY0_cNDGknqO64TWvdoIMiibRc8-Xg4zIuMqarhUh
    DnYA_xRKOGmD5XBHRQ>
X-ME-Received: <xmr:tsogZ-rSiKNce5dg_w17PzywjeNqChVT8E6tieLgH3MGnGZhdDUSEXrAYuIQ8EmJQVubTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepfdfmihhrihhllhcute
    drucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeen
    ucggtffrrghtthgvrhhnpedvffdugeetuedvtdffveetudduvdeutddthfevffdtveevhf
    dujeeuvdegfefhkeenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdr
    tghomhdpghhoohhglhgvrghpihhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlih
    grmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhorhgvnhii
    ohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrse
    hsuhhsvgdrtgiipdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepshihiigsohhtodegsgehtgejtdegtdduvdekledvtgegugdvvdhfugesshihii
    hkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    mhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepshihiihkrghllhgvrhdqsghughhsse
    hgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:tsogZ8l1Wy8LUEcY-zyRZ00zHLsrB4nzyUJVvMT8qJTKDRjCdxh6ag>
    <xmx:tsogZ-2AU3Xr187wG13HCaL0dWHIkUpZjFh6SuwO8DKWVofqBlwMFQ>
    <xmx:tsogZztvxdvtP426Ox8UXkwVkL3gW26b5ECms8OCEFTYzYWt8cayMg>
    <xmx:tsogZ6XvABx2I0_2liSFV30j25mUBvZcJeiY05OtUFqDQiVpO3iXfA>
    <xmx:t8ogZ8yaTZnD-zYBCbOmDKboB6DInfX0KuEp0YqYUFXuMQP3XV8_rtJ->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 07:44:51 -0400 (EDT)
Date: Tue, 29 Oct 2024 13:44:47 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in zap_huge_pmd
Message-ID: <ri2667onovzkphvyxqnxe724ymxqs52pkzpdesina35v55ccnr@4kghwz6eevom>
References: <67205708.050a0220.11b624.04bc.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67205708.050a0220.11b624.04bc.GAE@google.com>

On Mon, Oct 28, 2024 at 08:31:20PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10fb2ebb980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f730e7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177eae40580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com
> 
> R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
> R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
>  </TASK>
> ------------[ cut here ]------------
> kernel BUG at mm/huge_memory.c:2085!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5095 Comm: syz-executor380 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085

I believe it is bug in mmap_region() around handling
vms_gather_munmap_vmas() and vms_complete_munmap_vmas().

What reproduces does is:

1. Creating hugetlb mapping
2. Setting up UFFD on it
3. Creating a new that partially overlaps with mapping created on step 1

On step 3 an error is injected which makes vma_iter_prealloc() fail and
unmap_region() is called in error path.

The unmap_region() is called with the newly created as an argument, but
page tables still contain entries from hugetlb mapping that was never
fully unmapped because vms_complete_munmap_vmas() has not called yet.

Since the new VMA is not hugetlb, unmapping code takes THP codepath and
calls zap_huge_pmd(). zap_huge_pmd() sees PTE marker swap entry installed
by hugetlb_mfill_atomic_pte() and gets confused.

I don't understand vms_gather/complete_munmap_vmas() code well enough.
I am not sure what the right fix would be.
Maybe call vms_complete_munmap_vmas() earlier?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

