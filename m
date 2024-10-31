Return-Path: <linux-kernel+bounces-390178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB949B7687
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA91C21B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5011494CA;
	Thu, 31 Oct 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c6TS7ju/"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564481EB48
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363596; cv=none; b=FxEOBLgT3WAOEQ1OwEKjXAtIu2Mi8DQs4Z289BAquOt2OrqgVN+hVhV4H2TSZtbUZGY7SGvppN8IbM4X/fzxPAOA6pKEdWuujX57AekAHCZ7aB2hSFOwdxMId86Mf+ZhSfNRX+jIc5/699hmGT0VgGYAahLaDihO3817evr1dJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363596; c=relaxed/simple;
	bh=N3zTl/Jw16eojtFcPU1VBtMWyrIA6IDXLYu/nCZ29Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T94y5srkg1dSzJz2sLwCJ/Hu1Opi/vNQ8Shz7EWdA/p5P+IfG8O5Uf2ln3+SFAZjT/RU9a9oR+jgQl82ACOBUCW+CZzcvzZyVPIH5c+wui92lfcMnY/O2hDLC7vsQSIENK0PeX9eMkXxHV7e0pfpcpAV4PBhoJV64X51xmqIfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c6TS7ju/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso94227766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730363592; x=1730968392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnS03BBo4QpsOCYCGr/jAfpuBdo72FatDxA9433QoBA=;
        b=c6TS7ju/m8vWCc87il6tVwqgsUXN5yYyleToIEGOWe5lNgyUYSBRooJ6hOPXDzzLjj
         f+4RvkxVoBDsdRKD4AXrd8ysZBEr63Xr8tIjVES1M2mdrT55z2BEXBr4g3v4QMisC3J9
         HbxH6SY5O6GjFnEZ7RyYtwnIMaShcKAfZlyJnAHGeAKO5uhrngJlB/LeO1IZVLuisAcb
         qwmlTJGTqG88YF6wOEIzH4mFeFizK2N1lEXVkjxVX5AhqwOGXrr6sa9k2ulqiOYQJGvs
         RQwFL+cUe7gOMyOdv0eF60uYziJ14kDBgLFXadHk28lnebCU8QJKQxrScqCJc7fXDEZ+
         2DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730363592; x=1730968392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnS03BBo4QpsOCYCGr/jAfpuBdo72FatDxA9433QoBA=;
        b=d6CYpBPoXhLN6sRXSn/4N7NUlDJRSTRi9Zhqh+HjM6kSpS9Z5THU8eiKAaPIeHgniH
         k4Egd0Pdhi9z0bROljMBtjoAqUOOG0VKnAWNqnZmoITnciK5912WtJFQ0Cid8zAbJX9w
         rz2uTFdSzwfX5g4zZzy4q3V0V5gvCNdcKKYuW6Dyd+axWM0plaVrA5PJqe8mobas56Vv
         8c8oIw0qqIh3ojAPOyVIZR8Yu7hJ5L3llClpm2tGRNZoILxYuoW+/4LNsPEOZpKPIQ7O
         ho9hxup9cg16d1wqlT4e3SO5mFO/VzeaoT6gVfm0HM4EmJicYs20+5uqtiw8EGBXIe5w
         zVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRhoggnHn/pV6WVHM3AnlXCcW7B913P1wKODdoKxeRhH8ruggnEVpvS7zqNr0Ei7muOETmAsQpc3wBfX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7gMga9VHQqCcoIv79HaQ/s4YrERN2wC4mcr1ur0eHUh/K8p6
	Xp3OoJ45KS6X/5ptnnCwUPceOcOjMyL6osg84OaA5njMnKWsM93EQI8ntih9UgU=
X-Google-Smtp-Source: AGHT+IGHTEKzBKUVtnYe2a+ryORO5DF46XNGMFFFG30oEA+vIuO4M8RnW3rXX+fthYfNoUcwAKa5AQ==
X-Received: by 2002:a17:907:7e8b:b0:a9a:3cec:b322 with SMTP id a640c23a62f3a-a9e3a6c99e0mr528256866b.45.1730363591611;
        Thu, 31 Oct 2024 01:33:11 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c531csm41316866b.51.2024.10.31.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:33:11 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:33:10 +0100
From: Michal Hocko <mhocko@suse.com>
To: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyNAxnOqOfYvqxjc@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>

On Thu 31-10-24 09:06:47, Stepanov Anatoly wrote:
[...]
> As prctl(PR_SET_THP_DISABLE) can only be used from the calling thread,
> it needs app. developer participation anyway.
> In theory, kind of a launcher-process can be used, to utilize the inheritance
> of the corresponding prctl THP setting, but this seems not transparent
> for the user-space.

No, this is not in theaory. This is a very common usage pattern to allow
changing the behavior for the target application transparently.

> And what if we'd like to enable THP for a specific set of unrelated (in terms of parent-child)
> tasks?

This is what I've had in mind. Currently we only have THP disable
option. If we really need an override to enforce THP on an application
then this could be a more viable path.

> IMHO, an alternative approach would be changing per-process THP-mode by PID,
> thus also avoiding any user app. changes.

We already have process_madvise. MADV_HUGEPAGE resp. MADV_COLLAPSE are
not supported but we can discuss that option of course. This interface
requires much more orchestration of course because it is VMA range
based.

> > You have not really answered a more fundamental question though. Why the
> > THP behavior should be at the cgroup scope? From a practical POV that
> > would represent containers which are a mixed bag of applications to
> > support the workload. Why does the same THP policy apply to all of them?
> 
> For THP there're 3 possible levels of fine-control:
> - global THP
>   - THP per-group of processes
>      - THP per-process
> 
> I agree, that in a container, different apps might have different
> THP requirements. 
> But it also depends on many factors, such as:
> container "size"(tiny/huge container), diversity of apps/functions inside a container.
> I mean, for some cases, we might not need to go below "per-group" level in terms of THP control.

I am sorry but I do not really see any argument why this should be
per-memcg. Quite contrary. having that per memcg seems more muddy.

> > Doesn't this make the sub-optimal global behavior the same on the cgroup
> > level when some parts will benefit while others will not?
> >
> 
> I think the key idea for the sub-optimal behavior is "predictability",
> so we know for sure which apps/services would consume THPs.

OK, that seems fair.

> We observed a significant THP usage on almost idle Ubuntu server, with simple test running,
> (some random system services consumed few hundreds Mb of THPs).

I assume that you are using Always as global default configuration,
right? If that is the case then the high (in fact as high as feasible)
THP utilization is a real goal. If you want more targeted THP use then
madvise is what you are looking for. This will not help applications
which are not THP aware of course but then we are back to the discussion
whether the interface should be per a) per process b) per cgroup c)
process_madvise.

> Of course, on other distros me might have different situation.
> But with fine-grained per-group control it's a lot more predictable.
> 
> Am i got you question right? 

Not really but at least I do understand (hopefully) that you are trying
to workaround THP overuse by changing the global default to be more
restrictive while some workloads to be less restrictive. The question
why pushing that down to memcg scope makes the situation better is not
answered AFAICT.

[...]
> > So if the parent decides that none of the children should be using THP
> > they can override that so the tuning at parent has no imperative
> > control. This is breaking hierarchical property that is expected from
> > cgroup control files.
> 
> Actually, i think we can solve this.
> As we mostly need just a single children level,
> "flat" case (root->child) is enough, interpreting root-memcg THP mode as "global THP setting",
> where sub-children are forbidden to override an inherited THP-mode.

This reduced case is not really sufficient to justify the non
hiearchical semantic, I am afraid. There must be a _really_ strong case
to break this property and even then I am rather skeptical to be honest.
We have been burnt by introducing stuff like memcg.swappiness that
seemed like a good idea initially but backfired with unexpected behavior
to many users.

-- 
Michal Hocko
SUSE Labs

