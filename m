Return-Path: <linux-kernel+bounces-227541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9229152F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643E128319C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95D619D885;
	Mon, 24 Jun 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXWVsimD"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635414264C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244561; cv=none; b=VAQmX4hMKVYiBwMZP5T21T+/D0Gv5+YWXFNDqx6D4KTmKv37D8/utORQhPRraxOvkEFsrEwASdqPm14Tss3vbBvsYp9y6nosADDRK1X8kdbT0HQH9tqHhCEnMF6m8Crbg6dWZ83h/VEUNhTblo/xvb9ph+/XzvG3LSVVI1/WiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244561; c=relaxed/simple;
	bh=B6ewSQHosO2LQ8r+yoQ8Cqbc0dBwA6+lHM2VTS7xLps=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WLti60fcZ/dk4NpIppVoLCQQ/k1hH5OGE/mxeokhuUqPd5H/pUnnr6SK6UOr/Pl6PJmpAlcgJdjp3CstUEBZPVrLOeAqeHRNzCO2VjqldV+8y53f5LJ/DG6nnalz+HkrLaf4GpncdeBH99kIPjrCBtJKUu0VKTi/ol/DseuJQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXWVsimD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so4378792276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719244559; x=1719849359; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfWZn1YU3dRvQeweqJc9tWpIC2Gz+zz9bEPN4e86euI=;
        b=FXWVsimDChC7z74XADrxJz9bEyz5zVKWQLmLVdp686xn1NLjtyyYqIc/C+V4a9OfK1
         89bZHaHHsWmceEf7/1cgd0tfcTT5Xi3Zo4xbmgBXtTnrH44gdFol0YIjfyp2x+nZVv6S
         NoJtQw/Nb7f98G6dq9CbHJUl6miSkXYOhnaCtmTrr7l8byrFolxBQMkphyU0xpDBaJ2z
         /v//qEYhH8eWQuPvHmWHVHPZmsElEZyGKYO1GlUhBu/98A6/N/0AYW+91HlVg/JsOW11
         T5FKC2j27mx2FaYjr0a/Lgqd3eXK/5ynAE6pxRjdPgAYPxto++b+T0xe9g5QNVEJITar
         xCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244559; x=1719849359;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfWZn1YU3dRvQeweqJc9tWpIC2Gz+zz9bEPN4e86euI=;
        b=IqeifZJ9cpKr4whDe7K3Qy4hOcvsFpfIjZZavQf8rJHIwgjoCfgMidzo39V9RUN+br
         fzYFEd99atPNjXKM/jq2ANAVC05Fzc6elRv6UjiyD/kNMwE6ALCRV21KlvOOcc1tDlRX
         BGYelr8+x2t55RSUu6ALfVolDkgMXZvT4LvaDBMVEnkUQRA4CxCPXDToO5eqg5Y/nPKi
         7imt45Gm6QHyysMfXb4mtAb5wtBjk1kc5mJKNE4ZvDi6B2FXScPhGoqsu+YLgU4XLbvX
         U3eUfi82BEOJVp2gfLGWlrU8M8zFDu/ulqfIfLSRm0aG6a8u9RkVz0utpgGxnmROphaK
         9Abw==
X-Forwarded-Encrypted: i=1; AJvYcCUoFfwb2UDNjCbhziQfb4SRJfO2gQNcQaOCO0jXkMSM7qj2zOw3rLRhKXSbGnPh8yQaheUvum5sE+lL6LLb+RTOR2yxyW55kXdYx8bn
X-Gm-Message-State: AOJu0YxT3bvAXcSIm4C4DDW3Mv1AxJFVqYpJ3zH6ye5mlopwYaBbgsRO
	KSxdT2HSgtB1Jm63gknmRkoFGmSLBG2NzkTV8hzBPaUvRQee6ILBzbFkeRirng==
X-Google-Smtp-Source: AGHT+IHheq8hSRwWFmH40xtZQpLDRnZQiHV6+dJIKeNGFC+oqjIVbI5vNUIQt9N20C6HOLf/IK/8dA==
X-Received: by 2002:a25:ea42:0:b0:dfe:3de:87a0 with SMTP id 3f1490d57ef6-e0303f5348amr3897252276.24.1719244558581;
        Mon, 24 Jun 2024 08:55:58 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e6115bf1sm3286801276.10.2024.06.24.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:55:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:55:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usamaarif642@gmail.com>
cc: Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
    kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
    David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
In-Reply-To: <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
Message-ID: <4b16e2bb-d0af-9a9a-3425-e937f9ecc777@google.com>
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com> <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com> <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
 <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-863124913-1719244557=:31879"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-863124913-1719244557=:31879
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 24 Jun 2024, Usama Arif wrote:
> On 24/06/2024 18:26, Hugh Dickins wrote:
> > On Mon, 24 Jun 2024, Usama Arif wrote:
> >> On 24/06/2024 15:05, Yosry Ahmed wrote:
> >>> On Mon, Jun 24, 2024 at 1:49=E2=80=AFAM kernel test robot <oliver.san=
g@intel.com>
> >>> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> kernel test robot noticed
> >>>> "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
> >>>>
> >>>> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pa=
ges
> >>>> to
> >>>> be swapped out in a bitmap")
> >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mas=
ter
> >>> This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), an=
d
> >>> is triggered by the new bitmap_zalloc() call in the swapon path. For =
a
> >>> sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> >>> under the hood) cannot be used to allocate the bitmap.
> >>>
> >>> Usama, I think we want to use a variant of kvmalloc() here.
> > Yes, I hit the same problem with swapon in my testing,
> > and had been intending to send a patch.
> >
> >> Yes, just testing with below diff now. The patch is not in mm-stable y=
et,
> >> so
> >> will just send another revision with below diff included. Thanks!
> >>
> >>
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 0b8270359bcf..2263f71baa31 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -2643,7 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *,
> >> specialfile)
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_percpu(p->cluster_nex=
t_cpu);
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->cluster_next_cpu =3D NU=
LL;
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfree(swap_map);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_free(p->zeromap);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvfree(p->zeromap);
> > Yes.
> >
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvfree(cluster_info);
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Destroy swap account in=
formation */
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swap_cgroup_swapoff(p->typ=
e);
> >> @@ -3170,7 +3170,7 @@ SYSCALL_DEFINE2(swapon, const char __user *,
> >> specialfile, int, swap_flags)
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto bad_swap_unlock_inode;
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->zeromap =3D bitmap_zalloc(max=
pages, GFP_KERNEL);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->zeromap =3D kvzalloc(DIV_ROUN=
D_UP(maxpages, 8), GFP_KERNEL);
> > No, 8 is not right for 32-bit kernels. I think you want
> > =09p->zeromap =3D kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
> > but please check it carefully, I'm easily confused by such conversions.
> >
> > Hugh
>=20
> Ah yes, didnt take into account 32-bit kernel. I think its supposed to be
>=20
> =C2=A0p->zeromap =3D kvzalloc(BITS_TO_LONGS(maxpages) * sizeof(unsigned l=
ong),
> GFP_KERNEL);
>=20
> if using BITS_TO_LONGS.

No doubt you're right (I'm glad I already admitted to being confused).
Personally, I'd just say sizeof(long), but whatever you prefer.

Hugh

>=20
> Will wait sometime incase there are more comments and will send out anoth=
er
> version.
>=20
> Thanks!
>=20
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p->zeromap) {
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error =3D -ENOMEM;
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto bad_swap_unlock_inode;
---1463770367-863124913-1719244557=:31879--

