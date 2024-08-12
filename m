Return-Path: <linux-kernel+bounces-283267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04594EF56
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7FAB221D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81317DE36;
	Mon, 12 Aug 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUxI22Rk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CB16B38D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472257; cv=none; b=T1+6cdwHMfmCj0E4ynvpLiRkbiuL/pukIIvaV6+iIsBRawqUMAHpYbaU76xwj8iGQU1GtiK2PkIvwOwSdaHI6cvrpTiv5sIr/lUePwOvQR8ZB+g0sW44HvXJUaY3SUBHv2MAeltsGYunmIA7SJr3hfVbQyshM3ciw9swaaATIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472257; c=relaxed/simple;
	bh=rpWz06RRrjzMyzDbK3jEABkEUALNs+Yma4r11Kmgedc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuAU58RG7ZGpSnWDZxPaRkmvr3jEbWEoSjouRgvPDi2NzUoAmArr/XB0Ga+mGxDaDDnL1+UDsxADiIziCPElXszcneZdw2mCqYv+VliRPfCPm50i0Z+oSTieJPFNXvmnEf2cZBgr00gvwQUufe18ao2Dn3gz1g2J6VqSLvgUOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUxI22Rk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723472255; x=1755008255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rpWz06RRrjzMyzDbK3jEABkEUALNs+Yma4r11Kmgedc=;
  b=RUxI22Rk3VFDEd5DZfDXyrxSMmFQDq7bDOVoayciBr4VYth7xOKXi/sB
   gnRTQW8Rovz2cj/ltsAhY5t+1+mCCYmr9w7yvas8Kz4+igSHU3K+IcYVR
   JUY+GCkdvqo1p0zHepfyU/GdFDRf4QHEBTDfDgxZ3/YSZYO9iAxmfjzWG
   OoET+LcZGesbXSeBFWseqXEPYpGvsQNY6IMdPwCIKzuC+O76/AL5QFqFU
   O6mhvI9khNiwBZxkOFa8AOFyUIWxmfOBUpeOEztEl8srZ1pXbS3gX4oj7
   fV59HoOR9hwTsx0HKZrM0FdjmYgiGh6pDemAx5qTFkgfevRCRLF7Pg9bx
   w==;
X-CSE-ConnectionGUID: T6AR5CCYTva+4fufyNyLgA==
X-CSE-MsgGUID: +41s7RIdQQyQAKFucyFw0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32735627"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32735627"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:17:35 -0700
X-CSE-ConnectionGUID: TWvjsrByT9qHBCZaQCdHCw==
X-CSE-MsgGUID: o3UX7m0QR6qghUMolg3nGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="81516927"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:17:32 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7913B11F82C;
	Mon, 12 Aug 2024 17:17:30 +0300 (EEST)
Date: Mon, 12 Aug 2024 14:17:30 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] linux/container_of.h: Remove redundant type cast in
 container_of_const()
Message-ID: <ZroZelxS_ddHwH30@kekkonen.localdomain>
References: <20240802-container_of_const_fix-v1-1-90e7a5b624f9@quicinc.com>
 <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrX9G2Ol2jt4o-s7@smile.fi.intel.com>

Hi Andy, Zijun,

On Fri, Aug 09, 2024 at 02:27:23PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 02, 2024 at 11:15:15PM +0800, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > Remove redundant (type *) cast for default branch in container_of_const()
> > since the cast has been done by container_of().
> 
> While it might have same effect, the below is explicitly clear about both
> cases. With your patch it will become inconsistent.

In the const case it's actually required whereas container_of() already
does exactly the same cast, rendering the cast done below redundant.
There's nothing inconsistent in removing a needless cast.

Removing it is my preference as well.

> 
> ...
> 
> >  #define container_of_const(ptr, type, member)				\
> >  	_Generic(ptr,							\
> >  		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> 
> (see, in the above line the cast is still present / required)
> 
> > -		default: ((type *)container_of(ptr, type, member))	\
> > +		default: container_of(ptr, type, member)	\
> >  	)
> 

-- 
Kind regards,

Sakari Ailus

