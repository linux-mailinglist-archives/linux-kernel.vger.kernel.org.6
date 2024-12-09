Return-Path: <linux-kernel+bounces-437992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB5E9E9B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413C51888B69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10C13C81B;
	Mon,  9 Dec 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wgaEos52"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A317F48C;
	Mon,  9 Dec 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761000; cv=none; b=XWTMdvqJO37WsNMPJ2Ud3l9H86nT4rRbddUoiQPMHzgbXX1hESEMCvWNP+p8Nrr5VwKnrYhr5aYNggK2oMFyK0+FtiqB6blSjScq9y+YD/R1/xLpwnpTYZ0tUlLF74I7yuh1VjnnVmQQCBw50Z3cK4b0VKKyQ6GEhlx+g7TouPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761000; c=relaxed/simple;
	bh=qPAlXioGw1zBnH/UBkCy036skYuuSw1WeTlI90WTYqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rv3aN4SWM6Da4MY4xGqtNYviD8qJlrmxGMQFcS14/K/YKv5RBq3YlWAyayeK2KLN8FKGJ5AIaZOMKijBsuEvw7/15pEiJ20SHqDXFlQXQcFgd1Zc6vBv39fqoC6zwMtY4vZ6goSUd21TpjuRNIh4v7HzAeFRAHjHhK9mwoJ/wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wgaEos52; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9G4lW9012527;
	Mon, 9 Dec 2024 17:16:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6gt6BiM0QgyBm6Yq6Z5iu8g08qp3vEHqvhnzyciWVbM=; b=wgaEos52tZiBCPeN
	i0JXCrahbIonwvPX8eIV4gJfwtv08sIWTHofWdwonth4MPkaBiXmNtnXi0JUg1ZN
	TY5//m6DHe3WEBYjkdKEh+749ssbGk5f0r6yDFw2IteVhuy1GloB3Qmeog33dVVM
	uk/zXnEv11L03lxZI/tAcPs52nSxt6ajCJ3U7FLMr3wi8X4XnDsqAqnZvNRfns3K
	iX7ofWljFic26qc/AduI1+e2IRdnbnJWNxEt+5emRnyehSZt+iHkvjthrSfP1Lst
	21ubya6dSX9gaTjYw56ZFLkGRGdjPKl8HS+nIqhVh01EBdYoH1yi4fcuOZGlT3Yn
	TuVebw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccc8rrd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:16:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B6BB340061;
	Mon,  9 Dec 2024 17:15:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E016A26D755;
	Mon,  9 Dec 2024 17:14:30 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 17:14:30 +0100
Message-ID: <d38f2ea1-17c3-466c-9537-0a5e31a5225e@foss.st.com>
Date: Mon, 9 Dec 2024 17:14:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: st: add i2s support to stm32mp251
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241113082510.2354924-1-olivier.moysan@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241113082510.2354924-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Olivier

On 11/13/24 09:25, Olivier Moysan wrote:
> Add I2S support to STM32MP25 SoCs.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 45 ++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 6fe12e3bd7dd..8cc0b64e6a16 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -237,6 +237,21 @@ rifsc: bus@42080000 {
>   			#access-controller-cells = <1>;

Applied on stm32-next.

Thanks!
Alex

