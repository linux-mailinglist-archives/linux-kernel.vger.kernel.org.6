Return-Path: <linux-kernel+bounces-220601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D890E443
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7216F1F2535A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AE7581D;
	Wed, 19 Jun 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME1MvefH"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE13574077
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781784; cv=none; b=gGnMsZeSBSQVrbMzVnYQRdWCIy1k6Tt4k0NPAYQjN9Pos41CUa+0gsRnd4aV7cmQCgsBkK3ToQnCCgG5uAvfHpwI12iA5MwlypvPddX/CJTRJI1LFmTc4sSw260KOGkmRM5ueG5cYOlrgYMJ8ikCZZez0buJQ81yEJWQLUu9Rac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781784; c=relaxed/simple;
	bh=ngpHcCrM1X7mc4wPm38zxIOXVRlcC6KG0uGmx9lUIiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lppm37IP/vy/FJGHY74ubzhBnq3GdoQUPu9FD6pJUUr0azfATruvZzh4d1VlGXq5XJu9OKF7biUjqR0+BaDm0tHr7He8cTFrTMtjtvbt3bHeXIzkTxUwAiF1I3CZiwmgks+anQurpAW+YwSJq3OY1tgBHuh6x8su7A/v6kP8oIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME1MvefH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2ecd25e5aso4914371a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718781782; x=1719386582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FveVfxPudO0I6HFCr6cHBBWBZ89yS/VFWEzd7gyK5w=;
        b=ME1MvefHFlAFccC5i4aO7p6JHEZIKhL8ZlZHrhNwlHPH1xSGocEJNr1F4LrZhMeWuN
         c1gFlusQr1h/WPVzkwAQjC9YN7CguoUMEnzTu6pUYaespqLT81f0KZwm5YFVNOWQkVU8
         g3FQCTc2q0OLnqyqNT6wCLjk3hQBTIcLS2L/ldhd9NDpp9Z9OQu/QA8Vki2zkGOhxEf2
         KkQ4AqO19XU+U1jRz1VlnNvsqwbdAcA4DbYleQMf0HxVSLCcW8z8c/crZKWPXZV9VUU7
         RbPDw6jbzaQqvdWPhHpXhCjCw2UnzEY4KP6JDGyYUJhlwvqnQV01grG03EFjG6wFqucJ
         DrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718781782; x=1719386582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FveVfxPudO0I6HFCr6cHBBWBZ89yS/VFWEzd7gyK5w=;
        b=HEJwtW9Kxa8kEnV724aU/6f3JNPJ8ZZlj4UUISZQtCCPHfIc/MQrcZn17euLapblgA
         72KS5UTvNhrj3EeC9Xf2QIVYcebD2riSlRqTHZnCMgYZNJYgjWuSQuEzoM3+XyEjqn+f
         D05Jc/RGcBSmwPK3iNq7C2uv69kW8jZqQiFf+3RXnTw8UycL6XmZqjw9yIVeLTz0mbQ2
         nM19SCxZDTt12v1WJNwlzjT+rY7Nk2DWX0wvBFrge++F43+dHMr+NFA7ZiMapMvtcedy
         RD60vvadGpZ+uhadJYK/xe+NEhAVLGCpWrhiwI2r0NDuoRv9Od5AhfxYUbDs0Tvmpwnd
         ZYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvGGcDfnk14E9rU8xMGf4hN9n01MfCGhTHlRSN/Lf5wy2B13jk6CpjxlYkefxvqifv5Rw1eZ/5+q+awNlCaHOCO0exES5bXHaMFDoP
X-Gm-Message-State: AOJu0Yy9jUmVPfssusG0+GhZpeFCDvOzeXfOvclo0ShZhin+OjC0nYwK
	R4Tr4WxAYIRF8BnuMs0F3KNW171Fs5Gn1EkLXetguxVKRgljGgfR
X-Google-Smtp-Source: AGHT+IFktMVASJzQCiDMim5aegxCPE0SwjlCRAhAZzOnDGvYTZRFtUSmGK2jeUmrQXz/C8k/0mlWag==
X-Received: by 2002:a17:90b:1107:b0:2c2:f26a:59d4 with SMTP id 98e67ed59e1d1-2c7b5d57cf7mr1753675a91.32.1718781781989;
        Wed, 19 Jun 2024 00:23:01 -0700 (PDT)
Received: from [10.0.0.19] ([122.172.85.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466bf5fsm12085934a91.35.2024.06.19.00.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 00:23:01 -0700 (PDT)
Message-ID: <a9312102-44c1-4529-b3ef-a7831392c42f@gmail.com>
Date: Wed, 19 Jun 2024 12:52:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 dianders@chromium.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240619033351.230929-1-tejasvipin76@gmail.com>
 <mozxxkpqlboh2w7bf55bezgcy5b2jfgepmgullgd24dtmwfva2@mghwg3c5an5y>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <mozxxkpqlboh2w7bf55bezgcy5b2jfgepmgullgd24dtmwfva2@mghwg3c5an5y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/19/24 12:06 PM, Dmitry Baryshkov wrote:
> On Wed, Jun 19, 2024 at 09:03:49AM GMT, Tejas Vipin wrote:
>> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
>> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
>> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
>> raydium rm692e5 panel.
>>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>> Changes in v2:
>>     - Change rm692e5_on to return void and take mipi_dsi_multi_context
>>       as an argument.
>>     - Remove unnecessary warnings.
>>     - More efficient error handling in rm692e5_prepare
>>
>> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail.com/
>> ---
>>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 237 ++++++++----------
>>  1 file changed, 99 insertions(+), 138 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
>> index 21d97f6b8a2f..9936bda61af2 100644
>> --- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
>> +++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> 
>>  static int rm692e5_prepare(struct drm_panel *panel)
>>  {
>>  	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
>>  	struct drm_dsc_picture_parameter_set pps;
>> -	struct device *dev = &ctx->dsi->dev;
>> -	int ret;
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>>  
>> -	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> -	if (ret < 0) {
>> -		dev_err(dev, "Failed to enable regulators: %d\n", ret);
>> -		return ret;
>> -	}
>> +	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> +	if (dsi_ctx.accum_err)
>> +		return dsi_ctx.accum_err;
> 
> int ret, please. Let's leave dsi_ctx.accum_err for DSI errors only.
> LGTM otherwise.

Is this really necessary seeing how regulator_bulk_enable returns
0 on success anyways? It saves creating a new variable for a single
check. In case you do think its necessary, should it be changed in
himax_hx83102 too?

> 
>>  
>>  	rm692e5_reset(ctx);
>>  
>> -	ret = rm692e5_on(ctx);
>> -	if (ret < 0) {
>> -		dev_err(dev, "Failed to initialize panel: %d\n", ret);
>> -		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> -		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> -		return ret;
>> -	}
>> +	rm692e5_on(&dsi_ctx);
>>  
> 
> 

-- 
---
Tejas Vipin

