Return-Path: <linux-kernel+bounces-169516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1EA8BC9D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D828C280DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102581420A6;
	Mon,  6 May 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hufegg8v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5306CDAC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985105; cv=none; b=ejSxJx/1GZ8m8H/uGfYhp5ht3LymWgutkIvZj3oJx+2lTyfDFqOUlEnStalN2+fRfU04pJyeUVTvxkILD0wmuWuFiF5251uGg+j/H4mRo1TsQtWGTYvbhvyvCnnrFnYkJqzWUTP2albkZUxqhz9CWYbK3k2oeOQdb4SGvZAnCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985105; c=relaxed/simple;
	bh=rptVwfb1xtN9n0vH393IeRH5HJZCQBBxcHYPZ20BChQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5NUWWXEaANwioySAmji/jtWBXtvj+HVDkZQXaLPN6KULSSQgH2Ht5ydam69igkNkOjX4bcXNZw/gK5ffi5IyA1n7Zmk45BUieh0VlE1sw+QM9sdAYpwQ7i+JR5GwvYJC5Y2+ot5PQLzG7b429CQZR9JXfHCbaOkKJfnO8N7R9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hufegg8v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714985104; x=1746521104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rptVwfb1xtN9n0vH393IeRH5HJZCQBBxcHYPZ20BChQ=;
  b=Hufegg8vWCASbwzfByvWGvh2nsppsv0vsowr4VbuCnVKFAAo7VUPGsM9
   RLscM2vDluQX+o6kGGmignSCKFgmxjq2CW59K7kM0NSS8Bs3+fqtJJwaT
   hAWU7V412RwniaRgryw5S0wynU9zfSiBSovdC2thClUpzS3BrSJxpsuHn
   43V+iy1YEj2ZweYpcQsrUDXZAt1hJ5yEBQSrzCjpilBdMtZVaZAfRGTWy
   QgnyyIFfPiXo+IGQ8u42oOQPwz2vfnYXIdiYTaEdnsjjFlUQVlUNinZIE
   FSH1t16fdwDOrR5DgEuZFtGkob1ujUkJFxtLvl3XDG87FIUVFBntEg3Ee
   A==;
X-CSE-ConnectionGUID: PSmRJtE8TJGnzBureZwrhw==
X-CSE-MsgGUID: NTsdNAxISLGpph9+Zal8hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10563351"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10563351"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:44:54 -0700
X-CSE-ConnectionGUID: XqjTsAL5TTGRGmP7RZWP5Q==
X-CSE-MsgGUID: TX85tZunRoCaKYxlFs4B1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32605261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:44:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3txm-00000004c5p-3lwj;
	Mon, 06 May 2024 11:44:46 +0300
Date: Mon, 6 May 2024 11:44:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"P O, Vijeth" <v-po@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification
 for add tas2781 driver for SPI
Message-ID: <ZjiYflatVz7F_2em@smile.fi.intel.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
 <20240418040240.2337-2-baojun.xu@ti.com>
 <ZiEKc4OTVlOt8llU@smile.fi.intel.com>
 <0c7b29075dc347299602668660adb4b6@ti.com>
 <ZjNpX6TvB4Vv1akq@smile.fi.intel.com>
 <d96bea0bacc842e0b30a100f43ff264f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96bea0bacc842e0b30a100f43ff264f@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 06, 2024 at 07:44:05AM +0000, Xu, Baojun wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 02 May 2024 18:22
> > To: Xu, Baojun
> > On Thu, Apr 25, 2024 at 07: 54: 41AM +0000, Xu, Baojun wrote:
> > On Thu, Apr 25, 2024 at 07:54:41AM +0000, Xu, Baojun wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: 18 April 2024 19:56
> > > > On Thu, Apr 18, 2024 at 12: 02: 37PM +0800, Baojun Xu wrote:
> > > > On Thu, Apr 18, 2024 at 12:02:37PM +0800, Baojun Xu wrote:

..

> > > > >  sound/pci/hda/Kconfig                           | 15 +++++++++++++++
> > > > >  sound/pci/hda/Makefile                          |  2 ++
> > > >
> > > Is this correct? You are adding a dead "code", isn't it?
> > >
> > > What's mean "dead code"? After add CONFIG_SND_HDA_SCODEC_TAS2781_SPI=m
> > > in my config file, the whole patch code has worked.
> > 
> > Is that file already in the repository?
> > If not, I don't see it in this patch either --> dead code.
> 
> When I integrated CONFIG_SND_HDA_SCODEC_TAS2781_SPI and compiled the whole kernel,
> it used to popup the following message for TAS2781 SPI module in first compile:
>  
>  Build TAS2781 HD-audio side codec support for SPI Bus (SND_HDA_SCODEC_TAS2781_SPI) [N/m/?] (NEW) 
> 
> Normally, selected m. And TAS2781 SPI module would be compiled.

The above is a dead code if this SPI driver is not yet in the kernel. Is it?
What is the path to it in the current kernel source tree?

-- 
With Best Regards,
Andy Shevchenko



