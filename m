Return-Path: <linux-kernel+bounces-389438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6379B6D21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7435C1F229A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CF1D07A2;
	Wed, 30 Oct 2024 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoqkdDy9"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40371C3F01
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317958; cv=none; b=h2m+Qejx+Z7HFt+in/5FK3jDDBca4eWNMcd4h/JQ9LwD0fbeu9zsB/TXU37PUBmS7uSgZQjhA+P4PK+wqjYRft4Ap8Jvdl9GSle8QpQjVFJyf+semz9+7Are1VOP/CmjMXE93oDzcYJZ7eng6KQBEf9RIFn69Fp0JYcDW7/srtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317958; c=relaxed/simple;
	bh=+/o+6f340yStUOUUizhAe4dchrInAWR4WctMvK2Qybg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfyFEjIucWdK0xUYyLDS4lChBvGthT5A6DnqbpDsQ79TuOJHVWWc0emM2L5hQylVg26M1Mnk2G958OQk7urcYPoGq/DcavV5BvJuSCWouG0PVugmPmNgb40M62jszuVfSf47XrQqdnDdPhoWk/06xTEtaMKNux0BdFFEocjn4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoqkdDy9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso1455696d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730317955; x=1730922755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/o+6f340yStUOUUizhAe4dchrInAWR4WctMvK2Qybg=;
        b=OoqkdDy9iEjXBS+naulvS62NwCsapoy6VcMeqc3QRrQ1ZOcH6A6plCM1QZ6ImF5prn
         klyHTTrXPgfuol+8lMjo4oytJrvwj4zNIF8DOo4PBt1l6GwumnNSvCIIx1H/Qxl+Oi1A
         yM3X1M/gBYGKcYVNi6A+PvCGdFi64ibltC7qYxXjIT4aghdjMuP7HW+40Go7u5jpMNMt
         yjWFruqbUzlswuf9CfPCUbvt5IBc2xNRw4lA4eVFLU5BLSprNtwpuB7WdOXYmXa+dY+T
         xT4OrsIjY4U4iAPqN/3G8Q1SSVpjOJVlKsIaD+LbfsI8AOprYmEH7p257JNK1rq4cbxS
         rPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730317955; x=1730922755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/o+6f340yStUOUUizhAe4dchrInAWR4WctMvK2Qybg=;
        b=ssf5l7UiEP2Nb36K2EqsnHbzagIVc8W67UByME6f9fiusspiOPK13sc+L97fK391QI
         c/g6XKHBJGO0gWeSPxaQI22G0Qa9qTdrKK+a2jYdmRZYFeuddZ1QOxYLctq+R6Fmu6jH
         k77Wzy7i0qa2ulIjTmvwz3WCbOGfyNEBAmwrEyzOhRkaKevkqaRAgTRSZsgISxJZGWS3
         L+dB04RO9TCT7o//0XXcnwTUffhgByFkQ3yXlzIY/aGI597cHkX+06139WB1rxtSZFLu
         g6J8FKccAYUOhbmUa8gnCH1kiD4GeIWpNkF0jfc1CSvmD8VMY4ivxgwzMzpQdX+jWMOg
         ZMcA==
X-Forwarded-Encrypted: i=1; AJvYcCXR0lASxLjPe+3wS/c/QMXmDIdfLnj+y/jzSIVltbfeZ9d3LuG4OEn+STb5G0DUCQgpU4OQFmAlzZ7o2EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfU7f1208aVpSvpRxGw0zjzJtWRAi736xEh78b5x8m3l1HJ/rL
	xmhYChkAbOjzF5Jk9jtAKNIIlLZiAkhVuUw2L+Gr3lahCNn7rwl0GIEyZ7GfphzQBP6aL/rkBIm
	5Wac5blS7s6PT4bDpSkMTG3iQlXOjOxcj+ibU
X-Google-Smtp-Source: AGHT+IGRLo1FAaraQ2RBzX9kuBOQfVcUrcJ9p+UHHehrTc7kScapNfxQYzuEyupDQ73cuNZT2pAWcXQYgZhtt1hgNXw=
X-Received: by 2002:a05:6214:5bc4:b0:6cb:600f:568b with SMTP id
 6a1803df08f44-6d18568374dmr219394266d6.8.1730317955230; Wed, 30 Oct 2024
 12:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com> <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
In-Reply-To: <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 30 Oct 2024 12:51:58 -0700
Message-ID: <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

[..]
> > My second point about the mitigation is as follows: For a system (or
> > memcg) under severe memory pressure, especially one without hardware TLB
> > optimization, is enabling mTHP always the right choice? Since mTHP operates at
> > a larger granularity, some internal fragmentation is unavoidable, regardless
> > of optimization. Could the mitigation code help in automatically tuning
> > this fragmentation?
> >
>
> I agree with the point that enabling mTHP always is not the right thing to do
> on all platforms. I also think it might be the case that enabling mTHP
> might be a good thing for some workloads, but enabling mTHP swapin along with
> it might not.
>
> As you said when you have apps switching between foreground and background
> in android, it probably makes sense to have large folio swapping, as you
> want to bringin all the pages from background app as quickly as possible.
> And also all the TLB optimizations and smaller lru overhead you get after
> you have brought in all the pages.
> Linux kernel build test doesnt really get to benefit from the TLB optimization
> and smaller lru overhead, as probably the pages are very short lived. So I
> think it doesnt show the benefit of large folio swapin properly and
> large folio swapin should probably be disabled for this kind of workload,
> eventhough mTHP should be enabled.
>
> I am not sure that the approach we are trying in this patch is the right way:
> - This patch makes it a memcg issue, but you could have memcg disabled and
> then the mitigation being tried here wont apply.

Is the problem reproducible without memcg? I imagine only if the
entire system is under memory pressure. I guess we would want the same
"mitigation" either way.

> - Instead of this being a large folio swapin issue, is it more of a readahead
> issue? If we zswap (without the large folio swapin series) and change the window
> to 1 in swap_vma_readahead, we might see an improvement in linux kernel build time
> when cgroup memory is limited as readahead would probably cause swap thrashing as
> well.

I think large folio swapin would make the problem worse anyway. I am
also not sure if the readahead window adjusts on memory pressure or
not.

> - Instead of looking at cgroup margin, maybe we should try and look at
> the rate of change of workingset_restore_anon? This might be a lot more complicated
> to do, but probably is the right metric to determine swap thrashing. It also means
> that this could be used in both the synchronous swapcache skipping path and
> swapin_readahead path.
> (Thanks Johannes for suggesting this)
>
> With the large folio swapin, I do see the large improvement when considering only
> swapin performance and latency in the same way as you saw in zram.
> Maybe the right short term approach is to have
> /sys/kernel/mm/transparent_hugepage/swapin
> and have that disabled by default to avoid regression.
> If the workload owner sees a benefit, they can enable it.
> I can add this when sending the next version of large folio zswapin if that makes
> sense?

I would honestly prefer we avoid this if possible. It's always easy to
just put features behind knobs, and then users have the toil of
figuring out if/when they can use it, or just give up. We should find
a way to avoid the thrashing due to hitting the memcg limit (or being
under global memory pressure), it seems like something the kernel
should be able to do on its own.

> Longer term I can try and have a look at if we can do something with
> workingset_restore_anon to improve things.

I am not a big fan of this, mainly because reading a stat from the
kernel puts us in a situation where we have to choose between:
- Doing a memcg stats flush in the kernel, which is something we are
trying to move away from due to various problems we have been running
into.
- Using potentially stale stats (up to 2s), which may be fine but is
suboptimal at best. We may have blips of thrashing due to stale stats
not showing the refaults.

