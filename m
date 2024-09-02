Return-Path: <linux-kernel+bounces-311057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C007968463
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FDA2852E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3B13D503;
	Mon,  2 Sep 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+8YLqyj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5461FEB;
	Mon,  2 Sep 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272184; cv=none; b=P0tbtUwXXfInEa+slJ0Lg/ket13Td0DOOqIJ9VvEf1IYavMrE2k5WdLo6KYXqc9OcwpkxPDzcFgoFXY2/wVIO8AtErCHmQVnZBhdCSk1SaaaREs3x3bt5A4KeoyKY0aZx6SnFekIBzwiT0kr3rk9PI9B2T2US3cy0WH5AyCvjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272184; c=relaxed/simple;
	bh=XyE6avxnHkZeJ9HyHaHOludncMbEkZubHOK1HuVjkEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2x/i+4/XIFFBMIkEWHQsRfjdTzdJ53NoeBDamrNBsnSIKAoO7TigKut3/+ysHTdpsY8eXjc2nh6FlHwheZZf/+HEYO3i4U9Gq0S0C+5rxo1+tO+REjdraQ+u9zmkHV1VuG+EM7CL8rzJTiniQRXJM5XtuyXMll2WhDuWJUyD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+8YLqyj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725272184; x=1756808184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XyE6avxnHkZeJ9HyHaHOludncMbEkZubHOK1HuVjkEM=;
  b=h+8YLqyjx+uX/RZO2erSt5Q+W4aVaXHXjTqjOO4D1uLZeEpMSnjaiROe
   sSuLooo9mUT8vXIcNjwt8C/ZXZ/lEdvBhv/4a9I5JqdZ4odtunt1ZnYma
   4JeCqW6vhMTFPeMn5NmiSx+2cTqc/aTS9vJ/LsVGV02hh75WTvV4+010x
   eG4LslFhVw6seRrmfm9+lkdTvsHjrJQpMy37TnKdobGVGMOvw8o3ACZzn
   58jRFd2KfaOys1auSIRcb5XnmZE93S2WaXvoh6CDpAl5FEWBlabj72i0z
   MEdGV2FhGivSeaANhcBItLvWYlPk81XtPcofGtSh1ixH+OrVop0nhZNGQ
   g==;
X-CSE-ConnectionGUID: eSyvu+5HTuizrqCOqX7qAQ==
X-CSE-MsgGUID: ywX6demgR0ur25P4uG6JXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23714704"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23714704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:16:23 -0700
X-CSE-ConnectionGUID: +GHyJoJRQ9mcWg3rXB2ECQ==
X-CSE-MsgGUID: LYM67pJXQhK4VeuFp0GMYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69438724"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:16:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl46b-00000004Jcd-1kvy;
	Mon, 02 Sep 2024 13:16:17 +0300
Date: Mon, 2 Sep 2024 13:16:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <ZtWQcXerriSnWgf1@smile.fi.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
 <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>
 <96a19237-9380-4173-9e52-e8295a0f4883@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a19237-9380-4173-9e52-e8295a0f4883@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 31, 2024 at 11:53:51AM +0300, Dan Carpenter wrote:
> On Sat, Aug 31, 2024 at 11:25:54AM +0300, Dan Carpenter wrote:
> > On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> > > In the similar way, ignore 0 error code (AKA "success") in
> > > dev_err_probe(). This helps to simplify a code such as
> > > 
> > >   if (ret < 0)
> > >     return dev_err_probe(int3472->dev, ret, err_msg);
> > > 
> > >   return ret;
> > > 
> > > to
> > > 
> > >   return dev_err_probe(int3472->dev, ret, err_msg);
> > > 
> > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > This is a terrible idea because currently Smatch is able to detect about one
> > bug per month where someone unintentionally passes the wrong error variable
> > to dev_err_probe().

How many cases you know where smatch is false positive about this?

I believe the number is only a few at most, which means that you may easily
detect this still with this change being applied, i.e. "anything that
terminates function flow with code 0, passed to dev_err_probe(), is
suspicious".

So, I don't see how it prevents you from detecting that.

> Here are the stats since Jan 2023.  All these bugs are impossible to detect now.
> 
> 2024-08-12 d3bde2243d42 iio: proximity: hx9023s: Fix error code in hx9023s_property_get()

Just looked at this one.
Whoever writes something like

if (ret || foo)
	return ...ret...;

should be punished immediately. I.o.w. has nothing to do with the API.

> 2024-07-08 101e5c5c4e76 PCI: qcom: Fix missing error code in qcom_pcie_probe()
> 2024-02-22 debabbb1f272 iio: adc: ti-ads1298: Fix error code in probe()
> 2024-01-08 9c46e3a5232d iio: adc: ad7091r8: Fix error code in ad7091r8_gpio_setup()
> 2023-12-04 35ddd61cf023 platform/x86: x86-android-tablets: Fix an IS_ERR() vs NULL check in probe
> 2023-11-20 2d37b3649c41 hwrng: starfive - Fix dev_err_probe return error
> 2023-11-30 03219a3aa6c8 drm/imagination: Fix error codes in pvr_device_clk_init()
> 2023-09-07 4b2b39f9395b watchdog: marvell_gti_wdt: Fix error code in probe()
> 2023-08-24 8886e1b03669 ASoC: codecs: Fix error code in aw88261_i2c_probe()
> 2023-06-23 ad5152b85e8b leds: aw200xx: Fix error code in probe()
> 2023-07-18 86fe3e9f4c63 phy: starfive: fix error code in probe
> 2023-07-12 0b64150c3429 Input: bcm-keypad - correct dev_err_probe() error
> 2023-06-26 5fb2864cbd50 OPP: Properly propagate error along when failing to get icc_path
> 2023-06-19 02474880e8fd ASoC: max98388: fix error code in probe()
> 2023-05-25 cc5f2eb7ce11 mfd: tps6594: Fix an error code in probe()
> 2023-05-22 1ca04f21b204 remoteproc: stm32: Fix error code in stm32_rproc_parse_dt()
> 2023-05-15 46f5dd7439e3 fbdev: omapfb: panel-tpo-td043mtea1: fix error code in probe()
> 2023-05-13 3530167c6fe8 soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
> 2023-05-12 bc97139ff135 power: supply: rt9467: Fix passing zero to 'dev_err_probe'
> 2023-03-23 c4351b646123 iio: adc: ti-ads1100: fix error code in probe()
> 2023-02-27 65609d3206f7 i2c: gxp: fix an error code in probe
> 2023-02-15 76f5aaabce49 ASoC: soc-ac97: Return correct error codes

-- 
With Best Regards,
Andy Shevchenko



