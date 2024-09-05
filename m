Return-Path: <linux-kernel+bounces-316639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21396D240
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842011F2A177
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FC194AE8;
	Thu,  5 Sep 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTmte3LV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DE1898E4;
	Thu,  5 Sep 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525301; cv=none; b=mQIxxHuY5gs9vyqjokPRl8Y42RRbdidhMiCB2bUn1FNJZr/QyRWS7LeHo1FQTiFxxn+B3kJardX5p5TyUXXI3BDNqHqsFY8JNeHsltS5Nk0J6uuiaXCVe4hRav6lRGh0b1v3y39Tsg2KUHFSFPli2GHFpNSfIQ5lCtIMTKLJ/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525301; c=relaxed/simple;
	bh=eLX05+8Pw9Of6l7EDVqXXg7yUi/nnzEjkju7SfOCP6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPQNVlbVMcvYRLbR+1Kz5Zu8Ye9qlInedR+UlRu3yLOcBlctOuRf3q6Nzw+Dl4W558NgdxYMaE1uj9fL40Dj0BO475ltJlIKOCmhJUxEnn8ZKufKeWLU5Vyk2jdUeI2xIElUsa225zSqXeYw7SpY8glEufFpMne5ojS6TcXAr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTmte3LV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725525300; x=1757061300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLX05+8Pw9Of6l7EDVqXXg7yUi/nnzEjkju7SfOCP6A=;
  b=dTmte3LVErMNxxJrg27ffhkBJHryAxkXOBfbg4cZBmAHeoJuLj+bUYn+
   vYdRUzBpWch78jP07QZDGdfx5w2KVGnvWyqx9KahAYVHoudXqHutDPUfh
   Itl1EfxN8JqBH4TCktSJUnnvLCEsDzHwGm2E6sXMT+x3CAXiTOtXK0g8p
   rhwfhiL2fZkP1te2BKcSmZLc5drQT82kGb2ptz4tWRjwPKQp4zTPXtZRA
   eQkYLAy/4MnLHhIP2f5U3tS6GQpd1MpSCUPeNmuxmm4O406fbi0h25h3g
   KqKxbjSnZJw2vomBHQt+Q6SPOiJvZQZInS1faK3x9K1JNKs4LVnMNNldW
   g==;
X-CSE-ConnectionGUID: /jztXIhdRDylzJ/VFmGg2g==
X-CSE-MsgGUID: YduOX6GmRny2ARpK1yqr+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35612716"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="35612716"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:34:59 -0700
X-CSE-ConnectionGUID: BodgJ0ElSzmUoe9rYN0Zaw==
X-CSE-MsgGUID: Gjfv7NxeTbuX13W3dQspjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="66070810"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:34:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sm7x9-00000005Kkq-0UAa;
	Thu, 05 Sep 2024 11:34:55 +0300
Date: Thu, 5 Sep 2024 11:34:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] of/irq: Use helper to define resources
Message-ID: <ZtltLjZkFBWSbl2s@smile.fi.intel.com>
References: <20240904160239.121301-1-vassilisamir@gmail.com>
 <20240904160239.121301-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904160239.121301-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 04, 2024 at 06:02:38PM +0200, Vasileios Amoiridis wrote:
> Resources definition can become simpler and more organised by using the
> dedicated helpers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev))

Just use Elvis to make this shorten.
Btw, have you ever compiled this?

> +		r->flags |= irq_get_trigger_type(irq);

-- 
With Best Regards,
Andy Shevchenko



