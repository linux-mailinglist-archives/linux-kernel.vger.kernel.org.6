Return-Path: <linux-kernel+bounces-448557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2C9F41C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C612A188E0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF6142E7C;
	Tue, 17 Dec 2024 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oq3OoyoJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C61442F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409982; cv=none; b=g3R7Nys8iRF+n7f6LC/xmVTiO7XyfSaprEp5pabj0JCXZJBmgTbjDSYj1PaGS9LBBn5NDfjKMaheUAUTSKyCCa69OZyAJyU+h9Uj3pbx8RWMiFKsYd7rs5M/FAd5h6DgLOPuksXdbtOBtW1TdCjujX75ABf6kk58F+Ykm5Q3bpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409982; c=relaxed/simple;
	bh=JMxTNOTLT+FZz0cdfUOzaELcgsuyz5fRasxiew6zlZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+dKi+oCHiEr58izr/id1a7yc8gp1a1fSFFCZc3UtikRAHcd9lvf/WsZirS8k8MZ0q2b2nBwMElT68LhXsz+qjBFRHWVeXnMTKxrvYUoGEYNcKekTE9Idnc2DAwXH7xzZ1DnEBGSPGbMr+ufmHioW2SNUcuuzYTRDeR8hOdeCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oq3OoyoJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mwdKcfCFIULPvQgRme/rxFTQjrctWSSEqgxMd/sJ7Qs=; b=Oq3OoyoJb4z382imCKiKPnvw55
	0BqkqdrwqTdwvGm+Z1Foeq7SbgNMOsVz1Y2ruScOLmYNY5GKmtxJ2kC7lUJrra9q9jpr9dlPsYPnZ
	V+T4bpWFuLoOcOC/ZiTsGnYqyNGZVmAF+rqWL5Egst1mAMyu2/JGw/h0jxJJnrvKk/FDDsG2jm+ND
	TmpDgJhZvQQW5ChogL0vEN53ZegPY9vTabil4ErCOJ/dnnThSvHipSf2+21TBkiTMWgaxIsfAVc66
	3b6FqpO5m9poz8WnN4mlmhej69pa829qRA4FQtHLCfVNM+CdRmlOdghLwd3fdm2gsfXcxhDMNbiOx
	ZvV6FVHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNPGB-00000004pWG-3AEd;
	Tue, 17 Dec 2024 04:32:39 +0000
Date: Tue, 17 Dec 2024 04:32:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>, g@casper.infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com,
	kirill.shutemov@linux.intel.com, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
	jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
	hughd@google.com, aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
	wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com,
	surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com,
	zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/12] khugepaged: Generalize
 __collapse_huge_page_isolate()
Message-ID: <Z2D-5y65onX_qOLi@casper.infradead.org>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-6-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165105.56185-6-dev.jain@arm.com>

On Mon, Dec 16, 2024 at 10:20:58PM +0530, Dev Jain wrote:
>  {
> -	struct page *page = NULL;
> -	struct folio *folio = NULL;
> -	pte_t *_pte;
> +	unsigned int max_ptes_shared = khugepaged_max_ptes_shared >> (HPAGE_PMD_ORDER - order);
> +	unsigned int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
> +	struct folio *folio = NULL;
> +	struct page *page = NULL;

why are you moving variables around unnecessarily?

>  	bool writable = false;
> +	pte_t *_pte;
>  
> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> +
> +	for (_pte = pte; _pte < pte + (1UL << order);

spurious blank line


also you might first want to finish off the page->folio conversion in
this function first; we have a vm_normal_folio() now.

