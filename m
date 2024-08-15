Return-Path: <linux-kernel+bounces-287894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B029952DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E061F24B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652B1714D5;
	Thu, 15 Aug 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzWelHPf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AD146A6D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723471; cv=none; b=ce2xV7cvt04H/TP7rEn3DDZ3ndio13iIKGEIfiqIYukpXg3YaRtfswbTP8Vt1F+cTbraBY2rgaAnY5XgO2lnh0SJiMraCLXjY3Lt/8p7NzC8WwOd8bJOTTlBbht42uLKzVz8uo0BeXvzPUJ15lDKDRFPHcOf6uZCEi/ucs2gtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723471; c=relaxed/simple;
	bh=yHydkaB7mV0to4o1OlyyrC234NnyXN2FRI8n4mFL3ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLrG6WFrDfMoRsd2cSeRipH1+6s9dnt1KorzKLxlGNBgy7nTEtmEkN9eP+Cg4DUGhL6ZYBwbGtNjwcS/M6wHuBWT01WGql07/CinHYyVK0+Vw89LT4dzaYMTLRhIoS9r86hVwK3bZPw+4id+51A7Aj9tzJAWBHFGXmtuRPz6wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzWelHPf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723723470; x=1755259470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHydkaB7mV0to4o1OlyyrC234NnyXN2FRI8n4mFL3ds=;
  b=DzWelHPfVm4JA8BYPY+Odor79s5woac+Y8EfrpBSe4Rl/EQhOnw2Gin4
   1ptgdy0YekjS8r8ol5GCXAvqMaKtlYguiv5EWhKTo3kW561bueL3Pqvdc
   VCvxB197DXQ65SI5Zy29x7tv/75Zpp4wDdYNlylmpHrVgQRjLeGwtLNoH
   f0/AcIFYe1S2yawxwf45e54iE+xu2qpWnTnNNsZ/iO2SFDCxsGcEUXFYi
   D5FHbO7MZtva6vHOogVNqE0eAeXvrca0yQgM0XK9g00797WpX4Zy0MBNw
   e9z8qZ6edRRe1/gxH+qBOLG6gOHb/hU5LXYJVq0QP+aiFxp5BfvQ7rHtS
   g==;
X-CSE-ConnectionGUID: hzubtVDPQmW88ywQJxlWCQ==
X-CSE-MsgGUID: 0KLB8uNCTzSqdo/kVNXyAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32608987"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32608987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:04:29 -0700
X-CSE-ConnectionGUID: eLkWGLmqR+yANPMnofdrxQ==
X-CSE-MsgGUID: DTybqODiTZWVCd6mzcTxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="96852637"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:04:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1seZDG-0000000FXp8-0mub;
	Thu, 15 Aug 2024 15:04:18 +0300
Date: Thu, 15 Aug 2024 15:04:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"zhourui@huaqin.com" <zhourui@huaqin.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Salazar, Ivan" <i-salazar@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chadha, Jasjot Singh" <j-chadha@ti.com>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"Yue, Jaden" <jaden-yue@ti.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Rao, Dipa" <dipa@ti.com>,
	"yuhsuan@google.com" <yuhsuan@google.com>,
	"Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
	"Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"judyhsiao@google.com" <judyhsiao@google.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"cujomalainey@google.com" <cujomalainey@google.com>,
	"Kutty, Aanya" <aanya@ti.com>,
	"Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
	"savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
	"flaviopr@microsoft.com" <flaviopr@microsoft.com>,
	"Ji, Jesse" <jesse-ji@ti.com>,
	"darren.ye@mediatek.com" <darren.ye@mediatek.com>,
	"antheas.dk@gmail.com" <antheas.dk@gmail.com>,
	"Jerry2.Huang@lcfuturecenter.com" <Jerry2.Huang@lcfuturecenter.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name
 to unify the name between TAS2563 and TAS2781
Message-ID: <Zr3uwfNLtTdJWrz4@smile.fi.intel.com>
References: <20240803032717.175-1-shenghao-ding@ti.com>
 <ZrovmRCPN7pc0n40@smile.fi.intel.com>
 <9ec30bafdec441078828cb0d7be93342@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec30bafdec441078828cb0d7be93342@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 15, 2024 at 03:02:01AM +0000, Ding, Shenghao wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, August 12, 2024 11:52 PM
> > On Sat, Aug 03, 2024 at 11:27:14AM +0800, Shenghao Ding wrote:

...

> > > +	strscpy(name, "Speaker Profile Id",
> > SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > 
> > > +	strscpy(prog_name, "Speaker Program Id",
> > > +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > 
> > > +	strscpy(conf_name, "Speaker Config Id",
> > > +SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > 
> > Why not 2-parameter strscpy()?
> strscpy seemed not support 2 params. Do you mean strcpy? 

1. It does.
2. No, I meant strscpy().

-- 
With Best Regards,
Andy Shevchenko



