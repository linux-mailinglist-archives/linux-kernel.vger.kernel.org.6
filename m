Return-Path: <linux-kernel+bounces-339502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A728498660C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CACD286D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED38825;
	Wed, 25 Sep 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PtPo8yWF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB64A00
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287173; cv=none; b=WIDHz6PPEEeqFFpabAp/mVb22v8TVIXs9BS7F8LITzuvUh5MCr2vyrqmgXcrMnHkehXW2I5MXFqsivSHI5YxASQTSX0lLRnyQi3MM0oYQ6MBmO13m6L+dMX0jNueZOnvHEnrOriHL+SkbE1BHdHixyevu1V+LnXhKW98Xugqk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287173; c=relaxed/simple;
	bh=S27+PQigGwn/uwVzauqTHj3CN5NguW8JAb8aUz5J68w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCVaSrDJFiV5Uq+YdPhxwZZdVsBU3Xk81HrydfNKUaySXQqeEQByg3Cz3yjqTuXokj7VS+T7NASyQuhRlWnmhXTD3VkqyIeCBBcMe8w3Yj5kOPtvV+XOoXKgifj5lbsKmV7V/1vJGLtdj1k2pdLNrW/Ct3BTlp+re4g6gyNcyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PtPo8yWF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rLHmpQDjNbRe8Fs3fE9dshz0/EVZgppn8nMr2Vj7AXc=; b=PtPo8yWFySOnUSC27T8ubZRbrg
	d2uEUjme6SMF+IBm+BQTO16RCCKBDeOAp0zd3x8u9V6EM5wZpWY8DKUmYszH9T7FrHTl9tOO2Ie33
	WyLj1yRm65zV9AUenHKqvPiYIpAq69UJRRbEIH3YTmEB+mz61tvgEEd55hFESkxYk8G9Ca6TEfcm3
	VgrLyvAW97jIEGQ+Tv97t2Ud7nLQBAbxkjY/DPcpBOZ7xMdjJPd+7xLVtr/4Ow7+ct2iyKeXVfp+D
	HtAs0tSDYr740tJv+1KVZe/qJeEwOLoSyw04u7VB5Uz0h0C2wXUV9teG4hGKRh7G1ajl0VC3ZcTOu
	urB/DvUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stWIQ-00000004Xkf-1br3;
	Wed, 25 Sep 2024 17:59:26 +0000
Date: Wed, 25 Sep 2024 18:59:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: lsahn@wewakecorp.com, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmzone: remove redundant exception handler on pfn_valid()
Message-ID: <ZvRPfiS9KTi7NPV4@casper.infradead.org>
References: <20240925155540.4087150-1-lsahn@ooseel.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925155540.4087150-1-lsahn@ooseel.net>

On Thu, Sep 26, 2024 at 12:55:28AM +0900, Leesoo Ahn wrote:
> 1). It can ensure the upper PAGE_SHIFT'ed bits of PHYS_PFN(..) are clear
> by the C11 standard:

I don't think you understand the purpose of the code you're removing.

> +++ b/include/linux/mmzone.h
> @@ -2028,15 +2028,6 @@ static inline int pfn_valid(unsigned long pfn)
>  	struct mem_section *ms;
>  	int ret;
>  
> -	/*
> -	 * Ensure the upper PAGE_SHIFT bits are clear in the
> -	 * pfn. Else it might lead to false positives when
> -	 * some of the upper bits are set, but the lower bits
> -	 * match a valid pfn.
> -	 */
> -	if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
> -		return 0;

Let's assume that the pfn being asked about is 0x8000'0000'0000'1234.
The actually valid PFNs are only 0-0x1000'0000.  This function should
return false.  With your change, it will retrun true because it'll
only check the bottom 52 bits, and ignore that some of the top 12 bits
are set.

