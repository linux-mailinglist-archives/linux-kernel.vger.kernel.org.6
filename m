Return-Path: <linux-kernel+bounces-570968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D03A6B6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D33B4142
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229081EFF9C;
	Fri, 21 Mar 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DW4EN0Ue"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C41E32A3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548789; cv=none; b=rwKJODZYGVEv6DLoNCdsqLwuWwQgrTDCXTN4lAYx7F+8pGBiwh3FpTfOAFaoJ9Ra4uUgPtR7X7k7ahmEcJR2d4x+M8bdt5uOlI1Wr1FpKMQgiWKQiZbI4YuCWahDi7r8fWo15002uJG0RJ+SPht2oiK/LhQ/dLHveDk90885i5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548789; c=relaxed/simple;
	bh=rCvYynaJnTpxFhsLa/9noOzbU319PepdT92htTNuQDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb2tSzkyvWPFbcybsYTPvcPe3DcMyqxuZXN6YKiD+UhFWnRe+t5bRgJ0vketiTS6q1R9M98+l5VCzSRE9dqcwncArqEP2s3txvTIs0U2p9MdLI1Jzr+EpW1v4GTPiNdywRxA50m++Tpx56/urTsKyvAmTsf5+6SyhFiw6+4sqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DW4EN0Ue; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso12442105e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742548784; x=1743153584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWnR5bCtS2OFl6qMZ2T0dze3z5cvO0emTkA11CaAm0I=;
        b=DW4EN0UeZZqQh6gf0i/QdnXAxj8pK4deFpfSN3vSC8ya/EYIvIXUvjth2Tm4AP4BC0
         EWzoAnlH6izXHhiMCl9mdQSYSiLxCu775zLvgYInCPPy/OI8xwJwvIL/Wa+UeRDizu5N
         Ka57cTwcetROme6NBfSIc1kzSnScFxLOU+6g2mPfPA617479tLt0I9eoz90CcXybm+6k
         pRQ5VL0vBadP8Dwdzmr8p6txYNqtP6/idqbl4S8/XFt7F1XWb9ACfTzbX8QOWWnjEJXC
         Zn9OjhJpII0+AExKjPnznPwflNJGII0iE4UsKCOutp/vIbO8wZAKYBJDXf4OKoStHbz0
         DQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742548784; x=1743153584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWnR5bCtS2OFl6qMZ2T0dze3z5cvO0emTkA11CaAm0I=;
        b=sxxNmkN9ntFVtjbkfKK0wwiR9OR/udH7rPOV4wYZKlXQ0a9cIWp26yFITSNAB+pxAM
         cYhCYzUVCN/DIcNDwWN/fPbl2ysYWWMMF0BR0xVANVdQj5XFV1hzakP6BkrrP5zUHtg8
         SYfU0F0rKkao/JqVucGvfmesHgx3gTWOHMq9z379ZB9jwH0ZMwvQZXlgY7kzDHIhKlBY
         4N9M6s9GR9io2gBEEI7ZZVNHam/Q4/wLO+tEkgJbvu5mCK0KP83wfcwAXrNlCLevt7GD
         VBnpUjuCJTxGa8yR+seouHq8VUXzpsHvzuxHbOpenKmmC2gYmqT4+F2xp71yHclO852W
         DNrw==
X-Forwarded-Encrypted: i=1; AJvYcCUakUi0hvfcyMKqGuZsmye4dY1PA4rY7B0hyjM54MaSZPqlG9OuXL7ms0WcjNOh24wABycSybOHAYmDcB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdbkKSPa1OGjjVUl3QUtnzIl4k00Pf9pfnIOZhZfZjX5s7tPb
	q5MxzXaZGFYyjtWG4S18oqb1prUPoF5OXGnDXSWdqzNxCesR5W7sK2rKkInWrUI=
X-Gm-Gg: ASbGnctbIF05F0BX6IUD+wS5sED7Ta78XKaCQZOdUTWFm2izeNAM0OmQMtVBv3Up9CJ
	butVSMzo7iwQOcowyUmDb23R6s9b8eD3jvW2LtozCzUVY3+8Mp9CyN8yFk+uzWwkywmxIsPerjH
	mijmCmZ4XNb4Vx8E+I9qS3pkDQAXe2NSbF4GSCoxpWvbz/3BQb3gm+DHNBoTwbtSHdyiRNmlpLI
	SMPTVqBv+W1Dwy6rtPCzGFky4eD3TNjF1H2tEOv+hZCoogddp3DLLWWrZtTN02JnbVw785ZVod7
	dtqlHDRz7Xp4cG0a8oBW2NCrQjH1F+Bml/4RjsGe5rgjAdmwhp/2gUx4JErg6sk0qUo9Z3/s25q
	LRffI3Oysb9OUpI/w
X-Google-Smtp-Source: AGHT+IGb4qaiD8zveCmbngoPFmfN9WpLcjDxkx7ItZuEiKJ1uCoRacXpzZp0WPeOAWRPRphRbr45pg==
X-Received: by 2002:a05:600c:1e18:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d509f64b8mr23766545e9.18.1742548783913;
        Fri, 21 Mar 2025 02:19:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:5ee:79d0:2756:9ecd:3e82:43c7? ([2a01:e0a:5ee:79d0:2756:9ecd:3e82:43c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceae03sm21916245e9.8.2025.03.21.02.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 02:19:43 -0700 (PDT)
Message-ID: <fb72f1f5-dc94-4e33-a20c-d46a081091bc@baylibre.com>
Date: Fri, 21 Mar 2025 10:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] drm/panel: startek-kd070fhfid015: add another init
 step
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org
References: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
 <20231023-display-support-v8-2-c2dd7b0fb2bd@baylibre.com>
 <d70b62f8-e24e-4a10-8c6b-18d2e19f1337@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <d70b62f8-e24e-4a10-8c6b-18d2e19f1337@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Angelo,
Thanks for the fast feedback :)

On 20/03/2025 13:37, AngeloGioacchino Del Regno wrote:
> Il 20/03/25 09:48, Alexandre Mergnat ha scritto:
>> Currently, the panel set power, set gpio and enable the display link
>> in stk_panel_prepare, pointed by drm_panel_funcs.prepare, called by
>> panel_bridge_atomic_pre_enable, pointed by
>> drm_bridge_funcs.atomic_pre_enable. According to the drm_bridge.h,
>> atomic_pre_enable must not enable the display link
>>
>> Since the DSI driver is properly inited by the DRM, the panel try to
>> communicate with the panel before DSI is powered on.
>>
> 
> The panel driver shall still be able to send commands in the .prepare() callback
> and if this is not happening anymore... well, there's a problem!

Sorry I don't think so, according to that def:
	/**
	 * @pre_enable:
	 *
	 * This callback should enable the bridge. It is called right before
	 * the preceding element in the display pipe is enabled. If the
	 * preceding element is a bridge this means it's called before that
	 * bridge's @pre_enable function. If the preceding element is a
	 * &drm_encoder it's called right before the encoder's
	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
	 * &drm_encoder_helper_funcs.dpms hook.
	 *
	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
	 * will not yet be running when this callback is called. The bridge must
	 * not enable the display link feeding the next bridge in the chain (if
	 * there is one) when this callback is called.
	 *
	 * The @pre_enable callback is optional.
	 *
	 * NOTE:
	 *
	 * This is deprecated, do not use!
	 * New drivers shall use &drm_bridge_funcs.atomic_pre_enable.
	 */
	void (*pre_enable)(struct drm_bridge *bridge);

	/**
	 * @enable:
	 *
	 * This callback should enable the bridge. It is called right after
	 * the preceding element in the display pipe is enabled. If the
	 * preceding element is a bridge this means it's called after that
	 * bridge's @enable function. If the preceding element is a
	 * &drm_encoder it's called right after the encoder's
	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
	 * &drm_encoder_helper_funcs.dpms hook.
	 *
	 * The bridge can assume that the display pipe (i.e. clocks and timing
	 * signals) feeding it is running when this callback is called. This
	 * callback must enable the display link feeding the next bridge in the
	 * chain if there is one.
	 *
	 * The @enable callback is optional.
	 *
	 * NOTE:
	 *
	 * This is deprecated, do not use!
	 * New drivers shall use &drm_bridge_funcs.atomic_enable.
	 */
	void (*enable)(struct drm_bridge *bridge);

=> "The bridge must not enable the display link feeding the next bridge in the
=> chain (if there is one) when this callback is called."

Additionally, you ask for something impossible because here is the init order
fixed by the framework:

[   10.753139] panel_bridge_atomic_pre_enable
[   10.963505] mtk_dsi_bridge_atomic_pre_enable
[   10.963518] mtk_dsi_bridge_atomic_enable
[   10.963527] panel_bridge_atomic_enable
[   10.963532] drm_panel_enable

If panel want to use the DSI link in panel_bridge_atomic_pre_enable, nothing
will happen and  you will get a timeout.

So, IMHO, this patch make sense.

> 
>> To solve that, use stk_panel_enable to enable the display link because
>> it's called after the mtk_dsi_bridge_atomic_pre_enable which is power
>> on the DSI.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   .../gpu/drm/panel/panel-startek-kd070fhfid015.c    | 25 +++++++++++++---------
>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c 
>> b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
>> index c0c95355b7435..bc3c4038bf4f5 100644
>> --- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
>> +++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
>> @@ -135,19 +135,9 @@ static int stk_panel_prepare(struct drm_panel *panel)
>>       gpiod_set_value(stk->enable_gpio, 1);
>>       mdelay(20);
>>       gpiod_set_value(stk->reset_gpio, 1);
>> -    mdelay(10);
>> -    ret = stk_panel_init(stk);
>> -    if (ret < 0)
>> -        goto poweroff;
> 
> Also, you're moving both init and set_display_on to the enable callback...
> this is suboptimal.
> 
> You should do the DrIC setup in .prepare() (can include SLEEP OUT), and then you
> should have a .enable() callback that calls DISP ON, a .disable() callback that
> calls DISP OFF, and .unprepare() that turns everything off.

This is not what I understand from the pre_enable's definition above, and also
the function call order by the framework. :)

> 
> Cheers,
> Angelo
> 
>> -
>> -    ret = stk_panel_on(stk);
>> -    if (ret < 0)
>> -        goto poweroff;
>>       return 0;
>> -poweroff:
>> -    regulator_disable(stk->supplies[POWER].consumer);
>>   iovccoff:
>>       regulator_disable(stk->supplies[IOVCC].consumer);
>>       gpiod_set_value(stk->reset_gpio, 0);
>> @@ -156,6 +146,20 @@ static int stk_panel_prepare(struct drm_panel *panel)
>>       return ret;
>>   }
>> +static int stk_panel_enable(struct drm_panel *panel)
>> +{
>> +    struct stk_panel *stk = to_stk_panel(panel);
>> +    int ret;
>> +
>> +    ret = stk_panel_init(stk);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    ret = stk_panel_on(stk);
>> +
>> +    return ret;
>> +}
>> +
>>   static const struct drm_display_mode default_mode = {
>>           .clock = 163204,
>>           .hdisplay = 1200,
>> @@ -239,6 +243,7 @@ drm_panel_create_dsi_backlight(struct mipi_dsi_device *dsi)
>>   }
>>   static const struct drm_panel_funcs stk_panel_funcs = {
>> +    .enable = stk_panel_enable,
>>       .unprepare = stk_panel_unprepare,
>>       .prepare = stk_panel_prepare,
>>       .get_modes = stk_panel_get_modes,
>>
> 
> 
> 

-- 
Regards,
Alexandre

