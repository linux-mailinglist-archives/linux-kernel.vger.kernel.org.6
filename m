Return-Path: <linux-kernel+bounces-538934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C9A49EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C130316180C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1E271815;
	Fri, 28 Feb 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ovGoa2vf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9A25F974
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760569; cv=none; b=I5Nj24pW4ND3sw6M/p4bKohklXktCUH41wa4Tt+WR2f9qkYM0UCz+MRFnVgq+HuD8PFG3YY18V4VBxoPBses0pSjZpof9buDeDDew8DqD/BjFyxICUjlWaEWTutCZ9tjEN/O+PE2SQBvyeHfBryKf2541vcaXf98/ao2s4hc/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760569; c=relaxed/simple;
	bh=K77CUEtfwG/93Vke5Pk7GR9JF/a9/uvCr7iYeET14t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+52g049uHQ7J3toId5p08JDHqHlaSKhEe3jTsZTmdR9cQpaz1/cVYFjEzhdPIlMe2lmHhjYFbIznfMw4DQZiIetZr/FNb3R4GGgGA0azLsJn8ixWVBcKLxdReEPXW7GvbabF8vT7ZrJjiUmjxTijwfi19Yo+dPDlZpE0ad1/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ovGoa2vf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e9vSoM+7hs95bKdKIg7eM5WyD/pdP0vSTAfr15Di75g=; b=ovGoa2vfaZnp6Y6O28EKx54pAK
	Zj/UuoQrcat4WFUQ+tUC+KgWadHtP4ZC18yJPvdTuzTmlHPmcV+IIamHGRi35wZLrlmMxkHZgXiUq
	0tGOjVRGcubtySli2aoHuDuZKHZF4WQwgp3hj2jGW64zkEUpRRsSzlRcwBtTpoXwdvtumS3/9nrt3
	+jciZIOZboUV35URq/DRdKOR3DPSR7Q91iezreRzK/Xh0syqR/MyrgTbY/QhvmKRUYPNN36vjtXcs
	rCsYOwzZ4jHojdkQvda83BdHrIkPr7Ka5iiCKd7W8KBVRgpX8WeKKPY248Gq8vl5wB2p1GFd7p8aM
	T2+J+qGg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1to3KR-000000033wq-1NiW;
	Fri, 28 Feb 2025 16:35:16 +0000
Date: Fri, 28 Feb 2025 16:35:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix shmem xarray update during migration
Message-ID: <Z8HlvyKod4pbi6le@casper.infradead.org>
References: <20250228154219.2214149-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228154219.2214149-1-ziy@nvidia.com>

On Fri, Feb 28, 2025 at 10:42:19AM -0500, Zi Yan wrote:
> @@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>  			folio_set_swapcache(newfolio);
>  			newfolio->private = folio_get_private(folio);
>  		}
> -		entries = nr;
> +		/* shmem uses high-order entry */
> +		if (shmem_mapping(mapping))

It's be cheaper to check folio_test_anon() here, right?

Also, how did this bug remain unnoticed for almost 4 years?
Our testing is terrible ;-(

> +			entries = 1;
> +		else
> +			entries = nr;
>  	} else {
>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>  		entries = 1;
> -- 
> 2.47.2
> 

