Return-Path: <linux-kernel+bounces-335045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77E97E049
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49E61F21429
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5E18DF79;
	Sun, 22 Sep 2024 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjfIIQnk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523B11712
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726985996; cv=none; b=Okjr1s+7/JWNWUFe5SX+EwO0uEjky9xT60WjBwQXQotsXfW1qLaMiioYqW3OYUHTck7y0TxnS7GHhHzijFkb4eozvCydbombuXBGb5EC6yrQap3ARi5ZZvVUH3nCFVxT6W3rj4KmrVG/jTyTTvsEQnVH9xw4UOiCF3+JprLx2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726985996; c=relaxed/simple;
	bh=mT/Xp8IOBrnKtZ5WSBQDU8PqaOhKuApPXozFLdMKsiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRMNgAgZVvSdOGMgNFLskz0lVNdNGgvmyZxPI4Ol9StsnhPbzjgSSl+K2vU7UnblpaRlbYvgVzOufRHG5Zi96iJNsJMzMkvIQkFnNS0b0C6j0JGOxJP8ET9YJtEGZowoZdo89znNcecN/JgyHEx0dG9WynQaxahjsFtdG9Hhb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjfIIQnk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2068bee21d8so34265035ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726985994; x=1727590794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xQ9V6HSaf4CAgLfVMwdW/11tmA/ZODg6WnRklyW9P8=;
        b=YjfIIQnkRtlvMafC15JRTNwbkN2UUpgU40im465dYZXa1JarL1cXsP0G0yFYldkni0
         4HOSM549PuFhxgNX3NZKcMq5kw6rBv8EXLYY4obIBbfqR+mqI4zV5ZbtB6PhxBqkgXoY
         ZfWEETuBnHNGZ6xvVgboDEz5duzeRInttSDR1GJEDwXBpb+yDVDiocW4fJtMP6K44KMo
         Ql9sDrp57aMj1EyEgkvRmOmUzsw1yfNRVjZA8YQE2htzysnP3e0DtTjGFU+QuFAXajyn
         sxoSNrpma0Y1DEZnyIB8N19vucKgu/Lhf6dFoo5YJfp08I4D+v6cJfhfYzvVGw7/jfaN
         e+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726985994; x=1727590794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xQ9V6HSaf4CAgLfVMwdW/11tmA/ZODg6WnRklyW9P8=;
        b=GjjaSj8ikLa3L/xxDSyta3Hj6CGLIcIrg8nQtBVmrZhW/ujCu3IM8uwbuYAJAJzaCX
         1Bzkdf0ccLYFajbgyFBMvxJC4mC11k5b65zetLo5iWeB/aayYtCp+SKxBlf4QnZnROpK
         aVF12fMYJ7lwMFQVx4A9ho+n4dbyletJNS3nRKKJjLuRzVOvj7ZvLarpKf+AbISfFflx
         V+hSWbPCag2MSl2EbFHRjfAxzeKuniN/k00PjDmH6SNFBynHSX0Tc7+VQJVPaOxBKiV3
         3Y09Jw6znGnUrXNBkTJ1IOUqn/G/xryhQfUadfAHI7WubuzZJcD1EqzSscLpuDLvBlOW
         Y4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCX1kqbRLoPAHkJD76gpQ022nnFl09pK2mlJWQriRrqpcGMocK2LFCiZZJ2Yc3lIjbP1eUymgqMMsLaq+X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/4cbw6GiIV/+rONBB4U0y3SCTZy6+jK5Axl4qGyu5Q+6b4Pg
	YA6sc4PsFo/IEQlfU10c7QY6B6ZbjVl5ilq/ZlLXOK8Q95GrTTWS
X-Google-Smtp-Source: AGHT+IHco0PIIsbh+MV6+539AZjban0BxjLXSZCarpWMLofXWVD3xMzTIYoyBh0YTzpmrUpdjtCTNg==
X-Received: by 2002:a17:903:191:b0:207:1913:8bae with SMTP id d9443c01a7336-208d8397c1amr90751845ad.14.1726985993913;
        Sat, 21 Sep 2024 23:19:53 -0700 (PDT)
Received: from [10.3.80.76] ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794730629sm116259225ad.247.2024.09.21.23.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 23:19:53 -0700 (PDT)
Message-ID: <d470e0ef-0193-478c-a858-d6498758aa9a@gmail.com>
Date: Sun, 22 Sep 2024 11:49:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: elida-kd35t133: transition to mipi_dsi wrapped
 functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 quic_jesszhan@quicinc.com, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240917071710.1254520-1-tejasvipin76@gmail.com>
 <c3wv3r44cmua2hphyjqzb7pp2a32pvs6svcj6s2zohp77qn3cr@4iica7j5bx5l>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <c3wv3r44cmua2hphyjqzb7pp2a32pvs6svcj6s2zohp77qn3cr@4iica7j5bx5l>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/20/24 9:59 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 17, 2024 at 12:47:10PM GMT, Tejas Vipin wrote:
>> Changes the elida-kd35t133 panel to use multi style functions for
>> improved error handling.
>>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 107 ++++++++-----------
>>  1 file changed, 45 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
>> index 00791ea81e90..62abda9559e7 100644
>> --- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
>> +++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
>> @@ -135,25 +127,16 @@ static int kd35t133_prepare(struct drm_panel *panel)
>>  
>>  	msleep(20);
>>  
>> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>> -	if (ret < 0) {
>> -		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
>> -		goto disable_iovcc;
>> -	}
>> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +	mipi_dsi_msleep(&dsi_ctx, 250);
>>  
>> -	msleep(250);
>> +	kd35t133_init_sequence(&dsi_ctx);
>> +	if (!dsi_ctx.accum_err)
>> +		dev_dbg(ctx->dev, "Panel init sequence done\n");
>>  
>> -	ret = kd35t133_init_sequence(ctx);
>> -	if (ret < 0) {
>> -		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
>> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>> +	if (dsi_ctx.accum_err)
>>  		goto disable_iovcc;
>> -	}
> 
> Move this after the last mipi_dsi_msleep(), merge with the error
> handling.
> 
>> -
>> -	ret = mipi_dsi_dcs_set_display_on(dsi);
>> -	if (ret < 0) {
>> -		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
>> -		goto disable_iovcc;
>> -	}
>>  
>>  	msleep(50);
> 
> mipi_dsi_msleep()

Is this necessary though? Converting this msleep to mipi_dsi_msleep and
moving the previous dsi_ctx.accum_err check to below this seems
redundant. If the check is placed above msleep, then we need to only
check for the error once. If its placed below mipi_dsi_msleep, we end up
checking for the error twice (once as written in the code, once in the
code generated by the macro) which is unnecessary.

-- 
Tejas Vipin

