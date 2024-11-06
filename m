Return-Path: <linux-kernel+bounces-398711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2149BF503
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1D1C23733
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6FC20969B;
	Wed,  6 Nov 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SE9GNRus"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4604209691;
	Wed,  6 Nov 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916913; cv=none; b=Sy+UXjEiLXgq3uy1mHr5irsx2xjzUGlpl8Hc5Htd63Mg3YLkbjIfQAD1sTVAocv/O3tQbnfJUUaWGRsSu663zXbLn7UlucvuMYoI6oE/684ZNJ1T6ehsiz5nU1IjkvU5pR7uLMvFTQzFjhol34DjIJq4w4xwEBg4BevRhVdBGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916913; c=relaxed/simple;
	bh=SAqNMiVakOdPIqhnb8KZqTUFmK9vjHx9/XPLZZ4C/0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VVLLgzalAoyLWqVgql31RLgpRcrBgi0DYUK/U8d51isngM2nfghvosGTYONOkC9fo7SIlGZK5eV0GZsGIdv5eFklwzpTazY+MiLUskC+rdmyrXHhGRqkBeNfEnMUpTDS5rVKlrzXzpIp/xMqsvgMX1hXgj+0/nr9QXofhPpbtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SE9GNRus; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6GkS6D013171;
	Wed, 6 Nov 2024 18:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	th/E8UsuEgDElgaotj70NzPM0eFqpeomnO7I+tpc37g=; b=SE9GNRusiUcYL7dQ
	oFGOChougJf9gET+rFMa2UZG5Ks64/QPFiWuCORm5g5iJmq+k16t59WEDsHEHfj5
	MNSP4nJ+yVfR1AG/3qBDGGUkEild0G9fgEEl/9AdpdqnqlDTyuX6QY7xLBhURmw/
	AbAfuRszVAwCmHEKObLf2qYhiCVMYQTtlddnKRlqc8Uq2X6VW+7MrPHl7b2MFIIZ
	3m8MuV0bI8XQBNDN3jZdCrO3y3+iUaAKva7Ueg4egNbip8+hVYed7GrgKLRIoDmB
	E2f/HhaobBWQQg7uXH50crXaPBnAF/QA37STKp9cgS+JG+O1KwFZ03Ul2mjl98Cr
	FAEq8g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2ruv65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 18:15:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6IF685015787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 18:15:06 GMT
Received: from [10.216.22.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 10:15:02 -0800
Message-ID: <04a46e5e-0392-4355-91ba-77b709e365e5@quicinc.com>
Date: Wed, 6 Nov 2024 23:45:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] clk: qcom: clk-alpha-pll: Add support for controlling
 Taycan PLLs
To: Bjorn Andersson <andersson@kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala --cc=linux-arm-msm
 @ vger . kernel . org" <quic_satyap@quicinc.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-4-quic_molvera@quicinc.com>
 <isk2sazlimemlljrhslorazplvxkfisak2sncarqenai4ru5yf@k23mofd5dixd>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <isk2sazlimemlljrhslorazplvxkfisak2sncarqenai4ru5yf@k23mofd5dixd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X9vXXVHeJhFAx0-CRzluEi1ZCGVW_gAr
X-Proofpoint-ORIG-GUID: X9vXXVHeJhFAx0-CRzluEi1ZCGVW_gAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060141



On 10/23/2024 9:18 AM, Bjorn Andersson wrote:
> On Mon, Oct 21, 2024 at 04:03:55PM GMT, Melody Olvera wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Update the clock ops for Taycan PLL, add the register offsets for
>> supporting the PLL.
> 
> Subject and patch says "Add" so why does it say "Update" here?
> 

Will fix in the next patch.

>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-alpha-pll.c | 14 ++++++++++++++
>>   drivers/clk/qcom/clk-alpha-pll.h |  7 +++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index be9bee6ab65f..57a15ac7b052 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -267,6 +267,20 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>>   		[PLL_OFF_OPMODE] = 0x30,
>>   		[PLL_OFF_STATUS] = 0x3c,
>>   	},
>> +	[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU] = {
> 
> The other entries in this array are following the order of the enum, how
> come this is different?
> 

Sure, will align the order.

> Regards,
> Bjorn
> 
>> +		[PLL_OFF_OPMODE] = 0x04,
>> +		[PLL_OFF_STATE] = 0x08,
>> +		[PLL_OFF_STATUS] = 0x0c,
>> +		[PLL_OFF_L_VAL] = 0x10,
>> +		[PLL_OFF_ALPHA_VAL] = 0x14,
>> +		[PLL_OFF_USER_CTL] = 0x18,
>> +		[PLL_OFF_USER_CTL_U] = 0x1c,
>> +		[PLL_OFF_CONFIG_CTL] = 0x20,
>> +		[PLL_OFF_CONFIG_CTL_U] = 0x24,
>> +		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
>> +		[PLL_OFF_TEST_CTL] = 0x2c,
>> +		[PLL_OFF_TEST_CTL_U] = 0x30,
>> +	},
>>   };
>>   EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>>   
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
>> index 55eca04b23a1..5ba06d9ba77e 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.h
>> +++ b/drivers/clk/qcom/clk-alpha-pll.h
>> @@ -27,6 +27,7 @@ enum {
>>   	CLK_ALPHA_PLL_TYPE_ZONDA_OLE,
>>   	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
>>   	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
>> +	CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
>>   	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
>>   	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
>>   	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
>> @@ -184,12 +185,15 @@ extern const struct clk_ops clk_alpha_pll_zonda_ops;
>>   #define clk_alpha_pll_zonda_ole_ops clk_alpha_pll_zonda_ops
>>   
>>   extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
>> +#define clk_alpha_pll_taycan_elu_ops clk_alpha_pll_lucid_evo_ops
>>   extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
>>   #define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
>>   extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
>>   #define clk_alpha_pll_fixed_lucid_ole_ops clk_alpha_pll_fixed_lucid_evo_ops
>> +#define clk_alpha_pll_fixed_taycan_elu_ops clk_alpha_pll_fixed_lucid_evo_ops
>>   extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
>>   #define clk_alpha_pll_postdiv_lucid_ole_ops clk_alpha_pll_postdiv_lucid_evo_ops
>> +#define clk_alpha_pll_postdiv_taycan_elu_ops clk_alpha_pll_postdiv_lucid_evo_ops
>>   
>>   extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
>>   #define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
>> @@ -217,6 +221,9 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>>   				 const struct alpha_pll_config *config);
>>   void clk_lucid_ole_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   				 const struct alpha_pll_config *config);
>> +#define clk_taycan_elu_pll_configure(pll, regmap, config) \
>> +	clk_lucid_evo_pll_configure(pll, regmap, config)
>> +
>>   void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>>   				  const struct alpha_pll_config *config);
>>   void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>> -- 
>> 2.46.1
>>

-- 
Thanks & Regards,
Taniya Das.

