Return-Path: <linux-kernel+bounces-363976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1399C921
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECCB1C208BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD25917C227;
	Mon, 14 Oct 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="IfrTy+7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jn1R70Xh"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B219340F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905897; cv=none; b=QWIdxNAg33YUalCjSNGN9Aev6oQShFyxi+IEqOLb+TGWuplMxnVHHuj3s6C5Jo6wdWWtLquFv8EJlRCL7H4CGWBtbp/r1U7W/mvmsSY9cBwchccEtUIeHGMZn5Km24Brhfrb3STGb5YZeqr+C7SyyMH4j+pE+ItsgkFwrrPQpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905897; c=relaxed/simple;
	bh=we5+QWU5E1Uye+TsIkFprduan8O2m4uKdF2MhenbRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQbkPDjcax2qq5wz6fNZGbfGAWzpQcuVMTL4XkxA+taWYJxHL/gnfEURyB4VgglGrlOkcrIc48VULk77iyD8SJ1Bn+vtFUlpjbc39BIELaK1uY3z/KNeZ5q9BRtbnlWsdGiuybOUHpoe0CRnCm+6wabt8OY8rzWruoXz8HDou3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=IfrTy+7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jn1R70Xh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 13A891380432;
	Mon, 14 Oct 2024 07:38:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 07:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728905894; x=
	1728992294; bh=euvrIkuVWyjDvRRVyVHh3XbrC7wodWWz0wREFAZfjBQ=; b=I
	frTy+7d4PBgASUBZT5ySuaBSqG6dEmFg45L/31RTtFVEVmNYO55DNOTVpjcqllHW
	QHsjOT+rGfB/ZpMf+ceiN+Upq6ohSHQz6yN0ubDXsA5CVuaLAVCsByYZRYB4zU09
	1fTCGs3IjfMyHpdmkIfufWE5G/evlTBhA0PHhIpiF7RGhmTEDC3jVZY7wrPIXeln
	MhZxfMpLFBN/ejBEm7NFKwn2nouAFlQWTPheUsmvu2/W8m2F4N83IFVOylfLMlB7
	GfsU5Q6D3UvVO6WK4SKSkrIGTXLpMODNU/50Mj+fQ7+DOfcpHCXNnwUVnqxexAq2
	p0dhBzh0gTx7NiQ9V1ezA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728905894; x=1728992294; bh=euvrIkuVWyjDvRRVyVHh3XbrC7wo
	dWWz0wREFAZfjBQ=; b=jn1R70XhnrxJ/BTipN598K4Hr7ajPDCuykGBEiCDn7WX
	zoUYpWoAswPNnmFrNw4v/494+cesyVQmiGug4W8L1zMAGQKoAAxFEqXF5gA2S9qe
	r3K3MFwujhX8SfRk3fIdPFSnDqIl1px4MxJxLWOlzXIYfvi8dkgX7ORFQqLM38QO
	xwjDXG4Sc7ygQTrmmpYgp9Guo0GqFofzQXPvRYF3IaEKhYHMSHh1Mav4aNU+l/5l
	j8yVOwEU9qwZ/3rUogycZ0lo2kEuEhkw8ujCp873sjthlkhpv2wqFfZzFMqrrTIW
	a7rLP2FzBHadNcMu5LIEuJwbl8B8ivyDkbHPCRbH7Q==
X-ME-Sender: <xms:pQINZzsUrtTEOue5bOllFpH5cRAlo0jAfxpYwxYz70UqBZWktPYIcg>
    <xme:pQINZ0e7pQy0uOL6pMf9dl5RNzmaOlShTngUEcm2OzFvoN-aDPrNwnKOYE63u49hh
    h13LJfeZsi8hZa8Zpw>
X-ME-Received: <xmr:pQINZ2zfpncAoLbawcZwKRgNbeuGeFZ7dGD_MH1ACPYOHMCBn5uTpOmKx9XbnAq7r9M7eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepfdfmihhrihhllhcute
    drucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeen
    ucggtffrrghtthgvrhhnpedvffdugeetuedvtdffveetudduvdeutddthfevffdtveevhf
    dujeeuvdegfefhkeenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdr
    tghomhdpghhoohhglhgvrghpihhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguhh
    hofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshihiigsohhtoddtvgdu
    jeegkeeitdeftggtlehfvdgufhgtkeejugesshihiihkrghllhgvrhdrrghpphhsphhoth
    hmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepshihii
    hkrghllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:pQINZyOVO8Mc-GsbAJaaWSy_7ekKGsfkA1EXyJLgvsR03pODb9tX6w>
    <xmx:pQINZz-247o0dsLXYSSKg-O4Ju8AkLapnqMSJMiyaEoqfykGS2UvpQ>
    <xmx:pQINZyXPq01Z6GKKeDNjgHo1bFIULBry2oN6E6mrgUQh2zp9oiFt7Q>
    <xmx:pQINZ0cC_Ozhd3e-vXkTEzZx1xJ0foGqpLT4XVbaaJNuk59xd2jebw>
    <xmx:pgINZ0OlIPBKMZaWz05hGJnsNi2__un32ETXETzlfS6OltVt6K3LGIA6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 07:38:11 -0400 (EDT)
Date: Mon, 14 Oct 2024 14:38:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: David Howells <dhowells@redhat.com>, 
	syzbot <syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in compat_sys_open
Message-ID: <ukvr42gn4t5i3sq5eynyv4yl2bihjkcrtlwccguvavjvd4rumk@zlzmahzoystu>
References: <670cb3bd.050a0220.4cbc0.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670cb3bd.050a0220.4cbc0.0040.GAE@google.com>

On Sun, Oct 13, 2024 at 11:01:33PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    27cc6fdf7201 Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13043307980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3e4d87a80ed4297
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e1748603cc9f2dfc87d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-27cc6fdf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ae2f7d656e32/vmlinux-27cc6fdf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1b06a62cc1e5/bzImage-27cc6fdf.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0e1748603cc9f2dfc87d@syzkaller.appspotmail.com
> 
> BUG: TASK stack guard page was hit at ffffc90002b3ffb8 (stack is ffffc90002b40000..ffffc90002b48000)
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 12425 Comm: syz.2.2179 Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
> Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 89 d6 48 ba 00 00 00 00 00 fc ff df 41 55 41 54 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 44 24 30 48 c7 44 24 38 38 51 57
> RSP: 0018:ffffc90002b3ffc0 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000003
> RDX: dffffc0000000000 RSI: ffff888021edaf98 RDI: ffff888021eda440
> RBP: ffffc90002b40100 R08: 0000000000000000 R09: 0000000000000006
> R10: ffffffff9698ad37 R11: 0000000000000002 R12: dffffc0000000000
> R13: ffff888021edaf98 R14: 0000000000000008 R15: ffff888021eda440
> FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f56f6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: ffffc90002b3ffb8 CR3: 000000005f61e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <#DF>
>  </#DF>
>  <TASK>
>  mark_usage kernel/locking/lockdep.c:4646 [inline]
>  __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
>  rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  page_ext_get+0x3a/0x310 mm/page_ext.c:525
>  __set_page_owner+0x9a/0x790 mm/page_owner.c:322
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x223/0x25c0 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>  alloc_slab_page mm/slub.c:2412 [inline]
>  allocate_slab mm/slub.c:2578 [inline]
>  new_slab+0x2ba/0x3f0 mm/slub.c:2631
>  ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4141
>  p9_tag_alloc+0x9c/0x870 net/9p/client.c:281
>  p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
>  p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
>  p9_client_read_once+0x443/0x820 net/9p/client.c:1560
>  p9_client_read+0x13f/0x1b0 net/9p/client.c:1524
>  v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
>  netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
>  netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
>  netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
>  netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:369
>  netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:405
...


This recursion looks borken:

    netfs_rreq_terminated
      netfs_rreq_assess
	netfs_retry_reads
	  netfs_rreq_terminated

It ate the stack.

Seems to be introduced in ee4cdf7ba857 ("netfs: Speed up buffered
reading").

David?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

