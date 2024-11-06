Return-Path: <linux-kernel+bounces-398712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A79BF506
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E01C23903
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288B207A3A;
	Wed,  6 Nov 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="erzD9ojk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB39209F24;
	Wed,  6 Nov 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916916; cv=none; b=FKRIxkQpan8topG8D9KVpk0cFdrDsyxkEC5O4EKvSAeMOqEf95jFBZGvVO42fQSNFO9ShF7QA/NIFwIEgqR4rhOVVFuF/W38K8pFfVK5YFd7Ggo/5M8Qvw/+PnTuDeHqUUEUGEgK1wQ5fryca99N1SlhEwIvlCQCdhxXp3DvHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916916; c=relaxed/simple;
	bh=bjBVCWJs3JVih9LLkEdAs06aFgKWyrXCnVS0nCRANps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+MfKzTLqDJCTMHSxLCf5VsTvHFfsnORkRatmVOTWk4iWtND6QB187r3CxtmYtaW9vkconO5bq59IxOcLnrPi2NNsyYvSnXcQQU6rmFzvPoFBhQnd/mzMXsMDOr1QYdR4q5Qaqt0mFGUJeporabmS/d042kZr9WGSdxrPHwRy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=erzD9ojk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68GiK0004743;
	Wed, 6 Nov 2024 18:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gmB9e571dxANu14lGWTGGq0+uEwpcPxl12XWbz/4KLk=; b=erzD9ojkPVfvBXp6
	w4nNqVfN1uV8w5H1nJ3diZdkzjZMNyP0GhiTtZ+PFrBCeOm7k/H5znrKDBTTSdON
	i8p+rng+6X/ZuFlugNFCAiKkEeB3Bb0hNeW/zwxWsPPZJ68wFWsq0MUvHcVUD/zz
	lMVwb7tTcBg6gJPg81pP3upanyg5FFDrA5MoNoGBCSSGnq9pDlogde8EUDBqv/yO
	Fuyv3f/6IFleVfmwQ3TVAdx4luK21NYwQShmD3NhhAUpEdU2uwOHmFNhgMTgoBXa
	Nz5DE+u1lNlzmQ9WFrptAautvmslCDnKUTHMjatwGwDeYZuS7nSnAMtI9K6F5K+W
	nNQJAw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx53he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 18:15:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6IFAXr020047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 18:15:10 GMT
Received: from [10.216.22.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 10:15:06 -0800
Message-ID: <4b57566e-bcfa-4218-a4ba-8f1d49493df2@quicinc.com>
Date: Wed, 6 Nov 2024 23:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] clk: qcom: Add support for GCC clock controller on
 SM8750
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
 <20241021230359.2632414-6-quic_molvera@quicinc.com>
 <4rp4h2inllsa2zd62yg6giyf45skhe3bzcgkjb5btwn4hhh33b@pdjllzwaqtks>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <4rp4h2inllsa2zd62yg6giyf45skhe3bzcgkjb5btwn4hhh33b@pdjllzwaqtks>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lAp0gs0ojnfOtNbXS2zWgXxBfAO0fMfn
X-Proofpoint-ORIG-GUID: lAp0gs0ojnfOtNbXS2zWgXxBfAO0fMfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060141



On 10/23/2024 9:30 AM, Bjorn Andersson wrote:
> On Mon, Oct 21, 2024 at 04:03:57PM GMT, Melody Olvera wrote:
> [..]
>> diff --git a/drivers/clk/qcom/gcc-sm8750.c b/drivers/clk/qcom/gcc-sm8750.c
> [..]
>> +static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
>> +	.reg = 0x6b080,
>> +	.shift = 0,
>> +	.width = 2,
>> +	.parent_map = gcc_parent_map_7,
>> +	.clkr = {
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "gcc_pcie_0_pipe_clk_src",
>> +			.parent_data = gcc_parent_data_7,
>> +			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
>> +			.ops = &clk_regmap_mux_closest_ops,
> 
> Please confirm that the PCIe pipe clock sources should not be
> &clk_regmap_phy_mux_ops, as on other platforms.
> 

Yes Bjorn this will be fixed in the next series.

>> +		},
>> +	},
>> +};
>> +
> [..]
>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>> +	F(400000, P_BI_TCXO, 12, 1, 4),
>> +	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
>> +	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
>> +	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
>> +	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>> +	.cmd_rcgr = 0x1401c,
>> +	.mnd_width = 8,
>> +	.hid_width = 5,
>> +	.parent_map = gcc_parent_map_8,
>> +	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
>> +	.clkr.hw.init = &(const struct clk_init_data) {
>> +		.name = "gcc_sdcc2_apps_clk_src",
>> +		.parent_data = gcc_parent_data_8,
>> +		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +		.ops = &clk_rcg2_shared_ops,
> 
> Please confirm that the sdcc apps_clk_src no longer needs to use
> &clk_rcg2_floor_ops.
> 

This too would be fixed in the next series.

>> +	},
>> +};
>> +
> [..]
>> +static struct gdsc gcc_pcie_0_gdsc = {
>> +	.gdscr = 0x6b004,
>> +	.en_rest_wait_val = 0x2,
>> +	.en_few_wait_val = 0x2,
>> +	.clk_dis_wait_val = 0xf,
>> +	.collapse_ctrl = 0x5214c,
>> +	.collapse_mask = BIT(0),
>> +	.pd = {
>> +		.name = "gcc_pcie_0_gdsc",
>> +	},
>> +	.pwrsts = PWRSTS_OFF_ON,
> 
> Shouldn't the PCIe GDSCs be PWRSTS_RET_ON?
> 

Not required.

>> +	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>> +};
>> +
> [..]
>> +static int gcc_sm8750_probe(struct platform_device *pdev)
>> +{
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	regmap = qcom_cc_map(pdev, &gcc_sm8750_desc);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>> +				       ARRAY_SIZE(gcc_dfs_clocks));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Keep clocks always enabled:
>> +	 *	gcc_cam_bist_mclk_ahb_clk
>> +	 *	gcc_camera_ahb_clk
>> +	 *	gcc_camera_xo_clk
>> +	 *	gcc_disp_ahb_clk
>> +	 *	gcc_eva_ahb_clk
>> +	 *	gcc_eva_xo_clk
>> +	 *	gcc_gpu_cfg_ahb_clk
>> +	 *	gcc_pcie_rscc_cfg_ahb_clk
>> +	 *	gcc_pcie_rscc_xo_clk
>> +	 *	gcc_video_ahb_clk
>> +	 *	gcc_video_xo_clk
>> +	 */
>> +	regmap_update_bits(regmap, 0xa0004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x26034, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x9f004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x9f01c, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));

>> +	regmap_update_bits(regmap, 0x52010, BIT(20), BIT(20));
>> +	regmap_update_bits(regmap, 0x52010, BIT(21), BIT(21));
These will still require to use the regmap_update_bits().

>> +	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x32038, BIT(0), BIT(0));
> 
> Any reason why qcom_branch_set_clk_en() can't be used here?
> 

Yes, I agree it is a miss.

>> +
>> +	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
>> +	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg,
>> +			   BIT(14), BIT(14));
> 
> qcom_branch_set_force_mem_core() ?
> 

It will be fixed.

> Regards,
> Bjorn
> 
>> +
>> +	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8750_desc, regmap);
>> +}
>> +
>> +static struct platform_driver gcc_sm8750_driver = {
>> +	.probe = gcc_sm8750_probe,
>> +	.driver = {
>> +		.name = "gcc-sm8750",
>> +		.of_match_table = gcc_sm8750_match_table,
>> +	},
>> +};
>> +
>> +static int __init gcc_sm8750_init(void)
>> +{
>> +	return platform_driver_register(&gcc_sm8750_driver);
>> +}
>> +subsys_initcall(gcc_sm8750_init);
>> +
>> +static void __exit gcc_sm8750_exit(void)
>> +{
>> +	platform_driver_unregister(&gcc_sm8750_driver);
>> +}
>> +module_exit(gcc_sm8750_exit);
>> +
>> +MODULE_DESCRIPTION("QTI GCC SM8750 Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.46.1
>>

-- 
Thanks & Regards,
Taniya Das.

