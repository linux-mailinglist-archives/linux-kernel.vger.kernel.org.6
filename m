Return-Path: <linux-kernel+bounces-529421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BBA42604
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A298163D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A931624C8;
	Mon, 24 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRH5fBf5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E0155744
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409897; cv=none; b=IFw4BanXtGl4LWShttbXpDIpg+9GmtUsWya4LTdPUH1gG3IirvindCfOReOnY5DytCd3aBvPcDQFZKR9J1d7RGTUUu5jbeQRH3h0Y2oyOtiX6+yx+JGod9gN4b+fXQ5ULaLyC78EWBnrG3nwet+JmzAxYT9xUgBhhOOjnNMidi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409897; c=relaxed/simple;
	bh=qUzubzLgBT05RrsaQ4UBzMm3XMNcQZmfka4Vb8NPVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZLypXoohS/q87iWnM2D+fjIt0ied0uwU0fzE/NzeepbKBE/1VWSXJ2Cx4zW53s3ufYIc8jU00O3jLbW0a1fJf/RW04o6UokYoNJ/At/OvY+9+uJQ2/5CJMa6kTWqFdQ9OwS5fe3l9e3DBntTOxysLBW2IeA2BYck6cPWKPrQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRH5fBf5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740409896; x=1771945896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qUzubzLgBT05RrsaQ4UBzMm3XMNcQZmfka4Vb8NPVi4=;
  b=eRH5fBf5OKHNLI2YEI9xihj+YdgwYoGd0lxSPPn7sKhPP6f/OpnD46U3
   Y1J69Uvax9Ko8WMvZ+8GYblJuBH7cS7HHY0nH8GbnFvGLnEIgE/zUzCM7
   q5h5xbNwtx6xl0HwjlPq9UpOFlEpEzL5SxtkrXIQT1eGeJgYab8FwOFFr
   iy/CvwmAvQZeGxPq75oo10CYcIuo4kYrGWVe05OiVnwY1Tomg5Ji8eLC0
   866WjCWufAQspW1igTZQqnuVIgmnuhw1qf83MIEkZUQHhZVqd4ZacA90g
   o+wHP3RALyk4h5lSeuWxFnDd2MfTg/JQEE2/iZDMsKDOBpqelUhLDbL7U
   w==;
X-CSE-ConnectionGUID: RJbDvqUrTKuNsaa9DSuZRQ==
X-CSE-MsgGUID: v/cqkplaQXap/0cwPl//hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51806062"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51806062"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:11:35 -0800
X-CSE-ConnectionGUID: 4/Ao5ftqSSWETV+dElBn4g==
X-CSE-MsgGUID: wU5cAz5sRvebytjsw+OlRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153286520"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:11:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tma7E-0000000EjB1-3EDe;
	Mon, 24 Feb 2025 17:11:28 +0200
Date: Mon, 24 Feb 2025 17:11:28 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z7yMIC1wxm0AGBCt@smile.fi.intel.com>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
 <Z7x7kMjaDbCp_LB2@smile.fi.intel.com>
 <5BC3A795-99C2-4F00-ADD0-7ECD0285CDD0@live.com>
 <Z7yI4roBKA-PI4EC@smile.fi.intel.com>
 <3D520B56-AE84-4D73-9604-495642AF5B30@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D520B56-AE84-4D73-9604-495642AF5B30@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 03:03:40PM +0000, Aditya Garg wrote:
> > On 24 Feb 2025, at 8:27 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Mon, Feb 24, 2025 at 02:32:37PM +0000, Aditya Garg wrote:
> >>> On 24 Feb 2025, at 7:30 PM, andriy.shevchenko@linux.intel.com wrote:
> >>> On Mon, Feb 24, 2025 at 01:40:20PM +0000, Aditya Garg wrote:

...

> >>>> +#define __APPLETBDRM_MSG_STR4(str4) ((__le32 __force)((str4[0] << 24) | (str4[1] << 16) | (str4[2] << 8) | str4[3]))
> >>> 
> >>> As commented previously this is quite strange what's going on with endianess in
> >>> this driver. Especially the above weirdness when get_unaligned_be32() is being
> >>> open coded and force-cast to __le32.
> >> 
> >> I would assume it was also mimicked from the Windows driver, though I haven't
> >> really tried exploring this there.
> >> 
> >> I’d rather be happy if you give me code change suggestions and let me review
> >> and test them
> > 
> > For the starter I would do the following for all related constants and
> > drop that weird and ugly macros at the top (it also has an issue with
> > the str4 length as it is 5 bytes long, not 4, btw):
> > 
> >  #define APPLETBDRM_MSG_CLEAR_DISPLAY cpu_to_le32(0x434c5244) /* CLRD */
> 
> Lemme test this.

Just in case it won't work, reverse bytes in the integer. Because I was lost in
this conversion.

> > (assuming we stick with __leXX for now). This will be much less confusing.

...

> >> Alright. For some reason (a mistake on my part), some dev_err_probe were also
> >> still left in this version.
> > 
> > But those are seems to me in the correct locations, no? How do we even know
> > the DRM device before its creation? So, dev_err_probe() calls in ->probe()
> > seem logical to me. Somebody from DRM should clarify this.
> 
> Thomas asked me to do this change. Maybe you didn’t see his reply.

I saw, maybe I took it wrong, but I really don't understand how on earth
drm_err()  or whatever can be used in real ->probe() of the physical device.

Imagine the hypotetical case

probe(strict device *dev)
{
	mydrm;
	foo;
	...
	foo = devm_gpiod_get(dev, ...);
	if (IS_ERR(foo))
		return dev_err_probe(dev, ...); // how?!
	...
	mydrm = ...DRM alloc...;
	...
}

I don't even believe it will be possible to create drm_err_probe() as it most
likely will require to have an allocation to be always the first op (that may
fail) in the ->probe() which might be not the case for some device drivers.

> >>>> +  */

-- 
With Best Regards,
Andy Shevchenko



