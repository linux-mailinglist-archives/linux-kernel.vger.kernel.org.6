Return-Path: <linux-kernel+bounces-294008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E409587A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971FC283075
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58B19046E;
	Tue, 20 Aug 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMLGBITN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387112745C;
	Tue, 20 Aug 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159576; cv=none; b=Ow1tCMxk3nyHRUuABapVyFq9Vk22HdT5zFqsXdYieTHRJ+3/jry/ucEPRusnhyplKvr3vym9nHCDoU8/HwlW6RKw8Mwcynu80raLRoDBw4Q2Kkp65Q4JbXk3xrnTzNariyPRZgzZOflKDf48xoPLllir15deWmFlpgxrrKnGRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159576; c=relaxed/simple;
	bh=aPgexG4oE2c88za6mvKecAfXWDlnS7gQxWVON+Mpz8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrXlB1buAjng+ul6sQzkMThj/qUBuiFlzULXas6cQrHHT2P2cf6R8dsgadw+CRxp3HrJyeD2XCassKq9qduE8teYrKwqxqTgUQfjdb8ubU9DxmzJW9GOaX237CLHTvnLs/o2nFQs8YZIgirRZsSu6uU1mssgkVXe7BHoXh52CtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMLGBITN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724159575; x=1755695575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPgexG4oE2c88za6mvKecAfXWDlnS7gQxWVON+Mpz8I=;
  b=VMLGBITNYNhEpODwcquorcmgFNCwY2oVj1Evh0E0WQTEYWMMfjabaGFx
   D2WSNkGPl2fPsVu5+fQWjI6akoMi3FP6sycPaZp5SzIF1mq/+2/enE9O1
   aPY07MNtnSnCkYKqkQb2K5pU5FVfO8eqA9yTt18qYE0DK7/cVA7WL1kBg
   lLlnfbBxUw6II5XDTJAf99N5+usE08v0kit9ZlU6akFZtjtek6DmgKaOT
   bhsAXf5yzDy64Cms4B1J/U6HPTVrKuiYySiOrw1wJMj7ovMIfhCNFNx+b
   buP4MJv3Ta75YpLiAywh5ImWTDsd/MXetCMqgQ0fLz7DtDeye5cZmItDq
   g==;
X-CSE-ConnectionGUID: szylp3WCSca9h9J/3l6+Rw==
X-CSE-MsgGUID: 9JvQBcGTSYKatUa4V5uPog==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22427099"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22427099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:12:54 -0700
X-CSE-ConnectionGUID: uwoDjRNUQfiy6bUNw6a57Q==
X-CSE-MsgGUID: zqAYfGooTSqxBHkn9UdOog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60411979"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:12:50 -0700
Date: Tue, 20 Aug 2024 16:12:46 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
	daniel@ffwll.ch, linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, badal.nilawar@intel.com,
	riana.tauro@intel.com, ashutosh.dixit@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v6] drm/i915/hwmon: expose fan speed
Message-ID: <ZsSWTtew8nCYWrxF@black.fi.intel.com>
References: <20240820062010.2000873-1-raag.jadav@intel.com>
 <ZsRup8uKiqUvADFl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsRup8uKiqUvADFl@smile.fi.intel.com>

On Tue, Aug 20, 2024 at 01:23:35PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 20, 2024 at 11:50:10AM +0530, Raag Jadav wrote:
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
> > v2: Handle overflow, add mutex protection and ABI documentation
> >     Aesthetic adjustments (Riana)
> > v3: Change rotations data type, ABI date and version
> > v4: Fix wakeref leak
> >     Drop switch case and simplify hwm_fan_xx() (Andi)
> > v5: Rework time calculation, aesthetic adjustments (Andy)
> > v6: Drop overflow logic (Andy)
> >     Aesthetic adjustments (Badal)
> 
> But it still has an issue with 64-bit division on 32-bit platforms, right?
> 
> ...
> 
> > +	/*
> > +	 * Calculate fan speed in RPM by time averaging two subsequent
> > +	 * readings in minutes.
> > +	 * RPM = number of rotations * msecs per minute / time in msecs
> > +	 */
> > +	*val = DIV_ROUND_UP(rotations * (MSEC_PER_SEC * 60), time);
> 
> ...somewhere here?

Use div64_u64() instead? Or is there a better alternative?

Raag

