Return-Path: <linux-kernel+bounces-274679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B0947B67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2011C211A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B425A1591F0;
	Mon,  5 Aug 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1xaeCBW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343A18026
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862527; cv=none; b=eByl7GXWpftMbERo4aKDb7uWfF5sdf5iotg2xuOrea29SX7vm83O9xniOyj80QfJo9ObhRGKFyjZCpZbXiHOXpQ3Dx+BfH8XD6wqS1biFczwRN63IPs3G4fHASf9GiSBapuCHVQ5MmnGzWrFi2JS8FMJDxM8XVXo1PWqz7MAzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862527; c=relaxed/simple;
	bh=rThXsOGnr4j9afVuGdaqTPtRPkern/KlSHXvW/NeASQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSAfh2bOVWK+xos9a1cvmAghJQaKfYtJmm53yq/gY08wecPQfSi5iM0l0bCp3CPD8rhORf2+nkCwM8I1F8kxst07xiw5Ld5E8pe/NcQQhaeTuRPj6rIBLyj9/AIMgg62tgIz6w6rEgwOExjHDeROQIF+2A96sZCzY/r2FPMtly8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1xaeCBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722862524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sFTkFFBzy68gGYyVFthr8XWWlGLTI9qL1cAt5iZfio=;
	b=K1xaeCBW31rtEmP/jsmeK5FB2rF7ewjuKt7e7JudHCGs3xQ8ETbl6JaPZfAzVFfliTeR53
	3DgANnzQo0AmYK4I2Z8GokTrYaUhJRREiWeI5TrRsEtiymlFlT2ct9/yXMOVuJhqO1wHrd
	Nnap1iEL8UQ1QREXBOdsAi0heXemnzM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-I7LB11RoNHSTFlpLLa7uCg-1; Mon, 05 Aug 2024 08:55:22 -0400
X-MC-Unique: I7LB11RoNHSTFlpLLa7uCg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7aa56d8b14so834968266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862521; x=1723467321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sFTkFFBzy68gGYyVFthr8XWWlGLTI9qL1cAt5iZfio=;
        b=cFQq3lLBc0p9ijOVBORibSMTVP+26errguGOesd1UVbuai6pCEjxlC/4SsKvUBlNSB
         LvgWpevV1DE16trfhZNDwipnhzXoLsE0cjzsLhyj4hs3vpOIzCrNl/iqWy/sOjeBh0Y5
         7SRtOdPteZFf0fVE8YJNt1GvTVD2zr+k2YdUbUm3AVF+vDNLLAy79EamfyK8bOFUuXBZ
         L2lv2eqgWKfNqVqMMumC5N4wzQj2mcJOdO4I0y79HWYhgGanRjzF+8rQgkVR0CKy0mQD
         bGmSkZeDC6o6HIQtFdWwMRHQa62xVSKWMDFi9uMrAMFTpC+s/kWNIdd97l8DJUJilRqP
         zuww==
X-Forwarded-Encrypted: i=1; AJvYcCUKr4kZZkyN+cSB06hZ2Ja5PI7iNAOv+4xtId7AthBJ1XaVB8xpD3xl4Lu4u7s5z8PRfDAsCTxwrX86omAeHpQ427GKr8LPmOajqli6
X-Gm-Message-State: AOJu0Yy6TTwrmhU9L1f6OAPdwDClDtOvW5Mcnh8pJBdgBQEcebK/Vy7a
	0eYcfY7ntTI+tR2ivtibSMLBy0ET1W5gv2CHQj/om8nY9muPe0XL0xqVM6zFbUVt0DkAGrgwtV0
	1J53DmzPUAseHVl3tsnqfP3t6uUQ5PfbsT1WQIJKCenMRqNggajLEixplagJBpw==
X-Received: by 2002:a17:906:d262:b0:a7a:9f78:fef with SMTP id a640c23a62f3a-a7dc5179f86mr918969266b.45.1722862521511;
        Mon, 05 Aug 2024 05:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9YeBvy8oWLp/NyTyOio/5DPMJElgRHoNwm4t6biuGr97/fY6gQoYH1jOlXD1POvqPTXGZVQ==
X-Received: by 2002:a17:906:d262:b0:a7a:9f78:fef with SMTP id a640c23a62f3a-a7dc5179f86mr918967066b.45.1722862520880;
        Mon, 05 Aug 2024 05:55:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4542esm452408766b.127.2024.08.05.05.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:55:20 -0700 (PDT)
Message-ID: <df84bf60-bcb4-4fcc-bbf2-d627714e365d@redhat.com>
Date: Mon, 5 Aug 2024 14:55:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
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
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> is "12". This leads to a fairly bright minimum display backlight.
> 
> Add a generic quirk infrastructure for backlight configuration to
> override the settings provided by the firmware.
> Also add amdgpu as a user of that infrastructure and a quirk for the
> Framework 13 matte panel.
> Most likely this will also work for the glossy panel, but I can't test
> that.
> 
> One solution would be a fixed firmware version, but given that the
> problem exists since the release of the hardware, it has been known for
> a month that the hardware can go lower and there was no acknowledgment
> from Framework in any way, I'd like to explore this alternative
> way forward.
> 
> Notes:
> 
> * Should the quirk infrastructure be part of drm_edid.c?
> * The current allocation of struct drm_edid in amdgpu is bad.
>   But it is done the same way in other parts of amdgpu.
>   I do have patches migrating amdgpu to proper usage of struct drm_edid [0]

So now that we have agreed to move forward with this approach one
generic design issue / question which popped into my head is:

What happens if i915 also gets support for the minimum brightness quirk?

Specifically the panel used on the framework 13 will match the quirk
independent of which GPU driver is used. But does say a minimum value
of "5" have the same meaning / results in the same minimum duty-cycle
when used by the i915 code vs the amdgpu code ?

I know that the actual quirk sets the min pwm to 0, which presumably results
in a 0% duty cycle on both i915 and amdgpu, but I'm worried what happens
if we see the same panel used in designs which can have it attached to
different vendor GPUs, how should the GPU driver interpret the
pwm_min_brightness value so that it is interpretted consistently between
drivers ? 

I guess this is covered by the docbook saying that min-brightness is on
a 0-255 brightness scale (with 255 being 100%) though ?  Just making sure
that everyone has agreement on that being the scale and that drivers
should not directly take this value but scale it as necessary.
This should also (scale it as necessary) be explicitly mentioned in
the docs IMHO.

Regards,

Hans






> Mario:
> 
> I intentionally left out the consideration of the firmware version.
> The quirk will stay correct even if the firmware starts reporting
> correct values.
> If there are strong opinions it would be easy to add, though.
> 
> Based on amdgpu/drm-next.
> 
> [0] https://lore.kernel.org/lkml/20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net/
> 
> ---
> Changes in v2:
> - Introduce proper drm backlight quirk infrastructure
> - Quirk by EDID and DMI instead of only DMI
> - Limit quirk to only single Framework 13 matte panel
> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
> 
> ---
> Thomas Weißschuh (3):
>       drm: Add panel backlight quirks
>       drm: panel-backlight-quirks: Add Framework 13 matte panel
>       drm/amd/display: Add support backlight quirks
> 
>  Documentation/gpu/drm-kms-helpers.rst             |  3 +
>  drivers/gpu/drm/Kconfig                           |  4 ++
>  drivers/gpu/drm/Makefile                          |  1 +
>  drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++
>  drivers/gpu/drm/drm_panel_backlight_quirks.c      | 76 +++++++++++++++++++++++
>  include/drm/drm_utils.h                           | 11 ++++
>  7 files changed, 124 insertions(+)
> ---
> base-commit: 1ecef5589320fd56af599b624d59c355d162ac7b
> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> 
> Best regards,


