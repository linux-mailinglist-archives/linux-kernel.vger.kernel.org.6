Return-Path: <linux-kernel+bounces-246241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7392BF7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D61F2571E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5795B158A36;
	Tue,  9 Jul 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ke2B6Lhj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2119CCE2;
	Tue,  9 Jul 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541792; cv=none; b=mI7WhOi6DTYJPbswpxJLsCjIUIH8feT7SD/sW1FeJ9EgWbWuVk/QpUu2HdUHuJGZk5WdEhpGP8Wi++h6mea1Q8zcoMPk2vOB2SOmPm127va/hHSvQGWECi9w2fRM2HOg9lPwmBW/UO+3fIfkbh+tkG5hP2X5mJPC30x4brLrRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541792; c=relaxed/simple;
	bh=Wac3H0Db3qXfYF3Jn0UPjaBVmOpSO6H/SsDk79ZzFm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YeO+fyRPrYPtRqvHsApS4N7xKZJshWEJ7KCUzOj5N3McjXThJBW7TCjeiwz0/juvQKWHNIY5r6CgEIbenCYDzataJHE9RdOBD0+yNxoljgGGAS8h6FhAd2enb0gg2zKhu5TeGz8XDg4ILdKO9BwykAhMJrg6AEqCckVboslp+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ke2B6Lhj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 469GGGaE128937;
	Tue, 9 Jul 2024 11:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720541776;
	bh=V4jAQwPKr1ZXAxeyrE183GLAcSFjKu8019oQfUyoCxM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ke2B6LhjocNQMbk+6IRzoYCyjJczLyIZQH00dKTHtevH7obs3+YekHqgIdRGH+ye+
	 Ghtm8c5vhDwQKzPRuO7yOdz+/ZnX35fsTSuQwFbhYFsFy/7YBA6N0s2g8am8SMqI62
	 QbJTZjKq2daw4NL5ZuGXKEsAPh0s+q/qimfwMcpU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 469GGF3W077469
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 11:16:15 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jul 2024 11:16:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jul 2024 11:16:15 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 469GGB2Z086509;
	Tue, 9 Jul 2024 11:16:12 -0500
Message-ID: <39caa8a7-bc40-4f7e-87e1-005c8b677655@ti.com>
Date: Tue, 9 Jul 2024 21:46:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j7xx: Change timer nodes status to
 reserved
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <tony@atomide.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240607105559.771080-1-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240607105559.771080-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Beleswa,

On 6/7/2024 4:25 PM, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. Therefore, change the status of the timer nodes to
> "reserved" to avoid any clash.
>
> This change is already incorporated for timer nodes in the MCU voltage
> domain.
>
> Fixes: 835d04422f9d ("arm64: dts: ti: k3-j721s2: Add general purpose timers")
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  |  2 ++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi  |  7 +++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  6 ++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 10 ++++++++++
>   4 files changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 9386bf3ef9f68..22351a4f3da6e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -1254,6 +1254,7 @@ main_timer0: timer@2400000 {
>   		assigned-clock-parents = <&k3_clks 49 2>;
>   		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
>   		ti,timer-pwm;
> +		status = "reserved";
>   	};


Instead of changing these nodes in base device tree.

I suggest to change in device tree, where those remoteproc drivers are 
getting enabled.


>   
> [..]

