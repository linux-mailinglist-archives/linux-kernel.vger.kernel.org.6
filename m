Return-Path: <linux-kernel+bounces-520799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C3A3AF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49E067A5C08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5B14D70E;
	Wed, 19 Feb 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/od2t+e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406D54782
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931136; cv=none; b=RKj6fKzgkhC5GeVotUvFP33A1WtPYuy61m9F5+ohF8doBxMlTlL8EW6NSvThDiHhFI0jMkgtMv5Pm/dLD/lTPMdNV7kQa7Oy9WXtb+9UUeWrwZ/Z4D/+Po3K6YcvMjPUOFDYQHdrsejwoXURIc3k5g1A6niemnI5ZfuLiV0l7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931136; c=relaxed/simple;
	bh=hZyf9TPR7iNSzIpbiEBIDQ0zKNM4n86uggz2BmYb2VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPTVQrvpHiM7rZfdMpOfnVD7auxTIAcolZlaZ++2+LTauT/818qJMRKE8azCarfMxTEYdR8BvbiDMRYAJiGl6/l47f0hLYDHDL+g9+pmLeBhvAmlLlKATSgLOx+ZaS9kaBfVGeo/OzXGUfv+j3MHYMteiZGjmfMSG7KjFw7viRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/od2t+e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739931133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0P5Gj4WhipWloYam1SLmuS1RQMkBOTimmYouu8iJ04=;
	b=R/od2t+e0Isa0dArWO7VeKi3KFdFL+uL2ukZ/bv58pCtaR5EoN05Rdzgleazw0CVnLizRe
	SXWp4y/7egFLoJ/a6BlCmkWKNcRJq2boeNiSydC7lmaBfOfI6HzmSDGRXGQ4pAuJidquj8
	sDfKs6Zg3rIn6StdzJGis4jvK6dyL60=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-p777GerLNJSMbRYcfAJlvg-1; Tue,
 18 Feb 2025 21:12:08 -0500
X-MC-Unique: p777GerLNJSMbRYcfAJlvg-1
X-Mimecast-MFC-AGG-ID: p777GerLNJSMbRYcfAJlvg_1739931127
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00C02193578F;
	Wed, 19 Feb 2025 02:12:06 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A9271955BCB;
	Wed, 19 Feb 2025 02:12:03 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:11:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm, swap: avoid reclaiming irrelevant swap cache
Message-ID: <Z7U976YLdk0AbITJ@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-2-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/15/25 at 01:57am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Swap allocator will do swap cache reclaim to recycle HAS_CACHE slots for
> allocation. It initiates the reclaim from the offset to be reclaimed and
> looks up the corresponding folio. The lookup process is lockless, so it's
> possible the folio will be removed from the swap cache and given
> a different swap entry before the reclaim locks the folio. If
> it happens, the reclaim will end up reclaiming an irrelevant folio, and
> return wrong return value.
> 
> This shouldn't cause any problem with correctness or stability, but
> it is indeed confusing and unexpected, and will increase fragmentation,
> decrease performance.
> 
> Fix this by checking whether the folio is still pointing to the offset
> the allocator want to reclaim before reclaiming it.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 34baefb000b5..c77ffee4af86 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -210,6 +210,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  	int ret, nr_pages;
>  	bool need_reclaim;
>  
> +again:
>  	folio = filemap_get_folio(address_space, swap_cache_index(entry));
>  	if (IS_ERR(folio))
>  		return 0;
> @@ -227,8 +228,16 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  	if (!folio_trylock(folio))
>  		goto out;
>  
> -	/* offset could point to the middle of a large folio */
> +	/*
> +	 * Offset could point to the middle of a large folio, or folio
> +	 * may no longer point to the expected offset before it's locked.
> +	 */
>  	entry = folio->swap;
> +	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		goto again;
> +	}
>  	offset = swp_offset(entry);

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

While reading the code in __try_to_reclaim_swap(), I am always worried
that entry indexed by offset could be accessed by other users so tht
it doesn't only has cache, because we released the ci->lock and don't
hold any lock during period. It could be me who think too much.


