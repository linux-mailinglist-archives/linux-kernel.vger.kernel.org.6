Return-Path: <linux-kernel+bounces-316376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5796CEBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D6BB246BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F66188A26;
	Thu,  5 Sep 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ORluSlYh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ADF621
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515449; cv=none; b=goy4NbymMT8yTIExaelu2XgBUfbQ2ywhswjgFH12CAmzIBnD+UE3MQCfX9r3tzr5YSc4aNn8mvZlLqk25Ow/efMARr+o42i2SmN9+ZPjbN9JyShHQjbTieh3ViCb7rSmlbjn5F1I+eSqumsVPviSCba+0lu9Bn7nTphgNCmwDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515449; c=relaxed/simple;
	bh=5dxzGSTAslaJGmPXTzAzswelDdMwpyIDnw0rq3NilxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pm19ma7x7/4cV6qZRn+hrYNC7McI/kO0l5CGiB4pGc1UuQCLQYLUfEyohC+sMaaSrtzNEDrPoldIemJFj3XITUlVwcp4bGz5xhvqqSEnVbocMFA0uTVJ+ijYkf2wbK8IiqYcHUoniIMI8iiy0aXauJDZW/5Oo26oMa7+ev5LPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ORluSlYh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484FxEPf020925;
	Thu, 5 Sep 2024 05:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	77SH1uvNfWLkio+SufQcVBbFIq8m2g0KthoEkMukAU0=; b=ORluSlYhqChwmtPW
	9p4a6YMFpOY6UEz0oHZK/6Tfu5C4TDU22ps+eOF3ZwK6Ucco/HCTz/vb/QjA7M3E
	U46M8YeppE4GbNtE09RdR5XrGeEh+9et9G2yZrdzLvyMwT++TYUJha4cLOPdapQ0
	ySlFpfLWiX+xKuAxwXvNpYbM8+ngv2OyhYipws717Kp1qt+C7V7a/3XS23eVfJ+E
	Q5Et7ZnWZ0kiwi88cB0ZIUWvUIljDDzN+Stir3FVMTzVxdAC1wRkwSeimP1M4vY4
	V56X5T1OP8FmcAfqNFRnUkYN5zA6Dj7FAjp2W0jiTraLR+1He//pJtqTx9Nn0rK9
	t6RtzA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dxy26asb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 05:50:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4855oYFS002282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 05:50:34 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 22:50:32 -0700
Message-ID: <cc94e66f-6fa0-4499-a851-bac90533eeca@quicinc.com>
Date: Thu, 5 Sep 2024 11:20:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i3c/master: cmd_v1: Fix the rule for getting i3c mode
To: Billy Tsai <billy_tsai@aspeedtech.com>,
        "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>,
        "jarkko.nikula@linux.intel.com"
	<jarkko.nikula@linux.intel.com>,
        "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240826033821.175591-1-billy_tsai@aspeedtech.com>
 <OSQPR06MB7252463A7C81BF18811DB6EC8B8B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <OSQPR06MB7252463A7C81BF18811DB6EC8B8B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -fLAWtVrUT3z_pMbs6UmvaSq9103PQoa
X-Proofpoint-ORIG-GUID: -fLAWtVrUT3z_pMbs6UmvaSq9103PQoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=939 spamscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050041


Hi Billy,

On 8/26/2024 9:32 AM, Billy Tsai wrote:
>> Based on the I3C TCRI specification, the rules for determining the I3C
>> mode are as follows:
>> I3C SCL rate > 8MHz: use SDR0, with a maximum data rate of 8MHz
>> I3C SCL rate > 6MHz: use SDR1, with a maximum data rate of 6MHz
>> I3C SCL rate > 4MHz: use SDR2, with a maximum data rate of 4MHz
>> I3C SCL rate > 2MHz: use SDR3, with a maximum data rate of 2MHz
>> Otherwise, use SDR4
> 
> Sorry, the description of the commit message is wrong.
> I will change it to
> I3C SCL rate > 8MHz: use SDR0, as SDR1 has a maximum data rate of 8MHz
> I3C SCL rate > 6MHz: use SDR1, as SDR2 has a maximum data rate of 8MHz
> I3C SCL rate > 4MHz: use SDR2, as SDR3 has a maximum data rate of 8MHz
> I3C SCL rate > 2MHz: use SDR3, as SDR4 has a maximum data rate of 8MHz
> I3C SCL rate <= 2MHz: use SDR4
> and send the v2 patch
Seems some typo errors, you mentioned all the modes having maximum data 
rate of 8MHz. "has a maximum data rate of 8MHz"

I3C TCRI Specification (in [MIPI06] Section 7.1.1.1) :
MODE 	Listed Speed 	Maximum Sustainable Data Rate
0x0 	I3C SDR0 	12.5 MHz, Standard SDR Speed, fSCL Max
0x1 	I3C SDR1 	8 MHz
0x2 	I3C SDR2 	6 MHz
0x3 	I3C SDR3 	4 MHz
0x4 	I3C SDR4 	2 MHz

