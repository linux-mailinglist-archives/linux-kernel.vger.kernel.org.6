Return-Path: <linux-kernel+bounces-538725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CEA49C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7B93A6BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950526FDBD;
	Fri, 28 Feb 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duHjAGul"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364A2686A0;
	Fri, 28 Feb 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754067; cv=none; b=ZuS8bxUofRpQPQtxxizuo/iUzRRUNONNEyRRro4VStCz7MMm0qC483YoXOoTDqW27uHA27G0b6ec2WTaPn0+3HJUEdW1bMuncYZD404hNxBRPwdhZbwmYtSZzk4UVa/5YQ/TyoDympe0nwsml9DQJmO74hUoVZEnkpGEDcOXllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754067; c=relaxed/simple;
	bh=uMI/SwIOrlpkoOm9W1A4BI8AXNrdzgT3hJobRIZk15Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7jmRejjlkq6mjP6w51W5Xuhb8GtBXkyXK3mxfcFxhSSscKGsS7S4YtgiGlmO976p0PYCeeEbcSlizNsdAmkO2URXRFQyqCvS401/6N5EIzvJp/mDrD4ihRX7pIf6+B4fXi7w2YbIImlSsY3V5JSoPVs2yzZy2geb8+rdGQFbW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duHjAGul; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22356471820so34427505ad.0;
        Fri, 28 Feb 2025 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740754065; x=1741358865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i2wNPwHnZnkmI+dSimlZAnrYFHIiGkSwVfEO0KaFlvU=;
        b=duHjAGuls2NOhY9rmv9pKs1yrwl24o88+vOSBBL2ChrXINmzb8N2Ah/ivKAJtrRzaR
         rDfrUVYnnd0Zyt0aPyJEC539jO/Jg/MJZAfGQ8Q7lT57f1DF3BnfWKPwDYpl7kxV92gT
         BhFyTqPtNplr0bJGW98gWBLEVjDgDAS2YDrDrqA9h0KdYhEYalrequnRJlX4dGx+x7TC
         lu/hgHXi3+NPAZfjABpfq9G21irF97/r1JcoOBfW4fZPyP1N+jUla5dbFGNEpXoFdkoa
         EnxSA6P6d9DXGTy8Otgj38+HZ/Sk90QHciUPWDgg8y87HYT7qRfmFnt+VniUUBFTiHMp
         l7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754065; x=1741358865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2wNPwHnZnkmI+dSimlZAnrYFHIiGkSwVfEO0KaFlvU=;
        b=JEeQLv3/AVK9136FW/iDJzgRz9CBK1MrrNfBLjyU6lPyJM8fgzeShfedWtB1dgJXtn
         rFxUEmd17mJKodxaN5y3q5pZBN8aoBjeAs6KCwljmw+/oW5C7SYPiLzJYgy0uJnQHysJ
         HQXuuMqPPvctPLIxjC3JQtNzCZczBNcjW8oDn9rhF33114Pgm+jcCcF2n2OOy8iII9pa
         cqqC2xgNpg9jdUrnUz+RsYy6Z0YDF0DQ3Yw9Qt6h/esY2i3rZFbGGJEma/I0JUt2O2l3
         1ySQRJx9qc9xzkYfGXM0UoRJopdzh9CawW2vOxv6m9eL1WprdNs/77vg/8xUUMPRedZs
         VEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC4benZtfKFuvzEpvhQJYiuAq+Jj45GahfgUrD2VxZxffMzhiezcr/8BcRSaJj2LOFHxMtdB/4jb3OXHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXNMvIPM14VU61mjix6Q9Xd1ZzEN45+/5/OCYQ4jID4V8ijLp
	Vw/2qWF69qA2ww5AXd9xmuozJOHx2tJ8IaCP4QmsqObV3dPk7lBt
X-Gm-Gg: ASbGncuOM6dZcICZCOPRXFTadBTVSt/rUiMXGOl8tPTi3rwvl+bP2OKqupqnPdFsXUG
	CkuBYauj3JcfaBBQ5z7QAttpvvbUcqK4HYM+gi/sZXOFXRkBAVC4uwMlot0/bdoRiyBV0ExIPu5
	PyLPGM6u6/5wCqEgGFCQDZwsFS9qWKFKZ/N4MCM9EE8rJMzv8dpAOZZc/8ccRgWOz2h+c0uuL83
	01S0dIcpha1kAeU65P5634ki7KAjyEA1IX/z/3fKxTc+3cGMgVsFBf4zwAZ2U11o8nvLUC8XmfH
	JorSkafrabqmT+hPdv6qEWgDL2ZDLGBpHMYmNo554fzZuDSbi7do4uZhzvdVp8zHKUt6YtKFW+8
	=
X-Google-Smtp-Source: AGHT+IGfgKZc58CV2yLAhpvTaX6Hfa2bRhNFoISBE5vZHLdKIxoGWxvLyhiyi238x2zIIc2QxwJr6g==
X-Received: by 2002:a17:902:cec1:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2236925558dmr62176595ad.32.1740754065039;
        Fri, 28 Feb 2025 06:47:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db7b1sm33682315ad.165.2025.02.28.06.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 06:47:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce3866a2-d264-4da9-9411-8427fc1c8f46@roeck-us.net>
Date: Fri, 28 Feb 2025 06:47:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (acpi_power_meter) Replace hwmon_device_register
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com,
 jdelvare@suse.com
References: <20250225085158.6989-1-lihuisong@huawei.com>
 <8b59c8d0-4710-48ab-ad70-b2eddc74fa9e@roeck-us.net>
 <05bb1583-13c7-25f6-48fb-dc415b3206f9@huawei.com>
 <d765aeb3-3ca6-44a1-9337-2706621df903@roeck-us.net>
 <765d509f-112a-2173-43af-e657f59fddac@huawei.com>
 <7c8db8ba-19ad-417f-bacd-00e8e88eea25@roeck-us.net>
 <25baf5c2-9f79-9bcc-fdfb-8d36b8472d4c@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <25baf5c2-9f79-9bcc-fdfb-8d36b8472d4c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 00:26, lihuisong (C) wrote:
...
>>> BTW, I have another problem as commit log described:
>>> -->
>>> The path of these sysfs interfaces are modified accordingly if use hwmon_device_register_with_info():
>>> Old: all sysfs interfaces are under acpi device, namely, path is "/sys/class/hwmon/hwmon1/device/" ('device' in the path is a soft link of acpi device)
>>> Now: all sysfs interfaces are under hwmon device, namely, path is "/sys/class/hwmon/hwmon1/"
>>> What do you think about this?
>>>
>>
>> That is as intended. The ABI states that the attributes are under
>> /sys/class/hwmon/hwmonX _or_ /sys/class/hwmon/hwmonX/device/.
>> The ABI does not guarantee that the underlying path remains the same.
> Yes
>> libsensors handles this automatically, as should any userspace programs
>> accessing the attributes directly.
>>
>>
> So we don't need to care or handle this change of syfs path, right?
> 

Correct. Each driver converted to the new API experiences the same change.
If you insist keeping the path the same, you'll have to drop this effort
and live with the deprecated message.

Guenter


