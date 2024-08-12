Return-Path: <linux-kernel+bounces-283702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BD94F7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C932CB21C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8588D19307E;
	Mon, 12 Aug 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZOQ0OM6"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDA18E772;
	Mon, 12 Aug 2024 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493343; cv=none; b=teBB9geEVc1DXb0DT+3Ubc+JmIos4Kygk97JGjogGc3/5oVhKee1cAOBLPN881qg0k8+8m7mYTRHxpgZC5SNwWhZuRJXlwKIdduFxqQ9cDKPscrN9PQaJYSNdje2d4UV5FOft2nA54lpF7u4nNPlp+Lsiab4hoJSliI1/QuGrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493343; c=relaxed/simple;
	bh=kAnT8rvYPFb9ndqkF8CiDT514Qu20MeT+fA0t6e+k3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwrVUpvGn42YwGEPMU1lfMcAxMm1egfPHEvFB5vZzPuySa1MPjRVoPt9HcdRuNZeyZtCJw1yS2HlG+vJcufFzIKrKtUDTg6cylUZQ2eMnbZSN+l2eSWPYsYbgkWvS8eB8pDVAjH7vT+JV+yhvuBaLCcZxEaTcqeEd/t5x7BsRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZOQ0OM6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fed72d23a7so35496345ad.1;
        Mon, 12 Aug 2024 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723493341; x=1724098141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TwXK7FLlKlrHoiGjKfSH5lAqOjXzMk5L4tpGx9rdWLs=;
        b=PZOQ0OM6qwh1Em52YN6P8dLpgl1yxzJN8JDe9tWw1uN7JM8bhiLMO+SzVrzpiGYAva
         iP45O0o7QWXumIKaBXzJhZSk/it9joJkxnFsi7xE1hedDNXOrDN7lZ0eFOHqpcSvPj3a
         XL3tXUAZSNsfnIkotn3te6CpJsWBaEUYsnxRPQttb4pPtPYbTS73s7XkPMdlsHzT8qrv
         wFTtGGE7tOsw8X83iMC+bhGLQ7ucE4QqyyfJdtNVQoStLbFoCfr3FJTD80pGcwlmQiwV
         IlABaLmxsc+mDdSlG8X1fzzTGpHJ8dQ/UVwLCB/mD8K7Xjpj2bYkXmWruWpFtBTEx1F9
         EwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493341; x=1724098141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwXK7FLlKlrHoiGjKfSH5lAqOjXzMk5L4tpGx9rdWLs=;
        b=D1dss9Igu5l/RoorHWRzvD5BtuE+0Nag2spPRCgg/9wLSgjBKIlFL+Cnh1onIud5Ll
         XCFqSRxj4sfRUh/VKh0ZrDhqgJj3ePHDTNtZf2Wh8mF/Rn/yJaaNRAYzM1QR6CHmrMR5
         bVNi2fE6sTiT9w3xVU6WD+FYqeClZAyX42I+OeluK3YD1jvwg5RMuc54rBkf1nFFoVSA
         s4t5DEPGp8bs8TMZMCOZldFOauj2c1D+R4OIi1pCQhdERkdadZ6yQ/PeYbeiiJajr3r4
         ZIRMki/KnD8gWvMeec7xFbGVDdEPbJDhupih2SxznjXBjyrx6o0ifLctP+8KgHsobj4N
         kNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXKujQY100zXZT123ePbE3vpIOk3GAtlzUdm0dKnHZR8eFB41rcpHJpJJI8CsSOvt2ZvTR3lgmoZ6sNh4xxI/A1OgLM0oZjhQ4HGbQG
X-Gm-Message-State: AOJu0Yy6r1YpC15S5J6Th+EhrVtIesgXVnTWWf0VtjqOI/OcxCnaK4Yf
	vvJIzz6FH8EFV2HvZ5vLLBq1pvDWwW+TGHM20pccGFIAihCXW7d4PhqXIQ==
X-Google-Smtp-Source: AGHT+IHjj8o+1aWgpl5+MqGp5lOoFEa7lSp22u2UFWKwCem2sLPITMPVEzq+5dnIU7ydeW0jQGT8tw==
X-Received: by 2002:a17:902:fa4e:b0:1fb:72b4:8775 with SMTP id d9443c01a7336-201ca1c2602mr14550175ad.40.1723493341275;
        Mon, 12 Aug 2024 13:09:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9403sm713835ad.151.2024.08.12.13.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 13:09:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eefbeda1-8c09-4b57-83dc-30be9966de2b@roeck-us.net>
Date: Mon, 12 Aug 2024 13:08:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: chipcap2: disable sensor if request ready irq
 fails
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
 <20240812-chipcap2-probe-improvements-v1-2-3cdff6d16897@gmail.com>
 <9b4f88e8-5fc6-4c4a-b89c-7f96675e81ac@roeck-us.net>
 <9659c699-1ce4-4b74-b697-83d926d80b35@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9659c699-1ce4-4b74-b697-83d926d80b35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 12:59, Javier Carrasco wrote:
> On 12/08/2024 18:49, Guenter Roeck wrote:
>> On 8/12/24 08:43, Javier Carrasco wrote:
>>> This check is carried out after getting the regulator, and the device
>>> can be disabled if an error occurs.
>>>
>>
>> I do not see a possible path for a call to cc2_enable() at this point,
>> meaning the regulator won't ever be enabled. Please provide a better
>> explanation why this patch would be necessary.
>>
>> Guenter
>>
> 
> Hi Guenter,
> 
> this patch enforces the state where the dedicated regulator is disabled,
> no matter what the history of the regulator was. If a previous
> regulator_disable() failed, it would still be desirable that the
> regulator gets disabled the next time the driver is probed (i.e. a new
> attempt to disable it on failure).
> cc2_disable() checks first if the regulator is enabled to avoid any
> imbalance.
> 

That is very theoretic. Sorry, I am not going to accept this patch.

Guenter


