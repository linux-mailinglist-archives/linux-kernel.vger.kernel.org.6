Return-Path: <linux-kernel+bounces-552408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFCA5799A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC01B1896B35
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B919DF9A;
	Sat,  8 Mar 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="driDAFO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6YzQ5b65"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F518C32C;
	Sat,  8 Mar 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427262; cv=none; b=osC9GGA+IW0TjFFgim3ADdoGtWrv+3F0hMpLFtX4AnDcX0WKl0lQgu7z6hLHycEwGTAEPk+ZUlH10LcbCHiDJvBExBwxev+yVi+NOIMUsV8gfTXc4uI1nm7YJER+4Q25E7MZg/2sW4YOHwgAAtfO/a8P5Z8nDXKMFyW65Ji+0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427262; c=relaxed/simple;
	bh=Nu3oTGUTRl8dtZKtoNaGor+v1mBxjfMjIW+vZCAKyy4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GjiFB88tr+veyCeAXcZDS971dAK2kKVLCkeokua2aJeX77zZMf/tROUPKwzbd2fa39S5/0Df7LBnU5a9tH6tzT+/Emx9oH8HX8/h3DgyHHAyKLGykl1uFy13zrvBk/yH+LOQOXVlTsmav/PgG52c0OC4MH3oQ15GIiPY+Gc4Kx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=driDAFO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6YzQ5b65; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 651C21140084;
	Sat,  8 Mar 2025 04:47:39 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Sat, 08 Mar 2025 04:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741427259; x=1741513659; bh=Tc9wAy3ut+Vg9RzNHJrfHWG2bPYNxL7J
	OfNTz/yRTDQ=; b=driDAFO0NZrxdvvwDA1O+Rk531jO9s8y56jo+o0AVsVC7/tq
	uX/Q4qakFhaS8GQSoJ9FaToMJL5MVDQlrLmY5ACe0BPGKp2AXoTO3kU/2Y9FxIjQ
	nKJxBZjeZtpEoFGqxjWHNfwG28cDWwMgExFZcUoAoxFbjHcBCvnnmZ7lNCdErJOZ
	2lfrpqrIqAVzEJF0H4YLXKvCLwoZ/IyTj+AsfU24ashrCLyH4KULq/8BC5a8hN4q
	WndRJhVKemvw1abZ2ircoIaCyQS5PZynnJnPiTAismUJ4rfdFUBZashH/dXTZ5P6
	/Jo7zoqxvJ1lXrlcInnyW+qreVTjR7wTqadbbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741427259; x=
	1741513659; bh=Tc9wAy3ut+Vg9RzNHJrfHWG2bPYNxL7JOfNTz/yRTDQ=; b=6
	YzQ5b65Lj6wAmvXzDLaFHAxp4O7c80P4+1TX+O0/CALxYIiA726EW8bgWnKLKF7V
	vovLzRVYyANHmWG6j9CyqbuaCzzXQgMCD4xpmDdRIr1xYjpzrUhDaU0zqSXdKUxk
	qh1s5AfuQfvmLfcxIiQKyyBLlq4exN3SHMatd5YUlu65MLgM3pioHnSJPLIy29/L
	q8OwlitUYbvARunwSfNRARJYkL3zuNTP83lZQS7snWz6D9VMOei1BYYbL6C9tY9g
	iY7Mpu3ZOHoBA0Hb+DPKVv73rysYUsqIZsAiSAOq+PFZT5/JfwKOE6oMoknx0kh4
	8pV6oxwR7aiivaIihd7pg==
X-ME-Sender: <xms:OhLMZ9efGwv-1PTaJNcei2Y4Tn9FlbL_YCxJahngoYQl7BXgDW9O7g>
    <xme:OhLMZ7NUiKCD9JiJ_GqJBqNEBMseyh-PcQf7_i-ihB58LsaZeO90JrpZksl6z9sf9
    MgGKzmAmu03qurD2Jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveek
    ueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhnkhhlrd
    hkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehtohifihhntghhvghnmhhi
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpth
    htoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:OhLMZ2g6iRx_AzoIqsQUuwEoRy1-Zpberf9r-KcbDj4xMXxZ05iBWw>
    <xmx:OhLMZ2-6qr2kWU59ecNlencmmO076L71A_yCTHWEsgrlTdzJWB7qzw>
    <xmx:OhLMZ5vfyIGVu3hQm2yrhIDMhCpq3NpkbR1FUtsSzypxGm6aXqY9lA>
    <xmx:OhLMZ1ETN8n_jdwsZ8C9emPyNLs1J-O4bbkVxDRxlr9JKgdh1_6R7g>
    <xmx:OxLMZ1GcbORkHihKMIBCw_Li5G4ir0qsL0MoEtQr3m4ZVsR6QffoWJbH>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C6CB3BA006F; Sat,  8 Mar 2025 04:47:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 10:47:18 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "Nick Chan" <towinchenmi@gmail.com>
Message-Id: <e7a253bf-8e8b-4845-a38f-51bc00ad677c@app.fastmail.com>
In-Reply-To: <20250307-spmi-v2-3-eccdb06afb99@gmail.com>
References: <20250307-spmi-v2-0-eccdb06afb99@gmail.com>
 <20250307-spmi-v2-3-eccdb06afb99@gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: apple: Add SPMI controller nodes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Fri, Mar 7, 2025, at 21:09, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Add device tree entries for the SPMI controller
>
> Reviewed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi | 7 +++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi      | 8 ++++++++
>  arch/arm64/boot/dts/apple/t8112.dtsi      | 7 +++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi 
> b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> index 
> b1c875e692c8fb9c0af46a23568a7b0cd720141b..d544a35c8af414c583d38b040e1aa753902f1c93 
> 100644
> --- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> @@ -53,6 +53,13 @@ wdt: watchdog@2922b0000 {
>  		interrupts = <AIC_IRQ 0 631 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> 
> +	nub_spmi0: spmi@2920a1300 {
> +		compatible = "apple,t6000-spmi", "apple,spmi";
> +		reg = <0x2 0x920a1300 0x0 0x100>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +	};
> +

Please keep the nodes ordered by their MMIO address.
The watchdog node above is at 2922b0000 and should come after
spmi@2920a1300. Please also check the other nodes you're adding
here.

>  	sio_dart_0: iommu@39b004000 {
>  		compatible = "apple,t6000-dart";
>  		reg = <0x3 0x9b004000 0x0 0x4000>;
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi 
> b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 
> 9b0dad6b618444ac6b1c9735c50cccfc3965f947..0f03dc808cf7c6b7d71afc79dd29d368f957f979 
> 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/apple-aic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/apple.h>
> +#include <dt-bindings/spmi/spmi.h>
> 
>  / {
>  	compatible = "apple,t8103", "apple,arm-platform";
> @@ -604,6 +605,13 @@ pcie_pins: pcie-pins {
>  			};
>  		};
> 
> +		nub_spmi: spmi@23d0d9300 {
> +			compatible = "apple,t8103-spmi", "apple,spmi";
> +			reg = <0x2 0x3d0d9300 0x0 0x100>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
>  		pinctrl_nub: pinctrl@23d1f0000 {
>  			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
>  			reg = <0x2 0x3d1f0000 0x0 0x4000>;
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi 
> b/arch/arm64/boot/dts/apple/t8112.dtsi
> index 
> 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..fecf70eba255c668757e2edfe25a4e9e7c0d0bad 
> 100644
> --- a/arch/arm64/boot/dts/apple/t8112.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -641,6 +641,13 @@ pcie_pins: pcie-pins {
>  			};
>  		};
> 
> +		nub_spmi: spmi@23d714000 {
> +			compatible = "apple,t8112-spmi", "apple,spmi";
> +			reg = <0x2 0x3d714000 0x0 0x100>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
>  		pinctrl_nub: pinctrl@23d1f0000 {
>  			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
>  			reg = <0x2 0x3d1f0000 0x0 0x4000>;
>
> -- 
> 2.48.1


thanks,


Sven

