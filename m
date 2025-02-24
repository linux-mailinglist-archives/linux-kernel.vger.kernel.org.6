Return-Path: <linux-kernel+bounces-529406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7252A4257B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901BA189DD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F718CC1C;
	Mon, 24 Feb 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjbKbzBP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96E189919
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409257; cv=none; b=LGd4aNzbZTTZC2lipe0YMh6TA7XTkPBKoXwacDXaEPgqJlyWopUnlWS4RykVht+WDSBY2kXDJrDZzhVUpPymcD/+JAaSbyOTh+6WCjuJdrW7P/xitr3izwFIeETjLiO7TLFTJ2mfdudsFlkdJrB1yKcOQ7XRWHRQxsHg688QwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409257; c=relaxed/simple;
	bh=xw3KB9gjyy7jwvn7lKbpsP4JVAclfVpengUyudkK6YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ4fGZoAXB9wb50i20ih+flnfUAI3wI+sPTtYaSm7u9Ds5ubpv69quaJpnKVy7CeAsEC4pc8WD4B1Ax8W6te1nSvqXsmelpgP9GuMzDPTnvCQUG7XFgjDRjtxOxMZ1/acM877qp9zbM2//pneLwc+CkGz5Q8NdFWE3hmY3x0laE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjbKbzBP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740409256; x=1771945256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xw3KB9gjyy7jwvn7lKbpsP4JVAclfVpengUyudkK6YQ=;
  b=fjbKbzBPEgICZH4reeSkVkXieYz76aqJM0BPcR4E+/CoeqdZyid61KxZ
   9iWhkUBLJWPBwZws1tmNlxvygXiOYh9LA2FkQPjqHuo69OS7YJ6WAlTpm
   ulvf7W90gt5E5lU970UN9M8sFCHiFXMENicz5pOQ+Rpdl8glCklFlPZx/
   caZPydRvbh9eUBlG+sLYaJPZwKtffQCAEgzl/Pfd/PG36t+0SH3EygGjZ
   wi1C2k5dVYV0xpiIsW1Z8ww9N6eSrfJXRnrcCUhuKR0HK0Pi8gyL+igy0
   xqhqKzMHx3VMe28klLZ0Fiy8D5lqSwyig5QdFa+uSoSUAdH8ZoFL9Tjh4
   A==;
X-CSE-ConnectionGUID: QQ96/rVXTzyw+Omw6LMYXw==
X-CSE-MsgGUID: AacVyS29QbOhyAkQ2+QIyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40353421"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40353421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:00:55 -0800
X-CSE-ConnectionGUID: 1nyFkwNrQwyQIVpJqp6H1g==
X-CSE-MsgGUID: pl7Gd87GRPqSpQTH/LqWJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115875289"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:00:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmZww-0000000Ej2f-0MUb;
	Mon, 24 Feb 2025 17:00:50 +0200
Date: Mon, 24 Feb 2025 17:00:49 +0200
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
Subject: Re: [PATCH v4 1/2] drm/format-helper: Add conversion from XRGB8888
 to BGR888
Message-ID: <Z7yJodpB4WAB5oHn@smile.fi.intel.com>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <03FA573F-6D01-40E8-A666-CEA17A917036@live.com>
 <Z7yCLxBN4Cl4btQm@smile.fi.intel.com>
 <7D98DED5-5B18-4AAE-A347-C880232530B7@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7D98DED5-5B18-4AAE-A347-C880232530B7@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 02:54:07PM +0000, Aditya Garg wrote:
> This conversion helper mimics the existing drm_fb_xrgb8888_to_rgb888 helper

Not really. See below.

> > On 24 Feb 2025, at 7:59 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Mon, Feb 24, 2025 at 01:38:32PM +0000, Aditya Garg wrote:

...

> >> +static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> > 
> > Okay the xrgb8888 is the actual pixel format independently on
> > the CPU endianess.
> > 
> >> +{
> >> + u8 *dbuf8 = dbuf;
> >> + const __le32 *sbuf32 = sbuf;
> > 
> > But here we assume that sbuf is __le32.
> > And I think we may benefit from the __be32 there.
> 
> So, like drm_fb_xrgb8888_to_rgb888, we are using __le32
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_format_helper.c?h=v6.14-rc4#n657

The rgb888 != bgr888, that's where the byte swapping happens. So, one should
use __be32 if the other has already been using __le32.

> >> + unsigned int x;
> >> + u32 pix;
> >> +
> >> + for (x = 0; x < pixels; x++) {
> >> + pix = le32_to_cpu(sbuf32[x]);
> >> + /* write red-green-blue to output in little endianness */
> >> + *dbuf8++ = (pix & 0x00ff0000) >> 16;
> >> + *dbuf8++ = (pix & 0x0000ff00) >> 8;
> >> + *dbuf8++ = (pix & 0x000000ff) >> 0;
> > 
> > pix = be32_to_cpu(sbuf[4 * x]) >> 8;
> > put_unaligned_le24(pix, &dbuf[3 * x]);
> 
> Again, 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_format_helper.c?h=v6.14-rc4#n664

As per above.

> >> + }
> > 
> > Or, after all, this __le32 magic might be not needed at all. Wouldn't the below
> > be the equivalent
> > 
> > static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> > {
> > unsigned int x;
> > u32 pix;
> > 
> > for (x = 0; x < pixels; x++) {
> > /* Read red-green-blue from input in big endianess and... */
> > pix = get_unaligned_be24(sbuf + x * 4 + 1);
> > /* ...write it to output in little endianness. */
> > put_unaligned_le24(pix, dbuf + x * 3);
> > }
> > }
> > 
> > The comments can even be dropped as the code quite clear about what's going on.
> 
> These comments are literally rewritten :
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_format_helper.c?h=v6.14-rc4#n663
> 
> >> +}
> > 
> > But it's up to you. I don't know which solution gives better code generation
> > either.
> 
> I don't really mind any code change tbh, but I’d prefer that as an
> improvement to existing code, and not a part of this patchset.

Right, but see my argumentation above.

-- 
With Best Regards,
Andy Shevchenko



