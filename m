Return-Path: <linux-kernel+bounces-172685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E418BF561
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147CB1F250D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A516415;
	Wed,  8 May 2024 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PrIdbbVt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1C8F6C;
	Wed,  8 May 2024 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144181; cv=none; b=Cnb9qsZwCmflnLNqH6YXLSpVSo1MlL00qsf1ZaXdPXh9TcjPOI8jsLSSEvTKtDZ1NwPnQaXbm7eVTuRpVS0WCg3XuYE3PWU53mEOlEJ29VQQ9NpNHuf283zXlSST8tbCBVQ5bbTaFu9c4ndNTH2iBGjx5Zba1oWeNotXkrESt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144181; c=relaxed/simple;
	bh=Jyr2hUEWFKADNLWFdVy11ZFHNqpV4stk/iYWvzCKsBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ojN+nsiAhxorJzFLT5BIFq+SvddawIZYEzb6XlONhyaFIHPlArNnvr1vuh4VZ8YBT6kJlKORalJEELCen5Pih1WF7f53An5CW9Zt6OCvauN9ojH93j0a57OaD7WaQIABUkh8od1pzYcDyoeiY2+zh63ofdFgysnT9dGeT4q4pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PrIdbbVt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4484u2YS007973;
	Tue, 7 May 2024 23:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715144162;
	bh=i5ost6/8hJqOm8sNUZyUzXMh+TpN283BjGJn6wA9w1w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PrIdbbVt+PM5XaNGwAUuU0kgKips3Ke5b3rwMKJunbq+/T78afr/JJtyb7gTwST9y
	 kU1c2s+XKMnPEQCYVn7j+tVUTyH4kKr2iQIhaOozjmTeezTu7K0txg5AlPW5opZW1A
	 TDDG/gZTBuYJ0uy8vnVwtvV8rGcm45S9mI9T9ef4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4484u2f6111141
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 23:56:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 23:56:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 23:56:02 -0500
Received: from [172.24.30.180] (lt5cd2489kgj.dhcp.ti.com [172.24.30.180])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4484twRF101335;
	Tue, 7 May 2024 23:55:59 -0500
Message-ID: <dc369d86-2a67-423e-a020-8e7ff58b6029@ti.com>
Date: Wed, 8 May 2024 10:25:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: boot: dts: ti: k3-am68-sk-base-board: Add
 LP8733 and TPS6287 nodes
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240507122158.3739291-1-n-francis@ti.com>
 <20240507122158.3739291-4-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240507122158.3739291-4-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha

On 5/7/2024 5:51 PM, Neha Malcom Francis wrote:
> Add DTS node for LP87334E PMIC and two TPS6287x high current buck
> converters.
>
> LP87334E is responsible for supplying power to the MCU and MAIN domains
> as well as to LPDDR4. The two TPS6287x supply power to the MAIN
> domain for AVS and other core supplies.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Link: https://www.ti.com/lit/pdf/slda060
> ---
> [..]
> +	tps62873b: tps62873@43 {
> +		compatible = "ti,tps6287x";
> +		bootph-pre-ram;

I think,  we don;t need bootph-pre-ram for fixed regulator,

Please check once, if really bootph-pre-ram needed here


> +		reg = <0x43>;
> +		regulator-name = "VDD_CORE_0V8";
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +
>   &mcu_uart0 {
>   	status = "okay";
>   	pinctrl-names = "default";

