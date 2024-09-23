Return-Path: <linux-kernel+bounces-336139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED197EFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844CD1F21992
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43519F104;
	Mon, 23 Sep 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3vZ1BaP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5E13D625
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110467; cv=none; b=Vx4hoA12NLrPieiqmFZ8ENZccFR6Fi8+frp2Gok7DyFv63pCONNcBhBgbbBPeqvZWWy14b8zGO35Jk/CejHleq+cBk0xZmhIzEzAKz/V87G67hUh41PuNk1h2b8luh1aYhnkntrNsw3i2e82RxvnKVX20cKbRsFQ+B9LFhlSY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110467; c=relaxed/simple;
	bh=AIQq9BfzBGfV+VJuokAVF/SgKa31LxKsQJkl4ZMaXpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCbFDDV9AEbfqzOoTTUskTo5KI5DQvEACrmJeNzcPVyu1iNsqxCuCSPVTpqoFqE/WRc47cmkjPgOFnNS07YeNzzcR8g81vSHorJ2K/pz8E8w5sU1Un7Km8tRGmCZslpmhSoYsPGtddy0D1mGCQEIArYsjy7rIE2c42NcFw3GItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3vZ1BaP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83562f9be9so537884666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727110464; x=1727715264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XETdMacu+o7N4b4ReIdSaCukIfjrx18Z91S0X8y5fAA=;
        b=j3vZ1BaPGSFacadjs6cDAYVgoL0JpKOnA7Z2tyT1wjWmyhEyDHnmewzWvOWwxMuk5Y
         bnZAcy30iva4bo1kfAeY/kuLegZfMiXJ3rzogCQVuvEft1HxNh8iNZPN/pC6dZRcQw/b
         emjwxd8hArE00RSLb5eLQ7o89JkmWKoU2KRxdcVTOqx5FN3pb2Cbv5sMhLcTLJrJBz1K
         cpqZ8FbkYFP9xFBXDpsbT/Ekq7cPzOUjPO9MS0RT1iXu1lo4PS0ASyYg+zDFiwV00uuj
         JiWqIOSiwgyZNJVlW+Kkc9m/nJM8ydXnpMQ5ox5uQU7fkrOuzuPOzCPCtbo6UiLeDh/5
         vOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110464; x=1727715264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XETdMacu+o7N4b4ReIdSaCukIfjrx18Z91S0X8y5fAA=;
        b=hruRdGt6iP8KTJAh4AXGnTYu0dJh3MPYTxK3zYbzocQyKwEnJq55xMrZEwPcFFG61K
         uBk7qTjyutgK0ZjD1QUWxX/ZoCMD9tVY/pIcDsrtC5I/MlVcFjMf+OiJq0cU/dbre3n3
         1GknNr5so4/PCzHZgieb2x+X/GdafRymqr9F8PZPg4w7Jnkldmwz4uVOfuTKUhpsABpu
         Zgnd2JaqPG4Iw23iafBtxzLH4NhE3FNCHbNShG1H6Bw9dCe2Ljw6+Jksjh1DCItK09Pv
         6EKKtms5aHVDyCZqY4K53TgwTOpAz9d//fRP31VGPRZ+9BbSzD8OhkWop3VWLI2VZmMN
         vjwg==
X-Forwarded-Encrypted: i=1; AJvYcCVkqGv9W7vUSp28ydHDBhBOvkFM3tQnVg4r4Sx6/qVn7Ib24c0pFBtGKViJ4rO9NOu6R/IvbPHP5TelPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02Yhifg8nwUZl8J73aFSdHZEaiEoaZenjA63co9DOqqSlbnAy
	efp9kQURqVXWrHucsFLuoUc9Mm2acwrEoTHWx7aDIuLjrFuaq8sjlP2FkUdt3rq+dcyIvfvKR/E
	gT0/u8iZg/sb41lyvoBs6BySM9Exyg7DkY32k
X-Google-Smtp-Source: AGHT+IHHD2kds/l82L6lPQGpHZhOksbBaHj/dSlQ8/ggb1gxmfLehhBmB+vMGUP6geJ9I1EkkMafwixx7zrfQmTVWEc=
X-Received: by 2002:a17:906:bc1b:b0:a8d:75ab:17ca with SMTP id
 a640c23a62f3a-a90d5003ff0mr1178368366b.31.1727110463388; Mon, 23 Sep 2024
 09:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com> <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
 <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com> <CAJD7tkYu2v2VnMizVeOTHTNXXbdnd+UqaKhTRfrTC7THUiPPdA@mail.gmail.com>
 <CAGsJ_4wd=6kuwg7v=_ARb+Ay15M8SU776Vjb4rmtiVp8vQg-qA@mail.gmail.com>
 <2c418b81-8f67-4a45-b4d2-d158fa4f05d9@gmail.com> <20240923121041.GB437832@cmpxchg.org>
In-Reply-To: <20240923121041.GB437832@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 23 Sep 2024 09:53:45 -0700
Message-ID: <CAJD7tkbc5-noBxSxDTAT-beSEj5_Qv_L_M-Q=oFEZ_uxP2sNFw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Barry Song <21cnbao@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, 
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, hch@infradead.org, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 5:10=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Sep 23, 2024 at 11:22:30AM +0100, Usama Arif wrote:
> > On 23/09/2024 00:57, Barry Song wrote:
> > > On Thu, Sep 5, 2024 at 7:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >>>> On the other hand, if you read the code of zRAM, you will find zRA=
M has
> > >>>> exactly the same mechanism as zeromap but zRAM can even do more
> > >>>> by same_pages filled. since zRAM does the job in swapfile layer, t=
here
> > >>>> is no this kind of consistency issue like zeromap.
> > >>>>
> > >>>> So I feel for zRAM case, we don't need zeromap at all as there are=
 duplicated
> > >>>> efforts while I really appreciate your job which can benefit all s=
wapfiles.
> > >>>> i mean, zRAM has the ability to check "zero"(and also non-zero but=
 same
> > >>>> content). after zeromap checks zeromap, zRAM will check again:
> > >>>>
> > >>>
> > >>> Yes, so there is a reason for having the zeromap patches, which I h=
ave outlined
> > >>> in the coverletter.
> > >>>
> > >>> https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@g=
mail.com/
> > >>>
> > >>> There are usecases where zswap/zram might not be used in production=
.
> > >>> We can reduce I/O and flash wear in those cases by a large amount.
> > >>>
> > >>> Also running in Meta production, we found that the number of non-ze=
ro filled
> > >>> complete pages were less than 1%, so essentially its only the zero-=
filled pages
> > >>> that matter.
> > >>>
> > >>> I believe after zeromap, it might be a good idea to remove the page=
_same_filled
> > >>> check from zram code? Its not really a problem if its kept as well =
as I dont
> > >>> believe any zero-filled pages should reach zram_write_page?
> > >>
> > >> I brought this up before and Sergey pointed out that zram is sometim=
es
> > >> used as a block device without swap, and that use case would benefit
> > >> from having this handling in zram. That being said, I have no idea h=
ow
> > >> many people care about this specific scenario.
> > >
> > > Hi Usama/Yosry,
> > >
> > > We successfully gathered page_same_filled data for zram on Android.
> > > Interestingly,
> > > our findings differ from yours on zswap.
> > >
> > > Hailong discovered that around 85-86% of the page_same_filled data
> > > consists of zeros,
> > > while about 15% are non-zero. We suspect that on Android or similar
> > > systems, some
> > > graphics or media data might be duplicated at times, such as a red
> > > block displayed
> > > on the screen.
> > >
> > > Does this suggest that page_same_filled could still provide some
> > > benefits in zram
> > > cases?
> >
> > Hi Barry,
> >
> > Thanks for the data, its very interesting to know this from mobile side=
.
> > Eventhough its not 99% that I observed, I do feel 85% is still quite hi=
gh.
>
> Would it be possible to benchmark Android with zram only optimizing
> zero pages?
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index c3d245617083..f6ded491fd00 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -211,6 +211,9 @@ static bool page_same_filled(void *ptr, unsigned long=
 *element)
>         page =3D (unsigned long *)ptr;
>         val =3D page[0];
>
> +       if (val)
> +               return false;
> +
>         if (val !=3D page[last_pos])
>                 return false;
>
> My take is that, if this is worth optimizing for, then it's probably
> worth optimizing for in the generic swap layer too. It makes sense to
> maintain feature parity if we one day want Android to work with zswap.

I am not sure if it's worth it for the generic swap layer. We would
need to store 8 bytes per swap entry to maintain feature parity,
that's about 0.2% of swap capacity as consistent memory overhead. Swap
capacity is usually higher than the actual size of swapped data.

IIUC the data you gathered from prod showed that 1% of same filled
pages were non-zero, and 10-20% of swapped data was same filled [1].
That means that ~0.15% of swapped data is non-zero same-filled.

With zswap, assuming a 3:1 compression ratio, we'd be paying 0.2% of
swap capacity to save around 0.05% of swapped data in memory. I think
it may be worse because that compression ratio may be higher for
same-filled data.

With SSD swap, I am not sure if 0.15% reduction in IO is worth the
memory overhead.

OTOH, zram keeps track of the same-filled value for free because it
overlays the zsmalloc handle (like zswap used to do). So the same
tradeoffs do not apply.

Barry mentioned that 15% of same-filled pages are non-zero in their
Android experiment, but what % of total swapped memory is this, and
how much space does it take if we just compress it instead?

IOW, how much memory is this really saving with zram (especially that
metadata is statically allocated)?

