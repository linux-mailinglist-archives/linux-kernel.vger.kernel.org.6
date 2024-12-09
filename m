Return-Path: <linux-kernel+bounces-438016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4926B9E9BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CF9166198
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44A144D1A;
	Mon,  9 Dec 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jyXFHdpX"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5742143C72;
	Mon,  9 Dec 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761785; cv=none; b=kyR75Fs6sUk1tlZ+N/EmrY4lIgub6SBzWHU/Hov9F+j4aM8s5z09fn25U8rFB0JfTVAVOXXzunKi6QdSztFHCedEtOtpT9nxyN97XVoodnGMPRH/zhj6HoaECQwUq6CJ05YLf/dUDcJVXUxUsXUD+BRyyp1AJUVuooQC5jAzkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761785; c=relaxed/simple;
	bh=hKEaeoK3n0J0N+4rTttPEgAYCOirq6k51p+EhD8tcFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cQe6NGCuMwcN8tK8nmyc60mLqK2UMCXCRQnkWoBroJ1vJKmelhDiX/4iR0BEo6j8O6TjMTjGb4EnysBwNyFJ61jEHVUhvIu7RpYM9lnkLJj4xny14aRMlk2jyxX49pTu1BS+WrbY3ZwE4j0RmjN+jfx58m1qeUzaUkJI6B13LRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jyXFHdpX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Dk78Y030060;
	Mon, 9 Dec 2024 17:29:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2xxd9CctnglpS/bsG969EigGTjV63sf0SfJfYKNJ5iA=; b=jyXFHdpXnRIz9ela
	xCGd6zoUUHUlh9IGm+qSgM1lGwOD4FTBP3Fu4kjMyUYDvwuULVGA7k24qEgqzbFg
	YwTmpb3ed/xBoBWjRzggG4KLs/6ohRnto954BAlELElqS97MIGG1czrLS5atULp5
	l0B2+JABQg0tDF+WmiFJi/2Q7sRV2zTE/rpk3it43sLAzMW7wwtKS+K5oS7P2q6C
	Ly3p3DwCpn0Gy+D0xgPNSz+uLthLYsgczK1AgduUUojr2Tcn4OU4Xjgj6ZiOEggr
	k1h+LH3vSHyHaDszebc5H3Bp36e9a4qGdkC/41H5fx3urTD0wp3aX1Fc5s8V4LGb
	WVQa+A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43d26n69ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:29:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3BB7640044;
	Mon,  9 Dec 2024 17:28:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D87CE2945B3;
	Mon,  9 Dec 2024 17:24:06 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 17:24:06 +0100
Message-ID: <6bbb3044-4c1f-4ff1-a503-ef8392e023ae@foss.st.com>
Date: Mon, 9 Dec 2024 17:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver
To: Christian Bruel <christian.bruel@foss.st.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20240930170847.948779-1-christian.bruel@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240930170847.948779-1-christian.bruel@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Christian

On 9/30/24 19:08, Christian Bruel wrote:
> Changes in v9:
>     - Fix bot clang warnings: uninitialized variables and
>       include bitfield.h for FIELD_GET
> 
> Changes in v7/v8:
>     - MAINTAINERS: Reorder STM32MP25 DRIVER entry
> 
> Changes in v6:
>     - stm32_combophy_pll_init: merge combophy_cr1 accesses and error path.
>     - Use devm_reset_control_get_exclusive
> 
> Changes in v5:
>     - Drop syscfg phandle and change driver to use lookup_by_compatible
>     - Use clk_bulk API and drop stm32_combophy_enable/disable_clocks
>     - Reorder required: list.
>     - Fix access-controllers maxItems
> 
> Changes in v4:
>     - "#phy-cells": Drop type item description since it is specified
>       by user node phandle.
>     - Rename stm32-combophy.yaml to match compatible
>     - Drop wakeup-source from bindings (should be generic)
>     - Alphabetically reorder required: list.
>     - Drop "Reviewed-by" since those previous changes
> 
> Changes in v3:
>     - Reorder MAINTAINERS patch
> 
> Changes in v2:
>     - Reorder entries
>     - Rename clock_names and reset_names bindings
>     - Rename and clarify rx-equalizer binding
> 
> Christian Bruel (5):
>    dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
>    phy: stm32: Add support for STM32MP25 COMBOPHY.
>    MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
>    arm64: dts: st: Add combophy node on stm32mp251
>    arm64: dts: st: Enable COMBOPHY on the stm32mp257f-ev1 board
> 
>   .../bindings/phy/st,stm32mp25-combophy.yaml   | 119 ++++
>   MAINTAINERS                                   |   6 +
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  16 +
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 +
>   drivers/phy/st/Kconfig                        |  11 +
>   drivers/phy/st/Makefile                       |   1 +
>   drivers/phy/st/phy-stm32-combophy.c           | 598 ++++++++++++++++++
>   7 files changed, 765 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
>   create mode 100644 drivers/phy/st/phy-stm32-combophy.c
> 
> 
> base-commit: 9bd8e1ba97b1f2d0410db9ff182d677992084770

DT patches ([4] & [5]) applied on stm32-next.

Thanks
Alex

