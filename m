Return-Path: <linux-kernel+bounces-554148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1AA59380
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A90A16DB10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4141227B9A;
	Mon, 10 Mar 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1kIOsDv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07653227EAE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608387; cv=none; b=MgGQOGjkbPfiach/JmMwDYg07+mmPnT0M8Kq9cn6qTVhveKTqOo878SDAx41nTSHM5/V9yX5IpOkuSW2ksgbPyJpt3xgTuegTVkUbFBgu6F3Ng5AVVdt80NbFlGUVgDD0/TMGcvb2HYAO+dkKNCZCwMuySMTrzHj1PsU0CBZY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608387; c=relaxed/simple;
	bh=fLAJAiqYd+Sl4aTlzjXT7WtMKBaFjK51w6THZu36tD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS+FnjOiGJwsNFOqu6cejltUp2IBJUI8zER+89UoB+4rtJ9g2V5n/KC4NvkqICkBxw9Cguw1mZJZexKNyxGytVa/r+5U+ncWYUEHFue3gPBCQjFWCH6siaeIXFawvjuHgUwDp8dqOLl72kYmK5w1xQIOP0XVfrOuR7qgvnezeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1kIOsDv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741608386; x=1773144386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLAJAiqYd+Sl4aTlzjXT7WtMKBaFjK51w6THZu36tD4=;
  b=A1kIOsDvW3zdSt/12iMBWVnsws0qVfYuiXO/sNrWBK5AhdwQ+PhmWtzp
   EHofZ94/dAoQ3xtr4YdUwU3VB7XbwNj7tvUJagPbtQtyOR3Y5K3k6NTZ3
   cXzrX7tUdmq2wFtMAr/UpfOVdcpCZHO/sYkLrAc0//QresmNXVu5OQxhN
   LAXCeyIvMTrB4yXN5bEiI8OvqiUXt2JM/c0qlMJOqMBoY4X7oGNfGY/CO
   K4hHUC+r/g3dDgo0B11ITgH5exvcN79Wgs9Zz+5KOflcbHUqZrvdhJifb
   wzJeYvo6jKjBhTg0FXAUvbNkzKohGC7XPj1thPzo0mLkVQsntAdanFVQo
   A==;
X-CSE-ConnectionGUID: xQ/5OuGkQlqOH6a/qV04iw==
X-CSE-MsgGUID: KRpyqFW/Q36Y9cyH8+S2Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="60150533"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="60150533"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:06:25 -0700
X-CSE-ConnectionGUID: EBoIinS3T/2ESNvpSDaWog==
X-CSE-MsgGUID: AY3cGCFuTmKo8D50e1j/+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="124582470"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2025 05:06:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E7AC0156; Mon, 10 Mar 2025 14:06:20 +0200 (EET)
Date: Mon, 10 Mar 2025 14:06:20 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH] mm/page_alloc: Fix memory accept before watermarks gets
 initialized
Message-ID: <asxbkez3pwoc2p4jb5ftwbvapzvoj3kma2tunprrnp4ptihebb@dxhvj3uicw6c>
References: <20250310082855.2587122-1-kirill.shutemov@linux.intel.com>
 <03b53f18-8c16-4716-8ed4-1902d7247354@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b53f18-8c16-4716-8ed4-1902d7247354@suse.cz>

On Mon, Mar 10, 2025 at 12:37:25PM +0100, Vlastimil Babka wrote:
> On 3/10/25 09:28, Kirill A. Shutemov wrote:
> > Watermarks are initialized during the postcore initcall. Until then, all
> > watermarks are set to zero. This causes cond_accept_memory() to
> > incorrectly skip memory acceptance because a watermark of 0 is always
> > met.
> 
> What are the user-visible consequences of that?

Premature OOM on boot.

It can be triggered with certain combinations of number of vCPUs and
memory size.

> > To ensure progress, accept one MAX_ORDER page if the watermark is zero.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-and-tested-by: Farrah Chen <farrah.chen@intel.com>
> 
> Fixes:, Cc: stable etc?

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Cc: stable@@vger.kernel.org # v6.5+

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

