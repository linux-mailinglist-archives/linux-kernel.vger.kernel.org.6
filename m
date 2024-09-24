Return-Path: <linux-kernel+bounces-336868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD7F9841EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A371C229CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554331553A3;
	Tue, 24 Sep 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M9UnI8nJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E167153812
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169579; cv=none; b=FKUk+WyTh/4PQG2gGElHVx/zXqoqnC4AdtLCoQuAT2aar0yDCHZvtOM+a6I43P9F8RWrtVvHQDGZSS+G/HCU4f8C/IF99ixJwCxErnE0cDUijObpcZZgGALuXNtfgAedJVUfXkdsJkUB1hRfoJNvoKew1aPnpjv8lqpuiEFFfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169579; c=relaxed/simple;
	bh=zFd+crYNBoIhwmg9zBQSzkZRt5KWYI8A7sqnEv79ZjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pbmpC0hDy/vrkUCTcEicsPN85vyhGTvqOJPHImfVZL0V/IkXe4GNZxy+e00Mb/LB+lURyI8K4gUYGz0OnXFLOBNdBtIE4dFvqeDpP5w7UO/3Ce52oJ7/y669x2rinU6/xhyJs4fpuG82FoKsdA99eu84lj+kmCA3krXyr8ICDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M9UnI8nJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8Gpq6006815;
	Tue, 24 Sep 2024 09:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XeOjY3wUznkw+ahjVc0JnDUgcVBeoN2HheVMXs1tMR0=; b=M9UnI8nJyDCN0KWp
	WHfiZnB8jNXZ8G0QoVY/4dm6ZGFq2HnyRv0gL/5PLakjGRLgXKnf/E3Zg46xE0zr
	kwnGnvq56weVxnARBYgTkZpkOawaPNipMtYO4Ujo0ygPqPsyFN4TdYflD+XyE3Gg
	B2e4scrFYzytQ3nlpFN9dKLvG+2HP8Vkmh4Yj0d+De/FcwFgP/6kuH9ZygFjrhuc
	mLfszxVL6T8jCepMMgkAysNXSECHebB5rOEDsj/MUJW4qUp11IrEpynPuURYwjm3
	ALno9UXF1mptKB4BqeQQZNnVNcuF9f9EHHZIrnTa3XMQCoPlDC0lJCOg4D96bOnX
	54eWEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3s7s98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:19:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48O9JLx0019239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:19:21 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 02:19:18 -0700
Message-ID: <023f532b-62d6-4a38-b288-e08b5f7788ac@quicinc.com>
Date: Tue, 24 Sep 2024 17:19:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: Enable Ftrace and STM configs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240920075905.19441-1-quic_jinlmao@quicinc.com>
 <CAA8EJppY4QXDWK1QsrorQM8NTOmi4cK_Fjhkzf10muRE85BQ-w@mail.gmail.com>
Content-Language: en-US
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAA8EJppY4QXDWK1QsrorQM8NTOmi4cK_Fjhkzf10muRE85BQ-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uKIMM_p4iiRZnlNb-rgxeOUQiMwg10-e
X-Proofpoint-ORIG-GUID: uKIMM_p4iiRZnlNb-rgxeOUQiMwg10-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=765 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240064



On 2024/9/20 16:10, Dmitry Baryshkov wrote:
> On Fri, 20 Sept 2024 at 09:59, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>>
>> Ftrace logs can be captured by STM over TMC sink path. We can enable
>> ftrace logs along with HW trace of coresight component. The timestamp
>> of ftrace logs and hw traces will be in sync which helps to debug.
> 
> You are describing what can be done. Please describe why this is
> necessary and what is actually being done. See
> Documentation/process/submitting-patches.rst. The "why" part is the
> most important.
> 
Thanks for the review. I will update in next version.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   arch/arm64/configs/defconfig | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 4a3999eefa67..c0a56e58e554 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1554,6 +1554,12 @@ CONFIG_NVMEM_SNVS_LPGPR=y
>>   CONFIG_NVMEM_SPMI_SDAM=m
>>   CONFIG_NVMEM_SUNXI_SID=y
>>   CONFIG_NVMEM_UNIPHIER_EFUSE=y
>> +CONFIG_STM_PROTO_BASIC=m
>> +CONFIG_STM_PROTO_SYS_T=m
>> +CONFIG_STM_DUMMY=m
>> +CONFIG_STM_SOURCE_CONSOLE=m
>> +CONFIG_STM_SOURCE_HEARTBEAT=m
>> +CONFIG_STM_SOURCE_FTRACE=m
>>   CONFIG_FPGA=y
>>   CONFIG_FPGA_MGR_ALTERA_CVP=m
>>   CONFIG_FPGA_MGR_STRATIX10_SOC=m
>> @@ -1663,7 +1669,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
>>   CONFIG_MAGIC_SYSRQ=y
>>   CONFIG_DEBUG_FS=y
>>   # CONFIG_SCHED_DEBUG is not set
>> -# CONFIG_FTRACE is not set
>> +CONFIG_FTRACE=y
>>   CONFIG_CORESIGHT=m
>>   CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
>>   CONFIG_CORESIGHT_CATU=m
>> --
>> 2.46.0
>>
> 
> 


