Return-Path: <linux-kernel+bounces-390328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD29B7876
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B50DB21328
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728011990AB;
	Thu, 31 Oct 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g25zhrjW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6B12B169
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369657; cv=none; b=ZLsh9DMCWHFDgxo6SjSiD9PfKIqtzaJtUgMsQ73RKSOPt2uBFP2mI25P9tLmzP7us+8bYRsQUfIZjsFMTDJ+X5Mom/1DoiXeroYRVGs9ha5IPk1VjUx6pU6r12IFlkUnNIT7KtsPW97XLuzszVExB5xIU7SqAC1VcSbQkSOcUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369657; c=relaxed/simple;
	bh=SfUOKiT/E6pzf63FvALfLtnrYKwCVgTIP4DrqgDHNhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCybs7UxvdAmxEJ/pcMB1631CSrVAJu5B5VdHvRxuSvlMcIKoKPaCBwZaEMFcRcR7PkvKEo1qzSAWXxNB1CsQN9uOiXEFbNvBqrqDB5pM0BVkPYvIyj5QU+vYJNSApykuuf2UKutf73oEhUF8MRGHCOzEqTbJCvP0TnTGgQk97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g25zhrjW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730369657; x=1761905657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SfUOKiT/E6pzf63FvALfLtnrYKwCVgTIP4DrqgDHNhY=;
  b=g25zhrjWYpMUQB36BafI/FKR7mMWKSvRJz3/0UpiVpRzHfWlUuDrYK2M
   6GdTj+y909FRhY8l7YfdcQ39+K7SVQUvVwrIpH9gyHkaS+O9/LyaztmmQ
   /e6IKSNxNH+9of9Ct/b5LfZKddak6P0tcUhkZqKGQwNGy2gBH1/ob3n1r
   dHo1+TIztOYTnIqT8bfKezOqeCVg51N3qy0+Tms6OYVC8JShdkZdC8XV1
   T9jwYKd7twICSE3ETKqkbEyXxxJLisdtvfYAzqhTRqLXyaxgb7aR9Ns2G
   8/roAUKKx3Kumjh+I/cT37afCmUds6cRR4J2FblbJUJpurWrWv2zXoKMh
   w==;
X-CSE-ConnectionGUID: GF/pVbwtScy+u6s3lIZo3A==
X-CSE-MsgGUID: ZXlAMbqxRAuufs5RIFTlIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29956527"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29956527"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:14:16 -0700
X-CSE-ConnectionGUID: XNYJCng+Rk67WwN9YOHhaw==
X-CSE-MsgGUID: zWMqq7EKSAG3n/N5/4FMnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82743180"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 31 Oct 2024 03:14:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 730D21C4; Thu, 31 Oct 2024 12:14:11 +0200 (EET)
Date: Thu, 31 Oct 2024 12:14:11 +0200
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm/huge_memory: buddy allocator like folio_split()
Message-ID: <cqh3exrkag2mbdeluranstvakkzxjpu34kkjs77feuvexoevop@nlyq2otyygr2>
References: <20241028180932.1319265-1-ziy@nvidia.com>
 <20241028180932.1319265-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028180932.1319265-2-ziy@nvidia.com>

On Mon, Oct 28, 2024 at 02:09:30PM -0400, Zi Yan wrote:
>  mm/huge_memory.c | 604 +++++++++++++++++++++++++++++------------------
>  1 file changed, 372 insertions(+), 232 deletions(-)

The patch is really hard to follow. Could you split it into multiple
smaller patches?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

