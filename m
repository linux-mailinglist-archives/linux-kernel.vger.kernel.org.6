Return-Path: <linux-kernel+bounces-325322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93319757D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D4B28D744
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11C19CC15;
	Wed, 11 Sep 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ+dVKZz"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D573EA76;
	Wed, 11 Sep 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070557; cv=none; b=eUVJnCu2vc4ySmkfdAEkMhWz7anijKrFNbL/u/wfg4jyBlIKD18g3Pcr2U/JYkhQ9hivEMJ1MOmTswn+7ao10dNnAZR7/n7VdAfirsn75GRAbfOh6B8a8bpphJFuzAI3BO39xW8lv/46fKO7yIzed3O3LNfuRPDX1DhGnF7gY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070557; c=relaxed/simple;
	bh=r6QvD9FhdepOvEr/WYVOCreI6UHgbVKov3rOcox8K/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv7ce8524yQqViuZBZLCuonD3A3Ny/3QmBGvnkuSVuHMd2ojocQljAc/+RaNAsGlngPYPyWSG1t//Xl7TDtBlh7k0FUB+xA7V1Ozyc0SGE85xPk87FfMqUC/skGbWvtUr/40YmacM6WSAUmPXhp4Yq0ATiTdRg+POiIxxeh+4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ+dVKZz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20551e2f1f8so185635ad.2;
        Wed, 11 Sep 2024 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070555; x=1726675355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Z0fJcZaNKVfL/yQSd38wTgSdKg5EJ3kwsSWPUkjqWI=;
        b=XQ+dVKZzN6WXgMnPrIJQn90OkDcK9TFJS7Ydbk40/RUSTdZgaksqZSSSmHmz+c4m7P
         Zol++4QypuKKl++CpNCunQQ9Xh3ExmKaFuGHj6bdB42Z5lAmIKeBdO38W7l95+i3JsDh
         yJHhqRH0ZreyG4rB/fyzwXumb3YdjBTbHtKV8+rCOszv4nmc4cmM2IIv7+czvGbpKTI8
         6ONDQp9ylbVx0hNf/NcmnhTa1OrztY9toHtieJ7QtsMgmbDa9rPeLa3O8ByNuPqNfSzU
         OubuTs3KKX3mYinmMvhfFZ81PNZDPAMXDAM/K6RaMHH4ip44FquqI5Aswb6tehoakIGW
         67Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070555; x=1726675355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z0fJcZaNKVfL/yQSd38wTgSdKg5EJ3kwsSWPUkjqWI=;
        b=HymMC9j56KeRO+l1zEgTIo/20cTILGGKe6g6Z7mVWW2fWMDzNYhAQ3/HTV2XBTZ/g8
         L5ZAu3faa4r2QDkroRCbWTiEP8zPH9yBG/BFw926PRLKR3KvRW86XUphhfGBhDRPnqnr
         lxOOXlWItQyCZIgvVmYh6o58P27IBj47z0/lEaBwN3yVl8mMELgHJbsgGlESFnKXDuoY
         rpTvhQ/O4PKEOn7bFOfOjGxY4XooSplcWSG2h6/3MJJtvuKxYoDDbQt8SVG4EG6Y86Cm
         bO+ajxKoqy6h31nGC23ygorPHxPW03A2OdfSGdtaKTYXmPR+Ht0j7+3LnKtdv/E0JxYP
         Nbyg==
X-Forwarded-Encrypted: i=1; AJvYcCUH/6Ay0z/TH/5rOrobLSVS/JhrrZ0Xk9oXYrrOwgaJJTGP7Qr4t9/sV0XOV8cBhsxH9CMCW39SLsp6Zsmo@vger.kernel.org, AJvYcCXWMUbPKTry2HnQhx3JaU6Oraab3vXxSAuVDJjuk5GSdIMPvTuieEBmzzHPdUenRR9HNrrbIJbJ0aPtak11IOE=@vger.kernel.org, AJvYcCXYXcMkN5Ne0ou/+yb9YeDWVsUbbyWecGpy1IgxhkZ8DVr2GMNqrWHrH6ayYUyvW9m+vbjgOYSfL7jz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfj9wIox5BFLKOgoP5Z6uK8/Fg9PeZLguGorY7uzEYzC/6uZR4
	xVjsJYaNBVCMOto6qX20C/FvE4qoLwFGFBMOZwk1eg87p9d8FvOP
X-Google-Smtp-Source: AGHT+IGZA2nrfaml+dTZzjUl09CuZgnx91GaM4wHlkcWfHL3Y2AjUxvNpFV+qA7OepeOAbrY+ZUjvQ==
X-Received: by 2002:a17:902:c946:b0:205:7f87:ba3e with SMTP id d9443c01a7336-2074c5e4cf2mr73320825ad.13.1726070554257;
        Wed, 11 Sep 2024 09:02:34 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af252e2sm1398935ad.6.2024.09.11.09.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:02:33 -0700 (PDT)
Message-ID: <ecd1fff8-9c15-496a-982f-36e6c58e906a@gmail.com>
Date: Wed, 11 Sep 2024 21:32:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] mikrobus: Add mikrobus driver
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ayush Singh <ayush@beagleboard.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-3-3ded4dc879e7@beagleboard.org>
 <2024091144-glitzy-kindly-fa74@gregkh>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2024091144-glitzy-kindly-fa74@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 20:27, Greg Kroah-Hartman wrote:

> On Wed, Sep 11, 2024 at 07:57:20PM +0530, Ayush Singh wrote:
>> A simple platform driver for now that does nothing. This is required
>> because without a platform driver, the mikrobus_gpio0 nexus node cannot
>> be used.
>>
>> In future, this driver will also allow for dynamic board detection using
>> 1-wire eeprom in new mikrobus boards.
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   MAINTAINERS              |  1 +
>>   drivers/misc/Kconfig     | 17 +++++++++++++++++
>>   drivers/misc/Makefile    |  1 +
>>   drivers/misc/mikrobus.rs | 32 ++++++++++++++++++++++++++++++++
>>   4 files changed, 51 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0cc27446b18a..d0c18bd7b558 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15433,6 +15433,7 @@ MIKROBUS CONNECTOR
>>   M:	Ayush Singh <ayush@beagleboard.org>
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>> +F:	drivers/misc/mikrobus.rs
>>   
>>   MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>>   M:	Luka Kovacic <luka.kovacic@sartura.hr>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 3fe7e2a9bd29..30defb522e98 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -610,6 +610,23 @@ config MARVELL_CN10K_DPI
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called mrvl_cn10k_dpi.
>>   
>> +menuconfig MIKROBUS
>> +	tristate "Module for instantiating devices on mikroBUS ports"
>> +	help
>> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
>> +	  board socket standard that offers maximum expandability with
>> +	  the smallest number of pins. The mikroBUS driver instantiates
>> +	  devices on a mikroBUS port described by identifying data present
>> +	  in an add-on board resident EEPROM, more details on the mikroBUS
>> +	  driver support and discussion can be found in this eLinux wiki :
>> +	  elinux.org/Mikrobus
> So you want to be a bus?  Or just a single driver?  I'm confused, what
> exactly is this supposed to do?
>
> If a bus, great, let's tie into the proper driver core bus code, don't
> "open code" all of that, as that's just going to make things messier and
> harder to work overall in the end.
>
> If a single driver, why is it called "bus"?  :)
>
> thanks,
>
> greg k-h


Well, mikroBUS [0] is the name of the socket standard. It is basically a 
group of following pins:

Analog - AN
Reset - RST
SPI Chip Select - CS
SPI Clock - SCK
SPI Master Input Slave Output - MISO
SPI Master Output Slave Input - MOSI
VCC-3.3V power - +3.3V
Reference Ground - GND
PWM - PWM output
INT - Hardware Interrupt
RX - UART Receive
TX - UART Transmit
SCL - I2C Clock
SDA - I2C Data
+5V - VCC-5V power
GND - Reference Ground


I do not think it would qualify as as a "bus" in the Linux driver sense. 
Especially with the devicetree based approach here which applies overlay 
directly to the actual uart/i2c/spi controllers and basically not 
interact with the mikroBUS node much.


The driver is here to enable the following:

1. Enable dynamic board detection using 1-wire eeprom on some addon boards.

2. Provide sysfs entry for runtime board adding/removal

3. Enable using mikrobus connector node as nexus node for GPIO (not 
having a platform driver makes any driver trying to use the connector as 
nexus node go into deffered probing state).


For this patch series, the driver is mostly here due to point 3. 
Basically a stub.


[0]: https://www.mikroe.com/mikrobus

Ayush Singh


