Return-Path: <linux-kernel+bounces-355562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7199540E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F68F282219
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA901E0B91;
	Tue,  8 Oct 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKD6qWZE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0A64A8F;
	Tue,  8 Oct 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403813; cv=none; b=SC9UJR98wvhQEmksPnricK3SROGVq55uazkUu9g1Qdj/xp40BOPrR6i5yE//nKWwCeVdXCGaFO0j9o6eKADkxFcW4aRWdzhcKCoLte9OQNFeYhd2c+2gaJqIFrwpArsMFkW7BunRfKtlGFk5tKDL3fPlSgEvA3ZfGmimp+A46xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403813; c=relaxed/simple;
	bh=Jqt51uv11WaJ2wYSsFLauwhBG+IqYiIyY54lrvUrEx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Own++pXpb+NZoUawz1JMoE8/gFBamj0syYBDNlQkXPThbB1mnJjr7MDXHgiLVwtHDpLTp5XaENqcKIFHUsZ8pQjcqOQKzpXQ/npgawXRxXaG9IIG7/EFZpATu1hxFXJ4mMCoH2uBsfVXM8yeDadJ8MqLsHj80nHCjoloOIV3ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKD6qWZE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728403812; x=1759939812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jqt51uv11WaJ2wYSsFLauwhBG+IqYiIyY54lrvUrEx4=;
  b=JKD6qWZE+xSdNg4wevb20GfhDx3tbctPcQElQB6v6OriF8oZCNG9tPWk
   QFcc6VmaXnJasHSbcW0tQqnIktlojsdT8B529wiaPwaks/izMi2hYo9Mb
   7bWwS3MZSpY/al0mqbD+WiLTRSdFQlrKh3EyEurTzojyIRoSRBOVlS8PZ
   IMyi+IQGxo32NaWFlKryk1b3zwHMbxzhuO84bflTPsBqmQPuwW2EUSBo4
   dJ1qD9vk1dmA0p5GHdkOXY7lpDdIs54XjALMJz3uoAkft4RWDkam5Qqw+
   t874SDW/XD0ByxOv34K1wTK/jFpWucYmrDm9X2gquBBfpjDPphd9A9C2O
   Q==;
X-CSE-ConnectionGUID: jM2giKVYSaiAZfnm1veloA==
X-CSE-MsgGUID: tLwP50HxS/mp8T7TrioZ+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38183801"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38183801"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:10:11 -0700
X-CSE-ConnectionGUID: rfMMT9K5RoC2YZkugt0plA==
X-CSE-MsgGUID: w/X4QyNoRCi52Jz8Sqd5DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="99223278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 08 Oct 2024 09:10:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5CC1720F; Tue, 08 Oct 2024 19:10:08 +0300 (EEST)
Date: Tue, 8 Oct 2024 19:10:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [PATCH v2 1/3] xhci: pci: Aling the naming for Cadence PCI ID
 0x0200
Message-ID: <ZwVZYOu78QX-lYXg@black.fi.intel.com>
References: <20241003121729.3867216-1-andriy.shevchenko@linux.intel.com>
 <20241003121729.3867216-2-andriy.shevchenko@linux.intel.com>
 <2024100417-graveness-irritably-d31c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100417-graveness-irritably-d31c@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 04, 2024 at 09:48:35AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 03, 2024 at 03:14:44PM +0300, Andy Shevchenko wrote:
> > Rename the PCI device ID to match what's used in another driver.
> 
> If the same device id is in multiple drivers, why not add it to
> pci_ids.h like is normal to do?

Also an option. So, Mathias, please, skip the first patch, seems we can
do better.

-- 
With Best Regards,
Andy Shevchenko



