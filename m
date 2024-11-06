Return-Path: <linux-kernel+bounces-398709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE89BF4FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0E41F215CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED616208991;
	Wed,  6 Nov 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WzuYjYqI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221A208220;
	Wed,  6 Nov 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916905; cv=none; b=BUjlSSF+qI5u7vqRip9+XIpi158NHsevmQ5/Dwafi0cFBq0O5ce7zXSZHrwg6jUAjO0xUWjhJ3UNlGTTrCZSwOlecOHmtpl2XCpp6zrwt0OlusQ06cVlZivwimhEBLKCN65UyVzeFuRGKfVs5R1iF7LaWUJ9o97lfX6K2f5FS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916905; c=relaxed/simple;
	bh=a3zsQPoBndwMkH7++RyuQloyMzDBtMeKqp5lR13haKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nqRt9dF+a/Grt4SCWVeVfm77N5riW2BntVfPt6him3DRKD9YhFckamN7spfvaOWpzIkCPYxmSnAjIn0mwUZt4c/L+WrmDuZulsJKqJQPOw/5Eppq5VegqLTZkCUkqbTQ+pCkUZrJnUum5VTjC1Jx7rRV9jha5JR/xrQcCaH2rHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WzuYjYqI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6DKsqD023132;
	Wed, 6 Nov 2024 18:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KcAeno6XcP9nggXSLEYB0tZ0Kc1d52k38siW6Nf8nN4=; b=WzuYjYqI8qsfdXb9
	A9PnkBGyrLsx0XxScx+c/xVpWPvzSpk6HDqxC67sY+HqMYx/2popfedQjTGqGEga
	d03wE0Dvt19n1l1Zvr5/7x6elBgI/Y7820KyH7HAv8Dz4D5FrDk23UnfZIHOagnq
	dWGmgzQD+XC0qUBpf4kwCOi1ykXc4DiDlRQLmWMZp7iN3SG0JZCyDJhHZp3rwcqd
	VQKlClq4zm60BhCxh/+SlH7A33a1Ud4fY/PtikD68qDjMgdkdI1bDVM9hx9hGLEj
	HvSG4LRq7BAQEEdYKNXwNq/zM09mHR6Ij1WXx7dTfXnv8GAsIBjhIrHIyh6uGm+D
	aunp8Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r07hja7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 18:14:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6IEwTZ028774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 18:14:58 GMT
Received: from [10.216.22.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 10:14:54 -0800
Message-ID: <2bc5da3f-3b4e-4286-87ce-235b98c51d7a@quicinc.com>
Date: Wed, 6 Nov 2024 23:44:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] clk: qcom: rpmh: Add support for SM8750 rpmh clocks
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya
 Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org"
	<quic_satyap@quicinc.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-3-quic_molvera@quicinc.com>
 <787bc601-e669-480e-96c7-36f6e12e3088@linaro.org>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <787bc601-e669-480e-96c7-36f6e12e3088@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gpIGuN2Q5Q85dzU5-P1YLOn-F4B5TuQy
X-Proofpoint-ORIG-GUID: gpIGuN2Q5Q85dzU5-P1YLOn-F4B5TuQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=700 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060141



On 10/22/2024 2:17 PM, Bryan O'Donoghue wrote:
> On 22/10/2024 00:03, Melody Olvera wrote:
>> +    { .compatible = "qcom,sm8750-rpmh-clk", .data = &clk_rpmh_sm8750},
>>       { .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
> 
> Might be a nice opportunity to alphabetise this list if you do a V2.
> 
Will fix in the next patch.

> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

-- 
Thanks & Regards,
Taniya Das.

