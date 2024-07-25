Return-Path: <linux-kernel+bounces-262496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A793C7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6317C281CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E219DF94;
	Thu, 25 Jul 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FgNdkf4J"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B530854759
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929198; cv=none; b=G0Cm31tIbrMqtuz6PkipaudR7IunI75hko2SiP4qhhYJUL6lo42ummYzsHoReJPBl77Ciyl68spih1XWltOL9wJw8P1lknvaQvLZeRYS9YuhQxfaYv4xz7beadKmMuqKNP3agt3r4FjXCYeA9H76SRvZw8noE+3SrZhFaFJka7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929198; c=relaxed/simple;
	bh=yoEv3GlbwT6UsQ5b5s5duS6tb26odOD0neXsqOSLGEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgXyc3UNGDZXWr10uymUVBjt2v2APLXqnfT5oW6wPjEaH+bMSsCaBygV37ZzBhk3oOTn1y6804HJHkjKv1Y9usFEbvZRUMJztrgc1FSCvQhxIIPew+yz0SJ59mFVLyRktemtRC+MsDfJFih3aNu3IEK8Buqf3TZCI0GHg5xw55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FgNdkf4J; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jul 2024 17:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721929193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wodKrrDe2cqof0/g9wNaNIiFlKLU0ROQCInky1h/aQo=;
	b=FgNdkf4JTFnSgALEkNLIckMzWTpjyhh8UIdUCiMC8VSGcsi80CXKKYMsp53gE7tsNBO0Qq
	sJduM1mngr2yTe7RfxBKc0FoD6rRVSNzanp8hZEsuaC2c0UyI/d2YxNy6bPkkuZ/KXLomQ
	6YGuQ9RGzooG1yYEvhTuVRpu4WnADZY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Message-ID: <ZqKN4jF7eQ-o-mNH@google.com>
References: <20240725094330.72537-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725094330.72537-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 25, 2024 at 05:43:30PM +0800, Muchun Song wrote:
> The obj_cgroup_memcg() is supposed to safe to prevent the returned
> memory cgroup from being freed only when the caller is holding the
> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> ignore thoes conditions when users call some upper APIs which call
> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> the link below). So it is better to add lockdep assertion to
> obj_cgroup_memcg() to find those issues ASAP.
> 
> Because there is no user of obj_cgroup_memcg() holding objcg_lock
> to make the returned memory cgroup safe, do not add objcg_lock
> assertion (We should export objcg_lock if we really want to do).
> Additionally, this is some internal implementation detail of memcg
> and should not be accessible outside memcg code.
> 
> Some users like __mem_cgroup_uncharge() do not care the lifetime
> of the returned memory cgroup, which just want to know if the
> folio is charged to a memory cgroup, therefore, they do not need
> to hold the needed locks. In which case, introduce a new helper
> folio_memcg_charged() to do this. Compare it to folio_memcg(), it
> could eliminate a memory access of objcg->memcg for kmem, actually,
> a really small gain.
> 
> Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

