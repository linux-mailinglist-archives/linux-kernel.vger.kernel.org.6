Return-Path: <linux-kernel+bounces-256149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FF9349D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42F61F2431E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFFA7D3E0;
	Thu, 18 Jul 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEOKnMMe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874D7D09D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291127; cv=none; b=Jpgm+ZrL+CHTP+1EUu7gx/HKnJzk/ZrB4UTGjf8rDbLudjTYYA6x9j/SrpAtI2ZuZNox03W4pNE3O3WRn1a/AUwG8a9MGaH+FgeOfhhcpN3LybkHt8CfQJozoaB7WStoohO3reJnFXO/Hb3sqahDYNughtvRDRTta/OlBRRIJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291127; c=relaxed/simple;
	bh=XG81iaE2nnS4GMjk0aSlJtBGjcoMfkevb82ayWnRYz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0m+1Y1M+hocz7qAoA7mBL1SV0hzqM1GTMcwif/WyCa7ou3AZ+ILX9UlLmVNPXj4jQla/oWK5F0/Q6lkkYKL2YaCgK7/ElQ+RMixIwajfkrJpK4KDS/+Z9g6EPssvFTV1ebg78JwVI8jW1/82bDO+Y4eCMQZkNkqzPSn+caCY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEOKnMMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721291125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1svtcDGv9GPXqhPvf/wZn92njhXKe/iKQ0fD18vtZo=;
	b=TEOKnMMeGu1F01td+ybKq0gVC15NCNeSXuGb/p4LFWBhobQ4reDITqUVUIzVbKqhO71lvC
	Rhm0VpZ2m5oFqKstybDgiEGg6SbbBxG/qHvvksaIAd8RVEFysEe5B2kyd5rnwFJL6u/bvM
	9Km/suoLVanJd3hZW85LgmYmRiw44ks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-4jM--kbbO-mV5T5SpAA44Q-1; Thu, 18 Jul 2024 04:25:23 -0400
X-MC-Unique: 4jM--kbbO-mV5T5SpAA44Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42674318a4eso475575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721291121; x=1721895921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1svtcDGv9GPXqhPvf/wZn92njhXKe/iKQ0fD18vtZo=;
        b=PUOlg/6x1++IM51JAD3B6dTaVz+udd2DwAyHuGgbXzm5DEKnqOqoIMsXj17sQfKdug
         Y0j1aGZv8gm4nNyH1KA7mGCr+bdMjs+GhqDirrbdj529ZhiAqcUWIA+Y58RiHTRck4/K
         ksTuQnuGGc3+BWU6W5tTaWMJwjVYWHGJSCte1dQmp8V0Hde+uxOnuGiXj84f79z8m3Kb
         FfbpptVEzFuB8KEJy2p4z1EIkmm3kdxp/5gcCL0HHWeOJykqdyeI1Pua2H9YZ7nl5Lub
         seOWEaBcI8S3BY+cABr9NXE61M1OuW6yfFP1S7vg3PNwqvXbb/nx/5Xg4E231oczRS41
         ocng==
X-Forwarded-Encrypted: i=1; AJvYcCVzhYFXFcAmvALv19Gyu65uWpBIXlA2Dy/6zMQ93Yr+3D46i2zW4oXGEbaZ+t+Soul8RUsA3+aZy6yuGS0hd571dKAKo1gicnyUUsX5
X-Gm-Message-State: AOJu0YykkxxuMGBKFZPbGXvdaw+w4q+zthRP8dQ0BlF9w05DnS7hLE6m
	CZ4N4eWfYK7ISbauW8zVL/jhHbrNoHfGH/KWO9fKKOhgRxiHU504riMgDDyfABW73/6ukgyO1A9
	lpN/rOtsHEa3UoWZSGb/Cuipiuzd2wKWFvD3fH4vQJVuCVUxKgCiRTOUQ4MUfxQ==
X-Received: by 2002:a05:600c:4455:b0:426:5d4d:d759 with SMTP id 5b1f17b1804b1-427c2d01fa0mr35302095e9.24.1721291121595;
        Thu, 18 Jul 2024 01:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQmOs05h3TMeUCsJAeQ6XUVxagcN1TKeIjWXjqi79nkjJ+F5PJFWZ0k0Ne+JuEETUnDjJMg==
X-Received: by 2002:a05:600c:4455:b0:426:5d4d:d759 with SMTP id 5b1f17b1804b1-427c2d01fa0mr35301835e9.24.1721291121154;
        Thu, 18 Jul 2024 01:25:21 -0700 (PDT)
Received: from [172.18.228.53] (ip-185-104-138-47.ptr.icomera.net. [185.104.138.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43034sm2201335e9.3.2024.07.18.01.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:25:20 -0700 (PDT)
Message-ID: <6db5abf9-cbdd-4ec0-b669-5df23de6c2ad@redhat.com>
Date: Thu, 18 Jul 2024 10:25:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <e61010e4-cb49-44d6-8f0d-044a193d29b2@redhat.com>
 <51f68b3b-dd21-44ef-8ec8-05bea5db6e55@t-8ch.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <51f68b3b-dd21-44ef-8ec8-05bea5db6e55@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 6/24/24 6:15 PM, Thomas Weißschuh wrote:
> Hi Hans!
> 
> thanks for your feedback!
> 
> On 2024-06-24 11:11:40+0000, Hans de Goede wrote:
>> On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
>>> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
>>> is "12". This leads to a fairly bright minimum display backlight.
>>>
>>> Add a generic quirk infrastructure for backlight configuration to
>>> override the settings provided by the firmware.
>>> Also add amdgpu as a user of that infrastructure and a quirk for the
>>> Framework 13 matte panel.
>>> Most likely this will also work for the glossy panel, but I can't test
>>> that.
>>>
>>> One solution would be a fixed firmware version, but given that the
>>> problem exists since the release of the hardware, it has been known for
>>> a month that the hardware can go lower and there was no acknowledgment
>>> from Framework in any way, I'd like to explore this alternative
>>> way forward.
>>
>> There are many panels where the brightness can go lower then the advertised
>> minimum brightness by the firmware (e.g. VBT for i915). For most users
>> the minimum brightness is fine, especially since going lower often may lead
>> to an unreadable screen when indoors (not in the full sun) during daylight
>> hours. And some users get confused by the unreadable screen and find it
>> hard to recover things from this state.
> 
> There are a fair amount of complaints on the Framework forums about this.
> And that specific panel is actually readable even at 0% PWM.

If a lot of Framework users are complaining about this, then maybe Framework
should fix their VBT in a BIOS update ?  That seems like a better solution
then quirking this in the kernel.

> 
>> So IMHO we should not be overriding the minimum brightness from the firmware
>> using quirks because:
>>
>> a) This is going to be an endless game of whack-a-mole
> 
> Indeed, but IMO it is better to maintain the list in the kernel than
> forcing all users to resort to random forum advise and fiddle with
> lowlevel system configuration.

One of the problem is that what is an acceptable minimum brightness
value is subjective. One person's "still too bright" is another
person's "barely readable"

>> b) The new value may be too low for certain users / use-cases
> 
> The various userspace wrappers already are applying a safety
> threshold to not go to "0".
> At least gnome-settings-daemon and brightnessctl do not go below 1% of
> brightness_max. They already have to deal with panels that can go
> completely dark.

Right, something which was added because the minimum brightness value
on VBTs often is broken. Either it is missing or (subjectively) it is
too high.


>> With that said I realize that there are also many users who want to have
>> a lower minimum brightness value for use in the evening, since they find
>> the available minimum value still too bright. I know some people want this
>> for e.g. various ThinkPad models too.
> 
> From my experience with ThinkPads, the default brightness range there
> was fine for me. But on the Framework 13 AMD it is not.
> 
>> So rather then quirking this, with the above mentioned disadvantages I believe
>> that it would be better to extend the existing video=eDP-1:.... kernel
>> commandline parsing to allow overriding the minimum brightness in a driver
>> agnostic way.
> 
> I'm not a fan. It seems much too complicated for most users.

Wanting lower minimum brightness really is mostly a power-user thing
and what is the right value is somewhat subjective and this is an often
heard complained. I really believe that the kernel should NOT get in
the business of adding quirks for this. OTOH given that this is an often
heard complaint having some generic mechanism to override the VBT value
would be good to have.

As for this being too complicated, I fully agree that ideally things
should just work 100% OOTB, which is why I believe that a firmware fix
from Framework would be good. But when things do not work 100% adding
a kernel cmdline option is something which is regularly asked from users /
found in support questions on fora so I don't think this is overly
complicated. I agree it is not ideal but IMHO it is workable.

E.g. on Fedora it would simply be a question of users having to run:

sudo grubby --update-kernel=ALL --args="video=eDP-1:min-brightness=1"

will add the passed in argument to all currently installed (and
future) kernels.

> Some more background to the Framework 13 AMD case:
> The same panel on the Intel variant already goes darker.
> The last responses we got from Framework didn't indicate that the high
> minimum brightness was intentional [0], [1].
> Coincidentally the "12" returned from ATIF matches
> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, so maybe the firmware is just not set
> up completely.

Right, so I think this should be investigated closer and then get
framework to issue a BIOS fix, not add a quirk mechanism to the kernel.

IIRC the amdgpu driver will use AMDGPU_DM_DEFAULT_MIN_BACKLIGHT when
that setting is 0 in the VBT.

> 
>> The minimum brightness override set this way will still need hooking up
>> in each driver separately but by using the video=eDP-1:... mechanism
>> we can document how to do this in driver independent manner. since
>> I know there have been multiple requests for something like this in
>> the past I believe that having a single uniform way for users to do this
>> will be good.
>>
>> Alternatively we could have each driver have a driver specific module-
>> parameter for this. Either way I think we need some way for users to
>> override this as a config/setting tweak rather then use quirks for this.
> 
> This also seems much too complicated for normal users.

I agree that having a uniform way is better then having per driver
module options.

Regards,

Hans


