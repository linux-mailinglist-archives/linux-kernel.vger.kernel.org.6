Return-Path: <linux-kernel+bounces-218413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BA90BF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7299C2830FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2DD19AA53;
	Mon, 17 Jun 2024 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMt6n1Z0"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699F18FC71
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665257; cv=none; b=QAtSMM/C6PN4zuXr+z0E0SsVMqyEFp0xoSUCeUOILWrx5GRHtdn1eS/eAAvBUiwxvA7UtMP6R5QTLn+l9YP40teYpf/yUdnbsgKlSC1I1c+WEseHv0UeSHQ+dhgwtmjRUyIXp5C0rnkj4bH8PBmXWIhu+/PFdi3G75f50zBRlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665257; c=relaxed/simple;
	bh=NpdpI3eccm1KOYJzneIZZRoXgDas9aZllFTznl9a7UY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W4KhHM8EiM5GUq+iJklfJ6uqYO1v9neW9AgtGtz0VeTwgzwDM04dTnZeDFt/c4OKYKZ0iPMQ7UtjhWDW1435FA2wE4iq0DO05LYYJZmGNwXVDooIUUYOTiwT3gMqhJGRQDXPOkF6kUoe4lItKjKNuWylSqn7c+ByvqlpYXCTc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dMt6n1Z0; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25488f4e55aso2219301fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718665254; x=1719270054; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmfbCptE6HzgE4ewLB3XNk5/XZzfbGjOYY6gjOo6sHs=;
        b=dMt6n1Z0KgMgp3h0i5UsnBqd4ge5g2N0Bsv65Ha67rJommNcqudi7czFKBmFwzNHat
         cPnpuJ0h+oDMS+9oukilz9zfhOPCF67NhmX6dLe5QMcEPXbukKwAt72TdowQle3UkaCT
         wUfuBvZgIsETjQMonVGan0+znr6HJof9P6MBfAqMTqBTBVDa9AXPoddHfpsL7h9IXaZM
         MwnDknek+Dd5azFy7toqOLbVZ15c5slp7EAtGwzTbOTVGiTVfJUFLIyYVmp+BPZ878Rn
         qEWuF4DSAz9llArzNaE03gI5MA7IDUiWlSPEvXU6TbRjbenYaUkIoZ+kbqr5+wCRXyA4
         uZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665254; x=1719270054;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmfbCptE6HzgE4ewLB3XNk5/XZzfbGjOYY6gjOo6sHs=;
        b=g4XsAWx+MUwHglg6YnPwkWz8gjZLdZvmAmUYZkwtklujstbNjxLkgfB9R9WHkZCmWB
         vNiYMjzkWPer/oAmvc5ke+USA3vp5EG5vYROLS8UNhiS1wqLTbfNjeZ5/ggYt+Lup96Q
         B2csId0FmW0o5U05SmQIF+BsWjKhy4Sq3PCjIr6Ygz4KEkpiGPaNw9SHBpZ9juk3tTLD
         vkmckFmeGjFlEfz/58Q6gifx5uNheO3z5ZGFAIEEOq5RSAnfcvx3VBjFVpVHiEQjhCpx
         aREVXsc6NofDtqF7tF8MQYf060NTuGpHuWxXPtYrRllFApxX/Jp3GNMHlPzsyRO6qAj1
         nXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6mL1AYeEkB6BxbXIM82UScfYh65Oc/bqtqhyh/o8zwpMilJMTuBXc4ZIW6rcwIlRtQ3I56H1DVzKFuyH8SfsNQ1kgp2D2vwigz39G
X-Gm-Message-State: AOJu0YyVMathR22Pko1nhfCdfG0HY6lE2bcHtPE1+K11z7BJxCrm17ya
	tcf8SW+A7yPAvzr+zOC2mcMMul+jpwhC5mYqxS4XyFx7OlLoKyS7Unx6LVAB5w==
X-Google-Smtp-Source: AGHT+IHDF1zt1b0WZlg/B1lHKvVbIypD4jB/H99bV1QVPpwvOKSPnfoRr+s8ofpv510R146+wIvY/w==
X-Received: by 2002:a05:6870:828d:b0:254:9392:e5a2 with SMTP id 586e51a60fabf-2584297b9f6mr11607036fac.25.1718665253922;
        Mon, 17 Jun 2024 16:00:53 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a94e74fsm2858999fac.9.2024.06.17.16.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:00:52 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:00:41 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Chris Li <chrisl@kernel.org>
cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
    baohua@kernel.org, kaleshsingh@google.com, kasong@tencent.com, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
    ying.huang@intel.com
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
In-Reply-To: <CAF8kJuNAuuR489b=etm3-ZNLcvMmuQhUAP2cdG=AgKSLMoZ2wg@mail.gmail.com>
Message-ID: <8db63194-77fd-e0b8-8601-2bbf04889a5b@google.com>
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org> <20240615084714.37499-1-21cnbao@gmail.com> <CAF8kJuNAuuR489b=etm3-ZNLcvMmuQhUAP2cdG=AgKSLMoZ2wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1528251371-1718665254=:12184"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1528251371-1718665254=:12184
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 17 Jun 2024, Chris Li wrote:
> On Sat, Jun 15, 2024 at 1:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> > On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > > On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote=
:
> > >
> > > > > I'm having trouble understanding the overall impact of this on us=
ers.
> > > > > We fail the mTHP swap allocation and fall back, but things contin=
ue to
> > > > > operate OK?
> > > >
> > > > Continue to operate OK in the sense that the mTHP will have to spli=
t
> > > > into 4K pages before the swap out, aka the fall back. The swap out =
and
> > > > swap in can continue to work as 4K pages, not as the mTHP. Due to t=
he
> > > > fallback, the mTHP based zsmalloc compression with 64K buffer will =
not
> > > > happen. That is the effect of the fallback. But mTHP swap out and s=
wap
> > > > in is relatively new, it is not really a regression.
> > >
> > > Sure, but it's pretty bad to merge a new feature only to have it
> > > ineffective after a few hours use.
=2E...
> > >
> > $ /home/barry/develop/linux/mthp_swpout_test -s
> >
> > [ 1013.535798] ------------[ cut here ]------------
> > [ 1013.538886] expecting order 4 got 0
>=20
> This warning means there is a bug in this series somewhere I need to hunt=
 down.
> The V1 has the same warning but I haven't heard it get triggered in
> V1, it is something new in V2.
>=20
> Andrew, please consider removing the series from mm-unstable until I
> resolve this warning assert.

Agreed: I was glad to see it go into mm-unstable last week, that made
it easier to include in testing (or harder to avoid!), but my conclusion
is that it's not ready yet (and certainly not suitable for 6.10 hotfix).

I too saw this "expecting order 4 got 0" once-warning every boot (from
ordinary page reclaim rather than from madvise_pageout shown below),
shortly after starting my tmpfs swapping load. But I never saw any bad
effect immediately after it: actual crashes came a few minutes later.

(And I'm not seeing the warning at all now, with the change I made: that
doesn't tell us much, since what I have leaves out 2/2 entirely; but it
does suggest that it's more important to follow up the crashes, and
maybe when they are satisfactorily fixed, the warning will be fixed too.)

Most crashes have been on that VM_BUG_ON(ci - si->cluster_info !=3D idx)
in alloc_cluster(). And when I poked around, it was usually (always?)
the case that si->free_clusters was empty, so list_first_entry() not
good at all. A few other crashes were GPFs, but I didn't pay much
attention to them, thinking the alloc_cluster() one best to pursue.

I reverted both patches from mm-everything, and had no problem.
I added back 1/2 expecting it to be harmless ("no real function
change in this patch"), but was surprised to get those same
"expecting order 4 got 0" warnings and VM_BUG_ONs and GPFs:
so have spent most time trying to get 1/2 working.

This patch on top of 1/2, restoring when cluster_is_free(ci) can
be seen to change, appears to have eliminated all those problems:

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -418,6 +418,7 @@ static struct swap_cluster_info *alloc_c
=20
 =09VM_BUG_ON(ci - si->cluster_info !=3D idx);
 =09list_del(&ci->list);
+=09ci->state =3D CLUSTER_STATE_PER_CPU;
 =09ci->count =3D 0;
 =09return ci;
 }
@@ -543,10 +544,6 @@ new_cluster:
 =09if (tmp =3D=3D SWAP_NEXT_INVALID) {
 =09=09if (!list_empty(&si->free_clusters)) {
 =09=09=09ci =3D list_first_entry(&si->free_clusters, struct swap_cluster_i=
nfo, list);
-=09=09=09list_del(&ci->list);
-=09=09=09spin_lock(&ci->lock);
-=09=09=09ci->state =3D CLUSTER_STATE_PER_CPU;
-=09=09=09spin_unlock(&ci->lock);
 =09=09=09tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTER;
 =09=09} else if (!list_empty(&si->discard_clusters)) {
 =09=09=09/*

Delighted to have made progress after many attempts, I went to apply 2/2
on top, but found that it builds upon those scan_swap_map_try_ssd_cluster()
changes I've undone. I gave up at that point and hand back to you, Chris,
hoping that you will understand scan_swap_map_ssd_cluster_conflict() etc
much better than I ever shall!

Clarifications on my load: all swapping to SSD, but discard not enabled;
/sys/kernel/mm/transparent_hugepage/ enabled always, shmem_enabled force,
hugepages-64kB/enabled always, hugepages-64kB/shmem_enabled always;
swapoff between iterations, did not appear relevant to problems; x86_64.

Hugh

>=20
> > [ 1013.540622] WARNING: CPU: 3 PID: 104 at mm/swapfile.c:600 scan_swap_=
map_try_ssd_cluster+0x340/0x370
> > [ 1013.544460] Modules linked in:
> > [ 1013.545411] CPU: 3 PID: 104 Comm: mthp_swpout_tes Not tainted 6.10.0=
-rc3-ga12328d9fb85-dirty #285
> > [ 1013.545990] Hardware name: linux,dummy-virt (DT)
> > [ 1013.546585] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [ 1013.547136] pc : scan_swap_map_try_ssd_cluster+0x340/0x370
> > [ 1013.547768] lr : scan_swap_map_try_ssd_cluster+0x340/0x370
> > [ 1013.548263] sp : ffff8000863e32e0
> > [ 1013.548723] x29: ffff8000863e32e0 x28: 0000000000000670 x27: 0000000=
000000660
> > [ 1013.549626] x26: 0000000000000010 x25: ffff0000c1692108 x24: ffff000=
0c27c4800
> > [ 1013.550470] x23: 2e8ba2e8ba2e8ba3 x22: fffffdffbf7df2c0 x21: ffff000=
0c27c48b0
> > [ 1013.551285] x20: ffff800083a946d0 x19: 0000000000000004 x18: fffffff=
fffffffff
> > [ 1013.552263] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800=
084b13568
> > [ 1013.553292] x14: ffffffffffffffff x13: ffff800084b13566 x12: 6e69746=
365707865
> > [ 1013.554423] x11: fffffffffffe0000 x10: ffff800083b18b68 x9 : ffff800=
08014c874
> > [ 1013.555231] x8 : 00000000ffffefff x7 : ffff800083b16318 x6 : 0000000=
000002850
> > [ 1013.555965] x5 : 40000000fffff1ae x4 : 0000000000000fff x3 : 0000000=
000000000
> > [ 1013.556779] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000=
0c24a1bc0
> > [ 1013.557627] Call trace:
> > [ 1013.557960]  scan_swap_map_try_ssd_cluster+0x340/0x370
> > [ 1013.558498]  get_swap_pages+0x23c/0xc20
> > [ 1013.558899]  folio_alloc_swap+0x5c/0x248
> > [ 1013.559544]  add_to_swap+0x40/0xf0
> > [ 1013.559904]  shrink_folio_list+0x6dc/0xf20
> > [ 1013.560289]  reclaim_folio_list+0x8c/0x168
> > [ 1013.560710]  reclaim_pages+0xfc/0x178
> > [ 1013.561079]  madvise_cold_or_pageout_pte_range+0x8d8/0xf28
> > [ 1013.561524]  walk_pgd_range+0x390/0x808
> > [ 1013.561920]  __walk_page_range+0x1e0/0x1f0
> > [ 1013.562370]  walk_page_range+0x1f0/0x2c8
> > [ 1013.562888]  madvise_pageout+0xf8/0x280
> > [ 1013.563388]  madvise_vma_behavior+0x314/0xa20
> > [ 1013.563982]  madvise_walk_vmas+0xc0/0x128
> > [ 1013.564386]  do_madvise.part.0+0x110/0x558
> > [ 1013.564792]  __arm64_sys_madvise+0x68/0x88
> > [ 1013.565333]  invoke_syscall+0x50/0x128
> > [ 1013.565737]  el0_svc_common.constprop.0+0x48/0xf8
> > [ 1013.566285]  do_el0_svc+0x28/0x40
> > [ 1013.566667]  el0_svc+0x50/0x150
> > [ 1013.567094]  el0t_64_sync_handler+0x13c/0x158
> > [ 1013.567501]  el0t_64_sync+0x1a4/0x1a8
> > [ 1013.568058] irq event stamp: 0
> > [ 1013.568661] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [ 1013.569560] hardirqs last disabled at (0): [<ffff8000800add44>] copy=
_process+0x654/0x19a8
> > [ 1013.570167] softirqs last  enabled at (0): [<ffff8000800add44>] copy=
_process+0x654/0x19a8
> > [ 1013.570846] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [ 1013.571330] ---[ end trace 0000000000000000 ]---
---1463770367-1528251371-1718665254=:12184--

