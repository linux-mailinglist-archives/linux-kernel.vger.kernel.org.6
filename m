Return-Path: <linux-kernel+bounces-296650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA1295AD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47589283195
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E96136354;
	Thu, 22 Aug 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Cep8Ey4o"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BB1CAA6;
	Thu, 22 Aug 2024 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307128; cv=none; b=QOeDTtOM2wJwEW3jILJNx7rOTe4P0tMvMGhhjb41V18cBY81epWiBnCpn5PYDT8ayOLjooN5kcXSPkVvQ2TIbmykQ7UFHekgjt10fdQshuvGeb3j58q6juOwiE0Ynq+xHsYPOJOaSFkicMAniWw1ZqH000nixSsTAhd0ixl3OMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307128; c=relaxed/simple;
	bh=Ll0eFfhpuU1oGsENGFevzKkMJM5AObXPdlRvemU7hAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqRulVyJ92jJSonmRprzfSMbNCg3LZC/TjAyeUg0GnjMONKo7ug21Pb/mSIvjiE4rtJPAYLyphkLQQpL1gQjNofO4LLlbxdB6FjoTqWJ8YuRpW914epyFZtYCJax88g5A7I0oevey8csYr2vqeTgPJfKv/fZRS5UxR+J2K+2a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Cep8Ey4o; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724307121;
	bh=Ll0eFfhpuU1oGsENGFevzKkMJM5AObXPdlRvemU7hAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cep8Ey4o6M6YW/t02LL6UYFETAes5hQ3OJKAmlgFjfqozTxhWCHyaaBCbxJPkrdmS
	 4mwHH4AkHN98jFgmVfqa7ETAJ+kU2xWcTKhJ252YQFd9m6WeSa1SyCU6ODUXjUSVNK
	 Xy2ey4n80U8f+mnjL61epR3f007yq+l8Nkauycrw=
Date: Thu, 22 Aug 2024 08:12:01 +0200
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
Subject: Re: [PATCH v5 1/4] drm: Add panel backlight quirks
Message-ID: <f3dac7f6-22ee-483e-b2f3-3a1c900c3f06@t-8ch.de>
References: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
 <20240818-amdgpu-min-backlight-quirk-v5-1-b6c0ead0c73d@weissschuh.net>
 <5363536d-0f96-4e96-8f1f-c8e1799b6421@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5363536d-0f96-4e96-8f1f-c8e1799b6421@amd.com>

On 2024-08-21 15:51:17+0000, Mario Limonciello wrote:
> On 8/18/2024 01:56, Thomas Weißschuh wrote:
> > Panels using a PWM-controlled backlight source do not have a standard
> > way to communicate their valid PWM ranges.
> > On x86 the ranges are read from ACPI through driver-specific tables.
> > The built-in ranges are not necessarily correct, or may grow stale if an
> > older device can be retrofitted with newer panels.
> > 
> > Add a quirk infrastructure with which the minimum valid backlight value
> > can be maintained as part of the kernel.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > Tested-by: Dustin L. Howett <dustin@howett.net>
> 
> One small nit below but otherwise this patch is fine to me.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> > ---
> >   Documentation/gpu/drm-kms-helpers.rst        |  3 ++
> >   drivers/gpu/drm/Kconfig                      |  4 ++
> >   drivers/gpu/drm/Makefile                     |  1 +
> >   drivers/gpu/drm/drm_panel_backlight_quirks.c | 70 ++++++++++++++++++++++++++++
> >   include/drm/drm_utils.h                      |  4 ++
> >   5 files changed, 82 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> > index 8435e8621cc0..a26989500129 100644
> > --- a/Documentation/gpu/drm-kms-helpers.rst
> > +++ b/Documentation/gpu/drm-kms-helpers.rst
> > @@ -230,6 +230,9 @@ Panel Helper Reference
> >   .. kernel-doc:: drivers/gpu/drm/drm_panel_orientation_quirks.c
> >      :export:
> > +.. kernel-doc:: drivers/gpu/drm/drm_panel_backlight_quirks.c
> > +   :export:
> > +
> >   Panel Self Refresh Helper Reference
> >   ===================================
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 6b2c6b91f962..9ebb8cdb535e 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -454,6 +454,10 @@ config DRM_HYPERV
> >   config DRM_EXPORT_FOR_TESTS
> >   	bool
> > +# Separate option as not all DRM drivers use it
> > +config DRM_PANEL_BACKLIGHT_QUIRKS
> > +	tristate
> > +
> >   config DRM_LIB_RANDOM
> >   	bool
> >   	default n
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 68cc9258ffc4..adf85999aee2 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -92,6 +92,7 @@ drm-$(CONFIG_DRM_PANIC) += drm_panic.o
> >   obj-$(CONFIG_DRM)	+= drm.o
> >   obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
> > +obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
> >   #
> >   # Memory-management helpers
> > diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > new file mode 100644
> > index 000000000000..6b8bbed77c7f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/dmi.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <drm/drm_edid.h>
> > +#include <drm/drm_utils.h>
> > +
> > +struct drm_panel_min_backlight_quirk {
> > +	struct {
> > +		enum dmi_field field;
> > +		const char * const value;
> > +	} dmi_match;
> > +	struct drm_edid_ident ident;
> > +	u8 min_brightness;
> > +};
> > +
> > +static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks[] = {
> > +};
> > +
> > +static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
> > +						  const struct drm_edid *edid)
> > +{
> > +	if (!dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
> > +		return false;
> > +
> > +	if (!drm_edid_match(edid, &quirk->ident))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/**
> > + * drm_get_panel_min_brightness_quirk - Get minimum supported brightness level for a panel.
> > + * @edid: EDID of the panel to check
> > + *
> > + * This function checks for platform specific (e.g. DMI based) quirks
> > + * providing info on the minimum backlight brightness for systems where this
> > + * cannot be probed correctly from the hard-/firm-ware.
> > + *
> > + * Returns:
> > + * A negative error value or
> > + * an override value in the range [0, 255] representing 0-100% to be scaled to
> > + * the drivers target range.
> > + */
> > +int drm_get_panel_min_brightness_quirk(const struct drm_edid *edid)
> > +{
> > +	const struct drm_panel_min_backlight_quirk *quirk;
> > +	size_t i;
> 
> Nit: this doesn't really seem like it needs to be size_t.  Shouldn't it just
> be an unsigned int?

ARRAY_SIZE() works with sizeof() which returns size_t.
It doesn't really matter, but I slightly prefer to keep the size_t.

> > +
> > +	if (!IS_ENABLED(CONFIG_DMI))
> > +		return -ENODATA;
> > +
> > +	if (!edid)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(drm_panel_min_backlight_quirks); i++) {
> > +		quirk = &drm_panel_min_backlight_quirks[i];
> > +
> > +		if (drm_panel_min_backlight_quirk_matches(quirk, edid))
> > +			return quirk->min_brightness;
> > +	}
> > +
> > +	return -ENODATA;
> > +}
> > +EXPORT_SYMBOL(drm_get_panel_min_brightness_quirk);
> > +
> > +MODULE_DESCRIPTION("Quirks for panel backlight overrides");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> > index 70775748d243..15fa9b6865f4 100644
> > --- a/include/drm/drm_utils.h
> > +++ b/include/drm/drm_utils.h
> > @@ -12,8 +12,12 @@
> >   #include <linux/types.h>
> > +struct drm_edid;
> > +
> >   int drm_get_panel_orientation_quirk(int width, int height);
> > +int drm_get_panel_min_brightness_quirk(const struct drm_edid *edid);
> > +
> >   signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
> >   #endif
> > 
> 

