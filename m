Return-Path: <linux-kernel+bounces-316065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199796CAB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D641F2859C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D717ADFF;
	Wed,  4 Sep 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItZf545u"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626BF79E1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725491444; cv=none; b=NEyTEfqIv5/EUuqR2YREBb7Lzx/7jm5vVS1Irik5srzKQOmuxFqrdBpawHf7gBlYrg3WD0D2q0spkAtJPAFd2+y7jxVeEi7PwZOkkwYdZN96kGkWKFKKcnljX4BBZXs1XHMTJBqPztAEQZl1wFIyOCTO1I+aM6gwiM97ByyRQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725491444; c=relaxed/simple;
	bh=I2QkPlHDUFNVxGS1eT5zUO4WTAFZlS+EmobYRmoYUlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSGuCCGN0hv5sV5uu8vKWT/UnTjxm+t65EjfSi0+ORHMRWCF2wdUH9LdkSs5mIEJN9Ljs7QSiZ1n44wvPvGSj6H6Gg197KJUG8ZG+Dt8ZqKjAaonjn2zT1DvqhsIgkkFXWwfmpgbHTiAOc5491WRMbDJqG/RwZOly+l9KkqUx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItZf545u; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4fd01340753so57882e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725491441; x=1726096241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAn3JxDFP21r4YFSVaV3PAOM9PQK/tnDHy5YesZx4b0=;
        b=ItZf545uIqDH0Bj5xV9j5xe3V3gXBqfEOhHgQ1iTbHsNRh9D6DXF8kIPlyIoqZQeXf
         N140W4DHLNV++yh19roj2IBkv+cSzGmvQMg/dL22rIQ5NKBqO6/nl2C7SIB+vWezJzZZ
         wbdBTGg0DkIjhtg4P1ZLDtvsXotN+Gi0hT6wMwlVkrRER2qXLlylyULVQtpCVTGp0jUn
         Sd0RLa9F1FGQ2s7JckMgnG78MX9yZzl/Ni4rNto45FxGCVRnm+pUlK104z40QHQTqgQ6
         ww2YtPMt2F1k2EKKFkZ3Yq//F4CgtNFcYyGNnGBjcb4xwq46eLUMXbKDsbK8eebTJrUt
         HfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725491441; x=1726096241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAn3JxDFP21r4YFSVaV3PAOM9PQK/tnDHy5YesZx4b0=;
        b=cjTwhyfMoNLatdluMP1o/fDDFxWHITnEcI8d6yh5XaqWl2TonrwEwFHaHcczNv0BO8
         cvQ8WuA+1Yao96lBw7buokRjR9YM7VCIdINxVOvMFf6HuQBdiw7jjsTpQeYn2nTe5h86
         l5qUCRbNzEuTsLePNH0613rPIkDl1VWh7UQ44eNGu6zKKVSwa2vc1Cur/Y5gxJ5aTtrj
         bIW4RcZPAqpP39KGRVTjA8aykXLHxwltrj25kP/pGeefMG27tX79h5iDi6+HQBwQy7MW
         TbgicXdLjGUj3mw7ii5kYIL4y8wj1Qv41cFsy0hxuvF2ZA24/pGd9dsSoCiJFfeiCZ0O
         NuhA==
X-Forwarded-Encrypted: i=1; AJvYcCX23MbwARhq32B4+aobCAkkEZy4BIpj5xFmasVUVuvEvVophrc58SfRG1iNVA3z7iPMfoXlCn06LYfLcBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEN+ZeDT9b6eqV5meSaHcKC1wI6ZPVHpc2h0hibNO570KOM51F
	zbptFf43/3moPfy1pzzxbhX/1FlxMYQz+wzNomRLP9mTYqBpmCJQFBVwlm4VXu5l3GldecxKe2q
	TgjgaTDm9CB0F14CrfSGix8LZSMs=
X-Google-Smtp-Source: AGHT+IF0nxgkJPT1EowO940ec9V3dG6+UpfFlus+7DDGlDtsdpQ3GiO+IzEIUUDE4WmYDd3XylSpIn26qPRbYxqarMQ=
X-Received: by 2002:a05:6122:20a1:b0:4f5:2276:1366 with SMTP id
 71dfb90a1353d-4ffe4a58f0dmr21580879e0c.3.1725491441030; Wed, 04 Sep 2024
 16:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com> <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com>
In-Reply-To: <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 11:10:29 +1200
Message-ID: <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:30=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>
>
> On 03/09/2024 23:05, Yosry Ahmed wrote:
> > On Tue, Sep 3, 2024 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >>
> >> On Wed, Sep 4, 2024 at 8:08=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> >>>
> >>> On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> >>>
> >>>>> [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000007
> >>>>> [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000001
> >>>>> [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 000=
07ffd619d5518
> >>>>> [   39.158998]  </TASK>
> >>>>> [   39.159226] ---[ end trace 0000000000000000 ]---
> >>>>>
> >>>>> After reverting this or Usama's "mm: store zero pages to be swapped
> >>>>> out in a bitmap", the problem is gone. I think these two patches ma=
y
> >>>>> have some conflict that needs to be resolved.
> >>>>
> >>>> Yup. I saw this conflict coming and specifically asked for this
> >>>> warning to be added in Usama's patch to catch it [1]. It served its
> >>>> purpose.
> >>>>
> >>>> Usama's patch does not handle large folio swapin, because at the tim=
e
> >>>> it was written we didn't have it. We expected Usama's series to land
> >>>> sooner than this one, so the warning was to make sure that this seri=
es
> >>>> handles large folio swapin in the zeromap code. Now that they are bo=
th
> >>>> in mm-unstable, we are gonna have to figure this out.
> >>>>
> >>>> I suspect Usama's patches are closer to land so it's better to handl=
e
> >>>> this in this series, but I will leave it up to Usama and
> >>>> Chuanhua/Barry to figure this out :)
> >>
> >> I believe handling this in swap-in might violate layer separation.
> >> `swap_read_folio()` should be a reliable API to call, regardless of
> >> whether `zeromap` is present. Therefore, the fix should likely be
> >> within `zeromap` but not this `swap-in`. I=E2=80=99ll take a look at t=
his with
> >> Usama :-)
> >
> > I meant handling it within this series to avoid blocking Usama
> > patches, not within this code. Thanks for taking a look, I am sure you
> > and Usama will figure out the best way forward :)
>
> Hi Barry and Yosry,
>
> Is the best (and quickest) way forward to have a v8 of this with
> https://lore.kernel.org/all/20240904055522.2376-1-21cnbao@gmail.com/
> as the first patch, and using swap_zeromap_entries_count in alloc_swap_fo=
lio
> in this support large folios swap-in patch?

Yes, Usama. i can actually do a check:

zeromap_cnt =3D swap_zeromap_entries_count(entry, nr);

/* swap_read_folio() can handle inconsistent zeromap in multiple entries */
if (zeromap_cnt > 0 && zeromap_cnt < nr)
       try next order;

On the other hand, if you read the code of zRAM, you will find zRAM has
exactly the same mechanism as zeromap but zRAM can even do more
by same_pages filled. since zRAM does the job in swapfile layer, there
is no this kind of consistency issue like zeromap.

So I feel for zRAM case, we don't need zeromap at all as there are duplicat=
ed
efforts while I really appreciate your job which can benefit all swapfiles.
i mean, zRAM has the ability to check "zero"(and also non-zero but same
content). after zeromap checks zeromap, zRAM will check again:

static int zram_write_page(struct zram *zram, struct page *page, u32 index)
{
       ...

        if (page_same_filled(mem, &element)) {
                kunmap_local(mem);
                /* Free memory associated with this sector now. */
                flags =3D ZRAM_SAME;
                atomic64_inc(&zram->stats.same_pages);
                goto out;
        }
        ...
}

So it seems that zeromap might slightly impact my zRAM use case. I'm not
blaming you, just pointing out that there might be some overlap in effort
here :-)

>
> Thanks,
> Usama

Thanks
Barry

