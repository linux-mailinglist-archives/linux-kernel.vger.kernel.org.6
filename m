Return-Path: <linux-kernel+bounces-407727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4299C71AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA46E1F210B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3E200CA7;
	Wed, 13 Nov 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEMFFIeJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37641DF272
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506254; cv=none; b=IW0m0yTvjB/UiRj0N7xBXtCBu9YYicwSrccGEdGpTCf1ZzvkxPD0UbwX9zJc479cdz/dtRyIYSCaBGVtmM05QcjBw9pirSpUieWPmRDvLNH8OQk/0o/CC0nxk3Jm3wu0TYXIo26L2alwUb8Vgx0Zp8s1UR4/sGnLfANFe5pX4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506254; c=relaxed/simple;
	bh=WqFQ6Y/VVVjuY5/sPjq6XfNnpFe3lVsNKk8kU7pNkq0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFEmhHxfrqjLCMmFBTzqeBxgQuHWgx7EDWWGdQAtkWWVf31maLxZ4RmY3QAVvjRpgG9xVH7JXIspgmYs6vRRNhRrFKwTMhzZeTqIrwtdPWYjnUaJWe508NdIT+u9dbBE6WCRlcZf8LFJcci/Lr9GysnUX6qaW3Z62Rl2+TWeZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEMFFIeJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LhLy5/26EMLDoklyW8LXQa4CH05PL24LL7bv1JpxLxU=; b=oEMFFIeJ2IxPSv3AUaG6msqMy8
	ywuSi3ewa0d7eB8HwonQP2rvY+AFDCn5TU2n9amC8DS05wAnNZ7nER6OmxOPMgWXPer6lxb297ELJ
	R+y3y5v7sYsaJnkx0HHdAoOjD+JHCA/GiNuwaOtJ3qj+KD1lrASlq+lWrtErAaf/EF7AJoFF1aJUw
	qeAqX8grqTlCPPQ27MTt9jkHcbTdms7J3zDtRYe/QjODX8jQuVgOJulIzKlWS6JT59xa78+U2soru
	qEmN2QQUfesiWVAMrHmqlMaybLz6xtUQGCNtsbEvTNEfwTCNdO5DGKWsr/M4jtJvquFhf4uFOn2Hk
	RN88gokQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDro-0000000GQdN-0TVH;
	Wed, 13 Nov 2024 13:57:08 +0000
Date: Wed, 13 Nov 2024 13:57:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <ZzSwM5qwStadOZvv@casper.infradead.org>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
 <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>

On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > Hi, I was wondering if we actually need the detached flag. Couldn't
> > "detached" simply mean vma->vm_mm == NULL and we save 4 bytes? Do we ever
> > need a vma that's detached but still has a mm pointer? I'd hope the places
> > that set detached to false have the mm pointer around so it's not inconvenient.
> 
> I think the gate vmas ruin this plan.

But the gate VMAs aren't to be found in the VMA tree.  Used to be that
was because the VMA tree was the injective RB tree and so VMAs could
only be in one tree at a time.  We could change that now!

Anyway, we could use (void *)1 instead of NULL to indicate a "detached"
VMA if we need to distinguish between a detached VMA and a gate VMA.

