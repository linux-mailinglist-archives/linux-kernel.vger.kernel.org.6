Return-Path: <linux-kernel+bounces-406863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AA9C6535
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6096C1F23D47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9820ADDB;
	Tue, 12 Nov 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt+pz0SO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E66213135
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454464; cv=none; b=XZjlUy6nGvbBhiW3EG8el+/5BPKd9AKE7RXgntMl0FqznAEIGZyoZXTGrGwEr2rbuRTZVZiJ+PeHNt3OY5XM72bN7803Ii0wJZS8TopuAE98fwx/WYyzz41gspCFdkj3faDGoivMriDfUpPTjL9NhBktQxGSLxw01Cn09XGcCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454464; c=relaxed/simple;
	bh=V7YrvqMxBiDtu1yyjd5HTYFxNev9pFYFi/CbJHPn/GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7mWFr1pxb8ZuyjnSXjFj0NBOJ+WjtCzaqED/mbpmTgB1Y50exDHUfDcsH1l47eriEZM9GAYEGu9A5Kc3oXViu1WWf8X/KxYalYCh2sG34OYq5f/fv6CWggmQfCy/dh29KzlLZxBJNIO3TP5Xq2iBz9duyAwHnF2rE68tTRsYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xt+pz0SO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so52735305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731454461; x=1732059261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDK6Jpe2m/hfg4hQn4ofja0c9FU98DCMFpbVNI55NDw=;
        b=Xt+pz0SOjdIN95RcRiAVuhh3b0dx4jfeab0fNNmMVCLXCz8zguDUujXvHLBfbaLlNw
         yEZ+5dJp5isT327A3Az76TtVQ6eWFrfqi88eeltZcPpXpc4tJ6S49cGrNdhaRWp2bZcW
         oU3VycPUcBVJtXONPQ15X45LLHYnbFK/o2GPgdHnqNzFNK1b924wAV8gMxcLvqeaScDB
         DyjjgmPAu8RUl7aBE80V9OOyLRgHtq7Tt4TNjXATbaVlOJs7xtcuYvFDgwUskH/3nKmd
         l1FgDivKED0r5OERgl8OHW0TLSlD6rek1Rh/B1ZcLohcScfFGs0tGBnLhX14N8j401qo
         kRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731454461; x=1732059261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDK6Jpe2m/hfg4hQn4ofja0c9FU98DCMFpbVNI55NDw=;
        b=pB3n/y1Q6I10MFGbR0vE0Qf9kfJBLJcjzcY+5HnzlI4g/57DyH3RKHhGKUlG4IHgyV
         58f+Y0IoKgX+j9KgORm2OZNoNuEbXWnW2GcXHv4KgrsHD4qbti0MushQG3SWmsvoTfHS
         YX240yz2Sb7xrJTUYXOBU+uJePt60rJ0CdW9SlFy/YaHwqyj9Ch3JtOHSsscdIoHkw8I
         rqrwp+7mbI9w1Zq8btggep5FxdUYMGnuAsj8UVaCb7LehB7dLWI3d8LT/LCaqlOvHw+R
         EsvmCxPKjufwqw7P4gv80Blua7yCb369ljZHc0tY9cThk5yjCVa9jbGwRZ+BZf8ILko5
         sJig==
X-Forwarded-Encrypted: i=1; AJvYcCX4nyeaJYi+WP2ZfYyL4ul02Zkvvu8iLS7KrfVeLN0mu7oM2fSvH/J1pzC0f2aPloCXm9dTFBOzg771mBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsoDj+awAbHiDknTcxpoSTX5ubuc/3cBugC96dxA14+5QZbWR
	rm23cLzWURQLNdrl27ePoTUq6BoKHsR9DOx1/1O4UDrTQOjNpDWenbgL8MPGQh4=
X-Google-Smtp-Source: AGHT+IFlTjuNrbTGIsR+0sG4thfT19ptCWMJEbd2b1payDR1CxHa6BLA6qbK+uLJjTdl7xL7zRnAjw==
X-Received: by 2002:a05:600c:5125:b0:430:52ec:1e41 with SMTP id 5b1f17b1804b1-432d4ab80d5mr8680315e9.17.1731454461350;
        Tue, 12 Nov 2024 15:34:21 -0800 (PST)
Received: from [192.168.0.48] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d550c14esm2955535e9.28.2024.11.12.15.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:34:20 -0800 (PST)
Message-ID: <1cefe6f0-5d08-41a4-b0c6-2291dd5781ca@linaro.org>
Date: Tue, 12 Nov 2024 23:34:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] media: qcom: camss: Restructure
 camss_link_entities
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, krzk+dt@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241112133846.2397017-1-quic_vikramsa@quicinc.com>
 <20241112133846.2397017-2-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241112133846.2397017-2-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 13:38, Vikram Sharma wrote:
> Refactor the camss_link_entities function by breaking it down into
> three distinct functions. Each function will handle the linking of
> a specific entity separately, enhancing readability.
> 
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   drivers/media/platform/qcom/camss/camss-vfe.c |   6 +-
>   drivers/media/platform/qcom/camss/camss.c     | 196 ++++++++++++------
>   drivers/media/platform/qcom/camss/camss.h     |   4 +
>   3 files changed, 138 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 83c5a36d071f..446604cc7ef6 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1794,9 +1794,9 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
>   				&video_out->vdev.entity, 0,
>   				MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
>   		if (ret < 0) {
> -			dev_err(dev, "Failed to link %s->%s entities: %d\n",
> -				sd->entity.name, video_out->vdev.entity.name,
> -				ret);
> +			camss_link_err(vfe->camss, sd->entity.name,
> +				       video_out->vdev.entity.name,
> +				       ret);

So you're doing the right thing reusing camss_link_err here however

1. The commit log no-longer matches
2. I generally suggest patches should be as granular as possible
3. That means if you want to use camss_link_err in camss-vfe.c
    and BTW I think that's, correct then

a) Refactor this to be two patches
b) First patch is about reducing the repitious string and introducing
    the reduction in camss.c and camss-vfe.c
c) The second patch is about restructiring link_entities in camss.c

Basically this patch now does two things and instead of havin those two 
things contained in the one patch, you should split those two things 
into two separate patches.

---
bod

