Return-Path: <linux-kernel+bounces-187294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29D8CCFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B572837FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60113D618;
	Thu, 23 May 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j1WGJSfz"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C12A929;
	Thu, 23 May 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458099; cv=none; b=FzW3gWs8CtbHUU6flDh9Ag71+uWK+uERgILZ2+Eb2bZoR+X9/osl5goauUsuQSwu9s+rLhFxMMwwu29h40DYWgHsaAssuNEqA2/isTbkuxRWUNyOZDlYNcjQefS0KaeEURNunitwJSyS51kzD7TExrqgg12mUlRmars0LvSthNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458099; c=relaxed/simple;
	bh=jRwumRBtxAKuVqRoLekvSCRPcpJJN2Bo6lT9gsNUCvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L81U24rPC2mvpjsGiOiTYp0w2tIo3R5m7vyA7+wMTKc9S1GdRSGtRpIKZPUis22J7jwe288NpBHl17n/pXWRIIlf41+8u7XD/jwlBIR1ZajxDkQqBvtzeFQSiaeYXZe+PqpzZ6s7idrW8RM7JFzXDOk6ArOuTZKS9yOTm/9XVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j1WGJSfz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44N9smVT075328;
	Thu, 23 May 2024 04:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716458088;
	bh=jx13z+9Ch6ZmYMVuWybOQTRsnPzK7wjSAS29/oe3F/E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j1WGJSfzHe1hyvnLmIZHLROVofnHnqM7unyhWL4X/FWPP4LKHUwYsyVpl/n0xi70s
	 wJIspzwwT/A4RT92EZzwpBEWIsTW+fC+vKvZ1h5KTzXor6Ev9M+IGgvW39Ob3x1ARi
	 281Lydkqrmw2ERAtWAuGou4tp399v1vpgxxNyh/0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44N9sml8009293
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 04:54:48 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 04:54:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 04:54:48 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44N9siRN090840;
	Thu, 23 May 2024 04:54:45 -0500
Message-ID: <24d0579a-1c8d-42ea-afa5-dcd0ab3fa193@ti.com>
Date: Thu, 23 May 2024 15:24:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Mark eMMC as non removable
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <jm@ti.com>, <nm@ti.com>
References: <20240522083631.1015198-1-b-kapoor@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240522083631.1015198-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 22/05/24 14:06, Bhavya Kapoor wrote:
> Mark the eMMC module on J722S as non removable since it
> is always present on the evm.

Nit s/evm/EVM

> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---

This needs a Fixes tag?

>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index bf3c246d13d1..fe810e32cb7a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -369,6 +369,7 @@ partition@3fc0000 {
>  &sdhci0 {
>  	disable-wp;
>  	bootph-all;
> +	non-removable;
>  	ti,driver-strength-ohm = <50>;
>  	status = "okay";
>  };


-- 
Regards
Vignesh

