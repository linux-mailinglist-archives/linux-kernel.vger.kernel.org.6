Return-Path: <linux-kernel+bounces-271810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD45594537B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8852B28820E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9DF14A4FF;
	Thu,  1 Aug 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dthR0e1X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C814A4DC;
	Thu,  1 Aug 2024 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541505; cv=none; b=PB+QAnmnDK2JLKFDxfm+4Fw/7x+t1qD+s76RWOvbDuIv3BoTeuy5U0YnIi4v8r5xyw9NqdJlkojmYNpfO9Z4UgMx9O07CnQQoxxB24661jM4u6iqg8UxHY97DUEI8Y3ALD3dqUftRq1feLkI3AH/Vg2Ql/AIe11Szgbx4rOiivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541505; c=relaxed/simple;
	bh=e24aorOXXDSkafQjHgeuqoEnpvyYdfplH57jQgBSlcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oMghuNSZCnDs/LVATiLQbZKieIDijvRk8uMrjH+GdPPLzlTtwA48vJNLvTfYrYtaQQpUuy+8/PWQuf5/Yulb3NqFrMtZVDvW5Tu8uhEJqUnZCykoe09BNc+2AJIQJZjX7C3wrkp6PGQHI4/zoASdh7079ncQ5Ucgq+MFQ59CDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dthR0e1X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471DadCb024582;
	Thu, 1 Aug 2024 19:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e24aorOXXDSkafQjHgeuqoEnpvyYdfplH57jQgBSlcI=; b=dthR0e1X2lhE7Vf8
	fQOIbvLzaPCFLv1mvRARWyZSr4sD69Ni14xhfJcgRlHTVNMVezLEXnunWKIlvfn4
	SqkDiV4+08fSOrWEXBYGbFEeWU/A0fjDnJ9al3LwfI6fg19Drn+DYFuM/OiZqhDT
	vt9sy1rrVwIPg4IczxA8nmcusvae6eN8QcnL0CJiuiGQ+aseWisHN3o3JUtDKzPs
	318oqKOKDEPEQ/AF194OYRdz/0GqIUHeyUSauO/2cxlDKsIsN5EhAEwFs5aH4T7x
	QbGgLAw4j9hYViIfbdA1oMROLOsintesDDYSvM1u2j8xZKHU7q5xzWzrYUqBWiLQ
	A+1LRw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qjpjdkxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 19:44:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471JiXdN021392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 19:44:33 GMT
Received: from [10.110.73.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 12:44:33 -0700
Message-ID: <9f245c3c-b6fc-4491-af9a-ae21ee8e1edd@quicinc.com>
Date: Thu, 1 Aug 2024 12:44:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Add SCMI transport descriptors
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <etienne.carriere@st.com>, <peng.fan@oss.nxp.com>,
        <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
        <dan.carpenter@linaro.org>, <souvik.chakravarty@arm.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <9c476b12-a4ca-43f7-875a-eb0a1032c494@quicinc.com> <ZqvgzwDtxdOuM1WJ@pluto>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZqvgzwDtxdOuM1WJ@pluto>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XuMve7ps3s8E5qi3l6WinMTwWg9hhTD8
X-Proofpoint-ORIG-GUID: XuMve7ps3s8E5qi3l6WinMTwWg9hhTD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010130


On 8/1/2024 12:23 PM, Cristian Marussi wrote:
> On Thu, Aug 01, 2024 at 12:17:36PM -0700, Nikunj Kela wrote:
>> On 7/30/2024 7:47 AM, Cristian Marussi wrote:
>>> Hi,
>>>
>>> this small series is an extended version of this recent, already reviewed,
>>> series [1] posted by Peng to add a new arm,scmi property to describe some
>>> platform-specific SCMI timeout constraints.
>>>
>>> On top of that, this adds 2 more properties to describe a couple more
>>> platform-specific transport characteristics.
>>>
>>> To minimize conflicts, the whole series is based on top of another recent
>>> series, which represents a rework of the core SCMI stack to split SCMI
>>> transports as standalone drivers. [2]
>>>
>>> Thanks,
>>> Cristian
>>>
>>> [1]: https://lore.kernel.org/linux-arm-kernel/20240709140957.3171255-1-peng.fan@oss.nxp.com/
>>> [2]: https://lore.kernel.org/linux-arm-kernel/20240730133318.1573765-1-cristian.marussi@arm.com/T/#t
>>>
>>> ---
>> Thanks Cristian for the series. I have validated them on Qualcomm
>> SA8255p(to be upstreamed) Ride platform.
>>
> Thanks for testing...does this solves your issues ?
> (assuming that will go through as it is ...)
>
> Cristian

Yes it works like a charm! Hope this series goes through.

-Nikunj


