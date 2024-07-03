Return-Path: <linux-kernel+bounces-239022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9319254FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42774284076
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFB139D0B;
	Wed,  3 Jul 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k30EFauw"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1B137C34
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993545; cv=none; b=BzvqLrReIhZ3+Q4nt65i0JmDvZ0U/K9LaIgMyJ/BdLDCYVI2v9lIKU3XEOpS+HeTLR73TZ9pOdXG5uQjUqsAxeohnQlTBNiKe9PjPqQ8fBBvseBoRifgTJGdqacwfIe/uO9oPBZIxNhCMqV1KrMU7EwvBUQ7Gb05jM8gq99b0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993545; c=relaxed/simple;
	bh=h7Yrb6B/9WCz9wGWvlJ65Yk1BK6g7vMoqfDKwnLoCxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icnnT6GOw59zdmEr8aq5jkV3G6zowQE9zOQtNnUA5MNs751cAegu2crQv7hCcYTxiORD8J6LemrKiOO9wQzNJED4Y+B/JSGjVQoC+sUY6RGgDj+ckencHEbzOcX+9zKBIZKmH18/x4g825yGjWcUYiChfW0DAdM6mU8e86nrna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k30EFauw; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48f4709e146so1905391137.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719993543; x=1720598343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oOEaDaVIDbOn6sqUGIDZZUmg9qCJEMQzuMTK1E7NRU=;
        b=k30EFauwH2SJ9QTVNwnwu0IDARw/RaTL0CM6MTBmFbD1Q+BoF3h3COcmzKbJCrfwNs
         YqkUZB3ifOkq1HABQcMu7Ecjv3FeUP/18gyyUKVk7JxLMmuzG3AGGjF2WgIwEO2ry1ut
         g2H2lsd1uayURfnRPztM3qkzSn8OpVl0e6dOOflJZIyk6iSKZ9bgatvABOPIRiUWiqmh
         V4efZFFl7YYXPoXqDj7+QOkxcjKLi6o5r9zwe5sen6Qu/4mEzO2aK8q9o9hsR1zyvOsr
         rftYsqPgEZt3HUKLgQU2J4MRNBWTTvTG7U2fa/MHKoh/t2QwG7MCS6QhigZH9ZoAf1nK
         rpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993543; x=1720598343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oOEaDaVIDbOn6sqUGIDZZUmg9qCJEMQzuMTK1E7NRU=;
        b=lQntHI5skxkQo98s7rCM4DsTzJ1FPgTXpsW0xm7d9zfVEbbNwEiBEwXGjfH8zccYFT
         O3/Z4PFnmDfWjWBSPQsyEYyW9HKsosU/K80TugR+TdvPASSCkynF5/gjvaklaJQT2Sgz
         lS6aUeW6euHsemBWZ9asuYG4mJsJJ2YKZZuobNlhOfoJcVhaPFL1paLEuI4r+QNZVaZE
         YVY/7rUelIxos3+14UfQtcNMTOo06vxRFsw2QVoHEL/jmt5lm/Poe4YAhSUOxsDe7ajL
         RiJLB68FyEkvgMXygYNaoajG39GnkCZBrE7G4Hdvw/qPsGkk1blC5C5K4ERe9cf3AUTq
         BVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvMdFHiNsQlAbmXRZYbe8Q0Wghs/wtRLBIGznq+EKQnfwMaNRJrCnyEoga+WN/5n16ultMFn1HUZ2+6vIlwiJTQRrRfWbNCmJ+D8u4
X-Gm-Message-State: AOJu0YzxgyEupk/kQSiCXGdah1n1y4XPFILZBnk+xAZH5uyAddvx343+
	pbMZpAR8IzfVfVn/18VZT4H0PHt35qGCRBT/Xhri5bcVnIqa6evfxVTD2z3TtTttFRUa0dO0GC8
	Iil62anvmfWRRdSdjR/CVNnDw0n8=
X-Google-Smtp-Source: AGHT+IFXK/irsf1uyNZnKDY/lrCaJrz0BT6iTgx6f00MO63ps1kd7o0Ttcd9faPqG3PichjEok0Gg9NILYA+BGinlJc=
X-Received: by 2002:a67:f486:0:b0:48f:4778:929d with SMTP id
 ada2fe7eead31-48faf140af3mr12914156137.27.1719993542664; Wed, 03 Jul 2024
 00:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629111010.230484-1-21cnbao@gmail.com> <87ikxnj8az.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ikxnj8az.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Jul 2024 19:58:51 +1200
Message-ID: <CAGsJ_4y7=b9gzKynXnT7rKd4nJ+m+POhMhmGMPKz37o_knpu6g@mail.gmail.com>
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

On Wed, Jul 3, 2024 at 6:33=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>

Ying, thanks!

> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > In an embedded system like Android, more than half of anonymous memory =
is
> > actually stored in swap devices such as zRAM. For instance, when an app
> > is switched to the background, most of its memory might be swapped out.
> >
> > Currently, we have mTHP features, but unfortunately, without support
> > for large folio swap-ins, once those large folios are swapped out,
> > we lose them immediately because mTHP is a one-way ticket.
>
> No exactly one-way ticket, we have (or will have) khugepaged.  But I
> admit that it may be not good enough for you.

That's right. From what I understand, khugepaged currently only supports PM=
D THP
till now?
Moreover, I have concerns that khugepaged might not be suitable for
all mTHPs for
the following reasons:

1. The lifecycle of mTHP might not be that long. We paid the cost for
the collapse,
but it could swap-out just after that. We expect THP to be durable and
not become
obsolete quickly, given the significant amount of money we spent on it.

2. mTHP's size might not be substantial enough for a collapse. For
example, if we can
find an effective method, such as Yu's TAO or others, we can achieve a
high success
rate in mTHP allocations at a minimal cost rather than depending on
compaction/collapse.

3. It could be a significant challenge to manage the collapse - unmap,
and map processes
in relation to the power consumption of phones considering the number
of mTHP could
be much larger than PMD-mapped THP. This behavior could be quite often.

>
> > This is unacceptable and reduces mTHP to merely a toy on systems
> > with significant swap utilization.
>
> May be true in your systems.  May be not in some other systems.

I agree that this isn't a concern for systems without significant
swapout and swapin activity.
However, on Android, where we frequently switch between applications
like YouTube,
Chrome, Zoom, WeChat, Alipay, TikTok, and others, swapping could occur
throughout the
day :-)

>
> > This patch introduces mTHP swap-in support. For now, we limit mTHP
> > swap-ins to contiguous swaps that were likely swapped out from mTHP as
> > a whole.
> >
> > Additionally, the current implementation only covers the SWAP_SYNCHRONO=
US
> > case. This is the simplest and most common use case, benefiting million=
s
>
> I admit that Android is an important target platform of Linux kernel.
> But I will not advocate that it's MOST common ...

Okay, I understand that there are still many embedded systems similar
to Android, even if
they are not Android :-)

>
> > of Android phones and similar devices with minimal implementation
> > cost. In this straightforward scenario, large folios are always exclusi=
ve,
> > eliminating the need to handle complex rmap and swapcache issues.
> >
> > It offers several benefits:
> > 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP afte=
r
> >    swap-out and swap-in.
> > 2. Eliminates fragmentation in swap slots and supports successful THP_S=
WPOUT
> >    without fragmentation. Based on the observed data [1] on Chris's and=
 Ryan's
> >    THP swap allocation optimization, aligned swap-in plays a crucial ro=
le
> >    in the success of THP_SWPOUT.
> > 3. Enables zRAM/zsmalloc to compress and decompress mTHP, reducing CPU =
usage
> >    and enhancing compression ratios significantly. We have another patc=
hset
> >    to enable mTHP compression and decompression in zsmalloc/zRAM[2].
> >
> > Using the readahead mechanism to decide whether to swap in mTHP doesn't=
 seem
> > to be an optimal approach. There's a critical distinction between pagec=
ache
> > and anonymous pages: pagecache can be evicted and later retrieved from =
disk,
> > potentially becoming a mTHP upon retrieval, whereas anonymous pages mus=
t
> > always reside in memory or swapfile. If we swap in small folios and ide=
ntify
> > adjacent memory suitable for swapping in as mTHP, those pages that have=
 been
> > converted to small folios may never transition to mTHP. The process of
> > converting mTHP into small folios remains irreversible. This introduces
> > the risk of losing all mTHP through several swap-out and swap-in cycles=
,
> > let alone losing the benefits of defragmentation, improved compression
> > ratios, and reduced CPU usage based on mTHP compression/decompression.
>
> I understand that the most optimal policy in your use cases may be
> always swapping-in mTHP in highest order.  But, it may be not in some
> other use cases.  For example, relative slow swap devices, non-fault
> sub-pages swapped out again before usage, etc.
>
> So, IMO, the default policy should be the one that can adapt to the
> requirements automatically.  For example, if most non-fault sub-pages
> will be read/written before being swapped out again, we should swap-in
> in larger order, otherwise in smaller order.  Swap readahead is one
> possible way to do that.  But, I admit that this may not work perfectly
> in your use cases.
>
> Previously I hope that we can start with this automatic policy that
> helps everyone, then check whether it can satisfy your requirements
> before implementing the optimal policy for you.  But it appears that you
> don't agree with this.
>
> Based on the above, IMO, we should not use your policy as default at
> least for now.  A user space interface can be implemented to select
> different swap-in order policy similar as that of mTHP allocation order
> policy.  We need a different policy because the performance characters
> of the memory allocation is quite different from that of swap-in.  For
> example, the SSD reading could be much slower than the memory
> allocation.  With the policy selection, I think that we can implement
> mTHP swap-in for non-SWAP_SYNCHRONOUS too.  Users need to know what they
> are doing.

Agreed. Ryan also suggested something similar before.
Could we add this user policy by:

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/swapin_enabled
which could be 0 or 1, I assume we don't need so many "always inherit
madvise never"?

Do you have any suggestions regarding the user interface?

>
> > Conversely, in deploying mTHP on millions of real-world products with t=
his
> > feature in OPPO's out-of-tree code[3], we haven't observed any signific=
ant
> > increase in memory footprint for 64KiB mTHP based on CONT-PTE on ARM64.
> >
> > [1] https://lore.kernel.org/linux-mm/20240622071231.576056-1-21cnbao@gm=
ail.com/
> > [2] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gma=
il.com/
> > [3] OnePlusOSS / android_kernel_oneplus_sm8550
> > https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplu=
s/sm8550_u_14.0.0_oneplus11
> >
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

