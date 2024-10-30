Return-Path: <linux-kernel+bounces-389046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9639B67DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5441C21B32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC11213ECB;
	Wed, 30 Oct 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzIjqaGO"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9312139BC;
	Wed, 30 Oct 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302208; cv=none; b=EsG4WgD31u53szdzJ/sp7CmKkYwkoGwtM1f9p8EDGjv035hzbgPxzTx+UFLjYCwKxbTNLRgBR67IOpEY14OyBzfpREssy25EnhV0vwqEVvJxNEx8JJ2fjj3k+MvbVKNO7SK6XurwOEpwzIkHx1VH0yI6N5ViOPDtsNbbyO0K0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302208; c=relaxed/simple;
	bh=TNGe6i0pr/X0kJB8J5k+b4/g5tBfFkJ8e9cUIB4A1TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJzDiXlg1qPAk4DOAJ5IYWjXT6nWQamJ3NM4UgZMfWQpdfy33biTPoqzDU75QgNOMaPdgBDWUZkJ/8Ad335OietqYc7rKBEtaKR3vy0ap8y6OX9eLWf15uiLszt7BZw3+ZNBXmuB1HNvC476bw6B8yyYGU3aeJFbG1uHAA8inKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzIjqaGO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso4782374b3a.3;
        Wed, 30 Oct 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302206; x=1730907006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zPZ4mwwr9svxgaczgvRAV1mca2J1e2rIZsyrFTFD+aA=;
        b=bzIjqaGOa62pUSMpZcAQY288VNvWQJxvHUdmVoLeRPlb+lqcQ3k9OBD7KIb6L+UYIG
         Svyur1IUMguB23aqy+jpRz9VQxM/R0ge5UvSYtfikzqpSK3tuKWzTztJXesYH2SVgjkL
         ZsvPvbVoL1B8So5pwJOUZyIL6NXJ/lBzgOWP6tEPIgusHmnf3CfQUbzQ6urBRCwXWeIz
         wsv1aqKC2tqBo3xilh05JUrlj+4wUy0Ahg8wBegUvDrTsFj4pR7yhuSK/P4PvqWcP5qa
         USRPqh12s4einydtklPQ7Mpz3jYYAWYALFUCz8Egxmf+N2gUHj2Bi60gqyRHT6otY2RU
         KRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302206; x=1730907006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPZ4mwwr9svxgaczgvRAV1mca2J1e2rIZsyrFTFD+aA=;
        b=j4TKCESnQrw99/wAWreOWGoP7vhQioUOG/9o1M25a4SKkWXoTsAcrRMnxRXHEQr6qX
         5mseZw9JgoFpu3+ZYsRmUzqJlHRG2lHyLCsOn39FCiYXI85MsDYHV2g2Qry1JxFE5dRL
         x45PhqcJivCHyCBojC6n2bZqf0MqbZW6pGUx+3Om+yg00j2SWyNdx51GGZ6Wu3A1pBy+
         MWwtE8jyGGUq8XZ6Jeh7FcHbOags4XB9SbwtRODMKTrtlojGHG1G7GfS8C/A9b9LJ/lz
         yiqnS+vi4oLfKkFNX4RMX1+q0dBLVWFjg8+UDjlO2p3S9hhtaG3VLXbIXPL8s0Y+nMsv
         e5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmwIPy+sM9vYf5cJPjpRnsn6DbSh0CgfxZ/cOdOr5L3ludB7Z2OXKEwtB2uRxQVcYsuGEUxJ+IyNdd4Ys=@vger.kernel.org, AJvYcCVkZm2+3XFuX/TCHx8zveeyFOg11RlPZZn14ltf1vFkptPWPX7LYncV2nD1R+U2zKe9w16xWMtv/DMr@vger.kernel.org, AJvYcCXyzzvWivSw3HJpUir5b/omTG5igGOlrnQdTQFVVr75qYHMl7277j7/FNJ3EBIk9vBiGH3/gBQW4XqH/Ob6@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUluQ1Nmb0Wg6B7zNvU2t21Nl7ng1NLeGeuqZL9daYC7vARIZ
	msVFeQTowU4VoUK1Q1X+ha2YSh6EqC6kcvrkvZyaqAjIaKioaYwk
X-Google-Smtp-Source: AGHT+IFLyrt1rrhgbmA1DJ0OOckVmlQJ3GVMGilPPmtjAnR+E75he88ejnDAFBd+eH6WdMkzj7XLVw==
X-Received: by 2002:a05:6a00:23ca:b0:71e:6122:5919 with SMTP id d2e1a72fcca58-7206306ed56mr20183703b3a.20.1730302205714;
        Wed, 30 Oct 2024 08:30:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921a78sm9648152b3a.12.2024.10.30.08.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 08:30:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <baaee942-b46c-468b-9f81-3b9c8b1f9ef3@roeck-us.net>
Date: Wed, 30 Oct 2024 08:30:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on
 shutdown
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-2-akinobu.mita@gmail.com>
 <OSQPR06MB72524578F1E5BA93772A12728B4B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <CAC5umyjtCaYPjtgDnJ69c87w825MFSHgm92JA1kWORwP4Hdjww@mail.gmail.com>
 <8a68babc-b4f5-42f2-bc93-ce8f1b7a14e1@roeck-us.net>
 <CAC5umyjtyuf8ECxhX+QeqQKb9+8emPU4omxw6V5JizAQMaGhCg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAC5umyjtyuf8ECxhX+QeqQKb9+8emPU4omxw6V5JizAQMaGhCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/24 08:18, Akinobu Mita wrote:
> 2024年10月31日(木) 0:02 Guenter Roeck <linux@roeck-us.net>:
>>
>> On 10/30/24 07:55, Akinobu Mita wrote:
>>> 2024年10月29日(火) 11:35 Billy Tsai <billy_tsai@aspeedtech.com>:
>>>>
>>>>> This adds an optional property "retain-state-shutdown" as requested by
>>>>> Billy Tsai.
>>>>
>>>>> Billy said:
>>>>>    "Our platform is BMC that will use a PWM-FAN driver to control the fan
>>>>>    on the managed host. In our case, we do not want to stop the fan when
>>>>>    the BMC is reboot, which may cause the temperature of the managed host
>>>>>    not to be lowered."
>>>>
>>>> I confirmed that it works properly.
>>>>
>>>> Reviewed-by: Billy Tsai <billy_tsai@aspeedtech.com>
>>>> Tested-by: Billy Tsai <billy_tsai@aspeedtech.com>
>>>
>>> Thank you very much for testing.
>>> However, I plan to change this option to device attribute
>>> (/sys/class/hwmon/hwmonX/retain-state-shutdown) instead of the device tree.
>>
>>
>> No, I won't acccept that.
> 
> Oops, I mean /sys/device/platform/pwm-fan.X/retain-state-shutdown
> not /sys/class/hwmon/hwmonX/retain-state-shutdown.

That does not make a difference. It still very much looks like a system property
to me, and making it a device property to be set by userspace just looks like
a workaround to address refusal by dt maintainers to accept the system property.

You'll have to make the case for why this is _not_ a system property for me
to accept it.

Guenter


