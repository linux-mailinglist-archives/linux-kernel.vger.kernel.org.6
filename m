Return-Path: <linux-kernel+bounces-261571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0193B92A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF4A1F23E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB413D51D;
	Wed, 24 Jul 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzRNgrUt"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752A13A3E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721860732; cv=none; b=XrRwI0F1S5D0tT2eSTWB9gqITvEf9EsUQFiBKwpl1tJBDSaSSqqB6QlKzlUdASs2uxn32MylNpZ2dUfeM2VmNjs6t24dbZ213U4GM/q5fpT8r7AM5bS+aF/XoTvjSO6kFbY1TwrK+jbx4snY6lJ59P8sVjsdMrEb67wyrnEJCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721860732; c=relaxed/simple;
	bh=G1cvcVivMUdlgb85diYQo5+jyRv2eMTLJYL/jByZQPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDapd7HmbuARmItXQKpfwmAZF+CKcjK1qp7Gct7ybs2KfVG7Hwd293ZfhYxJn/mXc9jDjMWdk7GWbPsh42V27afPnKZZ0Op5sR9ppJWDjwPqNP7ca9aq+uIxPw5SSRUpN+MTnmhHw6FzKB8JKvQWjI+iYbdbzL7ffXb6ZVaZol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzRNgrUt; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 22:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721860727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa12xhcwGYWhKFU8YlB18e+bkbQbKpTyxv5JolLajyI=;
	b=rzRNgrUta71PEusaTqtjES9ZeQ2BsHFx5T0w/qmy0FzuUvsUQrlE1gMAhDgUM1RdPfbsGa
	eio+MV6v96WLahF445gldpaoeRQz6TJdZNQZvQEDSmP5cSJ5bHpaPiXadDBDbNsHfRU+df
	AAmuKB+h+0dUE702S4EynQXbJLeF23Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Message-ID: <ZqGCc5EjtBGGZMD5@google.com>
References: <20240724095307.81264-1-songmuchun@bytedance.com>
 <610dc6fa-6681-4c9e-bffb-ef6d299dd169@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610dc6fa-6681-4c9e-bffb-ef6d299dd169@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 05:20:09PM +0200, Vlastimil Babka (SUSE) wrote:
> On 7/24/24 11:53 AM, Muchun Song wrote:
> > The obj_cgroup_memcg() is supposed to safe to prevent the returned
> > memory cgroup from being freed only when the caller is holding the
> > rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> > ignore thoes conditions when users call some upper APIs which call
> > obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> > the link below). So it is better to add lockdep assertion to
> > obj_cgroup_memcg() to find those issues ASAP.
> > 
> > Because there is no user of obj_cgroup_memcg() holding objcg_lock
> > to make the returned memory cgroup safe, do not add objcg_lock
> > assertion (We should export objcg_lock if we really want to do).
> > Additionally, this is some internal implementation detail of memcg
> > and should not be accessible outside memcg code.
> > 
> > Some users like __mem_cgroup_uncharge() do not care the lifetime
> > of the returned memory cgroup, which just want to know if the
> > folio is charged to a memory cgroup, therefore, they do not need
> > to hold the needed locks. In which case, introduce a new helper
> > folio_memcg_charged() to do this. Compare it to folio_memcg(), it
> > could eliminate a memory access of objcg->memcg for kmem, actually,
> > a really small gain.
> > 
> > Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> > v2:
> >  - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
> > 
> >  include/linux/memcontrol.h | 20 +++++++++++++++++---
> >  mm/memcontrol.c            |  6 +++---
> >  2 files changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index fc94879db4dff..742351945f683 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
> >   * After the initialization objcg->memcg is always pointing at
> >   * a valid memcg, but can be atomically swapped to the parent memcg.
> >   *
> > - * The caller must ensure that the returned memcg won't be released:
> > - * e.g. acquire the rcu_read_lock or css_set_lock.
> > + * The caller must ensure that the returned memcg won't be released.
> >   */
> >  static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
> >  {
> > +	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_is_held(&cgroup_mutex));
> 
> Maybe lockdep_assert_once() would be a better fit?

100%.

