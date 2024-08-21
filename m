Return-Path: <linux-kernel+bounces-295629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 446B2959F41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B3E1F2160D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11951AF4FA;
	Wed, 21 Aug 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iwLn4bcY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D46199FC6;
	Wed, 21 Aug 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249111; cv=none; b=ONScMIL+a1+nuUCiOiWd6gKxhB1mPIN/zMHJI9a/miJlaBYGK1m5wKBBoPT2M+Hm3q3XS3djMQwSV+kbKMox8PP0cADGDrzULHbNUKOiXRl1XQ8IVHM1f6i8mkDyIv4Mmdw+Kq2SmAppUpGwWcRJKM1EHgFVSJFO9yUUR4WMLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249111; c=relaxed/simple;
	bh=L8fub+mYsQhj+lVmbRK8xHTNCb+gtWl6pWQHrECpObQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qa+82DGhCi1adQzgOL4G++s17XDw5IoBi9qb3oowU/LIXI7/j+YRPN8e1iU+q3yNwn1sROY9EzJvJEynTETsWY0lGCZapOhMUUs/RenNjM6jHPeqayLO2grx9WzZE0ZJaHtnn7oZtjTeBhWIjNrE31Zgc/cxbXHgF/OY/+jlVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iwLn4bcY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBkdKv024590;
	Wed, 21 Aug 2024 14:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xlMv2ynVfIv2mD8mK6DVP/T6SS2H5LuAkFF6cS5f5A=; b=iwLn4bcYnrfU5iXL
	qvmc/Yc4MevrjfnYY95q70nKy1KTTMsMV2gmwXb32ZpOTmvRHJeGmccwFyVcQH7l
	+O1H3/oubjkfM+Lj2aG94j0ZAHj/3bI4BiffT3kyBxJWuL+jOJcNgCsdwb2YFtCp
	FgOdkaRLj9R0lBCugDlNwN2qsmCyIZyeGg6YF3ts03bpcXDwBJc7eKOHbEypgc0l
	6k0FCeo5aEWkvzDDNXrpOn9HuT9IyZHttcTrHhFCFSpVpV5bETBw6VedCbVJt61s
	xUH18iuSUm6an+S+3ZnpGP55s6DR8Au7xrYGDHOwdz7Vu0S34sHhq9s1cyDvQdoA
	p9m1/w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmw0jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 14:05:00 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LE4wAN017946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 14:04:58 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 07:04:57 -0700
Message-ID: <2b38828b-ebb0-4602-9320-9adc5deb76f6@quicinc.com>
Date: Wed, 21 Aug 2024 22:04:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: xhci: ext-caps: Use cpu_relax() when polling
 registers
To: Mathias Nyman <mathias.nyman@linux.intel.com>, <Thinh.Nguyen@synopsys.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhongqiu Han
	<quic_zhonhan@quicinc.com>
References: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
 <20240820121501.3593245-3-quic_zhonhan@quicinc.com>
 <cd0cc5d1-0776-4d5f-9f3f-8261deb0e3bb@linux.intel.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <cd0cc5d1-0776-4d5f-9f3f-8261deb0e3bb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bm-M6hf3pvMDddTFHzxovYc5eyt6lswa
X-Proofpoint-GUID: bm-M6hf3pvMDddTFHzxovYc5eyt6lswa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=414 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210102

On 8/21/2024 5:40 PM, Mathias Nyman wrote:
> On 20.8.2024 15.15, Zhongqiu Han wrote:
>> It is considered good practice to call cpu_relax() in busy loops, see
>> Documentation/process/volatile-considered-harmful.rst. This can lower
>> CPU power consumption or yield to a hyperthreaded twin processor and
>> also serve as a compiler barrier. In addition, if something goes wrong
>> in the busy loop at least it can prevent things from getting worse.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   drivers/usb/host/xhci-ext-caps.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci- 
>> ext-caps.h
>> index 96eb36a58738..25d148d60ab0 100644
>> --- a/drivers/usb/host/xhci-ext-caps.h
>> +++ b/drivers/usb/host/xhci-ext-caps.h
>> @@ -144,6 +144,8 @@ static inline int xhci_find_next_ext_cap(void 
>> __iomem *base, u32 start, int id)
>>           if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == 
>> id))
>>               return offset;
>> +        cpu_relax();
>> +
>>           next = XHCI_EXT_CAPS_NEXT(val);
>>           offset += next << 2;
>>       } while (next);
> 
> Similar case as with PATCH 1/2
> 
> This isn't a busy loop polling for some value.
> We traverse xhci extended capabilities until the one we are looking for 
> is found.
> 
> Thanks
> Mathias
> 
Hi Mathias,
Thanks a lot for the review, yes, it is similar case as with PATCH 1/2
there is not a busy loop polling, sorry for this and i will careful for
similar case next time, and thanks for the discussion as well.

-- 
Thx and BRs,
Zhongqiu Han

