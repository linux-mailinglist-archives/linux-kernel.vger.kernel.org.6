Return-Path: <linux-kernel+bounces-287239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73AE952532
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072FB1C21612
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2941474D7;
	Wed, 14 Aug 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EWul0EoH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34682139CE3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672971; cv=none; b=BI1UmwVhcZq5h3DowY6kkvzBQtOPSTaE9UU6yEmJ0fHuVU/fNWGky48gUKnGKYoIsVXjmpFeckw10Rv5Aq+fgZvYcubCmEQHaP5KQ+DRue6WCkQ542ycmt9EtCvs5nxJZF3yyQi6sK0gQGUba7lESHFPcnLryq2TEddVd7HZUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672971; c=relaxed/simple;
	bh=JO87AcMMnC1ABgWEp/kM7e5skWPARI9ON3EOKYehUvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RTZ6rc67DCkOiwZ7A4aDQ0NMmK+Qr7H32Ro0qvkZxaUAKvuV2kCGGLtMNkfbs34l7rB/9GmHXWNumUMEGV62KV7nmwn+mM3KqwHhiJ5v8SAd1Co6aBkDXsctt+equzh/S82XxieqML6OEq80uYWuB18YDkoLSBcI31+k6y5/fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EWul0EoH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EAUKoo017638;
	Wed, 14 Aug 2024 22:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DONMH56L3TiqMKep3P2/LGi8Ve1a6IQ2Yny65wVTOt8=; b=EWul0EoHF2a+Ux+K
	WpyU8+Yw4MUbQx9st3egk9qTjzi6k9fINzBtvtAPpd0hUhkm69BNJejjB8L5HlK8
	1ApID7aEE85w1nUwJK03JQw+q06rcVgLgOQceC6Lj3RYpVZq7mOr7WBKQWsYGmLz
	NTLI02pSVNq026SO7GmqTrrojd0xrrTDvIpVZ/sDdIxlaC5ppCLtofQJpBTEkN0B
	zZpVqZghm0ccHZmXFdcgdFYksVigWhWc1UsktsDI8G6TwUo+flKKyLfKsWKWTEUe
	yKICpJS+T0avBfKqkkueadtPQEhvLxfjullDG/3NEESwFpCVfyghAe796fowX3Ju
	yarhuw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410j1jb4p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 22:02:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EM2iMY031928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 22:02:44 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 15:02:43 -0700
Message-ID: <9be9626b-009c-165e-f025-ee177d051d02@quicinc.com>
Date: Wed, 14 Aug 2024 16:02:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 02/10] accel/amdxdna: Support hardware mailbox
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        George Yang <George.Yang@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <20240805173959.3181199-3-lizhi.hou@amd.com>
 <f7575353-760c-0f6d-5569-cd7f691f6af9@quicinc.com>
 <3cf235f9-3fda-5fba-ba2e-6ce4185ddf56@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <3cf235f9-3fda-5fba-ba2e-6ce4185ddf56@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JpVjPTsOgzQc5froJpivi-7yerZafOL3
X-Proofpoint-GUID: JpVjPTsOgzQc5froJpivi-7yerZafOL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_18,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=958 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140153

On 8/14/2024 3:05 PM, Lizhi Hou wrote:
> 
> On 8/9/24 09:32, Jeffrey Hugo wrote:
>> On 8/5/2024 11:39 AM, Lizhi Hou wrote:
>>> +static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann, 
>>> struct mailbox_msg *mb_msg)
>>> +{
>>> +    unsigned long flags;
>>> +    int msg_id;
>>> +
>>> +    spin_lock_irqsave(&mb_chann->chan_idr_lock, flags);
>>> +    msg_id = idr_alloc_cyclic(&mb_chann->chan_idr, mb_msg, 0,
>>> +                  MAX_MSG_ID_ENTRIES, GFP_NOWAIT);
>>> +    spin_unlock_irqrestore(&mb_chann->chan_idr_lock, flags);
>>
>> I think an xa struct would be preferred.
> 
> Can we defer this? This is in critical path.

Ok.  I would be satisfied with a high priority todo item for the conversion.

-Jeff

