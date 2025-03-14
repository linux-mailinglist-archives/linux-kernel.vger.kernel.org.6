Return-Path: <linux-kernel+bounces-561563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BCA6137E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6427A16F66B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C2200127;
	Fri, 14 Mar 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xCdQdTxd"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33B2E336A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961923; cv=none; b=eyJSETI7ZXy0Ivf6eghNeZET/IgHefmKBzc/KDjp8vTr7cmWCRnGq/42siHpr3o+j+A5GeuA63bjppn4T9pevkgIc9gYF23RqdqlqfyN5owIjMhIAvBrUe9SslIuWQL6C34l+mHDLq63IhAkMnskA5J34jHg/LJIb275pn/Y3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961923; c=relaxed/simple;
	bh=lBBP5TqAT8LnzORobHQMDmtz1K3uTro/RaLi3DNhWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUeaGoir3Jwitm6t4E256IFwUOFaXCFR6ReeCrD6kSDzt3jwdVvSRxlMwERo2YA6RRjT5R6l97dOE75ps/YtEMra5ezvasGR7iQpDmHfPGKZx/D+aa2mP3YfYYc8cTfK90js4a1MhCQ0wy6ALftBypGpzYlm/E766v/a6JXTTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xCdQdTxd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4768f90bf36so17876561cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741961919; x=1742566719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaDYviHzXbMRVdS6PNoP5phPb9zBK8u8E5XEDQrfB7c=;
        b=xCdQdTxdVkCQNyzuB276+D7tHd5AedJraIRaGOYtzlxRmZe9r9I6mLZ/E3AcZ+2cIh
         4v9mqOrehdM6OmNlbymrnhdetcbRb72N9IwxOdn8DYDySieXYPfzv9pQPBNEvg5T2Cbe
         URNHTBKKFY3VClL7wECtspgvxm8yOw4d1bu17AgvFvLveJMn4SkAkbqo6fgJA5bVINqy
         y50MhblUCzzOxvXD1PGtuEMWI374YeRdF1srXhIpiKQ+uJq8sBjVTcxY6nlGVds1WdUs
         RYqCWtLNUJkM1NQ+FHtNO9kNaMv/7smvVSrTq7qOtAzFkg6R9p0TmhhUGDG9A/g/ippD
         cINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961919; x=1742566719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaDYviHzXbMRVdS6PNoP5phPb9zBK8u8E5XEDQrfB7c=;
        b=Tqw1NkPYkZ+toRLettEx/j8MiRJkWV/HjSNXEVQy154MEq/duUJ78paMidZyXQjOCv
         RgZkUk3Qz/PD/oa/YOS8Clyd4pbX3J/cJPqIP4Z7ebLxp7+KvdpiUgEWhtPNs1LRrhwq
         jTZgrFfh7g10Dn6FmcVj8HaUp1rRH7g6aX88TuUUCBGe/VKS+hUwDTv+sX0KyQQwkBfH
         xF5BoAgeHoP6oGmqHpg6DIe6CDejZXlAr7YO7GUgL3p8gnhNhgvg0CkBo3LA023+pUVR
         6XqCOEeWwZOetfoEnS8m4bDONcmeVfIu5/wNC0Xy7F0E6C5xfJSuk7/mftGVBAzqt5/K
         NZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6Lcls4PeUalFznvA0DoRjJ0cUvZWmSveGIrf092SYH9Yy2tBHFLjJykQI5msK+OpE/EE+KqJzT15bvIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvPep9JewJRgMj67mBXUNvYBRhYTNcbH0L67o8w7yfN8zEVR3
	Iy9S7H8vcvSB9Jjf2u+pUwaac1/D8ImLnqwtdaH3AX7L17tmwcK807ezvXZxHRU=
X-Gm-Gg: ASbGncuvGgbS+ZxWS2NnuS/b1zAijB5hqsNgdz8ByGTrL2tO2MygGtm5bZShQDX2LLF
	nVTU0XEYE/nna+UfPZ15cNDcJHgEMaQZAszfTZ3pWFBmxN7GW+vfc/10BPQMTJhZWuDiFGHC4rT
	XJFba1hl8Efiqk1wFBs0MdkQ6xqvgrj7GcC6WwXJ7iTnacOZZr0jFVCzmMO5wcPAbNzJpJ/3TsZ
	oYrTOQbwFY+acLj5dMSKGAvtDY43fVHs7NsnIXlUTEyaD3KoXVk2ID0p20kPoHLt6hy6+WtxJRi
	eKAB8aeDgqyL0fyK6wxAlaWIPIb7d6JFR3ZCmEtUvcI=
X-Google-Smtp-Source: AGHT+IG7F2ni/878Zv1My77dBoi+suAvL96gvrp6tTD3MWR04MKx7wwf6zLBRFeSQYIOoSvEPfAl0g==
X-Received: by 2002:a05:622a:250:b0:476:9e28:ce49 with SMTP id d75a77b69052e-476c81e8cc8mr35426001cf.43.1741961918922;
        Fri, 14 Mar 2025 07:18:38 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb6370aasm23704331cf.20.2025.03.14.07.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:18:37 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:18:33 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, akpm@linux-foundation.org,
	muchun.song@linux.dev, yosry.ahmed@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <20250314141833.GA1316033@cmpxchg.org>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
 <Z9PuXMlHycL6Gco0@tiehlicka>
 <Z9P2nZ6b75FRMhCp@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9P2nZ6b75FRMhCp@tiehlicka>

On Fri, Mar 14, 2025 at 10:27:57AM +0100, Michal Hocko wrote:
> On Fri 14-03-25 09:52:45, Michal Hocko wrote:
> > On Fri 14-03-25 11:33:50, Zhongkun He wrote:
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
> > Haven't you said you will try a slightly different approach and always
> > bypass LRU balancing heuristics for pro-active reclaim and swappiness
> > provided? What has happened with that?
> 
> I have just noticed that you have followed up [1] with a concern that
> using swappiness in the whole min-max range without any heuristics turns
> out to be harder than just relying on the min and max as extremes.
> What seems to be still missing (or maybe it is just me not seeing that)
> is why should we only enforce those extreme ends of the range and still
> preserve under-defined semantic for all other swappiness values in the
> pro-active reclaim.

I'm guess I'm not seeing the "under-defined" part. cache_trim_mode is
there to make sure a streaming file access pattern doesn't cause
swapping. He has a special usecase to override cache_trim_mode when he
knows a large amount of anon is going cold. There is no way we can
generally remove it from proactive reclaim.

