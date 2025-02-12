Return-Path: <linux-kernel+bounces-510929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27777A323B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DD9188B83E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14720896C;
	Wed, 12 Feb 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PrCf//X2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497820551D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356979; cv=none; b=Uzd9pnyZy6xAKE5mw4fTQRoAZvXVL3EsjmL00iKr8UrYbuji/tyIqfewGl4hz+vwaTvo2tA7bE8sWy/BrbTIQKzUNH3e/y3tQgQdfINyS6XsFy2gamz7Uipt4bJ5arffrV7PPXgK2WlOAGgR77mHw0XEkmKeZjFisEd/wcE5/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356979; c=relaxed/simple;
	bh=rLZME83wY2OLb007OzaDaS2udh4wzEqf9p1nh2pGUTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsHbFqWULZaW9SgQZEpoTJ/yG+dvbDxfKsNp5qwnA2FaEwf/ZI20CFDCHb1sGgSGZ4bvN3GziKtuoLNPwQ8xLB6VEwFMJsesW3kjTKccIwAZpdyHdeNTeduKL0La/Ee75EVH57p6zKfgbXlWaX8NF8ouCbAcEzfMtaGuVKuF9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PrCf//X2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hdmOA94aYPO0cffYrOTR0RQRrJJb4YA7G2s/PyumSjA=; b=PrCf//X2aAucNNXGSkE5cD/eM9
	eKJZ2W0EsKkwJaInHDdTo5u1inOmKjZGyM/7DF/2sTslyaKYO3AaC0lE7fA8KFgIpdJMeO9W1dRs8
	5t5UrgBXN8MyiOO0E/UOgtHo0on2YQFwGsglYhKCGzB9q6SmfZ+WKl32uUkJ/Vcj/P54My0Q0qAkI
	1tPFDJbZuwokmBxILJBAtnbkz1q0fxCF61gDVHEDLgz8wKzZR0SuCWqrLC+qmxOH8phozveTAcQmx
	ArIObh3Aru4xcPzWeEkVRE1t3ZNq6YtoxaqaxvFmvdUD0sipEyYzyePC7rAfMCONV2iCPCPHjOn+H
	fIQ/TH4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiACX-00000004Fym-0ocZ;
	Wed, 12 Feb 2025 10:42:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF6CB300134; Wed, 12 Feb 2025 11:42:39 +0100 (CET)
Date: Wed, 12 Feb 2025 11:42:39 +0100
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
Message-ID: <20250212104239.GF19118@noisy.programming.kicks-ass.net>
References: <20250211210823.242681-1-riel@surriel.com>
 <20250211210823.242681-10-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211210823.242681-10-riel@surriel.com>

On Tue, Feb 11, 2025 at 04:08:04PM -0500, Rik van Riel wrote:

I poked around at this function a little, and ended up with the below.

As to your question if any INVLPGB capable hardware needs PTI; the
answer is no. No AMD machine needs PTI; but it should still work, just
in case someone needs to test something.

static void broadcast_tlb_flush(struct flush_tlb_info *info)
{
	unsigned long asid = info->mm->context.global_asid;
	bool pmd = info->stride_shift == PMD_SHIFT;
	unsigned long addr = info->start;

	/*
	 * TLB flushes with INVLPGB are kicked off asynchronously.
	 * The inc_mm_tlb_gen() guarantees page table updates are done
	 * before these TLB flushes happen.
	 */
	if (info->end == TLB_FLUSH_ALL) {
		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
		if (static_cpu_has(X86_FEATURE_PTI))
			invlpgb_flush_single_pcid_nosync(user_pcid(asid));

	} else do {
		unsigned long nr = 1;

		if (info->stride_shift <= PMD_SHIFT) {
			/*
			 * Calculate how many pages can be flushed at once; if the
			 * remainder of the range is less than one page, flush one.
			 */
			nr = (info->end - addr) >> info->stride_shift);
			nr = clamp_val(nr, 1, invlpgb_count_max);
		}

		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
		if (static_cpu_has(X86_FEATURE_PTI))
			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);

		addr += nr << info->stride_shift;
	} while (addr < info->end);

	finish_asid_transition(info);

	/* Wait for the INVLPGBs kicked off above to finish. */
	tlbsync();
}


