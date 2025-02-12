Return-Path: <linux-kernel+bounces-510902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20DA3236C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167AC188957D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2702080EB;
	Wed, 12 Feb 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iPKiqLsW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC891E500C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355790; cv=none; b=uvE2MAbnszayoYk5P5av/1URk4TByKhdBo+fmR9gNAAvgZ/WwY/ZUBWE5qiB+sFlZZ3tXRF0u1hiR75BznJiLzKi2WsfHIZK0ImbZsxCdrarfio1qob7oVubPU7Xu3EZDSHAVwk2fvget/TV0lN2O9WUG1jAwk7eOAQ4hXfYB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355790; c=relaxed/simple;
	bh=lsH+vgqlhsRJ7Z/449muYLAhD57q4dhfhf3vZL+cRaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2JSk4Ezl/lmZ2E25QKC/tZGKhKgrZd5O4Y+gMDL2uJY3Sr4pk2atFrKVoRyfRvEKgYdvwlYHYgXcKhBRxd8vU/q7LSf/VP7tsiRPtWlVBbiVeOr3JHWRJ3vrOhjlS7fCvFXedcPNzLLAgGusyGCRrT58eXiVfyEv4Y1Ge3LjHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iPKiqLsW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DlhjYzhTOJoc9WT6ycPlrW3tR0dtUeVHkM7mEliMgS8=; b=iPKiqLsWgZFonVsI2rfvo/DjEc
	eYmUwp9Q8zC8jDUT7z/V4F8q2Rabl40NVj+4u/DQ0jkdRigJcIPogLElWT14PkhcF+60Vj3on/E6c
	qrHGhQwxbsKXKzWjE0nvN8nTrYu8FxPRiGjpZ4fmhza9Tj3qRvu3csKrQTr/z2AHKeile92QsHQuZ
	e4n/ShYvVa6wZBHpxS1RBKQ9gQvagzbQcIkCinmyOdDFR453cdxQ/jrEwB4HdtjhblmGYbh/rs8Sr
	V3pyXHFZnRg6kgbzzG5O25Wf6a1LLIn4xw1n6yqJYlnc/k3vDqtrLsfEfiN4vK/zEZRJoMbFn970n
	DfyLyUuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti9tE-00000004EIe-0lYC;
	Wed, 12 Feb 2025 10:22:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB30E300318; Wed, 12 Feb 2025 11:22:42 +0100 (CET)
Date: Wed, 12 Feb 2025 11:22:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v10 09/12] x86/mm: enable broadcast TLB invalidation for
 multi-threaded processes
Message-ID: <20250212102242.GB24784@noisy.programming.kicks-ass.net>
References: <20250211210823.242681-1-riel@surriel.com>
 <20250211210823.242681-10-riel@surriel.com>
 <20250212095438.GC19118@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212095438.GC19118@noisy.programming.kicks-ass.net>

On Wed, Feb 12, 2025 at 10:54:38AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2025 at 04:08:04PM -0500, Rik van Riel wrote:
> 
> > +static void broadcast_tlb_flush(struct flush_tlb_info *info)
> > +{
> > +	bool pmd = info->stride_shift == PMD_SHIFT;
> > +	unsigned long maxnr = invlpgb_count_max;
> > +	unsigned long asid = info->mm->context.global_asid;
> > +	unsigned long addr = info->start;
> > +	unsigned long nr;
> > +
> > +	/* Flushing multiple pages at once is not supported with 1GB pages. */
> > +	if (info->stride_shift > PMD_SHIFT)
> > +		maxnr = 1;
> 
> How does this work?
> 
> Normally, if we get a 1GB range, we'll iterate on the stride and INVLPG
> each one (just like any other stride).
> 
> Should you not instead either force the stride down to PMD level or
> force a full flush?

Oh, n/m, I think I see.


