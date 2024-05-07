Return-Path: <linux-kernel+bounces-172434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6F8BF22C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48964283E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CBC178CCA;
	Tue,  7 May 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hc+MSFru"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C251708B9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123525; cv=none; b=nHnUtPqEhpqW5cRHb1lKvOKJleg9S1qY0rO6zA6IG4dUOpvwm480Co670kANStC9zs0zHNLJLRBXzgAMpEqYtB34tgrPkNGrWWsHJHKZCrCOkp0ljcKvqT33MvC1HddqA2hJlA+R9p9ffJ6MGGm7skGjySGJLHiO7ceiSzlQ0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123525; c=relaxed/simple;
	bh=QFNhWj9sw5gktxPchvCgkasg4aDKpludZsqro1wl380=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JsvqacVXeDA1SRbV8LX/7sbCWIAkoyqJl90EJ2npf0Ft3zQdu+IQ6r+lLE7mUuBlR9uTdxWIEJaSLpjYS3beUVdkWyY8L/cuBhjyoF/ggRiMNREIsA0mneOSkpTsIh9VVWzyBb9m5U6Qb58dYm9DBFeuCgA/F3c10FII2ihGFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hc+MSFru; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447Msx4q010709;
	Tue, 7 May 2024 23:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FBqAShKqXxbLSTi/XWNVbqzsTD06CXSdErRUFZ9RsK4=; b=hc
	+MSFruqfWcg1znotrs5tziKCvXR3FjMA4nk8QDejELOj+Vjw/5HMeje90ppqHJcp
	vdDccjqn6OmlD0Ct1OCwgwrlLldjSnksW+XMvha+Vf67BM2NYfP7YsUGFMnQYNXf
	gGtW4cYmkZakVcTWJWzBY7CYqo71pgj1cu+OtRPlGJwalpZa6tsVf7pX9CQw37wf
	O4lk4qE7hc8LbFzhHH6Fqjedwh3Y1qco6ZChj2qOMoe+VKewWFSWc6iREYwiTGKy
	LmNrSEZoadu+WAzyPhM5m1U/XER+vDZs93G2mT61rDSkvS+mCYiwM7E8BgYmAG2W
	YSqpPgrMrZcvL0k/Ez6w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysg4rg6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 23:11:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447NBGws015491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 23:11:16 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 16:11:15 -0700
Message-ID: <ae3ebe43-be3b-49dd-a5ad-4dae097e9ff8@quicinc.com>
Date: Tue, 7 May 2024 16:11:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jffs2: nodemgmt: fix kernel-doc comments
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger
	<richard@nod.at>, <linux-mtd@lists.infradead.org>
References: <20231205173222.12575-1-rdunlap@infradead.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231205173222.12575-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yFu2nQXpwZLoMKxzG9dgbeON128BV444
X-Proofpoint-ORIG-GUID: yFu2nQXpwZLoMKxzG9dgbeON128BV444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405070164

On 12/5/23 09:32, Randy Dunlap wrote:
> Update the end of one sentence where a comment was truncated. (dwmw2)
> 
> Fix a bunch of kernel-doc warnings:
> 
> nodemgmt.c:72: warning: Function parameter or member 'sumsize' not described in 'jffs2_do_reserve_space'
> nodemgmt.c:72: warning: expecting prototype for jffs2_reserve_space(). Prototype was for jffs2_do_reserve_space() instead
> nodemgmt.c:76: warning: Function parameter or member 'sumsize' not described in 'jffs2_reserve_space'
> nodemgmt.c:76: warning: No description found for return value of 'jffs2_reserve_space'
> nodemgmt.c:503: warning: Function parameter or member 'ofs' not described in 'jffs2_add_physical_node_ref'
> nodemgmt.c:503: warning: Function parameter or member 'ic' not described in 'jffs2_add_physical_node_ref'
> nodemgmt.c:503: warning: Excess function parameter 'new' description in 'jffs2_add_physical_node_ref'
> nodemgmt.c:503: warning: No description found for return value of 'jffs2_add_physical_node_ref'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org

I was about to submit a patch for these, but then checked lore and saw 
this was posted a while back, but so far not merged. Hopefully my R-B 
will provide some momentum

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


