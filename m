Return-Path: <linux-kernel+bounces-302036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC595F902
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7311F24349
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B34823A9;
	Mon, 26 Aug 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="No8VuR94"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868041991AB;
	Mon, 26 Aug 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697104; cv=none; b=IVurT0sEPC4P9Alzki2ylM6dIocRvN69jR4l9o3GDo83mbp9dtz9Cbavg7M93/VzlgTuVxyHGWztgmwmlD9oh6KAsf8mGIOv307OHTcPdBYPG2IrlGEKXi8nnGlYCW7YxW2fVweOA4Rk9V8DDrFmpNyb84JrNcszzyWO5bN1QE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697104; c=relaxed/simple;
	bh=PkNHwVHsVWhLWq3VRZ8fSv78RNki9EGyaMJzwVcd1cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gpgHEVxKqigbJoFqCunDUF6vRdyl9cXu4y/qeVSNUkXx1MBZeU0PNe1Bti4u+a1Nh0BhX0wlTLGrKOaV5/x6YkqhA5gjq5QrK8c5er8bEQg7MozmwUo2UkuDWyR8igkUfr1gg/q6NvA0Vger/giZ2ODDdL0YzRHi8yZ7mck/uKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=No8VuR94; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QIVWEn021081;
	Mon, 26 Aug 2024 13:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724697092;
	bh=CHCCG/rKE82GSdyXAUyJ/il42/mS9IcJSr+sHbXdeSA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=No8VuR946hLo6hWs1SsUERAmfQZDhmo1fsPcEzBydePHujWRRkQhCZrlPueCSEkdh
	 0thk61yewOTV0ZoNZSh/2xXGWtFWOqXKWTv8lAjpbn+Oyy0ShcZohoSJOb4Yf2d4OK
	 LYXc9LPzg+AgR3OdQ1dxEy6Dsj+/XTF5GZPjnVII=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QIVWH1103470
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 13:31:32 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 13:31:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 13:31:32 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QIVS7Z071773;
	Mon, 26 Aug 2024 13:31:29 -0500
Message-ID: <a3902df3-024d-4a0a-810a-0a9b24cfada5@ti.com>
Date: Tue, 27 Aug 2024 00:01:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: align watchdog clocks
To: Eric Chanudet <echanude@redhat.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, J Keerthi <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        <u-kumar1@ti.com>
References: <20240805174330.2132717-2-echanude@redhat.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240805174330.2132717-2-echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/5/2024 11:12 PM, Eric Chanudet wrote:
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
> ---
> I could not get the watchdog to do more than reporting 0x32 in
> RTIWDSTATUS. Setting RTIWWDRXCTRL[0:3] to generate a reset instead of an
> interrupt (0x5) didn't trigger a reset either when the window expired.


Tested-by: Udit Kumar <u-kumar1@ti.com>

Able to reset the board

https://gist.github.com/uditkumarti/1d1b66b250949a911b008728445db9c2


>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 38 +++++++++++-----------
>   1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f170f80f00c1..6c014d335f2c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -2429,7 +2429,7 @@ main_esm: esm@700000 {
>   	watchdog0: watchdog@2200000 {
>   		compatible = "ti,j7-rti-wdt";
>   		reg = <0x00 0x2200000 0x00 0x100>;
> -		clocks = <&k3_clks 348 1>;
> +		clocks = <&k3_clks 348 0>;
>   		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
> [...]

