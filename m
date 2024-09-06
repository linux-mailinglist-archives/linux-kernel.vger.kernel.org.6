Return-Path: <linux-kernel+bounces-319267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE096F9DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0743C1C227F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE51D31B8;
	Fri,  6 Sep 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJ/sai9B"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B11D31B9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643197; cv=none; b=cr1CV34SXrosk2mSGSZq2148mptJ2XBavJWyy9noiSaVUUIGKPIAp4ldNbQFxHP/Ge6MWk0qxL3MCUpK3BvNdj+O/kjdgtnxdCHvmUi0q/k2tBNF2+QbGfTe2LL0aS5g9S5tJvpY0OBko2t8A81HC7+HUgL1tItx2+49VxADQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643197; c=relaxed/simple;
	bh=zOZwaZjiRk8ETXMl84tlGs5yuQFWHmj1JAq3YK0STxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knJbornZKbcFBi5AsBTe3UA2LAdWOrCjuDt4jfAo/B04yobJd0Tkpsp2eO4ApunLDJ/u+FFdTj0vfWN9XTbfIf1IWnvH/8ToDrojcCKgK1axssKnxBA+BXU1S7XCJR6S9nyTnQNksVANEP+NJ7mF0Ko2LRyNByT/OwdG0WSJ/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJ/sai9B; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86859e2fc0so288368266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725643194; x=1726247994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zo6fqgtuuFE4NzO7fsVL9VZI75GyA9ZRT8MrykdXVx4=;
        b=iJ/sai9BnA6alEdzOsgWxiEKHPKvTMHjvG5r242eI/hIBh1mGzhz8mAWwIPpve92QV
         8AL9D2sAlnTCGMQunL6WYdmJz/ptjjbNg32r4deju3Zo4LpnXSwBJrvw4P2qaIg8YCku
         VMDf1swzYRMCmFnKOpElIoAqwDyLAMb68OAc5lMAJ0Fa6UEwNhau1NETLULIPRZq9BEd
         GKyczy3mep4ZoUok4trRxgCJS8Pl4rVPFwHfhq1pCTL4kmWOwJjNBrTFH6lXlTlSGyiN
         lO35s5tNGWec4/5WbS1PjtOPyq1zRSGI90Vpepk8XWMdonMYEvb5wCiP75K0/87elHeV
         +CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725643194; x=1726247994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo6fqgtuuFE4NzO7fsVL9VZI75GyA9ZRT8MrykdXVx4=;
        b=wnNkBnh7uvHlnziHpvr8xtX3nGAllL97h/xds67vgemtmDHezdFSIJk+zzJIClRSyU
         UKULzGDZk6LFETcIbrTeTRrZ9rzDZm9Wgi+eR+XQJll0e32KA2gIACVTt538yw2o7fqb
         q0Kh3+dMwHDJBxKtmQig6uCSBEKD0EyIEzmH7+TjBqMLUo8EurFvx2tUCIBp6dyg77af
         HLsCU5liJwnRf/qRiTj8vSrvLfbckV11e9sqTNa6xg7Q7vSKA1IHzSOLk43S3obcBc4/
         tPzUwtN90XphJQ5TIcHYzhVvC+ZYH5MAhvBC+wtydgW3RVFkVqAvfFfApoDA45YWbp6K
         2MZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh0K8oZRV0MVVZFcxANJKso+BVR28xtYtnHrQqWif7D7ObBB/gwL7jkQ4QzJoBi4TyFY8mIqVdrZWFhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8K32tavGcTxsrFCBr7XEPdT/6ApD7Bd7YmaYCTXA9A4j4RWwl
	vwU3c9Tf/Gwm58unmBLK7/VlslY2ghjdi2bOg7nXSUVD3D8yDztjTVsTDzTmWLxQLwRifob6Tmc
	q1d+hESUNk6j3/43OINXbNIqZ4MuEQMOXg1PC
X-Google-Smtp-Source: AGHT+IEmGTsFjxloYhTWQXuny7JmM5MPPjtcCFZVfITmMThbDPUbvpM0TFPBX7c3l7gb/TUFCOc+yz8f2fGvO/CXoLo=
X-Received: by 2002:a17:907:25c3:b0:a7a:bece:6222 with SMTP id
 a640c23a62f3a-a8a885bfdf7mr270126766b.10.1725643193288; Fri, 06 Sep 2024
 10:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx> <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz>
In-Reply-To: <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 6 Sep 2024 10:19:16 -0700
Message-ID: <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> I felt it could be improved more, so ended up with this. Thoughts?
>
> /**
>  * kmem_cache_charge - memcg charge an already allocated slab memory
>  * @objp: address of the slab object to memcg charge
>  * @gfpflags: describe the allocation context
>  *
>  * kmem_cache_charge allows charging a slab object to the current memcg,
>  * primarily in cases where charging at allocation time might not be possible
>  * because the target memcg is not known (i.e. softirq context)
>  *
>  * The objp should be pointer returned by the slab allocator functions like
>  * kmalloc (with __GFP_ACCOUNT in flags) or kmem_cache_alloc. The memcg charge

Aren't allocations done with kmalloc(__GFP_ACCOUNT) already accounted?
Why would we need to call kmem_cache_charge() for those?

I am assuming what you are referring to is kmalloc() allocations that
are not fulfilled from KMALLOC_NORMAL caches, but I am not sure how to
capture this here.

>  * behavior can be controlled through gfpflags parameter, which affects how the
>  * necessary internal metadata can be allocated. Including __GFP_NOFAIL denotes
>  * that overcharging is requested instead of failure, but is not applied for the
>  * internal metadata allocation.
>  *
>  * There are several cases where it will return true even if the charging was
>  * not done:
>  * More specifically:
>  *
>  * 1. For !CONFIG_MEMCG or cgroup_disable=memory systems.
>  * 2. Already charged slab objects.
>  * 3. For slab objects from KMALLOC_NORMAL caches - allocated by kmalloc()
>  *    without __GFP_ACCOUNT
>  * 4. Allocating internal metadata has failed
>  *
>  * Return: true if charge was successful otherwise false.
>  */
>
> >> > +
> >> > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> >>
> >> Is it possible to point to the commit that has the explanation here?
> >> The one you pointed me to before? Otherwise it's not really obvious
> >> where the circular dependency comes from (at least to me).
> >>
> >
> > Not sure about the commit reference. We can add more text here.
> > Vlastimil, how much detail do you prefer?
>
> What about:
>
>         /*
>          * Ignore KMALLOC_NORMAL cache to avoid possible circular dependency
>          * of slab_obj_exts being allocated from the same slab and thus the slab
>          * becoming effectively unfreeable.
>          */
>
>
> > thanks,
> > Shakeel
>

