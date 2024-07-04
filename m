Return-Path: <linux-kernel+bounces-240872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C99273EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769F0B23530
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7720D1AB90C;
	Thu,  4 Jul 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUxVRJip"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C31AAE13
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088617; cv=none; b=l1U6CxqhHH67Hko6k3ab3LfKwrhBLcEkOO9XIktdFvESSfMleL+Y/Suaun84dtGXKwKPQmjR+WrNWUKxurTLMWi8lyZN6v29ed58yjkmFsWGaEzcSwYcv90LQaFkD9sEtfYpigvnxj+SKcc0pGdalwQpse3wq2btrzDjmdzqWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088617; c=relaxed/simple;
	bh=pmMrpsQkK/wpspI2U/cFcPsz5WLQIssniZMRQUbapSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INO0PYwXRx61c16q8Jyr06NXj2DK2BOovqDBkPdRrb0hklKR8ONYmm6H2csLldr5AC+a4Dz2BZGHsfz8JU/9lyrbBv4B5++eGPrHqP2O92HxGdeVPVpOvrHomn99wHLZnvQGHUMLha9Dhwaowna+HixB7CWT3GiWFtBvTM2amUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUxVRJip; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f2f24f6470so173392e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088615; x=1720693415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmwdjVxyjtKsZjEvWiJCTAahZeOXiJ6Fw2zpiu13l0A=;
        b=KUxVRJipMyPJWYQ3jDX2k7x0/1Uh8j9LHPUnSV6ObX+naffR9sn5Z1klqvtupvhYfe
         lH+ESi68+lufY+X5BMemyAuSUOFvmxXBRGytMBASF5yKA/fBZ6OUGfxVDG2h71fW/u8e
         RMbzN7hNKhrNO1U8NRoc33cPtZGU1ebzPFemLte4scVhSnI+GEoa++tqa+YkuuHbjhYW
         WyF9JpgZuyptX630wKV103hZCd0/4bQkwcGssBw5fsfm9H3ejElJQk6Tm3poAQJ3D7+h
         IYfx9iNS+rHLyMGVnPIYQDDY4nc2xGygBba5Ve3vAiAfkhuQwPs5DrQw6uij7HGJXbG9
         7b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088615; x=1720693415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmwdjVxyjtKsZjEvWiJCTAahZeOXiJ6Fw2zpiu13l0A=;
        b=IP2hk8BqqPyQgjM6AeYban7j5dq+pFhwrGH6cDjOKrUItt6Pqt4+0/XUDkuVfgR5Mb
         QGWb+gRZrXcF9DmHgGBo+3L+Cqq0s2mAGVOf0tFJ0Vp/mN6n7uIvHDTeqeaDpBhpJoCR
         6z3xwCM0DhtLVqzDGyxzmi2gMWWOAeDVFfzp8NAPa+fswOFtIouKWvNkENtBEbO2fpvK
         GiJ4/fpGBvvO2PJE55jsWyf2NgyrVuTK3KBoWJ9n4xMAGV4oZ0/EYVlQThLUXOd3V78o
         q/MkjxO1KjMS6l9Z1cU9h2rljQspoR3sLFXkhdCFClHQLZ/fEDpi5QkPX5hWGSRODt/E
         S74g==
X-Forwarded-Encrypted: i=1; AJvYcCW0CFuzVHmZVLyugRrhCJFWfbNP9pts1zVDrW7Ldn77TwrP13KwsBj97jlNE5G1DNA25S+I36pqo2Dyy9PoLRa06cVzAY1sOfUn3/XY
X-Gm-Message-State: AOJu0YzPLG+/CIe8PIWzy+jIX7e47+QrWJ9cB+JkktXBSrAFVefYrUIe
	0RaUQDc+9tAIZg+TBdl5EvxLE1ZrDfCFOIsMlpagmf9zy2YewU2qs3YLpW6glmR0DPia6uzRHkD
	/EneDW3lKPDUQWftCfnclIRJNr4o=
X-Google-Smtp-Source: AGHT+IGWxqnIFpMAmgQZNvh0Y1gAvdLy+PIQwYo9k5U4/xN4SkWGNDHxB0lLKtmbjTikAjoFkutVrOqkihbASZr+zGo=
X-Received: by 2002:a05:6122:4d0c:b0:4ef:6d02:f4a with SMTP id
 71dfb90a1353d-4f2f407a7eamr1398798e0c.13.1720088614717; Thu, 04 Jul 2024
 03:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629111010.230484-1-21cnbao@gmail.com> <87ikxnj8az.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4y7=b9gzKynXnT7rKd4nJ+m+POhMhmGMPKz37o_knpu6g@mail.gmail.com> <8734oqhr4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734oqhr4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 4 Jul 2024 22:23:20 +1200
Message-ID: <CAGsJ_4yKNzZTzfj-deN=cLkgNxb6sbgj75NVH3UYjXVbHykvhg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/2] mm: support mTHP swap-in for zRAM-like swapfile
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, surenb@google.com, 
	kaleshsingh@google.com, hughd@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, yosryahmed@google.com, 
	baolin.wang@linux.alibaba.com, shakeel.butt@linux.dev, 
	senozhatsky@chromium.org, minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:42=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Jul 3, 2024 at 6:33=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >
> > Ying, thanks!
> >
> >> Barry Song <21cnbao@gmail.com> writes:
>
> [snip]
>
> >> > This patch introduces mTHP swap-in support. For now, we limit mTHP
> >> > swap-ins to contiguous swaps that were likely swapped out from mTHP =
as
> >> > a whole.
> >> >
> >> > Additionally, the current implementation only covers the SWAP_SYNCHR=
ONOUS
> >> > case. This is the simplest and most common use case, benefiting mill=
ions
> >>
> >> I admit that Android is an important target platform of Linux kernel.
> >> But I will not advocate that it's MOST common ...
> >
> > Okay, I understand that there are still many embedded systems similar
> > to Android, even if
> > they are not Android :-)
> >
> >>
> >> > of Android phones and similar devices with minimal implementation
> >> > cost. In this straightforward scenario, large folios are always excl=
usive,
> >> > eliminating the need to handle complex rmap and swapcache issues.
> >> >
> >> > It offers several benefits:
> >> > 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP a=
fter
> >> >    swap-out and swap-in.
> >> > 2. Eliminates fragmentation in swap slots and supports successful TH=
P_SWPOUT
> >> >    without fragmentation. Based on the observed data [1] on Chris's =
and Ryan's
> >> >    THP swap allocation optimization, aligned swap-in plays a crucial=
 role
> >> >    in the success of THP_SWPOUT.
> >> > 3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing C=
PU usage
> >> >    and enhancing compression ratios significantly. We have another p=
atchset
> >> >    to enable mTHP compression and decompression in zsmalloc/zRAM[2].
> >> >
> >> > Using the readahead mechanism to decide whether to swap in mTHP does=
n't seem
> >> > to be an optimal approach. There's a critical distinction between pa=
gecache
> >> > and anonymous pages: pagecache can be evicted and later retrieved fr=
om disk,
> >> > potentially becoming a mTHP upon retrieval, whereas anonymous pages =
must
> >> > always reside in memory or swapfile. If we swap in small folios and =
identify
> >> > adjacent memory suitable for swapping in as mTHP, those pages that h=
ave been
> >> > converted to small folios may never transition to mTHP. The process =
of
> >> > converting mTHP into small folios remains irreversible. This introdu=
ces
> >> > the risk of losing all mTHP through several swap-out and swap-in cyc=
les,
> >> > let alone losing the benefits of defragmentation, improved compressi=
on
> >> > ratios, and reduced CPU usage based on mTHP compression/decompressio=
n.
> >>
> >> I understand that the most optimal policy in your use cases may be
> >> always swapping-in mTHP in highest order.  But, it may be not in some
> >> other use cases.  For example, relative slow swap devices, non-fault
> >> sub-pages swapped out again before usage, etc.
> >>
> >> So, IMO, the default policy should be the one that can adapt to the
> >> requirements automatically.  For example, if most non-fault sub-pages
> >> will be read/written before being swapped out again, we should swap-in
> >> in larger order, otherwise in smaller order.  Swap readahead is one
> >> possible way to do that.  But, I admit that this may not work perfectl=
y
> >> in your use cases.
> >>
> >> Previously I hope that we can start with this automatic policy that
> >> helps everyone, then check whether it can satisfy your requirements
> >> before implementing the optimal policy for you.  But it appears that y=
ou
> >> don't agree with this.
> >>
> >> Based on the above, IMO, we should not use your policy as default at
> >> least for now.  A user space interface can be implemented to select
> >> different swap-in order policy similar as that of mTHP allocation orde=
r
> >> policy.  We need a different policy because the performance characters
> >> of the memory allocation is quite different from that of swap-in.  For
> >> example, the SSD reading could be much slower than the memory
> >> allocation.  With the policy selection, I think that we can implement
> >> mTHP swap-in for non-SWAP_SYNCHRONOUS too.  Users need to know what th=
ey
> >> are doing.
> >
> > Agreed. Ryan also suggested something similar before.
> > Could we add this user policy by:
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/swapin_enabled
> > which could be 0 or 1, I assume we don't need so many "always inherit
> > madvise never"?
> >
> > Do you have any suggestions regarding the user interface?
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/swapin_enabled
>
> looks good to me.  To be consistent with "enabled" in the same
> directory, and more importantly, to be extensible, I think that it's
> better to start with at least "always never".  I believe that we will
> add "auto" in the future to tune automatically.  Which can be used as
> default finally.

Sounds good to me. Thanks!

>
> --
> Best Regards,
> Huang, Ying

Barry

