Return-Path: <linux-kernel+bounces-226915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9089145A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723B7285AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C856A347;
	Mon, 24 Jun 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFYvTTq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398347FD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219653; cv=none; b=X/pCPRMKr/Nyshv69x/PiVz27RdXvu7JoaKYmoBW95jbb/e4G9zWAfHYWZkKQpFYg9s5gFeCDKZgVAVXEAaAcayevzEVi0NdCyEn9rHDdWTrU0TPr/XvIV+UU/U//akl0YPadJ6/jCAh9z8o9iPSYETzm80MiA1TFxWVRncCsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219653; c=relaxed/simple;
	bh=JTVewgJJgxPyjotNJis5A7FurUfkC489C8Wdu4SCPcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqTEsdQWYTOkvv9fktssHvUDm5uRYkHPWYlDxv5uMbivdqkhDWudmCmW4dZMLMU4ah0bWx/NCOJroK76c73XEaH9dElZIy2b3Xo8WZx0XPssm1PtbzMKm0cZRhNi3Y3xla/RgUL77hL01lA9FXonFtQXpJAHGiK7rlPMXPji9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFYvTTq/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719219650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwzmRUQPsKQBeShL2OB+EDS/R27ivaae/oICxqvSPpk=;
	b=ZFYvTTq/N3ssEVmiu4Jh53DxjSIyvGPcJr2OeUlsdFdZEIzLvVL0OCDU8gO84cs0TfzDNN
	rtNUt4ENrKytqV9v/Zoit/NV7sowWwB9Vg2TgRaehfp2TzK+OBDb2C5cu39nYZAHpJVImd
	RZQ+OfemD1cfcg6wixIv6/cipOJSFz4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-PdzOPHiPPLa0DEpE6g155Q-1; Mon, 24 Jun 2024 05:00:49 -0400
X-MC-Unique: PdzOPHiPPLa0DEpE6g155Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7244d1b086so92952466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219647; x=1719824447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwzmRUQPsKQBeShL2OB+EDS/R27ivaae/oICxqvSPpk=;
        b=Iw/vGo2DGfy/q/Sppue+gxmC15p8dx3T3dfRl3ucrMgo86L3d95SL1M9CArWWGToUM
         MOhVNLNlFIZzJKMLMqb3O1iMupeBir990DLfQXgpEFj1db9+TkZzQO5hgxXSkcoSnxNv
         x0RSKFobMmF8LwXQwDURhYy1lhFxE9WvpP0COSU2ZFr9AMNzrFucllfipL9+tECF9cUo
         W5S77OUmSIfTzpSczs0uD/CG47J3i666eDB7WByGTO544iEOz76CoexIghMZQpvO0Qpd
         1nE1mURDU0f2jxeYXSzz3mKnP7VTEzDh6WkxQRo7ND6btv2MAEGGHmQ3Q6AbXESo3mTf
         GVnw==
X-Forwarded-Encrypted: i=1; AJvYcCXvHsVD6Gxpmptxi6DlXDNDSeH8mTOPvHKAHimNiVr37dHi6I3JCc4zCbuiQNsDWM3pMSXJUMmKz/9O3hi1CY13+9eQtSF/IZwg71rL
X-Gm-Message-State: AOJu0YzydDOYLUIxglWsvmtnBoM+N2LxW6g7pRudvEpx8Cm2Sw5bA2HQ
	DeK7+bjntv0/MnGi33jjN4miNEOnVqNiOl/8xzzaxQz2dMwp1ehxG3Aw34ZGBqZOMAvJQYP2olv
	+A0mtODoFLPgLQmgmq4otVFA15rHXR18/eVoekXefJoujuHFISskupDRJQ6yw0pUKte6EBg==
X-Received: by 2002:a17:906:150d:b0:a6f:f1bc:21ce with SMTP id a640c23a62f3a-a7245c4837emr240507066b.47.1719219647538;
        Mon, 24 Jun 2024 02:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFDg4vMl4mXJj0YJkOY4Yu0h9QNLUUllyhO25TzJD0zz4pk3MzzNyFs/gus8N4uz64OpOug==
X-Received: by 2002:a17:906:150d:b0:a6f:f1bc:21ce with SMTP id a640c23a62f3a-a7245c4837emr240505366b.47.1719219647050;
        Mon, 24 Jun 2024 02:00:47 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7250010f77sm125328266b.181.2024.06.24.02.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:00:46 -0700 (PDT)
Message-ID: <cee2effc-8295-4d96-b544-e225cd0d73fb@redhat.com>
Date: Mon, 24 Jun 2024 11:00:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm: Add panel backlight quirks
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
> Panels using a PWM-controlled backlight source without an do not have a
> standard way to communicate their valid PWM ranges.
> On x86 the ranges are read from ACPI through driver-specific tables.
> The built-in ranges are not necessarily correct, or may grow stale if an
> older device can be retrofitted with newer panels.
> 
> Add a quirk infrastructure with which the valid backlight ranges can be
> maintained as part of the kernel.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  Documentation/gpu/drm-kms-helpers.rst        |  3 ++
>  drivers/gpu/drm/Kconfig                      |  4 ++
>  drivers/gpu/drm/Makefile                     |  1 +
>  drivers/gpu/drm/drm_panel_backlight_quirks.c | 67 ++++++++++++++++++++++++++++
>  include/drm/drm_utils.h                      | 11 +++++
>  5 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 59cfe8a7a8ba..1998a2675210 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -224,6 +224,9 @@ Panel Helper Reference
>  .. kernel-doc:: drivers/gpu/drm/drm_panel_orientation_quirks.c
>     :export:
>  
> +.. kernel-doc:: drivers/gpu/drm/drm_panel_backlight_quirks.c
> +   :export:
> +
>  Panel Self Refresh Helper Reference
>  ===================================
>  
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 959b19a04101..50ccb43315bf 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -443,6 +443,10 @@ config DRM_EXPORT_FOR_TESTS
>  config DRM_PANEL_ORIENTATION_QUIRKS
>  	tristate
>  
> +# Separate option as not all DRM drivers use it
> +config DRM_PANEL_BACKLIGHT_QUIRKS
> +	tristate
> +
>  config DRM_LIB_RANDOM
>  	bool
>  	default n
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index f9ca4f8fa6c5..6669913b907e 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -92,6 +92,7 @@ drm-$(CONFIG_DRM_PANIC) += drm_panic.o
>  obj-$(CONFIG_DRM)	+= drm.o
>  
>  obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
> +obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
>  
>  #
>  # Memory-management helpers
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> new file mode 100644
> index 000000000000..a89b5fd1940e
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/array_size.h>
> +#include <linux/dmi.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_utils.h>
> +
> +struct drm_panel_backlight_entry {
> +	struct {
> +		enum dmi_field field;
> +		const char * const value;
> +	} dmi_match;

Matching on a single DMI string is not always enough to uniquely identify
a machine. I would change this to a dmi_system_id struct and then add
an array with 2 dmi_system_id structs in drm_panel_backlight_entry_matches()
and copy the struct to the first array entry + zero out the second entry
(terminator) and then use dmi_check_system().

> +	struct drm_edid_ident ident;

Hmm, what about DSI panels? These do not (always) have EDID info AFAIK.

drivers/gpu/drm/drm_panel_orientation_quirks.c is using a resolution match
so as to hopefully not match external screens, but that is also so that it can
be used from efifb / simpledrm and here you really do want to differentiate
between different panels by panel model.

So I guess that the EDId match is fine and if we ever need to match DSI panels
without EDID we figure something out then.

Thinking more about this I have a question about the approach as a whole though,
I'll reply to the cover-letter with this.

Regards,

Hans



> +	struct drm_panel_backlight_quirk quirk;
> +};
> +
> +static const struct drm_panel_backlight_entry drm_panel_backlight_entries[] = {
> +};
> +
> +static bool drm_panel_backlight_entry_matches(const struct drm_panel_backlight_entry *entry,
> +					      const struct drm_edid *edid)
> +{
> +	if (!dmi_match(entry->dmi_match.field, entry->dmi_match.value))
> +		return false;
> +
> +	if (!drm_edid_match(edid, &entry->ident))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * drm_get_panel_panel_quirk - Check for panel backlight quirks
> + * @edid: EDID of the panel to check
> + *
> + * This function checks for platform specific (e.g. DMI based) quirks
> + * providing info on backlight control for systems where this cannot be
> + * probed from the hard-/firm-ware.
> + *
> + * Returns:
> + * A struct drm_panel_backlight_quirk if a quirk is found or NULL otherwise.
> + */
> +const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid)
> +{
> +	const struct drm_panel_backlight_entry *entry;
> +	size_t i;
> +
> +	if (!IS_ENABLED(CONFIG_DMI))
> +		return NULL;
> +
> +	if (!edid)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(drm_panel_backlight_entries); i++) {
> +		entry = &drm_panel_backlight_entries[i];
> +
> +		if (drm_panel_backlight_entry_matches(entry, edid))
> +			return &entry->quirk;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(drm_get_panel_backlight_quirk);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 70775748d243..37cc6de1a01a 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -11,9 +11,20 @@
>  #define __DRM_UTILS_H__
>  
>  #include <linux/types.h>
> +#include <drm/drm_edid.h>
> +
> +struct drm_panel_backlight_quirk {
> +	struct {
> +		bool pwm_min_brightness:1;
> +	} overrides;
> +
> +	u8 pwm_min_brightness; /* min_brightness/255 of max */
> +};
>  
>  int drm_get_panel_orientation_quirk(int width, int height);
>  
> +const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid);
> +
>  signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
>  
>  #endif
> 


