Return-Path: <linux-kernel+bounces-387674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925E9B546F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E783284C34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC02076D5;
	Tue, 29 Oct 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JpW/WYPy"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A40205ACD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234936; cv=none; b=Xe9FqI3Ag96CLvu56oB2e0j82y6sN6vUCQ7UIxpvrTzIC1BE9Jzndma7WvwVdHS1hTv+N0nWRBPPjD/2uzw6Ew+3zqHfLbyCjBLWgObBtdov/oNEjesieSe9zXnk3nLWXUZgt+6k1Fie3DFpSVZSCSbgp7clcieyVmQVhbV3Byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234936; c=relaxed/simple;
	bh=BsnzNvPCJXHZyKoa716Hd+vcE18PfG6O4lqHQBxHDyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqtosee2vCGeGqPNbWjMhHDARGBFlNvn3p82C1dCc3tMLzr8ohLbbd32nFPbd6KKlbl5U9TRdldqjLK+YmLw7YtG+XSenUq2k0mb5xQ6SYwwv6SFMgMrO9k0bkxwH+C/RMw/qABF86LHxIxQ/bgx5G6R+8cETICRrRwitN/Pf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JpW/WYPy; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ec1ee25504so1806332eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730234931; x=1730839731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz+fam73nTglMEn1ntwtV0+tn+WJ+jMNoRjEuTQ5sUc=;
        b=JpW/WYPy6wJLgClCi1hsss5sdpLWWV1z0tB4ossXXca+1z6nf33/UdNSCHtGPKctCY
         sP75PeoF+pCUKic8PDotOzUst7vmCM5zHWenrd0iq9aK0mjA8a89Hyllft1HyrUzHSq0
         3hxRWuGFipq29JoZYVpNU5XRS1L0jL+NBZhVneWV8RWmHnC62gGqrwNJ3XXa2FRlWaI3
         jEFAPw0vWh6kXmxmzmqSPIMELREhEMa2Pa6IbRGM9L01sXZjLTASMS1SpYI2/PaL3Fs+
         9NPqZYpgtS969mT2X7iuFPExASjvAcnZZleOWrQx8JbbBr27GJDI+dSki+CrY3zaT0Vs
         K3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234931; x=1730839731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz+fam73nTglMEn1ntwtV0+tn+WJ+jMNoRjEuTQ5sUc=;
        b=MITwBkJTOUjZvBfTxJV/IHKnJXTo0/VL8aUAFb93Kd9lQ/qlTH+ezBN2SLW43Kf6uL
         AhxDRwLyb8iZzDSlUuqupjzOpVNMuIGwnKnIi44jgkfpkhahLDj1PwDotqJL9fbpAB7f
         oQSJ+FxPqZy9Oq1/tZaOzbe04UHcuHQa26Mx0DO62gwmFtUL/7MD10bqxG+Nt61f4Z81
         dUDd4R57IPM8l1+0W3x9GRKg4YxOcdn+bclDSVJ0Lj6oyTOI82OtF0u8B38WkV0679FF
         WpCWSlUwPZbHogIDkoibkLQuKNsGBe3nwuFZ8CPB44fSmF0HzTGA3dripneRp7PHZbBk
         xAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRawr+mLOZj4n/iMNkjOJvAILKCK3K+hvXQZUENTJ8TWFWTvASRu0qr8HY5JvtOpb9TqOBK19DJWOH+0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS94jyv7iej0dD4NEkdM3uE/gaQsesh7a/weA8BTMTP4nFeZ6t
	B6OEq1UAerpAripuYYTMMNUb+OplPQaaKljm6Vjcja10WyMbK3V87+Ptaeb4uWE=
X-Google-Smtp-Source: AGHT+IEk+xZmWM8WKpt5tWtQhDCJGSjpzhCeDTFcsgf8Se6KNsxb5wHR97kIMZ66xEGKYHUW/E2EDQ==
X-Received: by 2002:a05:6358:6f17:b0:1c3:7b8e:c35b with SMTP id e5c5f4694b2df-1c3f9f5be1cmr617877555d.19.1730234931163;
        Tue, 29 Oct 2024 13:48:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2ce60sm45153996d6.108.2024.10.29.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:48:50 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:48:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: nphamcs@gmail.com, shakeel.butt@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net,
	lnyng@meta.com, akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <20241029204846.GB636494@cmpxchg.org>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>

On Mon, Oct 28, 2024 at 02:05:05PM -0700, Joshua Hahn wrote:
> This patch introduces a new counter to memory.stat that tracks hugeTLB
> usage, only if hugeTLB accounting is done to memory.current. This
> feature is enabled the same way hugeTLB accounting is enabled, via
> the memory_hugetlb_accounting mount flag for cgroupsv2.
> 
> 1. Why is this patch necessary?
> Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> hugeTLB usage to memory.current. However, the metric is not reported in
> memory.stat. Given that users often interpret memory.stat as a breakdown
> of the value reported in memory.current, the disparity between the two
> reports can be confusing. This patch solves this problem by including
> the metric in memory.stat as well, but only if it is also reported in
> memory.current (it would also be confusing if the value was reported in
> memory.stat, but not in memory.current)
> 
> Aside from the consistency between the two files, we also see benefits
> in observability. Userspace might be interested in the hugeTLB footprint
> of cgroups for many reasons. For instance, system admins might want to
> verify that hugeTLB usage is distributed as expected across tasks: i.e.
> memory-intensive tasks are using more hugeTLB pages than tasks that
> don't consume a lot of memory, or are seen to fault frequently. Note that
> this is separate from wanting to inspect the distribution for limiting
> purposes (in which case, hugeTLB controller makes more sense).
> 
> 2. We already have a hugeTLB controller. Why not use that?
> It is true that hugeTLB tracks the exact value that we want. In fact, by
> enabling the hugeTLB controller, we get all of the observability
> benefits that I mentioned above, and users can check the total hugeTLB
> usage, verify if it is distributed as expected, etc.
> 
> With this said, there are 2 problems:
> (a) They are still not reported in memory.stat, which means the
>     disparity between the memcg reports are still there.
> (b) We cannot reasonably expect users to enable the hugeTLB controller
>     just for the sake of hugeTLB usage reporting, especially since
>     they don't have any use for hugeTLB usage enforcing [2].
> 
> [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
> [2] Of course, we can't make a new patch for every feature that can be
>     duplicated. However, since the existing solution of enabling the
>     hugeTLB controller is an imperfect solution that still leaves a
>     discrepancy between memory.stat and memory.curent, I think that it
>     is reasonable to isolate the feature in this case.
>  
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

