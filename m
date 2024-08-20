Return-Path: <linux-kernel+bounces-294610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB8959030
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B734D283F74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBB1C6891;
	Tue, 20 Aug 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N886QN9V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6115C152
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191302; cv=none; b=To2VkCdN7/tm6d842sPKq1jm4rCb8fZUMZqEoHXWaU0BZgq/r07i//qY+AVWJ97dNNn82zt3jeij6byBqP6sxZMz0ZNUQ2PAgsPz4RJ2Qz5mJ2puLrJQNQAjSYuFNdJAQncYOWG4GKwQA6oAifh6rvkrUEnwhmMFhtwOBybXla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191302; c=relaxed/simple;
	bh=v54+MCLFPem7S/SIS0aKmyonU55zo2LfX1Vr1uR0tGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWGzb7zE54Onp168qlzU78Gan+JEyRzsjgLbCmdQqsTmCWqHi9pSnsx/w2m4knpwXAOQSqp9Ont2hzbuxOWRhtW3yCm1NNUNApceIwIKUnsslKvh7u9JzdzJ5jAnkHcRBed4AWQoHSzmKLuPoaWOxPpClsoYB3sBiqAppiXZRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N886QN9V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724191300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jF5tdi+xuPc6qltd6uB69vrp7uSr6ss7SEGUS1mB1ls=;
	b=N886QN9Vwk5DEa4+xAhiP/OWlhDofLszgtiMTPSe9tZZb+dGEQGrw1LgqXLxkw8r8axXer
	mSidbxcyO2KudaOFnG5LHkKB0scG+DsbQneVY+S7pcDjSLdL6OitDjse5dYH1tPpvdSNZU
	MaiJKPjHBcCYShyK0nba9E1fAbFgNak=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-mpBTn7uoPfekBMmzWEFYhg-1; Tue, 20 Aug 2024 18:01:39 -0400
X-MC-Unique: mpBTn7uoPfekBMmzWEFYhg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-68fd6ccd4c8so108872767b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724191298; x=1724796098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF5tdi+xuPc6qltd6uB69vrp7uSr6ss7SEGUS1mB1ls=;
        b=FjNevnsCkt2/uM1q1h/agphjiUM4Y7TbFyY14X0eraeTMyPUBsAXdeF5xhshDOZYK0
         c4khAj95wQbloF5Z1Ks8J+NlgYIkstfisSC6EeCynstbOj75dNqDPTtw3H+sxGKk96mU
         A+RwL6HOFCznsb8cr2zUqQAQpwpkAu1XJ+2/HbJ6iNRvQeCd4BWuw42RWNWYM/ansK2S
         7k9lW/Q2/hfOKMYGooqFtB8elududyfrLJEoahYz1iEQFiE0KU1SlQxKb883vh0D5JcG
         QroKVb5nPG1DxRByrU62NeinTq231gaCHLdrabfVfSGvpoN48fNg6bkA3c5alUXMllAI
         TOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6EjAEqZKxoK8YljZyf2Vi1EQFU4Xl5RNgMuoad1Hi/GFqCurxeu1E7HS2Vqk3IESkZ2x17qZ7XGYM8YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt9basuAsnw8dal5kekYiRD3PMUcwjwIhRn5aAsSq2FMd3crtC
	P2AvvkOVybR6kKb6wmoet/dtFczlyZyPveILaxPtFPf3OdRWqBYvG2NTn29kEx/075CJLbbFyqi
	HzmbKpWVl6I3SLkb7Ww4RyCuwjF9OZYnWwKNGQSITifyKATXJa19N7eWWh7e2Sw==
X-Received: by 2002:a05:690c:2706:b0:6af:125a:1c6a with SMTP id 00721157ae682-6c0a1493f4cmr6885287b3.41.1724191298030;
        Tue, 20 Aug 2024 15:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6E4T/OqVLJvgtVOTHFZ21tVTTZuOj73rhi1sEN5hdqt+kit0eSJsmXt45NHfrPXRN3Wt/Pg==
X-Received: by 2002:a05:690c:2706:b0:6af:125a:1c6a with SMTP id 00721157ae682-6c0a1493f4cmr6884937b3.41.1724191297582;
        Tue, 20 Aug 2024 15:01:37 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e1d938csm20136907b3.141.2024.08.20.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:01:36 -0700 (PDT)
Date: Tue, 20 Aug 2024 18:01:34 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: align watchdog clocks
Message-ID: <wiyw7h7hkc7u2brehi6zgxykesajtqmwwajo7tpwwvayjtcykw@w7rcmojs62vi>
References: <20240805174330.2132717-2-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805174330.2132717-2-echanude@redhat.com>

On Mon, Aug 05, 2024 at 01:42:51PM GMT, Eric Chanudet wrote:
> assigned-clock sets DEV_RTIx_RTI_CLK(id:0) whereas clocks sets
> DEV_RTIx_RTI_CLK_PARENT_GLUELOGIC_HFOSC0_CLKOUT(id:1)[1]. This does not
> look right, the timers in the driver assume a max frequency of 32kHz for
> the heartbeat (HFOSC0 is 19.2MHz on j784s4-evm).
> 
> With this change, WDIOC_GETTIMELEFT return coherent time left
> (DEFAULT_HEARTBEAT=60, reports 60s upon opening the cdev).
> 
> [1] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/clocks.html#clocks-for-rti0-device
> 
> Fixes: caae599de8c6 ("arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog instances")
> Suggested-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

Gentle ping and update to the test comment.

> ---
> I could not get the watchdog to do more than reporting 0x32 in
> RTIWDSTATUS. Setting RTIWWDRXCTRL[0:3] to generate a reset instead of an
> interrupt (0x5) didn't trigger a reset either when the window expired.

Re-testing using u-boot from the BSP (2023.04) has the board reset as
expected when the watchdog expires and WDIOC_GETTIMELEFT report the time
left coherently with this patch until that happens.

I initially had a u-boot with a DT lacking:
	"mcu_esm: esm@40800000"
and I could reproduce the board not resetting by commenting in its
description:
	"ti,esm-pins = <95>;"

I don't understand why that is on the other hand. The TRM says ESM0
ERR_O drives the SOC_SAFETY_ERRORn pin, which goes to the PMIC GPIO3 on
the schematic _and_ to MCU_ESM0 as an error input event. The tps6594-esm
module is probing successfully and it sets both ESM_SOC_EN|ESM_SOC_ENDRV
and ESM_SOC_START, so I would expect the PMIC to reset the board without
MCU_ESM0 being described or configured by u-boot.

Best,

> 
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 38 +++++++++++-----------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f170f80f00c1..6c014d335f2c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -2429,7 +2429,7 @@ main_esm: esm@700000 {
>  	watchdog0: watchdog@2200000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2200000 0x00 0x100>;
> -		clocks = <&k3_clks 348 1>;
> +		clocks = <&k3_clks 348 0>;
>  		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 348 0>;
>  		assigned-clock-parents = <&k3_clks 348 4>;
> @@ -2438,7 +2438,7 @@ watchdog0: watchdog@2200000 {
>  	watchdog1: watchdog@2210000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2210000 0x00 0x100>;
> -		clocks = <&k3_clks 349 1>;
> +		clocks = <&k3_clks 349 0>;
>  		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 349 0>;
>  		assigned-clock-parents = <&k3_clks 349 4>;
> @@ -2447,7 +2447,7 @@ watchdog1: watchdog@2210000 {
>  	watchdog2: watchdog@2220000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2220000 0x00 0x100>;
> -		clocks = <&k3_clks 350 1>;
> +		clocks = <&k3_clks 350 0>;
>  		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 350 0>;
>  		assigned-clock-parents = <&k3_clks 350 4>;
> @@ -2456,7 +2456,7 @@ watchdog2: watchdog@2220000 {
>  	watchdog3: watchdog@2230000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2230000 0x00 0x100>;
> -		clocks = <&k3_clks 351 1>;
> +		clocks = <&k3_clks 351 0>;
>  		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 351 0>;
>  		assigned-clock-parents = <&k3_clks 351 4>;
> @@ -2465,7 +2465,7 @@ watchdog3: watchdog@2230000 {
>  	watchdog4: watchdog@2240000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2240000 0x00 0x100>;
> -		clocks = <&k3_clks 352 1>;
> +		clocks = <&k3_clks 352 0>;
>  		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 352 0>;
>  		assigned-clock-parents = <&k3_clks 352 4>;
> @@ -2474,7 +2474,7 @@ watchdog4: watchdog@2240000 {
>  	watchdog5: watchdog@2250000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2250000 0x00 0x100>;
> -		clocks = <&k3_clks 353 1>;
> +		clocks = <&k3_clks 353 0>;
>  		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 353 0>;
>  		assigned-clock-parents = <&k3_clks 353 4>;
> @@ -2483,7 +2483,7 @@ watchdog5: watchdog@2250000 {
>  	watchdog6: watchdog@2260000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2260000 0x00 0x100>;
> -		clocks = <&k3_clks 354 1>;
> +		clocks = <&k3_clks 354 0>;
>  		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 354 0>;
>  		assigned-clock-parents = <&k3_clks 354 4>;
> @@ -2492,7 +2492,7 @@ watchdog6: watchdog@2260000 {
>  	watchdog7: watchdog@2270000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2270000 0x00 0x100>;
> -		clocks = <&k3_clks 355 1>;
> +		clocks = <&k3_clks 355 0>;
>  		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 355 0>;
>  		assigned-clock-parents = <&k3_clks 355 4>;
> @@ -2506,7 +2506,7 @@ watchdog7: watchdog@2270000 {
>  	watchdog8: watchdog@22f0000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x22f0000 0x00 0x100>;
> -		clocks = <&k3_clks 360 1>;
> +		clocks = <&k3_clks 360 0>;
>  		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 360 0>;
>  		assigned-clock-parents = <&k3_clks 360 4>;
> @@ -2517,7 +2517,7 @@ watchdog8: watchdog@22f0000 {
>  	watchdog9: watchdog@2300000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2300000 0x00 0x100>;
> -		clocks = <&k3_clks 356 1>;
> +		clocks = <&k3_clks 356 0>;
>  		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 356 0>;
>  		assigned-clock-parents = <&k3_clks 356 4>;
> @@ -2528,7 +2528,7 @@ watchdog9: watchdog@2300000 {
>  	watchdog10: watchdog@2310000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2310000 0x00 0x100>;
> -		clocks = <&k3_clks 357 1>;
> +		clocks = <&k3_clks 357 0>;
>  		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 357 0>;
>  		assigned-clock-parents = <&k3_clks 357 4>;
> @@ -2539,7 +2539,7 @@ watchdog10: watchdog@2310000 {
>  	watchdog11: watchdog@2320000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2320000 0x00 0x100>;
> -		clocks = <&k3_clks 358 1>;
> +		clocks = <&k3_clks 358 0>;
>  		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 358 0>;
>  		assigned-clock-parents = <&k3_clks 358 4>;
> @@ -2550,7 +2550,7 @@ watchdog11: watchdog@2320000 {
>  	watchdog12: watchdog@2330000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2330000 0x00 0x100>;
> -		clocks = <&k3_clks 359 1>;
> +		clocks = <&k3_clks 359 0>;
>  		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 359 0>;
>  		assigned-clock-parents = <&k3_clks 359 4>;
> @@ -2561,7 +2561,7 @@ watchdog12: watchdog@2330000 {
>  	watchdog13: watchdog@23c0000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x23c0000 0x00 0x100>;
> -		clocks = <&k3_clks 361 1>;
> +		clocks = <&k3_clks 361 0>;
>  		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 361 0>;
>  		assigned-clock-parents = <&k3_clks 361 4>;
> @@ -2572,7 +2572,7 @@ watchdog13: watchdog@23c0000 {
>  	watchdog14: watchdog@23d0000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x23d0000 0x00 0x100>;
> -		clocks = <&k3_clks 362 1>;
> +		clocks = <&k3_clks 362 0>;
>  		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 362 0>;
>  		assigned-clock-parents = <&k3_clks 362 4>;
> @@ -2583,7 +2583,7 @@ watchdog14: watchdog@23d0000 {
>  	watchdog15: watchdog@23e0000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x23e0000 0x00 0x100>;
> -		clocks = <&k3_clks 363 1>;
> +		clocks = <&k3_clks 363 0>;
>  		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 363 0>;
>  		assigned-clock-parents = <&k3_clks 363 4>;
> @@ -2594,7 +2594,7 @@ watchdog15: watchdog@23e0000 {
>  	watchdog16: watchdog@23f0000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x23f0000 0x00 0x100>;
> -		clocks = <&k3_clks 364 1>;
> +		clocks = <&k3_clks 364 0>;
>  		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 364 0>;
>  		assigned-clock-parents = <&k3_clks 364 4>;
> @@ -2605,7 +2605,7 @@ watchdog16: watchdog@23f0000 {
>  	watchdog17: watchdog@2540000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2540000 0x00 0x100>;
> -		clocks = <&k3_clks 365 1>;
> +		clocks = <&k3_clks 365 0>;
>  		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 365 0>;
>  		assigned-clock-parents = <&k3_clks 366 4>;
> @@ -2616,7 +2616,7 @@ watchdog17: watchdog@2540000 {
>  	watchdog18: watchdog@2550000 {
>  		compatible = "ti,j7-rti-wdt";
>  		reg = <0x00 0x2550000 0x00 0x100>;
> -		clocks = <&k3_clks 366 1>;
> +		clocks = <&k3_clks 366 0>;
>  		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
>  		assigned-clocks = <&k3_clks 366 0>;
>  		assigned-clock-parents = <&k3_clks 366 4>;
> -- 
> 2.45.2
> 

-- 
Eric Chanudet


