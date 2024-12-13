Return-Path: <linux-kernel+bounces-444481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985129F078B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1AA162C16
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3241ADFFE;
	Fri, 13 Dec 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gQN5K6N7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B341AF0A4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081511; cv=none; b=ZLjBM2TeXmgjOLjV3UXzEqkV3jP/Ec0/3mmVW7n8IqPbOXuDojVpiFxzQWNZrpBpK+XXInYJbvnAXNSHfDOYDS7w0ufI6ywVzFe3OBSHI63Q2jWDcMA7AZKClj/GLvu4BiZB59ZpyC32glOee6eM1NhiQxjtjUjYDpnUYZ0ivnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081511; c=relaxed/simple;
	bh=VhR6x5bYOoYqSfcwoKX+Fe7K0RLFzLzExP/O9WqsH4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tHab9gwezsRJFfPo70FdtUd/KNFfxDuqueeRt0V88MHwAPZbyk1VMw9lEoKsvHAIfUi9PDZsroB6JODCG0+/561V6kXAtu10TozWmMvaIW19HV9sawASYRHvtESHg1GK3usoCqPWynFw2suZ9KOhwwllCm9vWiOBVrIw7vKP+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gQN5K6N7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8HJvd026866;
	Fri, 13 Dec 2024 09:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I6kE8t5Yl2xYqtb9LtTwxOrdC5L10bLg5KJZZLPXHH8=; b=gQN5K6N7y+x4QkmS
	Ok7PR6HbTic3wS7g7gqgFXkA/Kkuer+Mqh67AXjhs9vplaKwldwV+pyq/Rh1dz01
	4lXlwOZwcl6hGzlPqkqNR8hIL4G9FO4lpIShH2c5wW1brHfZKEu0vRHjU5RhcE+y
	szAeZ6sLem6Csj/TA3+JVE4jQ+swbALMiC0YsNclHKfHIM0Ru3yzDAuBi7+S2Hhg
	zoh/I5l4e2Ki/6RgUkSzpwZxwH62wWhYbHfhLWjZZJyxy2TxwmXKZ52QnKUZ5FmZ
	PH+a7Q9+gW6NHgXmX7e0PwO+8ZLLLD0ULBuUf2gAMms2/m9Ac70ILLYDpgjVzmNr
	fMXTxA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40ns6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:18:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD9IIAe019113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:18:18 GMT
Received: from [10.239.132.152] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 01:18:16 -0800
Message-ID: <1e99294f-b528-4cf7-a0e0-3d78221e6982@quicinc.com>
Date: Fri, 13 Dec 2024 17:18:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight-etm4x: add isb() before reading the TRCSTATR
To: Leo Yan <leo.yan@arm.com>
CC: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@linaro.org>, <alexander.shishkin@linux.intel.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241204112332.3706137-1-quic_yuanfang@quicinc.com>
 <20241204151650.GA1976757@e132581.arm.com>
Content-Language: en-US
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
In-Reply-To: <20241204151650.GA1976757@e132581.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p_9MwUObVSA2qo8Me6vwxP0ygYgJGMDg
X-Proofpoint-ORIG-GUID: p_9MwUObVSA2qo8Me6vwxP0ygYgJGMDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 mlxlogscore=902 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130063



On 12/4/2024 11:16 PM, Leo Yan wrote:
> Hi Yuanfang,
> 
> Recently I just acrossed this part, so some comments.
> 
> On Wed, Dec 04, 2024 at 07:23:32PM +0800, yuanfang zhang wrote:
>>
>> From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
>>
>> As recommended by section 4.3.7 ("Synchronization when using system
>> instructions to progrom the trace unit") of ARM IHI 0064H.b, the
>> self-hosted trace analyzer must perform a Context synchronization
>> event between writing to the TRCPRGCTLR and reading the TRCSTATR.
>>
>> Fixes: ebddaad09e10 ("coresight: etm4x: Add missing single-shot control API to sysfs")
>> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
>> ---
>> Change in V2:
>> Added comments in the code.
>>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 66d44a404ad0..decb3a87e27e 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -906,6 +906,13 @@ static void etm4_disable_hw(void *info)
>>         tsb_csync();
>>         etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
>>
>> +       /*
>> +        * As recommended by section 4.3.7 ("Synchronization when using system
>> +        * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
>> +        * self-hosted trace analyzer must perform a Context synchronization
>> +        * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
>> +        */
>> +       isb();
> 
> As described in the doc, the "isb" is only required for system
> instructions case.  It is good to only apply the ISB on system
> register case:
> 
>         if (!csa->io_mem)
>                 isb();
> 

updated in PATCH V3.

>>         /* wait for TRCSTATR.PMSTABLE to go to '1' */
>>         if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>>                 dev_err(etm_dev,
> 
> As mentioned in system register case: "Arm recommends that the
> self-hosted trace analyzer always executes an ISB instruction after
> programming the trace unit registers, to ensure that all updates are
> committed to the trace unit before normal code execution resumes."
> 
> And for MMIO case:
> 
> "When the memory is marked as Device-nGnRE or stronger.
>  ...
>  - Poll TRCSTATR to ensure the previous write has completed.
>  — Execute an ISB operation."
> 
> Thus we need to add an ISB after polling.
> 
>         isb();
> 

updated in PATCH V3.

> For consistent behaviour, a relevant thing is the dsb(sy) in
> etm4_enable_hw().  I do not think the dsb(sy) is necessary, as the
> driver uses the sequence "write TRCPRGCTLR + polling TRCSTATR" to
> ensure the data has been populated to trace unit, the polling
> operations somehow act as a read back.  And the ETM manual does not
> mention the requirement for DSB when enabling trace unit.  Thus, we
> should remove dsb(sy) (maybe use a separte patch).
> 

updated in PATCH V3.

> Mike / Suzuki / James, please confirm if my conclusions are valid.
> 
> Thanks,
> Leo


