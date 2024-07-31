Return-Path: <linux-kernel+bounces-268536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAC9425E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F54A28768F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2234E1B3;
	Wed, 31 Jul 2024 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ioYu4bWi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736849643;
	Wed, 31 Jul 2024 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404623; cv=none; b=XhYTVrfxSqloiY7636bVEcxgWlaujg5FhVm9Z2Uk96mgj0nnJYUQL4jHexkrLqAGgbjiQW0cBnrAMvUE1Koj7I9PTvsYkTyf67M/k7fGAOtAzP5MZpb7vtwPw+X9eHv8nAr54VDG3l71B/+kroPegxV2CAvKigoCz0Gl1QT+poY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404623; c=relaxed/simple;
	bh=7nIvlbwFyFJE/Qy3OjuEZ4hhCdB6Rr+OIuVEIt2km94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jl9rmbWX1BPOHwT7Hzm5KhJbp0Qc9xYulIyyoGjTNwPJ+8hA2UVL89GrNlVAof3Uwc6FtFW5UaqUfftJG/aaP3qmvJD5cQwB6GrtSW7tcpauIY0cRycQZflLJFnn9cdxsehCvPMvLRhDuJRcbSOwcQLVVyU8C8D/OAgO594qKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ioYu4bWi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46V5hT22065986;
	Wed, 31 Jul 2024 00:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722404609;
	bh=3r9PTWzvN5H+b40F4RKaTChUoLRqaWMmaRO5hXHpP90=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ioYu4bWiHlYC4EQMXVQIxTl7Ur0iEln4mRjGuHGxCiS/kD1SYALa/eDfNo6PpiFG7
	 qFzsepOFooC4PlFh+G5jTaa/Nf0nO1uyg6iSgWgm7CHIs7ULypwvV/5Owikkb2Uj7I
	 Czg2Ji2NJS6uT8ajO+EDhlT77W+7FbOLrM2zekNI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46V5hTf1106339
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 00:43:29 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 00:43:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 00:43:28 -0500
Received: from [172.24.227.248] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46V5hOB5077514;
	Wed, 31 Jul 2024 00:43:25 -0500
Message-ID: <a456bde9-e00f-4aed-be28-9874b0d57674@ti.com>
Date: Wed, 31 Jul 2024 11:13:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
To: Parth Pancholi <parth105105@gmail.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: Parth Pancholi <parth.pancholi@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240730093754.1659782-1-parth105105@gmail.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240730093754.1659782-1-parth105105@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Parth,

Thank you for the patch.

On 30/07/24 15:07, Parth Pancholi wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Correct the McASP nodes - mcasp3 and mcasp4 with the right
> DMAs thread IDs as per TISCI documentation [1] for J784s4.
> This fixes the related McASPs probe failure due to incorrect
> DMA IDs.
> 
> Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids/ [1]
> Fixes: 5095ec4aa1ea ("arm64: dts: ti: k3-j784s4-main: Add McASP nodes")
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f170f80f00c1..d4ac1c9872a5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -2755,7 +2755,7 @@ mcasp3: mcasp@2b30000 {
>   		interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "tx", "rx";
> -		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
> +		dmas = <&main_udmap 0xc403>, <&main_udmap 0x4403>;
>   		dma-names = "tx", "rx";
>   		clocks = <&k3_clks 268 0>;
>   		clock-names = "fck";
> @@ -2773,7 +2773,7 @@ mcasp4: mcasp@2b40000 {
>   		interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "tx", "rx";
> -		dmas = <&main_udmap 0xc501>, <&main_udmap 0x4501>;
> +		dmas = <&main_udmap 0xc404>, <&main_udmap 0x4404>;
>   		dma-names = "tx", "rx";
>   		clocks = <&k3_clks 269 0>;
>   		clock-names = "fck";
Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>


Warm Regards,
Jayesh

