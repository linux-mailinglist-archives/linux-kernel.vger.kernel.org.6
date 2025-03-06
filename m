Return-Path: <linux-kernel+bounces-548971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D9A54B94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EDB16AB44
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633420CCC8;
	Thu,  6 Mar 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0H7OLGb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC120CCD2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266541; cv=none; b=tthfFqExAAAfbdQyRN8gNFPoym6TXoVFSj3xRAqUcMhxv4onz/PHTGAze6fe3hB1g5smxmGrHWtJgwpkhuCfAtciUy/29W+GFRmrTXOXysQ0UBrXBR8UpAZ7YLv7WEXSRKhETemHLGuM7QjOIIVn9T6Ad+ik5yZXPzZwOLt3asU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266541; c=relaxed/simple;
	bh=d/J2+mq/GAIy24horHmHsXIcl7aG6z61rC5ACtPrVpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpdI0KcvALCVFZXsd19pzgZ3MmEmp2CFCpTmJCh4nPISpZX/vEmqmcxaN9tx/Lu5ZJJO9uF6c4h6hjbRD1oRMljefa52V4YOxd8bwPX8Ml6kLQTAmk6jZUWAfx9Jcofe9EN5qkbkguVNIETPACg0TmECMPI+qEQtqRsFioetq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0H7OLGb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741266541; x=1772802541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/J2+mq/GAIy24horHmHsXIcl7aG6z61rC5ACtPrVpI=;
  b=e0H7OLGbPqeTgkrtZbTpammIUNkBMJlUM7dKNOF1zUaA2WYPST6xw1xg
   gzo7gX+TiOrFJr+yp3UJZtQYx9fvpB6fMCkS1vxqd5BVmhKnE+7EICEJl
   Svgi4fx2HPQOk8vWrrrOV41RpeVRh1ORzrO+nJD+DIYD0Xv5jPncPbQl/
   QBaFfutBHdLLdf66Ay2fJI9JV8VCvgFvZBM9m0R2zJDfe1Q2sytEPdAAy
   a0ehu6WLU9WIbz4ESMcM4v3zMRNhMcwsTmtjSK1T98hyiH6EOCZriJa6O
   Qf4CWwTzjoZx5XTM/5ggXFxQ/yNvjz2AP4Ptp8BjbmAw5QzXYPNaPSjcU
   Q==;
X-CSE-ConnectionGUID: L64pFJe3RW2jtRO2soQYWA==
X-CSE-MsgGUID: jHu/L/bNTnKggasgZvQoxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52917859"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52917859"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:09:00 -0800
X-CSE-ConnectionGUID: H7mWMoRdTLOv4gb+L0QGqw==
X-CSE-MsgGUID: ldBU1+aHSlKjVO7ibT1o5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119027618"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:08:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqAy3-000000007h6-3bfG;
	Thu, 06 Mar 2025 15:08:51 +0200
Date: Thu, 6 Mar 2025 15:08:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v5 2/7] bits: introduce fixed-type genmasks
Message-ID: <Z8meY7NS65_d14og@smile.fi.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-2-b443e9dcba63@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-fixed-type-genmasks-v5-2-b443e9dcba63@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 06, 2025 at 08:29:53PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Yury Norov <yury.norov@gmail.com>
> 
> Add GENMASK_TYPE() which generalizes __GENMASK() to support different
> types, and implement fixed-types versions of GENMASK() based on it.
> The fixed-type version allows more strict checks to the min/max values
> accepted, which is useful for defining registers like implemented by
> i915 and xe drivers with their REG_GENMASK*() macros.
> 
> The strict checks rely on shift-count-overflow compiler check to fail
> the build if a number outside of the range allowed is passed.
> Example:
> 
>   #define FOO_MASK GENMASK_U32(33, 4)
> 
> will generate a warning like:
> 
>   include/linux/bits.h:51:27: error: right shift count >= width of type [-Werror=shift-count-overflow]
>      51 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
>         |                           ^~

Code LGTM, but just to be sure: you prepared your series using histogram
diff algo, right?

-- 
With Best Regards,
Andy Shevchenko



