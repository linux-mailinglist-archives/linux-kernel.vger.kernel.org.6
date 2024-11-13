Return-Path: <linux-kernel+bounces-408193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E959C7BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5411F2153D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF796205150;
	Wed, 13 Nov 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dd1EPkdh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5442038DD;
	Wed, 13 Nov 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524122; cv=none; b=puT5evPHDntrCPjwgB5DvXhQDnSOu7yX7VVtXs97KseAK7H1U4F+eWITU369MZCLObGpP9h+91DKzrF3M9kcyDSVhdjITApiSApPusQwZRmaBneS5hIjdyyRjAYrFNp7hVvMohZ3i+Yib9iytFKn65J/tMz1ikor3DHI2AcGOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524122; c=relaxed/simple;
	bh=ilWFGCUUNIXRjZzE+xZydZS7gAs9vG0Nt5a/KjvBm9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3v/EuPyTycWBsvIEWxd8Ay8XtwcSLWN99JCq0g/siv+INQ9qMTiwoPyQPrAd08/crckT6ugIAHwNzvOfBrhVeVyk6clgt+gdp0IftSQBZEdr2Ui+duNzZhUR+bEiR9rFBf7vtheQA6kzDn1FbXbrNqL5rcHeeDExxnXh4lnrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dd1EPkdh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524121; x=1763060121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ilWFGCUUNIXRjZzE+xZydZS7gAs9vG0Nt5a/KjvBm9A=;
  b=dd1EPkdhJWYigNbA2rjPA27BT+np8sEBfTwUZ5sDY/sqijRo2SP2GakQ
   GoyRzdfdyEht3gquUHtslBIMZnP+y/I1P8L4u8yXm3clNUm73cB1mFI2s
   iuKyeTVV+0KukOBgFdT9MBiEJU1jrOC6PnywPedwwY8vQyyp2DGLqdkIX
   OFtvfS1ms69XzFU8OmavrS5HAqkjXIzFtDBr6RXcw3CTsVDbn+kK4FQ6k
   fwGQ6PRhyz4jFBP2jNehpiWO0bsSP0STyuslDTUfxcR6ce6MJi+okPcWu
   TFskC13k9Abqk8F/xj75KDY6uPNrihLUuzFD+goaIME8sCmAzE6uXdm3S
   Q==;
X-CSE-ConnectionGUID: TH0taclzT6KeculwakwaZw==
X-CSE-MsgGUID: NiD2AT3DTIyD7RUpaPzQ5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31530028"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="31530028"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:55:20 -0800
X-CSE-ConnectionGUID: gtjGOpe9SvabGGxSDfwBKw==
X-CSE-MsgGUID: y8CrQhEGSeOE1lH1PJhGdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92885745"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:55:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tBIWG-0000000ERnJ-1GiJ;
	Wed, 13 Nov 2024 20:55:12 +0200
Date: Wed, 13 Nov 2024 20:55:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Baojun Xu <baojun.xu@ti.com>, robh+dt@kernel.org, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	shenghao-ding@ti.com, navada@ti.com, 13916275206@139.com,
	v-hampiholi@ti.com, v-po@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org,
	antheas.dk@gmail.com, philm@manjaro.org
Subject: Re: [PATCH v4] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <ZzT2EE3-PxLj3bDo@smile.fi.intel.com>
References: <20241104093138.4819-1-baojun.xu@ti.com>
 <87ldxnuw1s.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldxnuw1s.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 13, 2024 at 02:01:51PM +0100, Takashi Iwai wrote:
> On Mon, 04 Nov 2024 10:31:38 +0100,
> Baojun Xu wrote:
> > +	// Speaker id was needed for ASUS projects.
> > +	if (!strncmp(sub, TAS2781_ASUS_ID, sizeof(TAS2781_ASUS_ID))) {
> 
> Is this really correct?  The sizeof(TAS2781_ASUS_ID) is 5, including
> the terminating NUL.  So this becomes equivalent with strcmp(), and
> it doesn't check the sub-string.

It all depends to what that method returns. If it returns the exact string
then strcmp() is fine, if not, we should understand what it returns then.

-- 
With Best Regards,
Andy Shevchenko



