Return-Path: <linux-kernel+bounces-398708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863A9BF4FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9841C238AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E711208225;
	Wed,  6 Nov 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R0V19OO+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039E205E2C;
	Wed,  6 Nov 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916901; cv=none; b=m0VL9Z3oRq2Q0+Lq81ufxz4267lCt/FGRnpUevt1AJbEJNDihuTn0Eco7UEgO+KT9OmxS6Uc12rMCOo2QyEn+bfWJKXRYdKo5anoKfRe/7q2Tv/2efMrhlZ24j+IMeCaBoDorvuA/09DmJlKhUDAbDixPwel9pYB2ub41P+qk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916901; c=relaxed/simple;
	bh=EVx1GzNPXkASAsGD7F1Fxyq1OpFWiPcft1wfXay07JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kvFxh9kVF5doHdT7LeHsxv9DR9ziHcnQmN8pxbqI2z3ojxOoHU2dIJF/BJO8WhubehDxNwAqX9if0JRxSrgwf/jNNL1b+NZrd+GVFyQ5xdDi4j86E9pTgae4mWA77+jNDRUCsZVk1oG8WZeYIt2CKKQKDps3D+CgujUCMfx/n0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R0V19OO+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6G8i87014270;
	Wed, 6 Nov 2024 18:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjEYReMQbDFcJuTHLh3Jcx87Dv+ub5d6gMwPYjlusqI=; b=R0V19OO+Lp7Ve3xp
	NrSZ4C17HDIDbu1dSPNvC6Awrnr3GY47RXdFl464GYH85oMwm5tRXANOyXEUTAN9
	C3/Gh5tZfvmkWYqI1DuwgLIqBpGGubllcQfWvBXtJozsHdXfGGm1siZ08tOOK/uD
	37NAMI/+HtEVCojblYCc5LdpPWtr9Dk540LhlD0+1Gdnd+e2T+52lNEm5dDUDSUn
	DaFprIqIOykWzISx9vnUTnY+vBC/v5ZCs4Mi5PM1djJeG8alx+yIJswDvDMK1FNc
	SEcGpkqE/sPn/UmXWfFd8b1EU4IXNc6B7waAb/1yXkfpDPJHBgH2CW0IO9st5wkX
	qDJsDw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2ruv57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 18:14:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6IErmX028739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 18:14:53 GMT
Received: from [10.216.22.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 10:14:49 -0800
Message-ID: <ed0fad4d-6509-4a29-ae75-a9fe27d69851@quicinc.com>
Date: Wed, 6 Nov 2024 23:44:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] clk: qcom: rpmh: Add support for SM8750 rpmh clocks
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
 <20241021230359.2632414-3-quic_molvera@quicinc.com>
 <hisxeyns76aibj2wfw65epqwe5cbox5mt7t7c67zrzzaildelm@6pu4ao2qvtgf>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <hisxeyns76aibj2wfw65epqwe5cbox5mt7t7c67zrzzaildelm@6pu4ao2qvtgf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZlCqF0TIyePKBBeq4Ap8UNynfWALpIxf
X-Proofpoint-ORIG-GUID: ZlCqF0TIyePKBBeq4Ap8UNynfWALpIxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060141



On 10/23/2024 9:10 AM, Bjorn Andersson wrote:
> On Mon, Oct 21, 2024 at 04:03:54PM GMT, Melody Olvera wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Add the RPMH clocks present in SM8750 SoC.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-rpmh.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 4acde937114a..245bdfe4827d 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -344,6 +344,7 @@ static const struct clk_ops clk_rpmh_bcm_ops = {
>>   DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 1);
>>   DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 2);
>>   DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 4);
>> +DEFINE_CLK_RPMH_ARC(xo_pad,  "xo.lvl", 0x3, 2);
> 
> Please make a note in the commit message documenting why we need two
> different xo.lvl resources defined.
> 
> If we indeed should have two copies, this list is sorted alphabetically
> on the clock name - rather than on the resource. Please keep that (i.e.
> move this down one line).
> 

I will remove the newly added "xo_pad" and reuse the exisiting nodes to 
derive 19.2MHZ.

>>   DEFINE_CLK_RPMH_ARC(qlink, "qphy.lvl", 0x1, 4);
>>   
>>   DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2, "lnbclka1", 2);
>> @@ -368,6 +369,10 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
>>   DEFINE_CLK_RPMH_VRM(rf_clk3, _d, "rfclkd3", 1);
>>   DEFINE_CLK_RPMH_VRM(rf_clk4, _d, "rfclkd4", 1);
>>   
>> +DEFINE_CLK_RPMH_VRM(rf_clk3, _a2, "rfclka3", 2);
>> +DEFINE_CLK_RPMH_VRM(rf_clk4, _a2, "rfclka4", 2);
>> +DEFINE_CLK_RPMH_VRM(rf_clk5, _a2, "rfclka5", 2);
>> +
>>   DEFINE_CLK_RPMH_VRM(clk1, _a1, "clka1", 1);
>>   DEFINE_CLK_RPMH_VRM(clk2, _a1, "clka2", 1);
>>   DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
>> @@ -795,6 +800,26 @@ static const struct clk_rpmh_desc clk_rpmh_x1e80100 = {
>>   	.num_clks = ARRAY_SIZE(x1e80100_rpmh_clocks),
>>   };
>>   
>> +static struct clk_hw *sm8750_rpmh_clocks[] = {
>> +	[RPMH_CXO_PAD_CLK]      = &clk_rpmh_xo_pad_div2.hw,
>> +	[RPMH_CXO_PAD_CLK_A]    = &clk_rpmh_xo_pad_div2_ao.hw,
>> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
>> +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
>> +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
>> +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
>> +	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
>> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
>> +	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_a.hw,
>> +	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
>> +	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a2.hw,
>> +	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a2_ao.hw,
>> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>> +};
>> +
>> +static const struct clk_rpmh_desc clk_rpmh_sm8750 = {
>> +	.clks = sm8750_rpmh_clocks,
>> +	.num_clks = ARRAY_SIZE(sm8750_rpmh_clocks),
>> +};
> 
> Please add an empty line here, when you're resubmitting the series.
> 

Will fix this in the next patch.

> Thanks,
> Bjorn
> 
>>   static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>>   					 void *data)
>>   {
>> @@ -896,6 +921,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>>   	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
>>   	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
>>   	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
>> +	{ .compatible = "qcom,sm8750-rpmh-clk", .data = &clk_rpmh_sm8750},
>>   	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>>   	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = &clk_rpmh_x1e80100},
>>   	{ }
>> -- 
>> 2.46.1
>>

-- 
Thanks & Regards,
Taniya Das.

