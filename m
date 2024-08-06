Return-Path: <linux-kernel+bounces-276682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F99496FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0294D1F2312D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7156B81;
	Tue,  6 Aug 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="O/K44YT8"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAF50276
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965929; cv=none; b=caVWKZJiLDjekR4BZXepzDVVQMgzPdRqzJNLDhEpqx0MXS3s8HfuFIT77i0oLMeq60TNY5HcBYAlXJA0paAPfM1L/DspcdUhxjGipD14C1VcmLBmDLAEGjXCB0bD9y3sZjYDV12UEUCUroQr9dWL6fmHrengB0t583ScFPJMhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965929; c=relaxed/simple;
	bh=HCJfZbOCDoxIFvqfbrfEWDLMhrLpLf4QFAUipuXMkX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCE2jVkG0C2Zt3fgFEbgT4JKzkrnDBXhAABQnSU2uDH64APsrvssoqIsgVzcI0HBhznnRxnDruvV0e5/42lAgZWFRpy4ae8aXaSZLXsqZBHUlFl6FddpeQ+lbLnTwjnyvOgEzcC/zoSQA4RoEG4lf4iiEOk2ghMzR2vC6c8fNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=O/K44YT8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b795574f9dso5099546d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722965925; x=1723570725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DFT04eDqUDRuoXV+iFO/OFbUzVkAnj/MsXC8LjTJQCY=;
        b=O/K44YT8tvdtfR/kEBEafawHyBME8JyFrX0VSYFHtt62ZtGh8T+o8PSTKsvSsccktK
         uWhYcgR+1ma609UWeVFgAP2JrjdlEQLCQFwFHgyBvB51vdf9wRH0nmUIIoFHeCURiiVg
         DvTbd25iTuNOJFt9fT0hCf8oRnlJza0/gCuZ1RD9JqXW8jjW4IhR9g8LTIXtGbYyPrOs
         vHXZKPoMkMTESGqC+wWYQ6ivdK09RkIAn8k4zOl337TPFBLaRigE0gDZk8Fq12sLKQBG
         iO7X3p7KbOiFSiLlbNoGMl5/6eXhZwLUn1LgRQ265kaGAXZ3ux4oxNynKDxCR2V6UWSH
         MTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965925; x=1723570725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFT04eDqUDRuoXV+iFO/OFbUzVkAnj/MsXC8LjTJQCY=;
        b=k4fJRRi7YJEUAQumCUvxsrXsV1b5M9TJ8urflZsdCvAoPdN0GS2yZZpqth9z3N5Ces
         ljuBlFtO0RPxlwr5zzykAB9PR3Fq5iPBT9WqGQn0e4XUDQr7cYNa5kxzDW4PhwOgwBcT
         MlBPmXWxedI9iK5927Y0MZk9E1u92tdoFFsEy6Pd5C5gdhXxqEl70odcoiaqYHTCI03R
         c89PkZrnvQQ+dQ+2mGqYgpeEiWsB9/+SlIfJXK6r093p6fprEbvAsQ1NPpYvaREfAeMw
         K4nQ+/RnPmsFb549hRBu4x5SiZYLt70gDA/iff7V6Y4bc7mkrJfg8eQpJyT73XXGWxvp
         QLaA==
X-Forwarded-Encrypted: i=1; AJvYcCW2D0wpJlSuxfqlb93LFOIb/W2AvPjEAcgStCuhKbaItyQS+za9MhjsyT+YGj5/Z5H5fsjYxIlKZ/11ulGcG/YIjiABWrwDl5Yw5WKb
X-Gm-Message-State: AOJu0YxeWSLiKvsnopROsS8G4kCRczCqJNez9o8wrbqRNPfweg97pJK3
	YeQ3Hx158p/y53aTvLCBSjDUDBWqutieH4Gy6mus9HhbHL2vZZlxvVtXroA3ZpQ=
X-Google-Smtp-Source: AGHT+IFfst/Qde1Lynn7BrIeWKbz/l71KGJXRt749ul6SogcxbbFqrdsTQFw10Bolr+DHEqWpnV/5g==
X-Received: by 2002:a05:6214:5886:b0:6b7:9a5c:c9ce with SMTP id 6a1803df08f44-6bb9842d7e6mr163767056d6.53.1722965925578;
        Tue, 06 Aug 2024 10:38:45 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c866ccfsm48229976d6.107.2024.08.06.10.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:38:45 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:38:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, riel@surriel.com, shakeel.butt@linux.dev,
	roman.gushchin@linux.dev, david@redhat.com, baohua@kernel.org,
	ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
	cerasuolodomenico@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
Message-ID: <20240806173840.GE322282@cmpxchg.org>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>

On Thu, Aug 01, 2024 at 12:09:16AM -0600, Yu Zhao wrote:
> On Tue, Jul 30, 2024 at 6:54 AM Usama Arif <usamaarif642@gmail.com> wrote:
> >
> > The current upstream default policy for THP is always. However, Meta
> > uses madvise in production as the current THP=always policy vastly
> > overprovisions THPs in sparsely accessed memory areas, resulting in
> > excessive memory pressure and premature OOM killing.
> > Using madvise + relying on khugepaged has certain drawbacks over
> > THP=always. Using madvise hints mean THPs aren't "transparent" and
> > require userspace changes. Waiting for khugepaged to scan memory and
> > collapse pages into THP can be slow and unpredictable in terms of performance
> > (i.e. you dont know when the collapse will happen), while production
> > environments require predictable performance. If there is enough memory
> > available, its better for both performance and predictability to have
> > a THP from fault time, i.e. THP=always rather than wait for khugepaged
> > to collapse it, and deal with sparsely populated THPs when the system is
> > running out of memory.
> >
> > This patch-series is an attempt to mitigate the issue of running out of
> > memory when THP is always enabled. During runtime whenever a THP is being
> > faulted in or collapsed by khugepaged, the THP is added to a list.
> > Whenever memory reclaim happens, the kernel runs the deferred_split
> > shrinker which goes through the list and checks if the THP was underutilized,
> > i.e. how many of the base 4K pages of the entire THP were zero-filled.
> > If this number goes above a certain threshold, the shrinker will attempt
> > to split that THP. Then at remap time, the pages that were zero-filled are
> > not remapped, hence saving memory. This method avoids the downside of
> > wasting memory in areas where THP is sparsely filled when THP is always
> > enabled, while still providing the upside THPs like reduced TLB misses without
> > having to use madvise.
> >
> > Meta production workloads that were CPU bound (>99% CPU utilzation) were
> > tested with THP shrinker. The results after 2 hours are as follows:
> >
> >                             | THP=madvise |  THP=always   | THP=always
> >                             |             |               | + shrinker series
> >                             |             |               | + max_ptes_none=409
> > -----------------------------------------------------------------------------
> > Performance improvement     |      -      |    +1.8%      |     +1.7%
> > (over THP=madvise)          |             |               |
> > -----------------------------------------------------------------------------
> > Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
> > -----------------------------------------------------------------------------
> > max_ptes_none=409 means that any THP that has more than 409 out of 512
> > (80%) zero filled filled pages will be split.
> >
> > To test out the patches, the below commands without the shrinker will
> > invoke OOM killer immediately and kill stress, but will not fail with
> > the shrinker:
> >
> > echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
> > mkdir /sys/fs/cgroup/test
> > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > echo 20M > /sys/fs/cgroup/test/memory.max
> > echo 0 > /sys/fs/cgroup/test/memory.swap.max
> > # allocate twice memory.max for each stress worker and touch 40/512 of
> > # each THP, i.e. vm-stride 50K.
> > # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> > # killer.
> > # Without the shrinker, OOM killer is invoked immediately irrespective
> > # of max_ptes_none value and kill stress.
> > stress --vm 1 --vm-bytes 40M --vm-stride 50K
> >
> > Patches 1-2 add back helper functions that were previously removed
> > to operate on page lists (needed by patch 3).
> > Patch 3 is an optimization to free zapped tail pages rather than
> > waiting for page reclaim or migration.
> > Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
> > subpages when splitting THP.
> > Patches 6 adds support for THP shrinker.
> >
> > (This patch-series restarts the work on having a THP shrinker in kernel
> > originally done in
> > https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
> > The THP shrinker in this series is significantly different than the
> > original one, hence its labelled v1 (although the prerequisite to not
> > remap clean subpages is the same).)
> >
> > Alexander Zhu (1):
> >   mm: add selftests to split_huge_page() to verify unmap/zap of zero
> >     pages
> >
> > Usama Arif (3):
> >   Revert "memcg: remove mem_cgroup_uncharge_list()"
> >   Revert "mm: remove free_unref_page_list()"
> >   mm: split underutilized THPs
> >
> > Yu Zhao (2):
> >   mm: free zapped tail pages when splitting isolated thp
> >   mm: don't remap unused subpages when splitting isolated thp
> 
>  I would recommend shatter [1] instead of splitting so that

I agree with Rik, this seems like a possible optimization, not a
pre-requisite.

> 1) whoever underutilized their THPs get punished for the overhead;

Is that true? The downgrade is done in a shrinker. With or without
shattering, the compaction effort will be on the allocation side.

> 2) underutilized THPs are kept intact and can be reused by others.

If migration of the subpages is possible, then compaction can clear
the block as quickly as shattering can. The only difference is that
compaction would do the work on-demand, whereas shattering would do it
unconditionally, whether a THP has been requested or not...

Anyway, I think it'd be better to keep those discussions separate.

