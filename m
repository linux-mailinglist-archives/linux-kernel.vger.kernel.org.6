Return-Path: <linux-kernel+bounces-541382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F0A4BC5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343D13A644E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18A11F3BBD;
	Mon,  3 Mar 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQTPeiwh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F41F3BB9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997865; cv=none; b=eIdwTQE+kYXpemSRfoWDwBocL5AqwisLVbo4SJBLS2QCixDxRYAIT8vD9FNVlJvl/W5LCtbbDXWwAgbfaFybWoO+Y2INx1ju4jDS1xnyegTbpemzblyitYZrx5pae0D9CfgiBCQ5X+Cxdiojv7KqTp8sv6NKVQepl/Wk57ztd5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997865; c=relaxed/simple;
	bh=DpPwmjvlhnQGxs4MslAb6cwk0vx/Scx4k69oeGlbzHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUjY16mpauO37dpMt4kirdr31HKqg8szyzP95LLbbBxD8S6aqqVFqlQqwylrWwKdrHcPQYvwIrs2BgAprOq1vZNAL1j3e0ke7pvW0x8d08FOLrfFfn3bqeq0ncrZI7QBbE0+NLzI52oB9iP4qMptVw9PyHXrqHjmCzz5bBvNkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQTPeiwh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740997864; x=1772533864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DpPwmjvlhnQGxs4MslAb6cwk0vx/Scx4k69oeGlbzHo=;
  b=eQTPeiwhCyInbTlgz0GyDEwe+Opvg6sOIratkWqCB6S2HQuKApStocdy
   z0xkjZ4RziLW8KavTLwtCP1OVTj22SZ046/uhEg2xyznJuQz6H1Rodlug
   Ux0OZV2j+2mRAMVH8bF61SUjJSpp32iON3TmcWxa91gUuM6ne+FcBDQeF
   pK1gMyeuVY4YW57ioMd5XRLdZLGAaEWIM+mG0xRseDR0d8LpnCxMf2hRz
   lseOAYCNNMfGpjmMcno6Hj6yP5vdAxn1Ca8Z9YH9e90wD0hiaoQOrynjC
   VyGyXJXhzYr2vSUZcuZJuORSFoEuWnNd1sW9BC1K8CEC3i4fyYdGSzrt0
   A==;
X-CSE-ConnectionGUID: NjLC1ZcHRZOPqU9jDPgZsQ==
X-CSE-MsgGUID: FJr908XdQhGeUVvRs+6lNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="29452926"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="29452926"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:31:03 -0800
X-CSE-ConnectionGUID: ZQvw2yZ/TciJnZ2K+Wn7Zw==
X-CSE-MsgGUID: dS+CN8WXTF++XALEK6gpNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118150482"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:31:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp34d-0000000GmRf-2SgN;
	Mon, 03 Mar 2025 12:30:59 +0200
Date: Mon, 3 Mar 2025 12:30:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 0/7] auxdisplay: charlcd: Refactor memory allocation
Message-ID: <Z8WE42W4WBt4c0qG@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 07:27:37PM +0200, Andy Shevchenko wrote:
> The users of charlcd_alloc() call for additional memory allocation.
> We may do it at the time of the main call as many other APIs do.
> For this partially revert the change that brought us to the current
> state of affairs, and refactor the code based on the original implementation.

Geert, if you are okay with this series, I want to proceed with it today.

-- 
With Best Regards,
Andy Shevchenko



