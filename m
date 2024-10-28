Return-Path: <linux-kernel+bounces-384018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97E59B2348
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2D281B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE918893C;
	Mon, 28 Oct 2024 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qserw/KS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B9178CC5;
	Mon, 28 Oct 2024 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084049; cv=none; b=Ze6cs8aCI91v5Oj8gHwx4gaYplcDmf7jthzSm0kov7oZIweQMDXAzTfeVkUNxrrvGM5uUowJO3/EMEGLzSF3zlLsUOPY8tYzpCw8BiqrtNxgUmRZiZGsPIkj573Iy14tnIhsoSge+P9vk9677I/ofQm2MEbqpG0noOc+PDUl6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084049; c=relaxed/simple;
	bh=K8HHtVVsRmVmZcZaYQUht+3NWbzZllIb2/axIpXkKyQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=hARI7RkSpJT1T7yWZiMCC5TPyQanygg8omTvPfX/P0XJhpHtomWi+Zp10zXliaW6QJfqBWAod8rVZLQ9SwuryRIWZY28xzPeP7JHs1PVpvj4dFujREjvcdQWLQqMSnkar/jlUZPnHdc8vHYN3nZgUS/pxfZgiUJwFMkKAHfdJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qserw/KS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RNpLGo031126;
	Mon, 28 Oct 2024 02:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5zN10JdhAIAKuyeOLdvbGAXdgY1Y+VOJbyGob/tjS3A=; b=Qserw/KST6S3KzwA
	iVrBOggXDNlmNEvOn0NGaSo+LUIFysn0ADcSOCJCyVM8VWKb+CA7Mk7rtwO1mNRJ
	7XIm5Zt3yXhEuupgGu85by34E/Gu1WvCyK67hVqC1Hfbs6khVSFrYUAJJNs2LAyS
	Jrz0PGA/r1oQ9IExwJxboMCYPu362dQnJitlsSLhBS41loAwItx5JHL8m04bJO1f
	rYtvnfUrlkJzpmh9gmHY/Vo9//wRxhY8W6V6FzTAgAutFbuSfDsSg+vP1gOl1YHl
	ZCrYsVN0h3R//h0cDzEHK+5zJEkfnClzAtetmzWVz/9F9y6lyL54sQ2PR5Cr9C1o
	QwtDJg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gskjucvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 02:54:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49S2rxgZ023044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 02:53:59 GMT
Received: from [10.64.68.153] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 27 Oct
 2024 19:53:55 -0700
Message-ID: <e263d461-9e2b-4ffe-8221-cd9ecdd142c9@quicinc.com>
Date: Mon, 28 Oct 2024 10:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add coresight nodes for QCS615
From: Jie Gan <quic_jiegan@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20241017030005.893203-1-quic_jiegan@quicinc.com>
 <69be09ec-e9a5-4fb6-890e-74a65f3ce404@oss.qualcomm.com>
 <3f90b3d6-9637-47b7-ad8a-ff43cb28ad32@quicinc.com>
Content-Language: en-US
In-Reply-To: <3f90b3d6-9637-47b7-ad8a-ff43cb28ad32@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G65cGfCj_fY372rmIK411cIbN-yhb_Yz
X-Proofpoint-ORIG-GUID: G65cGfCj_fY372rmIK411cIbN-yhb_Yz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280023



On 10/28/2024 8:54 AM, Jie Gan wrote:
> 
> 
> On 10/26/2024 2:47 AM, Konrad Dybcio wrote:
>> On 17.10.2024 5:00 AM, Jie Gan wrote:
>>> Add following coresight components on QCS615, EUD, TMC/ETF, TPDM, 
>>> dynamic
>>> Funnel, TPDA, Replicator and ETM.
>>>
>>> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
>>> ---
>>> Already checked by command:dtbs_check W=1.
>>>
>>> Dependencies:
>>> 1. Depends on qcs615 base dtsi change:
>>> https://lore.kernel.org/all/20240926-add_initial_support_for_qcs615- 
>>> v3-5-e37617e91c62@quicinc.com/
>>> 2. Depends on qcs615 AOSS_QMP change:
>>> https://lore.kernel.org/linux-arm-msm/20241017025313.2028120-4- 
>>> quic_chunkaid@quicinc.com/
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs615.dtsi | 1632 ++++++++++++++++++++++++++
>>>   1 file changed, 1632 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/ 
>>> dts/qcom/qcs615.dtsi
>>> index 856b40e20cf3..87cca5de018e 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
>>> @@ -202,6 +202,18 @@ l3_0: l3-cache {
>>>           };
>>>       };
>>> +    dummy_eud: dummy_sink {
>>
>> Node names (after the ':' and before the '{' signs) can't contain
>> underscores, use '-' instead.
> Sure, will fix it.
> 
>>
>> [...]
>>
>>> +        stm@6002000 {
>>> +            compatible = "arm,coresight-stm", "arm,primecell";
>>> +            reg = <0x0 0x6002000 0x0 0x1000>,
>>
>> Please pad the non-zero address part to 8 hex digits with leading
>> zeroes, across the board
> Will fix it.
> 
>>
>> This looks like a lot of nodes, all enabled by default. Will this run
>> on a production-fused device?
> Yes, usually Coresight nodes are enabled by default. Those nodes can run 
> on the commercial devices.
Sorry, my last clarification is not clearly. The Coresight nodes are 
enabled by default for commercial devices(fused), but only part of 
functions can run with commercial devices because it needs check fuse 
data before running.

If we want enable all debug functions related to coresight nodes on 
commercial devices, we need APDP override(APPS debug policy override) 
procedure first. The APDP override procedure will override some fuse 
data to allow debug sessions.

Thanks,
Jie


