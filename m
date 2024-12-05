Return-Path: <linux-kernel+bounces-432553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6C9E4CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193BA166C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA4191F60;
	Thu,  5 Dec 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgGm54bR"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2462391A6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370962; cv=none; b=qXcknrnHrJ8xCOjSDXgvQAhzP2LB3qT6YjaNn6OOF+DNYZ68o2ZINWjcIj2lrudQVTaZoGJVGLW+DdUPdXuCe7W2hqsNEAoTpLfFyj4q0zVX51axFH16d3BTHF4F3SME0ZK4gU5VGZJa1RAe1exF1ksemyLjwmE1qedYUP0hgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370962; c=relaxed/simple;
	bh=aeQ9BnUuXXXxxJcC0f7f8/Q4nHSdxF4ZXCC0KKcaKKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bqr4wF19bMRtZheertGDWKjhvi+DxZU+NsWMPZL9rLVaRW0B0u0a3A7+BSn0F9PnuuFNP8QTDgjAZCgOx8Tp2jvJOE/vjOzlcHq/PSBW82peGsm4L/iwxAopZBxCkgD0jPzP2l/XVC7CpF8G68Ui86/kDrBFt+/AKLGrRaU7KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgGm54bR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7259a26ad10so380963b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733370959; x=1733975759; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaS94RJU8jQE4zbDalu4mOpsczw2CxPrCQFCEvn0DAY=;
        b=tgGm54bR5rDlPZDi9GSpYGRhsNT7mzRiAXy/HjP6BZhHPN6su6s0nH+/rvLz5Oi0nA
         v2424U3y539FnsEt44TA+UBeha7BSfWS2DklqrKLVA2ZNgE8l3ThyLR7dRSztYLGvIZL
         UVomEu8Wvedj9HRJFikvlIxNfsJZciK2JJFeOILcAhAxZIfC0HVLR2Vevo8LERzjyoUJ
         OypQinEmj5Yx2W38RJRmA1dJZK101LiHbINx0Np1yjQGcCM7hwAbLwE0If+R7QjLSOJP
         NY26Yl7fLY7QcELHDjylaTyIpSH02/Hyx3ih0+b/MZaUykvBi6YpT4072XT9cVVQ8jKs
         hSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733370959; x=1733975759;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaS94RJU8jQE4zbDalu4mOpsczw2CxPrCQFCEvn0DAY=;
        b=rnPObyMaOLPRlPvFHQBTPDaUOrFreJUNOiMmSTzKD5unTdH41s0gMZiDKiviS4lXkF
         cuKL8SfFXwRf0svtDWz9QpWSfaHl7f8XVjGc1Ws/qyz7ZDU0++eRVeV1yE9bNG7Ao/fb
         fFyMJQfMvWJdJHISI4Q96hCBGZs9csxSSqQpn+L8ySNokKq+63GdF82K5YAzmaRkdTBE
         X/hoL5v9oxK1huEDf53OrKlTt4SvKiFv1EzLZnV5VgSJZbIFw4nkGjhxWs+oaENDZWoH
         iDn5ao9gWG0IEmLXrzB2mEVKF3iU6CPbhgNLnGL3T/uitTD8qD+xWlZahBUpKvX/M36d
         S3zA==
X-Forwarded-Encrypted: i=1; AJvYcCUa0xoYvT3E+ChS1obcW82IXerFtDSfMYA+yhLzt7YpY3YHblM+ZTnVu6PjELMcpD0FcAxXsJeP8pmtdbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyznNhcGkixOwjlCsFz9MCymH+8QuOLZs0rP/DMB6xciEuVEUqe
	eA1VRoqxjpinPDftJOTfv6Zz3iaAbVt4yISTjZ39MnLOFM46fJmQ424Zs47RzQ==
X-Gm-Gg: ASbGncvhFYVKhf8MmAqOXGJwN/E7V2MVoHmLUCRBgxFkaGurz466jNBSasAYQCQRHoQ
	plFU/jWjWIaBrkEe6IDT0p6VrgEqO1ZGJ5yOYvmbQufsmU0UB9An3v3piPGf8KHbF8DW4IMjCNe
	lnwhFVz8viF6gv+6SFcccH60v5iJjC+Lhkm3DM6rjpmpqfEv7VXi/oijmmVdbKjC/2sq3NTFpdj
	ME5jRGVMfPqL8pXNohzepp5zgpkLz1Lg06xAF+BHE6pdcKhbHeO8xP1RvR77PbNkrRHnfOjujAb
	+OB0jZgAibJAz+wWuR/2+0aY6Xbh3IegxA==
X-Google-Smtp-Source: AGHT+IGOGICKTpJv+lod4fIH882GKhFZkf4XS/slws2UT32lMDVlhD+D8l/V5cEs9Jldpll5sTVlXA==
X-Received: by 2002:a05:6a00:608a:b0:725:99cc:c9a1 with SMTP id d2e1a72fcca58-7259d2df0c3mr2266764b3a.0.1733370958982;
        Wed, 04 Dec 2024 19:55:58 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a17860sm275800b3a.90.2024.12.04.19.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 19:55:57 -0800 (PST)
Date: Wed, 4 Dec 2024 19:55:47 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: liuye <liuye@kylinos.cn>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Mel Gorman <mgorman@techsingularity.net>, Hugh Dickins <hughd@google.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Minchan Kim <minchan@kernel.org>, 
    Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Bharata B Rao <bharata@amd.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 RESEND] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
In-Reply-To: <20241129192228.6f08e74a555bedcad71d32f4@linux-foundation.org>
Message-ID: <dae8ea77-2bc1-8ee9-b94b-207e2c8e1b8d@google.com>
References: <20240919021443.9170-1-liuye@kylinos.cn> <20241119060842.274072-1-liuye@kylinos.cn> <20241129192228.6f08e74a555bedcad71d32f4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-225718998-1733370957=:7673"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-225718998-1733370957=:7673
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 Nov 2024, Andrew Morton wrote:
> On Tue, 19 Nov 2024 14:08:42 +0800 liuye <liuye@kylinos.cn> wrote:
>=20
> > This fixes the following hard lockup in function isolate_lru_folios
> > when memory reclaim.If the LRU mostly contains ineligible folios
> > May trigger watchdog.
> >=20
> > watchdog: Watchdog detected hard LOCKUP on cpu 173
> > RIP: 0010:native_queued_spin_lock_slowpath+0x255/0x2a0
> > Call Trace:
> > =09_raw_spin_lock_irqsave+0x31/0x40
> > =09folio_lruvec_lock_irqsave+0x5f/0x90
> > =09folio_batch_move_lru+0x91/0x150
> > =09lru_add_drain_per_cpu+0x1c/0x40
> > =09process_one_work+0x17d/0x350
> > =09worker_thread+0x27b/0x3a0
> > =09kthread+0xe8/0x120
> > =09ret_from_fork+0x34/0x50
> > =09ret_from_fork_asm+0x1b/0x30
> >=20
> > lruvec->lru_lock owner=EF=BC=9A
> >=20
> > PID: 2865     TASK: ffff888139214d40  CPU: 40   COMMAND: "kswapd0"
> >  #0 [fffffe0000945e60] crash_nmi_callback at ffffffffa567a555
> >  #1 [fffffe0000945e68] nmi_handle at ffffffffa563b171
> >  #2 [fffffe0000945eb0] default_do_nmi at ffffffffa6575920
> >  #3 [fffffe0000945ed0] exc_nmi at ffffffffa6575af4
> >  #4 [fffffe0000945ef0] end_repeat_nmi at ffffffffa6601dde
> >     [exception RIP: isolate_lru_folios+403]
> >     RIP: ffffffffa597df53  RSP: ffffc90006fb7c28  RFLAGS: 00000002
> >     RAX: 0000000000000001  RBX: ffffc90006fb7c60  RCX: ffffea04a2196f88
> >     RDX: ffffc90006fb7c60  RSI: ffffc90006fb7c60  RDI: ffffea04a2197048
> >     RBP: ffff88812cbd3010   R8: ffffea04a2197008   R9: 0000000000000001
> >     R10: 0000000000000000  R11: 0000000000000001  R12: ffffea04a2197008
> >     R13: ffffea04a2197048  R14: ffffc90006fb7de8  R15: 0000000003e3e937
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >     <NMI exception stack>
> >  #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
> >  #6 [ffffc90006fb7cf8] shrink_active_list at ffffffffa597f788
> >  #7 [ffffc90006fb7da8] balance_pgdat at ffffffffa5986db0
> >  #8 [ffffc90006fb7ec0] kswapd at ffffffffa5987354
> >  #9 [ffffc90006fb7ef8] kthread at ffffffffa5748238
> > crash>
> >=20
> > Scenario:
> > User processe are requesting a large amount of memory and keep page act=
ive.
> > Then a module continuously requests memory from ZONE_DMA32 area.
> > Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm reac=
hed.
> > However pages in the LRU(active_anon) list are mostly from
> > the ZONE_NORMAL area.
> >=20
> > Reproduce:
> > Terminal 1: Construct to continuously increase pages active(anon).
> > mkdir /tmp/memory
> > mount -t tmpfs -o size=3D1024000M tmpfs /tmp/memory
> > dd if=3D/dev/zero of=3D/tmp/memory/block bs=3D4M
> > tail /tmp/memory/block
> >=20
> > Terminal 2:
> > vmstat -a 1
> > active will increase.
> > procs ---memory--- ---swap-- ---io---- -system-- ---cpu--- ...
> >  r  b   swpd   free  inact active   si   so    bi    bo
> >  1  0   0 1445623076 45898836 83646008    0    0     0
> >  1  0   0 1445623076 43450228 86094616    0    0     0
> >  1  0   0 1445623076 41003480 88541364    0    0     0
> >  1  0   0 1445623076 38557088 90987756    0    0     0
> >  1  0   0 1445623076 36109688 93435156    0    0     0
> >  1  0   0 1445619552 33663256 95881632    0    0     0
> >  1  0   0 1445619804 31217140 98327792    0    0     0
> >  1  0   0 1445619804 28769988 100774944    0    0     0
> >  1  0   0 1445619804 26322348 103222584    0    0     0
> >  1  0   0 1445619804 23875592 105669340    0    0     0
> >=20
> > cat /proc/meminfo | head
> > Active(anon) increase.
> > MemTotal:       1579941036 kB
> > MemFree:        1445618500 kB
> > MemAvailable:   1453013224 kB
> > Buffers:            6516 kB
> > Cached:         128653956 kB
> > SwapCached:            0 kB
> > Active:         118110812 kB
> > Inactive:       11436620 kB
> > Active(anon):   115345744 kB
> > Inactive(anon):   945292 kB
> >=20
> > When the Active(anon) is 115345744 kB, insmod module triggers
> > the ZONE_DMA32 watermark.
> >=20
> > perf record -e vmscan:mm_vmscan_lru_isolate -aR
> > perf script
> > isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D2
> > nr_skipped=3D2 nr_taken=3D0 lru=3Dactive_anon
> > isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D0
> > nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
> > isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D28835844
> > nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
> > isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D28835844
> > nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
> > isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D29
> > nr_skipped=3D29 nr_taken=3D0 lru=3Dactive_anon
> > isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D0
> > nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
> >=20
> > See nr_scanned=3D28835844.
> > 28835844 * 4k =3D 115343376KB approximately equal to 115345744 kB.
> >=20
> > If increase Active(anon) to 1000G then insmod module triggers
> > the ZONE_DMA32 watermark. hard lockup will occur.
> >=20
> > In my device nr_scanned =3D 0000000003e3e937 when hard lockup.
> > Convert to memory size 0x0000000003e3e937 * 4KB =3D 261072092 KB.
> >=20
> >    [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
> >     ffffc90006fb7c30: 0000000000000020 0000000000000000
> >     ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000
> >     ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8
> >     ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48
> >     ffffc90006fb7c70: 0000000000000000 0000000000000000
> >     ffffc90006fb7c80: 0000000000000000 0000000000000000
> >     ffffc90006fb7c90: 0000000000000000 0000000000000000
> >     ffffc90006fb7ca0: 0000000000000000 0000000003e3e937
> >     ffffc90006fb7cb0: 0000000000000000 0000000000000000
> >     ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000
> >=20
> > About the Fixes:
> > Why did it take eight years to be discovered?

I don't think it took eight years to be discovered: it was long known
as a potential issue, but awkward to solve properly, and most of us have
survived well enough in practice that we've never given the time to it.

> >=20
> > The problem requires the following conditions to occur:
> > 1. The device memory should be large enough.
> > 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL a=
rea.
> > 3. The memory in ZONE_DMA32 needs to reach the watermark.
> >=20
> > If the memory is not large enough, or if the usage design of ZONE_DMA32
> > area memory is reasonable, this problem is difficult to detect.
> >=20
> > notes:
> > The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL,
> > but other suitable scenarios may also trigger the problem.
> >
> > Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node =
basis")
> >
>=20
> Thanks.
>=20
> This is old code.  I agree on b2e18757f2c9 and thanks for digging that
> out.

I disagree.  Although that commit is the root cause of what led to this
hard lockup problem, I believe there was no such hard lockup in it:
if I thought that this patch were a good fix, I would say

Fixes: 791b48b64232 ("mm: vmscan: scan until it finds eligible pages")

which allowed the previously SWAP_CLUSTER_MAX-limited scan to go
skipping indefinitely while holding spinlock with interrupts disabled;
which this patch here now limits to 32k, but that still seems way too
many to me.

And then after its 32k skips, it gives up and reclaims a few unsuitable
folios instead, just so that it can return a non-0 number to the caller.
Unlikely to find and reclaim the suitable folios that it's looking for:
which, despite its faults, the unpatched code does manage to do.

>=20
> I'll add a cc:stable and shall queue it for testing, pending review
> from others (please).  It may be that the -stable tree maintainers ask
> for a backport of this change into pre-folio-conversion kernels.  But
> given the obscurity of the workload, I'm not sure this would be worth
> doing.  Opinions are sought?

I think I've been Cc'ed because git blame fingered some nearby isolation
cleanups from me: I'm not the best person to comment, but I would give
this patch a NAK.  If we are going to worry about this after seven years
(and with MGLRU approaching), I'd say the issue needs a better approach.

Liuye, please start by reverting 791b48b64232 (which seems to have been
implemented at the wrong level, inviting this hard lockup), and then
studying its commit message and fixing the OOM kills which it was trying
to fix - if they still exist after all the intervening years of tweaks.

Perhaps it's just a matter of adjusting get_scan_count() or shrink_lruvec()=
,
to be more persistent in the reclaim_idx high-skipping case.

I'd have liked to suggest an actual patch, but that's beyond me.

Thanks,
Hugh

>=20
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -223,6 +223,7 @@ enum {
> >  };
> > =20
> >  #define SWAP_CLUSTER_MAX 32UL
> > +#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
> >  #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
> > =20
> >  /* Bit flag in swap_map */
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 28ba2b06fc7d..0bdfae413b4c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1657,6 +1657,7 @@ static unsigned long isolate_lru_folios(unsigned =
long nr_to_scan,
> >  =09unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
> >  =09unsigned long skipped =3D 0;
> >  =09unsigned long scan, total_scan, nr_pages;
> > +=09unsigned long max_nr_skipped =3D 0;
> >  =09LIST_HEAD(folios_skipped);
> > =20
> >  =09total_scan =3D 0;
> > @@ -1671,9 +1672,12 @@ static unsigned long isolate_lru_folios(unsigned=
 long nr_to_scan,
> >  =09=09nr_pages =3D folio_nr_pages(folio);
> >  =09=09total_scan +=3D nr_pages;
> > =20
> > -=09=09if (folio_zonenum(folio) > sc->reclaim_idx) {
> > +=09=09/* Using max_nr_skipped to prevent hard LOCKUP*/
> > +=09=09if (max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED &&
> > +=09=09    (folio_zonenum(folio) > sc->reclaim_idx)) {
> >  =09=09=09nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> >  =09=09=09move_to =3D &folios_skipped;
> > +=09=09=09max_nr_skipped++;
> >  =09=09=09goto move;
> >  =09=09}
> > =20
> > --=20
> > 2.25.1
---1463770367-225718998-1733370957=:7673--

