Return-Path: <linux-kernel+bounces-249773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9C92EFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BCE1F21C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD016EBEC;
	Thu, 11 Jul 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K3UvANMn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBE5BACF;
	Thu, 11 Jul 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726052; cv=none; b=HCTqnGwMjKVZ0drRSCRL5/Oot3yEeexgOm+RXdIcWHYz8rGpvQviKfZBpH0N+7N9/bg2h2QEprpQr+iatjmWV84U4Pgjn6c2C+TvZj7QpTszC6cnHhA2Q6JpQmITbY8KkC7IJQhqQazmnL3EDlbeuJTRqaqJrrUyIwWBjEF4IhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726052; c=relaxed/simple;
	bh=WTO8nBFtNNsR8zMMo/kRRpHE+3MJgYaGztu5gFTI4PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lmMC7XPpIGULJYiSax+KuoXEViL4nY7ZlJNV4ou9/acxGEERsIFiNVppt85hEzuIpH27v0Ody3H2JTx4l1vR384198e/Fkl1veQCGvuqjbglb9PVa8HUPf9dhqtr5LzuHcT0UX9GBtjS/Yf3YR5su/ohi2ka6N/kcmGU9krl5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K3UvANMn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BDLirT007342;
	Thu, 11 Jul 2024 19:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	01He2AukA3gNli5ye4GmZPgjjeR1c89/VmEYxkoI18U=; b=K3UvANMnRv7D4o2/
	BMk7fqojcDm81lzaRtLOnH5BVCeeAq4XqM7neX5rnp8uJX+VNkaKzWu9gkMG7BIk
	dL4brSvDYShCD4EnOapEtiE8IWK2gFNX+FlVpUOA/y/qzJvQN3folGTZdmixo+b8
	bCdEHMJLwFznbKQigebJxyPxF9mYHZQSNCmI4gAPGemugdrrUo2F+rRs//3zDTlp
	1eM5FqEwXxt8bHCZSdrjdVvb5gCnhg0uY8Ol1E2zUO5hM9ErmzMi3mZAi6IcwnXc
	AR027uawPbZ/fkHiRc6kP1qQxZ3EFhb09XADtoFZPm6IifJUducWiD4cUaP3rfoD
	T2kS4g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg45kq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 19:27:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BJRPPN015571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 19:27:25 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 12:27:24 -0700
Message-ID: <ce7863a7-f84e-42f0-9aa5-54b43edcd260@quicinc.com>
Date: Thu, 11 Jul 2024 13:27:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] agp: uninorth: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        David Airlie
	<airlied@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240615-md-powerpc-drivers-char-agp-v1-1-b79bfd07da42@quicinc.com>
 <99d6c483-9291-4bd0-8e62-76022abb762c@quicinc.com>
 <7b7e2952-fb54-48b0-93bc-f96c04e5cdd3@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <7b7e2952-fb54-48b0-93bc-f96c04e5cdd3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ADn9gVcQwjMLZ4n9ELF6H4wQf-jPtw3V
X-Proofpoint-GUID: ADn9gVcQwjMLZ4n9ELF6H4wQf-jPtw3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_14,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110134

On 7/11/2024 12:19 PM, Jeff Johnson wrote:
> On 6/28/24 20:14, Jeff Johnson wrote:
>> On 6/15/2024 2:01 PM, Jeff Johnson wrote:
>>> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>>> drivers/char/agp/uninorth-agp.o
>>>
>>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>>   drivers/char/agp/uninorth-agp.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/char/agp/uninorth-agp.c 
>>> b/drivers/char/agp/uninorth-agp.c
>>> index 84411b13c49f..b8d7115b8c9e 100644
>>> --- a/drivers/char/agp/uninorth-agp.c
>>> +++ b/drivers/char/agp/uninorth-agp.c
>>> @@ -726,4 +726,5 @@ MODULE_PARM_DESC(aperture,
>>>            "\t\tDefault: " DEFAULT_APERTURE_STRING "M");
>>>   MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
>>> +MODULE_DESCRIPTION("Apple UniNorth & U3 AGP support");
>>>   MODULE_LICENSE("GPL");
>>>
>>> ---
>>> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
>>> change-id: 20240615-md-powerpc-drivers-char-agp-db644db58c24
>>
>> Following up to see if anything else is needed from me. Hoping to see 
>> this in
>> linux-next so I can remove it from my tracking spreadsheet :)
> 
> I still don't see this in linux-next.
> Adding Greg KH since he's picked up many of these fixes.
> Hope to have all of these warnings fixed tree-wide in 6.11.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Dave, this seems like a trivial fix that is stuck, but normally routed 
through DRM.  I hope I'm not over stepping, but I think I'll drop this 
in drm-misc-next on the 19th if there isn't any other activity.

-Jeff

