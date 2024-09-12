Return-Path: <linux-kernel+bounces-326608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D555976AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ED01F24D97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9ED1A262F;
	Thu, 12 Sep 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="A4RXjX5q"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8019F42E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147980; cv=none; b=nehflbY0JYIDA3DkoF8ef2zmu08KAACGUn0Bzmn3GX13LU17pF0ya2mBj4zxYM0Purcq9kU6HqX2Ecb5X7/eUu+IdNFqjJ5S02qlDB8orVa03pwYnQfGnQKj92IIjSf8mPr6WHPaHD572rgDKWZ/79USmOmB31kX0lV70RMkH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147980; c=relaxed/simple;
	bh=y4JXK2nQ+yYVmIJ0dkBzHHepqbMO63NpftfrisvUxuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1B+QzJlS2zrGFFfGOoV06ntaVtBKsbDmQtVCE6FRvpS50BC9S3in90k1gyllvHc079elHhCUOQsPTaT3ti1mcgVUNb7X/W/geZ3ifwtQkswqfuSfcKMuEhQRx4k2WX3nayy4vdjbwz+ZZoe5cKL9AHyzZkzndMLivXoQ0BDThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=A4RXjX5q; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-718da0821cbso742294b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726147978; x=1726752778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSCLXgKSR/O6qPpMsarYrPyYwmGaU1cMe+1bP08dBzY=;
        b=A4RXjX5qHHTYU0yfMFtHtU0/aV0MER28weS4K983LJmrOhYkJaEalq8WfD2SB1UGEn
         6rzyod7i552ZiAb0cFiP92rz+pX8NWlTrsYdHC7dtCRQrPAZgEPExJvm9u8ttERd1h+g
         LyEerUKZRj2jX2cOT8t1GrcKrKtBcjMcnBsbVjfZh375RtPq/Yday5S/4270X6Yo9uvV
         9EP21JkAhU7/qRD6KwOpouTnbrl03irMnvRUhnGwFiIha/NurWyeW+wC4cogYzfefq6B
         6ebdKGdRcYBroOSE3O/mrsBC0Az8gQ3/hyIGAmVwe7J8SGb+OtKf02D1xzJ9Sg5qZxS0
         6BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147978; x=1726752778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSCLXgKSR/O6qPpMsarYrPyYwmGaU1cMe+1bP08dBzY=;
        b=JDE/aaW+nu0wxYUL+Ir9CA+Ym5BpFU97oZ+5DkMT+jvmn3jqkvF14Tr6RGb4im2Kp9
         Hm1oD1YdvkBQ6aPu0rKCBt5wxYJBqp8YnIPhM/t2Clsp/p4BN0wilDpKrjMYppzdU69s
         PsPYGM1k3HjtuAqhFsB8U3fumOXvv75jGWIpqu8gP+FF1OBUS2c7Q9APSmIuN4fkypkL
         wTIoRKDkvAiAV8kNL7WsS76JzqQ2dCmZ6JGGHascrvkwAk5+1U6wRGqw3z+WwlhKH8Tv
         vDRpH+QLsTjSS9QJ9vL/vHW9Xd0DcukfymLtLFavr6ONHA9JoPK0Q6MJezZSBi6vxfL1
         fvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5I80EenxW8QEzuYqgbvuMr3bSOn72Soj1X+J/PDBKlBpOvMfpAJng4fNkn0MLzot8+QzIipajz/i2pqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtCQppQaTXpGCxY4ClJ0Ib8+3Ko9u/d7isp2OtED8Oap2USx3
	P8VjpOZgoxst6iHV8/i7++LFRwVhSaUb2W1nK7yvAuynW7QURDrOV57e64B0Qg==
X-Google-Smtp-Source: AGHT+IHPBYH3dxSRY7Ys4valC9Nf6OkNReNcuKNFDgx+eOAc4A3ZD0f4f+0ft/cSZzhfPqD2o6437Q==
X-Received: by 2002:a05:6a21:7108:b0:1cf:539c:5712 with SMTP id adf61e73a8af0-1cf761f9867mr3708626637.38.1726147978258;
        Thu, 12 Sep 2024 06:32:58 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b2c3fsm4577209b3a.165.2024.09.12.06.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:32:57 -0700 (PDT)
Message-ID: <7d3cff7a-ecc0-4744-836f-ce74f335b753@beagleboard.org>
Date: Thu, 12 Sep 2024 19:02:46 +0530
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
 Ayush Singh <ayushdevel1325@gmail.com>
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
 <ecd1fff8-9c15-496a-982f-36e6c58e906a@gmail.com>
 <2024091151-hummus-usher-2561@gregkh>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <2024091151-hummus-usher-2561@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 01:33, Greg Kroah-Hartman wrote:

> On Wed, Sep 11, 2024 at 09:32:21PM +0530, Ayush Singh wrote:
>> On 9/11/24 20:27, Greg Kroah-Hartman wrote:
>>
>>> On Wed, Sep 11, 2024 at 07:57:20PM +0530, Ayush Singh wrote:
>>>> A simple platform driver for now that does nothing. This is required
>>>> because without a platform driver, the mikrobus_gpio0 nexus node cannot
>>>> be used.
>>>>
>>>> In future, this driver will also allow for dynamic board detection using
>>>> 1-wire eeprom in new mikrobus boards.
>>>>
>>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>>> ---
>>>>    MAINTAINERS              |  1 +
>>>>    drivers/misc/Kconfig     | 17 +++++++++++++++++
>>>>    drivers/misc/Makefile    |  1 +
>>>>    drivers/misc/mikrobus.rs | 32 ++++++++++++++++++++++++++++++++
>>>>    4 files changed, 51 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 0cc27446b18a..d0c18bd7b558 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -15433,6 +15433,7 @@ MIKROBUS CONNECTOR
>>>>    M:	Ayush Singh <ayush@beagleboard.org>
>>>>    S:	Maintained
>>>>    F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
>>>> +F:	drivers/misc/mikrobus.rs
>>>>    MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>>>>    M:	Luka Kovacic <luka.kovacic@sartura.hr>
>>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>>> index 3fe7e2a9bd29..30defb522e98 100644
>>>> --- a/drivers/misc/Kconfig
>>>> +++ b/drivers/misc/Kconfig
>>>> @@ -610,6 +610,23 @@ config MARVELL_CN10K_DPI
>>>>    	  To compile this driver as a module, choose M here: the module
>>>>    	  will be called mrvl_cn10k_dpi.
>>>> +menuconfig MIKROBUS
>>>> +	tristate "Module for instantiating devices on mikroBUS ports"
>>>> +	help
>>>> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
>>>> +	  board socket standard that offers maximum expandability with
>>>> +	  the smallest number of pins. The mikroBUS driver instantiates
>>>> +	  devices on a mikroBUS port described by identifying data present
>>>> +	  in an add-on board resident EEPROM, more details on the mikroBUS
>>>> +	  driver support and discussion can be found in this eLinux wiki :
>>>> +	  elinux.org/Mikrobus
>>> So you want to be a bus?  Or just a single driver?  I'm confused, what
>>> exactly is this supposed to do?
>>>
>>> If a bus, great, let's tie into the proper driver core bus code, don't
>>> "open code" all of that, as that's just going to make things messier and
>>> harder to work overall in the end.
>>>
>>> If a single driver, why is it called "bus"?  :)
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Well, mikroBUS [0] is the name of the socket standard. It is basically a
>> group of following pins:
>>
>> Analog - AN
>> Reset - RST
>> SPI Chip Select - CS
>> SPI Clock - SCK
>> SPI Master Input Slave Output - MISO
>> SPI Master Output Slave Input - MOSI
>> VCC-3.3V power - +3.3V
>> Reference Ground - GND
>> PWM - PWM output
>> INT - Hardware Interrupt
>> RX - UART Receive
>> TX - UART Transmit
>> SCL - I2C Clock
>> SDA - I2C Data
>> +5V - VCC-5V power
>> GND - Reference Ground
>>
>>
>> I do not think it would qualify as as a "bus" in the Linux driver sense.
>> Especially with the devicetree based approach here which applies overlay
>> directly to the actual uart/i2c/spi controllers and basically not interact
>> with the mikroBUS node much.
> It will be a "bus" in the driver sense as you want to have different
> drivers bound to devices that are plugged in here, right?  Or if this is
> just a single driver for the hardware, then no, as you will not have any
> additional drivers for this standard?  It's unclear you want to do here.
No, a single driver. The driver is for board detection and applying 
proper overlay. There will not be separate drivers for each addon board.

>> The driver is here to enable the following:
>>
>> 1. Enable dynamic board detection using 1-wire eeprom on some addon boards.
> Some, not all?

Some mikroBUS boards have 1-wire eeprom [0]. This can be used to enable 
dynamic detection of the board. But this is not part of mikroBUS 
specification itself, and is like a mikroe addition. So there will be a 
lot of mikrobus addon boards that do not have any way to do dynamic 
detection.

>> 2. Provide sysfs entry for runtime board adding/removal
> That's not what sysfs is for, but we can get there eventually...

>> 3. Enable using mikrobus connector node as nexus node for GPIO (not having a
>> platform driver makes any driver trying to use the connector as nexus node
>> go into deffered probing state).
> Why is this a platform device?  Is this always going to be described by
> DT somehow?


Well, since greybus does not use a dt based approach right now, that is 
one case where we potentially cannot describe the connector in DT. But 
since greybus is mostly staging, I am not sure if there are any plans to 
use DT before bringing it to mainline.


>> For this patch series, the driver is mostly here due to point 3. Basically a
>> stub.
> Let's see how this really works before coming to conclusions.
>
> As an example, how do you think sysfs should look for this device?  For
> all devices?  Write out the needed sysfs documentation entries first and
> then that will help explain things better.
>
> thanks,
>
> greg k-h


Something like the following:

cat board-overlay.dtbo > /sys/bus/platform/mikrobus-connector0/new_device


And to remove the device (revert the overlay)

echo 1 > /sys/bus/platform/mikrobus-connector0/delete_device


The main motivation for the sysfs entry is that only the board overlay 
needs to be provided, since the driver already knows it's own connector 
(and hence the symbols overlay for the connector).


[0]: https://github.com/MikroElektronika/click_id


Ayush Singh


