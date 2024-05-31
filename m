Return-Path: <linux-kernel+bounces-196934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0748D6403
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAF1B2B816
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113AE16D327;
	Fri, 31 May 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b8ZktriU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368D158D8D;
	Fri, 31 May 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163655; cv=none; b=BYZA06Yeci5VJiMcrpnXWGAVL7j8y49harVfOWInsIcRZpfVEF+bqMbLumWx2Cb1ClLbrPAkoE5SmA/YwvINs9nCxP9VjOXglXC+e0N/QwFx6S2fuEvZvCojd4swwZqdJ3fGHfIubSM7vFRxJaY9Z3foVZ7lthH3Z+m+69PD2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163655; c=relaxed/simple;
	bh=LDx6sVphNqG2qDDMXf0EfdREtXoPzkD03mMjA+svKnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XkPo6wEPIFfX2IRhzs+qQYHEUnZ4Uljb82kqnvyAIXrJvzPZo5mbhG0FXXcw7N49ebEvyMaeE3k5R3IFKcXdN7/3LNM1lTMH7lhVTyR2T514J2o+LHMJzBCk+dqeNfRN9aiWaBCbQeHt1DYn5+OIrp8WEXPTJcTEbzhOvdA9mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b8ZktriU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V711r5001099;
	Fri, 31 May 2024 13:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PYcMr99pnsmRTjwDC+d550mFjpzxJZe2o8cYFN49Ej4=; b=b8ZktriUdY2wvENV
	jiT2m3dgmGRp1jz0+d+r6rvzU87bsCBwNBNCuMgxhj2csdh6wvKor1uyURPtAlBl
	GI6Huw5zfcEfSkIalhVz+/rEjcgFlS/xC3ajda/VJJoy1z75fWsY/Kl0Sz3kWmEp
	YmsAdtBbGWleGINgo8Ss390BkTNUC7F9LF2zUVaedvyZJhUTMaDk6IAhgbBia+mq
	xJZu1otBL4XGsmjLi0p9C+qx5IMoMBc/7h+pUAnIWUV8yg+t6KmoF6mImqhoakas
	aR6nCCq/tPXyFHQRPMrQ28a597VtbZ54QB+Sr/nIsj4EfqlqJmXRU4O0PNfK29Tr
	Fizofw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjf43t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 13:54:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VDs6vH013000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 13:54:06 GMT
Received: from [10.110.11.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 06:54:05 -0700
Message-ID: <e9b4a22f-1842-4c37-8248-4f715d70a6c1@quicinc.com>
Date: Fri, 31 May 2024 06:54:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kcsan: test: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>
CC: Dmitry Vyukov <dvyukov@google.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240530-md-kernel-kcsan-v1-1-a6f69570fdf6@quicinc.com>
 <CANpmjNN1qf=uUnetER3CPZ9d5DSU_S5n-4dka3mDKgV-Jq0Jgw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CANpmjNN1qf=uUnetER3CPZ9d5DSU_S5n-4dka3mDKgV-Jq0Jgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PtadWKTq_N_dP2OxVw0_73w4rDO_TUW9
X-Proofpoint-ORIG-GUID: PtadWKTq_N_dP2OxVw0_73w4rDO_TUW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=874 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310103

On 5/31/2024 12:47 AM, Marco Elver wrote:
> On Thu, 30 May 2024 at 21:39, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>> Fix the warning reported by 'make C=1 W=1':
>> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/kcsan/kcsan_test.o
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Jeff, do you have a tree to take this through?
> If not - Paul, could this go through your tree again?

I don't currently have a tree. Kalle is in the process of relocating the
wireless ath tree so that I can push, but that is still work in progress.


