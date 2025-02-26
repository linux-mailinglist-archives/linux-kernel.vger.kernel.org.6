Return-Path: <linux-kernel+bounces-533875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89738A45FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141BC1889A30
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35120DF4;
	Wed, 26 Feb 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG8pRWBt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19E17BA6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573937; cv=none; b=pc1OHqmi2ymmfijIy3fwEQKyb6KQI10Rn/FZcEwqU+Yd6U7QsJmqYki5bs54zx2tV89ywMb21diLnfo5esAqUlMDhSHP6xALIgZjsoKLbwz5B99JRtBu9pGgmjq3gYnUBJK+IRKIqkHw+MummSrCXQhqEwd+xnLS1k5xNhneCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573937; c=relaxed/simple;
	bh=ETqLhvBLGuOkk5UcK7GolKeXVGPFkXzjQTV2KjAl978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLXEYTxuaPtJdNt7qdb1qvFR618HYQ9PxX9tKgYnYcVXOuXfyhkiD9lhFNQ4xOwkEb3aK3y2Hs6TH5gjW3ywR1Z3bbnRlUzC0IU7fecIw0Yon1yA9pMo/TjEojWkUIwFtE4K/S6HWJAnJd+5ZB46/a53vO05ydz1f86wpqnbO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG8pRWBt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740573936; x=1772109936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETqLhvBLGuOkk5UcK7GolKeXVGPFkXzjQTV2KjAl978=;
  b=MG8pRWBty0KmjHjm3D/f/P107Zt1gkpUjJwr0TeC3Cz94lal8u+5njAL
   NnVBx0nDvhsguv4aLI6qqGPNYH2AyTopJYMwVynDDpxWU+cV0vtlrFyyF
   0wUebuRyENXVOZ2xlFsF0sv+HDccXryMdBSMEV03Z/2Cp9TBDDxAozbmh
   BZ6eFq/5PbjREEOHJ+4cqn9dVakQ24LIzwZwj4kKY2I6jI3tbTFPpUiZH
   bphjvy8z53E0nH8tQ0NuEf0aq/tBav3i5NTjsGeca7ik5uzAOdcb4z7+v
   nMMKWdgn9L19m/qsC9f4EoUHwj+j/xIoRtaDIa574y7BDtg7qqd8tYCCm
   Q==;
X-CSE-ConnectionGUID: DyOENh+WTeOpotDJlM9jDw==
X-CSE-MsgGUID: giEjFsTpT2ScjcKIwEP5TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52049357"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52049357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:45:33 -0800
X-CSE-ConnectionGUID: ocEJKYj8SteaB2m3lNsQ8g==
X-CSE-MsgGUID: goNrEDJNTbulBy4nacQt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121941995"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:45:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnGn1-0000000FKAp-0nff;
	Wed, 26 Feb 2025 14:45:27 +0200
Date: Wed, 26 Feb 2025 14:45:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] pps: generators: tio: split pps_gen_tio.h
Message-ID: <Z78M5iTHgdHnqbz2@smile.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226061527.3031250-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 11:45:24AM +0530, Raag Jadav wrote:
> Split macros and structure definition to header file for better
> maintainability.

> +#ifndef _PPS_GEN_TIO_H_
> +#define _PPS_GEN_TIO_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/hrtimer.h>
> +#include <linux/pps_gen_kernel.h>
> +#include <linux/spinlock_types.h>

This missing time.h and types.h.

Also you need to add a forward declaration for the device.

struct device;

> +#define TIOCTL			0x00
> +#define TIOCOMPV		0x10
> +#define TIOEC			0x30
> +
> +/* Control Register */
> +#define TIOCTL_EN			BIT(0)
> +#define TIOCTL_DIR			BIT(1)
> +#define TIOCTL_EP			GENMASK(3, 2)
> +#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
> +#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
> +#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
> +
> +/* Safety time to set hrtimer early */
> +#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC)
> +
> +#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
> +#define ART_HW_DELAY_CYCLES		2
> +
> +struct pps_tio {
> +	struct pps_gen_source_info gen_info;
> +	struct pps_gen_device *pps_gen;
> +	struct hrtimer timer;
> +	void __iomem *base;
> +	u32 prev_count;
> +	spinlock_t lock;
> +	struct device *dev;
> +};
> +
> +#endif /* _PPS_GEN_TIO_H_ */

-- 
With Best Regards,
Andy Shevchenko



