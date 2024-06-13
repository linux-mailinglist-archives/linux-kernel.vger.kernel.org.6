Return-Path: <linux-kernel+bounces-213361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B8F90742D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB89B284789
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85D144D18;
	Thu, 13 Jun 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikHKyI4u"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C19476;
	Thu, 13 Jun 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286419; cv=none; b=JD+R/KWj71iKidZpKlLaitY3hSX8jGseAj0fcMWG/V07Vojlb0KQ0p/Gw66sPaGUwGhNk7mHufm+D0kyEhDgG2jGwRbM8B3lcIZric2kY4mOtGvAPZm/tEb1XDj4Cytlan0Tk9PTY1iQZPepbFvHUi2S3YXMhk+iWarxBDKmqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286419; c=relaxed/simple;
	bh=cLTlb0MIYYTHtZ+pmfm8TGdplUGb99YJYQz8oU/M6/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQEYh2R3faIHDTpSUUaUPWgXpCGhhUxc1DP0SIM8bhFnGb1jK4P1Ie11xRTpyl9TRBMACFmM4xHf/2hKIjEQzE71UemwRVtB+VQo46aT7s5b4JFl2kiGJEI6wikhp+MQlP1XZiBcUzcbGvWRbOLmj+JDtXOpyiK/AonzMBjJICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikHKyI4u; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-704261a1f67so776146b3a.3;
        Thu, 13 Jun 2024 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286417; x=1718891217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3UDlNvMamIbg8E6qB25/Fj6Y3vwnK2yTxGg2ToHYWkA=;
        b=ikHKyI4uGjXaGW0uIO9wOTW+xYUB88xbQNQTqUfrF3bYZ++CmnruM58sbO1UPqtjiA
         VNLSK0SvLU+vhdlnG4S/V0xn6untGtR5VfowlXan5UkDkr0cjedZE3sc5O4UNz158wmy
         zIh0R2+qz/5FjzamoZCYduITwJudQBSFARBkVAtiZYflPSxnvsuXZpnU3CIsbm+nyMKA
         5ucWuIjnaCz6nVyAb16caZZRe+WNd9q6iqFThXfYih9C8gloPqLWj14aekzRgcNLZdFl
         Xi64Ay+ZP7u7qo32ceEbOhoov3D0SAIiU3EuOEAfA9yeb56lsNC9y60aQXPv+TVOPAk3
         noxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286417; x=1718891217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UDlNvMamIbg8E6qB25/Fj6Y3vwnK2yTxGg2ToHYWkA=;
        b=Mx70bwHPuaQoLIk6b3uKTu6hCwDlSH/qexDD8hENlJSqDNAaEKu8tT5Fo4KqzvkEXV
         HCOD8Os09Bz6PACOGXo6dx3H1tn48sY9bmYXUTfleaXo6Qtb4K2sbyaGEF3G99YNI3y8
         iMQx5zsXEjqgBczubr1oFbh/pApTAovptvu7/WC57OXZt+5kcBvniQU4MxfejG4lwB6C
         IaatzRLjkQ0ZcA4vErj2WNWdjAfiD4XpGmMPUv/m98+Ojlsvk7npAvVvxfyH1wBziQec
         SVssHn+MCCt/NKDi25FmVCW35oq6uOC5imrgp11NJTnEj5NcUdZDEM0Cb7FDsQoOe37a
         Zs+w==
X-Forwarded-Encrypted: i=1; AJvYcCUEeWBe34D/jPr+3Q/GKAQRwDYtb+46VekmHhedcVJj3oWTpIQFIi8T0g2GndCrG3GjG1ZaT8NAf5gtYnMpzQcbpqKpjBCscq2ldc/K/1dRyOCqiD9gT0V71zJ9yFQw7PR8Q6e7jDPTf40=
X-Gm-Message-State: AOJu0Yx121d6eu7+R457/d9r6qf16PZvsGWuVNMb5/pgGcMCFMvlh4cy
	BLfYpT1drX4XD7VZ2rfbmPjR2JjxhFR5cwDEHyEiivFeF5xJIC82
X-Google-Smtp-Source: AGHT+IGPCNGOVGTcDmHZ+P6mJfERO9Y99QuogSk6vP5GoI76s0l31CHG/2tUyZrAOtrM/zDLYMTFbw==
X-Received: by 2002:a05:6a00:a04:b0:705:9aac:ffb8 with SMTP id d2e1a72fcca58-705bcdf085bmr5746433b3a.9.1718286417215;
        Thu, 13 Jun 2024 06:46:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8f3desm1315949b3a.201.2024.06.13.06.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:46:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b5f50d2-198a-4bfc-bbdc-d2da02d50ca7@roeck-us.net>
Date: Thu, 13 Jun 2024 06:46:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hwmon: (max6639) : Update hwmon init using info
 structure
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240604124742.4093334-1-naresh.solanki@9elements.com>
 <86ed7651-818c-42fb-ae31-8f73f7e725a7@roeck-us.net>
 <CABqG17hC_h8ru6xmTZiQH4vEAY_+zcPk4=CMB2rn9u_j2jVx0A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17hC_h8ru6xmTZiQH4vEAY_+zcPk4=CMB2rn9u_j2jVx0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Naresh Solanki wrote:
> Hi Guenter,
> 
> 
> On Wed, 12 Jun 2024 at 20:04, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi Naresh,
>>
>> On Tue, Jun 04, 2024 at 06:17:39PM +0530, Naresh Solanki wrote:
>>> Update hwmon init with info instead of group. The hwmon info structure
>>> in more flexible to describe sensor attribute & easy to maintian.
>>>
>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>> ---
>>
>> After applying your patch, I get the following errors in my module tests.
>>
>> Testing max6639 ...
>> temp1_crit: Suspected underflow: [min=0, read 255000, written -2147483648]
>> temp1_emergency: Suspected underflow: [min=0, read 255000, written -2147483648]
>> temp1_max: Suspected underflow: [min=0, read 255000, written -2147483648]
>> temp2_crit: Suspected underflow: [min=0, read 255000, written -2147483648]
>> temp2_emergency: Suspected underflow: [min=0, read 255000, written -2147483648]
>> temp2_max: Suspected underflow: [min=0, read 255000, written -2147483648]
>>
>> That was not seen before. Problem is that your set functions pass 'unsigned long'
>> as parameter, converting negative values into large positive ones.
> Agree. Will update v5 with below changes:
> For set functions, I'll change 'unsigned long' to long.
> For get functions, will do typecast as below:
>          *crit = (long)val * 1000;
> 
> Please let me know if you have any other suggestions.
> 

No. Running your patch through my module tests was the last step of applying it,
so you were almost there.

Thanks,
Guenter


