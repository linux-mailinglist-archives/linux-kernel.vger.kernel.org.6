Return-Path: <linux-kernel+bounces-272782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419D19460D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14AA281BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAB1537A2;
	Fri,  2 Aug 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KTdpPPYx"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAE175D3A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614024; cv=none; b=Rj5AgW1sGg/a7HaMOCgKu32Jn5p9ymuAaKPVMqzRYahVHJCzXTQclGWpA9TZHEnUzAYXGUwmApsrY34a+ByiyfZ3s0kSdwY6RRii34qOaGhKXOVTpFlElcgARprJwO7ovsPaMxc61bKPgbaW7ukFYwQ64sulsaO5zdYA+6IrR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614024; c=relaxed/simple;
	bh=PBrL109z5VdLAGUbDeO0hq+c0EP3kHJOHBxinu53q3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3AlF9F+vnFhaQNZmTsVYJ0IeDCD1/NQd29Ij+N9ZVG/7Q52MDVVtklgFi1AkRdOezUbrNn46x/prOI/39hNF+v5E+Z6HL7pwqURPjjhgS2MdSSDf1VSSxVGsnd4/3CnfZrWs4c0HPuAqVypwAWD2ciod3ppNn1utDSss4G+S/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KTdpPPYx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722614018;
	bh=PBrL109z5VdLAGUbDeO0hq+c0EP3kHJOHBxinu53q3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTdpPPYxap8ckNqzIq08ty6wG5jdnERqXiCW5zQnZ8qDbOnAcl4I13efXh0x0RtTK
	 Ktdi9/75HEWzpg/FiILRjbaKMYGrGPik4h0+MgFf62KKFEyBOdZNx0e2mv3Pf+L216
	 r46CSyngPmHQOx3xgR97WpUJT64fvnpRuCHfbask=
Date: Fri, 2 Aug 2024 17:53:38 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH v3 0/2] drm: minimum backlight overrides and
 implementation for amdgpu
Message-ID: <f1712049-fc88-46f6-83e2-31f9f50c7869@t-8ch.de>
References: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
 <87v80lwjcz.fsf@intel.com>
 <Zqqku_zS7CpPGbzW@phenom.ffwll.local>
 <1b4bfb81-339d-4582-873c-c720c82c8ba7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b4bfb81-339d-4582-873c-c720c82c8ba7@redhat.com>

Hi,

On 2024-08-01 10:52:55+0000, Hans de Goede wrote:
> On 7/31/24 10:55 PM, Daniel Vetter wrote:
> > On Wed, Jul 31, 2024 at 08:40:12PM +0300, Jani Nikula wrote:
> >> On Wed, 31 Jul 2024, Thomas Weißschuh <linux@weissschuh.net> wrote:
> >>> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> >>> is "12". This leads to a fairly bright minimum display backlight.
> >>>
> >>> Add a generic override helper for the user to override the settings
> >>> provided by the firmware through the kernel cmdline.
> >>> Also add amdgpu as a user of that helper.
> >>>
> >>> One solution would be a fixed firmware version, which was announced but
> >>> has no timeline.
> >>
> >> The flip side is that if we add this now, it pretty much has a timeline:
> >> We'll have to carry and support it forever.
> >>
> >> It's not a great prospect for something so specific. Not to mention that
> >> the limits are generally there for electrical minimums that should not
> >> be overridden. And before you know it, we'll have bug reports about
> >> flickering screens...
> > 
> > Yeah I think for this specific case where a fixed firmware is already
> > kinda promised, a quirk is the right fix. Otherwise we open up a can of
> > worms here ... so personally I like v2 a lot more.
> > -Sima
> 
> Ok, with both Jani and Sima preferring the quirk approach from v2,
> I withdraw my objection against v2. So lets go with that version.

Ack.

I want to note though, that there are enough other commandline
options that can mess things up.
An invalid video=MODELINE, custom ACPI tables, etc, so the fallout from the
new commandline variable doesn't seem too bad to me.

> Thomas, sorry about this.

No worries!

> I see that other then a remark from Jeff Johnson about a missing
> MODULE_DESCRIPTION() v2 does not have any reviews yet though.
> 
> So we will need to review that version now. Might be best for
> visibility of the patches in people's review queue to repost
> v2 as v4 with the MODULE_DESCRIPTION() fixed ?

I can do that.

> 
> >>> This helper does conflict with the mode override via the cmdline.
> >>> Only one can be specified.
> >>> IMO the mode override can be extended to also handle "min-brightness"
> >>> when that becomes necessary.
> >>>
> >>> ---
> >>> Changes in v3:
> >>> - Switch to cmdline override parameter
> >>> - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net
> >>>
> >>> Changes in v2:
> >>> - Introduce proper drm backlight quirk infrastructure
> >>> - Quirk by EDID and DMI instead of only DMI
> >>> - Limit quirk to only single Framework 13 matte panel
> >>> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
> >>>
> >>> ---
> >>> Thomas Weißschuh (2):
> >>>       drm/connector: add drm_connector_get_cmdline_min_brightness_override()
> >>>       drm/amd/display: implement minimum brightness override
> >>>
> >>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++++
> >>>  drivers/gpu/drm/drm_connector.c                   | 34 +++++++++++++++++++++++
> >>>  include/drm/drm_connector.h                       |  2 ++
> >>>  3 files changed, 42 insertions(+)
> >>> ---
> >>> base-commit: 36821612eb3091a21f7f4a907b497064725080c3
> >>> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> >>>
> >>> Best regards,
> >>
> >> -- 
> >> Jani Nikula, Intel
> > 
> 

