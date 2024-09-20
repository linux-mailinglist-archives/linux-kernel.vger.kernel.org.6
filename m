Return-Path: <linux-kernel+bounces-334546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4B97D89A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C201C22731
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2217E016;
	Fri, 20 Sep 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="EfvvcHDm"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628B17A922
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851077; cv=none; b=k5Bp3O47/vBolQi4ItgVst0i26ijwDih0ab6ATEqe1j7k9iNW+T5ZhXW75+L2NS/jrJ0B+LxtSOFGoVT4B4Lkzflfn5pLBz4RXoXo3a5gCGBJn26/jjmSIpmwYP5P51OwrglQExk4vWufYW1mbxhmmAu8PXI0x1R5lqmdmUhkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851077; c=relaxed/simple;
	bh=KsQVlvLTLVLx5HTYXqiC+sTdTjQgmDAEeWosYg5qu6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbO6EUQpm7LcJ9MVK+MjojNILJPDjPyP5SiTmO42EAFozRezkL0l7upn72UYA4NNowFBfkteaipwgpYk7lcyR8AulRf9ofqy5v78Fe7fC/BsfmJdhw4rqnfe9ViZ4yZnhdTXJOtzsL6r8A0rAFp+m3G82n4auLbNmrNFFFivIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=EfvvcHDm; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-208ccde82e6so19451825ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726851075; x=1727455875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWaHdgUF5WttiTB0kVW3XyzOiJtIxTXyqd5zmSY01K4=;
        b=EfvvcHDmKxamqKCVICSoxzgfBUWtwri3YvdDQpr50t7B6phyXxkzfuYMh/GHK7BxPY
         mGPqAr7q2pLAXTVwJG9/EjdnYPPJ2Bcrbj1MEaGO4TEimaorqtxGaxbCJjRvrJWL5/jg
         FKYpqIOXWBseygREEsVIjOzSYQiY/uMWk9GQumuZmNoS1iZPPYuawv0YWJz6gJ+At+nw
         fB5r4ci34PorBAVHV9+AvXllLK14BTZra8magqiXgBbjSzRJgB4oxvbB6mloMDHJuQUY
         z1RSVg+DoH9QB4M9ECNE3o+zTXD2lBJVzLpAcOGvnaWyVKKQdUbPKJgkQw0KFj9AwirB
         YKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851075; x=1727455875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWaHdgUF5WttiTB0kVW3XyzOiJtIxTXyqd5zmSY01K4=;
        b=k68cRdOVyufEYu0qJtO3nZ+GhSPEZufmY6Mqx9RZiMoNPdtDfw7StpN6QMxS9pgUVN
         ZBrOzBMDJln0g5nO+XLFUVr1/sgpzMd9AWCHxFVsP2Xc+68RgiJ18Wdm7F7vrd9AH7NY
         Yszr+AXrX+LY7269A9zUNnG0ELYKRWcHbtJH8alysM84d/rE4bBLKFbEV5m9cdwlmRWM
         ZxXw3d5c8R6QK0K7/N6Mjuymu63IelmFOsgXJeni6Ec4l+XkB44a+pH3ueZmdDGBvK5f
         S7q4sZ54un4LD6IyOP8l8hU3J6Mi7nrYu6gyfW6G+QW+6Qq5mQT0CxejdZplNq/1qTlo
         nTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZVtexMffhIEEiMyNWbBJx1DE3QOERL3PIANW5fUo4Vbs/c8BAa/Ux7byR41s7DuneCg40uz/qpSALiVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcyw/q8S2HufcuiiXT2zZqbmt+BoW87HIFAEG66c1WSeqsUBk7
	5UKECGRa7kMEcWnq/LzVqUhqGLB2DbwoIBRMH1yO2IVQYfWWc0Dd0kCgLbMIBw==
X-Google-Smtp-Source: AGHT+IEYRXoKu/4pb5twu3lYTq4DmeNQwIp/x5QHdVE+j4p3QOuhfDAHJP5FNITJWZFn0dvqitN2Cw==
X-Received: by 2002:a17:903:32c8:b0:207:1737:2c66 with SMTP id d9443c01a7336-208d83dea30mr44172445ad.35.1726851075068;
        Fri, 20 Sep 2024 09:51:15 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947485c2sm97208215ad.294.2024.09.20.09.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 09:51:14 -0700 (PDT)
Message-ID: <dae6ef1d-1317-435e-8c15-158a54cd8926@beagleboard.org>
Date: Fri, 20 Sep 2024 22:21:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add generic overlay for MikroBUS addon boards
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911170245.GA915638-robh@kernel.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <20240911170245.GA915638-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/11/24 22:32, Rob Herring wrote:
> On Wed, Sep 11, 2024 at 07:57:17PM +0530, Ayush Singh wrote:
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
>>
>> The patch series has been tested on BeaglePlay [4].
>>
>> I will now go over individual parts of the patch series, but for a
>> better picture of the approach, it would be best to checkout [0] first.
>>
>> MikroBUS connector driver
>> -------------------------
>>
>> Just a stub platform driver for now. Will be extended in the future for
>> dynamic board discovery using 1-wire eeprom present in some MikroBUS
>> addon boards.
>>
>> While it is a stub driver, disabling it will make the GPIO connector
>> nexus node unreachable (any driver attempting to use it will enter
>> differed probing). So it is required.
>>
>> MikroBUS connector Devicetree
>> ------------------------------
>>
>> The connector devicetree defines the MikroBUS GPIO nexus node. This
>> allows using pin numbering relative to MikroBUS connector pins in the
>> addon boards overlay. Currently, the patch uses a clockwise numbering:
>>
>>    0: PWM
>>    1: INT
>>    2: RX
>>    3: TX
>>    4: SCL
>>    5: SDA
>>    6: MOSI
>>    7: MISO
>>    8: SCK
>>    9: CS
>>    10: RST
>>    11: AN
>>
>> Additionally, in case PWM pin is not using channel 0, a nexus node for pwm
>> should also be used and go in the connector devicetree.
>>
>> MikroBUS connector symbols overlay
>> ----------------------------------
>>
>> To make an overlay generic we need a standard name scheme which we
>> use across base boards. For the connector pins the pinmux phandle
>> shall be:
>>
>> <connector-name>_<pin-name>_mux_<pin-function>
>>
>> For the parent provider phandle, we use a similar naming scheme:
>>
>> <connector-name>_<pin-name>_<pin-function>
>>
>> For GPIO controller, I am using `MIKROBUS_GPIO` name since with nexus
>> nodes, we do not need to define individual pin gpio controllers.
>>
>> The string symbols can be replaced with phandles once [5] is accepted.
>> That will make connector stacking much simpler.
>>
>> MikroBUS addon board overlay
>> ----------------------------
>>
>> The patch puts the addon board overlays in their own directory. I am
>> using the following naming scheme for MikroBUS addon boards:
>>
>> <vendor>-<product_id>.dtso
>>
>> Mikroe [6] lists this for all boards in their website, but I am not sure
>> if other vendors have a product_id.
>>
>> This naming also makes future dynamic discovery easier, since click id
>> spec [7] contains vendor_id and product_id in the header.
>>
>> Usage
>> -----
>>
>> So what does this all look like? Let's take an example of a BeaglePlay
>> with one MikroBUS connectors for which we have physically attached a
>> Wather click module to the first connector. Doing ahead of time
>> command-line DT overlay application:
>>
>> ./fdtoverlay \
>> 	-o output.dtb \
>> 	-i k3-am625-beagleplay.dtb \
>> 		k3-am625-beagleplay-mikrobus-connector0.dtbo mikroe-5761.dtbo
>>
>> Open Items
>> ----------
>>
>> - SPI Support:
>>    Currently SPI dt requires `reg` property to specify the
>>    chipselect to use. This, makes the SPI device overlay dependent on the
>>    SPI controller. Thus for SPI support, we need a way to allow defining
>>    SPI chipselect relative to MikroBUS pins, and not the actual device
>>    controller.
>>
>>    One possible solution is to introduce something like `named-reg` and
>>    allow selecting the chipselect by string array. But this probably
>>    requires more discussion so I have left out SPI support for now.
>>
>>    NOTE: pins other than the CS MikroBUS pin can be used as chipselect.
>>    See [8].
>>
>> - Controller symbol duplication
>>    The current symbol scheme has multiple symbols for the same underlying
>>    controller (Eg: MIKROBUS_SCL_MUX_I2C_SCL and MIKROBUS_SDA_MUX_I2C_SDA)
>>    point to the same i2c controller.
>>
>>    I think both of them will always use the same i2c controller, but
>>    maybe there are some exceptions? So I have left it as it is for this
>>    patch series. The same thing also applies to UART and SPI.
>>
>>    NOTE: with the use of nexus node for GPIO, the GPIO controller symbol
>>    will be the same for all pins.
>>
>> - Nexus node dt-bindings
>>    I am not quite sure how to deal with the nexus node properties
>>    (#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
>>    seem to conflict with upstream gpio schema (gpio-controller is a
>>    dependency of #gpio-cells).
> Please submit a fix to dtschema. Either GH PR or patch to
> devicetree-spec list.
>
> Rob


I have created a GH PR [0].


[0]: https://github.com/devicetree-org/dt-schema/pull/143


Ayush Singh


