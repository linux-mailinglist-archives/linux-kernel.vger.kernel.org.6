Return-Path: <linux-kernel+bounces-194372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547188D3B27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A0B1F26AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABB181321;
	Wed, 29 May 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfHDOC7/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D0746E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997168; cv=none; b=VZ5dPCuq/ALmF3PH0JT4WPTga25tKvQjRXGgliipAJMAbGQU8fzJ9Mh8D2CpMNq+GV/lZNKI+F5PuKQ+8CU5Y9beVbBqookSYIryNtBm2bLvnlcKeT71n1sCBIrjdP+31gvN8M3oaHnYXQahEyVdyrgSLGEuKfczoiODFINXA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997168; c=relaxed/simple;
	bh=e8LQcNcc3AEDHWS/nnMWgpljz4Z9RaTLNp7fyN5hGww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKgOn/X7vr7EEnQ9EhMEQf+6rHk63lkCjIYts2i8qii3kjb2+TFtMNpZxSMpyGy2o0kwFZaUlHW7PZfJrAjywttKCrk6Gd3h+KAfuX/sFmdZcsZy3iu6jNg8kgH2y/Fb+yoiiCBuONmO4+LXdFT/SqNYcKarxbVp3o5O35J6ydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfHDOC7/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716997166; x=1748533166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e8LQcNcc3AEDHWS/nnMWgpljz4Z9RaTLNp7fyN5hGww=;
  b=OfHDOC7/o27T3rzmU0bUEWwqDh5EFDyGBXJJF2b9xTRhCTiP8c92Ur3H
   MMoAWt+GYvXMjWZOznoJB7w4SAFMA7jGcsWpnx7XJhvhfl95ZPfOEbHGD
   GmG7H5GnAcAmBe5o27DLMGOhsoyZC3eEbAmGu30pIfI0Ul04p6jP72vdI
   aDGcfiitKTV62gJK+vPl2xkhBfzXrwUd50UTrkkfxSzvPPlynKkzC6EEm
   3jEW4xKgmyow+CXvD/G6SHqztXrU64bkZ1j+N715Zn0dRFijVmZ1ChMQz
   cKMaNGoub5YXY14iT02yhtiN8EVpger89i76dI4j3GxGD8bJHnkI7kn1U
   g==;
X-CSE-ConnectionGUID: RMfkxka/QnWKCFrknbyVFA==
X-CSE-MsgGUID: c3uYrgzfS1KkaVxL3zMnvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13361458"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13361458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:39:25 -0700
X-CSE-ConnectionGUID: KVlOEYYNRHi42GMY8d74Jg==
X-CSE-MsgGUID: swQ38J9XTGKPuzKtr3+jwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35445669"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 29 May 2024 08:39:22 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 29 May 2024 18:39:21 +0300
Date: Wed, 29 May 2024 18:39:21 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Chris Bainbridge <chris.bainbridge@gmail.com>, hughsient@gmail.com
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during
 initialization
Message-ID: <ZldMKZ1MzSDXOheJ@intel.com>
References: <20240528210319.1242-1-mario.limonciello@amd.com>
 <Zlc4V1goFvU2antl@intel.com>
 <197d195f-9206-41dd-8ff1-f4bb4988fb9b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <197d195f-9206-41dd-8ff1-f4bb4988fb9b@amd.com>
X-Patchwork-Hint: comment

On Wed, May 29, 2024 at 09:45:55AM -0500, Mario Limonciello wrote:
> On 5/29/2024 09:14, Ville Syrjälä wrote:
> > On Tue, May 28, 2024 at 04:03:19PM -0500, Mario Limonciello wrote:
> >> If the lid on a laptop is closed when eDP connectors are populated
> >> then it remains enabled when the initial framebuffer configuration
> >> is built.
> >>
> >> When creating the initial framebuffer configuration detect the ACPI
> >> lid status and if it's closed disable any eDP connectors.
> >>
> >> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> Cc: hughsient@gmail.com
> >> v1->v2:
> >>   * Match LVDS as well
> >> ---
> >>   drivers/gpu/drm/drm_client_modeset.c | 30 ++++++++++++++++++++++++++++
> >>   1 file changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> >> index 31af5cf37a09..0b0411086e76 100644
> >> --- a/drivers/gpu/drm/drm_client_modeset.c
> >> +++ b/drivers/gpu/drm/drm_client_modeset.c
> >> @@ -8,6 +8,7 @@
> >>    */
> >>   
> >>   #include "drm/drm_modeset_lock.h"
> >> +#include <acpi/button.h>
> >>   #include <linux/module.h>
> >>   #include <linux/mutex.h>
> >>   #include <linux/slab.h>
> >> @@ -257,6 +258,34 @@ static void drm_client_connectors_enabled(struct drm_connector **connectors,
> >>   		enabled[i] = drm_connector_enabled(connectors[i], false);
> >>   }
> >>   
> >> +static void drm_client_match_edp_lid(struct drm_device *dev,
> >> +				     struct drm_connector **connectors,
> >> +				     unsigned int connector_count,
> >> +				     bool *enabled)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < connector_count; i++) {
> >> +		struct drm_connector *connector = connectors[i];
> >> +
> >> +		switch (connector->connector_type) {
> >> +		case DRM_MODE_CONNECTOR_LVDS:
> >> +		case DRM_MODE_CONNECTOR_eDP:
> >> +			if (!enabled[i])
> >> +				continue;
> >> +			break;
> >> +		default:
> >> +			continue;
> >> +		}
> >> +
> >> +		if (!acpi_lid_open()) {
> >> +			drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is closed, disabling\n",
> >> +				    connector->base.id, connector->name);
> >> +			enabled[i] = false;
> >> +		}
> >> +	}
> >> +}
> > 
> > If you don't hook into some lid notify event how is one supposed to get
> > the display back to life after opening the lid?
> 
> I guess in my mind it's a tangential to the "initial modeset".  The DRM 
> master can issue a modeset to enable the combination as desired.

This code is run whenever there's a hotplug/etc. Not sure why you're
only thinking about the initial modeset.

> 
> When I tested I did confirm that with mutter such an event is received 
> and it does the modeset to enable the eDP when lid is opened.

This code isn't relevant when you have a userspace drm master
calling the shots.

> 
> Let me ask this - what happens if no DRM master running and you hotplug 
> a DP cable?  Does a "new" clone configuration get done?

Yes, this code reprobes the displays and comes up with a new
config to suit the new situation.

The other potential issue here is whether acpi_lid_open() is actually
trustworthy. Some kms drivers have/had some lid handling in their own
code, and I'm pretty sure those have often needed quirks/modparams
to actually do sensible things on certain machines.

FWIW I ripped out all the lid crap from i915 long ago since it was
half backed, mostly broken, and ugly, and I'm not looking to add it
back there. But I do think handling that in drm_client does seem
somewhat sane, as that should more or less match what userspace
clients would do. Just a question of how bad the quirk situation
will get...


Also a direct acpi_lid_open() call seems a bit iffy. But I guess if
someone needs this to work on non-ACPI system they get to figure out
how to abstract it better. acpi_lid_open() does seem to return != 0
when ACPI is not supported, so at least it would err on the side
of enabling everything.

-- 
Ville Syrjälä
Intel

