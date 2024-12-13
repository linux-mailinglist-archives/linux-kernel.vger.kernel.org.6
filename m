Return-Path: <linux-kernel+bounces-445177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0D39F1257
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB98118864ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9617A597;
	Fri, 13 Dec 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bMpqAfOG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789415573A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107838; cv=none; b=XjXep5wNOtKKPguKAyNs9mYKmIvU4mFsM7BBUY1lzunkW/WKYthREeLlCfbk+9Ggb0R51rn4BVNfpMIakKMcPVkSSKBI600rdi/UafGxZAH/UwHJoYdFDQTNYVoYn4i1rPRWyMJCWHgN9u6HSvoLT/6r8DNVrKks1xDOvxBw/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107838; c=relaxed/simple;
	bh=SP7WdZutZ57R8jF/hJq5gvyvQ3jzoQJ1+wjXyeF7kp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bFX5PnWDYMyMFohxBmHmMCdja4j323QPtedMwW1s7E4VrmQTGzsI+MiJSRr8nqUerZksl8y0S71S51U+0yihkhj71w9tnFEohMm5umyNLpVokNu5qoEM56KamjEPYbK/fd21ZUPHBR8TTf8wSlzUM2k1hfqUcmjAhFAvcYIojCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bMpqAfOG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81scf022370;
	Fri, 13 Dec 2024 16:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EdpZwmiV246JBoUqwzLd4lbwWGEYgXCDIAXZxMge7DE=; b=bMpqAfOGWPBmgbE9
	iyf8qFC5ZFdpfYNdY87uN0qYPG0hvdC7iVO4r/UkX9GgkqreKGtkTUIaUF3RS3i9
	COGx4BzkiNZNN5kORNC3ugp00Zh0eMODZ7aDmbXoop1LF5W72/RhwzgyLwNrnL/N
	FF6o/C/OvyWCtuRDsyjbA0FSSTvpyMM7b2BOeDXLl9bDei3IOWlu14Szp3iRhaPE
	rexnBRzxeN3GM2yGPjlAlczu1QEdh8Ason5bEKcmcjozBkbA+/XUonKYAIx8Yyh6
	CTTGsg7iHJc5o07cgBFOYm4K/ybNC0ym8e7rDH11VXF20gscUIyzuuPAlIPkyE+W
	dWU4Mw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh271e87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:37:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGbBsK005589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:37:11 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:37:10 -0800
Message-ID: <96368cf8-792b-598c-0c82-e6d2f46cfb74@quicinc.com>
Date: Fri, 13 Dec 2024 09:37:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 3/8] accel/amdxdna: Add RyzenAI-npu6 support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>, Xiaoming Ren <xiaoming.ren@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-4-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-4-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pkU0pjHH5yyIHcWVA9wJi3r_NfJz-CZu
X-Proofpoint-GUID: pkU0pjHH5yyIHcWVA9wJi3r_NfJz-CZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=712 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> Add NPU6 registers and other private configurations.
> 
> Co-developed-by: Xiaoming Ren <xiaoming.ren@amd.com>
> Signed-off-by: Xiaoming Ren <xiaoming.ren@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/Makefile    |   3 +-
>   drivers/accel/amdxdna/npu6_regs.c | 121 ++++++++++++++++++++++++++++++

This looks like dead code to me. I would expect somewhere else in the 
driver, dev_npu6_info would be used, but that is not the case.  What am 
I missing?

-Jeff

