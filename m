Return-Path: <linux-kernel+bounces-421290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9329D8A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951F6B6610F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143F1B3944;
	Mon, 25 Nov 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8vKl1G/"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD718C345;
	Mon, 25 Nov 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548180; cv=none; b=kZAa1q5XXAd7ZO3Q2gctwKU5uyn0sPhtQ+gfKyh4qtVaO+ATMRo0drDvruCqyEsTuo+EjhGnms1Sx5TdwdpuH/3uwoW4Xgy7b8omT+gsWK/qfce/tLE98aqS+k15qc0xi0O/NctowhbAXMPM7NGVqeCaXU3YHwlM2JJzAKTEUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548180; c=relaxed/simple;
	bh=jjfffoSdffwZDcXh85Zc3K0LtTwymYrtKYWfLl9rkDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEushQ2Fwyxoxdow6qrJz9Mb1l8j6HQVCaNnAh/GFovoOPdjAXh0MHxeTjReS8SYs8XhFnbysHSlxZVwgUb95tsgQ1HGbrrXUk8ivx4QtVSf0AojIQtB/nQPl9z5SuBLTR/6k3IkLotV6ZLqzp0D78ovqie5/pqUdQOOCGJtLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8vKl1G/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f8b01bd40dso3195075a12.0;
        Mon, 25 Nov 2024 07:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732548177; x=1733152977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pA5keJmCUO7eMYiuFODcV9OmUyA9RUw96yl+dfKJWZU=;
        b=F8vKl1G/ysF6HtKVb3UauYPo0Vic/x7ySq2Z6L52aMrve7r7jUdqdPkByUby6Ftk8M
         B2WDimQU6QDVEZ19b2cUjKCxO+ORu5+wiqDA8SMMsm1t8fOksS+VRexEVPNQZFmAfdyD
         ei6skvuKfBnmxl7/ocNuu+Tfj18/FkCAmZhTBWT9sM0/znuEBahsDswAGujg7DrOzeiZ
         fADbsQM/laP9Pd8gZfF74nZrKPpIZnDUHepqd4qld7Bj/rpwO4/VeP0Epjc0zMuTzS+C
         nPUhBnCIgLaV7ooYxNgA6Nn3eXjIJqQd41nHVJsJNEIb7bbhMKln2EpblhkZI+BYJw6y
         A9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732548177; x=1733152977;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA5keJmCUO7eMYiuFODcV9OmUyA9RUw96yl+dfKJWZU=;
        b=KLlXGC/FkHzNCmrAN+me252S5fMHGSWU4QZpw3LPe9ceYgH4hREvZQGpRJHkw+x0i2
         fKrS9+yESvkQL4zJEhhpfQUtKG1r0frTul95ttzDfzqt8kxpqNASN8H9wrS8VJbVhX9I
         hukWgwbW08HMkJvLlaugMSsvQbfBAt4yBShXeCEnzTsL4BgVljPR5LyVGT/Gg+9C08iK
         FbYndix6JvgOP0bOw8ogT+SpjGx+hoeSQS4kmixDmddYDzX7Hay0msKN0UIKQmbpuckD
         yuHYhNlWLljqjAXrUxqeOAq47zsslrcp7qyZHXD3VvLv6ru743jPpXS9OT/TK3fu4UHT
         R/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUTLsDN/mlws1xgriroFcvYrfXEDNNybA5hmcni3veMa0gLWK7aESye2qWv/8oxOQHTWwBO84hCgBQekw==@vger.kernel.org, AJvYcCVnOIFb0/v7hSQy3bgg4+IwiZNZQGrDhmYxC/NQAYZHCxaXPnJk74SvD+F64nVZrNmPfQyrImW13KyC+yCB@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5pREwfAJbDYhoU5knr+QPuqcQE76ptVCUMZQVPI6a0qfREGn
	uAz04CUJd5z4LAfBB8UNdBTGpkF8rr3e7xIdpR72k6SFBgevszHdagubkA==
X-Gm-Gg: ASbGncuJnWFMNlp/a6cJIvOJ1ITP6IHmMFv/eH7btxG/V6ePV09KLdYzR7tClyOcxcz
	lMJEqKOQgy5ANJEMpuK/cuULSLcBGcVUVO0olFBRWsPtvF0fQYwLi7JpzKQ5dgjTEg08W7IaL1V
	sZbji13tk54m4hTwxz7WBOwe4ZKjINM+l3jVtDAsLx/3fHM1Bi6u1DEe7x412qY83DQdZQlnClk
	iiQFRlMbi0ijFcG0uztUqz3c978YuGTzh3B+6rd3phIwTGrm6pErj2a8dQUiyv1VConFCYkZYxN
	5TBQ+r1/eGkcxS3Q2hLWbtc=
X-Google-Smtp-Source: AGHT+IEgiIh8M72lh4VSB6EkU9yUrwERGhfYKyRL8dVCHnNR+ajhKa6zMXiPKeR4BpgIejOhfhJrcw==
X-Received: by 2002:a17:902:e943:b0:212:10ea:a4a1 with SMTP id d9443c01a7336-21283c86ac6mr258919105ad.15.1732548177132;
        Mon, 25 Nov 2024 07:22:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de4549a1sm6753301b3a.24.2024.11.25.07.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:22:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7acbc41a-f822-4464-8bcb-b7379fa78a86@roeck-us.net>
Date: Mon, 25 Nov 2024 07:22:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] hwmon: (acpi_power_meter) Fix update the power
 trip points on failure
To: Huisong Li <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-3-lihuisong@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241125093415.21719-3-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 01:34, Huisong Li wrote:
> The power trip points maintained in local should not be updated when '_PTP'
> method fails to evaluate.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 4c3314e35d30..95da73858a0b 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -292,8 +292,8 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>   	struct acpi_device *acpi_dev = to_acpi_device(dev);
>   	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> +	unsigned long temp, trip_bk;
>   	int res;
> -	unsigned long temp;
>   
>   	res = kstrtoul(buf, 10, &temp);
>   	if (res)
> @@ -302,8 +302,11 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
>   	temp = DIV_ROUND_CLOSEST(temp, 1000);
>   
>   	mutex_lock(&resource->lock);
> +	trip_bk = resource->trip[attr->index - 7];
>   	resource->trip[attr->index - 7] = temp;
>   	res = set_acpi_trip(resource);
> +	if (!res)
> +		resource->trip[attr->index - 7] = trip_bk;

Unless I am missing something, this restores the old value if setting
the new value succeeded. Please explain.

Thanks,
Guenter

>   	mutex_unlock(&resource->lock);
>   
>   	if (res)


