Return-Path: <linux-kernel+bounces-510856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA9A322E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319AF3A34C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A200206F0B;
	Wed, 12 Feb 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pq0yP9Uc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DB1F03C1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354099; cv=none; b=BJ/RluiI9Sf70dooNGzg4PgOxsaecH+bdh/T2UP3PvpH6QsPWUdHwR7WquUO54v4thdO/HfNpnX3EFHdv+XPxNJFmE8P02xSonhHaUuHxmv0QQnUtDQ8fg+NBXHAeToUZYMvQ2NiYBPy+xcMftPycZby+pFIhaiUgFu9tVeUXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354099; c=relaxed/simple;
	bh=UNgfNFGiapG/OthpbtBmzOD+XNv2vQtibQOh6UhLmNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0HIWu/Jg0EZQmT6TTzSOxdOVBMC4MXHFbSa1MwQ1FyMOOkDShq/zxiuKXGg1/4U60jDerAJyi/Hwe4RTgdl1g/LrNXOxvcMXeUrn/9QjJjJdpnlIG68YOv3w2+j79XnTr5JOrZXHCyvJTCaCNFxKIGv3Lg0t0m6dDvswBRy/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pq0yP9Uc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6c+WjwuOjtZ/tCDydLZsLysHBEZRfMiTVscRPlLORcI=; b=Pq0yP9Ucvm22cCmGGU2MzGS7vX
	pnvfMziMyGrKPf+LpLEw5sbsHtTw6kmtptlFPhxfwwCfog8sJkZ2yrluAR9ouMu/QetwtttEb0TI3
	lR6ESkwaqzXKWrb60nxyzjJ0mN9Hq1ZDEeow40V/O4dNQs0amTR6u7R5Doi5XAEOptzSpKmRAfk2b
	oKjE/qMWuTSkL0+fUYpeX1QO2+wCR1Cle5A3MjhW2MV79Skg2QykLcY/pGy02Nq5iXyFIRVhfcCwX
	NAANbHouzC2yj9uUeoBbmAVd6UxSutHSm2lCUw9Fa6/0+O7fhqyk4gB7BD22kIB3Z8lAPf8kQHlAR
	wZS+bVXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti9S3-00000004ByC-13YM;
	Wed, 12 Feb 2025 09:54:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CCE93300318; Wed, 12 Feb 2025 10:54:38 +0100 (CET)
Date: Wed, 12 Feb 2025 10:54:38 +0100
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
Message-ID: <20250212095438.GC19118@noisy.programming.kicks-ass.net>
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

> +static void broadcast_tlb_flush(struct flush_tlb_info *info)
> +{
> +	bool pmd = info->stride_shift == PMD_SHIFT;
> +	unsigned long maxnr = invlpgb_count_max;
> +	unsigned long asid = info->mm->context.global_asid;
> +	unsigned long addr = info->start;
> +	unsigned long nr;
> +
> +	/* Flushing multiple pages at once is not supported with 1GB pages. */
> +	if (info->stride_shift > PMD_SHIFT)
> +		maxnr = 1;

How does this work?

Normally, if we get a 1GB range, we'll iterate on the stride and INVLPG
each one (just like any other stride).

Should you not instead either force the stride down to PMD level or
force a full flush?

> +
> +	/*
> +	 * TLB flushes with INVLPGB are kicked off asynchronously.
> +	 * The inc_mm_tlb_gen() guarantees page table updates are done
> +	 * before these TLB flushes happen.
> +	 */
> +	if (info->end == TLB_FLUSH_ALL) {
> +		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
> +		/* Do any CPUs supporting INVLPGB need PTI? */
> +		if (static_cpu_has(X86_FEATURE_PTI))
> +			invlpgb_flush_single_pcid_nosync(user_pcid(asid));
> +	} else do {
> +		/*
> +		 * Calculate how many pages can be flushed at once; if the
> +		 * remainder of the range is less than one page, flush one.
> +		 */
> +		nr = min(maxnr, (info->end - addr) >> info->stride_shift);
> +		nr = max(nr, 1);
> +
> +		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
> +		/* Do any CPUs supporting INVLPGB need PTI? */
> +		if (static_cpu_has(X86_FEATURE_PTI))
> +			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
> +
> +		addr += nr << info->stride_shift;
> +	} while (addr < info->end);
> +
> +	finish_asid_transition(info);
> +
> +	/* Wait for the INVLPGBs kicked off above to finish. */
> +	tlbsync();
> +}

