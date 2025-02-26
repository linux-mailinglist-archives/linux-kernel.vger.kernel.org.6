Return-Path: <linux-kernel+bounces-533935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102BA46080
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E547A4F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E62144AF;
	Wed, 26 Feb 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hNPM6j/V"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32222EE5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575783; cv=none; b=l4QCFxNhjg2mt048ztKwAuEe3i2fJOubusW9iMg0lTCYnqDksXJaOgws/nGLJHmcLtHf3Y4/FhLUcktgQoivlvQs0+oz4pvFuV65DSy+uTwQpgH0Mep5XxPJ5g7Rk7XZQ3dV4P2v0zQzyv+PbpCGYMC8DDbZnCecWkeHkeDXVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575783; c=relaxed/simple;
	bh=cqOiFSy7RDTczBvThKPhGq1U0NAuvb/KxdY9EfQvHl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZFjbAfpT8b+wkEf+ZhMgcxByZnhdWWF2TTNE0y2/keRUdXkU2rjs0tDljg47pbLiWLasA84RiBGJ/sMrozuVta8tU7nqYkSsH5Go6BMN6vCNiugtrbt3BGgdJb4DEsgVhDGsKg6BrTs3UNU2BOe7FLyoT5qyvewcY5X34MaV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hNPM6j/V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4399deda38cso42187045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740575780; x=1741180580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QySj/3gXBapZsSsI8S6n09GzTe+ASut5dxFZ8ln3oQ=;
        b=hNPM6j/V18+kZ6Pj17ldxjEpLZD7anv80upgZE4htIwCVyyiLGw9MpyxNVbWKGhGSk
         s+9BvOJtJkvYVQ0eelnL7o/90EgugD2OxYqjt3QFOZ9HVK3/tJfTHGkL4IIMhz/UOJqK
         es215DNQJ5wxmJshTDyfb+pafef4jWQs78W/ABV1CSdpejwAyHkvj2H6KMj6KuyMysIt
         vS/+S0X/cvAehnbdNwwclkeaMsUwxRJCE7XTt1/q+BoAZB/0Tv7E59d3mxcCoxvUhk0F
         2nIZwZ/rju/gCWPiUa/rEzWzNtNyTuXPJVcGi/cDJq4Sv0Mmnp4FG+qT7uuVzsTNF9Wq
         byLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575780; x=1741180580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QySj/3gXBapZsSsI8S6n09GzTe+ASut5dxFZ8ln3oQ=;
        b=XUi4pn3oByKnLcRVdedeO34aE1gSLIN/RHoWvj25KlKyQsghKfUkHuZE9If5SPGN2/
         RC7e67HpNJ7GuawgoCUeB8dERbB6s1jMOnViFXHfHb+h66ytjjW8VoaMkKVz6USqJ6hs
         gpn9YRV+LVJNHhuzv9//ZEXf0FaWFT1+oTqoHIKkvNw3dZZ6759/BQZFMWH+vDzu2a2U
         WBEI+LgrjY3ozHtLRXjREPGcptJDFL9Vz2K07GQz7dNlltVT4Be5es+5L0VZ1yFNWt0Q
         m/YtawejhLYXTTB/ymRZ2EzUaJ83fi1q5qjNVYScfPTkdzJ2PHZYimdu/fPaILf00VY1
         jbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVepapkfPoi764CnL4ZyuZFov+wCphujU0HD+SF8/+57k20B3Wa6YHjWDU4J8fFhBS44s9aUM/B7nkNO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNAkTCNE+Q44msdOxzJ0rsa26lfJPFlTvkSpcvtI6ieeZiDEU
	zXj+sRjEEZcMnIMzxDNaXySNHVWqu2/vqAwAz2V0/T3t7tkxcx10YUg45SC2Ce0=
X-Gm-Gg: ASbGncuwgWdOqJjkhzUo5VvjBfnGly9MXDY2XudhxGuq76sIsUj15fHwBzJAs0fw09d
	E1Y4ZWQeL9S5ZObznRQdK5GRG2EW+Pn50Lkm5RQI/2hlPzWxtziCk0bSPrJWwP2dj5lmxvhA6Eq
	hbpMbHtWIf6odNQ+T8NTKJ0sisveHlS4dP8zPNEQGWqD78OogKAgPM1bNakhg9tnBCs1akslcDB
	XiMy0UBj7p3hG26RYEXBf5heZGkxX/iqOZ33rH8/QsN7cKQYysGeH5EaBWQ0SG3l8uR7YDvSCJd
	Afom0j/8lObyCRW/p89NWNSTNlOWX+vs8IXC0trqTEwIVGQeTR3FcVHPgdNE5QsWVw==
X-Google-Smtp-Source: AGHT+IHBYfxG0X3yyvWm6nQA9LWy/PfeZqfB8z2wGt61RhxaaQMqUBMKTYu794JfjOFUOpOPcwvA6Q==
X-Received: by 2002:a05:600c:5123:b0:439:88bb:d035 with SMTP id 5b1f17b1804b1-43ab0f2887dmr70381405e9.5.1740575778320;
        Wed, 26 Feb 2025 05:16:18 -0800 (PST)
Received: from [192.168.0.172] (88-127-185-231.subs.proxad.net. [88.127.185.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cc96sm5706491f8f.31.2025.02.26.05.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:16:17 -0800 (PST)
Message-ID: <8c69314f-b7b9-4ad9-bcf1-6a57645f1335@baylibre.com>
Date: Wed, 26 Feb 2025 14:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] drm/mediatek: dsi: Improves the DSI lane setup
 robustness
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona.vetter@ffwll.ch" <simona.vetter@ffwll.ch>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "will@kernel.org" <will@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>
References: <20231023-display-support-v7-0-6703f3e26831@baylibre.com>
 <20231023-display-support-v7-2-6703f3e26831@baylibre.com>
 <ab3bd050c873bb6cecc00b615b938eabc157cb49.camel@mediatek.com>
 <79477810-00a9-47f1-8282-f8077ea082bb@baylibre.com>
 <3310b6f9-df7a-4769-a221-4a93cc3ec035@collabora.com>
 <0863ee2e-25ed-43b7-a896-e380de828d58@baylibre.com>
 <c2154240-efa1-4c73-aabe-74e938a75af1@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <c2154240-efa1-4c73-aabe-74e938a75af1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/02/2025 12:45, AngeloGioacchino Del Regno wrote:
> Il 26/02/25 12:35, Alexandre Mergnat ha scritto:
>>
>>
>> On 18/02/2025 09:52, AngeloGioacchino Del Regno wrote:
>>> Il 17/02/25 16:03, Alexandre Mergnat ha scritto:
>>>> Hi CK.
>>>>
>>>> On 17/02/2025 08:56, CK Hu (胡俊光) wrote:
>>>>> On Fri, 2025-01-10 at 14:31 +0100, Alexandre Mergnat wrote:
>>>>>> External email : Please do not click links or open attachments until you have verified the 
>>>>>> sender or the content.
>>>>>>
>>>>>>
>>>>>> Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
>>>>>> before mtk_dsi_poweron. lanes_ready flag toggle to true during
>>>>>> mtk_dsi_lane_ready function, and the DSI module is set up during
>>>>>> mtk_dsi_poweron.
>>>>>>
>>>>>> Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
>>>>>> nothing because lanes are considered ready. Unfortunately, when the panel
>>>>>> driver try to communicate, the DSI returns a timeout.
>>>>>>
>>>>>> The solution found here is to put lanes_ready flag to false after the DSI
>>>>>> module setup into mtk_dsi_poweron to init the DSI lanes after the power /
>>>>>> setup of the DSI module.
>>>>>
>>>>> I'm not clear about what happen.
>>>>> I think this DSI flow has worked for a long time.
>>>>> So only some panel has problem?
>>>>
>>>> I don't know if it's related to a specific panel or not.
>>>>
>>>>>
>>>>> And another question.
>>>>> Do you mean mtk_dsi_lane_ready() do some setting to hardware, but lane is not actually ready?
>>>>
>>>> The workflow should be:
>>>> ... | dsi->lanes_ready = false | Power-on | setup dsi lanes | dsi->lanes_ready = true (to avoid 
>>>> re-do dsi lanes setup) | ...
>>>>
>>>> I observe (print function name called + dsi->lanes_ready value):
>>>
>>> Alex, the first poweron is called by mtk_dsi_ddp_start() - and the start callback
>>> is internal to the mediatek-drm driver.
>>>
>>> That callback is called by mtk_crtc during setup and during bridge enable(), and
>>> there we go with suboptimal code design backfiring - instead of using what the
>>> DRM APIs provide, this driver uses something custom *and* the DRM APIs, giving
>>> this issue.
>>>
>>> Part of what mtk_crtc does is duplicated with what the DRM APIs want to do, so
>>> there you go, that's your problem here :-)
>>>
>>> Should I go on with describing the next step(s), or is that obvious for everyone?
>>>
>>> :-)
>>>
>>> Cheers,
>>
>> Ok thanks Angelo.
>> Can you let me know if you agree with this change please ? This should be better:
>>
> 
> No, no, I'm saying that we should do the exact opposite of what you're doing here!
> 
> We should drop the MediaTek custom stuff that duplicates the DRM APIs behavior(s),
> and conform to what the DRM APIs provide and want us to do.
> 
> To be really really clear - I'm saying to delete and avoid using:
> - mtk_dsi_ddp_start()
> - mtk_dsi_ddp_stop()

Ok, that what I though first but when I've tried to remove it, the board hung at boot as described 
in this old patch:

https://patchwork.kernel.org/project/linux-mediatek/patch/1653012007-11854-3-git-send-email-xinlei.lee@mediatek.com/

Even if I do some little change that (like remove mtk_dsi_start) allow me to boot and make DRM 
working for HDMI, DSI still not working at all, I need to do more effort to rework the DSI init.

In my previous suggestion I forgot to say "Since the goal of this serie is to add display support 
for genio 350 but not rework/fix DSI driver, is it reasonable to do a soft fix first and then work 
on another serie about legacy stuff issue?"

> 
> The spirit here should be to use kernel provided APIs, and to make custom stuff
> to disappear as much as possible (again, that mtk_crtc .start/.stop).

> 
> I'm not saying that literally all of the start/stop callbacks for all of the
> MTK DRM drivers should disappear *all at once* but... gradually, one by one,
> these should get lost (where/if possible).
> 
> Just one more mention: that custom handling also backfired on me while writing
> the hdmiv2/dpi drivers... and now backfires on dsi, and in the future it will
> backfire again on something else. It's there only to give problems in the end,
> not to solve them :-)

Is that issue fixed for DPI ? I'm asking because the following struct still used in mtk_ddp_comp.c:

static const struct mtk_ddp_comp_funcs ddp_dpi = {
	.start = mtk_dpi_start,
	.stop = mtk_dpi_stop,
	.encoder_index = mtk_dpi_encoder_index,
};

But maybe what you fixed for hdmiv2/dpi isn't related to this.
Can you link me the patch where you fix that please ? I think that can help me.

I'm 100% agree with you to remove MediaTek custom stuff that duplicates the DRM APIs behavior. The 
genio 350 display support patches has already be stopped and reworked for of graph support, now 
stopped by custom framework issue. What do you think about to validate the "DSI hotfix" to merge the 
whole series and open a dedicated series to cleanup custom start/stop from MTK DRM framework ? I'm 
really asking for your deliberation, not trying to force it when I say I prefer merge this in the 
current state :)

-- 
Regards,
Alexandre

