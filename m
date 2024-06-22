Return-Path: <linux-kernel+bounces-225503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F61913177
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4CA1C21378
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8CD5664;
	Sat, 22 Jun 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G67eX4zf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B64A04;
	Sat, 22 Jun 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719021280; cv=none; b=Hd07hq94gA6vnfOJOrjldxOIZvC5OS5vA7t1Fw6OoHm7fB3pqWB4RVJOusL5XP2R5zCjpcaUF2z/iBIa/wCDLvoJWLZNT+Lco5jd2JwaksPbsOi8J/0USjil9DUrmq22mdo5PcKQouACCq5ln5CaEOJ4OFQWdVpqgHxhDOE5H4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719021280; c=relaxed/simple;
	bh=84R3iKwW+SU6LFQPMo8TBffGbXDbODp6Z5ykMUEY1zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fybKtidGcutLE1B2HKetYPP5z9nyJ7+N+V42kQj82XqTmryNhPEkHNs+g4szPNeVOvzK8okgLQvdwhJOTQqDwbzgUgbCUmc+jUj+uO3vcrxnt4OzX21OD9qVxfpqIw8m3PDchjb5CkVRX+oBMy6vi+KWk/M9/AIZwL3ebGGNKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G67eX4zf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LE84hn010564;
	Sat, 22 Jun 2024 01:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V2GHY3NwBXbPOAZudGB0BH745pzy3yzUbWl1R6JBBi8=; b=G67eX4zflHU/zXYU
	7FmGia70XHp6GbusLsMaKaZ2kB3cyijs8LZy5ecYwTquuDc/4iqBe4aIZoy6j3Gh
	UzNk4Lgb0QgWpWqC38yWRbawTSjuEo+Vh36HPbXWEq7C98QE6nWBMLBjyHUN32I5
	iehRJUo1fyXrXxPzZ8vWmcGPRgSR7sXPWD567aWMhzKKU8BGHrxIHHqZT2YS115i
	LnoP5ELz9NYDW/cddgVaK3ODpDKdgq/TUTZC6CvK8rIJ8vhAMQMYRh4+g0fXbhGa
	nThtX2/Q8TMRSas+Kyd3ahkQP+AMpGAZEiT0AHIKDZLbv+ytTvHffYWLZnf7azM4
	MrX+5w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrrcbxh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 01:54:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45M1sQpL027220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 01:54:26 GMT
Received: from [10.110.82.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 18:54:22 -0700
Message-ID: <1b4d1aaa-ae5f-a6ed-d6b3-e922e84c3d84@quicinc.com>
Date: Fri, 21 Jun 2024 18:54:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/4] drm/msm: register a fault handler for display mmu
 faults
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul
	<sean@poorly.run>,
        <freedreno@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <dianders@chromium.org>, <quic_jesszhan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240517233801.4071868-1-quic_abhinavk@quicinc.com>
 <20240517233801.4071868-2-quic_abhinavk@quicinc.com>
 <CAE-0n517DSbNim+K3=N2J2R0iZn44MS3siLKkhdLq05GTfaHtQ@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAE-0n517DSbNim+K3=N2J2R0iZn44MS3siLKkhdLq05GTfaHtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DWD4KbIIgwdZwq4WBnH8jD_rBnK-aeNi
X-Proofpoint-ORIG-GUID: DWD4KbIIgwdZwq4WBnH8jD_rBnK-aeNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406220009



On 5/20/2024 9:12 PM, Stephen Boyd wrote:
> Quoting Abhinav Kumar (2024-05-17 16:37:56)
>> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
>> index af6a6fcb1173..62c8e6163e81 100644
>> --- a/drivers/gpu/drm/msm/msm_kms.c
>> +++ b/drivers/gpu/drm/msm/msm_kms.c
>> @@ -200,6 +200,28 @@ struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
>>          return aspace;
>>   }
>>
>> +static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void *data)
>> +{
>> +       struct msm_kms *kms = arg;
>> +       struct msm_disp_state *state;
>> +       int ret;
>> +
>> +       ret = mutex_lock_interruptible(&kms->dump_mutex);
> 
>  From past experience I've seen the smmu fault handler called in hardirq
> context, so it can't sleep. Is there some way to grab the register
> contents without sleeping? Otherwise this will have to fork off
> somewhere else that can take locks, runtime PM resume, etc.
>

Sorry for the delay in this series.

Yes, this is a valid point.

Let me see move to msm_disp_snapshot_state() as that one will spawn a 
kthread then dump the registers.

>> +       if (ret)
>> +               return ret;
>> +
>> +       state = msm_disp_snapshot_state_sync(kms);
>> +
>> +       mutex_unlock(&kms->dump_mutex);
>> +

