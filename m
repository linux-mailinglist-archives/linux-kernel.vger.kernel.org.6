Return-Path: <linux-kernel+bounces-398710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFDE9BF500
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404081F21330
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5020896C;
	Wed,  6 Nov 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mv/KlJMp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5E20898A;
	Wed,  6 Nov 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916908; cv=none; b=q9pU7kvkQMyrdERuTj1SX5scJclQSv3VLSAgsSODK6ousqcW/Rbwvm3XCZz0irfr7hA37VH4HjnGrc2CiDl8fa/WeeywvCBUpSVzPy5PnquMuj2xDN+o39MgNxZRneG4xRQkvZUk93KWZzYQ5wIdfpkdECmijftnFVkmMwYPN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916908; c=relaxed/simple;
	bh=WACusJpBXLQJQyqPxDh4r+ge9ncAilJXCQ3t7LOhzOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=icZAM1qdYJPTjkwAdP/9VSg20f3OqATnNmWASO4FzJCOn8WGxOD3XdW8WePXW2UqE7dWtr0YzHGhm6cV3WSYoKJN5cnhgo5+zDtm/6WylCHgbQOyOcbfOmjYFiCSyWd0Pm5fVdE9nZtUg+ATBgOqYUHZ+DBVhh5Vp++fyzAsqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mv/KlJMp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ffk7q024495;
	Wed, 6 Nov 2024 18:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q9UkRTRXKGZ0ezE+gDV/CbTtlkROh2Fv/C1k6M0jsRI=; b=mv/KlJMpslLO+mWX
	fVVtb65bp0TPceMghISxcJQjcWGGHseXTFrJsPRB/WuBk/h52U6K2y1NY8Ojk3Yj
	1VxpisCWPP1xlVWw468RG3Qe3F+JJJpSz63XSsOo/YmGX3xv9OygSvazPHV4sIAC
	Ecpwf5IYV7G2ZTllKic8ZaXcvqZZvdh781sHt7cr5CdL92j0ECk3nrmmUDsUygZu
	sJYXFuIsG7ZKlfmu/odv1wwklfYZnTaCwb94Sr1IplnNUqq/XjmxkhTnfaO+jHe4
	lV2aO82moLeNKlzlPy1Wo9rjqCUUICpeKiK+0bvN5zmjZl+0TBmzukfmUnCB7DUy
	K74jxw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r2ugsxtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 18:15:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6IF28w026029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 18:15:02 GMT
Received: from [10.216.22.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 10:14:58 -0800
Message-ID: <5fe90ddc-960e-4ece-bb86-59619dfd35b4@quicinc.com>
Date: Wed, 6 Nov 2024 23:44:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] dt-bindings: clock: qcom: Add SM8750 GCC clock
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga
 Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org"
	<quic_satyap@quicinc.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-5-quic_molvera@quicinc.com>
 <qxhsw4sg4feiaee7npio2e7gxi5d2gwsupdculzyhc7xxg6ci2@di532b2jmonc>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <qxhsw4sg4feiaee7npio2e7gxi5d2gwsupdculzyhc7xxg6ci2@di532b2jmonc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vbm9gUq_gXD2mjsqDb5RQzUglZ1NqSeH
X-Proofpoint-GUID: vbm9gUq_gXD2mjsqDb5RQzUglZ1NqSeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060141



On 10/22/2024 11:48 AM, Krzysztof Kozlowski wrote:
>> +  domains on SM8750
>> +
>> +  See also:: include/dt-bindings/clock/qcom,sm8750-gcc.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm8750-gcc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Board Always On XO source
>> +      - description: Sleep clock source
>> +      - description: PCIE 0 Pipe clock source
>> +      - description: PCIE 1 Pipe clock source
>> +      - description: PCIE 1 Phy Auxiliary clock source
>> +      - description: UFS Phy Rx symbol 0 clock source
>> +      - description: UFS Phy Rx symbol 1 clock source
>> +      - description: UFS Phy Tx symbol 0 clock source
>> +      - description: USB3 Phy wrapper pipe clock source
> 
> It's the same as sm8650, so it should be there. No need for new file.

Sure, will remove this and reuse SM8650 file.

-- 
Thanks & Regards,
Taniya Das.

