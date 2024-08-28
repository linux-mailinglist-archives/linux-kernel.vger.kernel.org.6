Return-Path: <linux-kernel+bounces-305389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271AB962DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A938328740A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF21A4F1F;
	Wed, 28 Aug 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGy9QFle"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B651481B3;
	Wed, 28 Aug 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864310; cv=none; b=PUEDz8Q5QlKAvgnbIiWe3lFG5iOTBBCWttviKw1O5uBIn2H9dceQ70NY45YTLiWgVSrGt4Nd1PQTwvGwgqNhI99RMuwODC43kz7OSktYWeCmMANeIyL4w9GDKHvwWw1IZMB/FuKtyO3YG/LHVwBRBYzG58Q/Y5NB7p7F7yNgQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864310; c=relaxed/simple;
	bh=WICbGCEGxKFHDucqOiaVRx0SdTB8zP8nY6yJaexlPgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFqr3ru56OPup4Hj6gjZ//n09gs7xTE394P7tVaLZYPnH01ZHbM7m2YlI0AYxzYfpgLR/6kSMxcjNixbNMDOzyW6gGKyKnfutqnZr/nbG8WQpcnO3ss0WBeQp/jeu0wYJIX17Eaw7/lJkLy3BD3mXeo/ZREXcT2tyEhPI0nHK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGy9QFle; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724864308; x=1756400308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WICbGCEGxKFHDucqOiaVRx0SdTB8zP8nY6yJaexlPgY=;
  b=CGy9QFlewjAd+eyQBa1FcoGLykl4n4NlzdDC6BF85nIuxKbQuX2B5ffc
   yM83ZfJ7+rW6yywd5nsaA0krOJhz7/NejohosALRzxiHxnjkuaCW9qqwK
   j6S0JuHa67wGVUFSpGu8b2CJO6VJ0b5pm2l1S4HrK2sluuzbM5MLETlVo
   bZRdX/FwoDfGZcvNVRxwi6s/+xebWGznyt2CMKE2OG+Lji0JdF7kn4/hI
   hkL7IsITg8kt7Lr6UD9ODU5hsVq3PSOCZqg2+CoLKaYAJD+xMSfoZYg+e
   2oML5nVciNYBNpLYowtRzp2vjSfienw+Bd8Pvldk7LwrvUlGWLT4OzUzw
   Q==;
X-CSE-ConnectionGUID: yc2ISsiCSNi0ezKW6gmSmQ==
X-CSE-MsgGUID: M4Yslr23S7KYotqNFpMT8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40912215"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="40912215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 09:58:28 -0700
X-CSE-ConnectionGUID: acWaujrgTLKnGn8xfjGT7w==
X-CSE-MsgGUID: 13/3drV3Rzi/E0zXYFs1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94090533"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 09:58:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjLzz-00000002ilO-2Gu8;
	Wed, 28 Aug 2024 19:58:23 +0300
Date: Wed, 28 Aug 2024 19:58:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <Zs9XL1SwyroU8qE0@smile.fi.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
 <2024082443-mulch-junkie-1f9a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024082443-mulch-junkie-1f9a@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 24, 2024 at 11:08:53AM +0800, Greg Kroah-Hartman wrote:
> On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> > In the similar way, ignore 0 error code (AKA "success") in
> > dev_err_probe(). This helps to simplify a code such as
> > 
> >   if (ret < 0)
> >     return dev_err_probe(int3472->dev, ret, err_msg);
> > 
> >   return ret;
> > 
> > to
> > 
> >   return dev_err_probe(int3472->dev, ret, err_msg);
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you!

Hans, I think we all set to proceed with this. Do you have any comments?

-- 
With Best Regards,
Andy Shevchenko



