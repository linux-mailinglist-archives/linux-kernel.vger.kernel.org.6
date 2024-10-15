Return-Path: <linux-kernel+bounces-365984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0641999EF00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72911F225F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20181C4A12;
	Tue, 15 Oct 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPtphILJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01031C07D5;
	Tue, 15 Oct 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001455; cv=none; b=s87wvpcpfzz82ckMjYR1qyDIDx0eCF0GhLSDjvhVbZ0JCjoM67cz6hU6wsUB3fTcyhK0zTNUkhM/7Sqbpz4HxORSfHsl57sO6A9ElMEh5w/d9YelkuZ+TOUhAJfvL8pu05hP/jbSaaIjlizOr59uZDvUgPeQz7nyFsAy/1kAgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001455; c=relaxed/simple;
	bh=4ilgM/XgrMYplYtg0dFd5RFUXbCho10fI62JZ9/QqAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ocPdxhmoDT3HolH3YFPktXRmPiAP7sdMv15vFjPBIzpVro2PmvshaIu7xNovKvZTvr2IFEmaMpLb4hfPzr5XRtLxoaIDgJ9eJv2/s7A0WsaqpqFndh0oM0euCu9raYhXYEMqxVmsZF2i62AR3ta2VpQO9vhH5Di1Qz9+1f+sudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPtphILJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdb889222so22205775ad.3;
        Tue, 15 Oct 2024 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001453; x=1729606253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Schv5VB6tTanv9Tkkt6eqPig+ccww5N0g+oEIu4mf54=;
        b=HPtphILJnCeyHxG+fN7XQjOukyEXh3YujFCDG9SGNvA2fDypRz//MWTY9+QKIbqB0P
         xLtjzHiRKGmNRMXydEDfxJZEBHPXGP5SQ8E/zHtuwbdZSSbX1UN/ZGjT1MbxsZ8oBtSf
         Tdde7CLc1LOL1HjNb2PqbGKw+FQHJca0UbBgt2XauVkoCD5Ygyeq8SVu8SPGzBA4lMVY
         hoh68zsm4+VDBJjMTJV3ZOc65bWsrVzsfULPHNIsjB/AClnouoKaZKQsa6fVhdQLudv7
         TX4C5ona/m5RxcswhbwfPKZLaX3dbpjBriwaZfdM3BfOVckYHaYS5LXQvDqlVRO6TI4d
         uQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001453; x=1729606253;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Schv5VB6tTanv9Tkkt6eqPig+ccww5N0g+oEIu4mf54=;
        b=TI9H7/LWiyHRou/R0DiywGxQfm2riQLUihTkTnwVQ2/iqoGCrI8x565ZgciQLRDRnR
         yIh3K6OX0rFZAtqqehKLCvM2rZjZ4Axkyi1GGw68qv42fL7sKRQRztJU6ttx/GOoI5fo
         i7mmfKfOySITcFJgX59LDHuJYjjn2azAwFt9DZQlG30uH21RFJoH85KcpEFh0wXYAn7V
         /oPc/1g6yPxqoebb2l0y8dSQ8JeRThgiCPW/dr5txanN2LvxCZAi7j+R/X2anorR9uhL
         LQB8Hu3JweDtqFDsrcj1Vq8+8tNtfMDmV6ckjP/q5gYqCs0TP0NxzqEJtwxnwYVF6MLY
         h05w==
X-Forwarded-Encrypted: i=1; AJvYcCUE4gJLc2WIN93sFa6q67vSnLv4wPNbjJXhURCUTV5xuklpbTBeEZhlbvNg2BICDD77CsnmgP9tfhVg@vger.kernel.org, AJvYcCV4wY7tnz/Yv7/1NB8yQedOFcuBlGUGW+uLMVntsVoSCKHtRTM6R4eJ8dwSOiDYfTBiLKd9H1L78o/1piI=@vger.kernel.org, AJvYcCVWjSWJpYUCR8BWvxinyEM7oiGVU/gn9UGWXtjeVmvAObwu2sIr6P5+mGGjV9oz7sZR+9PgB+p4p/MBZMdI@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7ekzT8C8+nr68ey8U8mBioTHtkIoAojhQM0///XiHRDxwY2l
	T2SvM6JlrzVlQZLCVok0OFeaFfNpdjCbxBe/GpKr3QE93U/Y/mOp
X-Google-Smtp-Source: AGHT+IFeY1RiaYBz6I6wopnkI+z8bFuqMYJgX7uRLVyCXWyiyfQDtZMKCAd+OIRb3jDr7kWQBEWfvA==
X-Received: by 2002:a17:902:e805:b0:20c:7eaf:8945 with SMTP id d9443c01a7336-20ca14601b3mr227905945ad.28.1729001452814;
        Tue, 15 Oct 2024 07:10:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1803625dsm12388695ad.121.2024.10.15.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:10:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <30089bac-e764-45ca-b0fd-f0eb0333e632@roeck-us.net>
Date: Tue, 15 Oct 2024 07:10:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: pmbus: pli209bc: Add bindings
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sylvester Bauer <sylv@sylv.io>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015113329.667831-1-naresh.solanki@9elements.com>
 <20241015113329.667831-2-naresh.solanki@9elements.com>
 <c07435f5-af3f-46e2-8e4d-b0a42969b60a@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c07435f5-af3f-46e2-8e4d-b0a42969b60a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 04:48, Krzysztof Kozlowski wrote:
> On 15/10/2024 13:33, Naresh Solanki wrote:
>> Add bindings for Vicor pli1209bc.
>> It a Digital Supervisor with Isolation for use with BCM Bus Converter
>> Modules.
>>
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>> ---
>>   .../bindings/hwmon/pmbus/vicor,pli1209bc.yaml | 65 +++++++++++++++++++
> 
> This has to be squashed with previous patch.
> 

Neither me nor the hwmon mailing list was copied on that previous patch
(or on an intro patch if there was one), so I have no idea what this
is about.

Guenter


