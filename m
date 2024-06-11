Return-Path: <linux-kernel+bounces-209969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAC903D84
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B21C2306D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB517D880;
	Tue, 11 Jun 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+IxYcdr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989C17D35F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112850; cv=none; b=rKSGIbT9s5QbuRoVdCVkV1bhcybPKFT3IPtO7o5oU3V6uzk+9af/1Y9UolCw5sh5beM3a+whPDnv/vVbgkoFiI8xlmt38kGF5fNzziUYmFRzuvByX+AlCJybm1VriFgrnSZ6A9xQCmbiZNHoHKzGnTsVR6a0L7uws5DUznvA0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112850; c=relaxed/simple;
	bh=SwpplB4JSy1bF45K4tpsmb//2IRRz4TkaZ4mbEE+tk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUM0nAuxeU5DRLi6eVQb/lqn3p+gN2c0HHbmOPvmhq3IODHH7C8a2W24KrGX2gibHuzIXfiV1npUFS38u4dH7xRRb18khVnsr5SxTaw6+aYg6bIJ7GTC0tT6BO003l2MCP81O5GnGv4+c5JGkarv43Gpg8cvARbAwI5eS6X8+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+IxYcdr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718112849; x=1749648849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SwpplB4JSy1bF45K4tpsmb//2IRRz4TkaZ4mbEE+tk4=;
  b=n+IxYcdr8vt/a0ffRIDLJ5l0j4CLjFvNxZ7oifm6NRgK567/OCrxv7Qb
   YfG4i2RxBh/QSF68KCHSABs1RyUkQ/fy4Z2KMF2wftgg8s7E3Df/HPzQM
   MrPDJFxAh6DcnBR+Fc4ofm5Mmb3Dck834VzectYyYJoGYNrS3/xKfznk2
   uTr+hRVu3yDtvGNr8vxoaRfdSZ52tC0Ov429CKJmjbhDOEMWHEjVml+Yz
   h2MQ/z2Wu375OkXCNETakDjxJD3+GcGW3QbrKGe56IwzWnZ6GkqJSzFZa
   LEed9AVR01eXO4+wlQEOGxRzdUTKO2YzeQphKC5sudt7BDQGB1dJX2t9I
   g==;
X-CSE-ConnectionGUID: 5/9F3FAIT0OjYinugpG90w==
X-CSE-MsgGUID: gPVk4eBpTFO86fqZn5LkLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="40223746"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40223746"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:34:08 -0700
X-CSE-ConnectionGUID: KMu7RY8WSX+7ERkVR43LFQ==
X-CSE-MsgGUID: KbUVOKdoQo6Fa9+tblZJ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40149337"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:34:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sH1dT-0000000FY6k-0Jxo;
	Tue, 11 Jun 2024 16:34:03 +0300
Date: Tue, 11 Jun 2024 16:34:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/mipi-dbi: Add missing MODULE_DESCRIPTION()
Message-ID: <ZmhSSvT0pxp3Sz8s@smile.fi.intel.com>
References: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
 <ZmDMxtDz5aq0xom6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmDMxtDz5aq0xom6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 11:38:31PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 25, 2024 at 03:56:26PM +0300, Andy Shevchenko wrote:
> > The modpost script is not happy
> > 
> >   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mipi_dbi.o
> > 
> > because there is a missing module description.
> > 
> > Add it to the module.
> 
> Any comments on this?

+Cc: Jeff, FYI

-- 
With Best Regards,
Andy Shevchenko



