Return-Path: <linux-kernel+bounces-388972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69099B66C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87BE1C20A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077F1EBFF7;
	Wed, 30 Oct 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vnFqCP7T"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C21EF0A2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300472; cv=none; b=paRj0z9maHL+OOrWq7m7RYLgKNb5xGX45D+sfLYwHmccmqU/av/wwypz04ZYLPi9kNStcuzVkbYUiNNSO3aTLQ4lX7LhBF412SA59U7VaoGpDcpS4GXgFLOU332gzdN5DDopXTjymh3nHDBl3PVIm6cjkBOzaVDXMsRqlZy6G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300472; c=relaxed/simple;
	bh=lpvecm1f5pu4GtEx3sl9tf4tvgcFxrIcvbcBaG9U6AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhm9gJb7gbHbF+4Fqgr/BcavkUcARFnwkQN4FokCIq85wWFMggohDjuNqgbJTSY9phAYQKLQa+HI5JFoV/bEQo4pUaGdNUoxLJ4XfpIypBljcYxJro1WMevst0X8kCeKHCMIxBxIZijqktcrDq9rKbYq0m0xdaAlg5AOj7f7xf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vnFqCP7T; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718998df806so167786a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730300468; x=1730905268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9L+h3DakvrHLU0Mvs5EKdTAhMxHYKDitGx80mazmNoE=;
        b=vnFqCP7TRxmBq/1uDIIU7xrvKrfeNavTDVCK9hIvEDPW7zwsKbHPnSN2pq7gsds+nA
         vmtAEifumKq/Jb8nvqdSPeFBXVjiwqK2K/kUDShTAAYd9+aAgxeuNvKbXPszGU2npur+
         LFhV9gEBivYYX+VPJjik230D1XUwHm+Z9ZwzeeCD1cAQ2Tm0f33xR6yhQARWU+EviCuP
         X5aXCyPD/7C9A7f6cfo8jjZNlZjCxV8oywr4Y+a4eVHH4ReJqPJdxS/7CUwSHEpPCunF
         RpSU9/aD7zoowY6PQWIUOvOR1Q/i7V+QKVLckdsxN90V157MFPbmkzs69v6L/ONEjwOm
         Wz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300468; x=1730905268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L+h3DakvrHLU0Mvs5EKdTAhMxHYKDitGx80mazmNoE=;
        b=ka0aISbbUajX55VERrTGictslrnF30rEUXEZDjOh/KzyEOJ5Wv3fGeuvZZstjZ4tsW
         KajzsLtp10QEjDUfwUDfBLHENFEG2ESfQh4F8685X0o4BgUK4l5SC2kpm7MaUPCGl4yD
         TGr1bAAGo7BCuxZRfZaPPaxj3xjPxDSp6eYT6iFc0Z337hAnKgJ+g8uVnmii+am/lOvG
         Hcpl9I2M4A4dexmgmxb39s1Vyg7BicYwead29B/0EDloYo7vrYquvQ+Wt4+IAKKp61+s
         0jgsALwenYRtfNxPh+Xq/BsITlw1NGyUGc66Bp5Mq7lrxEDbWS/93LgRjhjIJeVmSL7S
         gX5w==
X-Forwarded-Encrypted: i=1; AJvYcCUXJnhg4QOr1x70BxRxeMjmAKggPvmbaHaUEeD5ApJqnhk7KrmMeSsoDRFy6pbP1NA4iVsgrHsIyVZt0jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7p2/kgjAR02ptufmObH9kCgkRfSL4Qce2EQ11MpTXSyChJ2s
	YSQUkwdG5xUWOfox8mzblz5KBRcvXUEJubJZQis24aZJXfAMeDRm23b5DglWwmU=
X-Google-Smtp-Source: AGHT+IG158ptjqLIj0gjGFfB685gOEBJUFjuG7Y8dRLeCk9VafXrmZFUa5vVNmgGQg2umHSprc+JtQ==
X-Received: by 2002:a05:6358:729c:b0:1c5:e2eb:2fba with SMTP id e5c5f4694b2df-1c5e2eb32admr285161955d.18.1730300467658;
        Wed, 30 Oct 2024 08:01:07 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a1bf3sm55265351cf.81.2024.10.30.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:01:06 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:01:02 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <20241030150102.GA706616@cmpxchg.org>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyIZ_Sq9D_v5v43l@tiehlicka>

On Wed, Oct 30, 2024 at 12:35:25PM +0100, Michal Hocko wrote:
> On Mon 28-10-24 14:05:05, Joshua Hahn wrote:
> [...]
> > Changelog
> > v3:
> >   * Removed check for whether CGRP_ROOT_HUGETLB_ACCOUNTING is on, since
> >     this check is already handled by lruvec_stat_mod (and doing the
> >     check in hugetlb.c actually breaks the build if MEMCG is not
> >     enabled.
> [...]
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 190fa05635f4..fbb10e52d7ea 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1925,6 +1925,7 @@ void free_huge_folio(struct folio *folio)
> >  				     pages_per_huge_page(h), folio);
> >  	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> >  					  pages_per_huge_page(h), folio);
> > +	lruvec_stat_mod_folio(folio, NR_HUGETLB, -pages_per_huge_page(h));
> >  	mem_cgroup_uncharge(folio);
> >  	if (restore_reserve)
> >  		h->resv_huge_pages++;
> > @@ -3093,6 +3094,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> >  
> >  	if (!memcg_charge_ret)
> >  		mem_cgroup_commit_charge(folio, memcg);
> > +	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> >  	mem_cgroup_put(memcg);
> >  
> >  	return folio;
> 
> I do not see any specific checks for CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING
> in these paths. I guess you wanted to say that you rely on
> mem_cgroup_commit_charge setting memcg pointer which then __lruvec_stat_mod_folio
> relies on when updating stats.

Yes, this is what Shakeel pointed out here:

https://lore.kernel.org/lkml/il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh/

> I suspect this all is done because you want a global counter to be
> updated as well, right? Changelog doesn't say anything about that
> though. Why is this needed when /proc/meminfo already describes the
> global hugetlb usage?

Sigh.

vmstats is the preferred framework for cgroup stats. It makes stat
items consistent between global and cgroup. It provides a per-node
breakdown as well which is useful. It avoids proliferating
cgroup-specific hooks in generic MM code.

It was a ton of work to integrate cgroup stats into vmstats and get
rid of all the memcg special casing everywhere. You were there for all
of it. We're not adding cgroup-specific stats unless unavoidable.

Duplication doesn't matter, either. We have plenty of overlap between
vmstat and meminfo. By all means, send a follow-up patch to have the
meminfo one sourced from global_node_page_state().

But you know all this. I'm having a hard time seeing the way you are,
and have been, engaging with this patch as good-faithed.

