Return-Path: <linux-kernel+bounces-226427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED2913E40
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6ED281A21
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C546A185083;
	Sun, 23 Jun 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmoZ4qVx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D12232A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176151; cv=none; b=gG8jDduU5hKPYjYCsVBvBF6iCVUwhvlUuCo4WTHGo/5ZViY3rvkeedfha3Ou7pG/e/TZirpzx1TzGant8rF1c3UTge9NXmikgFMF1Tmb9ZGsUSV2uOLSRIvan3MDprlTR3wXu/BxJyQqexfoYQqLXjLalkEoaxTLk16uKoBXmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176151; c=relaxed/simple;
	bh=MhIlsqIl+BgkxBAsbuBhWVYU/n/G+yuBh83YBEeViRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWB2FQqy4wbt/j37W50SuXRCczNkJGlXN5Y3e1qH6SuAXxBJtYvcQN8jWEOEcMP8fdILUbF6vOh2+rXer3+noZzbhRk552Qdl6cEVsDTgd+jCvk0SqISiJ2GQEWxEUm1bHLrRZtX4wivDIey+7lhimxuEOuNSQedms3fesPCjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmoZ4qVx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719176148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycGA0qob45Gs1RubeX/VV0b+q84aeVVnPxRQS1lp6wk=;
	b=LmoZ4qVxVTffa1E55dhb729GcpvF6ebC+6uuv1EV8kFOls4S5CM45tBcpiVCyEWc6Og7Lc
	HQzZ2j+tnz3skX0Zv6IhwLyN2ar45XENOS3gSuhVf4CiXYimiotLVbes9AXsIsP63c91rw
	lxLJqO3gRrvNXcdB1iI9m7USItwh7TI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-GjwwdzA2M0630hTRbDuWtA-1; Sun, 23 Jun 2024 16:55:47 -0400
X-MC-Unique: GjwwdzA2M0630hTRbDuWtA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52cd8c15ce5so1532249e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719176146; x=1719780946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycGA0qob45Gs1RubeX/VV0b+q84aeVVnPxRQS1lp6wk=;
        b=hMuKAjmNbBOIbLoNLp2p0+Ag4Tv2AWkpTQp5RI9fYgWFy4kXiSe2Vj9ZyjOEMD4OCi
         sdVzLORaVhGHk9fT+J8hm+0+OsNwMC1y463Gc6C8tysgS5NFxZCk/MQELozjdlHFTwiP
         EG2md61Peo4paQIG5lpauEGhen5dZ4wb25MHRkcYCg0UC/8t5enAD7/4u4stxPJcYVqY
         mv0ds6xlLN82YMCxYqmfaNnuFvmAYqUuAYv1qMSNZICJ89UX8Lh4rWjNbKzTG9g4zvac
         hso1XGJlCao7f93C0B5iX48HtL64W8laQTKXscd1yoRH7G8UoLK0uPyE2kNpsik6HjE2
         1EGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTDlMGJTSjipcs1mOtvVQEte0LUSmLiSyLM+MerFhlZHDXx6Uymobqy4TzGiei+RmFhqbd1BNB3tlOTUuoUs4UnBdefQwn5K5O3sWw
X-Gm-Message-State: AOJu0YzZ8xi71QLwDmkgzeZynxNEDnJ2MQyx8VyhY+5ithD5yv1sO5mO
	W1sHrKx3phuu5EJ+irnJbJS7Pw+OnTVC+7LlSbO9BPzW6RiyuGdNJh01zWqfInjg0Ip1n8uaVT5
	jungHTADqCWOCjTD+4mj5MKoBDytg80FZebDkaLvCjWB0Uc3C6PIgybGAu+14rA==
X-Received: by 2002:ac2:4197:0:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-52ce186148amr1641205e87.56.1719176145974;
        Sun, 23 Jun 2024 13:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHULZezCOzaC6cUPhJ8LIzccLuS/UbKNm+jMLcGXD6TlSFd2ofykFgOEvn07ITPHKbvfB3HbQ==
X-Received: by 2002:ac2:4197:0:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-52ce186148amr1641192e87.56.1719176145491;
        Sun, 23 Jun 2024 13:55:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72554a5d94sm33680166b.196.2024.06.23.13.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 13:55:44 -0700 (PDT)
Message-ID: <ad5d7ff3-e013-46d0-9ddb-5b0afc3dc870@redhat.com>
Date: Sun, 23 Jun 2024 22:55:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm: Add panel backlight quirks
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>,
 Matthew Anderson <ruinairas1992@gmail.com>,
 "Derek J. Clark" <derkejohn.clark@gmail.com>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
 <efc9165d-856a-44a1-a93f-e7467cd2cceb@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <efc9165d-856a-44a1-a93f-e7467cd2cceb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/23/24 10:20 PM, Mario Limonciello wrote:
> On 6/23/2024 03:51, Thomas Weißschuh wrote:
>> Panels using a PWM-controlled backlight source without an do not have a
>> standard way to communicate their valid PWM ranges.
>> On x86 the ranges are read from ACPI through driver-specific tables.
>> The built-in ranges are not necessarily correct, or may grow stale if an
>> older device can be retrofitted with newer panels.
>>
>> Add a quirk infrastructure with which the valid backlight ranges can be
>> maintained as part of the kernel.
>>
> 
> So I was just talking to some folks in the Linux handheld gaming community (added to CC) about an issue they have where they need to know the correct panel orientation.  Due to reuse of panels across vendors the orientation on one might not be appropriate on another.  The trick is then to detect the combo of both the panel and the DMI data.
> 
> It's the same "kind" of problem where something advertised in the firmware should be ignored but only on a panel + SMBIOS combination.
> 
> So I am wondering if what you're proposing here could be more generalized.  IE "drm_panel_quirks.c" instead?
> 
> Thoughts?

Note we already have a quirk mechanism for non upright mounted lcd-panels:

drivers/gpu/drm/drm_panel_orientation_quirks.c

note that the info here is shared with the simpledrm and
efifb drivers, so if the chose is made to extend this then
that needs to be taken into account.

Regards,

Hans





>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>   Documentation/gpu/drm-kms-helpers.rst        |  3 ++
>>   drivers/gpu/drm/Kconfig                      |  4 ++
>>   drivers/gpu/drm/Makefile                     |  1 +
>>   drivers/gpu/drm/drm_panel_backlight_quirks.c | 67 ++++++++++++++++++++++++++++
>>   include/drm/drm_utils.h                      | 11 +++++
>>   5 files changed, 86 insertions(+)
>>
>> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
>> index 59cfe8a7a8ba..1998a2675210 100644
>> --- a/Documentation/gpu/drm-kms-helpers.rst
>> +++ b/Documentation/gpu/drm-kms-helpers.rst
>> @@ -224,6 +224,9 @@ Panel Helper Reference
>>   .. kernel-doc:: drivers/gpu/drm/drm_panel_orientation_quirks.c
>>      :export:
>>   +.. kernel-doc:: drivers/gpu/drm/drm_panel_backlight_quirks.c
>> +   :export:
>> +
>>   Panel Self Refresh Helper Reference
>>   ===================================
>>   diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 959b19a04101..50ccb43315bf 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -443,6 +443,10 @@ config DRM_EXPORT_FOR_TESTS
>>   config DRM_PANEL_ORIENTATION_QUIRKS
>>       tristate
>>   +# Separate option as not all DRM drivers use it
>> +config DRM_PANEL_BACKLIGHT_QUIRKS
>> +    tristate
>> +
>>   config DRM_LIB_RANDOM
>>       bool
>>       default n
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index f9ca4f8fa6c5..6669913b907e 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -92,6 +92,7 @@ drm-$(CONFIG_DRM_PANIC) += drm_panic.o
>>   obj-$(CONFIG_DRM)    += drm.o
>>     obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
>> +obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
>>     #
>>   # Memory-management helpers
>> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
>> new file mode 100644
>> index 000000000000..a89b5fd1940e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/dmi.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <drm/drm_connector.h>
>> +#include <drm/drm_utils.h>
>> +
>> +struct drm_panel_backlight_entry {
>> +    struct {
>> +        enum dmi_field field;
>> +        const char * const value;
>> +    } dmi_match;
>> +    struct drm_edid_ident ident;
>> +    struct drm_panel_backlight_quirk quirk;
>> +};
>> +
>> +static const struct drm_panel_backlight_entry drm_panel_backlight_entries[] = {
>> +};
>> +
>> +static bool drm_panel_backlight_entry_matches(const struct drm_panel_backlight_entry *entry,
>> +                          const struct drm_edid *edid)
>> +{
>> +    if (!dmi_match(entry->dmi_match.field, entry->dmi_match.value))
>> +        return false;
>> +
>> +    if (!drm_edid_match(edid, &entry->ident))
>> +        return false;
>> +
>> +    return true;
>> +}
>> +
>> +/**
>> + * drm_get_panel_panel_quirk - Check for panel backlight quirks
>> + * @edid: EDID of the panel to check
>> + *
>> + * This function checks for platform specific (e.g. DMI based) quirks
>> + * providing info on backlight control for systems where this cannot be
>> + * probed from the hard-/firm-ware.
>> + *
>> + * Returns:
>> + * A struct drm_panel_backlight_quirk if a quirk is found or NULL otherwise.
>> + */
>> +const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid)
>> +{
>> +    const struct drm_panel_backlight_entry *entry;
>> +    size_t i;
>> +
>> +    if (!IS_ENABLED(CONFIG_DMI))
>> +        return NULL;
>> +
>> +    if (!edid)
>> +        return NULL;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(drm_panel_backlight_entries); i++) {
>> +        entry = &drm_panel_backlight_entries[i];
>> +
>> +        if (drm_panel_backlight_entry_matches(entry, edid))
>> +            return &entry->quirk;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +EXPORT_SYMBOL(drm_get_panel_backlight_quirk);
>> +
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
>> index 70775748d243..37cc6de1a01a 100644
>> --- a/include/drm/drm_utils.h
>> +++ b/include/drm/drm_utils.h
>> @@ -11,9 +11,20 @@
>>   #define __DRM_UTILS_H__
>>     #include <linux/types.h>
>> +#include <drm/drm_edid.h>
>> +
>> +struct drm_panel_backlight_quirk {
>> +    struct {
>> +        bool pwm_min_brightness:1;
>> +    } overrides;
>> +
>> +    u8 pwm_min_brightness; /* min_brightness/255 of max */
>> +};
>>     int drm_get_panel_orientation_quirk(int width, int height);
>>   +const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid);
>> +
>>   signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
>>     #endif
>>
> 


