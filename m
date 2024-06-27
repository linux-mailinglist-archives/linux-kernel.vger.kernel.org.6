Return-Path: <linux-kernel+bounces-233058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530C91B1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CDB23EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717941A08BD;
	Thu, 27 Jun 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uWA9M1v4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85D22F1C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524883; cv=none; b=b7C/bjiu6U2UiRhl4zvQPuBhq5x0qkzHjP8DMih////T83WUc11hj6CCVKlV620J4Frg0e4fEhdWz27D/TzlVMNzMdLH3U3/OFFEHZs2J9hBGvX2WafO3MmzTY5kNP0JIABsEMGJSX1kssLiTkMGzDSxHbSWlZ9qNtLd+mkanKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524883; c=relaxed/simple;
	bh=CabZMlpzYqA6GeHq9fDvbC2+c5aC4P0gXZCWx5+Huyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbSBiuGgtr9UTuUw0GHifYy1oB63LKi+aMCMghS0F2KYa+OZB2rAlrhzW03UhFD6dpNnmwlHTvqvfOVR21r51J9LspHT0xbHy5ypHxQtx+Z9obfcMebiXnoynHJrbf/4iz6Xeq1yyHVZr0/atuT5wtTnu8gmENw1tTIfP9iArBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uWA9M1v4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zapy7S8WwWK6NPvn1vDjIz6RL8CxEPi5KJd6spZHc5g=; b=uWA9M1v4YvQeaqND4hpfL7i1SZ
	NQjZHl9R+7oafpJ33Ks49Fs7UskCOhK7bYN9pEZ3f0alQqcYWFSzAYRGePVNZqWKX1JmfEs4dBN1k
	vJ3ADYqcYpVCCDlDMesDmEc0fH8tL++jbT0gh7h+e7MLHWdrrWpWcql86wjBG+QDng7uWNoomUJ45
	fcpJeGkhdRbmflp7pA1eQcB1YfVm9fRUqE4ML2FfaD8gLhgoeBrokdc0jlZzD0G2wzo9WyRluou0X
	qRcw2PeCJAlZ1MpD0vB62In+xVKEx7cQWfjJkJeGzX+4uyqXCQ4GH6UkgclqKvh8mPuttJSsLJyC6
	1eXX9cWw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMwy5-0000000DygY-1c52;
	Thu, 27 Jun 2024 21:47:49 +0000
Date: Thu, 27 Jun 2024 22:47:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the balancing
 mode
Message-ID: <Zn3eBbJ377VeZGcc@casper.infradead.org>
References: <20240625132605.38428-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625132605.38428-1-tursulin@igalia.com>

On Tue, Jun 25, 2024 at 02:26:05PM +0100, Tvrtko Ursulin wrote:
>  		/*
> -		 * Currently, the only defined flags are mutually exclusive
> +		 * The below two flags are mutually exclusive:
>  		 */
>  		if (flags & MPOL_F_STATIC_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "static");
>  		else if (flags & MPOL_F_RELATIVE_NODES)
>  			p += snprintf(p, buffer + maxlen - p, "relative");
> +
> +		if (flags & MPOL_F_NUMA_BALANCING)
> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>  	}

So if MPOL_F_STATIC_NODES and MPOL_F_NUMA_BALANCING are set, then we
get a string "staticbalancing"?  Is that intended?

Or are these three all mutually exclusive and that should have been
as "else if"?

