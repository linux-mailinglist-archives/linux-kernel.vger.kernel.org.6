Return-Path: <linux-kernel+bounces-260320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A088E93A6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497291F21A65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979F158A31;
	Tue, 23 Jul 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WH6hnazc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39D1581F4;
	Tue, 23 Jul 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759935; cv=none; b=VW8zzDlQeCcXbq2Y8OxsUQzHvIjlDe1mBPnv16IagDb1jbH/Zg7jE+UL9tIiBY2wejvZjm8mchdfslwhWMFkhUfXY5I58VIxoOnmAiK61MLFcbHgLC3/s74mciJEbiwNUZBvdcjx3e0ylFtfCmALNjYNNRPMajWUBPKzPZMFp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759935; c=relaxed/simple;
	bh=rar2XdtshKSQEXeKvWMZ7u5wxuY+RcogxFACQYX9dHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p4EuJLUv5U3kPV9KVMGKbs06lnDfFKrWx5yLbwpTBAwV/vfKnVlqGgnkgIGJmLyGcZGBqzhIcK/E6eKBK5Df/XqST0UhNUZgTTJe0GJwUderI1JWgcno209Fp9F9XmTsxgH9M09mSwsrBX8a3LSZNzj+5hI9WYEPZdNc9h0Stko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WH6hnazc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NI0VLp032597;
	Tue, 23 Jul 2024 18:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k3eldlb7fsJM17KzwjmHwLhkIgAAH9V6Wt/2reC8uZw=; b=WH6hnazc2q57tnwn
	OOCTvo0uC3Gj9QPS5GdTlwGSt41pJVx61XrfyQ3xC/40Ox+XuAecDNks2Rjo/BKj
	2onMUxppNtp/zIKRKxA81ZuzOVqFTh9ea/TFb2n0YxXQhPV9gxpT58LGxf50WIS+
	n+1eDK/sysBAOgYC0SEfC0RLZqPoN5oOLZlWnrgd0ArM5HnD3LR9QbDKeGy48hAp
	kywHrRlz9NY3D3b3wqTf2m4z4Htu8lJfbr4fYKI8Urb9IY9NS9gScydjNIJKfreJ
	AySyS2V8IJ38RU+OYcVrfhaiJZ9ttKuoVIQnMUJYpigF/m2nCcmBBHfJHbDDPJp9
	6eCi4w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g6h8ytpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:38:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIcnI8008544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:38:49 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:38:49 -0700
Message-ID: <cb9ddcaf-1ba2-4e1b-9c56-6658919e7d22@quicinc.com>
Date: Tue, 23 Jul 2024 11:38:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: broadcom: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240608-md-drivers-phy-broadcom-v1-1-f070f84cc3f0@quicinc.com>
 <171821471999.586907.11914023851963096437.b4-ty@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171821471999.586907.11914023851963096437.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YfEGAusxmHkCJCzXeV9AjVLIOmqUf8Pl
X-Proofpoint-GUID: YfEGAusxmHkCJCzXeV9AjVLIOmqUf8Pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230129

On 6/12/2024 10:51 AM, Vinod Koul wrote:
> 
> On Sat, 08 Jun 2024 23:17:05 -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/phy/broadcom/phy-bcm-ns-usb2.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/phy/broadcom/phy-bcm-ns-usb3.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] phy: broadcom: add missing MODULE_DESCRIPTION() macros
>       commit: ea09ba7653bb53252ed96ec524991c55a38bcd0f


Hi Vinod,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

