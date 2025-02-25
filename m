Return-Path: <linux-kernel+bounces-531067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E0A43BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F252119C482A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402B266190;
	Tue, 25 Feb 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUutau1m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423E265610
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479343; cv=none; b=fyq3QEEiwLo42xDNFJMpc4ZSRdgYnJj4tiL8GV3pe1gTejoVRWc46TW6nGFc6rsU9yv4qcFZSzRgRbT13peQOuxqlFygUbM7NDv0hMqgZKpJSPGiaAcd/uVgN5Wlc2S3paA8fCwc7Bn0URCGFnm1eOynhJJ1blSobSTkCeHLUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479343; c=relaxed/simple;
	bh=bQ6fvZqvVAScXUHVfi2Jgc1uaKIbM24bSW4bUHsGHUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbgx9tQ2wPffny3+rbpTJLQH6J5bnQfUco6MUHSVWt9qCzdrUHUN75B3mrl6I3ln6j2PyKoQaXS517uWyUi6woV1dHZv/tNkadGv54zgAJDPAS/6HFT+c7RiJ0p7eSCDIoZuP+iy28TAbgvlzMVZoqdUfUAy9AVACbYjjBZ9z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUutau1m; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740479342; x=1772015342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bQ6fvZqvVAScXUHVfi2Jgc1uaKIbM24bSW4bUHsGHUQ=;
  b=lUutau1mFYjt1s1ex9aXWOXW+1fzkr8LGIQTMagW5+k3X7zDIQXHk/BY
   CvJbOxPunj9SH8CkKgZPSRdWVjdBpJ1tChePTXa8W/BLsOZFrORNy4Kpp
   uNfvWCLXC++CB+4Nbc2XrOJFVXlGz4UwVfsOulFbxS3thxIfF/M89qosW
   TyiPY1Y7hAJou+b8m46/oBqXVttTljPS8BBsU2Z1w+AV6d3+2OdMg11Mt
   7ukRQoW6jqFztteP7ZIMnbswD3dLJIwXmplzXn0DaVeI49ZjwFzrcqT4P
   +TmDhTCFaaYxQA+XCbsxX9seftnloW5x26+Nco9aOENQQhYhOFhv51IJp
   w==;
X-CSE-ConnectionGUID: ytxYfSKITBaHusHqppSJPg==
X-CSE-MsgGUID: 915NqoOnRSG/Wur5KGxAIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51914614"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51914614"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:29:01 -0800
X-CSE-ConnectionGUID: 4kiwgWtzSHWSQoZWk1IDOA==
X-CSE-MsgGUID: DMZs2XXcT0ywATF+ooUJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153534389"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 02:28:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmsBL-0000000ExTN-21Rf;
	Tue, 25 Feb 2025 12:28:55 +0200
Date: Tue, 25 Feb 2025 12:28:55 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Aditya Garg <gargaditya08@live.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z72bZ3iURwhW5Pj1@smile.fi.intel.com>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
 <91a39a2e-a3ad-499d-86cd-0e621a68e282@suse.de>
 <PN3PR01MB959702F55F747E5D87D9AD56B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <54e45d37-6ada-42e3-a3ae-92d3ee475c5f@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e45d37-6ada-42e3-a3ae-92d3ee475c5f@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 09:48:11AM +0100, Thomas Zimmermann wrote:
> Am 25.02.25 um 09:00 schrieb Aditya Garg:
> > > On 25 Feb 2025, at 1:22 PM, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > Am 24.02.25 um 14:40 schrieb Aditya Garg:

...

> > > > +struct appletbdrm_device {
> > > > +    struct device *dev;
> > > This field should go away, please. There's drm.dev, which contains the same address.
> > > 
> > > So seems to have remove the dmadev field instead, which you'll need for
> > > dma-buf sharing. Was that a misunderstanding from the last review?
> > Yeah that was a misunderstanding. I though you meant to remove dmadev.
> > > The rest of the driver looks good.
> > Maybe you missed the left over dev_err_probe left in this patch? I'll fix
> > them.
> 
> Sure.

But can you comment on my reply where I'm asking for a clarification how
drm_err() can be used on the physical device ->probe() to begin with?

> > > > +    unsigned int in_ep;
> > > > +    unsigned int out_ep;
> > > > +
> > > > +    unsigned int width;
> > > > +    unsigned int height;
> > > > +
> > > > +    struct drm_device drm;
> > > > +    struct drm_display_mode mode;
> > > > +    struct drm_connector connector;
> > > > +    struct drm_plane primary_plane;
> > > > +    struct drm_crtc crtc;
> > > > +    struct drm_encoder encoder;
> > > > +};

-- 
With Best Regards,
Andy Shevchenko



