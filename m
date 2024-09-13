Return-Path: <linux-kernel+bounces-327967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79451977D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0597E1F23943
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51D1C244D;
	Fri, 13 Sep 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="H/eadiHP"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D81C2DA4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222997; cv=none; b=aP1zebMwlgI6icFVkxZQseUGkgbotPZkaQ5N7oWrQa+184B1DpZkTT5+ix2fXtVzPC36k7fwcbB+GSXHmgA1/lGRynXhUgkke7vIqMPX/BY2SgwkA3m4bGXN+3pXWBsx27HvMhLduiYZC13esSPkNMhoJ39L8Eqmeaty0s51I2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222997; c=relaxed/simple;
	bh=p6tgJB58tTcRnuJEgWaM8KrjInxk1KTlCcXAie4xLqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAelaeB3lBhycRIIvFbrpPai3cckycY0W0BoO3Js4J4DsV/23kLi0urhe3BQZW+g2ZsjYW2GuPq1ZvZmkhcaxvAdssHvGBwrs16iPPGFtVjBRbAwgSJu7pnjJ92ftdBfZo3udZW8SPU0G5LeWnPNHLDsYaogQqpeSc7o48lKyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=H/eadiHP; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1260074a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726222996; x=1726827796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiZi8VcoHy2dI52u6S90IRih2acHVc5MolxAqjTzino=;
        b=H/eadiHP1yhx+/4QmPmIOUwG2aPwYvJsOhWGzK5O36UsHfFdYaalZesWFyCA4OmiyN
         NZZtNZcz6aHSlvo+w8Xy5A/MEvwgM0Z4vjJeY+D+xP6FfC3rQYmPwtDGhJaGaikl+oMw
         CIoDkY1oBm03CFF70forWoGqjocgpwAifB3pCXNudY6rCgmCPvN2xgFyFtg3bEtAWUIv
         NyrPj7ViLtJZV+pCLRdKjY34umdTlIpabpkVhH7eOg7wna6kU86k7THWgQEeI7jSUBf1
         rcwXTKd77YQyDZKcDmZrRDBmzrgSp+/VoDHuT8aQwm7ENHo/R+rPSgMoH0RTLImDjwMi
         9VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222996; x=1726827796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiZi8VcoHy2dI52u6S90IRih2acHVc5MolxAqjTzino=;
        b=ET49IBR7UY5LDy1fyWhv7ewMF/Ll8EZjlaZNvlPnsSaamyOqhhyryt5GM3+o0UtEi5
         JrgGfleIB4kGetl9RntQDncKgETFNwQ7ltAVowRBQlTHLCdyJ53LODIiR5ZlzISyEeeB
         liWu1Cn/kmLEbSFiDc9OopoVv/kaJfuZNbzP//hyz0h9Y18b1qTOsPrdTGKuWD5hQfLr
         pMZ2/6Vg7o3AL/hG8VdNkTczzBdA9i6tc9Mp55Dwq9BV1h28NrI1C1cwbe3Fz/yDIY2w
         7nDj5kWeGDzcY0UBd4aUkd5hRiHIlkoAjnQ+yGXHHgHa4V0Ieeyw/JaXKOISvBdLp3C/
         F1oQ==
X-Gm-Message-State: AOJu0YyLCuS6df8e9Hk1a9cGn7c0hYv8mp2Zg+THeZN8NdRZQmj0GGSH
	9UfmDf+tgMMLIQUkMPWOSv5EVNHiY00YjzHgAv/4AqdhV2RlXw21ltQQSMeetQ==
X-Google-Smtp-Source: AGHT+IE20qpyhTu6c4+KImLY/NAdkYoyLr+IkuhYxS+W9wO2TuFcF1dsqgCQ+UYw47dThwp0pAebmA==
X-Received: by 2002:a17:90a:17e1:b0:2cb:4e14:fd5d with SMTP id 98e67ed59e1d1-2db9ffe44b3mr6369987a91.17.1726222995668;
        Fri, 13 Sep 2024 03:23:15 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d20029sm1341315a91.50.2024.09.13.03.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 03:23:14 -0700 (PDT)
Message-ID: <c127af0d-7e9b-420f-b241-e26ede6b79b7@beagleboard.org>
Date: Fri, 13 Sep 2024 15:53:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add generic overlay for MikroBUS addon boards
Content-Language: en-US
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <8428068.T7Z3S40VBb@steina-w>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <8428068.T7Z3S40VBb@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/13/24 15:35, Alexander Stein wrote:
> Hi,
>
> Am Mittwoch, 11. September 2024, 16:27:17 CEST schrieb Ayush Singh:
>> Hello all,
>>
>> This is an attempt to add MikroBUS addon support using the approach
>> described by Grove connector patch series [0].
>>
>> The patch series tests out 2 addon boards + pwm and GPIO on the MikroBUS
>> connector. The boards used are GPS3 Click (for UART) [1] and Weather
>> Click (for I2C) [2]. Additionally, I have tested relative GPIO numbering
>> using devicetree nexus nodes [3].
>>
>> The patch series does not attempt to do any dynamic discovery for 1-wire
>> eeprom MikroBUS addon boards, nor does it provide any sysfs entry for
>> board addition/removal. The connector driver might include them after
>> the basic support is ironed out, but the existing patches for dynamic
>> overlays work fine.
>> [sniip]
> To put it in a more abstract perspective, aren't you "just" defining some
> kind of connector with a fixed layout of pins and features?
> It's not really different to Arduino Shields and Raspberry Pi hats, no?
> Ignoring multi-purpose pins for GPIO or e.g. I2C, this is about matching
> the plugin module's pins to platform-specific on-board peripherals.
>
> Sticking the name to MikroBUS might be misleading, because this is AFAICT
> just a trademark for a specific connector pin layout.
> This concept could be applied for any kind of connector, where e.g.
> the I2C interface is mapped to i2c0 on one platform and to lpi2c5
> on a different platform.
>
> Best regards,
> Alexander


Yes, the only thing specific to mikroBUS in the patches is the connector 
symbols. Theoretically, it is supposed to be usable with any connector. 
MikroBUS is just the connector I am trying to apply the concept to.

I think I came across a bit too mikroBUS specific in the patches here, 
since well that is the connector I am currently trying to support, but 
as the original patches by Andrew [0] explain, this approach was 
proposed to work as a generic way to support such connectors, and even 
do connector stacking.

Trying to use it with MikroBUS shows some limitations we have with the 
current device tree stuff

1. SPI chipselect

2. Nexus nodes need the node to have some kind of existing driver

3. A good place to store the board overlays

4. Stacking needs phandle symbols table support

5. Append property support in devicetree


And of course, I might encounter more limitations as I continue to test 
more boards with it.


[0]: 
https://lore.kernel.org/linux-arm-kernel/20240702164403.29067-1-afd@ti.com/


Ayush Singh


