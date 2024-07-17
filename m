Return-Path: <linux-kernel+bounces-255307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87C933EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BD7B210AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82618132E;
	Wed, 17 Jul 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NinKXh5b"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FC1109;
	Wed, 17 Jul 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227332; cv=none; b=NatVhzsIiOI2QjPXb+TRO7PJBqWcUAmiCNdGm//9mAcWzHDFzFRDwLiHiY/TUvj7vdbvrQco/pgKlJ6JCIwC0+H7ff7kTMy8iELpT3Sk0vYH5WFFkAt5pvvSJCM1i71bgqqIplbYzVcgjfTR939xhd8r0qG0MoR0bGEIMfyaTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227332; c=relaxed/simple;
	bh=l/KM7yxi2ZHkF8cQYBEhy4a+9kOEEclU8QcrHDuMnK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEJzyQGdlv0UH+doGHbGRthU0/BP9XsRsGlxfsvqP+kLrzwMaay9MhAkt6I79kf5xjJuxZuQo0//HSH9faLhI9xU27ii/hRznup1v8OH5EAsbVArtn0hrlEsP4gk460N5fhF0REmdaB7XUr120XdaJzOQlHqajqW2w42bmY5p8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NinKXh5b; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-78006198aeeso610647a12.1;
        Wed, 17 Jul 2024 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721227330; x=1721832130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9+H9w8F77UOiuxTWjm2gxO0HFKxtsrjJrC/NVtqoOGY=;
        b=NinKXh5bZliO84cqaMwxH2p3Ege24w+s0zwc1X5rqu6redgT58lY4+2aax+WIsaC4b
         gYMKStmODu8N0+oAOU64nyLoo+eBqSeqYZHH7M7pV5bvUZF/83Rt82FMvyCNDvcuIwSH
         05UrcwP8CQI35rs1FT4MCbSMv7yjy0bWfh0bvx1fQlYGNs2mdfFudzLpWnWu3wFNk1Gp
         N8/O3vnqL/ykCMqJtTk3nIyiJHPcTu8Jj7xsxdweRU9pEDWIMF17pTagctcfWz5RCCyt
         sFcV5P/dTpzRBz1GpPA8g8fJ0fUCXx4iOfFLvaEzP5Q2zjsCn3gy7c7Qg6+0gOIdGnj6
         vCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227330; x=1721832130;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+H9w8F77UOiuxTWjm2gxO0HFKxtsrjJrC/NVtqoOGY=;
        b=J9YNQl0C+uN8NnynRG4ECEC35Wwrqc1NwkdGHYH8P+h0eFOradCxLUvXqlMfLfbBtt
         5TushiwPVHIyqtjNCMMF5UeLNhcqNrd8tJbPfYb1SiRJmo2U9nNt1IrlohF4iggLSdGO
         +uW75USmvVvxHH3a4HBTUnr2IqcIM1DbLtj1ErTCXWAhvWIU9P5pC57MCFe6sf0Z5lQi
         r8RTEKFzuCK8VYFUDJaMA6tjp2CUKaFHkTT3g/oTgGpEPmfcOaxiqEJgO3/LP1rlgBnc
         +wQRYIXEW+Q5a4Ce/RD8ER5pIvolc2D6qJrrVeSRajMqxn1aEqpGKr9Ck+oWp+spfNf6
         4qsA==
X-Forwarded-Encrypted: i=1; AJvYcCXyhP9HomXbLSLLbEAFKiia2u+CVskSoVW+7ZgTfTxHu5Ec1AUcfL2+7+TGxuB8bNKYt9LCVItqdde4yup336Iwr6PtAqSQ0TWh6MdV0wcjn8vU58jPFU72nfISZZtgpjL5O/3B10fTidI=
X-Gm-Message-State: AOJu0Yxe11nl8YV5WdGIWGNQZJdPjCcumvpI8yGTrh1pO4dLOJjFpz9t
	c7rKuvWfjQWqDZlayMW2MEkw5R0qIGLpcUJlspLAWq46IDFJMauq
X-Google-Smtp-Source: AGHT+IFzIuwPU0tk7qlRcOVg/ETQ6ftxICf4AoFYaR1qpTdQwQjw/2oKyOQbCcwNIBDFyjh3O1ecRg==
X-Received: by 2002:a17:903:22c9:b0:1fb:a38b:c5b7 with SMTP id d9443c01a7336-1fc4c362d39mr32559675ad.1.1721227330321;
        Wed, 17 Jul 2024 07:42:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fe52sm75712465ad.21.2024.07.17.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:42:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e83aada2-79b2-4272-ab10-4453083193cd@roeck-us.net>
Date: Wed, 17 Jul 2024 07:42:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hwmon: pmbus: Implement generic bus access delay
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20240717073000.786228-1-patrick.rudolph@9elements.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240717073000.786228-1-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patrick,

On 7/17/24 00:29, Patrick Rudolph wrote:
> Some drivers, like the max15301 or zl6100, are intentionally delaying
> SMBus communications, to prevent transmission errors. As this is necessary
> on additional PMBus compatible devices, implement a generic delay mechanism
> in the pmbus core.
> 
> Introduces two delay settings in the pmbus_driver_info struct, one applies
> to every SMBus transaction and the other is for write transaction only.
> Once set by the driver the SMBus traffic, using the generic pmbus access
> helpers, is automatically delayed when necessary.
> 
> The two settings are:
> access_delay:
>    - Unit in microseconds
>    - Stores the accessed timestamp after every SMBus access
>    - Delays when necessary before the next SMBus access
> 
> write_delay:
>    - Unit in microseconds
>    - Stores the written timestamp after a write SMBus access
>    - Delays when necessary before the next SMBus access
> 
> This allows to drop the custom delay code from the drivers and easily
> introduce this feature in additional pmbus drivers.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---

Sigh (sorry, but this isn't your first patch, and you should know).

Change log goes here.

Guenter


