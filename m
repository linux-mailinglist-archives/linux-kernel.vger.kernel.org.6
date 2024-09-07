Return-Path: <linux-kernel+bounces-319699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BD9700E8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60932842EE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB291494DD;
	Sat,  7 Sep 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW0ONj68"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B34134BD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697954; cv=none; b=SxObabjSOTPZw0wyMp5yBu3RJjlJ88HesD8UD2mgq4IrbpwJhUnOR5mzhv8APWXtdkO7RKCbnBPkYE3PFyRgIGpCTd2ZlenaK4rEox0L2NSySzVQdPiyVvOZaTbcko70v7FHMLUZwvZVlhF8bHzsIZMqXKVkdvCZSoxtyzT/Scw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697954; c=relaxed/simple;
	bh=BU0VlnAseaf46NbYoSU+WR9e5QPurVH7LUxnzxpb/h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1RKQKTGkZfVnnJCoxYro9B1xJambuYpt5lqwOZekbqRYMGseT7YCOUczIyIUXCJkJxoRUQdRB45DP+PzEzp1RfTEoO0Y0temCRCSdg0Hc8qsFphwLCOWm1ZxRY/U5j5hzRJ+xt2FZPS/QRRfg4X6Zwc5FchSre5N/FLVyfBVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW0ONj68; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5de8b17db8dso1689884eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725697951; x=1726302751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oKEoYV8xUI1GgTKhxgYDza28t2ifQzvK4btLf5o7Do=;
        b=fW0ONj68ZJshyabiud3YAxDwjks9S1hGrKGBc8GRYrN3EWbRkpFYnEOumyUk4dZBfi
         KMHsR/JKHsUQydeySaWFn/GVtaSHwcA3LMS/Z/cuJG+etKUbbJuKL1qRQ0RqMLqLaXP2
         zD1MhbiNmYzj5DjHWHT6IZ0qgwVdK4QmPnRM5Lj1T/hjiPVMUySGNx0m3crfBWdV/zEt
         ChBXTMbuFX+BocsTmT6tRSGXdPWK38at9IfHlQRBo/ZNRzgE5p1jj1QVa66ibI0SwQJV
         Ol90lLGtg6/tdK2TPGcTtKSj0rz9ceUBKWmwVU+xBtN8SvPO3crKagZojiAKWSb1lBAI
         uEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725697951; x=1726302751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oKEoYV8xUI1GgTKhxgYDza28t2ifQzvK4btLf5o7Do=;
        b=xL96Ef1Jn5gVe/cGDtsQMzV1n1qcu90ofIdOVbj6559Kq/1BTel4rdVoupvere8FRL
         k8lVodZCaZksM23fBt0qP4QlGNFQTd8pRQCXsH05oLFEhAgWugd6BAW8uL3ZKVzZQ6nc
         hhc4h477HKUnsS4qHmuBFLrbmR1SHJq3X1qHlMNRLejaKnvkO8McX/3Qu37/8kWLYdKC
         UlqbPDUtqR5NjBkKy5TD+v/HdBWbQOOBa+ftHV830OUjp2CY07cW9podG1zG8UXN0ppW
         SELlRpQ/dzxO92DKhxIE7S/VD9bAs4PJme75m+HCk6AXRhOdXsi2UCUtgs7Ups2T8w/3
         g+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaIBFtsbqEl2vtVd6WfEtGFGnVUBKH7/bsrKql5/aAlCESQ2Uiu19m6Cep2MMC3eSl8Yt78k/rWrCtaV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2VYtx9UeQNApaGwVjUgEzH9i1biPQAkyBSZKhZcso0lmNM9n
	BxNUg6Ye/eOUkZP4dsgSEfccew55rWe0yNz11LGIEKqnzgCY9Qsu
X-Google-Smtp-Source: AGHT+IE/nLcnyMO6Rfwuf1W5J0uq6akr6ynAJyxeX2C8vFon634p4hDsDQz0hDu/VicDFso4wwra+w==
X-Received: by 2002:a05:6870:558d:b0:278:a21:de9 with SMTP id 586e51a60fabf-27b9dcc3a1dmr1840145fac.46.1725697951402;
        Sat, 07 Sep 2024 01:32:31 -0700 (PDT)
Received: from [192.168.210.157] ([103.4.220.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e589652asm569112b3a.12.2024.09.07.01.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 01:32:31 -0700 (PDT)
Message-ID: <330174f9-bead-4411-b05e-ea9c009f765c@gmail.com>
Date: Sat, 7 Sep 2024 14:02:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped
 functions
To: Jessica Zhang <quic_jesszhan@quicinc.com>, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dianders@chromium.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
 <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com>
 <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 3:53 AM, Jessica Zhang wrote:
> 
> 
> On 9/6/2024 3:14 PM, Jessica Zhang wrote:
>>
>>
>> On 9/4/2024 7:15 AM, Tejas Vipin wrote:
>>> Changes the himax-hx83112a panel to use multi style functions for
>>> improved error handling.
>>>
>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>>
>> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> 
> Hi Tejas,
> 
> Just a heads up, it seems that this might be a duplicate of this change [1]?
> 
> Thanks,
> 
> Jessica Zhang
> 
> [1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1

Ah, thanks for letting me know. I hadn't realized someone else had
started working on this too. 

However, I would argue that my patch [2] is a better candidate for merging
because of the following reasons:

1) Removes unnecessary error printing:
The mipi_dsi_*_multi() functions all have inbuilt error printing which
makes printing errors after hx83112a_on unnecessary as is addressed in
[2] like so:

> -	ret = hx83112a_on(ctx);
> +	ret = hx83112a_on(ctx->dsi);
>  	if (ret < 0) {
> -		dev_err(dev, "Failed to initialize panel: %d\n", ret);
>  		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>  		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -		return ret;
>  	}

[2] also removes the unnecessary dev_err after regulator_bulk_enable as was
addressed in [3] like so:

>  	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +	if (ret < 0)
>  		return ret;
> -	}

2) Better formatting

The mipi_dsi_dcs_write_seq_multi statements in [1] aren't formatted
quite right according to what has been done so far. They are written as
such in [1]:

> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
>  			       0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);

Where they should be written as such in [2]:

> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> +				     0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);

All in all, the module generated using my patch ends up being a teensy
bit smaller (1% smaller). But if chronology is what is important, then
it would at least be nice to see the above changes as part of Abhishek's
patch too. And I'll be sure to look at the mail in the drm inbox now
onwards :p

[1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1
[2] https://lore.kernel.org/all/20240904141521.554451-1-tejasvipin76@gmail.com/
[3] https://lore.kernel.org/all/CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com/
-- 
Tejas Vipin

