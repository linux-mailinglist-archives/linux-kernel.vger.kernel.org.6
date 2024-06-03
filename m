Return-Path: <linux-kernel+bounces-199663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F688D8A81
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD65B23476
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061913A89C;
	Mon,  3 Jun 2024 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGQvSD3i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39689131182;
	Mon,  3 Jun 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444315; cv=none; b=WCI2CKPX3Zc+KKneu7z4eWDrso3BFDV5dyz+YP44diTSsPQxwW+bRp+H2fFChIUP7Cl6ipgi12WF7TZig9bdWfrrfKtLeDSA2aX0xQ3WSIRO1wFLNamKEbuOcQSr9KuFTiqZ6XUcEHZw1DBPFkoy22AeIL6cNsYwcXWx2Z0ixMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444315; c=relaxed/simple;
	bh=ZWhiK/w50bV0NCShUl0fkyj2IEFUugwoTs25t/6gc/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5gkIPtePhkyATTjJ67GMIAZ7NU5KWOmy+pjgl8kvuIDrgZdBg1tzTkByl4cPnW0HfyHr0LGT9b2lzwC3JzzNAfUCdAC7jm9RXO/u+KNq93a1a+0iEi2JFiNqSPXC84j8b4bRKPrQMH3M7+sPVLHvvC2FZ3G81PbpeTWmShAlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGQvSD3i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717444314; x=1748980314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZWhiK/w50bV0NCShUl0fkyj2IEFUugwoTs25t/6gc/c=;
  b=ZGQvSD3is5J3vMIA6qJE1N8SqmFV+1Fur5oVBFUHkri2O0AqLJmfKkQG
   lDUo3R25NK7TCS0aS9th3DqR3IQ9VQvLBpuXdQiXL/7F3J1wOIUVw8nTJ
   RbbWhCbmNhdTvdajDSez8+A6jcUxUoWmnE6bS0KufpMT+VoTIYNmgXxfE
   3C+37tFVrPAB230dPe/ZLluuA6Jzn0qe6pp3WNKmzATFOxYfr6beVMCg2
   58yCUSOkOCfceegZsSYoNUkmCaifIulIsFcuhGpB13mRdrwbMrw1xwx6R
   L6ff9zOacE0v5ZivIFA0vIWS1CPVqWzk29djYcKUgsIH0y9qs6iI0YrPe
   A==;
X-CSE-ConnectionGUID: GfrLpE8cRDSoOIE4oFagCg==
X-CSE-MsgGUID: yMzxy3VzQw2q/m6Ng12pOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="16897855"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="16897855"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:51:53 -0700
X-CSE-ConnectionGUID: jSg2/r8sTAiypEYzuewOPQ==
X-CSE-MsgGUID: qVXP+vu5Tl6FGX1tndm6jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41430244"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:51:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEDig-0000000DNKW-08gc;
	Mon, 03 Jun 2024 22:51:50 +0300
Date: Mon, 3 Jun 2024 22:51:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] uuid: add missing MODULE_DESCRIPTION() macro
Message-ID: <Zl4e1XkYXhJLRSOY@smile.fi.intel.com>
References: <20240531-md-lib-test_uuid-v1-1-67fa498104c0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-md-lib-test_uuid-v1-1-67fa498104c0@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 07:19:09PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_uuid.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(We have no designated tree for UUID, so I would expect that Andrew takes this)

-- 
With Best Regards,
Andy Shevchenko



