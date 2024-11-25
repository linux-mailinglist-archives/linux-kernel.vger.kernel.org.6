Return-Path: <linux-kernel+bounces-421440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CBB9D8B72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F9BB2CED9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5F14D43D;
	Mon, 25 Nov 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9Zxfdjv"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0618C322
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555904; cv=none; b=r9YZCHYLXsV6U8rvU/07Jep12xFiCahBb5n9Y2v0StiUwrunXDKXnsVYqPnmbIGuhtmhbCUFPLfHoB/J05uZKCiDhycg7mK6M89iAEu0yYBLHPWWcMTBflWTWGy6w63lub+7dkF/KHJoaaf/KPBAUArh58/ARY16eZ2BCGH+Rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555904; c=relaxed/simple;
	bh=8AvedBOtdtQew9svzqYDe8+6dGe6UB/k3OZ9TUGyqP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+ei7MKM9fNwto+LjbgWeGjBrSJiQkJGlQ/45Lv3PhenM7Tj0Qq52rLT9UVAb6iFUerrQJkn5bXOvpPOMRqiLQMlmHSRkTsOJXzjfyC5D1VZ2xxS6Z4K4JbeIBFXi4oQz8lYUPM9q7H53seQiVZ1kQvUY/J6oOHDMuvtVtrX8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9Zxfdjv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4668caacfb2so357001cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732555900; x=1733160700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO1wp9JV30HhfT5H5hY0d7rnb/YcMaPbWSQ96zslJfA=;
        b=q9ZxfdjvIyDF1+Vni5vYhLxXJ5x6Lxzo3to17PbHy4Gwl0XnZBXuP1Qo4spAWX2/Xe
         gAOyXdwN26Qn/rYLlGjDAbPB9wZJfErAVRyhm0CtlzFRx2StPDItR0t9a6Vf0AsuvU1Y
         21/r4kON/VWcBuRLu1Sh1j7pgwr4hN1eJNeRGkBmxB7GZCBtTQBBl7jxJs9bQeEaX7MP
         Qvy9ffmAaeS7BZHSiePXFyalO6o6OOrvcZhr1NnKizBgAeQB8rE0+t1TZaWeVk7r4hMm
         XxPVTegzyLzsBDOrSxiXvPXnCNU4Pa1zfViP6L8FAlgWC0s2LiwfBHM2Y1ZNZ/DFcD7B
         MZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555900; x=1733160700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO1wp9JV30HhfT5H5hY0d7rnb/YcMaPbWSQ96zslJfA=;
        b=nBsc2Sl92CC3MUtDtzAQ+vhPZKNQELI5ekBFwhp0nAo3W3ho9LyzNiH9K1sae48+fR
         qCUVIooreykyUxy1kfuSHAKS7rss3Y3GjZZEa8U8B+mUYIsU+bKL/7dzqtvVQjlVS4KO
         0DJHAALDQt6J8vOSinTtoCAFNJqv4grumo1s8kliZXwVMCNFT1XEZV8AwxdEf6eyw/kx
         +xtbTngzVMkwjodp8s1d33BVDno7XJGObeUMVi0L1UCIezDGNrAwFOx3hpTqZ80Xsbsc
         atkE1teBU6MOwO0MVRXktEMqpDj1mo4UjDjvr+BTBLgMlTO3DC7yKlqSb+uZACuDjhZV
         ymvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrtlsJqxN52i5LGO4EueutydPlVVwrGfUb9ai9uFMmu0CpJkx0giGwpgpA/0SWF/So9F7oUrxnl0u8/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mDuJBIq8DclJmM7b+pJKNCCg4aKLsDQjwabDwzqxq2/m9/lw
	UrTRMQslQ4jQMZK5VemAXO/7Ws24B/diE+clHUyWlyIBb8+VfQI3YV70pTuuyihyDtGJk86A62Z
	6I1tA1ehRVVUEgAH76wHi2lpoGCjfmrBMrPzBt5BmLcdjAWr2HFACpyg=
X-Gm-Gg: ASbGncv1rhpcrJcplVTaYg6jFwgceF5N22JwE52P+gF2BDoEVXpuyC1+6OU4Bcs4tKy
	RWvOihhAhwF7UM7YsBh12+Q2efYcX92Y=
X-Google-Smtp-Source: AGHT+IEasE6Xd86F7HdWoNwURd8zT59VinAYw5bxbwFoVlYFu7U2PDmBvOnvEcXAQ9Xxdr4i4ZYHlAQnNOLFmL/y5cY=
X-Received: by 2002:a05:622a:4c10:b0:466:8887:6751 with SMTP id
 d75a77b69052e-466888768f5mr5020911cf.23.1732555899774; Mon, 25 Nov 2024
 09:31:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124074318.399027-1-00107082@163.com> <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
In-Reply-To: <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Nov 2024 09:31:28 -0800
Message-ID: <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
Subject: Re: Abnormal values show up in /proc/allocinfo
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:10=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
>
> Hi,
>
> Some update
>
> I reproduce the abnormal values of "func:compaction_alloc" today, just on=
ce. But I have not found a deterministic procedure yet.
> Seems to me, it happens when kcompactd starts to work
>
>     ret_from_fork(100.000% 57/57)
>         kthread(100.000% 57/57)
>             kcompactd(100.000% 57/57)
>                 compact_node(100.000% 57/57)
>                     compact_zone(100.000% 57/57)
>                         migrate_pages(100.000% 57/57)
>                             migrate_pages_batch(100.000% 57/57)
>                                 compaction_alloc(100.000% 57/57)
>
>
> Maybe, kcompactd mess up information needed by memory tracking? Just a wi=
ld guess.
> And those negative signed values, and underflowed unsigned values could a=
lso be the side-effect of memory compaction.
> A wilder guess....

Ok, thanks! I think that's enough for me to start digging. Will post
an update once I find something.
Thanks,
Suren.

>
>
>
> FYI
> David
>
>
>
>
> At 2024-11-25 08:35:54, "Suren Baghdasaryan" <surenb@google.com> wrote:
> >On Sat, Nov 23, 2024 at 11:43=E2=80=AFPM David Wang <00107082@163.com> w=
rote:
> >>
> >> Hi,
> >>
> >> I am running 6.12.0 for a week, and today I notice several strange
> >> items in /proc/allocinfo:
> >>
> >>        -4096 18446744073709551615 mm/filemap.c:3787 func:do_read_cache=
_folio
> >>  -1946730496 18446744073709076340 mm/filemap.c:1952 func:__filemap_get=
_folio
> >>   -903294976 18446744073709331085 mm/readahead.c:263 func:page_cache_r=
a_unbounded
> >>   -353054720 18446744073709465421 mm/shmem.c:1769 func:shmem_alloc_fol=
io
> >>  10547565210        0 mm/compaction.c:1880 func:compaction_alloc
> >>   -156487680 18446744073709513411 mm/memory.c:1064 func:folio_prealloc
> >>  -2422685696 18446744073708960140 mm/memory.c:1062 func:folio_prealloc
> >>  -2332479488 18446744073708982163 fs/btrfs/extent_io.c:635 [btrfs] fun=
c:btrfs_alloc_page_array
> >>
> >> some values are way too large, seems like corrupted/uninitialized, and=
 values for compaction_alloc
> >> are inconsistent: non-zero size with zero count.
> >>
> >> I do not know when those data became this strange, and I have not rebo=
ot my system yet.
> >> Do you guys need extra information before I reboot my system and start=
ed to try reproducing?
> >
> >Hi David,
> >Thanks for reporting. Can you share your .config file? Also, do you
> >see these abnormal values shortly after boot or does it take time for
> >them to get into abnormal state?
> >I'll take a look on Monday and see if there is an obvious issue and if
> >I can reproduce this.
> >Thanks,
> >Suren.
> >
> >>
> >>
> >> Thanks
> >> David
> >>
> >>
> >>
> >>

