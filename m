Return-Path: <linux-kernel+bounces-180886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7198C7462
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182231C226EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A19143890;
	Thu, 16 May 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XMB0JyKg"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375E143754
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854075; cv=none; b=X2KKE0iAqy5uhcH9SpqpSSZijlKl4Dp8Ro5N3mpZAYc7pdKwxACSRhpNMlMxuZ7svr+/DFnB2iaZY2V2y44xEvTJ0EtZcIOiprNch9lJck+WFVgOcrOOhoj1+Wm1yezfrtZ/bTdbmvboAka1fXYQiZQcJYxN27nlXUa3PozNYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854075; c=relaxed/simple;
	bh=JNUgkW/lXjvm5PrcPhIAUFxjKFNX43vl7Pm5LKmpe24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uh0HrGIvN8kGuLAYHXGqGdSZprnm2hAzP7QOVqZP5t8z06uDQt3JcQ5Kue7eadnipot8dToEaid697fDCslmvtrjAgqUi2UtYCy+cbF+zFyF9btln/Vd4CDNNq/amVpmQf7UBKl1dBX+9FIygQjO7VxrixcbVvNVd8mOD2xosTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XMB0JyKg; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44GA7P2w011742;
	Thu, 16 May 2024 05:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715854045;
	bh=QvlmKAAC50R3kqsGcxW7lyLx6cq4f8QASweZUfM85mE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XMB0JyKgrypEB93WkESh50SvnhA0rJuC1tACjNCNhsr1C5bZ2cJmeaoVllt7mu703
	 iHpuE2MMMHxBAAaIuEN178cKv6GzJ4WHFQe4EqNIAkYwW3jAZhRBIDXwjtwBa5uiLm
	 c/Te1VW/9ekQy//h0Klqw0YjD31PYo5K6Wlj1OSQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44GA7Ple016486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 05:07:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 05:07:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 05:07:25 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44GA7K2b114401;
	Thu, 16 May 2024 05:07:21 -0500
Message-ID: <110bdc3f-6605-42b1-92f1-e4773abdd310@ti.com>
Date: Thu, 16 May 2024 15:37:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Modify number of usable 8250 uart ports
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <u-kumar1@ti.com>, <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <arnd@arndb.de>, <biju.das.jz@bp.renesas.com>,
        <neil.armstrong@linaro.org>, <shawnguo@kernel.org>,
        <konrad.dybcio@linaro.org>, <geert+renesas@glider.be>,
        <krzysztof.kozlowski@linaro.org>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Bhavya Kapoor <b-kapoor@ti.com>
References: <20240516095733.276807-1-b-kapoor@ti.com>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240516095733.276807-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 16/05/24 3:27 pm, Bhavya Kapoor wrote:
> Jacinto SoCs have a total of 12 serial uart ports. But only 8 out
> of these 12 uarts can be used at a time.
>
> Thus, Modify maximum number of 8250 serial uart ports which can be
> supported as well as modify how many 8250 serial uart ports which
> we can use in the runtime to 12 for all the SoCs.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---

rebased to next-20240516

>   arch/arm64/configs/defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 57a9abe78ee4..c693736909bc 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -454,7 +454,8 @@ CONFIG_SERIO_AMBAKMI=y
>   CONFIG_LEGACY_PTY_COUNT=16
>   CONFIG_SERIAL_8250=y
>   CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_8250_NR_UARTS=8
> +CONFIG_SERIAL_8250_NR_UARTS=12
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=12
>   CONFIG_SERIAL_8250_EXTENDED=y
>   CONFIG_SERIAL_8250_SHARE_IRQ=y
>   CONFIG_SERIAL_8250_BCM2835AUX=y

