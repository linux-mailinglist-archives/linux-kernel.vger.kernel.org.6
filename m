Return-Path: <linux-kernel+bounces-337994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4C985201
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6C41C231AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952E14D430;
	Wed, 25 Sep 2024 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxJfHXx4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E652AD11
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727238368; cv=none; b=oJP75J1Ki3FGfncA+jjPq/AMSAuyix+GFK3rqKycLy2/9fCwa59GdbO1i8K+1ucAjCQKSyzQieVLPNkblCWOw9OsddRzJTCRsew7xjO1r1cGpF89Sqbq6VgC8mgHWkensYU+fY24a/qTtc4/SAFMJoyDdKD6IsNEyp4O7gPHkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727238368; c=relaxed/simple;
	bh=76oDldOt8nY4cZVg3v1oGG8fL1Uw8CcDp1ykn3KPdR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujy5V1Tv8h1o7faICW3x7YmdJ2qVnxr+IxkpYL+C6wTnofoWjb1OoaJzUhtjw/izVnwpPf1ppI1YbhbtmVC9o2BgBCc59LH0Rh/gQcA9txdmcka8/oeXdzuK7zlEudQMx0YWdtKqxbHU+OQWVsPk3vdBRTeHY2jd5vTyJobH+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxJfHXx4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206f9b872b2so51820125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727238366; x=1727843166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phoYo00B6ZRIpjfRG/81GcMspTNk0jh/acvNetZig2s=;
        b=AxJfHXx4FkCwuylUBA15q3EY5+7CHCbODUsUK24Y7aCuY9aCMVtGaCMLb2UT5ZJXK+
         mr0TYu/g2xqaIk20ujjDYQhSsL7Z0qAxUx0r7HGumC8SMMmZjUjgsRI1Nc+WA/Io4/Ki
         7a0noTqC5GVG50kKs+ZvdBpZVZZcnkiSoDdSJa/acMTAlQImMtHCTktFcPM36kxpNbEA
         47LEy8anJNyZjQruLSaXzQf4h/OSGetdjAExmJ2JGRMtQ3Ul8PhaAdyH/bQG8Df2ZP12
         sVvBnNXs4pzDH9KK5acwFDJNVK2xq5bkByWPMy/+NetbVcTnK8Ofqe+U4rM6h4avUxgA
         bDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727238366; x=1727843166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phoYo00B6ZRIpjfRG/81GcMspTNk0jh/acvNetZig2s=;
        b=hvAMMrU/BardosyC7nPN7L7Sx069erjK8QCLsd+9i1ghHK0/tJi7WCuORMEi3SQkmz
         taVn+41U9cT6jslw0eSr2ugLk8jmrzGbFBOXik74QtgaXgydpWJLA58iPpnAXy/rGe7Z
         ZR4q+XOtvEGh/qLHzzXjZQYuZhE2O2YPTCzOPzeEqk0m/wbM5IBrTv/Pf+pwsM4LazZm
         jeF9YEitVhzWbTiHN7oFrOZuKcMB+5pSbVKYudYdhJWzjS3tbEuKjQKIStsCAUrQmOSD
         j9ojMafHew8EL0hst0xKyq3x1gJR9X5XVnS1DJrNvb3mqJmxpuwhB3IMZ+xjFmj4wqo7
         jBDw==
X-Forwarded-Encrypted: i=1; AJvYcCV+fvjt7DTIZcNaHH6AZgG0Qjn07Zqyi9icEHLsZ9x1PLRy4XHtEq8D2xhXlQ1OvLlVLGXxSWcFLpkzeHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pW+ioYj4EQytSMQekVEqcH1Q2iIU5ViBFsugni+x9NF+4bIk
	/sWWFisUqGyCKkuyEjrsqMKd9bp+bYn4EiF0W7u7EgYx7Ci9dp6m
X-Google-Smtp-Source: AGHT+IGKxgpD7biIYq4dyOkPpfiLme60hVAhSy3SkRA7HVSfGbct0bidQMhuGF/r7xrAdvHEu1ZB+g==
X-Received: by 2002:a17:902:c94a:b0:202:26d:146c with SMTP id d9443c01a7336-20afc42d838mr19087135ad.5.1727238366183;
        Tue, 24 Sep 2024 21:26:06 -0700 (PDT)
Received: from [10.3.80.76] ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73120sm1899603a12.68.2024.09.24.21.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 21:26:05 -0700 (PDT)
Message-ID: <22d4aada-da3f-45d6-b2a9-b2f9a7ac7d10@gmail.com>
Date: Wed, 25 Sep 2024 09:56:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240923122558.728516-1-tejasvipin76@gmail.com>
 <CAD=FV=WmcyAbzU_M25rCzc3JmNGZ9T0wzMJAfxi-LmdZ6389OQ@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=WmcyAbzU_M25rCzc3JmNGZ9T0wzMJAfxi-LmdZ6389OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/25/24 1:25 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 23, 2024 at 5:33 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> -static int kd35t133_init_sequence(struct kd35t133 *ctx)
>> +static void kd35t133_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>>  {
>> -       struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>> -       struct device *dev = ctx->dev;
>> -
>>         /*
>>          * Init sequence was supplied by the panel vendor with minimal
>>          * documentation.
>>          */
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
>> -                              0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
>> -                              0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
>> -                              0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
>> -                              0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
>> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
>> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
>> -                              0x20, 0x02);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
>> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
>> -                              0xa9, 0x51, 0x2c, 0x82);
>> -       mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
>> -
>> -       dev_dbg(dev, "Panel init sequence done\n");
>> -       return 0;
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POSITIVEGAMMA,
>> +                                    0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
>> +                                    0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_NEGATIVEGAMMA,
>> +                                    0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
>> +                                    0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
> 
> It seems like you dropped a few bytes in the above. Was this
> intentional? You seem to have dropped the first byte from both of the
> continuation lines (0x00 from the first, 0x4d from the second).
> 
> 
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL2, 0x41);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_FRAMERATECTRL, 0xa0);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
>> +                                    0x02);
> 
> This used to be the bytes 0x20, 0x02. Now it's just 0x02?
> 
> 
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
>> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_ADJUSTCONTROL3,
>> +                                    0x51, 0x2c, 0x82);
> 
> This used to be the bytes 0xa9, 0x51, 0x2c, 0x82. Now it's just 0x51,
> 0x2c, 0x82?
>

Oh dear. No, this was not intentional. Most likely I think I wrote a vim
macro poorly.

> 
>> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, NULL, 0);
> 
> Are you certain that the above is equivalent to the old
> "mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);" ?
> Where is the "MIPI_DCS_ENTER_INVERT_MODE" constant?
> 
> I think the above needs to be:
> 
>   mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_ENTER_INVERT_MODE);
> 
> I've confirmed that this compiles OK and that there's no need to
> actually have any bytes in the sequence.
>

I'll do a v3 addressing all of this.

> 
> -Doug

-- 
Tejas Vipin

