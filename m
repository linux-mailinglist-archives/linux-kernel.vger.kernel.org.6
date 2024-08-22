Return-Path: <linux-kernel+bounces-296651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19AE95AD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4161F22796
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714D13667E;
	Thu, 22 Aug 2024 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sJ0dPAUG"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C88249F9;
	Thu, 22 Aug 2024 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307253; cv=none; b=sn/jAbGEqOEFMHvB32dURkRbMt0u0QOVrh1TfiBJmrcsSgce9rdC0GL6hPJ4xoe6VU14GmtQPf+gT9sc3x2u9Lfo63mY/p+g5YF3Nf5YRJlEJ0FWXKQv3Yn4uvoRsEQNLDJ9k2xGU4eDsCX8ENNEt8Jz4FUTVcf80PQXXtfndbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307253; c=relaxed/simple;
	bh=0Y/ciKTzZkQ+UpszSzWZPWqXScC6SCCtpDjN+A3yG7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6eD/UB6ueBv8/Z8td3NkrmIIkaHcjTa3kNqtUkX9i7p04AOm+JZ6+9pgv2ylGd7tzbwaMN1O9gwBQHS4SIRAzfxPDjno+CoJK0unxzEcTriKJjK4SDxlKecLdzCAUnapFBbK2DMBXxINx2oQUeZtd/y9d9+HalG64B2frW7DyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sJ0dPAUG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724307249;
	bh=0Y/ciKTzZkQ+UpszSzWZPWqXScC6SCCtpDjN+A3yG7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJ0dPAUGK6gypyetwVFxLQEA0DG3sSP4t+LzL/aFhJdAwsq7G0AS1Cwww6cFkkmhY
	 yGbcNYsn5UfVrmjz6qY2xaYSgUAVHq4rXbqJAb9qmbeoYN4+lozQu5eN0RMXEBQu1q
	 v0WKppaqldyXLShiYOvSWvmmKDLzx3gUXiFXB0mc=
Date: Thu, 22 Aug 2024 08:14:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Matt Hartley <matt.hartley@gmail.com>, 
	Kieran Levin <ktl@framework.net>, Hans de Goede <hdegoede@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/4] drm/amd/display: Add support for minimum
 backlight quirk
Message-ID: <f516b4af-0dac-4607-bdab-e4c83395fe04@t-8ch.de>
References: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
 <20240818-amdgpu-min-backlight-quirk-v5-2-b6c0ead0c73d@weissschuh.net>
 <269b2e72-2f93-4415-a56e-77536f373b22@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <269b2e72-2f93-4415-a56e-77536f373b22@amd.com>

On 2024-08-21 15:54:14+0000, Mario Limonciello wrote:
> On 8/18/2024 01:56, Thomas Weißschuh wrote:
> > Not all platforms provide correct PWM backlight capabilities through ATIF.
> 
> I don't think correct is an accurate term here.  How about 'optimial'?

Looks typoed to me :-)

What about this?

Not all platforms provide the full range of PWM backlight capabilities
supported by the hardware through ATIF.


> > Use the generic drm panel minimum backlight quirk infrastructure to
> > override the capabilities where necessary.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > Tested-by: Dustin L. Howett <dustin@howett.net>
> 
> The code looks fine to me but please wait for an ack from someone on the AMD
> display team.
> 
> Also, I would like to see comments about the testing with panel power
> savings enabled to avoid a conflict.

Ack.

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
> >   2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > index 0051fb1b437f..655c10aef2e3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > @@ -23,6 +23,7 @@ config DRM_AMDGPU
> >   	select DRM_BUDDY
> >   	select DRM_SUBALLOC_HELPER
> >   	select DRM_EXEC
> > +	select DRM_PANEL_BACKLIGHT_QUIRKS
> >   	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
> >   	# ACPI_VIDEO's dependencies must also be selected.
> >   	select INPUT if ACPI
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 983a977632ff..056960ea335c 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -93,6 +93,7 @@
> >   #include <drm/drm_fourcc.h>
> >   #include <drm/drm_edid.h>
> >   #include <drm/drm_eld.h>
> > +#include <drm/drm_utils.h>
> >   #include <drm/drm_vblank.h>
> >   #include <drm/drm_audio_component.h>
> >   #include <drm/drm_gem_atomic_helper.h>
> > @@ -3333,6 +3334,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
> >   	struct drm_connector *conn_base;
> >   	struct amdgpu_device *adev;
> >   	struct drm_luminance_range_info *luminance_range;
> > +	const struct drm_edid *drm_edid;
> > +	int min_input_signal_override;
> >   	if (aconnector->bl_idx == -1 ||
> >   	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
> > @@ -3367,6 +3370,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
> >   		caps->aux_min_input_signal = 0;
> >   		caps->aux_max_input_signal = 512;
> >   	}
> > +
> > +	drm_edid = drm_edid_alloc(aconnector->edid,
> > +				  EDID_LENGTH * (aconnector->edid->extensions + 1));
> > +	min_input_signal_override = drm_get_panel_min_brightness_quirk(drm_edid);
> > +	drm_edid_free(drm_edid);
> > +	if (min_input_signal_override >= 0)
> > +		caps->min_input_signal = min_input_signal_override;
> >   }
> >   void amdgpu_dm_update_connector_after_detect(
> > 
> 

