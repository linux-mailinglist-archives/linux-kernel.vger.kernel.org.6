Return-Path: <linux-kernel+bounces-179109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5B8C5BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A37281B70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED618131E;
	Tue, 14 May 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt/SOABy"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B092AF09;
	Tue, 14 May 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716080; cv=none; b=V4VajCWWdefMZzwFgb/zRlqR2jF8L9DTVQphU+aDCp4o9WstQOTxpe1dGR7j0INVJhPgpJuupw5bHs4S/cUMxxCR7hyf3Td6E301T1InXxGk044MtfyxGnnZ2/mwbEeY7oZR5/LohcJsXZIJO0tPjhSENCcmSZvSpU7fBkD0tWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716080; c=relaxed/simple;
	bh=qay9fcQvV5EoceZHhTP6fUUJbetuwCjx7BUkoV30CNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSJckt2wwikbJfx/3L+CB/4iETFmpnSJ7nnmYK84oI3fkI1ibgjOpXjQ31FJf5d31nEGD/7Bcx2APo0X/oR32Gs9dMUK7LMHG2VRZF7h3czfhIYtSS4mkrhZnYGLbujudmmbiDe9XFQUjFrZ44cF3HgVe/+bZD7evRP0/KU65DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt/SOABy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f082d92864so12344115ad.1;
        Tue, 14 May 2024 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715716078; x=1716320878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi3xCJO4rdouzD98U1mkPtXMtMWOntP/qKfAW4W0YOA=;
        b=Rt/SOAByv+FXtMXvF+EwSjE3bs0CW233BDsiBPwfLaqMS2CMZfNfAPiEI0p7FsL0x0
         UvSyiN/nBlt8kZxb4brFjIgiRWarOVtOUJ6HOPg7JpnPYNoB/3tXf7sh5ruwaxYR5T26
         L2AJl/gNaMh9PRZMICMZO+1LyTbv8kRicxXsZbUvwtDkPN1qn6ve1+6SoLLeRR7HyQQh
         LDtsd1l/fvGo9uCDzFzbJZQqPy76iu43Pz4WlkD+QuV1rfW6KJTvZp8Pu6lnZ/vEpWsG
         MfSUnOVEyb04NKAoN5IvR0qLOiPT2rVCU33cwJzIniBkXjUj9eI6PSa3m+OH0eX2sMHs
         KT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716078; x=1716320878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi3xCJO4rdouzD98U1mkPtXMtMWOntP/qKfAW4W0YOA=;
        b=lbBXqAm2hLqPxq+YSUqEN+7vrEcVJBGPtz/af3mOQlHSWjYW2Q/LHIMq6aon452/6D
         SZhPzTrirHs1r1OYrrtDD3/OwqegZIvg73o3lQ8W2Ak7dS+BWGgHvjKSoLbeHeQpX0Tw
         ZOiYsCB/jRJrVntatw7/I+ykMQf8LtWl1Ulmz/UlOobF0+jUU3WjCVEASxZmksgIoEre
         Rw+Nw/rKO33Z2v3qRMQV6SjF1nQCs+5aMuVGXZvyaUsngz/9nvACBD4V+lasqu+Pp8D0
         1140bVhH+BRjn5II6BEzfZ5iogbzNhNblSJl098LuhaA9usByvAErPL1AJ9Ph70kjhBN
         X2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXIvgU6vShh/fcOsLQITYCwVxCFCHju75pLupQh6+EGyDKWIqcjuW+4tWyMgyKWolAGhmYl/8jD7YeYUgXVG9mhTRav07h5usBVRd0zDi+gnLvmWpmU86KFR8rKphV6yQVfe4Qva37mf/U=
X-Gm-Message-State: AOJu0Yz4OQuuXi91TuBhBKZj4Hm85K8r258ape0QE5ToQO018Vcr2tzb
	OEyf+r+jA+TGacUEe8iQjfaPrB2iGqsRmfP2TxhgDh4k1m0zqq/VigImmQ==
X-Google-Smtp-Source: AGHT+IGZCnMC/bOxRh7FUxYTdfqgcP/E8zz49nkIrxV3BmwU+yyXVME2L0sXfin0okcQxL5lYmUISA==
X-Received: by 2002:a17:902:f689:b0:1ec:8d50:8dec with SMTP id d9443c01a7336-1ef43e293efmr169956265ad.39.1715716078438;
        Tue, 14 May 2024 12:47:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160a1esm102270775ad.279.2024.05.14.12.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 12:47:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <488e8eed-e0f0-4055-b43c-5422b6302632@roeck-us.net>
Date: Tue, 14 May 2024 12:47:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sbrmi: Add support for APML protocols
To: "Chatradhi, Naveen Krishna" <naveenkrishna.chatradhi@amd.com>,
 Naveen Krishna Chatradhi <nchatrad@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Akshay Gupta <Akshay.Gupta@amd.com>, arnd@arndb.de, lee@kernel.org,
 gregkh@linuxfoundation.org
References: <20240502220554.2768611-1-nchatrad@amd.com>
 <20240502220554.2768611-2-nchatrad@amd.com>
 <dd4ef0b6-8272-40b6-9a50-edbeec14d5e4@roeck-us.net>
 <8cf0d519-ae6c-4ed0-899e-899f67479052@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <8cf0d519-ae6c-4ed0-899e-899f67479052@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/14/24 12:15, Chatradhi, Naveen Krishna wrote:
> + @Misc and @MFD maintainers in CC
> 
> Hi
> 
> On 5/3/2024 3:56 AM, Guenter Roeck wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On 5/2/24 15:05, Naveen Krishna Chatradhi wrote:
>>> From: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>>>
>>> The present sbrmi module only support reporting power. However, AMD data
>>> center processors support various system management functionality
>>> Out-of-band over Advanced Platform Management Link APML.
>>>
>>> Register a miscdevice, which creates a device /dev/sbrmiX with an IOCTL
>>> interface for the user space to invoke the following protocols.
>>>    - Mailbox read/write (already defined in sbrmi_mailbox_xfer())
>>>    - CPUID read
>>>    - MCAMSR read
>>>
>>
>> This is not hardware monitoring functionality and would have to reside
>> elsewhere, outside the hwmon subsystem.
> 
> I thought as much, please provide your opinion on the following approach.
> 
> Background: Present sbrmi under hwmon subsystem is probed as an i2c driver and reports power.
> 
> However, APML interface defines few other protocols to support OOB system management functionality.
> 
> As adding the core functionality of the APML interface in drivers/hwmon/sbrmi is not the correct approach.
> 
> We would like do the following
> 
> 1. Move the i2c client probe, misc device registration and rmi_mailbox_xfer() function to a drivers/misc.
> 
> 2. Add an MFD device with a cell, which probes the hwmon/sbrmi and continues to report power using the symbols exported by the misc/sbrmi.
> 

afaik mfd API function must not be used outside drivers/mfd. The mfd maintainer
is (or at least used to be) pretty strict on that. The core code of a
multi-function device might better be implemented in drivers/mfd, with
drivers in drivers/misc (for the misc device) and drivers/hwmon/ (for
hwmon functionality). The misc and hwmon drivers could then communicate
with the core using regmap.

drivers/mailbox/ supports mailbox style communication. I don't know if that
would apply to the mailbox functionality implemented here.

Guenter

> 3. Define an ioctl for user-space to access other system management functionality.
> 
>     a. The open-sourced https://github.com/amd/esmi_oob_library will continue to provide user space programmable API
> 
> Regards,
> 
> naveenk
> 
>>
>> Guenter
>>


