Return-Path: <linux-kernel+bounces-175901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92A8C26D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002921F24505
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5128170834;
	Fri, 10 May 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBWjNRaK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D655170821
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351312; cv=none; b=XfQuZu6Pzc4Stl16bAxB6JS5/PWj//Z44gP/dlv5pZJh7GWkFPsUXOHlKyC+C4fXhsKx+oJKvS3LQ2cm99ohQcKN352dPBxLhcP5y49yUPhh3fofdIXT2SWEU0AHs0M/LNRrEOEdB2Q2YEt4jOwNQbw64HQUaNCRqk4ZTyb0LJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351312; c=relaxed/simple;
	bh=BpDfo0JyaiFAsLuhQN5rX/nDOzJtmaujSzQUgZhk2Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8+1nQ8aYCId3D654+xAcePPJmvR4XHBy+tmThDF4xpDy55kj1A29nq7q94H95HVljIzOiXjmepLdIYc0l1TruuL46UH5Sg2dgF/sjI0ULnfFacCKFAwMrSuJ5y6jLc6Dj5qbZ5CnXDsDDDHwgFlMycq/jM6bL7KSPBDJySFHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBWjNRaK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351311; x=1746887311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BpDfo0JyaiFAsLuhQN5rX/nDOzJtmaujSzQUgZhk2Ds=;
  b=aBWjNRaKv3NTXk7rSZpuEBBMMyTrQRgmF4LWjAfuDlNtEtM8iM+LF6na
   5FCwPc14yZqRJrMmXugMnDC0QV3KRQG3OL4oJIdlHL5WXFbWlvGC5dTlw
   VTCfppYAX3LK3qpsVXibcl3B3SpOX2zSTRcVq+AodUS/iww6fcpC99OZI
   qmnNlgbpIBw+Go65IZgTRWSqrcMnoXq5i2vOA7+U8ylOOj/ul9O37PB8s
   pBKj+0QrRQGtZessPXjEphZgV5BZer0Mc/+/BlUIgRIiAlh+4QR6akssX
   9vz/5AGXlj5romqC2NXRk4JzA3sOWkZPmXeMvtxs/yCZX+GudeK2bItPR
   w==;
X-CSE-ConnectionGUID: QL/N9FTUQLKXrxoCzwJDuQ==
X-CSE-MsgGUID: ylzuDcuDRxO0+wsQccvbdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22741978"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22741978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:28:30 -0700
X-CSE-ConnectionGUID: G9O7mg33SY+jY6kgIpS3Ww==
X-CSE-MsgGUID: AUtjaV+hRx26k9WlB8JW+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29644128"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:28:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s5REW-000000067yK-3Wjo;
	Fri, 10 May 2024 17:28:24 +0300
Date: Fri, 10 May 2024 17:28:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] eeprom: 93xx46: drop unneeded MODULE_ALIAS
Message-ID: <Zj4vCGgPu2ERxewe@smile.fi.intel.com>
References: <20240414154957.127113-1-krzk@kernel.org>
 <20240414154957.127113-3-krzk@kernel.org>
 <Zju8HpBCiOjjIZ1j@smile.fi.intel.com>
 <6599e2a3-3b04-4ea2-aa5c-a916b66c8009@kernel.org>
 <ZjvEam5paLD0Iv6V@smile.fi.intel.com>
 <9a26dac6-d776-4b84-830d-6f622719d7eb@kernel.org>
 <5b29d981-aa8a-413e-8250-5fb33802f32d@app.fastmail.com>
 <cb8df682-c006-46d7-bcf1-7a0548e65c98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb8df682-c006-46d7-bcf1-7a0548e65c98@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 08, 2024 at 09:17:59PM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2024 21:11, Arnd Bergmann wrote:
> > On Wed, May 8, 2024, at 20:44, Krzysztof Kozlowski wrote:
> >> On 08/05/2024 20:28, Andy Shevchenko wrote:
> >>> On Wed, May 08, 2024 at 08:15:00PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 08/05/2024 19:53, Andy Shevchenko wrote:
> >>>>> On Sun, Apr 14, 2024 at 05:49:57PM +0200, Krzysztof Kozlowski wrote:
> >>>>>> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> >>>>>> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> >>>>>> the alias to be duplicated.
> >>>
> >>> ...
> >>>
> >>>>>>  MODULE_ALIAS("spi:93xx46");
> >>>>>
> >>>>> I was stumbled over this (leftover?).
> >>>>> Commit message doesn't elaborate this bit.
> >>>>> Any comments?
> >>>>
> >>>> It is not present in ID table and commit msg removes only duplicated
> >>>> aliases. That alias has meaning - someone might be actually relying on it.
> >>>
> >>> It seems no users for it. The only user of platform data of this EEPROM uses
> >>> board files which AFAIU bypasses modalias matching.
> >>
> >> I don't think that's correct. The modalias of SPI board is there on
> >> purpose. 
> > 
> > Right, but I think a better workaround would have been to change
> > the board_info to pick a modalias that is part of the ID table:
> > 
> > --- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
> > +++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
> > @@ -76,7 +76,7 @@ static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
> >  
> >  static struct spi_board_info digsy_mtc_eeprom_info[] __initdata = {
> >         {
> > -               .modalias               = "93xx46",
> > +               .modalias               = "eeprom-93xx46",
> >                 .max_speed_hz           = 1000000,
> >                 .bus_num                = EE_SPI_BUS_NUM,
> >                 .chip_select            = 0,
> > 
> 
> That's kind of independent change.

I have done similar change in my patch series, after which I am 100% sure the
modalias can be removed. Can you look at that?

https://lore.kernel.org/r/20240508184905.2102633-1-andriy.shevchenko@linux.intel.com

> This commit *only* removed duplicated
> aliases, thus should have not functional impact except dropping
> redundant code. What you propose is to change spi board matching, which
> is reasonable, just a different thing.

-- 
With Best Regards,
Andy Shevchenko



