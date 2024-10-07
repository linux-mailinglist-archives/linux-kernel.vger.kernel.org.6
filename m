Return-Path: <linux-kernel+bounces-353628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF899307E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EDB1C230F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA051D9695;
	Mon,  7 Oct 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UshMQdhk"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17A1D968C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313397; cv=none; b=TTzO3L733Diu37NZPYKLSKRndQL8rrScwZtKQ2p/tgW3ihPjToynXLVZBRLeWYy+zagS+WA0X432V4Rbl5tA61Kh1fyOZd5ofT7OQRvnfC4XzOBXcsIGhGqxeCBVdjeTu2b8GHzNkA9oVzcv1+L+1NUd0sSLkxMppSwZMWaAmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313397; c=relaxed/simple;
	bh=XFlNd8F+ONXo3z12IIdePTg9KSmekYRu+S50N7f6AjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEP4E8ycX3UNq/p2dNkpkFiisMuAb5eGCtg4PpbuxbS4VqkZzbwjPrdzUtwbiMKryxtGGhozf2JxrM2MWaNauw8P1FtkT6D3cikvICmz4NmG1YtLm6y0WNxHLkanpGhJ0Tk86r2SJ2xrILBO8QdbjpZf5gqPcGOIbcXqRqI8vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UshMQdhk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso60383151fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728313393; x=1728918193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dE19RGwHF6XzzdyDx3E87QFadsqnO5aqjuR8kuDC10=;
        b=UshMQdhkrpqh8bVyXUhIxMuXF1uJ0TJJ4MdBhQAgC+G5aOZ05/mC7FP+n+VCQssNaX
         eZyg6f174Rco0kjneZkpPIBLFZfceoKIwzwLhuuUKCg1NT3hE7VbdcOjG7iiAL+ggUAc
         NiYs6gUml0LyB6xFzK5mjFcyhdUqt2WfLc+IdDxVIHfIXBkxZbcvvGp4/8b1ZAO/zqtf
         R8nAWzAyPTkNt8Cn/AprE9+g5QI1mCD8c6XUJSu9opSolGLE8lK7wTbKHytKrcsMNE24
         2hWJMY9u21X/56B9bIh3y+zu9HCcOp+pCg37qRcWDeXOQjeFa/PMLJUZ0Atrs9hl0bn8
         9Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313393; x=1728918193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dE19RGwHF6XzzdyDx3E87QFadsqnO5aqjuR8kuDC10=;
        b=kxGFUxM/fWH4uB+hROGRO1LFQCRcd22TSfOfMGnbK9SEoEKdMAlRVbgZK1s8EiYOfh
         q36z9eK1UXtfik4svUgNVxI8yQ7Krt+zL2igMQzviq+/E8Zj1L1VQsIqB+jiKC/XYwBr
         uM+h9wzKH3JuXm8g+qMR4fEiGpMc6/r6+RlignU+rG8L/YvplxFx8StS7umHOUQBPv5z
         iUqbGDkakKXaaIiEl+cl3ysEqv4p8z2R5sewJhVMsXbzDphXogjlE7Jb1WV2FKjKtMlD
         oWpxU2BUFVrjb1wql5V04jJ39/vSezFM6x1G+AbRNvD5z9piLZR5ftzRjGZGhCb67ONQ
         p6QA==
X-Forwarded-Encrypted: i=1; AJvYcCWD8uw4DqdJ1roiMwugd+KUkU9uOMIu0+Du4XHBylWMzvVDBp65O2rlr+UlesE9hSyo6PlkQ8pvh1yQGfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywriewl4zn0i7/yVGS9xKZDLwGFgr60RU/G+mxax+PvxMsNMFXK
	Kprs60LXbauitHuDc2CwftR5e0DdM9IzPjzwcgxBQF4J40jVNcdJCHDSMiMegO2qQFf/UGgxSgD
	aIpx4ZaP6wCgB61tQIWzA5hUgjrw=
X-Google-Smtp-Source: AGHT+IEEE7nkl2gCkPc/HtFigcAUq77KgjbUoCg1RhOHQMJskxTdr7EDwpnp5MBxv6Kh3ASTHn/3I7ZVF0GDt8WSoAU=
X-Received: by 2002:a05:6512:68a:b0:539:8d2c:c01a with SMTP id
 2adb3069b0e04-539ab87daf5mr9163155e87.29.1728313392914; Mon, 07 Oct 2024
 08:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007091850.16959-1-yuan.gao@ucloud.cn> <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz>
In-Reply-To: <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 8 Oct 2024 00:03:00 +0900
Message-ID: <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/slub: Avoid list corruption when removing a slab
 from the full list
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "yuan.gao" <yuan.gao@ucloud.cn>, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:29=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/7/24 11:18 AM, yuan.gao wrote:
> > boot with slub_debug=3DUFPZ.
> >
> > If allocated object failed in alloc_consistency_checks, all objects of
> > the slab will be marked as used, and then the slab will be removed from
> > the partial list.
> >
> > When an object belonging to the slab got freed later, the remove_full()
> > function is called. Because the slab is neither on the partial list nor
> > on the full list, it eventually lead to a list corruption.
> >
> > So we need to add the slab to full list in this case.
> >
> > [ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POIS=
ON1 (dead000000000100)
> > [ 4277.387023] ------------[ cut here ]------------
> > [ 4277.387880] kernel BUG at lib/list_debug.c:56!
> > [ 4277.388680] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > [ 4277.389562] CPU: 5 PID: 90 Comm: kworker/5:1 Kdump: loaded Tainted: =
G           OE      6.6.1-1 #1
> > [ 4277.392113] Workqueue: xfs-inodegc/vda1 xfs_inodegc_worker [xfs]
> > [ 4277.393551] RIP: 0010:__list_del_entry_valid_or_report+0x7b/0xc0
> > [ 4277.394518] Code: 48 91 82 e8 37 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 28=
 49 91 82 e8 26 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 58 49 91
> > [ 4277.397292] RSP: 0018:ffffc90000333b38 EFLAGS: 00010082
> > [ 4277.398202] RAX: 000000000000004e RBX: ffffea00044b3e50 RCX: 0000000=
000000000
> > [ 4277.399340] RDX: 0000000000000002 RSI: ffffffff828f8715 RDI: 0000000=
0ffffffff
> > [ 4277.400545] RBP: ffffea00044b3e40 R08: 0000000000000000 R09: ffffc90=
0003339f0
> > [ 4277.401710] R10: 0000000000000003 R11: ffffffff82d44088 R12: ffff888=
112cf9910
> > [ 4277.402887] R13: 0000000000000001 R14: 0000000000000001 R15: ffff888=
1000424c0
> > [ 4277.404049] FS:  0000000000000000(0000) GS:ffff88842fd40000(0000) kn=
lGS:0000000000000000
> > [ 4277.405357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4277.406389] CR2: 00007f2ad0b24000 CR3: 0000000102a3a006 CR4: 0000000=
0007706e0
> > [ 4277.407589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 4277.408780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 4277.410000] PKRU: 55555554
> > [ 4277.410645] Call Trace:
> > [ 4277.411234]  <TASK>
> > [ 4277.411777]  ? die+0x32/0x80
> > [ 4277.412439]  ? do_trap+0xd6/0x100
> > [ 4277.413150]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> > [ 4277.414158]  ? do_error_trap+0x6a/0x90
> > [ 4277.414948]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> > [ 4277.415915]  ? exc_invalid_op+0x4c/0x60
> > [ 4277.416710]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> > [ 4277.417675]  ? asm_exc_invalid_op+0x16/0x20
> > [ 4277.418482]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> > [ 4277.419466]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> > [ 4277.420410]  free_to_partial_list+0x515/0x5e0
> > [ 4277.421242]  ? xfs_iext_remove+0x41a/0xa10 [xfs]
> > [ 4277.422298]  xfs_iext_remove+0x41a/0xa10 [xfs]
> > [ 4277.423316]  ? xfs_inodegc_worker+0xb4/0x1a0 [xfs]
> > [ 4277.424383]  xfs_bmap_del_extent_delay+0x4fe/0x7d0 [xfs]
> > [ 4277.425490]  __xfs_bunmapi+0x50d/0x840 [xfs]
> > [ 4277.426445]  xfs_itruncate_extents_flags+0x13a/0x490 [xfs]
> > [ 4277.427553]  xfs_inactive_truncate+0xa3/0x120 [xfs]
> > [ 4277.428567]  xfs_inactive+0x22d/0x290 [xfs]
> > [ 4277.429500]  xfs_inodegc_worker+0xb4/0x1a0 [xfs]
> > [ 4277.430479]  process_one_work+0x171/0x340
> > [ 4277.431227]  worker_thread+0x277/0x390
> > [ 4277.431962]  ? __pfx_worker_thread+0x10/0x10
> > [ 4277.432752]  kthread+0xf0/0x120
> > [ 4277.433382]  ? __pfx_kthread+0x10/0x10
> > [ 4277.434134]  ret_from_fork+0x2d/0x50
> > [ 4277.434837]  ? __pfx_kthread+0x10/0x10
> > [ 4277.435566]  ret_from_fork_asm+0x1b/0x30
> > [ 4277.436280]  </TASK>
> >
> > v2:
> > * Call remove_partial() and add_full() only for slab folios.
> >
> > v1:
> > https://lore.kernel.org/linux-mm/20241006044755.79634-1-yuan.gao@ucloud=
.cn/
> >
> > Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
>
> Is it possible to determine which commit introduced this issue, for a
> stable cc?

By code inspection I suspect it's around when SLUB's first introduced in 20=
07,
more specifically commit 643b113849d8 ("slub: enable tracking of full slabs=
").
Even v2.6 kernels do not seem to handle this case correctly.

> Also in addition to what Hyeonggon proposed, we should perhaps mark
> these consistency-failed slabs in a way that further freeing of objects
> in them will also don't actually free anything, and thus not move the
> slab back from full to partial list for further reuse.

Yeah I was thinking of that too.

If that is feasible Yuan you may use one bit from (in mm/slab.h)
struct slab's 'inuse' field
and change it to 15 bits to mark consistency-failed slabs.

IIUC 'inuse' doesn't have to be 16 bits and 'objects' is already 15
bits, so I think it should be fine.

> Right now the
> (understandable) attempt to not use the corrupted slab further is only
> partially successful.

Best,
Hyeonggon

> > ---
> >  mm/slub.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 21f71cb6cc06..2992388c00f4 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2745,7 +2745,10 @@ static void *alloc_single_from_partial(struct km=
em_cache *s,
> >       slab->inuse++;
> >
> >       if (!alloc_debug_processing(s, slab, object, orig_size)) {
> > -             remove_partial(n, slab);
> > +             if (folio_test_slab(slab_folio(slab))) {
> > +                     remove_partial(n, slab);
> > +                     add_full(s, n, slab);
> > +             }
> >               return NULL;
> >       }
> >

