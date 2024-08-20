Return-Path: <linux-kernel+bounces-294359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F160B958C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE506284C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290CB1B8EAC;
	Tue, 20 Aug 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HXVe7Xxb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621D1BDAA7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172260; cv=none; b=NlxWW8PO7rf4tGHhM15wcE22loP0rMVePy9Cmm8tG2gCqw7opcS36B+sa5as/cVR+esLnSEjeqEUPmW2RfvQaGE2Rj5dUeUaNeImNC7PhA1dj/eMAoLMmTLtmKmYNfyMSSN7JvUENSQqugjoBHsHvYKCQH0iBa9Ozd8yXgzhy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172260; c=relaxed/simple;
	bh=tnHUA9vLeb9YhUlyKQ1ih3Wpqk8pAsPMwe+A6FTSN0c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8lLXJULLaqj/gtNeDusOhBsHKpoV6qu9kh4B8QFlqjzb8xVNyzd64RkcCnlng9wLwTZ3SVftjAfe0aUzWGPbw9k1hIc8VmdS8m026Lvg9ab3XJ+4w0BT7jtwrwZ+BTJrqRVVkiKMQMo2JeYxFQ0dr/mpdH9XjGLiiegMzvuOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HXVe7Xxb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K96Tv6002613;
	Tue, 20 Aug 2024 16:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IzWzeWCHONUKgqcrVqblCetx
	7UFnFX5M9HsJn5wSgEY=; b=HXVe7XxbiqWRvF7hfUQWtHbgIFA7iUoZz0XU/WZ3
	DiqY7NPWfpxdqD0R9SWofcxwPfMqc/8p/GXUFunRwtYyaWQ+Ch9VhEBppBxcgrYH
	7gQxPwlrA+TxjFYYWSOCaRsw8pQy/3fUs+XhrdWJMTE7Y/GIqJu8GoUC+tbLkW9t
	7JO3Q3w80isoPVpjmaU9Izcpet2Zx9EH9JsA2IJosKBLUhdisVc64AJ7a8s1luxt
	OrZ14mvSWpuRmMLHWblUD5QUysjCdWEmpx+il+yhHK4Ufo3rarpOk6Rn6gNRhb98
	xLVeMtKwTkuuUBtg4iMrWi4w78k/3Iafz811J+4LJ1rb2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 413qxg6457-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 16:42:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KGgugQ002149
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 16:42:56 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 09:42:56 -0700
Date: Tue, 20 Aug 2024 09:42:55 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Judith Mendez <jm@ti.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Bryan
 Brattlof <bb@ti.com>
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
Message-ID: <ZsTHj/Fyffi2LxIu@hu-bjorande-lv.qualcomm.com>
References: <20240819204352.1423727-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819204352.1423727-1-jm@ti.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nJWyRN2JCUXQQQ33eMwfC15XufzIm3Fl
X-Proofpoint-GUID: nJWyRN2JCUXQQQ33eMwfC15XufzIm3Fl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=929 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200124

On Mon, Aug 19, 2024 at 03:43:52PM -0500, Judith Mendez wrote:
> SK-AM62A-LP is a device targeting automotive front-camera applications
> among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
> to power the SoC and various other peripherals on the board [1].
> 
> MMCSD requires the PMIC to be setup correctly before setting the bus
> pins to 1.8V using the TPS6594 driver interfaced over i2c.
> 
> Currently, the following could be seen when booting the am62ax platform:
> 
> "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
> "vdd_mmc1: disabling"

Is this the regulator framework disabling the "unused" vdd_mmc1 while
you still have a probe deferred client?

That's not right.

> 
> and a failure to boot the SK-AM62A-LP.
> 
> One solution is to use initramfs [2], but using initramfs increases the
> boot time for this automotive solution which requires faster boot time
> parameters.
> 
> Another solution is to change MFD_TPS6594_I2C to built-in, that way the
> PMIC is setup and the regulators are ready before MMCSD switches to UHS
> mode, this is the preferred solution since it does not increase boot time
> like the initramfs solution does.
> 
> [1] https://www.ti.com/lit/zip/sprr459
> [2] https://lore.kernel.org/linux-devicetree/5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org/
> Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d32fca649965..61f767246d3a5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -756,7 +756,7 @@ CONFIG_RZ_MTU3=y
>  CONFIG_MFD_TI_AM335X_TSCADC=m
>  CONFIG_MFD_TI_LP873X=m
>  CONFIG_MFD_TPS65219=y
> -CONFIG_MFD_TPS6594_I2C=m
> +CONFIG_MFD_TPS6594_I2C=y

These things should work with =m, and then you can make them =y in your
product config to avoid the probe deferral.

Regards,
Bjorn

>  CONFIG_MFD_ROHM_BD718XX=y
>  CONFIG_MFD_WCD934X=m
>  CONFIG_MFD_KHADAS_MCU=m
> 
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> -- 
> 2.46.0
> 

