Return-Path: <linux-kernel+bounces-399487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E249BFFB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A18DB22DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE41DE2D4;
	Thu,  7 Nov 2024 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeF9c7or"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF031D1E64;
	Thu,  7 Nov 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966731; cv=none; b=H/2otNpPwCh0wCwM8pKFnOjUHI/uwkdzDc4bDPEDVqLU/jw/3rTlRiQfkIzlR3CNu4T7hI+SS9ByTLidrEiTquBYDUnjVU/EcXuTRl6ybBsgYtHKwCX1i3mk2U6RoEmapoCQUjak2LPMWRdcbKGpV9exqAhaGpm5mAmjJWX2yo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966731; c=relaxed/simple;
	bh=ijQGLShwBSYLLvUxnqStEBbxxKosoO9akZv2TZgOhm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlN2eV9LYYLz+qmgehyv9ezqptLQYDmjs/LOshp22GnNyLJgWoRthpVdC4i/Y+qOtB0z6LlUkgdgz1Sb57QqDiIoMmKtIzOLwI2sus6pkLKrH39PZAh75v57W3fO9c0PY/wzK4UOWshrR1kayFczjOs6JK5TZrQw5cTTB6WzPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeF9c7or; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730966730; x=1762502730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ijQGLShwBSYLLvUxnqStEBbxxKosoO9akZv2TZgOhm8=;
  b=QeF9c7orDp5Fyv0cvEbuI4hz23+6YBB4ZLmLAQNpDciC1IXSIHEk8p7w
   nTWRq3wMLkU3n/XNR260OQPHcKb3pgJEt0PpsxF1tn047WmUkCKl4BmT6
   P1CS1BrpgDZzPZzSuZ78BoBzjMYwsFlaThsZ6+HDir0hoUHPYYrldynbU
   z09XLTKEpxWR/mwGDbP8LwHw6L/hMvNaflh4NQQPPsdjyRzU6RtPGoTFk
   lsENwIifcrONmJjRlS5WVbQWPPZRXuHZt7hrW/aXwMxd/y27ybLIwIU6r
   90OW0M1odrBdzd4UOuu+3PgumjkdAd1suid8wchE/z2+qPKMSqi5D631z
   A==;
X-CSE-ConnectionGUID: ay1I34sZSqWycgBsOuIMjg==
X-CSE-MsgGUID: zU1ciVjCRB+GkPNZc77APw==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34721893"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="34721893"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 00:05:29 -0800
X-CSE-ConnectionGUID: wqVESQ92SL+6HCg6lj+7Zg==
X-CSE-MsgGUID: KD/u0kr5TeWTurn3071+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="85320413"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 00:05:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t8xW6-0000000CB9y-3n1y;
	Thu, 07 Nov 2024 10:05:22 +0200
Date: Thu, 7 Nov 2024 10:05:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Message-ID: <Zyx0wqJnOwGfto_F@smile.fi.intel.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
 <ZytSCD0dViGp-l2b@smile.fi.intel.com>
 <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
 <ZyuSzPXnxRYG4Gk3@smile.fi.intel.com>
 <PH0PR03MB6351F678D8FDC9C28174E9EBF15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6351F678D8FDC9C28174E9EBF15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 07, 2024 at 01:17:04AM +0000, Torreno, Alexis Czezar wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, November 7, 2024 12:01 AM
> > On Wed, Nov 06, 2024 at 07:55:30AM -0800, Guenter Roeck wrote:
> > > On 11/6/24 03:24, Andy Shevchenko wrote:
> > > > On Wed, Nov 06, 2024 at 05:03:11PM +0800, Alexis Cezar Torreno wrote:

...

> > > Is that an official tag ? Frankly, if so, I think it is quite useless
> > > in the patch description because datasheet locations keep changing.
> > > I think it is much better to provide a link in the driver documentation.
> > 
> > I believe it's semi-official, meaning that people use it from time to time.
> > I'm fine with the Link in the documentation. Actually with any solution that
> > saves the respective link in the kernel source tree (either in form of commit
> > message or documentation / comments in the code).
> 
> Will add the blank line after description. 
> Am I right to understand that we leave this as is? No need to add driver link
> in patch description since it is in driver documentation?

Add it to the documentation.

...

> > > > > +static struct pmbus_driver_info adp1055_info = {
> > > > > +	.pages = 1,
> > > > > +	.format[PSC_VOLTAGE_IN] = linear,
> > > > > +	.format[PSC_VOLTAGE_OUT] = linear,
> > > > > +	.format[PSC_CURRENT_IN] = linear,
> > > > > +	.format[PSC_TEMPERATURE] = linear,
> > > > > +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> > PMBUS_HAVE_VOUT
> > > > > +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 |
> > PMBUS_HAVE_TEMP3
> > > > > +		   | PMBUS_HAVE_POUT | PMBUS_HAVE_STATUS_VOUT
> > > > > +		   | PMBUS_HAVE_STATUS_IOUT |
> > PMBUS_HAVE_STATUS_INPUT
> > > > > +		   | PMBUS_HAVE_STATUS_TEMP,
> > > >
> > > > Ditto.
> > >
> > > That one slipped through with the original driver submission.
> > > I thought that checkpatch complains about that, but it turns out that
> > > it doesn't. I agree, though, that the usual style should be used.
> > 
> > Oh, okay, that's up to you then.

> I based my code style on the original, but I agree that the usual style
> should be followed.  

> I will change it to follow the usual style.

No, please be consistent with the existing style. If you want to change it,
add an additional patch to do that for the _existing_ code first and base your
patch on top of that.

> Should I leave the original untouched or should I format it too?

-- 
With Best Regards,
Andy Shevchenko



