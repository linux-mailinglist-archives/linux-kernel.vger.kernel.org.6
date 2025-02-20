Return-Path: <linux-kernel+bounces-523500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BFA3D79F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1273A3BFBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2B1F2360;
	Thu, 20 Feb 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mCjBNOWF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rwdVB45C"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAE1F152B;
	Thu, 20 Feb 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049135; cv=none; b=ihhEegCJ1VWIzGUhzAxVCUBcLIEuaVcAy9Yr6O+fdTqhY1VAgcp2WonXwsTfWqpPYPSIej8abK2cu7OA6egJqMLsTa8PNw41HtDrbxUwD+ca6FgB+OKtv735IHseraGY3dRMVFfvfUb6gAMxgXdcrCrMgqEOqXQRpkXw+oPnj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049135; c=relaxed/simple;
	bh=hd8U2GHx/GiqbCQONCBvfPhtd6FmIt6ca0diC8qJgrw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oMizNbQEmudootG4I/f1C/sm03fh32Vd931qj8nLrswRNRNa+B1JneLONpxi3tiLO5sWrNMHt0LJ9vMWUIhy5x/ltU3RsnwlgWFqwe9wUzs49d+0NQe5ZSPgSKzUAduHUmTrimcyTHvJYw/gtFPSjGNTq3mpxp/VNhvGrgHs6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mCjBNOWF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rwdVB45C; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2148A138017F;
	Thu, 20 Feb 2025 05:58:52 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Thu, 20 Feb 2025 05:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740049132;
	 x=1740135532; bh=Qp160iELwUVLpaIl0+ASJx5ZNgXaK9DNbEoCN7xfpTA=; b=
	mCjBNOWFZmulhFFBOoOHFm71MoQD/R+gelap6lBfyAOl6sxV4TdMy3Im3w05Dm7t
	BAAmbbLZmA3zkftnXsAROmvXP/xMqMCXJWa7hXtenH23olIZl4l/W7CrA4F/LSoh
	XW/dT4Aoxk3hOSNn2YX6pkCvE69yN2kk773Gk1aorC54rJIfOm3gsVQPTqn9cfXL
	XekhmJWmaTd9lurdFoDMbs3HDTvdIkgApbuOhlyj1GBPcKYe/xZOMCu3wIAj8Z7v
	3uwqayH5tDZhoPavVwv95WecGq3h+ZMaXEwuFSEWTJvT35rOf3QB2qSL6CCmgfC0
	Q9O00xh/lGngF+9pgrDrlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740049132; x=
	1740135532; bh=Qp160iELwUVLpaIl0+ASJx5ZNgXaK9DNbEoCN7xfpTA=; b=r
	wdVB45CP+Kp5k5dscauKGxGU5s6y2WVMsNVdETe1/e4hqMxRA8WDPS9Ra3bB6aFW
	UfcZDURkkwfZH/l2SKbOvyWfzcsU1d5vekBK9N9XxPP36A2PBMFFgd50MhJZD3hA
	C88su7xttUV2BtXGcABrUYnRxCbKEK0h++Id0plcQc+H4JXsot0r9XXdI193dv0K
	3paLFyKQBua8hCdSV0Adg1QExMmh8ZucwjlT1M+Z/ggPhNaqfdM4Ynhe+SwCXT6m
	LlMDDcJdnPKQZ2E1hS2u81KYW9sbYYsvIepfKB8y7jR/ddzJDvYIZhGVwXevM+AS
	IhnL00Q/3gguM3r20Cf8Q==
X-ME-Sender: <xms:6wq3ZyQ7bqO9AK2WZNO4z7rhStOGpeOv7vHiHekXl4t0z9wbCp8wWg>
    <xme:6wq3Z3yiN6Q6Y01R749Sc-2cwwMizhyBFwrTNkJL3cQ-CphyQ5WfSsqiB82niSM2r
    XoR8eOjWZxWyRlgRUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinh
    grshesrghrmhdrtghomhdprhgtphhtthhopegtihigqdhkvghrnhgvlhdquhhpshhtrhgv
    rghmsegtihigthgvtghhrdgtohhmpdhrtghpthhtohepfhhughgrnhhgrdguuhgrnhestg
    higihtvggthhdrtghomhdprhgtphhtthhopehpvghtvghrrdgthhgvnhestghigihtvggt
    hhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghh
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgr
    uggvrggurdhorhhg
X-ME-Proxy: <xmx:6wq3Z_3uWzH5TB0G_LAruDI2NuLsaj_BbaIbMraJsG58cZEXAs9jjA>
    <xmx:6wq3Z-B7-5hlL7QhpGEwho2xd9gh17PkethH2OWkyEK3VgggyCoDrw>
    <xmx:6wq3Z7jCIsOtkx_8otBZKM2tz3jCjhmrXAGrVCg_0xu0i3VSvPoUoQ>
    <xmx:6wq3Z6rUROM4_ZYrlVgyOviNtBugsETwUayYnfK_UCQfrQssfOm31w>
    <xmx:7Aq3ZwZzH51pcIjvywnFATaixNs2CWtscznax6qQhN0uPGB5VZ6Q2zJi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F3082220072; Thu, 20 Feb 2025 05:58:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Feb 2025 11:58:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Chen" <peter.chen@cixtech.com>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 "Fugang . duan" <fugang.duan@cixtech.com>
Message-Id: <4add2867-8c09-454a-b3e2-b4baaeccfd44@app.fastmail.com>
In-Reply-To: <20250220084020.628704-7-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-7-peter.chen@cixtech.com>
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2025, at 09:40, Peter Chen wrote:

> +#include "sky1.dtsi"
> +/ {
> +       model = "Radxa Orion O6";
> +       compatible = "radxa,orion-o6";

This should list both the compatible string for the board and
the one for the SoC.

> +
> +       aliases {
> +               serial2 = &uart2;
> +       };

Please put the aliases in the .dts file, not the chip specific
.dtsi file, as each board typically wires these up differently.

Note that the 'serial2' alias names are meant to correspond
to whatever label you find on the board, not the internal
numbering inside of the chip they are wired up to. Usually
these start with 'serial0' for the first one that is enabled.

> +               CPU0: cpu0@0 {
> +                       compatible = "arm,armv8";
> +                       enable-method = "psci";

This should list the actual identifier of the CPU core, not
just "arm,armv8" which is the generic string used in the
models for emulators that don't try to model a particular
core.

> +       memory@80000000 {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               device_type = "memory";
> +               reg = <0x00000000 0x80000000 0x1 0x00000000>;
> +       };

The memory size is not part of the SoC either, unless the only
way to use this SoC is with on-chip eDRAM or similar.

Normally this gets filled by the bootloader based on how
much RAM gets detected.

> +               linux,cma {
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +                       size = <0x0 0x28000000>;
> +                       linux,cma-default;
> +               };

Same here, this is a setting from the firmware, not the
SoC.

> +       sky1_fixed_clocks: fixed-clocks {
> +               uartclk: uartclk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <100000000>;
> +                       clock-output-names = "uartclk";

> +               uart_apb_pclk: uart_apb_pclk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <200000000>;
> +                       clock-output-names = "apb_pclk";


Clock names don't need "clk" in them, and there should
be no underscore -- use '-' instead of '_' when separating
strings in DT.

> +       soc@0 {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               dma-ranges;
> +
> +               uart2: uart@040d0000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x0 0x040d0000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "uartclk", "apb_pclk";
> +                       clocks = <&uartclk>, <&uart_apb_pclk>;
> +                       status = "disabled";
> +               };

It seems strange to list only "uart2" -- usually the dtsi file contains
all of the instances that are present on the chip and leave it
up to the .dts file to enable the ones that are used.

      Arnd

