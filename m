Return-Path: <linux-kernel+bounces-332827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9712497BF52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A5B2824AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421071C9868;
	Wed, 18 Sep 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K04gp4L2"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472F210EC;
	Wed, 18 Sep 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678394; cv=none; b=BjQZUiRfYOJDIupw3IZ+u62nd85Wh9Lor6RRTuo+m1hKZGSAqowvL6PMK9amNCCbAdRYYmhpOw9b+b/Nd4lpfAI8iIE5T6qrPwh1RXGFdfIbkmTHqGK2tcS9m3bFr9RMNVQnrRbBcHmKHtwT/SymFuT3s7P6iHqQrwFHHl5/EDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678394; c=relaxed/simple;
	bh=5dAxKzkDyGuXMmBNEdKWUyh9xQq1sdPJBz4J+tT5EWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8nYdC1rTIgU9c5shPCmqbCX6NtOjyKkXgw0cm/LPVoQK3TeO6WalwNeFjObSeXZ1Hk0GuEIPrJDCEiVW8jGPOM02mEB5PZYwzOgFcT5FS0uLu7b6leFMPJDCYwINvwk41ryfhCOhFFNs/3BkYca1j2liUjqNGp9FHYHQJ4nlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K04gp4L2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2db85775c43so816910a91.0;
        Wed, 18 Sep 2024 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726678392; x=1727283192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TwVG27iWjhMbbo2rXogcr5hiQ868jFDOAxTn8sf+ht8=;
        b=K04gp4L24mz77ICGQ3pTsaKVCN/YX4frs5c8vFKrR4UM5rsZUGikvts1xVKdyIeXgr
         OzI3Zp3ZUVcuhDkAf1VqskWKLb2A+PS5gvuFuxplbYXb/t7eCsOyX+1+QRpGxZ70MlSQ
         Us/hOe9qI5q69dLfOXV7SciB+KH9YMVOhvDzhg3xXkMkhV5g8QtOSewH31XdcASLvzH8
         BoEACazdyvMUUcf70Kp11NpqDSlwUeV5eqQPVDujMrAt+I6hy+e26qve4MMHNNUI5YF3
         ocYlGnGvPB+uHxCia39bIiErLr4ABHkLLTMWXom+dr4X94h7oF/PP3vfy2pBSKMNxFBX
         kFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726678392; x=1727283192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwVG27iWjhMbbo2rXogcr5hiQ868jFDOAxTn8sf+ht8=;
        b=Is8XYhs2aPih+oslVjFeQ4W6TuRCKVA71tfbtsi5x1tdy8inbzMrkYl3cVVz5/04mU
         JZGT3qTb0zjjc5njya+JOtgTziRVngR82IWVKHAq3qZSJXzf7nQbHYpfN3T8SE5mpPyi
         7ptn27NfpRPBl5CWHOfkRs0U5C6hG+9blDHX41ZQ2mEnOn26KS4Vfa607VQB+UIXSq0X
         XgPi8M+LbD/XbsJvrbOgh565vmYI0EzzMunpLU7y4eUi0pBkFUv6uWcSybMSCVv22MKu
         3ufLi7gUnFW+bRA371Wi4D33NDG5h8w2M/OV0HmhGlTlY/BwqUnYRjaXMLoQvUTb7+uN
         zdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOSyllekYB3kTJz+pOgjgs+d3U5DFMDstOw7idJtaWDSdCbYZO+iEEeGiNcGT+1Ev12rP0Vs7vpZYv@vger.kernel.org, AJvYcCXXzMn1aruLuchaNk3arqEOUJ9JX9oWAR2k8W+bzEXbTMi0Av2ge6Y/8TxmAcN+VwigmKd25fi0qkqvFQtD@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiQRgvChc96YmODH8opwb3BLr/Y26xXJsqQoBPQIyA8rTEUFf
	bMrf25VQxENzbC1Ml0Oik3rDcHp1onXz6xLSDC2chExseYXZ4D+T
X-Google-Smtp-Source: AGHT+IESeiykBWoBfHRj3NaZN3SuHuAvzzhhGH7qh4VssYv7fmnVXVd/X4/EWjz9DQQv7UGoDuV0Mg==
X-Received: by 2002:a17:90a:7345:b0:2d8:8a3a:7b88 with SMTP id 98e67ed59e1d1-2dd6cdfaefcmr427948a91.6.1726678391880;
        Wed, 18 Sep 2024 09:53:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd608e5e5esm1895404a91.33.2024.09.18.09.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 09:53:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f76798ea-6edd-4888-8057-c09aaed88f25@roeck-us.net>
Date: Wed, 18 Sep 2024 09:53:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: support pmbus
 compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Noah Wang <noahwang.wang@outlook.com>, Peter Yin
 <peteryin.openbmc@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
 <20240918095438.1345886-2-Delphine_CC_Chiu@wiwynn.com>
 <e94f03a9-92e1-47d5-aa36-fc51216436c9@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e94f03a9-92e1-47d5-aa36-fc51216436c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/24 06:03, Krzysztof Kozlowski wrote:
> On 18/09/2024 11:54, Delphine CC Chiu wrote:
>> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>>
>> Add pmbus compatibale string for the Generic PMbus devices that could
>> be monitor by pmbus driver.
>>
> 
> You need to explain more, provide background why we would like to accept
> a generic compatible. And why a specific compatible cannot or should not
> be used...
> 
> In general this is a no, you cannot have such compatibles for real hardware.
> 

Agreed; affected chips should be listed explicitly in drivers/hwmon/pmbus/pmbus.c.

Guenter



