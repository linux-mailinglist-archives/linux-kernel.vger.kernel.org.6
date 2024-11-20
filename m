Return-Path: <linux-kernel+bounces-415208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6D9D32ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD1D283C04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95014F9F9;
	Wed, 20 Nov 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rTcFiBon"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680F1876;
	Wed, 20 Nov 2024 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077410; cv=none; b=mC/cB5QCVLnlvAQAxwKITRGrBkjbUbsjXAnbK4KbivOwJdP5TSVLIMV89DMmZeqv0IHI+ye+8UPVk4lHG9YGvZgB/fhCWhsAkT258Ycx+DeclJquJmUVRN2AaUuEI0LqyUiiWQeC4r5ZZxmLIB6D+GPcBhHm1ZIta7uW4WNjJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077410; c=relaxed/simple;
	bh=u3cJ+kTAplTiPagMEGJTEea7cri1tk2vilCSJ3kTZ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDq1m0pIzE/iwa6IqabVCyxnSOF753kTA/9Ou2iYuVe3QUJWJxAGkh1kRZQ5E3ETZRBFezptbwLzuiKSHA5JGWR/ZyPY67sb++skIrDvtrsFUM1CpAQn/KV6UgvcrK7qALIJbKLvBRKr9CTwqCm9R8j6Okbr0g+Vmg32gmmTlIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rTcFiBon; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g8h0TAWx5uACRJYvqYwby+uO/66kiFRWyXgXzvRwZ2s=; b=rTcFiBongOBU8vmtfzD6jJDW6b
	58a5fNuCWm+VBgCEIaEEWj8KFQDt1Jk+wXKZbSoE1h0CLR+I2hdzW0AO2bZ3PkhnclKAXwLSk13Uu
	A6qKGMRdZme1QXT6SX0W6wfHDoRrRz/w7jmwG8lmqwfPFajDp4yeLBJoR4vjgSLOhiHJimZ+5bC3M
	UznvVLOP162zMY3O0dZteKO0WrE7xMvmRhFHq8nORWnMgO/TWHTDMl3PZOl3eCHVduscDA+6Zucwe
	fetBzUUwVcEitRSY5e+XR1+U8nu9lqYy201yVZ/8oLep68nhm6xeVz0qtNGjTSq5htWAQhc89eS18
	7AYQGYOw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDcRz-00000004quV-3R4t;
	Wed, 20 Nov 2024 04:36:23 +0000
Date: Wed, 20 Nov 2024 04:36:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <Zz1nRyMnIaCa0TL5@casper.infradead.org>
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120000826.335387-5-surenb@google.com>

On Tue, Nov 19, 2024 at 04:08:25PM -0800, Suren Baghdasaryan wrote:
> +static inline void vma_clear(struct vm_area_struct *vma)
> +{
> +	/* Preserve vma->vm_lock */
> +	memset(vma, 0, VMA_BEFORE_LOCK);
> +	memset(VMA_LOCK_END(vma), 0, VMA_AFTER_LOCK);
> +}

This isn't how you're supposed to handle constructors.  You've fixed
the immediate problem rather than writing the code in the intended style.

> +static void vm_area_ctor(void *data)
> +{
> +	vma_lock_init(data);
> +}

After the ctor has run, the object should be in the same state as
it is after it's freed.  If you want to memset the entire thing
then you can do it in the ctor.  But there should be no need to
do it in vma_init().

And there's lots of things you can move from vma_init() to the ctor.
For example, at free time, anon_vma_chain should be an empty list.
So if you init it in the ctor, you can avoid doing it in vma_init().
I'd suggest that vma_numab_state_free() should be the place which
sets vma->numab_state to NULL and we can delete vma_numab_state_init()
entirely.


