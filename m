Return-Path: <linux-kernel+bounces-275802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF139489F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFCB2454B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D7166F36;
	Tue,  6 Aug 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INN34JpP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360616B386
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928797; cv=none; b=NfYthtcdcTp8W48+DTk1Uu16rtWrqXtpJzx2xhTyQNXctWyStigGjraiUVPh6RxbShvTPz21VTbNIJwOPL+aEvoJtKto+u3yDd//gFDeelTn+uurvlpqLst401EBb6xjhr9Tzd0REZAGU+lWT4XjTcpb+85nMuQl/w1IJfCbwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928797; c=relaxed/simple;
	bh=0n6ZAmPEIrOh3Em42WYLvG6rl9PwybdLcfFH7SHyQX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw68pFwnNU5dgYcKX4RlzxJEUqdeDVo0KwtbJpqH2IOe/N+z3R1xuHpRF9vYTdGD0L4H0hr5tIPcCzkOBks4BN8n0TpYdIcCj7PVtdGNqu76hI+2z0GxaYurZnOlwy6VDprHhYOvsSY7bcATvC/GooQCX15A1eU9l1gFDeMFZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INN34JpP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722928796; x=1754464796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0n6ZAmPEIrOh3Em42WYLvG6rl9PwybdLcfFH7SHyQX4=;
  b=INN34JpPN1cbFgcUY+yaqsiWlKIVl6vQMH6Qoq+bFiHLbjPDjKk5VLFz
   X5RuhxseiUbWq0Ei1L2EYLSSatWMGB89Zukm6/qmIjvc2T7oLiLAmWAgo
   1Vj1I8TOWYlsXeFVGogjajOBA1MFSjz+7CdYevUpHBHaYvzirNBRmhccJ
   2R1HePxvvWw35vDQAU9lX1jC4PJrO+6gif+82KnKWOiY22z1I2uiLI9jx
   gX2p393NBpHfgJnR5kORTKhD/fJZsmXX09AfFFOZ7u/freIH818mhyaGQ
   fqBZ/z/XQgElsfg3XbpYNqB0WwvW3tpKYRNjjmohBabSddpl3B/t+74ui
   Q==;
X-CSE-ConnectionGUID: rIboiiTQSjCkIKJqGiKLYQ==
X-CSE-MsgGUID: Qt/sR0OVSomcyHDASy5qFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="23841707"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="23841707"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:19:48 -0700
X-CSE-ConnectionGUID: VAgD+C6pTxmXtBjfVpf2ew==
X-CSE-MsgGUID: iCrMl1FjTfeHYIs7WBMaUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="93951477"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2024 00:19:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D55D113F; Tue, 06 Aug 2024 10:19:43 +0300 (EEST)
Date: Tue, 6 Aug 2024 10:19:43 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] mm: Introduce promo_wmark_pages()
Message-ID: <ybwbqomzbfegmo5yop7uqgh3ogv42r2iznsnnl4gmdgmda5nsq@v32locjv7bnk>
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-8-kirill.shutemov@linux.intel.com>
 <20240805170442.GB322282@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805170442.GB322282@cmpxchg.org>

On Mon, Aug 05, 2024 at 01:04:42PM -0400, Johannes Weiner wrote:
> Hello Kirill,
> 
> On Mon, Aug 05, 2024 at 05:59:39PM +0300, Kirill A. Shutemov wrote:
> > Add promo_wmark_pages() helper to complement other zone watermark
> > accessors.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Andrew picked up a change that does this a few days ago:
> 
> https://lore.kernel.org/all/20240801232548.36604-2-kaiyang2@cs.cmu.edu/T/#u

Ah. Great. I'll drop the patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

