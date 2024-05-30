Return-Path: <linux-kernel+bounces-195455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F5F8D4D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A311F233EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366B186E43;
	Thu, 30 May 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnYrqCeS"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F99186E39;
	Thu, 30 May 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076842; cv=none; b=e4AI05/gChsB/QH/8HKAhIjXHDG6R1WUBQKafIp9ASYkNF9AXRYA8w3eumHal36ifV9K4Nu2QamlQvydNNPBa/raaY25xsiEmno5OMM+o6SkDsMNeZV7mUEHVsq4eZjMM0hHzK9BD1RRJ089pOfa910JPrbSqzwrHWycOuVY95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076842; c=relaxed/simple;
	bh=O4VsPxdPPfUE2QtTJEr3JV8cbNDj6ySWY4aPqGucduw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ6UQuk+tefx9BUnU2KONQbauc4hDLSEeTceqSGOoLXySa4wAJB7q8irL17iB16dPc5odyQ/2C66M8WVCPGktwGjYaOjkBnRPzIVlqGcvMx9N+IhJLoVz/P/BGUtkNY4OPa3FssO/isJqU5svZ2MNA+nt1nph+9sDarK1+oCnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnYrqCeS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f6a045d476so744360b3a.1;
        Thu, 30 May 2024 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717076840; x=1717681640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xrkxAFubP+0WccFvUDQf1RnYXWdHNVCXaJt6PF37RXE=;
        b=TnYrqCeS9R3XzN1KOITT2KQf7l7aFJh9EMj5aGrYi1cgHEG3xslOJc4t4NDqIJoyii
         OgUOtkdyEv3HNtISjjfj7TkAvj+2EIxVreImjgDpQfOM+e647/bHcseWMfpLKVL/m1DF
         qFjENPsLdC4ZqKRAXVCROvI3g4GsfzbHz/WXPQc8bb6UXgJEyZYot+Mjm9k0xXRj+b7w
         nF3/4AnI7SDl3eSJzMGtobvHB9/dMr2sJA/W+/Ih/VDIJHw1lMINR/ovqnHFTZGaDxMU
         7KuTSehXC89RFe4phnu7TQ6pLWmb99gCmAoX6pZpAaA6cH/O/XdFGkW2wbl5T41q4q7U
         kjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076840; x=1717681640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrkxAFubP+0WccFvUDQf1RnYXWdHNVCXaJt6PF37RXE=;
        b=Od577NjseVwbtQmFV3YPaHOWiiOKQg+76tFlBeVd5MOBl4H7y1X6YFmfLgmowYXR72
         OSXM969BEIL2ssWHQZcpTEdaUSWnZTkV1RgskqavHVa7W98ycaZEUgvEUs5bM4pJ41i9
         nPQtBIMXD7CiPODpuQnAnf7AxtJmQEr/NEl5tOV53EAgDlTUkkn2OWK1zVi9QLaDdbV+
         DPfxq3L14i/LIP+lvHvkHSnPEC8+hiMQD2KpQxa26OnDaDyAIWKewunpbeYsccEiINUa
         W2ZiL7QNIC1eLeRP72d86K19yrlJIOszqL5TJ1s57/VACexdGEzNoqRe8z77nctjqi4H
         lnUg==
X-Forwarded-Encrypted: i=1; AJvYcCWVxYrU8qmL4BgBk2yfIjNPu9VkLkMy8I5rZqMP1b4WtaIRBYe8nSUbezgxPj7c5r6gPOU7nX0LFIIBM2sfJlErAm+wUQ2j+v3a+Jh1+0pFPstOGavJLr+uptGXH7/2qQ63p9X+NIQsCQ==
X-Gm-Message-State: AOJu0YzgWFO8B0N6+SwCvMDhWyYvm80Ag3hqOTBK0jIIuNfa82n80e1A
	W/VGwRlSHYYVmogAFXt4ywCymxIxWKeZ60AC0prU2FNPGz4Oh4lk
X-Google-Smtp-Source: AGHT+IFYXpYxHAusC0SILMElYMSTPOSI/iHOb8GQdNVdkNgiga9MEZWRKzYQDsBn5EUBMESOvQzmWw==
X-Received: by 2002:a05:6a00:4293:b0:6f4:7606:aa85 with SMTP id d2e1a72fcca58-702313db6bfmr2689575b3a.32.1717076840027;
        Thu, 30 May 2024 06:47:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7023070ed32sm1283949b3a.42.2024.05.30.06.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:47:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9c7e050b-0e73-4388-bc58-5c4d3ed4f50a@roeck-us.net>
Date: Thu, 30 May 2024 06:47:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <6d5c2ee5-6e0e-4d13-a977-493d2ee2c0ed@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6d5c2ee5-6e0e-4d13-a977-493d2ee2c0ed@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 03:51, Thomas Weißschuh wrote:
> On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
>> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
>> sensors. Such sensors are typically found on DDR5 memory modules.
>>
>> Cc: René Rebe <rene@exactcode.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Tested on MAG B650 TOMAHAWK WIFI with CMH32GX5M2B6000Z30
>> (Corsair Venegance DDR5).
>>
>> René: I included you as MODULE_AUTHOR since the patch is derived from
>>        your driver. Please let me know if you prefer not to be listed as
>>        author.
>>
>>   Documentation/hwmon/index.rst   |   1 +
>>   Documentation/hwmon/spd5118.rst |  60 ++++
>>   drivers/hwmon/Kconfig           |  12 +
>>   drivers/hwmon/Makefile          |   1 +
>>   drivers/hwmon/spd5118.c         | 482 ++++++++++++++++++++++++++++++++
>>   5 files changed, 556 insertions(+)
>>   create mode 100644 Documentation/hwmon/spd5118.rst
>>   create mode 100644 drivers/hwmon/spd5118.c
> 
> With the Makefile and detect callback fixed:
> 
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Tested-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks a lot for the feedback!

If it is not too much trouble, could you send me a register dump ?
The one I have is from Montage Technology M88SPD5118, and I'd like to get
a few more to improve my module test script.

Thanks,
Guenter


