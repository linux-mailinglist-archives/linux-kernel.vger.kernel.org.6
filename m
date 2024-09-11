Return-Path: <linux-kernel+bounces-325339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031C97580E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6271A1C261D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E71AE058;
	Wed, 11 Sep 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYQFwv1J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0F1AD9FF;
	Wed, 11 Sep 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071341; cv=none; b=by6AwdlySAtORgZqzE6phAv/B6XSH6qOQEZLDjRYMEnz4TJ5YxtZ2MwSn4f+pDrvMMYdI9ruL1QatNf/g/+yKj6SMiMLkNI4bDS8l60e39hsg+WNQN5wBIempZF4uwMoMyTpD2+0dMB6L2idqJajiI1ZNKTdU89jylb7l+hB4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071341; c=relaxed/simple;
	bh=wFW/qpO3n7da0r6jkEGnN0ulyTu2/pFJJneaFG7nFAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di/ScgazwMSPxTVBv+MVbl1Wv+fTJu9eBdbcaygkP5Pgh9EfHEC4ZjZskNsU/8/nYfakVquOBK8P36sPGgbEzGoxMUxz5S0bcO9rwCuVL42usbHpYvWMc/oIz+jK0CEIWkSH2vfqFIbmpFaEDSmTcbXiPUhkdqvY5AOj3Oo15OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYQFwv1J; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726071339; x=1757607339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wFW/qpO3n7da0r6jkEGnN0ulyTu2/pFJJneaFG7nFAI=;
  b=nYQFwv1J6zk97F/atgzc0BWDrEtT71R7p7zIHWMJf5TO7BJEEVu6zemq
   sNUp7nMQjk2Ivfqb+NMhSlmepWkQI4g+j2Wr89+DxpA3nStBtIW3yzjyE
   iNXCna30+3W+5EUdCi6fXsQ1k6SCtxE/JZOxNonG4OrxEem959zgi1BcY
   D3/JKTh48gw21cQSR1ldnuYeXHE8x0qZg9Uhjzi4qY/0nyhP9mHdOnOoW
   lwkTSG/2EPULHuBuARQVDve91xhQ5v4I0T5BsZ/1SYPJrAV/9JPAh2AF9
   ku8gV0UDDrEXJctRBRzH/5ZaoCMxMiwoL9KPawn6Wr31UU+/s8+sthRWf
   g==;
X-CSE-ConnectionGUID: fbSxBg1vQz+Vaaf6AB7eZw==
X-CSE-MsgGUID: vKlIDHGkSg2753JXvwn0CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35475466"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="35475466"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 09:15:38 -0700
X-CSE-ConnectionGUID: 114nkUoOTua0Dl8R0hdwMQ==
X-CSE-MsgGUID: PaxNLYlmTiuy5YOGhbQGjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67705555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 09:15:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1soQ0E-00000007cN3-0DZz;
	Wed, 11 Sep 2024 19:15:34 +0300
Date: Wed, 11 Sep 2024 19:15:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] of/irq: Use helper to define resources
Message-ID: <ZuHCJcTyQvfPl7ai@smile.fi.intel.com>
References: <20240911160253.37221-1-vassilisamir@gmail.com>
 <20240911160253.37221-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911160253.37221-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Sep 11, 2024 at 06:02:53PM +0200, Vasileios Amoiridis wrote:
> Resources definition can become simpler and more organised by using the
> dedicated helpers.

...

> -		r->start = r->end = irq;
> -		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> -		r->name = name ? name : of_node_full_name(dev);
> +		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev));

Hmm... It seems you haven't replied to me why you avoid using Elvis here,
while at it.

Also for both patches you probably want
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +		r->flags |= irq_get_trigger_type(irq);

-- 
With Best Regards,
Andy Shevchenko



