Return-Path: <linux-kernel+bounces-305821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D39634DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036381C24621
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC91AD40E;
	Wed, 28 Aug 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT3TewUW"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182A1ACE10
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884495; cv=none; b=uM2/LA/NiPrCnX5HmjhTpt2UnbspvpPAszb41G6z8wGIYTBsT49mLzD/MdcPZ9XwkkO1Nvq18oAFcSQ5H6GHbIG5PeI0JN4WcTJRsiMyPLUUZMUuKVyGGn63Gy+0SB5MzvXb0+x+NijWxu9+Nz05kfdoMb8vlZ9C8jqUELX3128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884495; c=relaxed/simple;
	bh=z0DhTX8fYIHReskFFZabxzM3sVV6eDYOVk1eCVzfB9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BD72UfUAE0bNShZieisg+KMbTQUqzyqcb35hIhQX/1NO+l6hCYbtc6B0mOGyDS7+X/uQBV+oZsM4dY3bEQx6foIhjVKJJBYelynCLZ9ZGcXRyhxkBTm3+cCpMzgjsD7rrDZ/osXdhmLeAXsHRTkfHStyvaJ5VKfX9ixuRMiBpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tT3TewUW; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-842fdb1afb1so21433241.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724884493; x=1725489293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41f5gi45pknPv02YTSCRYyHEn7QAxd1eKb1xj0lbARc=;
        b=tT3TewUWc0k7xOtBiwIkslFN6ZvIv8jCOCTd87bvEL8xMoo9kNUSt4ILHA8h9byd5u
         g8o3f/Wfi0FmZZS+E9JZupEjxHTLFHM/kDsD721VAqEfAMFnLuA2EDAZBnS4BHUHm7Q3
         /8k5Af1jTHOYkqugTTd8VSPcaZo7I9wTsYCq/S/ziDMDpllkWNYx8UG8+FmEPaFIWy+P
         qw7Zocaio7Uf3b5eG8pZ2cJJ10W/z+kqdGTw8oClSkLLyGVFOvsPRDNZqzdyu3Sc3omd
         5IEN4l+PyueeKVmf7n54TqvrAACW/C7K6CdhkJ7KRGphXF/JUXW6MRlTR55i5qb+bUEl
         K3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884493; x=1725489293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41f5gi45pknPv02YTSCRYyHEn7QAxd1eKb1xj0lbARc=;
        b=F3rr/1uLr5XjWZs+xBbvjR/gdEQyY+cxypNmXA/Xu1jUQu4kJALUc9xnEwGHwH3qIr
         xk6ySMUJ5o/uPbUrQKYosS3vFIuqNzGOnB4D1n93FTb5NPLoejuyyxo2p69GAy/92Ojc
         3TnycrV0UBA/d/BEizTV6p1++GFFdlNoJOF/lL4Fp1t2G9tBgwRQYE6qpYTNps38YmU9
         aOrR2sQesPu4ULsMqxM7aYdJKt0Z63FsALmBuduubxoSwQqJ3OWaDn0bU1Shg0kD5/+M
         Na1Cgb/jyDpykjfEdeBH4ojjrmDxIg5Hr+jen3IMAQGEhm5F+s8Nha+zOUM48hfVE61s
         zzAg==
X-Forwarded-Encrypted: i=1; AJvYcCUvc5kl9gDxdYdnGQPOYpu+erRL1Dw2lgSw43EfU91vdQZQj0rPNVZt2OJoAMjM2e0K834BLoDcX94B06A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfL5XSH0cUUSN4ki9EP+M4jkpPQIAtrfX0hhbaNI4IPYwKtYot
	Cz8ds44kIbPNPL8nz4Hc9379sFCB/wEjgKBT683+0jiBqMhNqGTSpAK3M2Rt2T5IPcm6ezuJTLC
	3b2iR3hPZUgWGDQRWiyTygF+VL3G3PS4OGRP4
X-Google-Smtp-Source: AGHT+IFvmewkWoVr6K28frknzrUzXljJbINQuPS+H2qE0+ZfxUiThxc1/+OfgJyyVnpewvG3hqOFR86H2Buei3/+eGg=
X-Received: by 2002:a05:6102:dcb:b0:49a:4992:e1d8 with SMTP id
 ada2fe7eead31-49a5afa1f6fmr1330145137.31.1724884492830; Wed, 28 Aug 2024
 15:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
 <DM8PR11MB5671D72CED6850CDBB62B95FC9942@DM8PR11MB5671.namprd11.prod.outlook.com>
 <SJ0PR11MB567807116A760D785F9822EBC9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkb0Lnq+mrFtpba80ck76BF2Hnc9Rn8OVs_7dqmE2Hww2w@mail.gmail.com> <SJ0PR11MB56788C517A01B83174591A45C9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56788C517A01B83174591A45C9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 15:34:13 -0700
Message-ID: <CAJD7tkakML3vrZzG_tnxU9SuA3DFGiZY4pQDn4Yruv9y9vhVNg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:50=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Yosry,
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Wednesday, August 28, 2024 12:44 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: Nhat Pham <nphamcs@gmail.com>; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; hannes@cmpxchg.org; ryan.roberts@arm.com; Huang, Ying
> > <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> > Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
> >
> > [..]
> > >
> > > This shows that in all cases, reclaim_high() is called only from the =
return
> > > path to user mode after handling a page-fault.
> >
> > I am sorry I haven't been keeping up with this thread, I don't have a
> > lot of capacity right now.
> >
> > If my understanding is correct, the summary of the problem we are
> > observing here is that with high concurrency (70 processes), we
> > observe worse system time, worse throughput, and higher memory_high
> > events with zswap than SSD swap. This is true (with varying degrees)
> > for 4K or mTHP, and with or without charging zswap compressed memory.
> >
> > Did I get that right?
>
> Thanks for your review and comments! Yes, this is correct.
>
> >
> > I saw you also mentioned that reclaim latency is directly correlated
> > to higher memory_high events.
>
> That was my observation based on the swap-constrained experiments with 4G=
 SSD.
> With a faster compressor, we allow allocations to proceed quickly, and if=
 the pages
> are not being faulted in, we need more swap slots. This increases the pro=
bability of
> running out of swap slots with the 4G SSD backing device, which, as the d=
ata in v4
> shows, causes memcg_swap_fail events, that drive folios to be resident in=
 memory
> (triggering memcg_high breaches as allocations proceed even without zswap=
 cgroup
> charging).
>
> Things change when the experiments are run in a situation where there is =
abundant
> swap space and when the default behavior of zswap compressed data being c=
harged
> to the cgroup is enabled, as in the data with 176GiB ZRAM as ZSWAP's back=
ing
> swapfile posted in v5. Now, the critical path to workload performance cha=
nges to
> concurrent reclaims in response to memcg_high events due to allocation an=
d zswap
> usage. We see a lesser increase in swapout activity (as compared to the s=
wap-constrained
> experiments in v4), and compress latency seems to become the bottleneck. =
Each
> individual process's throughput/sys time degrades mainly as a function of=
 compress
> latency. Anyway, these were some of my learnings from these experiments. =
Please
> do let me know if there are other insights/analysis I could be missing.
>
> >
> > Is it possible that with SSD swap, because we wait for IO during
> > reclaim, this gives a chance for other processes to allocate and free
> > the memory they need. While with zswap because everything is
> > synchronous, all processes are trying to allocate their memory at the
> > same time resulting in higher reclaim rates?
> >
> > IOW, maybe with zswap all the processes try to allocate their memory
> > at the same time, so the total amount of memory needed at any given
> > instance is much higher than memory.high, so we keep producing
> > memory_high events and reclaiming. If 70 processes all require 1G at
> > the same time, then we need 70G of memory at once, we will keep
> > thrashing pages in/out of zswap.
> >
> > While with SSD swap, due to the waits imposed by IO, the allocations
> > are more spread out and more serialized, and the amount of memory
> > needed at any given instance is lower; resulting in less reclaim
> > activity and ultimately faster overall execution?
>
> This is a very interesting hypothesis, that is along the lines of the
> "slower compressor" essentially causing allocation stalls (and buffering =
us from
> the swap slots unavailability effect) observation I gathered from the 4G =
SSD
> experiments. I think this is a possibility.
>
> >
> > Could you please describe what the processes are doing? Are they
> > allocating memory and holding on to it, or immediately freeing it?
>
> I have been using the vm-scalability usemem workload for these experiment=
s.
> Thanks Ying for suggesting I use this workload!
>
> I am running usemem with these config options: usemem --init-time -w -O -=
n 70 1g.
> This forks 70 processes, each of which does the following:
>
> 1) Allocates 1G mmap virtual memory with MAP_ANONYMOUS, read/write permis=
sions.
> 2) Steps through and accesses each 8 bytes chunk of memory in the mmap-ed=
 region, and:
>     2.a) Writes the index of that chunk to the (unsigned long *) memory a=
t that index.
> 3) Generates statistics on throughput.
>
> There is an "munmap()" after step (2.a) that I have commented out because=
 I wanted to
> see how much cold memory resides in the zswap zpool after the workload ex=
its. Interestingly,
> this was 0 for 64K mTHP, but of the order of several hundreds of MB for 2=
M THP.

Does the process exit immediately after step (3)? The memory will be
unmapped and freed once the process exits anyway, so removing an unmap
that immediately precedes the process exiting should have no effect.

I wonder how this changes if the processes sleep and keep the memory
mapped for a while, to force the situation where all the memory is
needed at the same time on SSD as well as zswap. This could make the
playing field more even and force the same thrashing to happen on SSD
for a more fair comparison.

It's not a fix, if very fast reclaim with zswap ends up causing more
problems perhaps we need to tweak the throttling of memory.high or
something.

