Return-Path: <linux-kernel+bounces-183539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599E8C9A60
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D872820D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A881F61C;
	Mon, 20 May 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA8WCjpN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B07468E
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197519; cv=none; b=bx9ypcb+DmeirXu+Jibw656B4X2L0qRM47j5Bqv4gFlkK2EbPq6CPCicg6WFHHYFLqCglRIOB467kI9yYtCI03a79PqwXnqKC0HSG0S2yncjXLpPmS5CtB6H+wN++zFzAM88HKlkwq7eEBurEGCSmvWJTlPvG95+I+0w2X6nW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197519; c=relaxed/simple;
	bh=PhZhmPQj8wPJPg41qvten3RwZzl1e+vQG2wGD2LMIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl0yyQSfAejlg6hDz4nOoB0hjwvCUsTzJ/gs/00l8GPf4oqoenVMWkjNtw9hL/xys1/onWA40SsYYYMYinczKXtLq/pf3km3Vl+VIDJ4kRrMnxdxrBv860JSpH1NjvK7dMnbd2aMuYjzdFe9leJEKr5IAIzTad98uOvLIGw/mXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA8WCjpN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716197518; x=1747733518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhZhmPQj8wPJPg41qvten3RwZzl1e+vQG2wGD2LMIYw=;
  b=AA8WCjpNgFmmeKSEno9SKR9+A08suY5e36kpTpHaAirepKeOjn235T9T
   BsLbygCJu/8qoFE5RnkQd17BWem8IpftoS4AiIjpDjusiwyJAJ0RDCRp5
   sAjApeJLglde8okN8+MWAvVGl/+xudOB/2hz6bYftDeigbViUFeQs6Kwx
   XRPtJTO6zalZLnqVrWaBv/iuyhHHpozTCWvfO7B7Z7VZnHBRZM7GSxhE3
   +ab6gtI8m+ekHY1sEPje1+CN76AwLebBum0QDdVyZLigyxR9gQMca2ABY
   3HsZbvwR1JO9QVSBQnG/FU/U3VzlPEoKTMDlzV02UQamGd9aMVVXBU8Cs
   Q==;
X-CSE-ConnectionGUID: iPC86OghRnuY6pupDT3Fyw==
X-CSE-MsgGUID: xhSYd8SuQnmq5inUgvVeuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12186647"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12186647"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:31:57 -0700
X-CSE-ConnectionGUID: QskIDXCVR5WhLqW0lWceMQ==
X-CSE-MsgGUID: GCoo0kANQvKKezPGIVwDtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37237991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:31:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s8zN1-00000009GMu-0CCc;
	Mon, 20 May 2024 12:31:51 +0300
Date: Mon, 20 May 2024 12:31:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, i-salazar@ti.com,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, kevin-lu@ti.com, tiwai@suse.de,
	baojun.xu@ti.com, soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT
 data
Message-ID: <ZksYhr0mDvMeoZjg@smile.fi.intel.com>
References: <20240518033515.866-1-shenghao-ding@ti.com>
 <ZksYBOk_gHprCd_x@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZksYBOk_gHprCd_x@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 20, 2024 at 12:29:41PM +0300, Andy Shevchenko wrote:
> On Sat, May 18, 2024 at 11:35:15AM +0800, Shenghao Ding wrote:

..

> >  /*
> >   * tas2552.c - ALSA SoC Texas Instruments TAS2552 Mono Audio Amplifier
> >   *
> > - * Copyright (C) 2014 Texas Instruments Incorporated -  https://www.ti.com
> > + * Copyright (C) 2014 - 2024 Texas Instruments Incorporated -
> > + *	https://www.ti.com
> 
> Is it okay to wrap the (c) line? (Just asking.)

In another TI driver the form of

 * Copyright (C) 2014 - 2024 Texas Instruments Incorporated
 * https://www.ti.com

is used, perhaps you should align?

> >   * Author: Dan Murphy <dmurphy@ti.com>
> >   */

-- 
With Best Regards,
Andy Shevchenko



