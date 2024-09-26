Return-Path: <linux-kernel+bounces-340449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F7987391
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC32B26D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E553717BEC7;
	Thu, 26 Sep 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifVOkBFs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E5156875;
	Thu, 26 Sep 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353659; cv=none; b=JXg0JoQrRWDf5Mu6L6nqBGfubdXm4xnK4U/QuCv1ZYkGA5UOs/sdG8FIKQeOtr19NDmHfW4Qqk7jJV8Rxd6bi30FhMs9GeNWqZKpReffZFu/ZA/Y3/06qhAnN7hteGUZph1armYsKNiE3cT1L5vsrq9ImhzbFZQuyhYmiu2zW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353659; c=relaxed/simple;
	bh=YnO8jzSwusUqP5MrbcUGwNCHwAl9f2jDtgahK2k07Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix62nOlOlrm35B1drG98JzFyK5exgMfx0J2WPmGTWe5+hwAedDZEaUf2Wdc1Ax7Iz1eyUQ5XNWg6dleB7+ipJWH1E45kJ0OwL6tVDZfNjvppj+uwWjIR9WBFgHtThCIuzEGLoc+V//ciGWjSb4QlQ0MMLpsIFGrrbDQKWyXSjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifVOkBFs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727353658; x=1758889658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YnO8jzSwusUqP5MrbcUGwNCHwAl9f2jDtgahK2k07Qs=;
  b=ifVOkBFsHWWuvGt5xPGGmfR+z+fp/VdDFltHVrqice1W402H0cj0c/Yk
   MXXxiiZ3dlc0/mmecO/pEGC6nZhLCw8kbvrssTV3FYFTL3mLRLL4yg4Ud
   kMqlkHhwOzNgpkcpW3kMVfWNDVsVJ+u1TyxdTgNUdSMjG1hHGOKESTQu6
   hfixUJJEKDKjVoiQrCgAxvXBjIHj5JZfkyHmv+/puMSUTyNd1uv7hWFgP
   Mu1v1ofl4UDrE/2P3kbCl7D3NFyCoNspCq4uXACvBl6kndoUpFIcGRfsL
   aQYQwIWkczkoC6HE58CtpUY/j2vpKht/ermHMzdgvA5nSe5AIi8JZgucw
   A==;
X-CSE-ConnectionGUID: RWCEJQ/6Rmql6rmVW3R4tw==
X-CSE-MsgGUID: 7+nQZ3xEQMKfzAt8WU0kaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26309735"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26309735"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:27:37 -0700
X-CSE-ConnectionGUID: DdVHgut6RUqt5LdzA9CnAQ==
X-CSE-MsgGUID: obOfpQMVTlSJ1ji0jd+aqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76907851"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:27:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1stnal-0000000DC2k-1uEh;
	Thu, 26 Sep 2024 15:27:31 +0300
Date: Thu, 26 Sep 2024 15:27:31 +0300
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
Message-ID: <ZvVTMyn9VtuT-tIr@smile.fi.intel.com>
References: <b890361e-e99b-43da-8571-7478b5eab475@web.de>
 <jjsbnitbajdw7dc4plkbb55ezl2cdbnrfws7hnoigbzasvdzua@puhrwwlu4lvv>
 <ZvVPlInCFajkeFy9@smile.fi.intel.com>
 <CAA8EJpo0Q0Wn-GzqmPeNFfG_Hr-o8E7F_VuO47EbxKx=0OQhyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpo0Q0Wn-GzqmPeNFfG_Hr-o8E7F_VuO47EbxKx=0OQhyQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 02:20:19PM +0200, Dmitry Baryshkov wrote:
> On Thu, 26 Sept 2024 at 14:12, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Sep 26, 2024 at 12:26:24AM +0300, Dmitry Baryshkov wrote:

...

> > but in any case the thing is that kfree()
> > probably can be done using __free(). Then PM runtime handled differently.
> 
> That's a separate cleanup in my opinion.

Yes and for that we do not need an intermediate change, right?

-- 
With Best Regards,
Andy Shevchenko



