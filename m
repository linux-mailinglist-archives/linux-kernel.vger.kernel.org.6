Return-Path: <linux-kernel+bounces-282620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BFC94E686
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08AF1F22152
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A714EC4C;
	Mon, 12 Aug 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqlNrp2C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F627457
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443901; cv=none; b=bdd8wwNEjo7tyZDDAHcXD1l1zw8ufCODGaO9XjT8jtp9BoGGKA9zx2AR1st9wwXoWD2cLpMkkGy0RuuFZeRUul+F5U80T7AZvoX8MqGF0pkGFV+WN/PGChdDSGxPz4EsAN5NCugfZ7ig+nyuUKEcKNn+WxvcpVj2Hm02l61oUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443901; c=relaxed/simple;
	bh=ZcHs4sGuK00d0/wvxniMPB/um4ek/IGJu2PumeOzbPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBlmwkYtcpxcoOHVbODlSyFccTZ1Wzw5mpPTAD1Na9mmDh1ILmliPfutXU43coc5ILRGQ2uEvHbLljkz/8jLMBbwU3SNYfSPljYm40T1GI8dFlTgh37nX/eXp/4W05ezI5AfPp+cxv7Yshgbwc+IZdD44nNbw8JjgChy24lHZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqlNrp2C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723443899; x=1754979899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZcHs4sGuK00d0/wvxniMPB/um4ek/IGJu2PumeOzbPQ=;
  b=PqlNrp2CeqHeMuQNZP4zkVt1aIORjoXUGLUkwN2ZL3C+LdNPy3kCXkoG
   bFJ1PVCvTnNiaJsY+KSmsq9M+wvd1jv7GJopqbAIQB0X0NXMXq2qVX0dy
   4HL3l7VI6gk+B3ZVlEXMa21lr8aEJpgtsYgKcgjHli/UQmo6O0OocRSZP
   eZ4FjAjKUZUbQB7o+vg+zoIV4X2DY+ENKlNKruMQXrjRor8Jw2rMbVh1W
   VuDZuwRt4+8dUgVi+972c7YIVi+B9hp2OvF3lk+mTAHX28Y4gHQ4cqZhL
   aBeQdvR1ROpT4pCQWEDnvCnQ6PAxcwDglfVQ4IGTh+QkuCbgIZNiz5RJF
   g==;
X-CSE-ConnectionGUID: uQRQSl8wTHS+XB1RFjgIkQ==
X-CSE-MsgGUID: z5WBtCRSTAaNryHLRkvlOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21664995"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21664995"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:24:58 -0700
X-CSE-ConnectionGUID: I+lUIlELTJKI6YHZtUa6Zg==
X-CSE-MsgGUID: 5gfP+uEKS6uYmr3PjYROrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="81392471"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 11 Aug 2024 23:24:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E81D11F8; Mon, 12 Aug 2024 09:24:53 +0300 (EEST)
Date: Mon, 12 Aug 2024 09:24:53 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/8] mm: Accept memory in __alloc_pages_bulk().
Message-ID: <5aqorjb62kozvqehdw5ei6ov4gol6kcu72mteqso7v72jvnrgn@gdgpyjhhz65q>
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
 <20240809114854.3745464-4-kirill.shutemov@linux.intel.com>
 <8640d12f-e4b4-5bd1-b772-6aae5e5ef972@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8640d12f-e4b4-5bd1-b772-6aae5e5ef972@amd.com>

On Fri, Aug 09, 2024 at 10:31:03AM -0500, Tom Lendacky wrote:
> On 8/9/24 06:48, Kirill A. Shutemov wrote:
> > Currently, the kernel only accepts memory in get_page_from_freelist(),
> > but there is another path that directly takes pages from free lists -
> > __alloc_page_bulk(). This function can consume all accepted memory and
> > will resort to __alloc_pages_noprof() if necessary.
> > 
> > Conditionally accepted in __alloc_pages_bulk().
> > 
> > The same issue may arise due to deferred page initialization. Kick the
> > deferred initialization machinery before abandoning the zone, as the
> > kernel does in get_page_from_freelist().
> 
> Is the deferred page init issue an existing problem? In other words,
> should it be a separate patch with a Fixes: tag so it can go back to
> stable kernels?

Yes, it is existing problem, but the problem is transient (deferred thread
will add more pages) and there's fallback to __alloc_pages_noprof() which
knowns how to handle deferred pages. I don't think it is worth
backporting.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

