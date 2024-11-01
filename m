Return-Path: <linux-kernel+bounces-392323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24399B928B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893CA28116C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9A1A08D7;
	Fri,  1 Nov 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GQsLFEV5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1519E96A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469024; cv=none; b=YtdiVXgLecLLgvK6EGoL3mebgP70LuUJS87Vi+7FYZB8I98btWviKrjP+3kBuJtKTedTq7BXWx+ZSnCf1rjtr4cJs2gWsHnI1H7kbXsFPFi4Uoo4YNOkhvA2ymUZ3mCuZlNURHIJkl6ZUZZoZ2/e5wh6GbkKiwO0p+7wbVBqfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469024; c=relaxed/simple;
	bh=zu87bpCL70s/oXUC3Rx7lgPDzEV5M9sVT/p4zMoS+p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc992m8ag2dBGtFCvut0zr+SvcGsFNy9J6YVNHiQY0j+V9rseNgqXlTaCtQBMQ9/MhZCnVa2t2RsbnlOnRkBtdhzKGvXQwCZRrQemAKjj6GpQtrQRv18qBD7rEDIlN+3duCPldNbT0E7nzD4Pvykg3Z5Iz52jMtuMEiJ/21Lgh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GQsLFEV5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9932aa108cso296235166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730469019; x=1731073819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMQKKJ98iVpHNH3i2CXUx1LW5hgoaOShr2IlFC3AvNA=;
        b=GQsLFEV5whx/f+5/yRNZO77X6XJ5I2olmEo3rRQx3yx899MV2ricHR8OwwxhoC/our
         gOOe/oLgIrSLyZi6DeMKGLm9MPPF9OSlOL0RbG6XAQ/NLyjBLG21EpPLrmBASNT5q+DE
         FkWehESNRE4VfzniZg4i8bMZ5+Rri3xq+zAE6Mr75a113CJNxRCX3dCoZIGuXSz0eJ58
         GSnDV+7cG/rsxKwX21BuTFPnWjA66CgsL5exuBtMD1DXggnieV2TWfY3x+WgY4QLlOjs
         SvZJmlkKF91Vwn5ENEbjjrKNKVfASjNcH/TEtlepRzC6nhhTG6Tc0/qwhCYlggjyeJ4O
         +Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730469019; x=1731073819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMQKKJ98iVpHNH3i2CXUx1LW5hgoaOShr2IlFC3AvNA=;
        b=ml+Nx9nd1rBjC987skuofEU85rWYq97yVdgj50/fljQBQMibp3TajqOxHFOrHxqqvm
         q7bR8RZwtrH4lRdrbzIc8pUpdqxjy1FTcU1akrOzQBaA9rH5NnUh2kxXlvK1L0YJYCl0
         jwYd3wVKqEw7TeN3yEZ1FSKxjhDsaUv/iKe9JTfPvYQIQy1zko4XfIP5lWamWuTQ5jYn
         BI5jAfOWcFSaa8fwMq1BjNTtN1esvtIcEfrS8h2matwwgm4Z4oFaa/2o72c1V+xpMxsC
         pPaXkLWs+rW/tN34FdIV+MWz7I57Rz3XzwUKo5GUlm1bGSlUweQAfrZkZDt2fnJ3A6zZ
         Me+w==
X-Forwarded-Encrypted: i=1; AJvYcCUxJxiit5xFns7N2tPSvsWOOmwDnrFg69zXm4MGwRKmI7mug+9bYSBJamBWlV9XtmnzPUmu5UpFUVTtxnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRE47tYM6BfFpXnKavGmPimgClaLPf5J473QNGMSYcporbONFb
	05q77lS1JhdVISIe29K6hS+A0XAZc7h53u0drupHIkbooGO+aBd6434mUPESCaE=
X-Google-Smtp-Source: AGHT+IE3cmDk5BoxktCJSNUuOb2jDNHY+v5dPRdUMK5bfZM+U1Uy2em//nFYolTGT6CKFGhcPhkwpA==
X-Received: by 2002:a17:907:3f9f:b0:a9a:2afc:e4d7 with SMTP id a640c23a62f3a-a9e50b948d0mr670223566b.44.1730469019255;
        Fri, 01 Nov 2024 06:50:19 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494465sm182111266b.30.2024.11.01.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:50:18 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:50:18 +0100
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
	artem.kuzin@huawei.com, kang.sun@huawei.com,
	nikita.panov@huawei-partners.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyTcmvihAl_m4FZM@tiehlicka>
References: <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
 <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
 <ZyTUd5wH1T_IJYRL@tiehlicka>
 <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>
 <ZyTXYnbDfGYGuxlt@tiehlicka>
 <5baa6024-a0a4-4b0b-a7d1-641bba7e5b87@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baa6024-a0a4-4b0b-a7d1-641bba7e5b87@huawei.com>

On Fri 01-11-24 16:39:07, Stepanov Anatoly wrote:
> On 11/1/2024 4:28 PM, Michal Hocko wrote:
> > On Fri 01-11-24 16:24:55, Stepanov Anatoly wrote:
> >> On 11/1/2024 4:15 PM, Michal Hocko wrote:
> >>> On Fri 01-11-24 14:54:27, Stepanov Anatoly wrote:
> >>>> On 11/1/2024 10:35 AM, Michal Hocko wrote:
> >>>>> On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
> >>>>>> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
> >>>>>> THP mode property for several tasks at once, in this case some batch-change approach needed.
> >>>>>
> >>>>> I do not follow. How is this any different from a single process? Or do
> >>>>> you mean to change the mode for an already running process?
> >>>>>
> >>>> yes, for already running set of processes
> >>>
> >>
> >>> Why is that preferred over setting the policy upfront?
> >> Setting the policy in advance is fine, as the first step to do.
> >> But we might not know in advance
> >> which exact policy is the most beneficial for one set of apps or another.
> 
> > 
> > How do you plan to find that out when the application is running
> > already?
> For example, if someone willing to compare some DB server performance with THP-off vs THP-on,
> and DB server restart isn't an option.

So you essentially expect user tell you that they want THP and you want
to make that happen on fly, correct? It is not like there is an actual
monitoring and dynamic policing.

If that is the case then I am not really convinced this is a worthwhile
to support TBH. I can see that a workload knows in advance that they
benefit from THP but I am much more dubious about "learning during the
runtime" is a real life thing. I might be wrong of course but if
somebody has performance monitoring that is able to identify performance
bottlenecks based on specific workload then applying THP on the whole
group of proceesses seems like a very crude way to deal with that. I
could see a case for madvice_process(MADV_COLLAPSE) to deal with
specific memory hotspots though.
-- 
Michal Hocko
SUSE Labs

