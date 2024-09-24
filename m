Return-Path: <linux-kernel+bounces-336869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 688CB9841EB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121461F23AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8015539F;
	Tue, 24 Sep 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FaeDrGnU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11C84A50
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169627; cv=none; b=Vi0USkIIcw7l6dXw9cqbZqIYbe8ftHIYqteglgNtCLcDtpvhUIaEAWf/huJM7MT+FD37wc5nnQnXCyVXa6x6pLNzcu60YZnaQl9lrmQILaAGcW8a+4Qp7R6sCNJ6RkShi2hROs7MvGYZthPqI9kVomRazlVrvFNAOJo2wlyjnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169627; c=relaxed/simple;
	bh=ZoQgYvCJUSDKnHrEYx7/xS0l5OQvs2dTgTVjxRuarZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CO0eCqfb9om3Wki48KTkITxmtTbTn/08sq9Q9XwxolT8SRp7bdgiUrS7ihOj5yA1wRA82lMarWKIxfEE4l0/kCS6kDAlR6dpJZERX5EZzEx0oCfZ6vDcEe7ISZ5ccMiF+LJgTswPWNRYGcWXfNwoqWXc/75ddmTKA2eaNXrtqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FaeDrGnU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NN07bo008558;
	Tue, 24 Sep 2024 09:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9ghZBYZIOkdoaQjpB5RjPXrK49DBltFjJctxRkaWeo=; b=FaeDrGnUdXOO08sz
	HdZbHBscQRyzOGSg29KvP0U2ZGh5+IE5IaYC56O779OhKx1+Vy3VJHAjILtOCbx1
	is0AeBxY4+wVkSIhn8JuzLLb7c7jiZfjHh4EcChXdkx+bqAe4f1LmJTISfgQV2X/
	lWPn70tQzVFsvUefzie9Kt04mZmmORx7n8bvpHid1rDRpqSqkX0rbF6plxRGYFPX
	QT9gu0q9jPtjGJanW2pdtw/jkqdAsodHGHS3eOxTIhQh88/dIKwVgzI+AWBGJ2S/
	0b3kmOvA3NXSrZzvw74OYydJb5wBqmIgd/XJ5m7jyTSWXpi/aRYG/Pa6P0x/7GQ2
	lXt6SA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6r0y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:20:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48O9JwaZ020643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:19:58 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 02:19:55 -0700
Message-ID: <1d82fda3-dad4-45f8-86c9-ce1ad88278af@quicinc.com>
Date: Tue, 24 Sep 2024 17:19:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: Enable Ftrace and STM configs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?J07DrWNvbGFzIEYgLiBSIC4gQSAuIFByYWRvJw==?=
	<nfraprado@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240920075905.19441-1-quic_jinlmao@quicinc.com>
 <dd4c1956-cf6e-442b-9119-12f63fb95db8@linaro.org>
Content-Language: en-US
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <dd4c1956-cf6e-442b-9119-12f63fb95db8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6s4D8fj0w4T8nDO0HnD1CrZ7EDxJmBU-
X-Proofpoint-ORIG-GUID: 6s4D8fj0w4T8nDO0HnD1CrZ7EDxJmBU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=464
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240065



On 2024/9/20 20:48, Krzysztof Kozlowski wrote:
> On 20/09/2024 09:59, Mao Jinlong wrote:
>> Ftrace logs can be captured by STM over TMC sink path. We can enable
>> ftrace logs along with HW trace of coresight component. The timestamp
>> of ftrace logs and hw traces will be in sync which helps to debug.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   arch/arm64/configs/defconfig | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
> 
> I am pretty sure I saw this and even commented on. So you miss changelog
> and proper patch versioning... unless you duplicate someone's else work?

Thank you. I will correct the verion in next patch and add change logs.

> 
> Best regards,
> Krzysztof
> 


