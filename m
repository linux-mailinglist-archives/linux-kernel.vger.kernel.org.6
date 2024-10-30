Return-Path: <linux-kernel+bounces-388979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1759B66E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0AEB24014
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A921F80A0;
	Wed, 30 Oct 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLpx3BRu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EE1F4FA8;
	Wed, 30 Oct 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300580; cv=none; b=VzMNp1h45GHNvRnpjdALTR5zucUjDW3/HXgEDPQy5C3qgh4QV8d3JObjot64moyfRAPSA/evmg0euOCo/1C7/ytA/kHsujgbpACqx/kWDQxlABIzEzvHrbyLsMhKcL70IConihMmGniRF6eBxC9/g32kjUSkCho4THrOa8aknpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300580; c=relaxed/simple;
	bh=vwtgccB7FGWGz25PUGScEkFA45oRKl5HCNKi0pd5liA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+s5BG0ZsH2ehcONR+dJ6kG2alMkRxIufDzPUjRYoB8sOhG6wtqdWhWgoriaiqXezF2hLzzeIU0ouo08Y2ApRgs9StlKJu2ve+y5WEt1ZPQOjimfJuR4xGjpyjxP31yMLucZsMBrCj0+CM05gljc8XRXtRugCVU2n42P79+Rg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLpx3BRu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso4708455b3a.3;
        Wed, 30 Oct 2024 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300578; x=1730905378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PmKgwR+LdwuK0RxQ8YvMV5Ly4zqIVxv2OMzb7E5lgEo=;
        b=DLpx3BRuow4Js6gRWGgBNyCBP7tOIiyXKwL96Sgj3RfaYJVNn+V8ZtiLNDXK9FBnlp
         k2pFx6E9pSaHPyg1jkoy19sScTD9YWBvETOpl+U5bJut+eWlPLyz249nTQbd+qSrQJET
         bEkorJzQIlQJipRCKvZleLNb9RQzZb0+NJ2L/LSKKcd1wKu5FD0aqspCbSCpKS27jz6n
         x7v8nSUqqefpbQZE6hkk9ZQrgoZs0EOBOtK4JHoOOzLzLcGHxmYcBI/pORwgFGSnDutd
         64BXZzljljwmvvPxzYkg2i951APCqN8ith8EnaoSV6yg86fYCP60c1QDS0wpm5tuVcH4
         b7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300578; x=1730905378;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmKgwR+LdwuK0RxQ8YvMV5Ly4zqIVxv2OMzb7E5lgEo=;
        b=g4jDAMiePKi2qhXZhB1ppiNDVLEOTJfN3YCWj7kE3HvrtuTnZo9eZeH4MIRejjSDAl
         XqKbFgKgyhoTj3KX6Jsi6b4D6Erf66EmtCq/NKd+RwDxKKJY9OzZKEycbWyzsj29EN6K
         w7qwWvkRN5jGxffPmt2LYL1rgu203xfCFXopQn5Qu38Df0p56gp6SNM3Kzz1SSKPByAY
         HEc6HRQhmKzuasgDTgaNoD404AjnLJTpP1koluZOqsjsnJ8F8Q4LI2BVUBzdX6vwaaQY
         0no+/X8ZtJWa9ne0B6Q7kjskmPfqzfVo4gcThuU69chdslz4hrRkUkrmobf3xXkISRW0
         dHZw==
X-Forwarded-Encrypted: i=1; AJvYcCUBKludhLFT4goZLkWjIzBif1nJfUsV3o0/wMSmN1gyxhkCj0MKZu945dL+/SSpZntQcOrSletrfc0a@vger.kernel.org, AJvYcCUa2729H9e62rMr3kKlvoBRxTxy58OgGP9iZlnRpbypFPcuj6N4eQFa8VXx62ecgml39X/Sw6iZv5QAgoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTk08geJLlZU5kiYuUzYJRW7Y2+0ROqHbx9vHCGHOhUtBpc4W
	OrI7Cat81ahzcnzC8qG3sMCwenRul8cO9Zy3oPhXeE3HPZ0iUFDO
X-Google-Smtp-Source: AGHT+IGZc0jedsqhBEQS2ZKpKd15C0NSSXsroPkxzIz9wIvlOZOoNV13GUf37ZbaOLkzYZWkwpflCA==
X-Received: by 2002:a05:6a00:3cd1:b0:71e:1b6d:5a94 with SMTP id d2e1a72fcca58-72062f4c06bmr18971825b3a.5.1730300577924;
        Wed, 30 Oct 2024 08:02:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0bc94sm9322711b3a.119.2024.10.30.08.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 08:02:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a68babc-b4f5-42f2-bc93-ce8f1b7a14e1@roeck-us.net>
Date: Wed, 30 Oct 2024 08:02:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on
 shutdown
To: Akinobu Mita <akinobu.mita@gmail.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-2-akinobu.mita@gmail.com>
 <OSQPR06MB72524578F1E5BA93772A12728B4B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <CAC5umyjtCaYPjtgDnJ69c87w825MFSHgm92JA1kWORwP4Hdjww@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAC5umyjtCaYPjtgDnJ69c87w825MFSHgm92JA1kWORwP4Hdjww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/24 07:55, Akinobu Mita wrote:
> 2024年10月29日(火) 11:35 Billy Tsai <billy_tsai@aspeedtech.com>:
>>
>>> This adds an optional property "retain-state-shutdown" as requested by
>>> Billy Tsai.
>>
>>> Billy said:
>>>   "Our platform is BMC that will use a PWM-FAN driver to control the fan
>>>   on the managed host. In our case, we do not want to stop the fan when
>>>   the BMC is reboot, which may cause the temperature of the managed host
>>>   not to be lowered."
>>
>> I confirmed that it works properly.
>>
>> Reviewed-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> Tested-by: Billy Tsai <billy_tsai@aspeedtech.com>
> 
> Thank you very much for testing.
> However, I plan to change this option to device attribute
> (/sys/class/hwmon/hwmonX/retain-state-shutdown) instead of the device tree.


No, I won't acccept that.

Guenter


