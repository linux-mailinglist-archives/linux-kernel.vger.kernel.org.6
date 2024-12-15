Return-Path: <linux-kernel+bounces-444816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FADF9F0CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C01188AC08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F951DF97D;
	Fri, 13 Dec 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLBpEPVx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD21DEFDD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095135; cv=none; b=FGtY4jtHPkpmjTJADMffApsql54bBpEzAFMWCAsElMbeW3oSg57t8W895mYo2L5Fpd3V/rT0Rn+9zycm8eo5Dw3xlJXb+uJomKz6MWlputXLewLcclv6yI3o3Asya/LVuTeeGfyGbHU/KxdVmW/VANq85OlWvAgHR9029Dfkv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095135; c=relaxed/simple;
	bh=RLBEcygwx8JgsZtDlSuqT50mF2p74Zr/H61L3oZCkcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDOQ8KbHtqrgI9936tIY+ivqzBUVJpL/7N1/83f/11QkEn6K3sP99DVlH8J/5ME7e8qg1V9kJPwsBk/IRDGPgMaYL/eStdZKyssKbt1srK+7AYLpkFIEQccryD1w3WVZQAov99OuRLevnqlkz0N3Hjzf7paSDJtcZwJG65V0nEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLBpEPVx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD45haO017168
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjBuIqv/S/JYySCI8v+pcSnmI0O/26pxDqdFxZnLNSY=; b=PLBpEPVx0nRlOr3n
	TECw/PVk2RewaY7QVzDA9oM2xqNo7pGmyYZk5ZnuNcExMdxiv2mC/inN+fLKpGRM
	qMwISUaBxg/N1AmdsABvUkOJifa1lOw09LusDZIc3wk8SuBCvCBBR4RzEqcfoev1
	MWhc4rRDYSF0KwAmswAn/Qmpz51LEFM+IwmhU7/SCWm0bbgKTFo9t1AU53/7N2tC
	B2Q0S6WnQZJJXxbPOKsnNd8f4a9NGALJKiXMumHjSeze+o0k3XWqDz1d8SuVyA96
	fqUjpR76xZkbWU/ZO4102ARYzX7tVqC3cCivfyiF8XVzV9UQesnGHV7RICQDWFK8
	1Zy7Qw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gdkn1cd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:05:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f85325c3so24707985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095132; x=1734699932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjBuIqv/S/JYySCI8v+pcSnmI0O/26pxDqdFxZnLNSY=;
        b=LtkhpyQgQVfWXQVO80kxybi1tDeE/OAB8rEA9k/Vl4rI2yONL59UoKZowlFizkMk7E
         CDyah0//Yi6Fr+thqOXL4YHuJIYLblztuwyY3eumi/6lvQ8MdE1NOfhV7Qx2K+Szco+/
         S/Oi2WM1PHME2FUisx/+7J54qv4AmOVgFs8sg60NCZuLk83QmdNgIp+KzZiKqFZbo7jt
         cayaV5aKSNXbyCuwi6ehqYO0RuyULAwMB6EsQD8WUZEIPjf2Ir+KBKf0iZ9MBI/csTfb
         eS99liE993yCoPF1pPhLIE8Ga62mQ43d84DISPL5Su+5O9BO4zD4prD1JJb/wlJqNxgR
         GpKw==
X-Forwarded-Encrypted: i=1; AJvYcCXg1gCI623SoCwFeJsE4zLDfxoEL9bDF9kEdOYFoNqtJ9wo7TFTzjjQB11BbiM0U1zVJ9YIo0rhN0AJ4fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXa3oHeYBXzd7WZaIYjBsSIZ6fMbqDBlwKY6JlOCse/9/qsQxY
	a/9M7iK7/zA6UeA2godJi1VoB0nYg+ZacCbvLMu/F2r8f72DTun5hRFx8G0bRd9CjrJVS9ox3WP
	5raV+xCslCoUwTgJLuhjX7rtJf3dEaXAbzx7DN58t72d18beSKmdsSh0EUwwADBo=
X-Gm-Gg: ASbGnctzsC3y9siDlMRB1qiIDvyj9yB9OXTwESsg90yigiq/BKrG1d6azMt7NRp/dHw
	5tTH26lsNJIOUb1MNTvv0mKq5RJbiAILJ/EIryHSk1IimzIgAAdpTa6kixMLsqHfp/r72JSgneW
	oGF+lOGk84GIGss4erK+mQdyyIbN60e0WZa+bmeOfm7adzZcDx7LopCAHOWT3rMyoBWyrfJhOwo
	SVAKtUmkENAjt8DKagRUE7j2Bz3NzEDok7OCJZhz6pbcN26xhgXjDkvQPphkHbRm2TZedYBPihI
	oxfx87puInxQW+TAdGTOyvJvIRxzC2Q2hgyj
X-Received: by 2002:a05:620a:4414:b0:7b6:cb66:ad6b with SMTP id af79cd13be357-7b6fbeca502mr118705985a.3.1734095132090;
        Fri, 13 Dec 2024 05:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTVnKCWEeCs3nLgOFiiCt1ZpXJxs//Y7QAyjoDZfCwG2kuKqx4eF4nAgoNSJuP192IVBQ1qg==
X-Received: by 2002:a05:620a:4414:b0:7b6:cb66:ad6b with SMTP id af79cd13be357-7b6fbeca502mr118704385a.3.1734095131708;
        Fri, 13 Dec 2024 05:05:31 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cedbb8fesm9948457a12.22.2024.12.13.05.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 05:05:31 -0800 (PST)
Message-ID: <ce9f1ab1-56a0-4c0a-aa5b-f044111288ec@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 14:05:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] i2c: i2c-qcom-geni: Enable i2c controller sharing
 between two subsystems
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        conor+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, linux@treblig.org, dan.carpenter@linaro.org,
        Frank.Li@nxp.com, konradybcio@kernel.org, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, robh@kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20241129144357.2008465-1-quic_msavaliy@quicinc.com>
 <20241129144357.2008465-5-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241129144357.2008465-5-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ifqIEXJaqgit3SuC_tanph9xjjmc944O
X-Proofpoint-ORIG-GUID: ifqIEXJaqgit3SuC_tanph9xjjmc944O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130091

On 29.11.2024 3:43 PM, Mukesh Kumar Savaliya wrote:
> Add support to share I2C controller in multiprocessor system in a mutually
> exclusive way. Use "qcom,shared-se" flag in a particular i2c instance node
> if the usecase requires i2c controller to be shared.
> 
> Sharing of I2C SE(Serial engine) is possible only for GSI mode as client
> from each processor can queue transfers over its own GPII Channel. For
> non GSI mode, we should force disable this feature even if set by user
> from DT by mistake.
> 
> I2C driver just need to mark first_msg and last_msg flag to help indicate
> GPI driver to take lock and unlock TRE there by protecting from concurrent
> access from other EE or Subsystem.
> 
> gpi_create_i2c_tre() function at gpi.c will take care of adding Lock and
> Unlock TRE for the respective transfer operations.
> 
> Since the GPIOs are also shared between two SS, do not unconfigure them
> during runtime suspend. This will allow other SS to continue to transfer
> the data without any disturbance over the IO lines.
> 
> For example, Assume an I2C EEPROM device connected with an I2C controller.
> Each client from ADSP and APPS processor can perform i2c transactions
> without any disturbance from each other.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 7a22e1f46e60..ccf9933e2dad 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>  
>  #include <linux/acpi.h>
>  #include <linux/clk.h>
> @@ -617,6 +618,7 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>  	peripheral.clk_div = itr->clk_div;
>  	peripheral.set_config = 1;
>  	peripheral.multi_msg = false;
> +	peripheral.shared_se = gi2c->se.shared_geni_se;
>  
>  	for (i = 0; i < num; i++) {
>  		gi2c->cur = &msgs[i];
> @@ -627,6 +629,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>  		if (i < num - 1)
>  			peripheral.stretch = 1;
>  
> +		peripheral.first_msg = (i == 0);
> +		peripheral.last_msg = (i == num - 1);
>  		peripheral.addr = msgs[i].addr;
>  
>  		ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
> @@ -815,6 +819,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		gi2c->clk_freq_out = KHZ(100);
>  	}
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,shared-se")) {
> +		gi2c->se.shared_geni_se = true;
> +		dev_dbg(&pdev->dev, "I2C is shared between subsystems\n");
> +	}
> +
>  	if (has_acpi_companion(dev))
>  		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
>  
> @@ -887,8 +896,10 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	else
>  		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
>  
> -	if (fifo_disable) {
> -		/* FIFO is disabled, so we can only use GPI DMA */
> +	if (fifo_disable || gi2c->se.shared_geni_se) {
> +		/* FIFO is disabled, so we can only use GPI DMA.
> +		 * SE can be shared in GSI mode between subsystems, each SS owns a GPII.
> +		 **/

I don't think this change makes things clearer, I would drop it

>  		gi2c->gpi_mode = true;
>  		ret = setup_gpi_dma(gi2c);
>  		if (ret) {
> @@ -900,6 +911,12 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
>  	} else {
>  		gi2c->gpi_mode = false;
> +
> +		if (gi2c->se.shared_geni_se) {
> +			dev_err(dev, "I2C sharing is not supported in non GSI mode\n");
> +			return -EINVAL;

return dev_err_probe(dev, -EINVAL, "I2C...)

Konrad

