Return-Path: <linux-kernel+bounces-558950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38969A5ED74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCBB173DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC125FA37;
	Thu, 13 Mar 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUnPelFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PcLhGXH5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADD1F755B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852769; cv=none; b=BjJ3pCIBEhKilIuru6GGwLPx4mmkahyhorDK3rVTs2N55NXwplfRfd+wmHmZRQlTIUWbbMV/IeQ/1lbUG8cBpKgtxExRzps1Q/D+1ehAc0slKwQhbb3wFNfIttPJ+4ZTqXmt9Au33dAIyjJFISmaIBD4B52ji3yUlDno7cpDXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852769; c=relaxed/simple;
	bh=e0npNEEjX/utUW3cZBUcJMvYNMAeFt+qoNkbCAFK+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSUvhf2zqUIcswDuabN9I/IpGE9POWESLgfa1Ie7wx5TiD/PEiTqsZWmF2XVnd6hOlwj1K6t14i/shK27D4MeMMRU6nxCBG3zXgar+VG0nHNlz/36UBCGdLpa4D/Rr6M16revbcd2xKy2vyPnbFgOvcNq0qvTW3Ue4W9prNlvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUnPelFL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PcLhGXH5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 08:59:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741852765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsKP8joiC/AFQkri/bU6lzIAtOi6ZEtSVz09/Tvs7uU=;
	b=MUnPelFLHF2+ZJUe6YgeQ7EU/mn9xiiIFm8Yb0qlTvYpect/PnhtRMCDDPjo+7Xo0oTnwq
	BYpbUq9u+PTrxtPUoTYSTqA+iHswg0gzrVBi70IQs0GZM6bSxzdq/cuTIe52J4KggT3OF3
	ksrAkt5axY358I+NiMnvFFaCWG+P/e4TG857Wt67vqnImbPNN6+0pnamxsrd1HWihS7fzI
	7sUdjx2X5rirTgAj24+nxwDix1AKWUCcFU6yJHXuZL3BtjTN3WIWdWmDCWV2191SQ9aoX/
	666MjTvh3FujRVo/KtoSw8qqsksSCopIvY/K5ut+ah9jZLYxtNqLHnbaxHymmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741852765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsKP8joiC/AFQkri/bU6lzIAtOi6ZEtSVz09/Tvs7uU=;
	b=PcLhGXH5Fm2ECNrwOxHtfjfA9b93KJHm76F2MCNyjLR1Cxg7SK9DBRUsTIgEE/ZLT+2Ls7
	aNv2gFWW1gUUe0Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 19/21] mm: Add vmalloc_huge_node()
Message-ID: <20250313075924.qulV64zL@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-20-bigeasy@linutronix.de>
 <20250312150206.54afabcf993bbc55f0066886@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312150206.54afabcf993bbc55f0066886@linux-foundation.org>

On 2025-03-12 15:02:06 [-0700], Andrew Morton wrote:
> On Wed, 12 Mar 2025 16:16:32 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > To enable node specific hash-tables.
> 
> "... using huge pages if possible"?
> 
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3966,6 +3966,13 @@ void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
> >  }
> >  EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
> >  
> > +void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
> > +{
> > +	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
> > +					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> > +					   node, __builtin_return_address(0));
> > +}
> > +
> 
> kerneldoc please?

Okay.

> 
> I suppose we can now simplify vmalloc_huge_noprof() to use this:
> 
> static inline void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
> {
> 	return vmalloc_huge_node_noprof(size, gfp_mask, NUMA_NO_NODE);
> }

Do you want me to stash this into this one or as a follow up?

Sebastian

