Return-Path: <linux-kernel+bounces-327908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AB977C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BF0B286A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216A1D6DB1;
	Fri, 13 Sep 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHSeCbUm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC41BF7E3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220723; cv=none; b=oPpzTq7afgZP0MwI3aJr3RHsS2B5S6c+LZn9ohOlKBgxOQPaPOMFt8pTcLgM1/VW+ShDWdyNUyg9koN2Yu+HNDZr/SGSuD+UlNpZ5THOW47x3ThdnB8TB4CSwDworcx+4sD8fqB3ivQduu+nr61YoUrXkQD9PyHrSdaD/Hf2zmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220723; c=relaxed/simple;
	bh=MUAHhEXFPurd2AS6xdCG/w4vKY+yhMt7IXNzDb0O7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbeoNpDDo/98DOJ1xwZTfuBHTYNsGXopL11pbSSpIIKxq3rj2JN3LPDEWx/nVyMhO9ymFPSIxCKkRf9m9oFGZpHAMzbO3+lVshoLnjpa+mvEP2uhVS5mefn31uYuq4gx1irhbySzahO0O8FejI+zwLPULozw/sfCONbXQoido8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHSeCbUm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726220722; x=1757756722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MUAHhEXFPurd2AS6xdCG/w4vKY+yhMt7IXNzDb0O7JE=;
  b=VHSeCbUmzAkQnN90enKA7TMKXQeb0jx/aEhm3k1RsTSHf4N9xitA60/q
   o8IgCwp1ovYyNau9M7yQMWHf1A16OK59yfX9MyTwKSu/Q52EKIaofQK1i
   xYRKuf7yv3u0v77mfYzcT3S8JmEwZx8/ZaOr9pm0It46y4TpL0k06E3/O
   5qDztfrsbXF9Da9hW7R2Wt89L4t/1f5RfhDj8F/Nstj56wfz7+ukkcMSk
   S0b+Msu7zsI6MQQsEOecyQW1JMjE5EyoKQNLXpftbBg/k3xLq8cH6v3m6
   t1y99zppcXsIsvPRufM9DDfiyzAs7E21mp7+AFzBhSSKaOMVXjIAPRnWs
   g==;
X-CSE-ConnectionGUID: Th6eoMW/RKSgclBJfR/Fog==
X-CSE-MsgGUID: sFC07Ra+TeKcTyaOqAwOEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35700126"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35700126"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:45:21 -0700
X-CSE-ConnectionGUID: KPRN2a54SGeerFFSFrf28A==
X-CSE-MsgGUID: igp5M5BPTT6WGc1cF/VRNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67846828"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:45:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2rb-00000008FQc-2pCc;
	Fri, 13 Sep 2024 12:45:15 +0300
Date: Fri, 13 Sep 2024 12:45:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] drm/i2c: tda998x: Make use of
 irq_get_trigger_type()
Message-ID: <ZuQJq2JYAyuI4X3T@smile.fi.intel.com>
References: <20240913001156.56634-1-vassilisamir@gmail.com>
 <20240913001156.56634-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913001156.56634-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 02:11:56AM +0200, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



