Return-Path: <linux-kernel+bounces-317733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391596E2FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40057284891
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A418D655;
	Thu,  5 Sep 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SwteEs9r"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFE158DC0;
	Thu,  5 Sep 2024 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563910; cv=none; b=sA5ZYN1HwRWNtlfsOrV4F67eObT6THANybJYQT1h0xp8ApEkWtt+25JXXuvzaDGWUY4rzQCEumKL8MDsTSBRW3RqwdhJ7y5Dn/ZBMGdvJIqEtfb0lHI5GIjz1NkbgMHVgBhcgzKL+Vk6LLMEQepeQPRFUjEoVnw6k/SM3cCm4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563910; c=relaxed/simple;
	bh=nBonMH5MSyjDBzh0luecBwuGHg1CRbhWnpfAvFU5SCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYc59EFXQ+xolndQxeowFEp6Q1AUrE248oVtLAIVJk7XeK44Jti3FCtBrLSNjt5otFxBzkgAFdotAOeYVHoe4dkI7yozPlGfnPcby+nqrCZzI2gatysZu8Ed8IB54s3BiUW2L/KIMO+hc/T6rQ7ei9yQ65m1WEDFHLE64ZIEYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SwteEs9r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c5rxElpuWcu2fC87pycRobCVmahvYpj+jmA375ccp0M=; b=SwteEs9rB8WhPW1DYHne1fm0NL
	9A+2982zcLNwcTQJb95/eDNSRUPynokSqwoFo4OwD6CE/NIuqaUNm4GMbmNiw4pk1C+/qQJXbARZ3
	1mRf+eTnP4kIFpMzA3s9yMLvMrpbIdFkmcmRccddBDiLfXJIRk7tFED7rG0B3jVmkW0LMwZLQ4cyo
	xnFcEWMCMlvjCEhRSKPoU9VdnXAhRnhqG3fxwz5mOJxE3XRDjujLjjGzQbbStrPbc7n1WNM3fKGfy
	yz/+U7C4NDMWryMvFZgnTPYy7t6zcnKxClpI60G+ETeAPFS4Hw1gnc/V+2q4ySew+1v8Deg6B/7aC
	IBBBIAOA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1smHzi-00000002rXa-3JNT;
	Thu, 05 Sep 2024 19:18:14 +0000
Date: Thu, 5 Sep 2024 20:18:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, oleg@redhat.com,
	peterz@infradead.org, wangkefeng.wang@huawei.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] mm: move mm flags to mm_types.h
Message-ID: <ZtoD9tXJjWaS4liX@casper.infradead.org>
References: <20240905152622.1205046-1-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905152622.1205046-1-sunnanyong@huawei.com>

On Thu, Sep 05, 2024 at 11:26:22PM +0800, Nanyong Sun wrote:
> +++ b/include/linux/mm_types.h
> @@ -1485,4 +1485,85 @@ enum {
>  	/* See also internal only FOLL flags in mm/internal.h */
>  };
>  
> +/* mm flags */
> +
> +/* for SUID_DUMP_* above */

But SUID_DUMP aren't above.  They're in a different file.


