Return-Path: <linux-kernel+bounces-242185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C29284BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAB51C22656
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED91465AE;
	Fri,  5 Jul 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="V0PY1DUG"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9199145FFF;
	Fri,  5 Jul 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170439; cv=none; b=sfLfQqKpwde2fy6JU6iCngGP+ZAVFRzlI16sy27jcUHyVXNh4slhIDSVRPjMW5VGgcl34fPw3Huf6H0RxHGjZMg7YLG6Bi4vVDQSKUnEKlzfNFhWLZIV56qR7OPwlsOVZfQt3LVbbU1QRd1OfaT7MSiQ0E9lexyPV+bHDPvMbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170439; c=relaxed/simple;
	bh=Jk5Bs9a2opcyRfysq8AEnjeypJynwrn0jvgs8PYwc3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fQjV/MuPtnDrcZgbazqP3cgJ/0FS+jxAKwJI5Ehi/R9xUXxRzoVq7OXcN5xSAhvuzeXDNSIEznjRE7dMYf0MoVpZteNmMKFQJpJuBEv1/gGVQinyY//xs11/IpQX2coF28VvZsr08OZTDCStJQtQcoFPHgPRg9vinKuT3pjXnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=V0PY1DUG; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4656SeRg016131;
	Fri, 5 Jul 2024 11:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/qkDRea/v4F+r3YTp4HBLcYRQVWLheSq4GL+1Hmx0o4=; b=V0PY1DUGFz5brcCy
	6WE6UqwKj3pOC9VD1D/mebRmqiCexcRb61+VVvnL9tXdVm6/uCIX8bFwfEi5U0y2
	xKVCNJvK/7SrStSiEUUGhLXvCY5BT3qdFitG0wiUWtgK4l8ExiRxHFZyPSTZxzBy
	9OtcZ1mp+dPFv5Z8euKelxqd/seCcZTolnw3bcgyd+Z9IXnQg/C566d63wZ9yjDv
	YJ9WqmY4ek3ZPYumqMWe5psrzcPE9/L6Www8vBNbwcXiH90lX1GUC+AkzxMGTWO2
	co/0EbHSJH+CH/ZO5jTNEvj12cFgJ2RhSGdp5vl37gqOFmLxqF3CdWKZE04HY4uG
	tvIJmg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4029kx8g9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 11:06:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9BBF040046;
	Fri,  5 Jul 2024 11:06:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 174832194D7;
	Fri,  5 Jul 2024 11:06:07 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 5 Jul
 2024 11:06:06 +0200
Message-ID: <882bd5f5-47f1-4054-9032-300dd457b361@foss.st.com>
Date: Fri, 5 Jul 2024 11:06:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add SCMI regulators desciption on STM32MP25
To: Pascal Paillet <p.paillet@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: Etienne Carriere <etienne.carriere@foss.st.com>
References: <20240628085814.1586186-1-p.paillet@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240628085814.1586186-1-p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_05,2024-07-03_01,2024-05-17_01

Hi pascal

On 6/28/24 10:58, Pascal Paillet wrote:
> Add the description for SCMI regulators provided by OP-TEE firmware.
> The binding file named st,stm32mp25-regulator.h will be also used in
> the OP-TEE firmware.
> 
> Changes in v2:
>   - fix regulator binding commit title in patch 0001
>   - add regulator selection for stm32 in patch 0004
> 
> Pascal Paillet (4):
>    regulators: dt-bindings: add STM32MP25 regulator bindings
>    arm64: dts: st: add scmi regulators on stm32mp25
>    arm64: dts: st: describe power supplies for stm32mp257f-ev1 board
>    arm64: stm32: enable scmi regulator for stm32
> 
>   arch/arm64/Kconfig.platforms                  |  2 +
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        | 35 ++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 43 +++++++++++++----
>   .../regulator/st,stm32mp25-regulator.h        | 48 +++++++++++++++++++
>   4 files changed, 119 insertions(+), 9 deletions(-)
>   create mode 100644 include/dt-bindings/regulator/st,stm32mp25-regulator.h
> 

Series applied on stm32-next.

Thanks
Alex

