Return-Path: <linux-kernel+bounces-280797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DC94CF59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88251C21294
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A57192B89;
	Fri,  9 Aug 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0cWoF63"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C315D5C3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202850; cv=none; b=X4JMQUaBHTp97qty3SI8+XVjtuk2Grgnqv3mi/1NtSp34oOQ5j6h26iN6/QOIZVh4OXBsCdWij2IExYzq89PmPW/mc0/qcbm9JLjmK1g188p5940luXYLZUfQlKldmF7WM5jJ5L75V/g1/N1c/E4hoK1ctcpdwXU9vLn8j2acng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202850; c=relaxed/simple;
	bh=omG6oOUvVUIz9rPmgn6hJ9KsjtJcCGufwzjHdo6dgG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du7k8Yb3k1uh4gorTdjWnD4hPgE4sHXSYRSYcXLm7kVtj2uIal9Xd8BFsCCCb7++HEshI9TtWKSNRFnup54ZSfu5+0A9QGQgz5yH73FX87Qy707zd/u6E7nKdJVhuXa9mdTpxCTIR4B673sW+J1x/bQ4w9ptmmnJLFbUmb5ztRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0cWoF63; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723202849; x=1754738849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omG6oOUvVUIz9rPmgn6hJ9KsjtJcCGufwzjHdo6dgG0=;
  b=i0cWoF63vObkgBeBsxpNQFKLGeGU4w2QlVapr1L+pfvsmLd3kkjRHPiH
   Q/IjYNi7mZ3BGjatrKuJbPC/ldlGfxUDlwe3FuKuqyB8jAVJuYv+g9iwz
   yn6FOM+fgD0U607x6BEahQDESphx/PGkhgLG9dRJaHgD83KIJtv6fufGq
   +bdnu0sMC9fS0o2JR2RxRBsstdGICA7cDShFYir7gVMpLVPo5Ln/WREQ0
   CBbjdEgprDiOUpoiq6nEVaHRZCcEuWMm1ypYq/tpvxGjorC39e7BFty5W
   FmDYiHiSBZjvCFscJXG4ZruFA+0yihJnZnJPqjcEDgINO3ptaFMsezpiO
   Q==;
X-CSE-ConnectionGUID: j1xsItEHSieFg0IbM6vmeA==
X-CSE-MsgGUID: fbwn/ikHS5+NRV2kwyWc0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21498186"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21498186"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:27:28 -0700
X-CSE-ConnectionGUID: BNZeqY/5QfOZLvlr33E4lw==
X-CSE-MsgGUID: RIvCx0e9Tm2dSwEGkXdgdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62181629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:27:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scNmF-0000000DOuY-1ZXg;
	Fri, 09 Aug 2024 14:27:23 +0300
Date: Fri, 9 Aug 2024 14:27:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] linux/container_of.h: Remove redundant type cast in
 container_of_const()
Message-ID: <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>
References: <20240802-container_of_const_fix-v1-1-90e7a5b624f9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-container_of_const_fix-v1-1-90e7a5b624f9@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 02, 2024 at 11:15:15PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Remove redundant (type *) cast for default branch in container_of_const()
> since the cast has been done by container_of().

While it might have same effect, the below is explicitly clear about both
cases. With your patch it will become inconsistent.

...

>  #define container_of_const(ptr, type, member)				\
>  	_Generic(ptr,							\
>  		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\

(see, in the above line the cast is still present / required)

> -		default: ((type *)container_of(ptr, type, member))	\
> +		default: container_of(ptr, type, member)	\
>  	)

-- 
With Best Regards,
Andy Shevchenko



