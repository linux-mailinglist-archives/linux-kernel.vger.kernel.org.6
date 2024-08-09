Return-Path: <linux-kernel+bounces-280821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D819A94CFAB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2151F22CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF56192B9F;
	Fri,  9 Aug 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g06YyS1v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344C15B992;
	Fri,  9 Aug 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204687; cv=none; b=CylqQQuazsIP4M23DiB13PTBlagkGcFyG1hlzZN74bnPzW/oHIO88KK9b5vrAInty0fNKH7ExbtFxMXLx3R61ZlSwMOLxGsBid9P6AObiY+qVUjjm7IwS0bGYqweJrj7ImFEA0oqVqBVcmzduXiK2U6lJA8k/LJJiojwVrG2wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204687; c=relaxed/simple;
	bh=p4NghQtm+bbcZA7K1a2/Zh3lpKaq8lRBcQcDk3r3BJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7ivraisF8CGOFI9u4E+bCpBjbDKkZHchdU7LtcblEdW4IEMalObr07RRqMvLnWe7guJSerLeVrta3JD3NnT+RoJSlKP09rauOgxIdT4/E4Sp+p3QTwLc5vvKb1tbJCDJcENP3RzwfqWjogXVck7B1obFe7G19XZNw8pmIxTp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g06YyS1v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204686; x=1754740686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4NghQtm+bbcZA7K1a2/Zh3lpKaq8lRBcQcDk3r3BJo=;
  b=g06YyS1v3MqdA+VkRiwgqaoJRgYcybPai+VPlan9GDxf3KMMmCMMCWjx
   cwGnE67WHKTdmKZOSsBTyeMka1LOeHE9vLvbrgUl1Izr65o9zNp/FCswQ
   hSAbd7V5XBlem0q67x3LhaH+VatSqS5LtiUC23r7AyHLtO2zq428sQPZX
   THhZiIbK1Qkbu427uXOwAvQcxO87x7md5cys2+cMHymAxfa1slEz1DmqW
   HAp2qY7t+EP3bU7Cn3tAPEXfnDDirt2LdDmME9SNftTq0a9kqxhYlVagU
   yidQSrRDBYZubK+gQHNzn1fo7KlMyXBfT1JSGW3MxwZGW+/DN2iH1mxuO
   w==;
X-CSE-ConnectionGUID: v/oaED4XRD6GxrRuCgluhg==
X-CSE-MsgGUID: fDyooy0QTuSgVdbF9W5sCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32784224"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="32784224"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:58:05 -0700
X-CSE-ConnectionGUID: 4APDhaSoR0+u7qOu+pw0pA==
X-CSE-MsgGUID: cKBDlGJgSDKvvpBS/opWWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="61959473"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.245.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:57:58 -0700
Date: Fri, 9 Aug 2024 12:57:54 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch,
	linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZrYEQqs0IwDHWkGx@ashyti-mobl2.lan>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrYB-GI9L2RSc2bt@smile.fi.intel.com>

On Fri, Aug 09, 2024 at 02:48:08PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 11:45:25AM +0530, Raag Jadav wrote:
> > Add hwmon support for fan1_input attribute, which will expose fan speed
> > in RPM. With this in place we can monitor fan speed using lm-sensors tool.
> > 
> > $ sensors
> > i915-pci-0300
> > Adapter: PCI adapter
> > in0:         653.00 mV
> > fan1:        3833 RPM
> > power1:           N/A  (max =  43.00 W)
> > energy1:      32.02 kJ
> 
> > v2:
> > - Add mutex protection
> > - Handle overflow
> > - Add ABI documentation
> > - Aesthetic adjustments (Riana)
> > 
> > v3:
> > - Declare rotations as "long" and drop redundant casting
> > - Change date and version in ABI documentation
> > - Add commenter name in changelog (Riana)
> > 
> > v4:
> > - Fix wakeref leak
> > - Drop switch case and simplify hwm_fan_xx() (Andi)
> 
> I do not understand why we pollute Git history with changelogs, but it's
> probably the ugly atavism in DRM workflow.

I never liked it! Besides it should even be against the
submitting patches recommendation.

I don't understand what interest might have someone in a couple
of years, reading this commit, knowing an unintellegible list of
differences between v2 and v3.

I consider it a random pollution of the commit log.

Andi

