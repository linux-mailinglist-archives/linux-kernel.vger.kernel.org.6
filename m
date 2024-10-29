Return-Path: <linux-kernel+bounces-386976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AE9B4A58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A94F1F24038
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D6205126;
	Tue, 29 Oct 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="FLiCmXCU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+M6/08A"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE58BEA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206695; cv=none; b=EgDBrm9jaY34LgU9uAhdPdV/8vdvA1zFYPUiICxFeKwEi1Q5xj2ySztl50J/raTYJUHro0Gw+CkZMhPtvEtvu1l5g4Dv4CHOPQyiJ/yBwDi9dpZ7Uk0LMGpkDp7wTNQENIghV3FMQ/GbBwj0dhXQJ4QjnFzbXhOqUPPUeTLpy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206695; c=relaxed/simple;
	bh=JP4+nbkRKwxRmpRchnmX7SYExr13wEFiR5EzsC/l70E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfFykSmhC1bZGAzXba/mldrSouBbS+T2zSSdW0RjxFisvzyxSwRDYZcMavMG8CuuoRP2KkX2wESlC8ztAOhe6T23s8khX3xxSi6zvjZn2weed8L9CoqqVjLabJb4l+dH+N1vA4V3dYCA4z/XgqnJWPwHR0fTB4dqb+716a6o6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=FLiCmXCU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+M6/08A; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 22CC2138042B;
	Tue, 29 Oct 2024 08:58:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Oct 2024 08:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730206691; x=
	1730293091; bh=MkwNu/f8kONwvdOyDcH7H6PdkajNfgH9UgOlaZjZQLE=; b=F
	LiCmXCU7CfgRhxZUCBIPTHRliIW0eJsJefDfqs/KNArugyMt9VnRb8E2Ci37n7iD
	1yTLlM1KIwSemd8VrtnSiIwvAQ6h/eKWQ9NL42VjAl/Wa7f8RserOYFPV4EO0gvh
	H/3G53wrpLMkJM9UCl09CzM2EMBQB8AD9/JQN0qnRXmR3xcrrwbvYOV7HLekcTmG
	k6NCc/cSBadOs0+n5GKT0ij92wPZfxqxFHCGMF3etUJnGQX5N/gtVTin4+mZOyjv
	MGJvYBB1DNPt+SlwCrmYcfGVka1J4RkOhJpMIlxRziAdFAaWZK6bmIMqlgz2uKhw
	zuPqIUEIh1pSbG45YiI/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730206691; x=1730293091; bh=MkwNu/f8kONwvdOyDcH7H6PdkajNfgH9UgO
	laZjZQLE=; b=A+M6/08An0PUXiByp9tmxKCQGHTlN1/QTf03pfbg0pj/yxUgjzK
	l4UtXFOPQq3XrpUhhFTUbVwE/tW6nTTvyfQq4NDVMLeFGcnilJ6C3xZTUbm94KNt
	5QmbZRoZKcIg/dH81OWXY38YKCwFLPLK1G2obpR81T3SsAIivkmql7+SYOBTETBZ
	kkxwOvBhxTNaJpf088YZtr+AnNenfpfYt7oZm/mio5P21G8O+/aoIeCQEpzLJ2TW
	cC5BB3grsxngrveSZlls+6McCf0l4Q/lXN6j1NvAhk2JeCegZePqpIa/ObxOU7LD
	r13WCCdPMSgXUi3UWBnV9Upm7HP3xfUncFQ==
X-ME-Sender: <xms:4tsgZ-cBSSAPRznTO8zzYLqMbdOq89LF3FScsnnkhHusysdaIrTljA>
    <xme:4tsgZ4N1tbHYQabm3oupRD9_e3I5RhhRZzBZOFVZd3uTRarhpQXKxlxrgM2jAU_9x
    eoccasU_x9vjLd4yWY>
X-ME-Received: <xmr:4tsgZ_gS-5dYdxRDhLdv_9xHhhETqWfBdPrgkLZMduUn9eM7p7n0eVY4A-BdXpKVCyeTtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepfdfmihhrihhllhcute
    drucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeen
    ucggtffrrghtthgvrhhnpedvffdugeetuedvtdffveetudduvdeutddthfevffdtveevhf
    dujeeuvdegfefhkeenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdr
    tghomhdpghhoohhglhgvrghpihhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehloh
    hrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgr
    mhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrse
    hsuhhsvgdrtgiipdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepshihiigsohhtodegsgehtgejtdegtdduvdekledvtgegugdvvdhfugesshihii
    hkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    mhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepshihiihkrghllhgvrhdqsghughhsse
    hgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:4tsgZ79PdRpkCtRB1ua77Bzh_evP3BBtSVOo8vg3jtXYgDingVQ2kw>
    <xmx:4tsgZ6tS8AsgiOL7eqMR5BrJR04awtdbJdcHuLl_lZHjPGAXSBhmAg>
    <xmx:4tsgZyFxIwBvFRergvhYlm6O6NkYlTt4VFMRY1hMf0_pi1zMuh70Rg>
    <xmx:4tsgZ5NixEHDo2-P8VxEE1rNENaGuZMKxnuQpbVzYzG6NUvULsn8jw>
    <xmx:49sgZ0LeCYKFadvC_1tSoYUnhUuu4XK7CzKJsGBs4LcHzuQBayCmHbRu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 08:58:06 -0400 (EDT)
Date: Tue, 29 Oct 2024 14:58:02 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in zap_huge_pmd
Message-ID: <lifszx2644jx4dzc537w645wtk3qo7q5xxeam7ad7lihagvt7z@dooml2xm73dx>
References: <67205708.050a0220.11b624.04bc.GAE@google.com>
 <ri2667onovzkphvyxqnxe724ymxqs52pkzpdesina35v55ccnr@4kghwz6eevom>
 <3b06d23d-de9e-471f-ab99-54c96cb077bd@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b06d23d-de9e-471f-ab99-54c96cb077bd@lucifer.local>

On Tue, Oct 29, 2024 at 12:07:00PM +0000, Lorenzo Stoakes wrote:
> On Tue, Oct 29, 2024 at 01:44:47PM +0200, Kirill A. Shutemov wrote:
> > On Mon, Oct 28, 2024 at 08:31:20PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10fb2ebb980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f730e7980000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177eae40580000
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com
> > >
> > > R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
> > > R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
> > >  </TASK>
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/huge_memory.c:2085!
> > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > CPU: 0 UID: 0 PID: 5095 Comm: syz-executor380 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
> >
> > I believe it is bug in mmap_region() around handling
> > vms_gather_munmap_vmas() and vms_complete_munmap_vmas().
> >
> > What reproduces does is:
> >
> > 1. Creating hugetlb mapping
> > 2. Setting up UFFD on it
> > 3. Creating a new that partially overlaps with mapping created on step 1
> >
> > On step 3 an error is injected which makes vma_iter_prealloc() fail and
> > unmap_region() is called in error path.
> >
> > The unmap_region() is called with the newly created as an argument, but
> > page tables still contain entries from hugetlb mapping that was never
> > fully unmapped because vms_complete_munmap_vmas() has not called yet.
> >
> > Since the new VMA is not hugetlb, unmapping code takes THP codepath and
> > calls zap_huge_pmd(). zap_huge_pmd() sees PTE marker swap entry installed
> > by hugetlb_mfill_atomic_pte() and gets confused.
> >
> > I don't understand vms_gather/complete_munmap_vmas() code well enough.
> > I am not sure what the right fix would be.
> > Maybe call vms_complete_munmap_vmas() earlier?
> 
> We just changed around how this stuff aborts in a hotfix series that should
> avoid this, actually.
> 
> Unfortunately I don't have the netlink setup syzbot has locally so not sure
> how reliably i can repro.

Build the config in the report and run it under KVM (virtme?).


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

