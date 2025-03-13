Return-Path: <linux-kernel+bounces-559129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1BA5EFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322DC3AF680
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863C261398;
	Thu, 13 Mar 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XhBH2270"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FB1F9A86
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858946; cv=none; b=gJ1IVTbJk1zc1ky6pg0pE2rOijeZRVP46nhGCZZ6B1Fa/1/GYlIJlpuL4gctFXSnlXcZxTGV9nlEdL2hlN9eA+cimirYbrQRzVmGULNW8TxzqsYKVjcM/c9KNqTJmwJMM7sSRGK7OzhnUj5Zo+UD2msXVjgbRcUEMF7ijqYRnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858946; c=relaxed/simple;
	bh=OJfjvQ/N7ETSNrcJr5xxyNrxw9Sj9L8LVm1RwWTLxRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0TR0QyF8k+OHacQSU6oYX/6PGbw5NGpij1s+xFjTQsT+1iSD9HApyoTKWM/7X3LbmjG2wH3/TfqPWf51lNliQyVFh65iuz4vU8IM63KK85bF1Fcwp4+LWYDCJql2Mq/YV5wMhgcFwOeTrz1RRiKdMHvYqPUjQ53ZxgpdoSXbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XhBH2270; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914a5def6bso361834f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741858943; x=1742463743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=20DBW7AehNpQ2Om/8eHwOLATn1HbHZB6DDKZV2Anxq4=;
        b=XhBH2270oibeg7eqp2v3lAH4ncwVA9acydg8CfC3AqZMENfCBHeeo/Zr4oExHFfTof
         3yLidgb2nP/jd9CcF2qKZPNwpXKtYcIxdKO2ot9bZk0uNV5R/oksFhb273AFcREZFTnr
         JZb0pj38O7tnuwVeJxnQ599lzK+2WSoj7QnvzslNBhOKOk8Yd/3m1/6qj0z8YZn8Z48O
         a7BS4YF01G7aCSiC6JYecdYvcjLqeN5z6bAl1k2VJXQgjW7N12GnNkFR4t1G9CqvNLTL
         tUIXPfZEjyNeVj34tgfzC9RawPr8JpSfM9q/GQmUMhMaq114WY7IvX9jIOEqt51qYIYV
         BH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858943; x=1742463743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20DBW7AehNpQ2Om/8eHwOLATn1HbHZB6DDKZV2Anxq4=;
        b=VgZbaTdXeAhonQuvweIi9JjwbyX3mJAyhJTgKTXfRjuAxiMQ+7nTMhbw/9V7lZwEAu
         LRCCVjSbLt9PmLRW/FVbsJRf8CPfvIklDBpOXqA1x49XHGj8FX1r4r2YRJMUIJ9WkyRu
         82ux+ZjX+fRtsYC6ER0jhJJxY46hq5eGSRuqP3oCF1ZgwYW460fTIHoWHbBJWMJJN5uV
         M/JCCps6kxg/LcWjvqIYOz2dm/7BclCCezhRoDH6hlgtGVuD2pDiezpSwluPjgdYcUgu
         uCMYgD6v+pdqUJShs5cIqQ/4XFMZsSGXNmgT00VXROpvBnFYJZB3LYSeJBSnejCmnnhL
         1A8w==
X-Forwarded-Encrypted: i=1; AJvYcCUwirZSWqVakSCqycovDjDTjjzruqGyAX3b5OgQLwEN8qxTlQKyVtu0mHgsD6zooT4HKwL+RIRMdSnD57U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Quoom7Ef6x3u62M0BiIP9wn1UXVFya4v6kCzUVHZEI6YAzsO
	goXm+iHfmAInNFW0xZ3yEqEq27lNNmtl7saipGu0VO7CUntiUPn6Ahqq7vKYB5CzXw7oD1nSRlK
	D
X-Gm-Gg: ASbGncsrF52xR4yUUJHpwAL2tHpmT0HUEGeuTspPKuJeG5NdqJK1alqr0gkquB3qBzi
	vwCHrRb7KXNLn7nA0omrOW14o+jC04KaWMTeMaSOMBybntAqn66L3P8VuaeZ7YeNojyDEgKQWZ8
	F09iJXgG2eL6X4Vzlkl/r6l/SCyr6GdsrLmEimnzgKDTeEmsAH5Sx03TPd+NMMHUPRSMHpNZl2r
	6xWMKnaYggJiEp4CKHuLTDpLfk0ATGyT9RwTLrJiBAPvUHMe/3V9L8sPTxezSxzx1gmo6G6+FZK
	5QfYGIDm76tJWxyh9t8745HqrkEOTU32/2qLc2cpjrnX1Q6RiqZECMYFqQ==
X-Google-Smtp-Source: AGHT+IGxRh3flJu8cpJEo76OI5sO+1IMQEI9ARpuF8szI75gmS7y4b4K75SiX5C7SWGF6Co22nhSyA==
X-Received: by 2002:a5d:64c3:0:b0:391:31c8:ba58 with SMTP id ffacd0b85a97d-39132d16dd6mr21732061f8f.10.1741858942811;
        Thu, 13 Mar 2025 02:42:22 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb7eb8c2sm1466935f8f.85.2025.03.13.02.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:42:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:42:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, muchun.song@linux.dev,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH V1] mm: vmscan: skip the file folios in proactive
 reclaim if swappiness is MAX
Message-ID: <Z9KofXR3KOIBXb1A@tiehlicka>
References: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com>
 <Z9KPzQNctY_ALL0D@tiehlicka>
 <CACSyD1PU59py6rjiZ5snvRL449OmuH9W+RMbNpmOfhO80XuW5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1PU59py6rjiZ5snvRL449OmuH9W+RMbNpmOfhO80XuW5Q@mail.gmail.com>

On Thu 13-03-25 16:57:34, Zhongkun He wrote:
> On Thu, Mar 13, 2025 at 3:57 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 13-03-25 11:48:12, Zhongkun He wrote:
> > > With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> > > memory.reclaim")', we can submit an additional swappiness=<val> argument
> > > to memory.reclaim. It is very useful because we can dynamically adjust
> > > the reclamation ratio based on the anonymous folios and file folios of
> > > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > > from file folios.
> > >
> > > However,we have also encountered a new issue: when swappiness is set to
> > > the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> > > to the knob of cache_trim_mode, which depends solely on the ratio of
> > > inactive folios, regardless of whether there are a large number of cold
> > > folios in anonymous folio list.
> > >
> > > So, we hope to add a new control logic where proactive memory reclaim only
> > > reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> > > For example, something like this:
> > >
> > > echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> > >
> > > will perform reclaim on the rootcg with a swappiness setting of 200 (max
> > > swappiness) regardless of the file folios. Users have a more comprehensive
> > > view of the application's memory distribution because there are many
> > > metrics available. For example, if we find that a certain cgroup has a
> > > large number of inactive anon folios, we can reclaim only those and skip
> > > file folios, because with the zram/zswap, the IO tradeoff that
> > > cache_trim_mode is making doesn't hold - file refaults will cause IO,
> > > whereas anon decompression will not.
> > >
> > > With this patch, the swappiness argument of memory.reclaim has a more
> > > precise semantics: 0 means reclaiming only from file pages, while 200
> > > means reclaiming just from anonymous pages.
> >
> > Well, with this patch we have 0 - always swap, 200 - never swap and
> > anything inbetween behaves more or less arbitrary, right? Not a new
> > problem with swappiness but would it make more sense to drop all the
> > heuristics for scanning LRUs and simply use the given swappiness when
> > doing the pro active reclaim?
> 
> Thanks for your suggestion! I totally agree with you. I'm preparing to send
> another patch to do this and a new thread to discuss, because I think the
> implementation doesn't conflict with this one. Do you think so ?

If the change will enforce SCAN_FRACT for proactive reclaim with
swappiness given then it will make the balancing much smoother but I do
not think the behavior at both ends of the scale would imply only single
LRU scanning mode.
-- 
Michal Hocko
SUSE Labs

