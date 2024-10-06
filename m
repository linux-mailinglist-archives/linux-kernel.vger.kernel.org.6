Return-Path: <linux-kernel+bounces-352362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1530991E16
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7B1282495
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C291741C9;
	Sun,  6 Oct 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRFLoBjT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876313E898
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213682; cv=none; b=d9A33BOboWzJfVE0c3IBSWtgLIS+digTcGhkyW8iLqrbL5X4i75se5tf1bw7VQ83E5pKpSaEyqAzS3gkkqjHqeKspFKvPRSQQPYeimBvr8TJzD56nuAr1Kgqd8enXpdB9xn2UnHYdMm1N3t3uEhXJUe8b3cajnM6eBHqB1FCr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213682; c=relaxed/simple;
	bh=kAkf6NIhOlen6xkgkrgYREOsdkIOiEOGqa3LkxwXAz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rANccJXMBsM08FXX4Z1nSUjYJdsO3Wkq6mXSqGXBHNllVif0jReVoh/CEES3k2KeaRTKJxhQZHhUyJw+JBt5nnMZMox19cfGMTJbbH5nOMuJzY4Ds5Tp1jUZCyMWy9PaNrq0Ae6AqwWv0z3eweN+9YY/D1ANV/Pqlnz4yUIQfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZRFLoBjT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so8121701a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728213678; x=1728818478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IaSdlUzNDNfxslBW/OGrSNOxQF3vX0DH7/KKjL0CWFE=;
        b=ZRFLoBjTG8F3mnbaxzhEVD5mJKaLx5/2TTk+hrgvD3rdpHcyXkH0aj+uPy1cA8D4wx
         Af23dzdoNOYTNwpzbbqx46oCw8/n8HpYvCKG1Qd+xvl8BSGIOil2iyAT7QvsXKizpBWK
         PUXOoo12LpxhY6HIQIaMCZEtPE64TkBWJVK0J7zpihvQSrhbh8HcbSzL/aR1ETUhORfS
         2A0I9OMJxJSQTiRQF+1Z2nVOqA5BgPNRE8IO3JZUOLi3TXRC8vcy1KPbR4lAwlXjrpWc
         Av9hGEa16S8jbnKt+ZESVTlwP8Ygdj36R8Ao5EERaSF78gTr0fKlAQ2mnoeFD0K+6tI1
         8fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728213678; x=1728818478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaSdlUzNDNfxslBW/OGrSNOxQF3vX0DH7/KKjL0CWFE=;
        b=DpE4T8SFHN8CQ8/hHEYRDvr4yG/HJw/25W3GjAsvCQrxRiNnNNXxbQBr/5guKhSSpQ
         jeSjKcmPLzzZl63DatXz+w+rjzg/w/41KqsxpJLYGNNjexiWVQPFOLRI73qF1dbbWNjz
         gBHwFgts+8t+tEGi6Z0OyNhWxChs7D/7YUmiODrwO1Bp5hSYsTqboEvX0sTO5jwp3HVp
         OKXrQ9RisxA21VVEvdP8hXKUCwE4ujNE4s5niiF+InOGkdhSFpgtkSEDdX4UFxD6wuXU
         u5lg3khldsNqGkILh2K5PZpFVOjiv4B6VqWL563buuaC19ExUl6TXgoE46EMReFR2uE9
         dSow==
X-Forwarded-Encrypted: i=1; AJvYcCVWXgz5/kDlBFZXjKyULaxvm1M5nsz2lEX6LuIF79kFnqVPv4URur6v6AUBjyhbg1P8MFvsQngAB43ixXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNIEIg+3xr4XhUOux12gVZPGAxSeL7W/QQqvrKdFGKlB+PeHk
	4aB9X/tkLt4BhF13BEKI+FfdDCz92AW95mFL8qQ5N2iqWM0EUbmqfM0/hUWjPaA=
X-Google-Smtp-Source: AGHT+IGhNzL6F7Y3Basq1U7UYWMAXnxAome0GeoM6oq+0r0hVBAogjvQax1Al72V/SfzYXj8LXhFpw==
X-Received: by 2002:a17:907:360e:b0:a8d:4e69:4030 with SMTP id a640c23a62f3a-a990a0606a4mr1387180166b.19.1728213678283;
        Sun, 06 Oct 2024 04:21:18 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7860cbsm242410866b.120.2024.10.06.04.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 04:21:17 -0700 (PDT)
Message-ID: <b9e1c0ae-5651-418a-9b71-897cd739ed0c@linaro.org>
Date: Sun, 6 Oct 2024 12:21:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: fix sink status being
 overwritten with RP_DEF
To: Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 "open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241005144146.2345-1-jonathan@marek.ca>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241005144146.2345-1-jonathan@marek.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2024 15:41, Jonathan Marek wrote:
> This line is overwriting the result of the above switch-case.
> 
> This fixes the tcpm driver getting stuck in a "Sink TX No Go" loop.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> index a747baa297849..c37dede62e12c 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> @@ -432,7 +432,6 @@ static int qcom_pmic_typec_port_get_cc(struct tcpc_dev *tcpc,
>   			val = TYPEC_CC_RP_DEF;
>   			break;
>   		}
> -		val = TYPEC_CC_RP_DEF;
>   	}
>   
>   	if (misc & CC_ORIENTATION)

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

