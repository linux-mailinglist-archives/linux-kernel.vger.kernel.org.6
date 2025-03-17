Return-Path: <linux-kernel+bounces-563217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A267A639A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26853AD17D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB753A1BA;
	Mon, 17 Mar 2025 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c/gFpKfG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D8DDC1;
	Mon, 17 Mar 2025 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742173676; cv=none; b=umi+IrYKxTlwpsnpUxeKz4pODu8/tVq2a1jw5uaXKzhxZkJVtTnOqH52CMtPgR8MTI4GHaMEMcWsQeUA6MS/6sXEjMdkZ0oIxECLeI3yk8W90y4ii4/tXKJCAOtjoALDc6oRstbyw0Su1KFBKZqnFxExFdEEufTHeb81BTkR6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742173676; c=relaxed/simple;
	bh=eVlJJeAEPTqZGlSmG4PweD35CbpEft7MnShb+VU0e20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lKuCfnfoyODbFymJzSZEsiXzohBAbMIlfsNfptFZTazvRbTEpTFUr1VS5FSIGkVAra+Sq1ltPi+cDBrx0A3ZTscm2oG/ColsaAcUlgvqzE48wI4/nB14D3Znm6C42UpnP2kniRSxqJzQMNJZZ1FGu4sFPd3TXEBzu/q9LVRqlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c/gFpKfG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMnG6v022761;
	Mon, 17 Mar 2025 01:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RIet347e3GWnzM1H4Y30FN8VVgKlGoW5rVSE091wsH4=; b=c/gFpKfGHk+HO73/
	Z7psbsYTlv+5MfHzvaWmaDyslGGNcohkyumBR+GqKdJ9I2S/HjmPkN9hguaLvuSF
	/rE40kiiuFSy6iRIzvaEojJycqH8ghsfBjnyaeM4AzxXiedGaFNHuu4GPDky0Hpy
	fx65umNRCN9FHjdFR1W5c/MaT2IurX4IoKj2MwmFxAo90Nt9NL71UUStyllItNE/
	zLuqrM4hMkHK1YWgCfQIrLR5eT4PKiVZEuTMY5ARBINnv946mvelijbTdTqn53Q5
	tkn3guecSKqs9b+YapgIOmVb8pKb0o3cfGXge8FtyVya6I3UpUQ4FzUlLVgrrQmV
	IJTs1w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2qm2vjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 01:07:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52H17Nvv013921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 01:07:23 GMT
Received: from [10.64.68.153] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Mar
 2025 18:07:20 -0700
Message-ID: <f4d4a369-427b-4fb3-9d49-84f2a0f45aff@quicinc.com>
Date: Mon, 17 Mar 2025 09:07:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] Coresight: Fix a NULL vs IS_ERR() bug in probe
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
Content-Language: en-US
From: Jie Gan <quic_jiegan@quicinc.com>
In-Reply-To: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y-L46RjjSH9nusEJriuMfgahcfNtLGCc
X-Proofpoint-GUID: Y-L46RjjSH9nusEJriuMfgahcfNtLGCc
X-Authority-Analysis: v=2.4 cv=DLWP4zNb c=1 sm=1 tr=0 ts=67d775db cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=G3qhXeVNgz9aKr77KdUA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170006



On 3/14/2025 6:55 PM, Dan Carpenter wrote:
> The devm_platform_get_and_ioremap_resource() function doesn't
> return NULL, it returns error pointers.  Update the checking to
> match.
> 
> Fixes: f78d206f3d73 ("Coresight: Add Coresight TMC Control Unit driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-ctcu-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> index da35d8b4d579..c6bafc96db96 100644
> --- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
> +++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> @@ -204,8 +204,8 @@ static int ctcu_probe(struct platform_device *pdev)
>   	dev->platform_data = pdata;
>   
>   	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> -	if (!base)
> -		return -ENOMEM;
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>   
>   	drvdata->apb_clk = coresight_get_enable_apb_pclk(dev);
>   	if (IS_ERR(drvdata->apb_clk))

Thanks for fix it. Looks good to me.

Reviewed-by: Jie Gan <quic_jiegan@quicinc.com>

Jie


