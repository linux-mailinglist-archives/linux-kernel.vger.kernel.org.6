Return-Path: <linux-kernel+bounces-553724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33010A58E20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45AC7A38D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA050223328;
	Mon, 10 Mar 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUMnr39+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985271D54FA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595293; cv=none; b=g3uLlspCJeIR4Ss2aWXqwJyuJI7kJYVn9iLozyoWmgyOOh4hvLiyBK/YKRIKZJC5WMCSy9BLa6zify06MOH4wt3M+HbLr+HDeipbcthizgAcJCuoiqvPEm52jcq/qZsWwGtZ6NvxyZmnYFIk9pMtkvjMOYC7774jbKD3pkx1eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595293; c=relaxed/simple;
	bh=AO/IjuFIbXugfgtSEWyDOCjGNphrdVZXK8ISdYBpFqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGXAxad5zgL4NvZNVkuXsmwQwsQ/TG7OXN0BA6Haz9pe0k0nTnRvrQrOwGeWPfNvw3ULWN1AtsWktD/3dPpfcNzWQ7ID5OzImRoOBbgxRsJ80iYc/qntxQY6k4zLVBjl5XUe/GNc9FgkPz7crpgPsQ2yDdrhtWC/3hcvLBLatXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUMnr39+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741595292; x=1773131292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AO/IjuFIbXugfgtSEWyDOCjGNphrdVZXK8ISdYBpFqc=;
  b=BUMnr39+ltaXkDaIn4ZUk2Ne7p2V6M9StKcORDP7K6gjmjmb4nGGPZ63
   32iJPGgR13IaXUmaV27rVLAjk2Z4848k64gmitwNSXPI7tCPibJzB6r0Y
   UCISXeuq9g6n97T2vXaLF7CmYLA6s9nnR0gfsb44YN/PLEdrIbKDGI40c
   laaTU4wNvCJmpjq3EFyQsthY/1BcoOvl67wBuA4ihN7Ja21UqJtev7MwJ
   cXb2c8Y7HNFvZdUNdUVs1YVMKHQfTq7s46hLYtg1UP/Ahhc+Czjtrsyx2
   3NHyDmit1Z//7Xa1RaQpM6Rh6WkbWHEYVdSxovD6CRzeRsNa4mR0kLkZi
   g==;
X-CSE-ConnectionGUID: LYuc9u0TRLe5wLzIpx9w/A==
X-CSE-MsgGUID: wmmgbPGYSQ+VRWibphDFTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42291239"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42291239"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:28:11 -0700
X-CSE-ConnectionGUID: 4kuUd61yS2CINZ/e/5e7XQ==
X-CSE-MsgGUID: YUSGAhigT4Kk2gnD69Zc1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120637705"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:28:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trYUX-00000001BuD-1Pz5;
	Mon, 10 Mar 2025 10:28:05 +0200
Date: Mon, 10 Mar 2025 10:28:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH next 1/8] test_hexdump: Change rowsize and groupsize to
 size_t
Message-ID: <Z86ilQqOn-fgVsiL@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
 <20250308093452.3742-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308093452.3742-2-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 09:34:45AM +0000, David Laight wrote:
> Both refer to positive values, size_t matches the other parameters.

But why? The original code is written to mimic the parameters of
the hexdump_to_buffer().

You probably want to say that this matches it after your other patch being
applied (which is not yet the case).

-- 
With Best Regards,
Andy Shevchenko



