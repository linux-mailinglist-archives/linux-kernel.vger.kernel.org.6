Return-Path: <linux-kernel+bounces-333979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8397D0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B461828648F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E636AF5;
	Fri, 20 Sep 2024 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ZVO6NQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02181C68C;
	Fri, 20 Sep 2024 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726810739; cv=none; b=sgeT4KXyO76LH/gXsC7pYjZDjE7rD1mmEJ6jEI13sKRnWgOril7zT04aAmUuRzny8IwCH+o63ZJpF6hy1IAKILoqfa0IhvffUAqcPrznMmwgzNfO1zb/4D2t+zIPciHtZaPHo6MmKA/uyV/npKgvhoyvIv9ysxfrbl0b47IaRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726810739; c=relaxed/simple;
	bh=9mM7JGjQh2uRfy2PIfM9U9eC6nQ/UPRh8t+iXq52YLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ9aVklIOYnxr9xYCKXPByv0Pou15XGgvQWsHfcHEQxLsC6MxqdQSJ7U9SsHNPVEFSpjl6k+dZif8xRIRH8JkB9kyH95B9MwxCSNdHSdUG2kfk2JlG93k7+ahgw/tnT7GBkPW56KiybRtZb4nAlmtHAgxj/wZTx3o6CsEFZLDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8ZVO6NQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso13530405e9.2;
        Thu, 19 Sep 2024 22:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726810736; x=1727415536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Frjxz5etneHCaaJgzRHNp4iPyV6Hzbgn0iIJTfYdgIk=;
        b=g8ZVO6NQyu91jxZgx4QG7jpGHM701KVZy8RJ2JQRU4Ac/MrFEFOs1+ax6F4qxC2Z5r
         UkQQYvIAXkHS5jU9ecqcHjuhRfDFonWjJtDs55Q4wg0a/i9zt5MUWOn114rJZK8OT3pi
         EViulHP37bE5waigCbNVP/7Iu9RcpyYk7BhPBwCI0byfu0D663EqlA9VAB8Y+ROy0IMd
         aqPv6/q5k2Y0q0mAk3zgQzmJDDlnSzH1Op7EUEyCY9heEX9UPavN4KDq6QJV7pR+PVps
         DVoNh2Efsh3NfFvbdbQxyykmUEuUVCd60a9NykrlLADquDIrPXnRn40EAqYkAicVxiur
         aWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726810736; x=1727415536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Frjxz5etneHCaaJgzRHNp4iPyV6Hzbgn0iIJTfYdgIk=;
        b=wHna9x2XQRNEmv3spo1ZEhbzQWWllFCXuNSS4xALXB/YBSITrguWjAfCPM58m+GN5J
         hSdOyGyzSUBrv/fD74BTIxk/o+kFWCVnjXOYuq25lFv/w5Stg/7N9e+BByACSfZZ/D4N
         teg86vt2wNOYtoyx8QP4UOUAcqPut8X2WdsCfA4CX7JpOedlRgnquT920yQ0DD+Q6pTG
         cf1RdD/j34GtH7zqccm5UIHuiiwLJ2qrRJLHVwF719qZoMlMO5kMrvkRWEKJnJ+DuI2D
         1+wQDXEhGOcB1MZAREVDsdK7MpFQ/R4i/YKGarr+lokD2Tb/+811SDPMOf3HXBJ8cpDq
         SAsA==
X-Forwarded-Encrypted: i=1; AJvYcCUt35oPkimlbPCttilGIWEGDCgDb5HRxLniWwIvj38FsC6OG3Hj7He5aIIMVkJF6DFU5bBld6pCNIpU@vger.kernel.org, AJvYcCWuKWKUy/ceKjC6PO8bU4y6Pg+Kn6xewJc2orTRSVMSpQtXeJk7l7ujjpN5to7bZgH+7OyJ/NDObQhIPL6U@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3hQM9rrw+DkvGYgStJHg5aIo7DLtk4tPI6QC5zfQh2Rwtmrf
	JXgXl0jjoAII532ZCXe2c6OKAE0Q05eApKaQM2G4NMjQVQxgmkYT
X-Google-Smtp-Source: AGHT+IHyVmJ/Xhl5VAZSjrj3EfgC6w8klVkHfqzqRBFPY326hghRpoKJbRZkPZkL2dOJa1WhWtl8LQ==
X-Received: by 2002:a05:600c:310a:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-42e7abe8e3emr9928395e9.11.1726810735502;
        Thu, 19 Sep 2024 22:38:55 -0700 (PDT)
Received: from [192.168.0.241] (85-193-33-128.rib.o2.cz. [85.193.33.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afe0eedsm12297155e9.32.2024.09.19.22.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 22:38:54 -0700 (PDT)
Message-ID: <fed7f9f5-0189-4ac4-bcc5-4b59e8b1ccc1@gmail.com>
Date: Fri, 20 Sep 2024 07:38:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: allwinner: Add disable-wp for boards with
 micro SD card
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
 <20240919212151.50957a14@minigeek.lan>
Content-Language: en-US, cs
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <20240919212151.50957a14@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dne 19. 09. 24 v 22:21 Andre Przywara napsal(a):
> On Thu, 19 Sep 2024 20:35:39 +0200
> Kryštof Černý <cleverline1mc@gmail.com> wrote:
> 
>> Adding disable-wp property for micro SD nodes of Allwinner arm64 devices.
>> Boards were verified from online pictures/tables
>> that they have micro SD slots.
> 
> The changes itself look good to me, and I checked that the boards in
> question have a microSD card slot, so do not feature a write-protect
> switch.
> You seem to be missing the mmc0 node in
> sun50i-h616-bigtreetech-cb1.dtsi though, can you please add this file,
> to fix the two boards using this file as well?
> 

I wondered about that one, as it's just a compute module without the
actual slot, I thought it was not right to put it there, as
someone could wire it to full SD or eMMC in their own board.
Maybe put it to sun-50i-h616-bigtreetech-cb1-manta.dts and
sun-50i-h616-bigtreetech-pi.dts instead? The dtsi has broken-cd
property already, but as it seems it is wired to the connector.
I was not sure about this, what are your thoughts?

> With that added:
> 
>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> There are some boards which have their base .dtsi in the arch/arm
> directory, but we can tackle those separately.

I missed them, if I add the property to sunxi-libretech-all-h3-cc.dtsi
and sunxi-bananapi-m2-plus.dtsi, could tag you as a reviewer?
There is also a module called Emlid Neutis, the compute module itself
has not a slot, but the board that uses it does, unfortunately they are
not separate files, so I do not see a clear solution here, as above.

Best regards
Kryštof Černý

> 
> Cheers,
> Andre
> 
>> ---
>> Sorry that my last messages were not in mailing list,
>> one was wrongly sent and second was rejected, as the bot claimed it
>> contained html. ---
>> Changes in v2:
>> - NEW: Added the property to all Sunxi arm64 boards, as discussed in
>> mailing list
>> - Link to v1:
>> https://lore.kernel.org/r/20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-12f54f0d6620@gmail.com
>> --- arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts       |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts  |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts         |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts          |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi           |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi              |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi    |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts          |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts       |
>> 1 + arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts |
>> 1 + 16 files changed, 16 insertions(+)
>>
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts index
>> 526443bb736c..18fa541795a6 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts @@
>> -136,6 +136,7 @@ &mmc0 { vmmc-supply = <&reg_vcc3v3>; bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>> +	disable-wp;
>>   	status = "okay";
>>   };
>>   
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts index
>> 05486cccee1c..128295f5a5d6 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts @@ -88,6
>> +88,7 @@ ext_rgmii_phy: ethernet-phy@7 {
>>   &mmc0 {
>>   	vmmc-supply = <&reg_vcc3v3>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>>   	status = "okay";
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts index
>> 3a7ee44708a2..44fdc8b3f79d 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts @@ -157,6
>> +157,7 @@ eth_mac1: mac-address@fa { &mmc0 {
>>   	vmmc-supply = <&reg_vcc3v3>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>>   	status = "okay";
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts index
>> ce3ae19e72db..0f29da7d51e6 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts @@ -153,6
>> +153,7 @@ &ir {
>>   &mmc0 {
>>   	vmmc-supply = <&reg_vcc3v3>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>>   	status = "okay";
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts index
>> b699bb900e13..d4fc4e60e4e7 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts @@
>> -153,6 +153,7 @@ &ir { &mmc0 {
>>   	vmmc-supply = <&reg_vcc3v3>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>>   	status = "okay";
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
>> index ae85131aac9c..3322cc4d9aa4 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts @@
>> -82,6 +82,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>>   	vmmc-supply = <&reg_vcc3v3>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>>   	status = "okay";
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> index 734481e998b8..3eb986c354a9 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts @@
>> -79,6 +79,7 @@ hdmi_out_con: endpoint { &mmc0 {
>>   	vmmc-supply = <&reg_vcc3v3>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>>   	status = "okay";
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts index
>> 3be1e8c2fdb9..13a0e63afeaf 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts @@ -129,6
>> +129,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>>   	vmmc-supply = <&reg_cldo1>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts index
>> 6c3bfe3d09d9..ab87c3447cd7 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts @@ -131,6
>> +131,7 @@ hdmi_out_con: endpoint { &mmc0 {
>>   	vmmc-supply = <&reg_cldo1>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi index
>> 13b07141c334..d05dc5d6e6b9 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi @@ -94,6
>> +94,7 @@ hdmi_out_con: endpoint { &mmc0 {
>>   	vmmc-supply = <&reg_cldo1>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts index
>> c8b275552872..fa7a765ee828 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts @@ -133,6
>> +133,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>>   	vmmc-supply = <&reg_cldo1>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi index
>> 855b7d43bc50..bb7de37c0d58 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi @@ -124,6 +124,7
>> @@ &mmc0 { pinctrl-0 = <&mmc0_pins>;
>>   	vmmc-supply = <&reg_vcc3v3>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi index
>> fc7315b94406..a3fe39f8e2ca 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi @@
>> -81,6 +81,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts index
>> 26d25b5b59e0..dd3bd9cca710 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts @@ -52,6
>> +52,7 @@ &ir { &mmc0 {
>>   	vmmc-supply = <&reg_dcdce>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts index
>> 18b29c6b867f..16c68177ff69 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts @@ -111,6
>> +111,7 @@ ext_rgmii_phy: ethernet-phy@1 { };
>>   &mmc0 {
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
>>   	vmmc-supply = <&reg_vcc3v3>;
>> diff --git
>> a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
>> b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
>> index d6631bfe629f..024377b333c1 100644 ---
>> a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts +++
>> b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts @@
>> -71,6 +71,7 @@ &ir { &mmc0 { vmmc-supply = <&reg_dldo1>;
>>   	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
>> +	disable-wp;
>>   	bus-width = <4>;
>>   	status = "okay";
>>   };
>>
>> ---
>> base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
>> change-id: 20240914-b4-nanopineoplus2-fix-mmc0-wp-9d77fb9e6513
>>
>> Best regards,
> 


