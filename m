Return-Path: <linux-kernel+bounces-429188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC449E196D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C0B626F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE41E009F;
	Tue,  3 Dec 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KhK1cOS5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7031DF275;
	Tue,  3 Dec 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219461; cv=none; b=Jap04sRBA175YbGXxKMDU9YOYmysTMxTtaP5Rl52DCdhmS4UjVA5XXFYKIXJG0PStae5pRb1roAkL7joyIEdi2aOUNIbPdOt+NyL0rWPCvJrTY4jT61IjuHP8IMVmsuYdIIEMVfAW0QSX7d3UNySqNDdoXnQTo4u81leT/p0tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219461; c=relaxed/simple;
	bh=tKxIDUi3DuFKMPeuelQronMe4uthf4bpfeMRsKTeYfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QUwsXn7dvCowDiKZ5rV3mMdtSRDMM7nXIxf1F19L5v44yp2Hbgk6Ay2hR/BUrE+tb/JkKBa+5QnIsgENHwb6qgRtuKgk5L9lhHcn50mskcxMHVYHYPRw4mPfJkH90tONQJEM0zLFqJlhodzT18CB72+Rotfycw1RE0sh16/WyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KhK1cOS5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B36322H028726;
	Tue, 3 Dec 2024 09:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qaeb7KS/lbchisxJTVciw+SB/QXy+43izDJlqXdv0bE=; b=KhK1cOS5erwwzC9I
	ObagpkTCdleSFpZGp3IPy03OoTCClBB1T6aXwAcF17x1nHPXF4H7mlb5XuawkLrI
	Y6yVH8jjJXfceyrJP1xK/4wIoWRle2Yl0cbVQvDv59Yi8Ue3/+7oJ7P8KRu2yS2t
	53CN5R9nSzLYEnhuuUoB5o9B9mVftbn9FJVkQYvBMqeBn/fzbRb+v+eprUUilaND
	jnxl0QbqtXyiTENc2iNm64YsQsWy/ISwfaSqLdK5WhcymNjJ5PkvZfN2yvYDZzfM
	rsAe0AX4KP8n54K9Dgigf3wBMEz7UVTTkoedF1GT259Hk6EbCsT4fHwurhv+CTkv
	vAp5xw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vcegkgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:50:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B39ou9t011102
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 09:50:56 GMT
Received: from [10.216.55.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 01:50:52 -0800
Message-ID: <78b31cfc-121f-455d-aabe-63a1fe7c9a02@quicinc.com>
Date: Tue, 3 Dec 2024 15:20:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYzXSB1c2I6IGdhZGdldDogdV9zZXJp?=
 =?UTF-8?Q?al=3A_Fix_the_issue_that_gs=5Fstart=5Fio_crashed_due_to_accessing?=
 =?UTF-8?Q?_null_pointer?=
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "mwalle@kernel.org"
	<mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>
References: <TYUPR06MB62170A30651D64EB59F94B88D22F2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <59bc14c1-502e-4931-bbce-e1b01ebd53b6@quicinc.com>
 <TYUPR06MB62179A94EB3FF2AD10AA9712D2362@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <TYUPR06MB62179A94EB3FF2AD10AA9712D2362@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kBLAYNx8D2JoinlyaE3rW35glk1vo8eI
X-Proofpoint-ORIG-GUID: kBLAYNx8D2JoinlyaE3rW35glk1vo8eI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=500 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030084



On 03-12-24 12:09 pm, 胡连勤 wrote:
> Hello  Prashanth K:
> 
>>> From: Lianqin Hu <hulianqin@vivo.com>
>>>

[...]
>> And the rest seems fine to me.
>>
>> Acked-by: Prashanth K <quic_prashk@quicinc.com>
> 
> I'm very sorry that I didn't notice some of the previous requirements due to negligence in reading.
> I will modify and re-release the version as requested before.
> https://lore.kernel.org/all/b0c787ad-55a1-4fb1-b9cd-1f688ea65316@quicinc.com/
> 
Yea, Along with those, make sure to add fixes tag and cc stable kernel.
Feel free to add the Acked-by tag after making the above changes.

Regards,

