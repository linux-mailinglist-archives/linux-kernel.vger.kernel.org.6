Return-Path: <linux-kernel+bounces-261066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A493B284
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557661C235CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF781DA26;
	Wed, 24 Jul 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hpsp69pg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107408F48
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830689; cv=none; b=S2bnTnJUyIDvcRkMCazsOv4cvTaDK8Sw//TvnFxOTTqgVNQHKPnNQd7qfrr+1DHNw9QKFrJ9alyXg3ClfGnNhWKSWh5LzPFiezjfHERG7lWmPIXv6Yo/pJ3vUvYpRHMxNc6e/Thl8AU9IS0uFt8gcs8sLD4hca+89QPZyS/LOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830689; c=relaxed/simple;
	bh=E1HZYz7J5DFuSpxB7yUcWWqZUkPFDeMY2uDTQop76+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6HeO3OfhnZKAop7bfy3EBpnoY9IUB7+yvmQAjR4MOZCLsiwolFuUfJgn4EadltB+6gNETlcH0BPVt/nyUiN2sD0hI0dSVZHzCGvWv1TA6NTYRvhBMphFPLBRNb7+Ltmk23BrILhLSmPDcKo/65jkLVIsddrXd4PGfv6Xl2M848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hpsp69pg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OA0hiK005900;
	Wed, 24 Jul 2024 14:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fxbhfKXGU3FGpyw+e6YbwN2tEDd9+6BmhQLlA0Phuzw=; b=Hpsp69pg85VN9p5n
	IMe7JtHrjXJZmdCNdD367lEw85kvzAiviU0ieA5vRGYgYig3o7rqzEJXhzxHRq72
	3PErH0V3p/2O2beWS1jYl7fP5sx87je+6rb0Jz6rMFERnerOl12X6A8ffjJ/LUCh
	lhzqBD16otsK0JGFylX6cAYWaDV965YIQc1xey8RjHn/WpY3pz+ZuQTdZzSoXJJu
	/+akwvqxobBuqQrL31KEqorUV7iOZXb0F+vaxkbldTPNWPLcgRDzWIdoSLSx0kDg
	GXh/dBQ1fFuxHsKbPCplzR/vAKPPyh8US65JjidYoowghNj9OvI9jINCL3keKFR8
	Z2KGkA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6dk23q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:18:00 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OEHxY1003412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:17:59 GMT
Received: from [10.253.11.54] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 07:17:58 -0700
Message-ID: <1ef6fa28-8a4d-427e-8a22-98e3055280d4@quicinc.com>
Date: Wed, 24 Jul 2024 22:17:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: bus: Return -EIO instead of 0 when
 show/store invalid bus attribute
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240723-bus_fix-v1-1-175f926805dc@quicinc.com>
 <2024072316-yeah-snide-ca28@gregkh>
 <70ec36ff-1be9-4fc3-9792-4950a483b272@quicinc.com>
 <2024072449-tidy-cosigner-f681@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024072449-tidy-cosigner-f681@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mRrj9f0QFqoBV6Ch0nbGfyOAht0scKB0
X-Proofpoint-ORIG-GUID: mRrj9f0QFqoBV6Ch0nbGfyOAht0scKB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240104

On 7/24/2024 9:29 PM, Greg Kroah-Hartman wrote:
> On Wed, Jul 24, 2024 at 08:56:18PM +0800, quic_zijuhu wrote:
>> On 7/24/2024 1:31 AM, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 23, 2024 at 10:55:43PM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> Return -EIO instead of 0 when show/store invalid bus attribute as
>>>> class/device/driver/kobject attribute.
>>>
>>> Why?  What is this now going to break?  You are changing a user-visable
>>> api that has been this way for 20+ years, how was this tested?
>>>
>> this change should break nothing.
> 
> Have you tested all tools that access these files?  Please document what
> was done for testing please.
> 
not yet. let me do more investigation then give reply.

sorry to send v2 without noticing this reply.
let us still discuss with this mail thread.

>> tested by wc a writing only bus attribute, for example
>>
>> root@kvm-Q35:/sys/bus/gpio# ls -l
>> --w------- 1 root root 4096  7月 24 20:20 drivers_probe
>> root@kvm-Q35:/sys/bus/gpio# chmod u+r drivers_probe
>> root@kvm-Q35:/sys/bus/gpio# wc -c drivers_probe
>> 0 drivers_probe                  // for current design
>>
>> root@zijun-kvm-Q35:/sys/bus/gpio# wc -c drivers_probe
>> wc: drivers_probe: Input/output error  // for this change
> 
> That's just using a shell, I am referring to actual tools that read
> these files and rely on the contents and error values that they provide.
> 
make sense.
> thanks,
> 
> greg k-h


