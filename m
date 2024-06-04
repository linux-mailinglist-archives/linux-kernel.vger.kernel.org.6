Return-Path: <linux-kernel+bounces-201221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CDC8FBB28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A0ABB2A918
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96114A4DB;
	Tue,  4 Jun 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXGi1TRT"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2A18635
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524142; cv=none; b=nL4suiM8rTFwDxwbYV7oYHQUdpLK/aMpoi9oHP0muRazQsfQQgg4pj29Sck33ykftqW6o6uI2q8GlbwWoU+nRySDhZIyyKEcerH3cPOronOTFyvAajEZVt6quNvE5qPIbXNlKTCYFOt8zu7ZOfIhGe451B1KzLtk4bzEA2fPt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524142; c=relaxed/simple;
	bh=tHWLGQWisUQj7HhRAw2go4sy8LHyULISrzif4HyJkSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8cUvVAypQclA1pRpoqbHBdMkhbE3DB3cBSRsYcnn/n02BwR/lmfkqcpSJzBrOXgMjOxilSy9Lbx4E2XbYbZQucMB9AJaqIC7z7hm/KwXJW5laF+/n4s4inELgbV7uSBTNsrfV+JghCyM4bWtvIixQ3Qcj2i5Qp2KF6c/AXnc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXGi1TRT; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9c36db8eeso3335531b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717524139; x=1718128939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHWLGQWisUQj7HhRAw2go4sy8LHyULISrzif4HyJkSE=;
        b=XXGi1TRTITQwz1xn5H/aKaCoS1R041RPFztAHSxRoiXq3+Bw7CYbeYIWqAYHmmcWLN
         T5WTQKTHaDSFhcvizWs4M6wfWiZwSgDc0Bc8cF+jntVDel//da+vKKInTbayVL2iUssB
         aTOozmG3g2u6UGpBQdZ0ofPZQpDWIfMHV/vlX0H/h1DCZX9N/t9yMrn7Kibr73vcvXsi
         vw3IsQvtfbgG9KuRz6k0IwUeBbfRj5bGKTmtmt2scRJT0YIeOJgfa+fgWt9ew29T58m9
         yZepVSVY5JclGQKnIZYKgyW9cefdtDdwuJ7Qixxij8WALOlIBUuuU8M/yKTSt4TpwcU4
         iGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524139; x=1718128939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHWLGQWisUQj7HhRAw2go4sy8LHyULISrzif4HyJkSE=;
        b=CWEQT6RDG7677oymRtJ5Y7C2SBiT7bGfErkWqR/BasSlAz0cDuD86a+ykyG0HQKhRf
         I8SqcyOb5iz8G/CmQJFaNNV44OCULJL9Rzci8gCwN7f9fmcjXtPM8cqymmo3GNJwE+d3
         vFG19IWKS3bbo6frVERWSJvn5lxkApniZkP4uC7sDliC3n8xiz7T9kZizCu+IMwIbKUI
         mcc2JJ8QyBEL1bckJb5weLE3iVilljnVmlaI17I96DMO8JEtAFzftpF1h2gUw7cmek52
         WLqR03UNghSNVaEVPikORr+4EbjoIrmi1d1KWTnBIhkznA+U1iKiRcBqZkgEkE6beaCt
         Iy1g==
X-Forwarded-Encrypted: i=1; AJvYcCXnY38QYd3SqZk77BkxcZR9vsJEhjU9YzfMy916U3jiKH7wmAZ7NCNj15KHoRnzH2izCBTeZP8x6/mYN5F9R/5mVQjIaNPRiwaVeDCX
X-Gm-Message-State: AOJu0YzSUAvCCEkdpiyDNh4+Ky2j2fDxQxAvZa9JndF1SU6GshWP+0J5
	52ewilT8lAJjb8YDFfDuKxAmj5f/eoDUaHQ7sPznxs0e+wXP2DyJctlwJHOUTpIrn35euC9RIIs
	4R4gMs3acXxlR4Ir1Wahvlwc4kKA406R+Jdj9
X-Google-Smtp-Source: AGHT+IGLP4t3hL8c6rQwnWojRitsYcXuRXha13VBXTuVelVGnvix3EEiSfqrbr4AO/JmxEnQlMJSjTPnhcgT9+b9UCM=
X-Received: by 2002:a05:6808:911:b0:3d1:d9e6:7ee9 with SMTP id
 5614622812f47-3d20439d504mr112188b6e.33.1717524139167; Tue, 04 Jun 2024
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com> <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
In-Reply-To: <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 4 Jun 2024 11:01:39 -0700
Message-ID: <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yu Zhao <yuzhao@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:54=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jun 4, 2024 at 11:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 4, 2024 at 10:19=E2=80=AFAM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Tue, Jun 4, 2024 at 10:12=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Tue, Jun 4, 2024 at 4:45=E2=80=AFAM Erhard Furtner <erhard_f@mai=
lbox.org> wrote:
> > > > >
> > > > > On Mon, 3 Jun 2024 16:24:02 -0700
> > > > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> > > > > > Thanks for bisecting. Taking a look at the thread, it seems lik=
e you
> > > > > > have a very limited area of memory to allocate kernel memory fr=
om. One
> > > > > > possible reason why that commit can cause an issue is because w=
e will
> > > > > > have multiple instances of the zsmalloc slab caches 'zspage' an=
d
> > > > > > 'zs_handle', which may contribute to fragmentation in slab memo=
ry.
> > > > > >
> > > > > > Do you have /proc/slabinfo from a good and a bad run by any cha=
nce?
> > > > > >
> > > > > > Also, could you check if the attached patch helps? It makes sur=
e that
> > > > > > even when we use multiple zsmalloc zpools, we will use a single=
 slab
> > > > > > cache of each type.
> > > > >
> > > > > Thanks for looking into this! I got you 'cat /proc/slabinfo' from=
 a good HEAD, from a bad HEAD and from the bad HEAD + your patch applied.
> > > > >
> > > > > Good was 6be3601517d90b728095d70c14f3a04b9adcb166, bad was b8cf32=
dc6e8c75b712cbf638e0fd210101c22f17 which I got both from my bisect.log. I g=
ot the slabinfo shortly after boot and a 2nd time shortly before the OOM or=
 the kswapd0: page allocation failure happens. I terminated the workload (s=
tress-ng --vm 2 --vm-bytes 1930M --verify -v) manually shortly before the 2=
 GiB RAM exhausted and got the slabinfo then.
> > > > >
> > > > > The patch applied to git b8cf32dc6e8c75b712cbf638e0fd210101c22f17=
 unfortunately didn't make a difference, I got the kswapd0: page allocation=
 failure nevertheless.
> > > >
> > > > Thanks for trying this out. The patch reduces the amount of wasted
> > > > memory due to the 'zs_handle' and 'zspage' caches by an order of
> > > > magnitude, but it was a small number to begin with (~250K).
> > > >
> > > > I cannot think of other reasons why having multiple zsmalloc pools
> > > > will end up using more memory in the 0.25GB zone that the kernel
> > > > allocations can be made from.
> > > >
> > > > The number of zpools can be made configurable or determined at runt=
ime
> > > > by the size of the machine, but I don't want to do this without
> > > > understanding the problem here first. Adding other zswap and zsmall=
oc
> > > > folks in case they have any ideas.
> > >
> > > Hi Erhard,
> > >
> > > If it's not too much trouble, could you "grep nr_zspages /proc/vmstat=
"
> > > on kernels before and after the bad commit? It'd be great if you coul=
d
> > > run the grep command right before the OOM kills.
> > >
> > > The overall internal fragmentation of multiple zsmalloc pools might b=
e
> > > higher than a single one. I suspect this might be the cause.
> >
> > I thought about the internal fragmentation of pools, but zsmalloc
> > should have access to highmem, and if I understand correctly the
> > problem here is that we are running out of space in the DMA zone when
> > making kernel allocations.
> >
> > Do you suspect zsmalloc is allocating memory from the DMA zone
> > initially, even though it has access to highmem?
>
> There was a lot of user memory in the DMA zone. So at a point the
> highmem zone was full and allocation fallback happened.
>
> The problem with zone fallback is that recent allocations go into
> lower zones, meaning they are further back on the LRU list. This
> applies to both user memory and zsmalloc memory -- the latter has a
> writeback LRU. On top of this, neither the zswap shrinker nor the
> zsmalloc shrinker (compaction) is zone aware. So page reclaim might
> have trouble hitting the right target zone.

I see what you mean. In this case, yeah I think the internal
fragmentation in the zsmalloc pools may be the reason behind the
problem.

How many CPUs does this machine have? I am wondering if 32 can be an
overkill for small machines, perhaps the number of pools should be
max(nr_cpus, 32)?

Alternatively, the number of pools should scale with the memory size
in some way, such that we only increase fragmentation when it's
tolerable.

>
> We can't really tell how zspages are distributed across zones, but the
> overall number might be helpful. It'd be great if someone could make
> nr_zspages per zone :)

