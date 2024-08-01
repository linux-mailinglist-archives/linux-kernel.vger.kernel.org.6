Return-Path: <linux-kernel+bounces-270921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62A944717
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5AAB23B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D713B2BB;
	Thu,  1 Aug 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfTU6a4/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB716EB6E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502384; cv=none; b=JOrsFUqh9WXB/mY//x90UssK+Le6vnn0f9A0Se/os+u+jm4SbsxooLn2nNZQPYHLlBsbf7wcTklEVovzOozdKoM+RkbYx6Be01aHBHltpX0RGPs/0Nhl2R1ekKU4LK2+XtDKO+otgrNfq/wioGZPTAeunL5L80WPUvMuu+MTLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502384; c=relaxed/simple;
	bh=xESeUQjrSk5WmVstYgIKayBEavp05OMyjZjqjAGy2ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mCqGRof6Ls+mIOs8jvrhhLYMD5NhjX3GVCO979DoUn/PRsG+aMBoVkVOvLd8+/9rBKRYint9Qetu/TBxfo3K9B6YCzzrIKcaVCZZ/SHCdvS+iIWJfw6TehuB03b+YaTxzlplAAxetSasvrGteENwdv7SUpfBYIsQkBjb/bqOAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfTU6a4/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722502381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23VtBrMdg+e86oIyAKkk0gIRsQUKPk9UYAypqYqSedk=;
	b=SfTU6a4/mYw536jcPIRvIKX+0kp9Ot5WxK+9ymir53pNGMuhx/O5+meCw9DeGvvEftEByP
	V0CA+KjTjD6E6YSneP/styoRS5cl+fdjYJc35Kz7X7G7m0IuU0kSUQKt9SR4+wrzlf0XD+
	rvX2/2W07/fbIH4RwucJLVJ2vTXX0Nw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ZgDZDgS5PS6OcE9Txk-edQ-1; Thu, 01 Aug 2024 04:52:59 -0400
X-MC-Unique: ZgDZDgS5PS6OcE9Txk-edQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52efe4c2261so8978197e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502378; x=1723107178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23VtBrMdg+e86oIyAKkk0gIRsQUKPk9UYAypqYqSedk=;
        b=D4jHsO9v8GnBriefB5/a6a5WTy60mYkyD0XUqye9IYGkv2bwGIVn6N8Qmcym3jBM/A
         AP0QODtP3hx/dsWg3IQJVH221hdjv4UXwXC3TJ+GQmmd8E2Rbe2pdC/dV5UJ1ozklodT
         WRrx9RILyLR9mE5R2IgJeOupluVMGKO6wcjJiM0x+ltzfSyYT0lgAWmU7cSrmcTzYV/p
         w2fDkiSHJrrfNIR9kVdkFJoCaJHxeiWE4gW8lnt9IhOaKwgntNCnWLuck+C9OBWRneHt
         fid7M/O6ZhObX7yEFrw1VySqKe7RBJdu62vDZj3hd2mxR841cwt5ckYkO+pff8cJ91zt
         h5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVwbqB0noiEKfPE8812DXUFv7p35xFcG7fUznzSkOFN0eao55wetAZpey4ACMDcoC+fjEd/P3o007vMWd8i9eePIaVT20r47R45Y1N9
X-Gm-Message-State: AOJu0Yw733RX8bPe3AKie49OXL0qgBJEKtHJYXYktKchiU99x5vwMZw9
	ZlewIXcKW06WDAOTZtMyUk2qcLvjYH1W1PeEPcsRKcDuLsWQMdR6S9Z8sAkcES6DW95ulxWOgFA
	uBuXwSRwjdQ/7ydwaIFUncrJX6o0FFDI6kG/1r+W96WMKHQoEd05AgBOGNuZ7TQ==
X-Received: by 2002:ac2:418b:0:b0:52f:cd03:a84a with SMTP id 2adb3069b0e04-530b61fe66cmr1079620e87.39.1722502377727;
        Thu, 01 Aug 2024 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+DWDFB+/d/kjlinqEN/i6kFpt+27w9S7EzOyAXbtiCJaTdardj0Qe5rVEEOq7V/Tw17rWNA==
X-Received: by 2002:ac2:418b:0:b0:52f:cd03:a84a with SMTP id 2adb3069b0e04-530b61fe66cmr1079590e87.39.1722502377087;
        Thu, 01 Aug 2024 01:52:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb8278sm861717666b.202.2024.08.01.01.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:52:56 -0700 (PDT)
Message-ID: <1b4bfb81-339d-4582-873c-c720c82c8ba7@redhat.com>
Date: Thu, 1 Aug 2024 10:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] drm: minimum backlight overrides and
 implementation for amdgpu
To: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>,
 Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dustin Howett <dustin@howett.net>
References: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
 <87v80lwjcz.fsf@intel.com> <Zqqku_zS7CpPGbzW@phenom.ffwll.local>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zqqku_zS7CpPGbzW@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/31/24 10:55 PM, Daniel Vetter wrote:
> On Wed, Jul 31, 2024 at 08:40:12PM +0300, Jani Nikula wrote:
>> On Wed, 31 Jul 2024, Thomas Weißschuh <linux@weissschuh.net> wrote:
>>> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
>>> is "12". This leads to a fairly bright minimum display backlight.
>>>
>>> Add a generic override helper for the user to override the settings
>>> provided by the firmware through the kernel cmdline.
>>> Also add amdgpu as a user of that helper.
>>>
>>> One solution would be a fixed firmware version, which was announced but
>>> has no timeline.
>>
>> The flip side is that if we add this now, it pretty much has a timeline:
>> We'll have to carry and support it forever.
>>
>> It's not a great prospect for something so specific. Not to mention that
>> the limits are generally there for electrical minimums that should not
>> be overridden. And before you know it, we'll have bug reports about
>> flickering screens...
> 
> Yeah I think for this specific case where a fixed firmware is already
> kinda promised, a quirk is the right fix. Otherwise we open up a can of
> worms here ... so personally I like v2 a lot more.
> -Sima

Ok, with both Jani and Sima preferring the quirk approach from v2,
I withdraw my objection against v2. So lets go with that version.

Thomas, sorry about this.

I see that other then a remark from Jeff Johnson about a missing
MODULE_DESCRIPTION() v2 does not have any reviews yet though.

So we will need to review that version now. Might be best for
visibility of the patches in people's review queue to repost
v2 as v4 with the MODULE_DESCRIPTION() fixed ?

Regards,

Hans



>>> This helper does conflict with the mode override via the cmdline.
>>> Only one can be specified.
>>> IMO the mode override can be extended to also handle "min-brightness"
>>> when that becomes necessary.
>>>
>>> ---
>>> Changes in v3:
>>> - Switch to cmdline override parameter
>>> - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net
>>>
>>> Changes in v2:
>>> - Introduce proper drm backlight quirk infrastructure
>>> - Quirk by EDID and DMI instead of only DMI
>>> - Limit quirk to only single Framework 13 matte panel
>>> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
>>>
>>> ---
>>> Thomas Weißschuh (2):
>>>       drm/connector: add drm_connector_get_cmdline_min_brightness_override()
>>>       drm/amd/display: implement minimum brightness override
>>>
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++++
>>>  drivers/gpu/drm/drm_connector.c                   | 34 +++++++++++++++++++++++
>>>  include/drm/drm_connector.h                       |  2 ++
>>>  3 files changed, 42 insertions(+)
>>> ---
>>> base-commit: 36821612eb3091a21f7f4a907b497064725080c3
>>> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
>>>
>>> Best regards,
>>
>> -- 
>> Jani Nikula, Intel
> 


