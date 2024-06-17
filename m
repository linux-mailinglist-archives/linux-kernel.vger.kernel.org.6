Return-Path: <linux-kernel+bounces-218441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4190BFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DB8282A29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181DB19923B;
	Mon, 17 Jun 2024 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar5PQ4eC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7A288BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668081; cv=none; b=X/yNBdPFOm5jR7OuTzfuJ7ojONORqu54Zy+inx4wurhmghUP33Uiwe7LszxG49RqSF+mj9j5z+1DA1eqIoVb425NnwGzWQMYS1wD8HWPFIDznj+/LPW9zNLdmDzUP3Awa4m7T7lk8Oug3ZHq+KQjrmeLTtvGNEK0GKoT342tK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668081; c=relaxed/simple;
	bh=BImYMm5B7jO/CLHn58PIBXuFp1QuOojZpa4T5sCKN7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Se0JG+wqFPaVimFbrHmqrz2E8vOZO3p3rx2Fgp7wxbpxA/p2ZRlUN3DbtIvGGiLQxyjBASHjda4kN5rpIJ9Na+YVyArtf0U/8vAC6h1aUygSjc+FQufwaSk7FGTwGSE05PxEq8kr6hFI3vj+/0QnkHiS8Ib2GopCYYhlrY7xZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar5PQ4eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BEBC4AF1D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718668080;
	bh=BImYMm5B7jO/CLHn58PIBXuFp1QuOojZpa4T5sCKN7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ar5PQ4eCt9aTO4PcnqFVYtTP7TrCBXgU9uuLs0gHCC4iiyl53yVZuB90EZ9xUAGxp
	 29ARdK7Sxn0g05gPQHbfB2Q6zxtawCF/yNYxuyo7o3MU0hGmrjHDd0tC6FNVOPYNWq
	 3sfTgJKuFdOuhFNziO3waDucUUbo6iiQl4LOGh2Nc8UG9uC4Jb7YMiIMfQd5U7UmVR
	 izsbQYEKTiFOIMn4XSgKYN8XTh/Vsb3kXycXCH3zkYSC5fnSGRmURtV619U13kSXgi
	 Xmxbw87wE9rxEG/B6xB5EWt5QseVsjKTP4K6ihbMRKRoXo940nNgiOoB8vP3qbVGsy
	 CJtOoQTKv5m2A==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375fb45f465so5452455ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:48:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKhJ+KmLInclIRBzflEDgw8MVL0PfkCoysoaltmnm4Ra70eXex7LpKfTWFXtEdrZykxvfhfqzWvHQDPgK1zc+7Z/6hLdok5RRRdXB2
X-Gm-Message-State: AOJu0YxlhnDzSlfFz+9QPUCQ57HOQz/1PokP2OKRr3FvNsIZtBBQ38n3
	zzdPiWx0ZPC1fsAhYWImCJt+a0Wp8RAtRo6zvcYyY6qv3fUH56BfzcXoZPajoac3K7BIViDbiOM
	UVGTUHS4B8nulex8X0+wL2fu7DYgzzmChRoKe
X-Google-Smtp-Source: AGHT+IHEOsLtSuzJyMhnIL1JLcdMUDU0DYNi7mwXj2jPXhOEYYD5zdUAaH9Tsi+UXh32q3/3Wf6F7AwJpegtX4jQ1Ms=
X-Received: by 2002:a05:6e02:1c2a:b0:375:9e20:beef with SMTP id
 e9e14a558f8ab-375e0c4cb8emr129089605ab.0.1718668079743; Mon, 17 Jun 2024
 16:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
 <20240615084714.37499-1-21cnbao@gmail.com> <CAF8kJuNAuuR489b=etm3-ZNLcvMmuQhUAP2cdG=AgKSLMoZ2wg@mail.gmail.com>
 <8db63194-77fd-e0b8-8601-2bbf04889a5b@google.com>
In-Reply-To: <8db63194-77fd-e0b8-8601-2bbf04889a5b@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 17 Jun 2024 16:47:46 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMFxM25aCgqreMDaYziQ-SuZxfq9uK0CwwquQdsH-iGQw@mail.gmail.com>
Message-ID: <CAF8kJuMFxM25aCgqreMDaYziQ-SuZxfq9uK0CwwquQdsH-iGQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Hugh Dickins <hughd@google.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, baohua@kernel.org, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:00=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Mon, 17 Jun 2024, Chris Li wrote:
> > On Sat, Jun 15, 2024 at 1:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > > On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> > > > On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wro=
te:
> > > >
> > > > > > I'm having trouble understanding the overall impact of this on =
users.
> > > > > > We fail the mTHP swap allocation and fall back, but things cont=
inue to
> > > > > > operate OK?
> > > > >
> > > > > Continue to operate OK in the sense that the mTHP will have to sp=
lit
> > > > > into 4K pages before the swap out, aka the fall back. The swap ou=
t and
> > > > > swap in can continue to work as 4K pages, not as the mTHP. Due to=
 the
> > > > > fallback, the mTHP based zsmalloc compression with 64K buffer wil=
l not
> > > > > happen. That is the effect of the fallback. But mTHP swap out and=
 swap
> > > > > in is relatively new, it is not really a regression.
> > > >
> > > > Sure, but it's pretty bad to merge a new feature only to have it
> > > > ineffective after a few hours use.
> ....
> > > >
> > > $ /home/barry/develop/linux/mthp_swpout_test -s
> > >
> > > [ 1013.535798] ------------[ cut here ]------------
> > > [ 1013.538886] expecting order 4 got 0
> >
> > This warning means there is a bug in this series somewhere I need to hu=
nt down.
> > The V1 has the same warning but I haven't heard it get triggered in
> > V1, it is something new in V2.
> >
> > Andrew, please consider removing the series from mm-unstable until I
> > resolve this warning assert.
>
> Agreed: I was glad to see it go into mm-unstable last week, that made
> it easier to include in testing (or harder to avoid!), but my conclusion
> is that it's not ready yet (and certainly not suitable for 6.10 hotfix).
>
> I too saw this "expecting order 4 got 0" once-warning every boot (from
> ordinary page reclaim rather than from madvise_pageout shown below),
> shortly after starting my tmpfs swapping load. But I never saw any bad
> effect immediately after it: actual crashes came a few minutes later.
>
> (And I'm not seeing the warning at all now, with the change I made: that
> doesn't tell us much, since what I have leaves out 2/2 entirely; but it
> does suggest that it's more important to follow up the crashes, and
> maybe when they are satisfactorily fixed, the warning will be fixed too.)
>
> Most crashes have been on that VM_BUG_ON(ci - si->cluster_info !=3D idx)
> in alloc_cluster(). And when I poked around, it was usually (always?)
> the case that si->free_clusters was empty, so list_first_entry() not
> good at all. A few other crashes were GPFs, but I didn't pay much
> attention to them, thinking the alloc_cluster() one best to pursue.
>
> I reverted both patches from mm-everything, and had no problem.
> I added back 1/2 expecting it to be harmless ("no real function
> change in this patch"), but was surprised to get those same
> "expecting order 4 got 0" warnings and VM_BUG_ONs and GPFs:
> so have spent most time trying to get 1/2 working.
>
> This patch on top of 1/2, restoring when cluster_is_free(ci) can
> be seen to change, appears to have eliminated all those problems:
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -418,6 +418,7 @@ static struct swap_cluster_info *alloc_c
>
>         VM_BUG_ON(ci - si->cluster_info !=3D idx);
>         list_del(&ci->list);
> +       ci->state =3D CLUSTER_STATE_PER_CPU;
>         ci->count =3D 0;
>         return ci;
>  }
> @@ -543,10 +544,6 @@ new_cluster:
>         if (tmp =3D=3D SWAP_NEXT_INVALID) {
>                 if (!list_empty(&si->free_clusters)) {
>                         ci =3D list_first_entry(&si->free_clusters, struc=
t swap_cluster_info, list);
> -                       list_del(&ci->list);
> -                       spin_lock(&ci->lock);
> -                       ci->state =3D CLUSTER_STATE_PER_CPU;
> -                       spin_unlock(&ci->lock);
>                         tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTE=
R;
>                 } else if (!list_empty(&si->discard_clusters)) {
>                         /*
>

Thanks for the nice bug report. That is my bad.

Both you and Ying point out the critical bug here: The cluster was
removed from the free list inside try_ssd() and in the case of
conflict() failure followed by alloc_cluster(). It allocates from the
cluster, it can remove the same cluster from the list again. That is
the path I haven't considered well.

All this attempt of allocation in try_ssd() but can have possible
conflict and perform the dance in alloc_cluster() make things very
complicated. In the try_ssd() when we have the cluster lock, can we
just perform the actual allocation with lock held? There should not be
conflict with the cluster lock protection, right?

Chris




> Delighted to have made progress after many attempts, I went to apply 2/2
> on top, but found that it builds upon those scan_swap_map_try_ssd_cluster=
()
> changes I've undone. I gave up at that point and hand back to you, Chris,
> hoping that you will understand scan_swap_map_ssd_cluster_conflict() etc
> much better than I ever shall!


>
> Clarifications on my load: all swapping to SSD, but discard not enabled;
> /sys/kernel/mm/transparent_hugepage/ enabled always, shmem_enabled force,
> hugepages-64kB/enabled always, hugepages-64kB/shmem_enabled always;
> swapoff between iterations, did not appear relevant to problems; x86_64.
>
> Hugh
>
> >
> > > [ 1013.540622] WARNING: CPU: 3 PID: 104 at mm/swapfile.c:600 scan_swa=
p_map_try_ssd_cluster+0x340/0x370
> > > [ 1013.544460] Modules linked in:
> > > [ 1013.545411] CPU: 3 PID: 104 Comm: mthp_swpout_tes Not tainted 6.10=
.0-rc3-ga12328d9fb85-dirty #285
> > > [ 1013.545990] Hardware name: linux,dummy-virt (DT)
> > > [ 1013.546585] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS =
BTYPE=3D--)
> > > [ 1013.547136] pc : scan_swap_map_try_ssd_cluster+0x340/0x370
> > > [ 1013.547768] lr : scan_swap_map_try_ssd_cluster+0x340/0x370
> > > [ 1013.548263] sp : ffff8000863e32e0
> > > [ 1013.548723] x29: ffff8000863e32e0 x28: 0000000000000670 x27: 00000=
00000000660
> > > [ 1013.549626] x26: 0000000000000010 x25: ffff0000c1692108 x24: ffff0=
000c27c4800
> > > [ 1013.550470] x23: 2e8ba2e8ba2e8ba3 x22: fffffdffbf7df2c0 x21: ffff0=
000c27c48b0
> > > [ 1013.551285] x20: ffff800083a946d0 x19: 0000000000000004 x18: fffff=
fffffffffff
> > > [ 1013.552263] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8=
00084b13568
> > > [ 1013.553292] x14: ffffffffffffffff x13: ffff800084b13566 x12: 6e697=
46365707865
> > > [ 1013.554423] x11: fffffffffffe0000 x10: ffff800083b18b68 x9 : ffff8=
0008014c874
> > > [ 1013.555231] x8 : 00000000ffffefff x7 : ffff800083b16318 x6 : 00000=
00000002850
> > > [ 1013.555965] x5 : 40000000fffff1ae x4 : 0000000000000fff x3 : 00000=
00000000000
> > > [ 1013.556779] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0=
000c24a1bc0
> > > [ 1013.557627] Call trace:
> > > [ 1013.557960]  scan_swap_map_try_ssd_cluster+0x340/0x370
> > > [ 1013.558498]  get_swap_pages+0x23c/0xc20
> > > [ 1013.558899]  folio_alloc_swap+0x5c/0x248
> > > [ 1013.559544]  add_to_swap+0x40/0xf0
> > > [ 1013.559904]  shrink_folio_list+0x6dc/0xf20
> > > [ 1013.560289]  reclaim_folio_list+0x8c/0x168
> > > [ 1013.560710]  reclaim_pages+0xfc/0x178
> > > [ 1013.561079]  madvise_cold_or_pageout_pte_range+0x8d8/0xf28
> > > [ 1013.561524]  walk_pgd_range+0x390/0x808
> > > [ 1013.561920]  __walk_page_range+0x1e0/0x1f0
> > > [ 1013.562370]  walk_page_range+0x1f0/0x2c8
> > > [ 1013.562888]  madvise_pageout+0xf8/0x280
> > > [ 1013.563388]  madvise_vma_behavior+0x314/0xa20
> > > [ 1013.563982]  madvise_walk_vmas+0xc0/0x128
> > > [ 1013.564386]  do_madvise.part.0+0x110/0x558
> > > [ 1013.564792]  __arm64_sys_madvise+0x68/0x88
> > > [ 1013.565333]  invoke_syscall+0x50/0x128
> > > [ 1013.565737]  el0_svc_common.constprop.0+0x48/0xf8
> > > [ 1013.566285]  do_el0_svc+0x28/0x40
> > > [ 1013.566667]  el0_svc+0x50/0x150
> > > [ 1013.567094]  el0t_64_sync_handler+0x13c/0x158
> > > [ 1013.567501]  el0t_64_sync+0x1a4/0x1a8
> > > [ 1013.568058] irq event stamp: 0
> > > [ 1013.568661] hardirqs last  enabled at (0): [<0000000000000000>] 0x=
0
> > > [ 1013.569560] hardirqs last disabled at (0): [<ffff8000800add44>] co=
py_process+0x654/0x19a8
> > > [ 1013.570167] softirqs last  enabled at (0): [<ffff8000800add44>] co=
py_process+0x654/0x19a8
> > > [ 1013.570846] softirqs last disabled at (0): [<0000000000000000>] 0x=
0
> > > [ 1013.571330] ---[ end trace 0000000000000000 ]---

