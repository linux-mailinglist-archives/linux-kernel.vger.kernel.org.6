Return-Path: <linux-kernel+bounces-362008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD399AFE7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EADB22A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD89F14012;
	Sat, 12 Oct 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUX2SMo9"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC5DDAB
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697804; cv=none; b=TXpp17Z9z4H+Vm8JtZr9ClLb6PR/PQHp2k/qTMB9Ovv/ESa1jnkkuJ2pJCurKowqDk6si593jT4yXTUP9nj2+/Usk//3wHTEHo8F7kueaYYwwgmgtpvLKm5juHi5+ArMsSS8TTHTpvyF7cU4kYVEqWkkGdhLNGHcw9ESXLvjVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697804; c=relaxed/simple;
	bh=SFdZGufBedxmFnaVsVo7SFHDIrhrg6GpJtpJobHuRk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZZbnL8Q+t8R5Pr4f/ZfH4L7VZG4ssG9APsf04zF0u3eum1X4F/TbFspByLVmEO3yyelyXXYUaPyTHhGn4IcFxi/zSiDdRAPL1BK/h9yHZ3D/z7mIAKeHDyw3ALV7EjZ+sTDwfiq9Rk9GWA2kknkb26AcJl1CXgjXWx3r5XYBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUX2SMo9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e576d665so65684e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728697800; x=1729302600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl7QDmPgNR+ZcJpmQPpgGsdoXyoruwuzooaCriza/tA=;
        b=eUX2SMo99O99Ncnas+cRaCsfof9LbnRSTAYU5J4oOHFWX1ag067exAOnTocx1U+/5N
         mD0/lP49BXfrvrp9+e8RRKGrdR9K3H5mGJAYm5WXUui6ygMAmpDLPj0wODMbAO2YWtRW
         BsIkdlXZiVXVOpk3pkDSXio/TUkHyZkM04myd/PUNWvXXpUrpf2hMeEjP54mOvIWBrZR
         5SsoBC4i0xHMeya6WAZcK2y/CNa6nw/TqJ1YfuHlHi1RwC9eij585UjjPR64QhXF12eE
         EO7aWHUQ1H6ZeOoGSzu+bO7lSpQJYD2YaCgLIWRXY5ycAko5DbWuTqqQOPyPW3/+LbFm
         riVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728697800; x=1729302600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl7QDmPgNR+ZcJpmQPpgGsdoXyoruwuzooaCriza/tA=;
        b=nCICBRgmZjQqvX0cV3HKXQDa/fUjE53QrYtJ9ujxLcz+QAdFhOmUCXEZ+3QrWPTrsA
         yMNgaQ3/GfuScEy4td8OCvw1LBOfOWCmEw0ZKwGG910CJgicE3eTDgoSgH86iu7VqlN6
         zaG7TGOBaVejIBBmaRu3piSMl4e/QLRBxHUr5GV9T0WXgLB43ED0CYsY6NZwE7bwAsYu
         6WLl76kDVvzmzNbe0FUYwJsXssGKv72GIuBb7XDzwLgygRCaiuKGqh9U8nCKcW78D6EK
         i64ENWnMLsPplqD1y/zsVooxvXacN8CgwEmITPFuSZD2hBRPZxzWseGpzYpsntPYmhQ/
         VSsA==
X-Forwarded-Encrypted: i=1; AJvYcCUFRcXGA0hcmGvGJ+oCuSBFqT70ASGeuLlxTUSvnQlqbcBtKVbuLul0ZHHNYzdVH1utycxFyfOR6g6Z4Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1GxlN4yb2KCIIjiZKi/Tisr0jqE6dSDguWRDmr1q7jZMcnP4j
	EvpWj+qc5Zq9b3jzq2iKOUMfaCGamz6e4YccFne+aSeghJ/1HgiH16bnugLlEbBMhudrQWCRxRr
	xHzUx1Fm2cb96TTYxULoLMi1tPhnhPdGw
X-Google-Smtp-Source: AGHT+IHB+od3iobMStznhsxyUZcmRWuTmW1+fVXNwkMP2XOPNOBlhhSrPEYYGlJbixmYlA/eq/gKxGP5ilfgOLFWp0I=
X-Received: by 2002:a05:6512:33c1:b0:535:6a7b:9c03 with SMTP id
 2adb3069b0e04-539da5c6eb3mr619866e87.6.1728697799881; Fri, 11 Oct 2024
 18:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009074953.608591-1-zhaoyang.huang@unisoc.com>
 <CAOUHufaiKFZ6LjoQ8SChK+m0-nPzT6RYpDfLHp69vn1OYm3qhQ@mail.gmail.com> <CAGWkznGBWxVD0La5PArU1F2Q1Tqk40EGP1V0+jRiLNaxWy5zbg@mail.gmail.com>
In-Reply-To: <CAGWkznGBWxVD0La5PArU1F2Q1Tqk40EGP1V0+jRiLNaxWy5zbg@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sat, 12 Oct 2024 09:49:48 +0800
Message-ID: <CAGWkznEsesvbaRqOeqOaYJnD5BYxNOuO57pNt+cM7yOQrdk1Pg@mail.gmail.com>
Subject: Re: [PATCH] mm: throttle and inc min_seq when both page types reach MIN_NR_GENS
To: Yu Zhao <yuzhao@google.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:02=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> On Fri, Oct 11, 2024 at 12:37=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrot=
e:
> >
> > On Wed, Oct 9, 2024 at 1:50=E2=80=AFAM zhaoyang.huang <zhaoyang.huang@u=
nisoc.com> wrote:
> > >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > The test case of [1] leads to system hang which caused by a local
> > > watchdog thread starved over 20s on a 5.5GB RAM ANDROID15(v6.6)
> > > system. This commit solve the issue by have the reclaimer be throttle=
d
> > > and increase min_seq if both page types reach MIN_NR_GENS, which may
> > > introduce a livelock of switching type with holding lruvec->lru_lock.
> > >
> > > [1]
> > > launch below script 8 times simutanously which allocates 1GB virtual
> > > memory and access it from user space by each thread.
> > > $ costmem -c1024000 -b12800 -o0 &
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  mm/vmscan.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index cfa839284b92..83e450d0ce3c 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4384,11 +4384,23 @@ static int scan_folios(struct lruvec *lruvec,=
 struct scan_control *sc,
> > >         int remaining =3D MAX_LRU_BATCH;
> > >         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> > >         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> > > +       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> > >
> > >         VM_WARN_ON_ONCE(!list_empty(list));
> > >
> > > -       if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS)
> > > -               return 0;
> > > +       if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS) {
> > > +               /*
> > > +                * throttle for a while and then increase the min_seq=
 since
> > > +                * both page types reach the limit.
> > > +                */
> >
> > Sorry but this isn't going to work because in try_to_inc_min_seq(), the=
re is
> >    `while (min_seq[type] + MIN_NR_GENS <=3D lrugen->max_seq) {`
> > to prevent reclaimers from evicting hot memory -- they need to do aging=
 first.
> Thanks for heads up. What I thought was assuming there is a running
> reclaimer will do the aging and the throttled reclaimers increase the
> min_seq when scheduled back and move on. Or could we just drop the
> lock and throttle for a while to avoid a livelock on 'type =3D !type'
> with holding the lock?
please find below for the lru_lock contention information[2] which we
get from syzkaller test. if the patch[1] is worth discussing which
introduces throttling direct reclaimer by judging the number of
isolated folios.

[1]
https://lore.kernel.org/all/20240716094348.2451312-1-zhaoyang.huang@unisoc.=
com/

[2]
[  295.163779][T8447@C5] preemptoff_warn: C5 T:<8447>syz.2.17
D:40.429ms F:295.123341s E:6.660 ms
[  295.165000][T8447@C5] preemptoff_warn: C5 enabled preempt at:
[  295.165000][T8447@C5] _raw_spin_unlock_irq+0x2c/0x5c
[  295.165000][T8447@C5] evict_folios+0x2504/0x3050
[  295.165000][T8447@C5] try_to_shrink_lruvec+0x40c/0x594
[  295.165000][T8447@C5] shrink_one+0x174/0x4cc
[  295.165000][T8447@C5] shrink_node+0x1c50/0x2088
[  295.165000][T8447@C5] do_try_to_free_pages+0x560/0xef8
[  295.165000][T8447@C5] try_to_free_pages+0x4e8/0xaf0
[  295.165000][T8447@C5] __alloc_pages_slowpath+0x92c/0x1c78
[  295.165000][T8447@C5] __alloc_pages+0x404/0x48c
[  295.166277][T298@C0] C0 T:<298>logd.writer D:42.389ms F:295.123885s
[  295.166337][T298@C0] C0 enabled IRQ at:
[  295.166337][T298@C0] _raw_spin_unlock_irq+0x20/0x5c
[  295.166337][T298@C0] evict_folios+0x2504/0x3050
[  295.166337][T298@C0] shrink_one+0x174/0x4cc
[  295.166337][T298@C0] shrink_node+0x1c50/0x2088
[  295.166337][T298@C0] do_try_to_free_pages+0x560/0xef8
[  295.166337][T298@C0] try_to_free_pages+0x4e8/0xaf0
[  295.166337][T298@C0] __alloc_pages_slowpath+0x92c/0x1c78
[  295.166337][T298@C0] __alloc_pages+0x404/0x48c
[  295.166337][T298@C0] erofs_allocpage+0x90/0xb0
[  295.167317][T298@C0] preemptoff_warn: C0 T:<298>logd.writer
D:43.424ms F:295.123888s
[  295.168484][T8210@C7] C7 T:<8210>syz-executor D:32.816ms F:295.135666s
[  295.168507][T8210@C7] C7 enabled IRQ at:
[  295.168507][T8210@C7] _raw_spin_unlock_irq+0x20/0x5c
[  295.168507][T8210@C7] evict_folios+0x2504/0x3050
[  295.168507][T8210@C7] shrink_one+0x174/0x4cc
[  295.168507][T8210@C7] shrink_node+0x1c50/0x2088
[  295.168507][T8210@C7] do_try_to_free_pages+0x560/0xef8
[  295.168507][T8210@C7] try_to_free_pages+0x4e8/0xaf0
[  295.168507][T8210@C7] __alloc_pages_slowpath+0x92c/0x1c78
[  295.168507][T8210@C7] __alloc_pages+0x404/0x48c
[  295.168507][T8210@C7] __get_free_pages+0x24/0x3c
[  295.168625][T8210@C7] preemptoff_warn: C7 T:<8210>syz-executor
D:32.956ms F:295.135666s
[  295.168645][T8210@C7] preemptoff_warn: C7 enabled preempt at:
[  295.168645][T8210@C7] _raw_spin_unlock_irq+0x2c/0x5c
[  295.168645][T8210@C7] evict_folios+0x2504/0x3050
[  295.168645][T8210@C7] try_to_shrink_lruvec+0x40c/0x594
[  295.168645][T8210@C7] shrink_one+0x174/0x4cc
[  295.168645][T8210@C7] shrink_node+0x1c50/0x2088
[  295.168645][T8210@C7] do_try_to_free_pages+0x560/0xef8
[  295.168645][T8210@C7] try_to_free_pages+0x4e8/0xaf0
[  295.168645][T8210@C7] __alloc_pages_slowpath+0x92c/0x1c78
[  295.168645][T8210@C7] __alloc_pages+0x404/0x48c
[  295.178291][T8441@C2] C2 T:<8441>syz.3.18 D:42.290ms F:295.135998s
[  295.178356][T8441@C2] C2 enabled IRQ at:
[  295.178356][T8441@C2] _raw_spin_unlock_irq+0x20/0x5c
[  295.178356][T8441@C2] evict_folios+0x2504/0x3050
[  295.178356][T8441@C2] shrink_one+0x174/0x4cc
[  295.178356][T8441@C2] shrink_node+0x1c50/0x2088
[  295.178356][T8441@C2] do_try_to_free_pages+0x560/0xef8
[  295.178356][T8441@C2] try_to_free_pages+0x4e8/0xaf0
[  295.178356][T8441@C2] __alloc_pages_slowpath+0x92c/0x1c78
[  295.178356][T8441@C2] __alloc_pages+0x404/0x48c
[  295.178356][T8441@C2] bpf_ringbuf_alloc+0x22c/0x434
[  295.179135][T8441@C2] preemptoff_warn: C2 T:<8441>syz.3.18
D:43.128ms F:295.136000s

>
> >
> > >
> > > +               if (get_nr_gens(lruvec, !type) =3D=3D MIN_NR_GENS) {
> > > +                       spin_unlock_irq(&lruvec->lru_lock);
> > > +                       reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLA=
TED);
> > > +                       spin_lock_irq(&lruvec->lru_lock);
> > > +                       try_to_inc_min_seq(lruvec, get_swappiness(lru=
vec, sc));
> > > +               } else
> > > +                       return 0;
> > > +       }
> > >
> > >         gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
> > >
> > > --
> > > 2.25.1
> > >

