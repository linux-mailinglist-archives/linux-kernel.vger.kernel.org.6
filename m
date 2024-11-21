Return-Path: <linux-kernel+bounces-416631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049B09D4808
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2D9B2119B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACED18A6B2;
	Thu, 21 Nov 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lBZcsgJa"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180BBA3D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732172535; cv=none; b=X/D9YXkqyuQFjq0fE83nH2YyTKhwofAT3OrSGJ7nWtsvjmJ8tB2xYiirYMJMApWomV/LFE0/JtR/kQNZXV9B+QX33SZduOyKolTPWduIAOB9yw5TLWcpgMVFwUAlJmBbvhGn53QTWkkc0EH/dvAtZzeAIC3VEj2w0flTJB7kio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732172535; c=relaxed/simple;
	bh=HSGqSmZvl8yCfsKbNauklbaTlgvSrCw877t+oc1o+sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7K97WLttrwv7o77qI+56MvR5RlqJXvMELnDChOEVvrEZ5uvmS+KcMDNHcTxFjZNjEO41Q4GMYxQCAmHy+25bG+FbpbLmEcrUjEqLKYYpJGsoYRE8kVmb+k1FaOwTyxBV4l3vJpXr5XYFHBkNDA5FUKj2uDX1FQCOtcHYE/QokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lBZcsgJa; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 23:01:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732172523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap95Q1nsWIhzVEIGy3SKI0y8bEU8NHJzB+owS7s7oFk=;
	b=lBZcsgJaHZ1iWQ8HkxNDrrNGu46xUgydVslYoZefgOefdLNNgQXSiMrR3U4kGlmy6XN5aC
	Qq76DHM997dZqvp4ODH3lmWODeOLVfPBVgKaot6jk1xdzcT3t/uVsvtI/V00eIvM82Zo3n
	Fe6dQhbXnC6OTbsfivkffvcSJA2Gp3c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v4 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <iw34akksaz6wjlygwuztlkvto3aiduekrhw6rjlqq4lr7vzmug@tprkddvgrj3e>
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-3-surenb@google.com>
 <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
 <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com>
 <wnwfgk32wyvx7tzd522ajwk5uixls7iayksrtho6c3dkvgdpek@25yqv3ohljzc>
 <CAJuCfpGx6LCd7qCOsLc6hm-qMGtyM3ceitYbRdx1yKPHFHT-jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGx6LCd7qCOsLc6hm-qMGtyM3ceitYbRdx1yKPHFHT-jQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 04:33:37PM -0800, Suren Baghdasaryan wrote:
[...]
> > > >
> > > > Do we just want 'struct vm_area_struct' to be cacheline aligned or do we
> > > > want 'struct vma_lock vm_lock' to be on a separate cacheline as well?
> > >
> > > We want both to minimize cacheline sharing.
> > >
> >
> > For later, you will need to add a pad after vm_lock as well, so any
> > future addition will not share the cacheline with vm_lock. I would do
> > something like below. This is a nit and can be done later.
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 7654c766cbe2..5cc4fff163a0 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -751,10 +751,12 @@ struct vm_area_struct {
> >  #endif
> >         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> >  #ifdef CONFIG_PER_VMA_LOCK
> > +       CACHELINE_PADDING(__pad1__);
> >         /* Unstable RCU readers are allowed to read this. */
> > -       struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> > +       struct vma_lock vm_lock;
> > +       CACHELINE_PADDING(__pad2__);
> >  #endif
> > -} __randomize_layout;
> > +} __randomize_layout ____cacheline_aligned_in_smp;
> 
> I thought SLAB_HWCACHE_ALIGN for vm_area_cachep added in this patch
> would have the same result, no?
> 

SLAB_HWCACHE_ALIGN is more about the slub allocator allocating cache
aligned memory. It does not say anything about the internals of the
struct for which the kmem_cache is being created. The
____cacheline_aligned_in_smp tag in your patch made sure that the field
vm_lock will be put in a new cacheline and there can be a hole between
vm_lock and the previous field if the previous field is not ending at
the cacheline boundary. Please note that if you add a new field after
vm_lock (without cacheline alignment tag), it will be on the same
cacheline as vm_lock. So, your code is achieving the vm_lock on its own
cacheline goal but vm_lock being the only field on that cacheline is not
being achieved.


