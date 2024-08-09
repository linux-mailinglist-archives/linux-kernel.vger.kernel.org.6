Return-Path: <linux-kernel+bounces-281121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9A94D352
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3881C2193D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706B197A9E;
	Fri,  9 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wrq4J6aB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9691957FC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216909; cv=none; b=SJEWD1Tb4V0WEPBWAxfPOndnPz4tGQOa57AdHKNVkjISI4IGBu48RkIVBmXMC9P4/Zn2/zE3+eAh2HM58NPL/OIyyOD/mAhuIKTHgA8j3Ilv0Ftw1y+N/HapZvTSPo3h36RW/pTSS/JU0ae1Gt7221LN73hawF/w0kGoW3Q24GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216909; c=relaxed/simple;
	bh=3n7nt4F3cmnlZZg3bYa1u9gx42w0XvdP9tt3BMSrfbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0HX+zI3S0Koi4KVe/ZUOd9v/iMu/Wub5i7lLElanDtLNPkfmtWNyKJUIHKQIF9ucc9ApC3BZMZ8m4fsT7byH58yfe3NYYoer6jt4McE4w3iBd+LdINWwohE+bBpDmqZIIHT1X4lF8O+GukgSCgRDpWrvSdzvPtjnOFGE22fox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wrq4J6aB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216907; x=1754752907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3n7nt4F3cmnlZZg3bYa1u9gx42w0XvdP9tt3BMSrfbc=;
  b=Wrq4J6aBLzvbuwkjSYkKnkxFjRHF7mSWWgkqgKpk9PPNjHnf8251n2U5
   IuVN5UyZ2nG/O6jXEjHF/tiN7DH6Kd7kz3Z8VKMJ/bt48h1t4oUc/tkcf
   uy52dKn+Tc+NE4K6h+zNzQHLrP+Uv0GDJAy0GUaxCq5b4/nqMjH2vjB1s
   4tZcRhFUL/K0m2vL+zpJTIymyeDkib2X2D8W5WOpobptmaJpQ31lK8DcA
   ERniXB/YmypDeDgkGwiaYtLJp7wJc/bDvWOu5oS8Jg1AnbdGf3bcAYXBn
   UK/hCD6HLCNX4rNYmzNsYJbowSzq0NgkysOpTw44BNMcmeWVHUr3mL0T+
   g==;
X-CSE-ConnectionGUID: v5HXjx9HRfy639YlFDeGsw==
X-CSE-MsgGUID: YyzkWdf+RfSVC+PYKiD86w==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="12934368"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="12934368"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:21:47 -0700
X-CSE-ConnectionGUID: Tm6b3DDPT5uix8hCk1vNpg==
X-CSE-MsgGUID: 68O+vFfuTg2gud9Yzntdow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57257715"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:21:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scRR0-0000000DSEV-00Je;
	Fri, 09 Aug 2024 18:21:42 +0300
Date: Fri, 9 Aug 2024 18:21:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 47/53] serial: max3100: Simplify a create*_workqueue()
 call
Message-ID: <ZrY0Bd8Y0_r-OB9m@smile.fi.intel.com>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-48-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630222904.627462-48-bvanassche@acm.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jun 30, 2024 at 03:27:05PM -0700, Bart Van Assche wrote:
> Pass a format string to create*_workqueue2() instead of formatting the
> workqueue name before create*_workqueue() is called.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



