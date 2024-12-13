Return-Path: <linux-kernel+bounces-445340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0379F14D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302D628313D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D801E570B;
	Fri, 13 Dec 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Szo36KE7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC6157E9F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113989; cv=none; b=hIQikO17BXNF6gA6+gI69/dNRhwHtgP6sZCJrDy9gwI5Amr0zq3nJzBvs25tgw1+k2Yobp1c9YUrD4GYvkiE3YQkVW+zFW4kBVn8KQB+/HUHqOvIN8HVj6xzPUkbyFKsaIyZM5p3+wTFBNLZn0KEfIfHxsAxsO7xyGQI5dekqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113989; c=relaxed/simple;
	bh=pBRhGkgZxX0zvUoQiesXTl3MbXRcnvzIGjRjrAAWVBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBN7+qtyMQwAQhptoTrxz6aEBfI8WflaF9FKNp+8VXiV/OoBYmtrB2Z1+Il7sn9Qh0FXFjr8T1rT7j0meAqmVUvi5j4UIP/O49V7/wGxxBpFSBrOvHakc5Q2w8Vuc51OFcYDyJy9wGbnOWlpeVpHDBLPSh0BDTezNnMEA0rgft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Szo36KE7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pBRhGkgZxX0zvUoQiesXTl3MbXRcnvzIGjRjrAAWVBo=; b=Szo36KE7ZNhm73wXRKShO7e9ux
	UDSS8PZfynPyyw1R4y3/X9qj73BvIXwPMen1+yE+HLxQvmj47oMq/hjcgUY8+FQXFG2DwnI0O3AkA
	L+Svbl+w82guGUZxmYEhyx3MgDetTHMXrEO1x/2onPFMDQCqp0fZEwHqnouJWXyYk408NBgl10J7K
	m6wl9OwNsN68fikh8vkVMNGDHLtKUJG1QlPmAupZfZ6kq9fFxpf+Ft0DEJiFYtA0kgfbB6rTuniRv
	IlXKeE+v2DSD3P37ylahyUXQzo2jbARUu5lR5wRMM+ui7OoNdglN/JRcrYHFgh+xeWm2UXg3iAMVG
	KQerXNXA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAG7-0000000EtDL-0PtS;
	Fri, 13 Dec 2024 18:19:27 +0000
Date: Fri, 13 Dec 2024 18:19:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, akpm@linux-foundation.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Z1x6rmsfUjlU5evJ@casper.infradead.org>
References: <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
 <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net>
 <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
 <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
 <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com>
 <20241213095729.GC2484@noisy.programming.kicks-ass.net>
 <CAJuCfpHJn9jLT4zW2vPc4kv-Y3_3BTNXkn7pjFEKLVeFjxL4oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHJn9jLT4zW2vPc4kv-Y3_3BTNXkn7pjFEKLVeFjxL4oQ@mail.gmail.com>

On Fri, Dec 13, 2024 at 09:45:33AM -0800, Suren Baghdasaryan wrote:
> think the simplest way would be to move the definition of struct
> rcuwait into a separate header and include that header in mm_types.h.
> That, with some uninlining like you suggested, should do the trick.

I'd suggest struct rcuwait should live in types.h alongside list_head,
rcuref and so on.

