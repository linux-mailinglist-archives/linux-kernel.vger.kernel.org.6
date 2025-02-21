Return-Path: <linux-kernel+bounces-525762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3839A3F496
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D9B17FB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B320B210;
	Fri, 21 Feb 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R02V9JVp"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BBD2063C1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141418; cv=none; b=dRTsxERGfduecTmUZ/jJcQF/9yhADe9XwMly8N8m1VYPwz59Eu8KuJjtX5o+1seTQZSGRXku7i+0TAeN3ykBME9Ls0F2UkG6G2oVyaNzSta/DWFGO1A3d4wFIz6Yzt1hZwOs0Gcex0RIJb+jUvTTJNbL0sjEO1AiMMUeA1Ywz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141418; c=relaxed/simple;
	bh=reN/jN4U2nZz0IZjiNbvfQ2pGtnCDBhdnWOo/v/ZumI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/LTVf31W7FHuxMk3CzcEFS/VjaJwI/Stz3XM6+yrnb6JjxclLfLk+0jjtU+UKcT7OhWlSPHLOLsX/Yk+hiM50MuSr3ftVTVCuOiev7GOez3vR0eVbuSseJeOI/FPEfQ53b60WzJbL7LaRu0jBQsHZerlsfRx8QY5BTKvDLvT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R02V9JVp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5decbcd16d2so380765a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740141415; x=1740746215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUQlDd7Utz0aQjBN7sk1gzdB0Wc8pMTCUWTaZwMMJIw=;
        b=R02V9JVppWmPenPPXMPOwPhXOvMkG20dux2iplsKQCHxLp2oR7T4ZP1ej7aWXYm/5Q
         lwrrCWFtWqf9AG/pXrXA8bt5U8TmZBjknnUUYkFwrd9NFSBkIP4F8+Co2Pw/weCPclO0
         g8fzs1eg3zmmOoh67KFgm4x/0232fSOsJXK/Ta+t1/UycFM2yxEf8ur+Qa82kJNaQdiL
         e79kcotdoVR74iuFS5QFkdSi/0/cZWQFTwYG4Ihojxq70F0ECYBPHOhKpi7zuilnRPFi
         PHtgoJmV1P90w6fs6mkEAZSRgizgV40F6qoluErMjInbMyOJ/9ZplYuDkcctkgxHfyag
         HeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740141415; x=1740746215;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUQlDd7Utz0aQjBN7sk1gzdB0Wc8pMTCUWTaZwMMJIw=;
        b=OhoLRb00mxlCJ3RvgnRONs46Y7Jkt65OWNrnimuv2ZUUYYCTiNk7xLXcaiaaaBydQS
         +PbAaQQ2YyPPL6n9J94nMi5wfb8Dnh9n/NlV6yOGgW9POWE5CfpBTOGl3aiTJT3Bumk4
         2VpehZ+rouqWCYYKm42jquXZfbADjWQkb4TPgDI1y1Gc0bG+WlEVYyLYco5859xQTpIv
         fXq+aw2qov8TiKa1TzkoIL4Z23GDYg8jCMdYvCm7+mGC32oMoXpcIus5nH9IkiAyBPTT
         PLVaGrt+KljVk8EQtI+TmRIE+4n273noDpQJFLBPPbFEHpnM2Vj32XhemN+YtaO+tuoZ
         G6sg==
X-Forwarded-Encrypted: i=1; AJvYcCU1wuQmXfNx9CzsOZM9SJ8Yo7sokyxhrDV6UZeAB0hYqwOW4ZBrjQX3npPiGw3XYEllTYCIlGFU6LJCV6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBvoXGOK2sx3nk6/EHox8iKewEq8+82UASIwiDq2+N+WTKisa
	e78Gm1Xh+7UFsB4BTKdkZIyMFZmcV13dVCbLEs/BLUWDexARjPLeX3yLrwK77ks=
X-Gm-Gg: ASbGncvDB8IsukQD1dwPhrkSXZo+AQkj5Etd/FkSMzxjukhATiwTuLiLBq1JneS+qYL
	u9l0k5DJKD7LTwZPbW4M+XiTulXmMZLAp23UZPYzlawBoL1r6BUnuhIt4areJObA7+Qs7iRyQBM
	4xzDGEtFDDTr9I6GU/AR2CnNhqN4QEqNzGJHWfhoSvojGZ+8K2znhPvat734tGG9Vfu6eAIfGfI
	q3jHKa9NOkRFTbDII50Z9SoIDJ5k/7KCuUJz8idgJUujAhdDlv8K+SYgHl3JXLgHD3YEwMH4CgG
	19CVQXuPCJl1rQjLE8NzSbmmXn/hR39iCOHRkPhosDKTcg6HEsJzR1qxZCGBnKCTWG30jhV9mBF
	GN0YR
X-Google-Smtp-Source: AGHT+IEJMhelvd9k6prcrL/5SvES/+s36hwykYnIzV7bIabZ3ZkmismiB8YKbKK1g+iW0hPsnp9qYg==
X-Received: by 2002:a05:6402:26c2:b0:5d0:d183:cc11 with SMTP id 4fb4d7f45d1cf-5e0b70d2736mr945575a12.2.1740141414885;
        Fri, 21 Feb 2025 04:36:54 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e3bsm13594295a12.11.2025.02.21.04.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 04:36:53 -0800 (PST)
Message-ID: <883fed07-1d21-4ab1-8c72-9a1750ec1606@linaro.org>
Date: Fri, 21 Feb 2025 13:36:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] drm/msm/dpu: Implement new v12.0 DPU differences
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-15-d201dcdda6a4@linaro.org>
 <qlotuliwnm5spneolztca7avmh2a46pz2xqlxzqbw5kwa53m6q@oyhnzz7fhay3>
 <4b2426d2-a7bb-4c19-9ebe-77f6a90caf5e@linaro.org>
 <CAA8EJpquBhQeac0E66NqeagkxP-qY0whmah2ND0xziUQdxc_7g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpquBhQeac0E66NqeagkxP-qY0whmah2ND0xziUQdxc_7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 18:24, Dmitry Baryshkov wrote:
> On Wed, 19 Feb 2025 at 19:04, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/02/2025 20:18, Dmitry Baryshkov wrote:
>>> On Mon, Feb 17, 2025 at 05:41:36PM +0100, Krzysztof Kozlowski wrote:
>>>> Implement new features and differences coming in v12.0 of DPU present on
>>>> Qualcomm SM8750 SoC:
>>>> 1. 10-bit color alpha.
>>>> 2. New CTL_PIPE_ACTIVE and CTL_LAYER_ACTIVE registers for pipes and
>>>>    layer mixers.
>>>> 2. Several differences in LM registers (also changed offsets) for LM
>>>>    crossbar hardware changes.
>>>
>>> I'd really prefer for this patch to be split into a logical chunks
>>> rather than "everything for 12.x"
>> everything 12.x is still logical chunk. I can split more, but without
>> guidance what is here logical chunk, will be tricky.
>>
>> For example 10-bit color alpha looks like separate feature. But
>> remaining PIPE/LAYER active - not sure.
>>
>> I can split them but I would not call such split necessarily logical.
> 
> I'd say, the following items are logical chunks:
> - ctl->ops.active_fetch_pipes in dpu_encoder_helper_reset_mixers() and
> dpu_hw_ctl_reset_intf_cfg_v1() (with a proper Fixes tag?)


Ack

> - 10-bit alpha, border color,


Ack,

> - active_pipes
> - blend stage in LM + set_active_lms


Ack,  but you do understand that this is purely from new hardware, so
new registers. Even the 10bit border color is actually for new
registers. It makes no context outside of new hardware. same here.

Best regards,
Krzysztof

