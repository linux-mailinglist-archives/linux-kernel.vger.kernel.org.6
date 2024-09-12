Return-Path: <linux-kernel+bounces-326169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF98976437
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57877B22E55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517019259B;
	Thu, 12 Sep 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="J/nxG6FS"
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22961917F3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129054; cv=none; b=bCBdX/ISYdlZSzCqZs8IUQBzqsxII80+A+7GEFgiUnenHvkuPLq6z7W6Ll3zQmWI3UB1b8Bmr25g8agj1qBgeN3brEI0ZMY81FVOCiXYzvAjI6MTDV9b/fRmt5gvlqJpZG1Xyq+LB6S1yarM6okf1jbcteVFgpkbTNyyEbT8UsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129054; c=relaxed/simple;
	bh=d+BqVvTCnLYNpfUCGWJ+LK6fsMD567B1Xn+U4BteCmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSKI622vruScq4E1DUdaUJnRZcEbLerSEMoZdX3CvAKdDtvfJ5oRwkKFNki6zQeFlkc/4Yob+WK5/H8B1z89CBtIEriiUis0jGATdlr0fXucDCBAJQyeHsrfSk1Xy8ulmfqGzvIDE5TGZWXIocZCwbux+h8I//agZ5Msb8dH20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=J/nxG6FS; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3e05a5f21afso372172b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726129052; x=1726733852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uL3yDQtDSTfprjNMoH8FDOc9dazYHaDt/nHN9xGeXM=;
        b=J/nxG6FSSHE75sNtV/cLBnR6ClZDRUING+V6GWm4yFtsq+6z+5sfBCRBma8eKkM7hV
         iFC5+Pkt8t0jnYpFnzY01rc4H+tY+4AYI2Q2g/hHE1ICEhCOKv1L2z+kq6W2ZZoRMpxi
         Xtm0A3xdWn+HLAMWY8NT1lYvlLONFDz16Wi8P6IJTdAA2RNoYKBEPU4bJwiDrA238c+N
         qG2jDEQREy9EOGx94aaYpobEKoI2RtfUqtNx0/byph+45ykmRfMyaxOBxQp5TUZyyEsC
         ok8w0S/KZq2fdfTwISxcquhgtWEhDlDH58VMVBwzmu0FVwrGZS5vO87vYx0TQpmIE+e7
         bpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726129052; x=1726733852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uL3yDQtDSTfprjNMoH8FDOc9dazYHaDt/nHN9xGeXM=;
        b=MpyqaRYy0WjRfW0XeHUFW5lyNVzFIAJhMZzPbVvN2LgI6DuhocZ2VU1DE8WOaKK7Z8
         wRMiXjgk5GCFbk0EBfPUdzdshCi8ghdV5PivNHp6qlYvuAFMKbQFvDU5BCd5+MV1iAiV
         8ZLm+QqRhg0WYmyz1ZhV1l53wdyhlXCQbS3rFnKsYFeIMhCdlb4e1nk95tz0EMGii5C5
         CMBzPmkFgGfggxB2o//2VRIDKXQe38VvEjjF60SY305dbzv0H/mDcrtTuaUSfcVSE/f4
         sXu2iW080fBpcHftl+PzLbNLR322I2+WQo2URZc9Wl3uBOeJYhjmYjr9P6ir7Dfpdt+1
         OWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWsnKabKftDLUAt9suaSs3flH6htQ5i7psHG0qk4hAatggfYSMr60nGMcIYorhAr5Uww/E0IzURLG477mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYZKBNfVsTitNmPlRT7Q0sfEE4SMwDhanYdQcBN1PocEbuhN5
	l20oT1NjWNcEsFxfv28Ton3l3iExXMODvG7JfQKPo+jdlB1CYjtq7pxlobzf6A==
X-Google-Smtp-Source: AGHT+IHqXN55m2k9nKnrLVORi16b7s+aS0bP7kpj9K+gERCN7cxXjZ4YnCy9OzUuuNUrn0w1QzZ3/w==
X-Received: by 2002:a05:6808:3190:b0:3e0:74b1:d676 with SMTP id 5614622812f47-3e074b1dfb8mr974656b6e.27.1726129051808;
        Thu, 12 Sep 2024 01:17:31 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddc6e2sm1186225a12.62.2024.09.12.01.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 01:17:30 -0700 (PDT)
Message-ID: <8072c698-93b0-4d3a-a970-e276243f82c4@beagleboard.org>
Date: Thu, 12 Sep 2024 13:47:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dirk Behme <dirk.behme@de.bosch.com>
Cc: Ayush Singh <ayushdevel1325@gmail.com>, fabien.parent@linaro.org,
 d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, Andrew Davis <afd@ti.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
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
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
 <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
 <2024091151-unworldly-dance-9a80@gregkh>
 <097159c7-1602-4e32-8e6f-9cd023d62238@beagleboard.org>
 <419bf74e-74cb-46ca-95d0-03b3bab3948d@de.bosch.com>
 <2024091211-bladder-runner-2d75@gregkh>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <2024091211-bladder-runner-2d75@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/12/24 13:09, Greg Kroah-Hartman wrote:
> On Thu, Sep 12, 2024 at 09:29:01AM +0200, Dirk Behme wrote:
>> On 12.09.2024 09:16, Ayush Singh wrote:
>>> On 9/12/24 01:34, Greg Kroah-Hartman wrote:
>>>
>>>> On Wed, Sep 11, 2024 at 09:26:06PM +0530, Ayush Singh wrote:
>>>>> On 9/11/24 20:28, Greg Kroah-Hartman wrote:
>>>>>
>>>>>> On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
>>>>>>> - GPS3 Click is a UART MikroBUS addon Board
>>>>>>>
>>>>>>> Link: https://www.mikroe.com/gps-3-click
>>>>>>>
>>>>>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>>>>>> ---
>>>>>>>     addon_boards/mikrobus/Makefile         |  1 +
>>>>>>>     addon_boards/mikrobus/mikroe-1714.dtso | 28
>>>>>>> ++++++++++++++++++++++++++++
>>>>>> Odd top-level directory for the kernel, are you sure this is correct?
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>>
>>>>> Well, it is kinda a temporary location, since well, I could not
>>>>> find a good
>>>>> place for board overlays but a top-level location seems better
>>>>> than putting
>>>>> them in any arch specific location. I am open to moving them to a more
>>>>> suitable location if we have one.
>>>> top-level location is not ok for something so tiny and "special".  Just
>>>> put it where all other dtso files go.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> So here are the directories where dtso files currently go:
>>>
>>> ❯ find . -type f -name "*.dtso" -printf "%h\n" | sort -u
>>> ./arch/arm64/boot/dts/amlogic
>>> ./arch/arm64/boot/dts/freescale
>>> ./arch/arm64/boot/dts/mediatek
>>> ./arch/arm64/boot/dts/qcom
>>> ./arch/arm64/boot/dts/renesas
>>> ./arch/arm64/boot/dts/rockchip
>>> ./arch/arm64/boot/dts/ti
>>> ./arch/arm64/boot/dts/xilinx
>>> ./arch/arm/boot/dts/nxp/imx
>>> ./arch/arm/boot/dts/ti/omap
>>> ./drivers/clk
>>> ./drivers/of
>>> ./drivers/of/unittest-data
>>>
>>>
>>> Out of these, `drivers/of` and `drivers/of/unittest-data` contain
>>> unittest dtso, so probably not the place.
>>>
>>> And the `arch/arm` and `arch/arm64` are for arch specific stuff.
>>> MikroBUS is supported in RISC-V boards as well (BeagleV-Ahead). So
>>> probably not the correct location either.
>>>
>>> Maybe something like `arch/common/addon_boards` would be better?
>> Whats about
>>
>> drivers/misc/mikrobus/mikrobus.rs
>> drivers/misc/mikrobus/mikroe-1714.dtso
>> drivers/misc/mikrobus/mikroe-5761-i2c.dtso
> Exactly, put them where the drivers are, like clk and of does.
>
> thanks,
>
> greg k-h


So I am writing a more thorough reply in the driver questions, but 
essentially, the driver is not actually required for using the overlay 
based approach for mikroBUS addon boards. Initially, the driver was not 
supposed to be included in the patch series at all. But I was not able 
to find a way to use a GPIO nexus node [0] without having a platform 
driver attached to the node.

In fact, if the GPIO nexus node is not required (like in the case of 
weather click), there is no need to even have a mikrobus-connector node 
in dt, let alone a driver.


So to answer why it probably should not go in the driver directory, the 
driver for the connector, actually does not register the mikrobus addon 
board. And if there is a way to have GPIO nexus node without having a 
platform driver attached to the node, then it should probably be removed.


The reason why the overlay based approach was suggested was because 
previous approaches could not do board stacking (having chain of 
mikrobus connector -> grove connector addon board -> grove board). So as 
you can see, it is beneficial to have grove board overlays compiled even 
in a board without any grove connectors because of stacking.


[0]: 
https://devicetree-specification.readthedocs.io/en/v0.3/devicetree-basics.html#nexus-nodes-and-specifier-mapping


Ayush Singh


