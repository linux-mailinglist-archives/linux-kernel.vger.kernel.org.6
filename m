Return-Path: <linux-kernel+bounces-313198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FCD96A1CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA91F25775
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A8D185B7D;
	Tue,  3 Sep 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afdix5gu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C294183CB7;
	Tue,  3 Sep 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376482; cv=none; b=MlXc7RKVnyn/KWtqqOVRhwIfw7CgDST2i6xH3H7DLt2D+MCJOT0FtI5ePJj8wvun+Fia1oU+P8VMkcF4e52gEj9AfEtg1hNyBf/r43kpM2TxkWecWuQ5T/mUIYCFwQwQMhAeULqYbbxCe0RI9Z+Cw6dYGmVugIus2J3VXpqg2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376482; c=relaxed/simple;
	bh=VE5Ytzp4eJgJGQ5VNZPfsM42CWX0haJpfTqJ3Nm6X2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXKZCOeUcA3PwgHxiIOvYeCCpsB18ZKQtRTBFrnmggHMANL+PrPBOOPYzwahMpOkAvUguS0nX5cCJJY08zqhCQhmqAzIVwOMqemqLJvuXL8Bo85q/dw4pVkek0wmfMUdCVx9VuVxsumVvkLTYS2EoYgnz1v0m+VtWMqpCZl78/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afdix5gu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725376480; x=1756912480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VE5Ytzp4eJgJGQ5VNZPfsM42CWX0haJpfTqJ3Nm6X2k=;
  b=afdix5gugoeQ6p+ChyUJaQI8XjcpgBdQu1l3ycHe29weLM4I+v05lgAc
   sw5NeoS+uQHTZbsbjQyvLjM+8kktZrhVffws52y2WqBlHMYUmdXyUU+sO
   811OgafUBLMFUAD+owmXkjcT5kp5ahcBrhnHBaUFMKsSwhO7qVfH3nZ0v
   rqY3Lrv9K7Nn5zrnsH/KhviHrzAKmE6LHfUoVmlI4FTvhxX77rPMF6dWl
   8lrDJYTXhSv16uAFQ24yq4+eMa6HcvQuugBM7U0m7FB+hkBXH1TEC+vQ+
   FQ0/6K/eUKvgylOa1DxwJUBVenCQ7cC2w1qICBDbVlC9po4jFfFH/itpG
   w==;
X-CSE-ConnectionGUID: 1S506a/wTlK353S6eVADsg==
X-CSE-MsgGUID: WPF8+UyWSWWW+8TZbXQrGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27867598"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="27867598"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:14:39 -0700
X-CSE-ConnectionGUID: 9gos7tFFT9Woy+s26KxsAw==
X-CSE-MsgGUID: wt0yJ3GTSiuTsWUHphEqew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64938947"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:14:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slVEn-00000004kWF-1ROJ;
	Tue, 03 Sep 2024 18:14:33 +0300
Date: Tue, 3 Sep 2024 18:14:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gergo Koteles <soyer@irl.hu>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the
 scope_guard() clear of its scope
Message-ID: <Ztcn2Yu2TNSOYbhP@smile.fi.intel.com>
References: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
 <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf8c73dd91dbbb11b562a5e0d9ac6b4035c32d28.camel@irl.hu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 05:00:51PM +0200, Gergo Koteles wrote:
> On Thu, 2024-08-29 at 19:50 +0300, Andy Shevchenko wrote:
> > First of all, it's a bit counterintuitive to have something like
> > 
> > 	int err;
> > 	...
> > 	scoped_guard(...)
> > 		err = foo(...);
> > 	if (err)
> > 		return err;
> > 
> > Second, with a particular kernel configuration and compiler version in
> > one of such cases the objtool is not happy:
> > 
> >   ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section
> > 
> > I'm not an expert on all this, but the theory is that compiler and
> > linker in this case can't understand that 'result' variable will be
> > always initialized as long as no error has been returned. Assigning
> > 'result' to a dummy value helps with this. Note, that fixing the
> > scoped_guard() scope (as per above) does not make issue gone.
> > 
> > That said, assign dummy value and make the scope_guard() clear of its scope.
> > For the sake of consistency do it in the entire file.
> > 
> 
> Interestingly, if I open a scope manually and use the plain guard, the
> warning disappears.

Yes, that's what I also have, but I avoid that approach because in that case
the printing will be done inside the lock, widening the critical section for
no benefits.

> 	...
> 	unsigned long result;
> 	int err;
> 
> 	{
> 		guard(mutex)(&priv->vpc_mutex);
> 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN,
> &result);
> 		if (err)
> 			return err;
> 	}
> 	...
> 
> This looks a bit strange, but is probably easier for the compiler than
> the for loop of scoped_guard.
> 
> But I don't know how well this style fits into the kernel.

-- 
With Best Regards,
Andy Shevchenko



