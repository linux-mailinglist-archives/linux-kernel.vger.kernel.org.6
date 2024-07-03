Return-Path: <linux-kernel+bounces-239049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590E92556F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C6D1C224DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9C139CE2;
	Wed,  3 Jul 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoyMDYLx"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520A2629C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995557; cv=none; b=m04H8t+g8MzWxn5dX5SzORruUjB01c4xBVF/u7wAsqGgzBizGeYfY8b5HT0g8r+YWldajecohrerd3tlzr+O1hbZ/F0vHQ7GOLLqhuQxVYEy7sJaVyrJwkhAPgIn1LvfT0bG0spZvICWdXGi7LCCjOor59lvfxCHNm7VU6dKy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995557; c=relaxed/simple;
	bh=DnsKd4dzyBqRxJS5T2h+RWR+4LFDDMzHPzYdtxUKgrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG6PYRC5GKN2z3HYHtOo14/cuBBVtTgLLzwZYwFjzyXlAOdbyFRyWGHG8/jfoGpnPMTKPuBa6ETQ5Tycizir+qJfjctnZG0CcXTLVD0cVm4Ug0Y/LGoHOmhK6P5TkWMygQGRA+goQMVy/7hIoDJ0ddST2UkpbEocvl4Z8ziH7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoyMDYLx; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c11e92afaso316254085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719995554; x=1720600354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWu/SK9JoXzB+1RcHOyOxt+ym2qzgvKKxy1/Ozs1OXw=;
        b=AoyMDYLxuJDLw+z835WPNd+ulNBCw2n1bVPztEwfB4aYMxO+P8J04htZzHAzDngV6e
         EsuDswvJWHXMbqcaCwbb9ndbCV2IiN4mADBv0+IUqnA+f5LfikIMN2SqB2Mzs/lQZHwO
         BmZI9xWKqbho97qtqRwDm+M0YiVDV38K0kz/NTa3w+9B0sBwPIJNF8986C6WXxeVN7iN
         RMb0mNCoMPNNpZYyIMFa4WFnMPzoTOZrl8cLFG1QEauYPo/larEwKA1+C4byBgVXQngB
         AjGkU5beItfudaXkJJa/X5c1Suac+mpzMGtGH3J8PYB4WhgY5OCsQXL6lZ870ILfHu++
         mRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995554; x=1720600354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWu/SK9JoXzB+1RcHOyOxt+ym2qzgvKKxy1/Ozs1OXw=;
        b=n5DhQRDcFzPkKNl17CKBkkZ4XUaTbZqo6bOEUj6XXk5LsPE4wDf7qNHCPX2NGd0pLj
         jEHt5uU6BpsWgVi9z+sI4jHm3HWBdo2t95NforYl5wZk1Bl+XbA0kaEfeg6ZEyXxX+Vn
         jd8N+jO2okkiIRT3lnGuqrLdD50NCUETaXFSm9tzgRHn7IytRy+gNvHIAx0/BbevO5Q2
         MoN7pB7r0UP0jkA/tdZ9Gye7hHmsxKHuqAt5G8UnNPXAqapPQoscXoPmO07rOxNvCx/H
         TXphzfyJBZqhWLBmmRHjHNMcOouTtT/auy5iEsb80iUq1jja5quwN2qB5umENO5AZ6IK
         SFSg==
X-Forwarded-Encrypted: i=1; AJvYcCVMN7UVB23Y7b01bVBta8eRDj1mdkzqR7ZZocwidJ9pnlNulzZTW64kelsR2x7jdhS5Z8T7wHr8YyY3UwZ1dMWgGNoEK9d9Ea1qvm7j
X-Gm-Message-State: AOJu0Yx1lkUFP7B++h0bVFq+5Oadbi0yUyUde/VsDHCVTTOf74/apw4W
	z2mjPMXSCRmLYyQ50O55SD06ehLrcBvfq7eYloY4uFH4eNH9+Qx3WnqaDeWEysXi8sGmELD+ugI
	r4gOEatOUnOcfLekX8gX90BcoNjQ=
X-Google-Smtp-Source: AGHT+IGIXWLCzI7WSxmjk9c6zYVW3azDa72EfznUmUoaUmmt9X6VDrd/w0KMDG2kOM7JiKY3YRy/m2nzdY7bdJjLIqQ=
X-Received: by 2002:a05:620a:191d:b0:79d:5990:df3f with SMTP id
 af79cd13be357-79d7ba60389mr1492129485a.37.1719995554469; Wed, 03 Jul 2024
 01:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629111010.230484-1-21cnbao@gmail.com> <87ikxnj8az.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4y7=b9gzKynXnT7rKd4nJ+m+POhMhmGMPKz37o_knpu6g@mail.gmail.com>
In-Reply-To: <CAGsJ_4y7=b9gzKynXnT7rKd4nJ+m+POhMhmGMPKz37o_knpu6g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Jul 2024 20:32:22 +1200
Message-ID: <CAGsJ_4wgEoU9V1AbVN0huXN9wyGGs88VfVJ0Z+j6H6KaDHQZMw@mail.gmail.com>
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

On Wed, Jul 3, 2024 at 7:58=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Jul 3, 2024 at 6:33=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
>
> Ying, thanks!
>
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > In an embedded system like Android, more than half of anonymous memor=
y is
> > > actually stored in swap devices such as zRAM. For instance, when an a=
pp
> > > is switched to the background, most of its memory might be swapped ou=
t.
> > >
> > > Currently, we have mTHP features, but unfortunately, without support
> > > for large folio swap-ins, once those large folios are swapped out,
> > > we lose them immediately because mTHP is a one-way ticket.
> >
> > No exactly one-way ticket, we have (or will have) khugepaged.  But I
> > admit that it may be not good enough for you.
>
> That's right. From what I understand, khugepaged currently only supports =
PMD THP
> till now?
> Moreover, I have concerns that khugepaged might not be suitable for
> all mTHPs for
> the following reasons:
>
> 1. The lifecycle of mTHP might not be that long. We paid the cost for
> the collapse,
> but it could swap-out just after that. We expect THP to be durable and
> not become
> obsolete quickly, given the significant amount of money we spent on it.
>
> 2. mTHP's size might not be substantial enough for a collapse. For
> example, if we can
> find an effective method, such as Yu's TAO or others, we can achieve a
> high success
> rate in mTHP allocations at a minimal cost rather than depending on
> compaction/collapse.
>
> 3. It could be a significant challenge to manage the collapse - unmap,
> and map processes
> in relation to the power consumption of phones considering the number
> of mTHP could
> be much larger than PMD-mapped THP. This behavior could be quite often.
>
> >
> > > This is unacceptable and reduces mTHP to merely a toy on systems
> > > with significant swap utilization.
> >
> > May be true in your systems.  May be not in some other systems.
>
> I agree that this isn't a concern for systems without significant
> swapout and swapin activity.
> However, on Android, where we frequently switch between applications
> like YouTube,
> Chrome, Zoom, WeChat, Alipay, TikTok, and others, swapping could occur
> throughout the
> day :-)
>
> >
> > > This patch introduces mTHP swap-in support. For now, we limit mTHP
> > > swap-ins to contiguous swaps that were likely swapped out from mTHP a=
s
> > > a whole.
> > >
> > > Additionally, the current implementation only covers the SWAP_SYNCHRO=
NOUS
> > > case. This is the simplest and most common use case, benefiting milli=
ons
> >
> > I admit that Android is an important target platform of Linux kernel.
> > But I will not advocate that it's MOST common ...
>
> Okay, I understand that there are still many embedded systems similar
> to Android, even if
> they are not Android :-)
>
> >
> > > of Android phones and similar devices with minimal implementation
> > > cost. In this straightforward scenario, large folios are always exclu=
sive,
> > > eliminating the need to handle complex rmap and swapcache issues.
> > >
> > > It offers several benefits:
> > > 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP af=
ter
> > >    swap-out and swap-in.
> > > 2. Eliminates fragmentation in swap slots and supports successful THP=
_SWPOUT
> > >    without fragmentation. Based on the observed data [1] on Chris's a=
nd Ryan's
> > >    THP swap allocation optimization, aligned swap-in plays a crucial =
role
> > >    in the success of THP_SWPOUT.
> > > 3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CP=
U usage
> > >    and enhancing compression ratios significantly. We have another pa=
tchset
> > >    to enable mTHP compression and decompression in zsmalloc/zRAM[2].
> > >
> > > Using the readahead mechanism to decide whether to swap in mTHP doesn=
't seem
> > > to be an optimal approach. There's a critical distinction between pag=
ecache
> > > and anonymous pages: pagecache can be evicted and later retrieved fro=
m disk,
> > > potentially becoming a mTHP upon retrieval, whereas anonymous pages m=
ust
> > > always reside in memory or swapfile. If we swap in small folios and i=
dentify
> > > adjacent memory suitable for swapping in as mTHP, those pages that ha=
ve been
> > > converted to small folios may never transition to mTHP. The process o=
f
> > > converting mTHP into small folios remains irreversible. This introduc=
es
> > > the risk of losing all mTHP through several swap-out and swap-in cycl=
es,
> > > let alone losing the benefits of defragmentation, improved compressio=
n
> > > ratios, and reduced CPU usage based on mTHP compression/decompression=
.
> >
> > I understand that the most optimal policy in your use cases may be
> > always swapping-in mTHP in highest order.  But, it may be not in some
> > other use cases.  For example, relative slow swap devices, non-fault
> > sub-pages swapped out again before usage, etc.
> >
> > So, IMO, the default policy should be the one that can adapt to the
> > requirements automatically.  For example, if most non-fault sub-pages
> > will be read/written before being swapped out again, we should swap-in
> > in larger order, otherwise in smaller order.  Swap readahead is one
> > possible way to do that.  But, I admit that this may not work perfectly
> > in your use cases.
> >
> > Previously I hope that we can start with this automatic policy that
> > helps everyone, then check whether it can satisfy your requirements
> > before implementing the optimal policy for you.  But it appears that yo=
u
> > don't agree with this.
> >
> > Based on the above, IMO, we should not use your policy as default at
> > least for now.  A user space interface can be implemented to select
> > different swap-in order policy similar as that of mTHP allocation order
> > policy.  We need a different policy because the performance characters
> > of the memory allocation is quite different from that of swap-in.  For
> > example, the SSD reading could be much slower than the memory
> > allocation.  With the policy selection, I think that we can implement
> > mTHP swap-in for non-SWAP_SYNCHRONOUS too.  Users need to know what the=
y
> > are doing.
>
> Agreed. Ryan also suggested something similar before.
> Could we add this user policy by:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/swapin_enabled
> which could be 0 or 1, I assume we don't need so many "always inherit
> madvise never"?

I actually meant:

Firstly, we respect the existing THP policy, and then we incorporate
swapin_enabled after checking both allowable and suitable, pseudo
code like this,

        orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
                        TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
        orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);

        orders =3D thp_swapin_allowable_order(orders);

>
> Do you have any suggestions regarding the user interface?
>
> >
> > > Conversely, in deploying mTHP on millions of real-world products with=
 this
> > > feature in OPPO's out-of-tree code[3], we haven't observed any signif=
icant
> > > increase in memory footprint for 64KiB mTHP based on CONT-PTE on ARM6=
4.
> > >
> > > [1] https://lore.kernel.org/linux-mm/20240622071231.576056-1-21cnbao@=
gmail.com/
> > > [2] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@g=
mail.com/
> > > [3] OnePlusOSS / android_kernel_oneplus_sm8550
> > > https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/onep=
lus/sm8550_u_14.0.0_oneplus11
> > >
> >
> > [snip]
> >
> > --
> > Best Regards,
> > Huang, Ying
>
> Thanks
> Barry

