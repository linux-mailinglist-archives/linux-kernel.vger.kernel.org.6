Return-Path: <linux-kernel+bounces-326278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FA9765CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB03281EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E419E963;
	Thu, 12 Sep 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bN6QmF1A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503E18BB9E;
	Thu, 12 Sep 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133815; cv=none; b=ULIi44ZQ5taQ5XNZLf8eRnsqK9ov99Z/oGR/tA0GnkzRkKH3vNQlqBcfJiushl/lZc3K057kJxuZ8NXh36vliGDIPi7Kee8V4gqsv0ur2nHIhqabvvkRfJkkdiy1DgMX0qQ1ngP73PuFmL/NQ9zYqFHUlduBMvSsldj6lGilWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133815; c=relaxed/simple;
	bh=KDL+n7rCwG1RTUcVhoSb8MCzFMSQY2K4mQLbggQD9FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6q8IDigpm5y4n+my6C6kZoy1hfHfcPIqYy/gMub0v74XcGYlgNkEA7RKBzGOBP0oBJ2HiGSiUhGaULSw4HDjI1ABedN8IATJ34uzbXnhtE4Be2cSpMbwBnSaFaNnFHOPulpfIWEwxxjWhYkJMDgE3NjBR2jElqAhRnC3/ApQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bN6QmF1A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C2L9lf014104;
	Thu, 12 Sep 2024 09:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ELMXg0a3PNL9x8cGliR9W3qoMFSOuRXZfpyNfKP19HA=; b=bN6QmF1AnqUGzlp6
	iTxOPcXR/S4LUlCjtPk/+aP4ohUV0Lxt79CMTXhIShSJIRuOC9fVrOlZkJMyY/Li
	h6oLsmWkpeNvn6xqBGByQtNr1/BRXpTNkc4g8+FuEjWChdQYE2A6gl8JSpubft0+
	kn677eT9878MeAfXlFVeHKqXYWnMF7XgLcp7EGtD75Djs6thzJxT2wB19kv8z+UF
	yfXGgwHdNqgfRG6s0AAIfOEKwEnCzp21bmCXeS+mRnto9zx2OgkpWFkPjmU5EDkP
	jyewsUUfwuGy0hXKgtDn+ZYG/Uom8R0BNQX1+0USfB+jDIEVGZ5Ac712oVmEG/Rd
	I+S3Zg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p4qnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:36:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48C9aYPD002170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 09:36:34 GMT
Received: from [10.204.67.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 02:36:25 -0700
Message-ID: <274c267f-f3d4-42cf-915e-44a7c76f2489@quicinc.com>
Date: Thu, 12 Sep 2024 15:06:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] phy: qcom: edp: Introduce aux_cfg array for version
 specific aux settings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <konradybcio@kernel.org>,
        <andersson@kernel.org>, <simona@ffwll.ch>, <abel.vesa@linaro.org>,
        <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>, <sean@poorly.run>,
        <marijn.suijten@somainline.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <quic_khsieh@quicinc.com>,
        <konrad.dybcio@linaro.org>, <quic_parellan@quicinc.com>,
        <quic_bjorande@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <quic_riteshk@quicinc.com>,
        <quic_vproddut@quicinc.com>
References: <20240911100813.338-1-quic_mukhopad@quicinc.com>
 <20240911100813.338-3-quic_mukhopad@quicinc.com>
 <CAA8EJppLFWpf0QSmzAo5nqu=iMALyKzxEvy7sD5R0LDYSbA_7w@mail.gmail.com>
From: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
In-Reply-To: <CAA8EJppLFWpf0QSmzAo5nqu=iMALyKzxEvy7sD5R0LDYSbA_7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O9nQmlSGNOHMwTHyVu8MYKBsq1JE8owZ
X-Proofpoint-ORIG-GUID: O9nQmlSGNOHMwTHyVu8MYKBsq1JE8owZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120067


On 9/11/2024 4:04 PM, Dmitry Baryshkov wrote:
> On Wed, 11 Sept 2024 at 13:08, Soutrik Mukhopadhyay
> <quic_mukhopad@quicinc.com> wrote:
>> In order to support different HW versions, introduce aux_cfg array
>> to move v4 specific aux configuration settings.
>>
>> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 34 +++++++++++++++++------------
>>   1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index da2b32fb5b45..0f860a807d1b 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -90,6 +90,7 @@ struct phy_ver_ops {
>>
>>   struct qcom_edp_phy_cfg {
>>          bool is_edp;
>> +       u8 *aux_cfg;
>>          const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
>>          const struct phy_ver_ops *ver_ops;
>>   };
>> @@ -186,11 +187,14 @@ static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
>>          .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
>>   };
>>
>> +static u8 edp_phy_aux_cfg_v4[10] = {
> static const u8, please.


Sure, we will change this to "static const u8" in next version patch.


>
>
>> +       0x00, 0x13, 0x24, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03
>> +};
>> +
>>   static int qcom_edp_phy_init(struct phy *phy)
>>   {
>>          struct qcom_edp *edp = phy_get_drvdata(phy);
>>          int ret;
>> -       u8 cfg8;
>>
>>          ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
>>          if (ret)
>> @@ -222,22 +226,20 @@ static int qcom_edp_phy_init(struct phy *phy)
>>           * even needed.
>>           */
>>          if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
>> -               cfg8 = 0xb7;
>> -       else
>> -               cfg8 = 0x37;
>> +               edp->cfg->aux_cfg[8] = 0xb7;
>>
>>          writel(0xfc, edp->edp + DP_PHY_MODE);
>>
>> -       writel(0x00, edp->edp + DP_PHY_AUX_CFG0);
>> -       writel(0x13, edp->edp + DP_PHY_AUX_CFG1);
>> -       writel(0x24, edp->edp + DP_PHY_AUX_CFG2);
>> -       writel(0x00, edp->edp + DP_PHY_AUX_CFG3);
>> -       writel(0x0a, edp->edp + DP_PHY_AUX_CFG4);
>> -       writel(0x26, edp->edp + DP_PHY_AUX_CFG5);
>> -       writel(0x0a, edp->edp + DP_PHY_AUX_CFG6);
>> -       writel(0x03, edp->edp + DP_PHY_AUX_CFG7);
>> -       writel(cfg8, edp->edp + DP_PHY_AUX_CFG8);
>> -       writel(0x03, edp->edp + DP_PHY_AUX_CFG9);
>> +       writel(edp->cfg->aux_cfg[0], edp->edp + DP_PHY_AUX_CFG0);
>> +       writel(edp->cfg->aux_cfg[1], edp->edp + DP_PHY_AUX_CFG1);
>> +       writel(edp->cfg->aux_cfg[2], edp->edp + DP_PHY_AUX_CFG2);
>> +       writel(edp->cfg->aux_cfg[3], edp->edp + DP_PHY_AUX_CFG3);
>> +       writel(edp->cfg->aux_cfg[4], edp->edp + DP_PHY_AUX_CFG4);
>> +       writel(edp->cfg->aux_cfg[5], edp->edp + DP_PHY_AUX_CFG5);
>> +       writel(edp->cfg->aux_cfg[6], edp->edp + DP_PHY_AUX_CFG6);
>> +       writel(edp->cfg->aux_cfg[7], edp->edp + DP_PHY_AUX_CFG7);
>> +       writel(edp->cfg->aux_cfg[8], edp->edp + DP_PHY_AUX_CFG8);
>> +       writel(edp->cfg->aux_cfg[9], edp->edp + DP_PHY_AUX_CFG9);
>>
>>          writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
>>                 PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
>> @@ -519,16 +521,19 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
>>   };
>>
>>   static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
>> +       .aux_cfg = edp_phy_aux_cfg_v4,
>>          .ver_ops = &qcom_edp_phy_ops_v4,
>>   };
>>
>>   static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
>> +       .aux_cfg = edp_phy_aux_cfg_v4,
>>          .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>>          .ver_ops = &qcom_edp_phy_ops_v4,
>>   };
>>
>>   static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
>>          .is_edp = true,
>> +       .aux_cfg = edp_phy_aux_cfg_v4,
>>          .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>>          .ver_ops = &qcom_edp_phy_ops_v4,
>>   };
>> @@ -707,6 +712,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
>>   };
>>
>>   static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
>> +       .aux_cfg = edp_phy_aux_cfg_v4,
> Is this correct? Judging by ver_ops, X Elite uses v6 of the PHY, so
> maybe it should also use v5 AUX tables?


As per the current implementation, v6 uses v4 aux configuration, so we 
updated it to v4.


>
>>          .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>>          .ver_ops = &qcom_edp_phy_ops_v6,
>>   };
>> --
>> 2.17.1
>>
>
> --
> With best wishes
> Dmitry

