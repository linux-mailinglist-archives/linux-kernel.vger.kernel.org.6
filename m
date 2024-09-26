Return-Path: <linux-kernel+bounces-340432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23524987358
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39D61F28369
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052717AE05;
	Thu, 26 Sep 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS6C7Ne0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00078C90;
	Thu, 26 Sep 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352757; cv=none; b=Ellv1PLUQvtvoL3tvXlT8nokDZLH3mf4PMHMt/WaRBrwQKN6kRxTkxoJ+tR237xgTOrtkenzqMxBwk7I2mfUz3AG3gp/UVu65kzSnrmKMjDnt2l5BR/vkUysek3VAh5BVtyMXzJrTrI2f4eSQn2UuzPN4TwZ9HVOmOhmkFz+a/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352757; c=relaxed/simple;
	bh=3f2PlrxlmtzV9bX8QaJPEWHju7M5P+yDbVSMqF02t3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSWcxx+Ba0l8EC0gIPO3I7hEr4VWUElZtfY+j8wMDkCwVFo7Odw3tpZXratFFVOTw9T6KwkEbt/Sb26loiuxjsJLE7snToVamXAF/gUZOZWlzAgU9qhAj9l63me6n7bdu9oIRTZikqMTV4beCVWHdYEyG27/XudQSd9xAZX/Ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS6C7Ne0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727352755; x=1758888755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3f2PlrxlmtzV9bX8QaJPEWHju7M5P+yDbVSMqF02t3g=;
  b=bS6C7Ne0padragF3UhIWDYjKNJnalKjFNKM7gE6LYsWBRGh0m5zhGE0T
   HCnwK2+BVpVvYDPmlhkMya7BGdxlS3469EV7PA/mzbvRK/x3qRjKkDhC8
   8h2qbR7zzijalIfXP0ZkmbsouBrbrvLqzjA+j7qtsDh8kMWvlJ8o6NVfW
   gnTrGMQXpHPNkqTLDwoe1zZCKNPb6+n6I697trpMkl4m8phMAt8BMIxI3
   4IdQLC5qsmdI3pS+bfBozlyn4a+8zWmczv+vHlew3y2pP34vG98VdD5Od
   Mb5dESoYx1h1ejZK5oPNzIYu5VX+0QL13VFSYfQc9GyDUPPrLA90yuU6M
   g==;
X-CSE-ConnectionGUID: 42oz2T67T92UjghuArd4cQ==
X-CSE-MsgGUID: jf5arXABTRa8jEt1TPLGQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26579854"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26579854"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:12:10 -0700
X-CSE-ConnectionGUID: XUaBbbtrQf+w9SVZVGuJPQ==
X-CSE-MsgGUID: 6uWSaNQUTgaXk7bdCwqo8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="77050081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:12:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1stnLo-0000000DBma-1Xhj;
	Thu, 26 Sep 2024 15:12:04 +0300
Date: Thu, 26 Sep 2024 15:12:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-usb@vger.kernel.org,
	Ajay Gupta <ajayg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haotien Hsu <haotienh@nvidia.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] usb: typec: ucsi: ccg: Adjustments for common code
 in two functions
Message-ID: <ZvVPlInCFajkeFy9@smile.fi.intel.com>
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
 <jjsbnitbajdw7dc4plkbb55ezl2cdbnrfws7hnoigbzasvdzua@puhrwwlu4lvv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jjsbnitbajdw7dc4plkbb55ezl2cdbnrfws7hnoigbzasvdzua@puhrwwlu4lvv>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 12:26:24AM +0300, Dmitry Baryshkov wrote:
> On Wed, Sep 25, 2024 at 07:31:04PM GMT, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 25 Sep 2024 19:19:01 +0200
> > 
> > A few update suggestions were taken into account
> > from static source code analysis.
> > 
> > Markus Elfring (2):
> >   Use common code in ccg_write()
> >   Use common code in ccg_read()
> > 
> >  drivers/usb/typec/ucsi/ucsi_ccg.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> For the series:
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I believe there is no-one to take it, but in any case the thing is that kfree()
probably can be done using __free(). Then PM runtime handled differently.

-- 
With Best Regards,
Andy Shevchenko



