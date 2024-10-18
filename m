Return-Path: <linux-kernel+bounces-371435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844C9A3B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E300F1F25358
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8220111A;
	Fri, 18 Oct 2024 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IGc0sspd"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA2201111
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246324; cv=none; b=a250ULVWGAsELOb5FOvosozDpqIe9MAzoxBycVLJo/Yk1N5jwj6QWB++pmXMT7l8HKZsxd4+4T5oRrN6CYmxTuNvPdEti1hnTYE9qBGF+rncQXBkYe2KwWNev0k69ARKfZIymq1im1/dzxcvc6hzCX/4j4Ewjk1y0lArL85HUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246324; c=relaxed/simple;
	bh=1F+qf+jVYc/QP5fGuzJST4sDlujrh+4dBWGgsBxOxjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soYI/pLvyiKmTTCIQRn+woi5CL5pOcpSqUDqwN5WnwYT+jsT4kpIejpdREtZv1CTSbPiS1JarbjSLotGB3eMYDITLiUiZilUpdj9iBgrNGkIlRP5Hhsu1zHxdxQDFlAehg+a4xXSMWTm+fjF31y1Wf1l0dhDBi2up2QaJB2DDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IGc0sspd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99e3b3a411so476821866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729246321; x=1729851121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP+JOMY4iaykICx5qO8ZsaBsQsowDERbnUHntcs+XbI=;
        b=IGc0sspd+xYB43TxxI3oLURazNX/sZLIvcj4E6U2IA28fXCrojcqaC2c6J6w5MdTqY
         NsaVVPv5yx+z6lhyqWmJSMXoZZhgnntohVOXhCI4+RL5kwC+MRt3qmmuWMvfjz8OUkB3
         qM3BxXQ+nR8/3dELxHKRNDKOqEwOgWYbWvfVYDH6sNe5f0DDBX5P7oAX20WJa4a6IskV
         MPuK2c/T7f+YBLco3FDnXr4lZEWGHEAUhsWKQRnMtKWMpealyq+M6WiFXfyv9eb1to2f
         xnHrO18ms0s/DewxjmwnIRZ5pPsrY7wYNllMf7AKANLP0HBgz9yx0ZhYJOnb+Om+P0ai
         4W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246321; x=1729851121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP+JOMY4iaykICx5qO8ZsaBsQsowDERbnUHntcs+XbI=;
        b=Ck4/nmE2waQp8qRpHtF4LKQxNBo83czSN+Hsr+f7ZQcy8zw1MkzRl19dj1kTaRKJFs
         mbaqGEiAu2HoldijMarfOoWXwTUTFEKqGsJOMRPtmNRtwwSq+o29sCx9QrvZUu1/N6Xq
         otMPA++dog5/5EFcFrKPGEeza5SKNkffR9VfaVcMCz2/POxgLMlowUC5Uj7nb98kt8pG
         lXpe+aCGgeR/DZnuRO+m7DiamtGASmrq+a9z7eruyIshfxsriEZf+41dWkdlzjQz9mMY
         lOpiIuz0bX59pLImn1zUaV2yXhEhe49M0mSuKh+K4uvA7Emp6bjpRcLAy4Wf2G3+AMbi
         2jew==
X-Forwarded-Encrypted: i=1; AJvYcCXDLcfITcpBFRW9E9L3wYzYlTDFcXp3hVHbAC5gQu56HrcZE1JTeZurvsT53cqicA/m0VW8+/dYsgfSitA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaO9Ouz3csXak9emzx0GfZSvmPr40DGexp4NfbnqMiSxDWecy3
	dygY1gG/pOdGlJpeY90ujz83Ul4NWi/gd45PqEadHGpvRmaPR8qMUsGHWmuKIdg=
X-Google-Smtp-Source: AGHT+IFpi0II1Hmaw1IuAkx+cm14EFxpoJJ2Qv/1Lw4miCPbqkHcvomv5vAStTR5DLHU/UpSIoybaQ==
X-Received: by 2002:a17:907:6e87:b0:a99:eef5:d360 with SMTP id a640c23a62f3a-a9a4c311578mr608526566b.19.1729246321295;
        Fri, 18 Oct 2024 03:12:01 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf4157sm73467066b.154.2024.10.18.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:12:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:12:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <ZxI0cBwXIuVUmElU@tiehlicka>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>

On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> HugeTLB usage is a metric that can provide utility for monitors hoping
> to get more insight into the memory usage patterns in cgroups. It also
> helps identify if large folios are being distributed efficiently across
> workloads, so that tasks that can take most advantage of reduced TLB
> misses are prioritized.
> 
> While cgroupv2's hugeTLB controller does report this value, some users
> who wish to track hugeTLB usage might not want to take on the additional
> overhead or the features of the controller just to use the metric.
> This patch introduces hugeTLB usage in the memcg stats, mirroring the
> value in the hugeTLB controller and offering a more fine-grained
> cgroup-level breakdown of the value in /proc/meminfo.

This seems really confusing because memcg controller is not responsible
for the hugetlb memory. Could you be more specific why enabling hugetlb
controller is not really desirable when the actual per-group tracking is
needed?
 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> Joshua Hahn (1):
>   Adding hugeTLB counters to memory controller
> 
>  include/linux/memcontrol.h | 3 +++
>  mm/hugetlb.c               | 5 +++++
>  mm/memcontrol.c            | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> -- 
> 2.43.5

-- 
Michal Hocko
SUSE Labs

