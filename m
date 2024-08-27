Return-Path: <linux-kernel+bounces-303601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9D96104A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411AB28259F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047E1C4EEC;
	Tue, 27 Aug 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeqFI+yJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F401E520;
	Tue, 27 Aug 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771240; cv=none; b=Cj2wS/CIT88BJ2KHuo37Uk8+vJrwhHM/DUQTgwbIAXtvn6IB9PVN5d7qNSsIH+TaWF76n7H5JrD/tc2OnhBQ3i8aH7JIouS5jyrtYU9/BCV2+w6PaRvzhjnfJxIN07+6Ib9opkOPna/iKasmjBtTjKHwzmjfNfGs4xgwtf4Z6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771240; c=relaxed/simple;
	bh=K5CuyLlWQbNslvs1onkWlOfOKt3uR4nEb4Qzc8SOiLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV7nKKwR0nzfvmURr+8kf/h8jztYlgDwhr2efyjb9vzcujG9pqNDM4E9BMcQkTJl4V2h9FP3M3oRK66fmt+qwiHQpLqlnF+D3udanJfhLaOU0HnZTe7Sf7MA4OLHH2al7hQDzyTbUB8jMnTtKSBszcYb5QbcIOR41URklmLuVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeqFI+yJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714186ce2f2so4305614b3a.0;
        Tue, 27 Aug 2024 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724771238; x=1725376038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhY8MlE7WAXySqETyaPueslpGTmo9aoHJrk0EN8U8B4=;
        b=OeqFI+yJ4MwA11DH1WFD7HOwoqrBqf64zgPYSTkSCF5+Xop+e0hsjJamjlG+/CNoPo
         FohJAVSyy57jJ/sbDDKdJ5ms++b0hiyInzZ5gSHduzrV4E0lRh/vhC1v63Wv0iYX9HVl
         I4FNssAfEyrN/YYpTsFmiq6bG53f/u9JgQQCa+70TgNeKRepGgXPRGomnH9WUqU7WHeW
         4X+FRvypZoI0+PWkzLtuklGTx13rDkZU2rOk4ZGdC9+WMhizPeP6WXKJBboXP/Vf7nsN
         Bq5RXs8GcWu+ZyktSd/HNN+JNe3AFmnzxYiSd29asWK5M1jOsDH4VCft++yP6X3zVyGh
         uW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771238; x=1725376038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhY8MlE7WAXySqETyaPueslpGTmo9aoHJrk0EN8U8B4=;
        b=c6P/35aI+c6tAIg7fzGvS5CssRCvhN0HJCyfZQt734RFuEXoRCuMkYD8H6n3OFwT3L
         leSSk539dQuhOahF3WsKGA4H+yqm2sLssM9XEwuByTYuvIfkNKsrVqbSLApdENS3ch8E
         YKHsouX3DwE4gssEWVqBC/qfwl8OzUr546xxJtmD5yWXAR1oUQ8Hdtk4A8Pf5z9mDYKa
         7r+33mKQmGRbzM3I7E7HIGjm1KXnYDPJww5KtlvwKYpOX5NXt37yyVNm6kyb3L6WT/ZR
         FperrDSwWqBBKD2MGdacBptYp9zfpicjOTwlw9Sebh/EvS5rhS6GCvu4P6mVJFVwlVI/
         jjwA==
X-Forwarded-Encrypted: i=1; AJvYcCUHxAmEkkg9rVV/kw0VTewz34JZCt+14bNpor4QNnF9955d78bgE4NIGAywXnGl+V8kOw3yS6uCRvRwtg==@vger.kernel.org, AJvYcCXfMRYt69CwiiP8kQSRA/JMrlsXRsQ8B7vMmVXuLAViOTnAwBilD7ligZzrFkCtdN5+z0E7YHLiqhFkJ8tZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXoIZ/rxMp5SMglQFXU1f37GKMDZHynGo/ZGshrJ8AGY0wFUO
	QIJEmjLwJ19IAGskYYnUmxsEWkg4do8V7DlMMd5kzIR91JuXR4c7qMGGiw==
X-Google-Smtp-Source: AGHT+IGpofjCQVU2JyL++Xk3cIYSBN4+TDk7PcY0U2RJluysFz/DcQ3K3mNOPdW/dJciqoHMyDGjjg==
X-Received: by 2002:a05:6a20:2d21:b0:1c3:ba3d:3ec3 with SMTP id adf61e73a8af0-1cc8a21a05fmr13995963637.36.1724771237979;
        Tue, 27 Aug 2024 08:07:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434273510sm8858223b3a.90.2024.08.27.08.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:07:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 27 Aug 2024 08:07:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: jim.cromie@gmail.com, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] hwmon: (pc87360) Use min() macro
Message-ID: <10539bd8-5ce3-4f18-96f9-c87e537467f3@roeck-us.net>
References: <20240827070442.40667-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827070442.40667-1-shenlichuan@vivo.com>

On Tue, Aug 27, 2024 at 03:04:42PM +0800, Shen Lichuan wrote:
> Use the min() macro to simplify the pc87360_init_device() function 
> and improve its readability.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pc87360.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
> index 9e9681b2e8c5..788b5d58f77e 100644
> --- a/drivers/hwmon/pc87360.c
> +++ b/drivers/hwmon/pc87360.c
> @@ -1315,7 +1315,7 @@ static void pc87360_init_device(struct platform_device *pdev,
>  				    (reg & 0xC0) | 0x11);
>  	}
>  
> -	nr = data->innr < 11 ? data->innr : 11;
> +	nr = min(data->innr, 11);
>  	for (i = 0; i < nr; i++) {
>  		reg = pc87360_read_value(data, LD_IN, i,
>  					 PC87365_REG_IN_STATUS);

