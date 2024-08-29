Return-Path: <linux-kernel+bounces-307377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B12964CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BEC283835
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4631B5ECA;
	Thu, 29 Aug 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJLywIP+"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DC1494AF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951447; cv=none; b=QfeTxEZIfHV6bhBJSrzNajKeFoGOsDSTJxOMtZm8loGq38u3ciMUkYh/UFKThglppQv6MGr8Axu+c0WMAis1jO5Db1ym/xxmiXbZrubqd1bBjzvHICtuephYkZv4eAHoeVgv6jTTVO9f8MWqP6x7j0rA7upOfEL9CmJWZrQUB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951447; c=relaxed/simple;
	bh=qom5VxmFC4o36TM2n6k2TWB6DsCkXjTTOIIwGrrzboA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcAgVgPsTEo+CeC6ohWewUp1Ks1cnpprC0XzmNiXRbgawckDGnywhfXPJBXeEBGdcwsFPvqCm4Ef1mEE6HLNmxoQtT8gamNTJ5GmtCFVGKMWCAUY7tNMW50RJp+mUN6Zz2pRVM92ONo8NF9iV0b/sY9CRhE40N2OnmJAZFzaFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJLywIP+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf6beda0c0so5253236d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724951444; x=1725556244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP4Eh51AekJMydrtI494GdwaaSvpwbU1iqZqBMLS+IU=;
        b=lJLywIP+I5AGYP1SX7gP38il72IwDHkD0gIOsPDfNBl02YD1KCmZNNi+Js3OkC5vjw
         WwOhPk41w4/CEP1Usb2E+hTBtXfufr47RRIM1+tEKlPNjR+bJufHXfJu0o+HeRbdZyeS
         7urCuTedKpIssXaN0P/I5MKSkRI7S+DgqvrlfgN6AH4lwVTswEGDKxYqt94E0DXXUVSR
         VyUntA3RWc0GMiIUVflyKPkrhuamtAIcbjZi9u4SEwTaoP1QEKJ7nyK70aZ3qIiEaWSO
         X5u3l6vqM9kJ012Xa8YBfbXFxqSpA0WoAY3TTuIL+VWqhTP6bxFQ314/BMlMUivCcfr6
         uu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724951444; x=1725556244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP4Eh51AekJMydrtI494GdwaaSvpwbU1iqZqBMLS+IU=;
        b=nzCqoKY9fAQBRjKBUGozQe4flxtFJvq7LvWuGhH8+EuMwRupCZl/3zjYBZO4ynp4Kn
         OVaw5EmHDHFaHiM141FVvbcTmhGOXTGlz1+s1EzKDv2oS0PYguOWjx2ui8bZuw3NaWA0
         Q5S6K9bJ8f5GrWWeTJ1BzEAZi0CWtJ2rcSUoodn3Sisud8AM3hPGlS+BUfXR4+pIrucs
         uqSqNkRvUrt+vKoo2rsqFF3qQDWkptwHzXrFqRCJj+DggJTOl6V2S+G5BMdv1+6GY5bs
         mQzxf8hhvml8R6xwF7mRACYIgmC9+iKs79vSW42yf9pWYqrnPJ7RgbGWn28252BLZVlN
         Ax5g==
X-Gm-Message-State: AOJu0YwWX+UZa8xWwdqFeN2Qwpi2FBEyw8c72aFcxz0+kfMqm66uRElL
	veklVK6wAHmU3ppmP/TJptXDGYlBveJ2MelGCr12P++2F2qVsO1kkFNijx9mbv9xJpe+XAvdRQY
	jgxc2FndGGxQfqGh3ThvRnRApaQ0=
X-Google-Smtp-Source: AGHT+IFpa54Pu1ljtImHw5UT06YP15vm5GYyQ98tkJniYlTA7g9/rJHt3aNNaNy6f62GevtdZtSIWzT2cRatervk8Oo=
X-Received: by 2002:a05:6214:5a0b:b0:6c1:6b5d:8cd with SMTP id
 6a1803df08f44-6c33e6a7d9dmr46646616d6.49.1724951443834; Thu, 29 Aug 2024
 10:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com> <SJ0PR11MB5678412EE36C10CC0D69D036C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678412EE36C10CC0D69D036C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Aug 2024 10:10:32 -0700
Message-ID: <CAKEwX=P3L_uxWs6m9KL_Pqv_LpPpXH4E9gWMT95oi==ZNmqkWQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, Usama Arif <usamaarif642@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:06=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Nhat Pham <nphamcs@gmail.com>
> > Sent: Wednesday, August 28, 2024 2:35 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; yosryahmed@google.com; ryan.roberts@arm.com;
> > Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
> >
> > On Wed, Aug 28, 2024 at 2:35=E2=80=AFAM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > Hi All,
> > >
> > > This patch-series enables zswap_store() to accept and store mTHP
> > > folios. The most significant contribution in this series is from the
> > > earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has be=
en
> > > migrated to v6.11-rc3 in patch 2/4 of this series.
> > >
> > > [1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
> > >      https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> > ryan.roberts@arm.com/T/#u
> > >
> > > Additionally, there is an attempt to modularize some of the functiona=
lity
> > > in zswap_store(), to make it more amenable to supporting any-order
> > > mTHPs. For instance, the function zswap_store_entry() stores a
> > zswap_entry
> > > in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
> > > delete all offsets corresponding to a higher order folio stored in zs=
wap.
> > >
> >
> > Will this have any conflict with mTHP swap work? Especially with mTHP
> > swap-in and zswap writeback.
> >
> > My understanding is from zswap's perspective, the large folio is
> > broken apart into independent subpages, correct? What happens when we
> > have partially written back mTHP (i.e some subpages are in zswap
> > still, whereas others are written back to swap). Would this
> > automatically prevent mTHP swapin?
>
> That is a good point. To begin with, this patch-series would make the def=
ault
> behavior for mTHP swapout/storage and swapin for ZSWAP to be on par with
> ZRAM. From zswap's perspective, imo this is a significant step forward to=
wards
> realizing cold memory storage with mTHP folios. However, it is only a sta=
rting
> point that makes the behavior uniform across zswap/zram. Initially, workl=
oads
> would see a one-time benefit with reclaim being able to swapout mTHP
> folios without splitting, to zswap. If the mTHPs were cold memory, then w=
e
> would have derived latency gains towards memory savings (with zswap).
>
> However, if the mTHP were part of "not so cold" memory, this would result
> in a one-way mTHP conversion to 4K folios. Depending on workloads and the=
ir
> access patterns, we could either see individual 4K folios being swapped i=
n,
> or entire chunks if not the entire (original) mTHP needing to be swapped =
in.
>
> It should be noted that this is more of a performance vs. cold memory
> preservation trade-off that needs to drive mTHP reclaim, storage, swapin =
and
> writeback policy. Different workloads could require different policies. H=
owever,
> even though this patch is only a starting point, it is still functionally=
 correct
> by being equivalent to zram-mTHP, and compatible with the rest of mm and
> swap as far as mTHP. Another important functionality/data consistency dec=
ision
> I made in this patch series is error handling during zswap_store() of mTH=
P:
> in case of any errors, all swap offsets for the mTHP are deleted from the
> zswap xarray/zpool, since we know that the mTHP will now have to be store=
d
> in the backing swap device. IOW, an mTHP is either entirely stored in zsw=
ap,
> or entirely not stored in zswap.
>
> To answer your question, we would need to come up with what the semantics
> would need to be for zswap zpool storage granularity, swapin granularity,
> readahead granularity and writeback wrt mTHP and how the overall swap
> sub-system needs to "preserve" mTHP vs. splitting mTHP into 4K/lower-orde=
r
> folios during swapout. Once we have a good understanding of these policie=
s,
> we could implement them in zswap. Alternately, develop an abstraction tha=
t is
> one level above zswap/zram and makes things easier and shareable between
> zswap and zram. By this, I mean fundamental assumptions such as consecuti=
ve
> swap offsets (for instance). To some extent, this implies that an mTHP as=
 a
> swap entity is defined by consecutiveness of swap offsets. Maybe the poli=
cy
> to keep mTHPs in the system over extended duration might be to assemble
> them dynamically based on swapin_readahead() decisions (which is based on
> workload access patterns). In other words, mTHPs could be a useful abstra=
ction
> that can be static or even dynamic based on working set characteristics, =
and
> cold memory preservation. This is quite a complex topic imho.
>
> As we know, Barry Song and Chuanhua Han have started the discussion on
> this in their zram mTHP swapin series [1].

Yeah I'm a bit more concerned with the correctness aspect. As long as
it's not buggy, then we can implement mTHP zswapout first, and force
individual subpage (z)swapin for now (since we cannot control
writeback from writing individual subpages).

We can discuss strategy to harmonize mTHP, zswap (with writeback) as
we go along.

BTW, I think we're not cc-ing Chengming? Is the get_maintainers script
not working properly... Let me manually add him in - please include
him in future submission and responses, as he is also a zswap reviewer
:)

Also cc-ing Usama who is interested in this work.

>
> [1] https://lore.kernel.org/all/20240821074541.516249-3-hanchuanhua@oppo.=
com/T/#u
>
> Thanks,
> Kanchana

