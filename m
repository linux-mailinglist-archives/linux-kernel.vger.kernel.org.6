Return-Path: <linux-kernel+bounces-567327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF16A6849A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C6C3B892F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF524EF71;
	Wed, 19 Mar 2025 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S3dk0SM4"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C224E4B0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742362156; cv=none; b=KPH/eioiYEGtMZCPSG3+9fftYoVgpwis/XQQg9kQ0W+OionMrDlpWijxd6wpKkVx9fGuG9HWHB9P92b2+6IhjqyncWfS2RjmuDpui0+xQc6TgJcWicMRoBjOIxsc8gs5qRYmr9p+oeoLHLKNjq7pUI8uxsnjN3LXQzjsPI5VCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742362156; c=relaxed/simple;
	bh=2mC956Xf/BeEHFJUJQsGBra6Ec+itrvXRvBY7wdhfek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYcZG/X3AUwmqvsMfB4aU6V+8gmPQSUcrtp5iOkjb0RntUyTAV8j+9vr4XV0lKjloE0CMbgVW7ps5DZnWa03otMiCCTVoMlpe4rrGmy/eJ2hoMmZdepcs+DVPLmRVtnrre5iRsWDaZJKeh/K0rQ5Y+sjaQ2UohzFgQs7v4/6c7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S3dk0SM4; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 05:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742362143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1qHZ/pFekDYRn8NY2h+S9aQP+6EvUKpO/TvC9MJrtQ=;
	b=S3dk0SM4hE5QEyo9hXVWbX5LiZYaMRWOwTLOXq35pZSeKz5bD0sA/5appBmCPNcgzFcvos
	8gs3MGXREiygjxGO0ZxzxCRH/vNkRVSyA9gQ3sHL8enwfrsSr9P4BC8MWOwxEIb5+FKW64
	BGe6o/EcqZA3HUfX9eLw8SgvpyVQHeY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yuzhao@google.com,
	mhocko@suse.com, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] mm: add swappiness=max arg to
 memory.reclaim for only anon reclaim
Message-ID: <Z9pWFBSdfg4lGg85@google.com>
References: <20250318135330.3358345-1-hezhongkun.hzk@bytedance.com>
 <Z9l-x-b9W32vE8Qn@google.com>
 <CACSyD1PZVVep7Do6WWOMTFr_qhzskxZtXEaqpCtk9JcR3X1L-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1PZVVep7Do6WWOMTFr_qhzskxZtXEaqpCtk9JcR3X1L-A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 10:34:54AM +0800, Zhongkun He wrote:
> On Tue, Mar 18, 2025 at 10:10 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Tue, Mar 18, 2025 at 09:53:30PM +0800, Zhongkun He wrote:
> > > With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> > > memory.reclaim")', we can submit an additional swappiness=<val> argument
> > > to memory.reclaim. It is very useful because we can dynamically adjust
> > > the reclamation ratio based on the anonymous folios and file folios of
> > > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > > from file folios.
> > >
> > > However,we have also encountered a new issue: when swappiness is set to
> > > the MAX_SWAPPINESS, it may still only reclaim file folios.
> > >
> > > So, we hope to add a new arg 'swappiness=max' in memory.reclaim where
> > > proactive memory reclaim only reclaims from anonymous folios when
> > > swappiness is set to max. The swappiness semantics from a user
> > > perspective remain unchanged.
> > >
> > > For example, something like this:
> > >
> > > echo "2M swappiness=max" > /sys/fs/cgroup/memory.reclaim
> > >
> > > will perform reclaim on the rootcg with a swappiness setting of 'max' (a
> > > new mode) regardless of the file folios. Users have a more comprehensive
> > > view of the application's memory distribution because there are many
> > > metrics available. For example, if we find that a certain cgroup has a
> > > large number of inactive anon folios, we can reclaim only those and skip
> > > file folios, because with the zram/zswap, the IO tradeoff that
> > > cache_trim_mode or other file first logic is making doesn't hold -
> > > file refaults will cause IO, whereas anon decompression will not.
> > >
> > > With this patch, the swappiness argument of memory.reclaim has a new
> > > mode 'max', means reclaiming just from anonymous folios both in traditional
> > > LRU and MGLRU.
> >
> > Is MGLRU handled in this patch?
> 
> Yes, The value of ONLY_ANON_RECLAIM_MODE is 201, and the MGLRU select the
> evictable type like this:
> 
> #define evictable_min_seq(min_seq, swappiness)              \
>     min((min_seq)[!(swappiness)], (min_seq)[(swappiness) <= MAX_SWAPPINESS])
> 
> #define for_each_evictable_type(type, swappiness)           \
>     for ((type) = !(swappiness); (type) <= ((swappiness) <=
> MAX_SWAPPINESS); (type)++)
> 
> if the swappiness=0, the type is LRU_GEN_FILE(1);
> 
> if the swappiness=201 (>MAX_SWAPPINESS),
>   for ((type) = 0; (type) <= 0); (type)++)
> The type is always LRU_GEN_ANON(0).

Zhongkun, I see that you already sent a new version. Please wait until
discussions on a patch are resolved before sending out newer versions,
and allow more time for reviews in general.

I think this is too subtle, and it's easy to miss. Looking at the MGLRU
code it seems like there's a lot of swappiness <= MAX_SWAPPINESS checks,
and I am not sure why these already exist given that swappiness should
never exceed MAX_SWAPPINESS before this change.

Are there other parts of the MGLRU code that are already using
swappiness values > MAX_SWAPPINESS?

Yu, could you help us making things clearer here? I would like to avoid
relying on current implementation details that could easily be missed
when making changes. Ideally we'd explicitly check for
SWAPPINESS_ANON_ONLY.


