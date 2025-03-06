Return-Path: <linux-kernel+bounces-549658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9FBA55524
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ABC3A51ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A377269CE8;
	Thu,  6 Mar 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LoVsEZnq"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640B619D08F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286180; cv=none; b=HW1+H3nT56QdxWLUTzFQlAvax/LK9+BW1s1T/L0AOg4M/rm9nSezMWlAmqvoZ0pn2Zp0vcXBsr/+ni8Q+zMnpegImPVEroNve0FrWvVCg7eMuA9m4PjRg3rBLizkujcpf+GyQDtzX8HRdG+lMzGd+I0m4qOP4EipetQCzGYgdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286180; c=relaxed/simple;
	bh=htYD+VkDSkTduFLStKehHLOR1lFI1vbQeT7NCBbGpTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reD7GkoC9sTd7MX8QJMgkZXjF0j+ndApAaAUcOA2iCceNTQrib1ljVuwgKZwyCLbkMXjw80rbULPUskjSCOUYnTexrSnYQiyBEj6r8l/MHmu53bPHj4zJOsr7Zm7OXxeu4QIo26K7kJAOpeNl/MbNmttmRpOEThF/kdwrHkJWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LoVsEZnq; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 10:36:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741286173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wpm85dJS6CWnCc9LTcorLxfeCKdvOrtUzOT/4F/NbAk=;
	b=LoVsEZnqwLzLwU0o9A55FFDDWXz/JBM7U1pu7zbRaH7d+MCWd4yDT0wJdX/eRDp2xgiJB+
	zUeTvKm8C7K9WquuKUhFWMfKTJN/hMf1C3Nj+OgaqoKO0CzKeYFGl1vy4m9r/y8rp9/jBZ
	dC6s57pZf0fKa4k1y9ZmN/K+nl7Axbo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 10/16] mm/madvise: let madvise_dontneed_single_vma()
 caller batches tlb flushes
Message-ID: <hacxdm53iyd3xevvzcap65mtg5rgtwlpzur3q4lj5qjeejcht5@rnhloth5o3c5>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-11-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-11-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:16:05AM -0800, SeongJae Park wrote:
> Update madvise_dontneed_single_vma() function so that the caller can
> pass an mmu_gather object that should be initialized and will be
> finished outside, for batched tlb flushes.  Also modify
> madvise_dontneed_single_vma() internal code to support such usage by
> skipping the initialization and finishing of self-allocated mmu_gather
> object if it received a valid mmu_gather object.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Please squash patch 10 and 11.

