Return-Path: <linux-kernel+bounces-378714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3076E9AD44A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B580C1F22846
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99D1D0F77;
	Wed, 23 Oct 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHTxd9Gu"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251521BD039;
	Wed, 23 Oct 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709536; cv=none; b=eHkzrN81PC4aoFsoK2RT6Tj2xFdZj+5fXLNOfkSPcbjgBiJvGBw2DV5LuCGliaJjcs2CQfbIuv/asencvsyjaKihNwKopOvfBp+bb/kkhtXAsIo6zMrFduLwzPrrvvSmVhTQFIPgG0oLsFDUZG5eJDmBO1swokCaFGzJ11m3zpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709536; c=relaxed/simple;
	bh=njtUKgrV5OXayg0+Kn+J7g3LEYAnXZ8nLn3vjCWxcZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOZKhLzXPULMc/p2BLHHLnAJbh3S22yXuzQrM8tVZ2tlfHVRSHBpEC0IVGR2q3SKU5oQz0ipJaurTsUEoFxRk7/Qw1SwirW9olfY8i3eN7ZKpQh2lBfMKemPGia59m0+SmgeDB3RTojtMcr5BAvM3RYR5VQbKpa+c9W04zMb2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHTxd9Gu; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fe06fbdc6so28262241.0;
        Wed, 23 Oct 2024 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709534; x=1730314334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOKo15FalVfcgavpWt9liGgilAyV8FkT17tVYolJJFo=;
        b=RHTxd9GuWjgcYFSopQlrvj0JaItcy5E4gM+wEkH//li4VsNHE6Kq7eZSax43o15Ms2
         hvAe93LNbVEsufYAv0OBEwuyuGMEuK5Y5prmOMLFWaRhcxK8lwR/+bHCL70EgmC7I2zg
         WPJNVNPILkfKke6mZWvr6yEKcYFQxvjDQFuDtr9+ogQ3d0HM0EGBmrtGy3tBVuNk7ibo
         x+X2gTD4ADy29Ve3NEwUYRSKiq4sSio3ybFhH5FkQkywnObQGXMmj3eRd5WZdwR7goms
         mXuyPVZ2TnDA+C0jTznU741xnEenjvgBrf9fziVFAUQpUON0VnoLu9RADyUE3dF2blYM
         Wx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709534; x=1730314334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOKo15FalVfcgavpWt9liGgilAyV8FkT17tVYolJJFo=;
        b=MR3FthG/eL6SBGRNZihDgrKu8lp9fLilNzHilI05u7TXY0P0E2Zc+YI2L57y+aNeVc
         I2UAv5HuqIAf/HjX5SWqat2f2uk/+vplAzL4WInEdRaaBk2/0/UrctJlwFY+PBtvLR8/
         UdNrTlRbWCM26iBzdBRpjueGmnjxoBQ5UZDcppgsN2n5OQkYln8I/PjQBlzJ9KM3PKme
         y1bKEi5QlOPQe/FfV7967RNYB88bgqlwdluI9bPECxoQxgUtVR5ISoL6ixz3+ZKU67rj
         2fWKZ8vXUKuKHO5UQA+e70qVlUEoNf/cF+3fkEOeZFd9GfgYTMdz8qav8849G/krBEN7
         l3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX1UcyGA5KyP6uHd05atQT9lcx1joQz3Kdl73/icASyfkWyVkfhUDoPklhof+zCtvF9959aj15C7c5aODr@vger.kernel.org, AJvYcCXmLGnJzmEuxrhlaJJAGGapskJ3FmJ+0I27X1Mirkz1Qa5jdgyPsp6DFz9VHlKOz9m7MnQBPrm3+as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+mBYFdGu8YZPz1ULqyo8X+HfbjMqxV4YiQYMp2XjgzIVutN0
	GLiJwrs2rL+PmbMQT04LFzWkd54lNO/C1InXJpnvelsoCvvEWh7hmleBCQpLoxIXa2akcSSuI6t
	dZC66AMSLSd/J86cxT8xh5oj3G2M=
X-Google-Smtp-Source: AGHT+IGmSoi7EQKoemOA7oupQxpcLLvNt3dGw7kpWMGbnah/qXFQC7NPkc10lQWyw4eDcWzFcExh37M4jpAPSYNm2pY=
X-Received: by 2002:a05:6102:dcf:b0:4a5:c297:7d5a with SMTP id
 ada2fe7eead31-4a751c017f9mr4862582137.16.1729709533848; Wed, 23 Oct 2024
 11:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com> <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
 <CAGsJ_4wykOyJupLhcqkSPe27rdANd=bOJhqxL74vcdZ+T9f==g@mail.gmail.com>
 <eab11780-e671-4d09-86a6-af4cf3589392@gmail.com> <CAGsJ_4wWf7QnibY_uU8B=efuEACrvFaJJ=bJTD+9KrxFtfoMmQ@mail.gmail.com>
 <CAGsJ_4w5XLMok4F6Xw7aTAdV6rY9OvCVPM3U+hzFnKyTXBUpOA@mail.gmail.com>
 <4c30cc30-0f7c-4ca7-a933-c8edfadaee5c@gmail.com> <7a14c332-3001-4b9a-ada3-f4d6799be555@gmail.com>
 <CAJD7tkbrjV3Px8h1p950VZFi9FnzxZPn2Kg+vZD69eEcsQvtxg@mail.gmail.com> <3dca2498-363c-4ba5-a7e6-80c5e5532db5@gmail.com>
In-Reply-To: <3dca2498-363c-4ba5-a7e6-80c5e5532db5@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Oct 2024 07:52:01 +1300
Message-ID: <CAGsJ_4zp=E7izB5oAAiWu14UCqNCSvWhveGoHCP6Wr030SHH1A@mail.gmail.com>
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, senozhatsky@chromium.org, minchan@kernel.org, 
	hanchuanhua@oppo.com, v-songbaohua@oppo.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, david@redhat.com, willy@infradead.org, 
	kanchana.p.sridhar@intel.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:31=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 23/10/2024 19:02, Yosry Ahmed wrote:
> > [..]
> >>>> I suspect the regression occurs because you're running an edge case
> >>>> where the memory cgroup stays nearly full most of the time (this isn=
't
> >>>> an inherent issue with large folio swap-in). As a result, swapping i=
n
> >>>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
> >>>> next swap-in then recreates the overflow, leading to a repeating
> >>>> cycle.
> >>>>
> >>>
> >>> Yes, agreed! Looking at the swap counters, I think this is what is go=
ing
> >>> on as well.
> >>>
> >>>> We need a way to stop the cup from repeatedly filling to the brim an=
d
> >>>> overflowing. While not a definitive fix, the following change might =
help
> >>>> improve the situation:
> >>>>
> >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>>
> >>>> index 17af08367c68..f2fa0eeb2d9a 100644
> >>>> --- a/mm/memcontrol.c
> >>>> +++ b/mm/memcontrol.c
> >>>>
> >>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct fol=
io
> >>>> *folio, struct mm_struct *mm,
> >>>>                 memcg =3D get_mem_cgroup_from_mm(mm);
> >>>>         rcu_read_unlock();
> >>>>
> >>>> -       ret =3D charge_memcg(folio, memcg, gfp);
> >>>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
> >>>> MEMCG_CHARGE_BATCH)
> >>>> +               ret =3D -ENOMEM;
> >>>> +       else
> >>>> +               ret =3D charge_memcg(folio, memcg, gfp);
> >>>>
> >>>>         css_put(&memcg->css);
> >>>>         return ret;
> >>>> }
> >>>>
> >>>
> >>> The diff makes sense to me. Let me test later today and get back to y=
ou.
> >>>
> >>> Thanks!
> >>>
> >>>> Please confirm if it makes the kernel build with memcg limitation
> >>>> faster. If so, let's
> >>>> work together to figure out an official patch :-) The above code has=
n't consider
> >>>> the parent memcg's overflow, so not an ideal fix.
> >>>>
> >>
> >> Thanks Barry, I think this fixes the regression, and even gives an imp=
rovement!
> >> I think the below might be better to do:
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index c098fd7f5c5e..0a1ec55cc079 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio=
 *folio, struct mm_struct *mm,
> >>                 memcg =3D get_mem_cgroup_from_mm(mm);
> >>         rcu_read_unlock();
> >>
> >> -       ret =3D charge_memcg(folio, memcg, gfp);
> >> +       if (folio_test_large(folio) &&
> >> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_n=
r_pages(folio)))
> >> +               ret =3D -ENOMEM;
> >> +       else
> >> +               ret =3D charge_memcg(folio, memcg, gfp);
> >>
> >>         css_put(&memcg->css);
> >>         return ret;
> >>
> >>
> >> AMD 16K+32K THP=3Dalways
> >> metric         mm-unstable      mm-unstable + large folio zswapin seri=
es    mm-unstable + large folio zswapin + no swap thrashing fix
> >> real           1m23.038s        1m23.050s                             =
      1m22.704s
> >> user           53m57.210s       53m53.437s                            =
      53m52.577s
> >> sys            7m24.592s        7m48.843s                             =
      7m22.519s
> >> zswpin         612070           999244                                =
      815934
> >> zswpout        2226403          2347979                               =
      2054980
> >> pgfault        20667366         20481728                              =
      20478690
> >> pgmajfault     385887           269117                                =
      309702
> >>
> >> AMD 16K+32K+64K THP=3Dalways
> >> metric         mm-unstable      mm-unstable + large folio zswapin seri=
es   mm-unstable + large folio zswapin + no swap thrashing fix
> >> real           1m22.975s        1m23.266s                             =
     1m22.549s
> >> user           53m51.302s       53m51.069s                            =
     53m46.471s
> >> sys            7m40.168s        7m57.104s                             =
     7m25.012s
> >> zswpin         676492           1258573                               =
     1225703
> >> zswpout        2449839          2714767                               =
     2899178
> >> pgfault        17540746         17296555                              =
     17234663
> >> pgmajfault     429629           307495                                =
     287859
> >>
> >
> > Thanks Usama and Barry for looking into this. It seems like this would
> > fix a regression with large folio swapin regardless of zswap. Can the
> > same result be reproduced on zram without this series?
>
>
> Yes, its a regression in large folio swapin support regardless of zswap/z=
ram.
>
> Need to do 3 tests, one with probably the below diff to remove large foli=
o support,
> one with current upstream and one with upstream + swap thrashing fix.
>
> We only use zswap and dont have a zram setup (and I am a bit lazy to crea=
te one :)).
> Any zram volunteers to try this?

Hi Usama,

I tried a quick experiment:

echo 1 > /sys/module/zswap/parameters/enabled
echo 0 > /sys/module/zswap/parameters/enabled

This was to test the zRAM scenario. Enabling zswap even
once disables mTHP swap-in. :)

I noticed a similar regression with zRAM alone, but the change resolved
the issue and even sped up the kernel build compared to the setup without
mTHP swap-in.

However, I=E2=80=99m still working on a proper patch to address this. The c=
urrent
approach:

mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio))

isn=E2=80=99t sufficient, as it doesn=E2=80=99t cover cases where group A c=
ontains group B, and
we=E2=80=99re operating within group B. The problem occurs not at the bound=
ary of
group B but at the boundary of group A.

I believe there=E2=80=99s still room for improvement. For example, if a 64K=
B charge
attempt fails, there=E2=80=99s no need to waste time trying 32KB or 16KB. W=
e can
directly fall back to 4KB, as 32KB and 16KB will also fail based on our
margin detection logic.

>
> diff --git a/mm/memory.c b/mm/memory.c
> index fecdd044bc0b..62f6b087beb3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4124,6 +4124,8 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>         gfp_t gfp;
>         int order;
>
> +       goto fallback;
> +
>         /*
>          * If uffd is active for the vma we need per-page fault fidelity =
to
>          * maintain the uffd semantics.

Thanks
Barry

