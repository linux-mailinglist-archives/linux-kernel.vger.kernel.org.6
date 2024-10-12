Return-Path: <linux-kernel+bounces-362615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CF99B6F9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EC41F2198C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D9199240;
	Sat, 12 Oct 2024 20:36:26 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41E1946B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765385; cv=none; b=OCR7AykMwDuu8DFU+o2lMjxr4VgZJGefMCRCqTgdkvXKgx/v5M+6LTH3zPZSbyx9lWKi746kczuepfEqeIVTF1ar+xsxOPiYES5plaXIceStloF/5rUbZtFSMo6ubJtO87MUUjks68d/iGQTuLdUNdzG3PtChoB3tT3YbL16sVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765385; c=relaxed/simple;
	bh=3/c35w7D83VLEAha7Zi9HE2mg2SYsKTgY17bYe1C7dk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei3URvjrk4s7x9tPrgF246B/BP9QHAXPb2HXUsNXhrsHHd5oRlBu4+iBKPWkYLSzsiH+RtwYTb15Ii4smBWB7tTAScjLWAHEyNn8lM4ZSb93M1Og1C8KVV7yTvh153SFlviEj3hoib/J/+DWkzLIzuGkRBnPu5KFYEUzmdluykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 9bfc8f72-88d9-11ef-9671-005056bdf889;
	Sat, 12 Oct 2024 23:36:08 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Oct 2024 23:36:07 +0300
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: chemical: bme680: fix startup time
Message-ID: <Zwrdt_uaaLaVhM-L@surfacebook.localdomain>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-4-vassilisamir@gmail.com>
 <Zwj3V1oaTO6je-w9@smile.fi.intel.com>
 <ZwlzvboBPppQMEB_@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwlzvboBPppQMEB_@vamoirid-laptop>

Fri, Oct 11, 2024 at 08:51:41PM +0200, Vasileios Aoiridis kirjoitti:
> On Fri, Oct 11, 2024 at 01:00:55PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:20PM +0200, vamoirid wrote:
> > > 
> > > According to datasheet's Section 1.1, Table 1, the startup time for the
> > > device is 2ms and not 5ms.
> > 
> > Fixes tag?
> 
> It is not affecting at all the operation of the driver so I was not sure
> if it was worth it to be backported to the previous versions. This is
> why I didn't put a fixes tag. You think for such a fix is necessary?

The commit message siggests that this is a fix. If you want to make it clear,
that it shouldn't be considered as a such, perhaps you need to rephrase it.

-- 
With Best Regards,
Andy Shevchenko



