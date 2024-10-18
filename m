Return-Path: <linux-kernel+bounces-371784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C29A4045
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD6CB2259D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2C17C9E9;
	Fri, 18 Oct 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fjvuVCet"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E750134AC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258939; cv=none; b=gKoMCjJpUpTQHhqld12R0AFmQjWKSB6HbwzO/JEqzJ/AYgz2X6JnMaR/qBJZcqLykmxRTWlPiGjtXlN0Ofj7ZTr2zjjXtGFNGUtnvt+S2lDYHJa9/lQEdCML+rwrvUtqyUM3geKP4Y/U96kwM6VSC1Vmoq1h9pqk1yXSpzUiqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258939; c=relaxed/simple;
	bh=xBePZnsK3Nudyza72rvI8w1t5GSr3TU0LqaYiARoEDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maMUdVU2nGlaT+uQbtyEjo0rTLCqTIf4/6sy4RKjnE+UR7ipOSInAYeCUmT6zgABfX2e1eXl7xpm1IYNj4D3C+XxTRyqUDzUHJUSK428ye8lkQKger2vwv3LH6b2GwCJud5BtQx53/GneMqEoX6gdelje6x+nHlmOAN1xqmnb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fjvuVCet; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so1115762a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729258935; x=1729863735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZa7Ue1oIcLGAigjL4zuYAAZ2xEAi56JLa+QFpctN6s=;
        b=fjvuVCettQKqxe9GMf0pUA6JCkFbEiOELajjTNBCmfQn39l7s7uB4tCrKYVLnEHH/m
         JwIFA8dpeJ/bYVR1YUUJpceVNyC6+Qtj091mAG4ehgxf6jJ11J50N/+WvMdLh8aBqZ75
         3BDC+zOWlSKPTDm52pvxKs5006kI2Z9YWcaUTH9uwAle20qw2um5fM5gFCtSUNqQtWzX
         t7FsfVBjaKtqSft6nnI1Odv/5s/iUCPh+3Zon98Owr5ZVGMfqH+PQlWMyYYSzS4wqQWk
         CrF8GVsXC9amz6nsXuUCaRn/9jpES60b0BORtzBc6M4q4xhAXo0b4L71oUZwK/Wh9P/i
         LTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258935; x=1729863735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZa7Ue1oIcLGAigjL4zuYAAZ2xEAi56JLa+QFpctN6s=;
        b=Tw1wY/ovMZAyRYP3vnjvtYWgr8kHG5LP2R+S1ikIMXD0a7gLQUkZUG3gf+njS9VcNr
         vVVH4yTXJG9pDqj0TqyeS6cmkU/hmfS/R6VM23MhWvzJYty5DQ+POHalD7VKoESmC4ml
         hKGekReks+dk7mqbQRdKgDcwrioCRvafx9lYTWDCwJ2dR+RSA1bgdZ3HFQrv864H46/7
         4rMqj7KqFvmE2aVq9iIrzAr2A1oBg+p+1GixqP+TKtKYPR3dunBbrAwTo0HwvYNZwA6S
         JpNz07FdLKejT2CcP6zdBc6TSUrtlqD2vipPH/xncWaKCA6xArdnzeKbC7No0sgcaSPs
         wiZg==
X-Forwarded-Encrypted: i=1; AJvYcCUbgVNIeOTpURChIqNL57qHugJKMIvICww5TBP3njxY9iHdD3Ubl313QgQHL+Q3k3optwyVW0YPh8+dQIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4KQuwtIPcIkAH39onp4ex2QxMNRe5vqW13KS0BSsZt5umdg2
	RhLa/M0dnSLSYYvXy1LpqZM9SgSGChwfI6OtsiABgE0KPLBSvsYkZtpyz+WzsbY=
X-Google-Smtp-Source: AGHT+IG6Fxgb4NHCkIX3/dnlPvjFLsVzKH6Jek9DA+hqFWFwOWxceGjaQg5r7AgnL5NBc1jgnzfu1g==
X-Received: by 2002:a05:6402:274d:b0:5c7:1f16:78e3 with SMTP id 4fb4d7f45d1cf-5ca0ae81acbmr2408464a12.22.1729258934653;
        Fri, 18 Oct 2024 06:42:14 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0fec43sm751287a12.91.2024.10.18.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:42:14 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:42:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <ZxJltegdzUYGiMfR@tiehlicka>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
 <20241018123122.GB71939@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018123122.GB71939@cmpxchg.org>

On Fri 18-10-24 08:31:22, Johannes Weiner wrote:
> On Fri, Oct 18, 2024 at 12:12:00PM +0200, Michal Hocko wrote:
> > On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> > > HugeTLB usage is a metric that can provide utility for monitors hoping
> > > to get more insight into the memory usage patterns in cgroups. It also
> > > helps identify if large folios are being distributed efficiently across
> > > workloads, so that tasks that can take most advantage of reduced TLB
> > > misses are prioritized.
> > > 
> > > While cgroupv2's hugeTLB controller does report this value, some users
> > > who wish to track hugeTLB usage might not want to take on the additional
> > > overhead or the features of the controller just to use the metric.
> > > This patch introduces hugeTLB usage in the memcg stats, mirroring the
> > > value in the hugeTLB controller and offering a more fine-grained
> > > cgroup-level breakdown of the value in /proc/meminfo.
> > 
> > This seems really confusing because memcg controller is not responsible
> > for the hugetlb memory. Could you be more specific why enabling hugetlb
> > controller is not really desirable when the actual per-group tracking is
> > needed?
> 
> We have competition over memory, but not specifically over hugetlb.
> 
> The maximum hugetlb footprint of jobs is known in advance, and we
> configure hugetlb_cma= accordingly. There are no static boot time
> hugetlb reservations, and there is no opportunistic use of hugetlb
> from jobs or other parts of the system. So we don't need control over
> the hugetlb pool, and no limit enforcement on hugetlb specifically.
> 
> However, memory overall is overcommitted between job and system
> management. If the main job is using hugetlb, we need that to show up
> in memory.current and be taken into account for memory.high and
> memory.low enforcement. It's the old memory fungibility argument: if
> you use hugetlb, it should reduce the budget for cache/anon.
> 
> Nhat's recent patch to charge hugetlb to memcg accomplishes that.
> 
> However, we now have potentially a sizable portion of memory in
> memory.current that doesn't show up in memory.stat. Joshua's patch
> addresses that, so userspace can understand its memory footprint.
> 
> I hope that makes sense.

Looking at 8cba9576df60 ("hugetlb: memcg: account hugetlb-backed memory
in memory controller") describes this limitation

      * Hugetlb pages utilized while this option is not selected will not
        be tracked by the memory controller (even if cgroup v2 is remounted
        later on).

and it would be great to have an explanation why the lack of tracking
has proven problematic. Also the above doesn't really explain why those
who care cannot really enabled hugetlb controller to gain the
consumption information.

Also what happens if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled.
Should we report potentially misleading data?
-- 
Michal Hocko
SUSE Labs

