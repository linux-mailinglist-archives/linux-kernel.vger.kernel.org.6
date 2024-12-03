Return-Path: <linux-kernel+bounces-429622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F949E1EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AF9163257
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7921F4299;
	Tue,  3 Dec 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5eBY7N5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA817BB16
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234914; cv=none; b=LolLXA9j8z2PHWSQO+eKhMExaDh7ZGPrLC5h8jKubzD2YDEm0g1SDnDMffa16PayLxVPPIcpqaFC9pSsylzGtzCMnfp1UvtG4vOldfDYxuxmjLIE2OLfKKpN2kM1HBGcV3P5Of/4PZny7VTUh+foDNqy2kHLxnLsG0TeIoysXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234914; c=relaxed/simple;
	bh=1vgb5I+p4PfXVR7FHAsBlaVB6byxIXF25/TD0XAhlNw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKix3bl/J1My0xd0oZsW+rKbKd+sH+HVJ4ly5DZmPmCuwRjFiTJ7jGnA5qmQz9NQfeEprCrRNH9P3Nbzqe5UgmHUVSjNCLp25Q1Tl9Q79h+w7P6/aZTFnCBM/O2kKTbZ5KRdQuG16A+HYr2GhFvb0zpCVPFB1udk2meh+NJWg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5eBY7N5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733234913; x=1764770913;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=1vgb5I+p4PfXVR7FHAsBlaVB6byxIXF25/TD0XAhlNw=;
  b=Z5eBY7N5J3G0VrlTkZ3Nc3SDdaJseJZvoSJ3QFIJ5Kheq4HCiorUyavM
   JmP+Y6+IktgHnce/Ex+3BtC0Q8XzMdTJQJAri7Iw8EgVLgCcge15Q9HKL
   FNWRJs+nINR3ApzyAuw6cOGUdDx+qSI9w9ZP7Q4T4hKkd3gGQ1KSQVZc+
   BE9tDi+rRsJALEQQNjqUpBrpKVNBiDjCXgyW12iksQQSkLFHv3xi7HsRB
   mkXbsxTqqs34BlKz6AEB8hqlXkSptYuKbG3CVQHpnEAYkOeg9Gm4fZTK4
   VA+PXwMiW0K62TQo76OJBxrUxek8IA/C24qhE7NXJvGVXX96aSqjXVrLB
   A==;
X-CSE-ConnectionGUID: wMHhYvvVTqOJPOe4fRd08A==
X-CSE-MsgGUID: FNaJTrGHTj6DecDeL2dq+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37384869"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37384869"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 06:08:31 -0800
X-CSE-ConnectionGUID: OWm9m21qQL6Za5ni7Y/Hiw==
X-CSE-MsgGUID: NEHMPwSWROOzM+6RvEul9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="94278786"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.135])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 06:08:27 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/6] drm/panic: Move drawing functions to drm_draw
In-Reply-To: <a51f2945-4eff-411e-83ad-838e69daeb6a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241115142950.1758007-1-jfalempe@redhat.com>
 <20241115142950.1758007-2-jfalempe@redhat.com> <87y10x3u0x.fsf@intel.com>
 <a51f2945-4eff-411e-83ad-838e69daeb6a@redhat.com>
Date: Tue, 03 Dec 2024 16:08:23 +0200
Message-ID: <87ed2o506g.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 03 Dec 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> On 03/12/2024 12:06, Jani Nikula wrote:
>> On Fri, 15 Nov 2024, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>> Move the color conversions, blit and fill functions to drm_draw.c,
>>> so that they can be re-used by drm_log.
>>> drm_draw is internal to the drm subsystem, and shouldn't be used by
>>> gpu drivers.
>> 
>> I started looking at this in patch 2:
>> 
>>> +#include "../drm_draw.h"
>> 
>> I think we should avoid #includes with ../ like this.
>
> Sure, I've added it in v8, after the clients moved to drm/clients/, but 
> I didn't think much about it.
>
>> 
>> Either drm_draw.h belongs in include/drm, or maybe clients/Makefile
>> needs to add subdir-ccflags-y += -I$(src)/.. or something like that?
>> 
>> If it's supposed to be internal, I guess the latter, but then the
>> current convention is to have _internal.h suffix. All drm headers under
>> drivers/ have that.
>
> ok, I can rename drm_draw.h to drm_draw_internal.h, and add the include 
> in the Makefile.
>> 
>> Is this the first drm subsystem internal thing that's a separate module?
>> Should we use EXPORT_SYMBOL_NS() and MODULE_IMPORT_NS() to enforce it
>> being internal?
>
> It's not really a separate module, as it's built in the core drm module. 
> (the reason is that it's used by drm_panic too, which must be in the 
> core drm module).

Right, sorry, I got confused and looked at this the other way round.

drm_draw is part of drm.ko, drm log is part of drm_client_lib.ko, and
uses drm_draw, right?

So is drm_draw really internal if drm client uses it?

I don't really deeply care either way, but it bugs me when it's
somewhere in between. :)

Either include/drm/drm_draw.h or drivers/gpu/drm/drm_draw_internal.h,
the latter *possibly* with symbol namespace, but not a big deal.


BR,
Jani.


>
> I don't know much about symbol namespace, but I can add that if needed.
>
> Best regards,

-- 
Jani Nikula, Intel

