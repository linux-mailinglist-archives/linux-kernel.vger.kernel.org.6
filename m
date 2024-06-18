Return-Path: <linux-kernel+bounces-219230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9E90CBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B7C282E51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC8136658;
	Tue, 18 Jun 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2zkA0o4"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270A46557
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713547; cv=none; b=Mj3lEq4OHHPvYmO43JUfQrdjQGEXk3xuN9cHp3ZANjL0iUjIhnkodTrFVpEl4E0FO8JLtYFszGQZBLz5xEV96Xael56esL1xgZVeJD5QnUqjil/pXDjwQh2vMAZBmtJWZdX0I4FN730gHd+6CVCSaPAzN8H6deSnkPR1puC2/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713547; c=relaxed/simple;
	bh=Sf2OZyav+lIz0oAgOXDN+4Nav2sq3UKBUi1TJ1IykJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHockd5ajTY5qSJRFmM6Ry3sjCVINS1cpXA6N7oZnEeP8hDwTED6jm6IfPyjiiTdbkGyCF4nfvSjepQnanYqmXqaGA7czTS4779di2EpZnHbEhtbZjjJMAsMsGLMDbPj9gFBv4d+0doOi0Xrz1I3pkk6YmaKZi20tjHe1pGNNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2zkA0o4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70436ac8882so4117619b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718713546; x=1719318346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NY6uPHPa68jHM+L5M0kCzNkKbofFg3S/GyAR+NOOK/s=;
        b=V2zkA0o4/yx42uk7r3bvzkdkuhSzU1r07jKOzgLwNGhfPtFlvR6WI9tVZo3/xHzB7A
         93wdK8piVLNbX1/oAma9KlBR6GrWpjkBN7LKLFdHjKJ24nPCkizynHj5s20trvoiH4iI
         w5/PEigxKEvV3F0juzNugijyUP5rkPPTPHf/eTEwUGQfN5gRYIZOaRKkiBhiLQvLXm3V
         92amA3YBPCb9RVc3KgIJzdxZXkR2Ge1hbVR2nsLTAR5rDE56T6VC3iEFhDqi/qxHaBrp
         tqRCog9SGZFOAj3n6NOORGq7ijVK9Ljp5bCrnisFiEQJZfVw5kRS5cixAzumZHPmO8X1
         P11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718713546; x=1719318346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NY6uPHPa68jHM+L5M0kCzNkKbofFg3S/GyAR+NOOK/s=;
        b=wa+Nr3M8jPlQrCuGOiTTw9V4W9u0MPmPUO8rM2ChZGrr8Nhc/iiwC2p2UAnXdLoZmm
         ulEQkcb+UmC1SJtz8U9a7aLfrT3UXyLObDVds0RkHu9t03BWd73iTqSGOC4ofBkX3/Pf
         HmSFR2HZjL7LnUB3XccKiOsv6tpL9gWX0Ho2AY/EXqqRLUSdpQ4zQaEZOdTJJuej6rev
         L0929mkYevOjili1HHjCDFZzGVmFGIt0qknxvgfQr7McKfvU1oHgw9MKneSmJ4f/7u6+
         CPOf+upgFZqqQl9EiA3TKuoXZ5b/NzNRZ4kFrO8jBxvAfVDuG7kbV1GVUdXT89cCAHSD
         Na7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUL/VG86IVrOvcbtMkWjtL9br2yDZgQfZsB+PdqPb1NtBShQRGughGk4Ef0GxX+K5MKdMUmZxC79G0syxK4KNu9Az33T1Q1fTKrICK
X-Gm-Message-State: AOJu0YwcB10iVMzgop0r0mcxiPDFcMuD81YHEcp/hywNTXj5cEDHUuwQ
	yfEmixFarvji2lHUdpyTRmm2ePeDSZ6WB+d10LyE2a8t7P6YcSvO
X-Google-Smtp-Source: AGHT+IGa47riVZyP+rwzU4Nu2pdE+m1GXhxXHaH8DjTcYiTCKYVJF4wq9OFjKTm+ZrYfIlXyuon9jw==
X-Received: by 2002:a05:6a20:3946:b0:1b3:d59f:2d87 with SMTP id adf61e73a8af0-1bae82f6f36mr12674618637.55.1718713545588;
        Tue, 18 Jun 2024 05:25:45 -0700 (PDT)
Received: from [10.0.0.19] ([122.172.85.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e56183sm96304755ad.28.2024.06.18.05.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 05:25:45 -0700 (PDT)
Message-ID: <aa757abb-9883-4a46-a5e1-a7d4d5b044eb@gmail.com>
Date: Tue, 18 Jun 2024 17:55:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240615093758.65431-1-tejasvipin76@gmail.com>
 <CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/18/24 1:36 AM, Doug Anderson wrote:
> Hi,
> 
> On Sat, Jun 15, 2024 at 2:40 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> @@ -168,48 +147,38 @@ static int rm692e5_prepare(struct drm_panel *panel)
>>         struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
>>         struct drm_dsc_picture_parameter_set pps;
>>         struct device *dev = &ctx->dsi->dev;
>> -       int ret;
>> +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>>
>> -       ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> -       if (ret < 0) {
>> -               dev_err(dev, "Failed to enable regulators: %d\n", ret);
>> -               return ret;
>> +       dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> +       if (dsi_ctx.accum_err) {
>> +               dev_err(dev, "Failed to enable regulators: %d\n", dsi_ctx.accum_err);
>> +               return dsi_ctx.accum_err;
>>         }
> 
> It would be my preference to get rid of the error print here since
> regulator_bulk_enable() already prints an error message.
> 
> 
>>         rm692e5_reset(ctx);
>>
>> -       ret = rm692e5_on(ctx);
>> -       if (ret < 0) {
>> -               dev_err(dev, "Failed to initialize panel: %d\n", ret);
>> +       dsi_ctx.accum_err = rm692e5_on(ctx);
>> +       if (dsi_ctx.accum_err) {
>> +               dev_err(dev, "Failed to initialize panel: %d\n", dsi_ctx.accum_err);
> 
> I'd probably change rm692e5_on() to take the "dsi_ctx" as a parameter
> and then you don't need to declare a new one there.
> 
> ...also, you don't need to add an error message since rm692e5_on()
> will have already printed one (since the "multi" style functions
> always print error messages for you).

I'm guessing that the change about regulator_bulk_enable and 
rm692e5 should also be applied to all the other panels where
similar behavior occurs?

> 
> 
> 
>>                 gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>>                 regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> -               return ret;
>> +               return dsi_ctx.accum_err;
> 
> Not new for your patch, but it seems odd that we don't do this error
> handling (re-assert reset and disable the regulator) for errors later
> in the function. Shouldn't it do that? It feels like the error
> handling should be in an "err" label and we should end up doing that
> any time we return an error code... What do you think?

Personally I don't think this is necessary because imo labels
only get useful when there's a couple of them and/or they're 
jumped to multiple times. I don't think either would happen in
this particular function. But I guess if you have some convention
in mind, then it could be done?

> 
> 
> -Doug

