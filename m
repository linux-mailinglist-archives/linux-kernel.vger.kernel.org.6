Return-Path: <linux-kernel+bounces-400058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B79C0857
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9A81C20F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48817BB0D;
	Thu,  7 Nov 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdlprGFC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B0624
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988138; cv=none; b=mV0S/i/yCq2HqbN29ZWLStf2ky5mvqt9wnUpPvQ1BN1V6rVT373HrTRI3XsGVitFEVLU2BKMkjBSYfy323p/TdHJ9/Eg3ELywBUXh+jrD4MkD9q67HLp8BwmRiMZIw6cOedW+p1EYfTtO/8r8WbkCeDZkWac2vxglLeQ0Dc0GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988138; c=relaxed/simple;
	bh=yJYYPePum8cIA056BwOBhVe3QDck73FZlN7SmN1QJys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdTxMgLmdSMPzu1q79j1HbFXQiPE7RVhG0RosO1ed7U5myrpFskfQGFQ+xsTLDSRaG6aKWE2suFHkdZAgHsCXHxS5vxSmEHPVE9Bc6ave0Szvd3O7IEWWhrZDkq2+8DNX73QEN2vgJ+s5s+cEzqxTV2Slk84jEUPWSZUsnvNQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdlprGFC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730988137; x=1762524137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yJYYPePum8cIA056BwOBhVe3QDck73FZlN7SmN1QJys=;
  b=mdlprGFCddCyl186P5IR9g0tTltSczBchBh2jKtmnFLQpJ+7G2Ueziev
   aZfH7M04gfu68mKq5Hos54k4EsBijQpZ/jjx0V22BHfy3R7YZ+vUwbekz
   tslaNtoiETT4lX8/fdF+zJGsWLOQXyv7Ih7nik+/9lVG8kjZBAxd5K6kN
   02mLmF00KeQzS6wiNiiYqcJwcPEScNI+7CLJ0YcH3Yczl0CjUv2Z9GkOl
   TUIOYc1OjqaNpzNu6L3c6QwsF1XpoAk0FJyogN0wSLu5Jij9f254fANt8
   YS1Q0qZVG2iOpKD5eSb/SJp1Wuv5bM54tMTx6RA3+66NNYjDm9rJHgalO
   w==;
X-CSE-ConnectionGUID: 09nlWM0gSWanG/iDq1bk5A==
X-CSE-MsgGUID: hmyWdVbDRjupOmywRV2WFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30991737"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30991737"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:01:56 -0800
X-CSE-ConnectionGUID: jW91S61CQfq0QrEGFcd+rg==
X-CSE-MsgGUID: o9oxC44xSYulr9rfkghFuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="84620825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 07 Nov 2024 06:01:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C997A800; Thu, 07 Nov 2024 16:01:51 +0200 (EET)
Date: Thu, 7 Nov 2024 16:01:51 +0200
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm/huge_memory: add two new (yet used) functions
 for folio_split()
Message-ID: <yu5u6srhyixvnx66qvin3rk5p3ve4yxu7v6qj4ymma3fnbk4fg@yneglqtwpvyc>
References: <20241101150357.1752726-1-ziy@nvidia.com>
 <20241101150357.1752726-2-ziy@nvidia.com>
 <e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2>
 <C9096636-C91B-42C0-A236-F3B7D9876489@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9096636-C91B-42C0-A236-F3B7D9876489@nvidia.com>

On Wed, Nov 06, 2024 at 05:06:32PM -0500, Zi Yan wrote:
> >> +		} else {
> >> +			if (PageHead(head))
> >> +				ClearPageCompound(head);
> >
> > Huh? You only have to test for PageHead() because it is inside the loop.
> > It has to be done after loop is done.
> 
> You are right, will remove this and add the code below after the loop.
> 
> if (!new_order && PageHead(&folio->page))
> 	ClearPageCompound(&folio->page);

PageHead(&forlio->page) is always true, isn't it?

> >> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> >> +		if (!uniform_split)
> >> +			return -EINVAL;
> >
> > Why this limitation?
> 
> I am not closely following the status of mTHP support in swap. If it
> is supported, this can be removed. Right now, split_huge_page_to_list_to_order()
> only allows to split a swapcache folio to order 0[1].
> 
> [1] https://elixir.bootlin.com/linux/v6.12-rc6/source/mm/huge_memory.c#L3397

It would be nice to clarify this or at least add a comment.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

