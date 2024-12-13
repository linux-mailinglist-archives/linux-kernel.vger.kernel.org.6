Return-Path: <linux-kernel+bounces-445240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFF9F132B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D451C18840F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803E1E377E;
	Fri, 13 Dec 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bf7ah6+v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC6175AB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109553; cv=none; b=epJoKm9rsEyBoO42PUcnpM8SiweWNBgLE/3DPvaD9hvAN2rDj4WzrP7mbVQ52O0Z0SP88N3r2vkBSPU/YTM107jmLjwAUY/yuffjrmZppGtEB5Ijy0AUGKyHgT6aXMPi/iADCugzxccAAuotUcA91zss9cha8OzK5Dnx+Bd5Dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109553; c=relaxed/simple;
	bh=vFAOm4pNLK/QlcmDNbwxD9S37tx+rhy/y7bn1LZy1JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nBJQGkzAe0CzTCF81/skemW2vyEEJHWRYiiY6SI3qTHK4Cr9ZU7FyT2WPWAwaYh3Ha6tqL3o+JK6kzAic7XWlLaixx8iyhhD35LGy9CrqFv1cD2h/DTnpbFWEjSrvk+NYY0ZiSeNe0VSfC9NX498rDS6sUXkvBdTRFYBSA+oEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bf7ah6+v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDA3hK6012465;
	Fri, 13 Dec 2024 17:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/6qHiN8iaAgyIJA/OG/dTOr30636DFaQB8QCSV02rjM=; b=Bf7ah6+v/YBEcSJo
	Qc2u9LYfec0zFDZduvBNQ3M/Et1KpUbVODXM8QLSlDlDBNiygne5ebBM8Hh1crkn
	Ku2ypuwyXEJsji8mNPqueYZQauAakSH/FPF+24KPA8RLHkekO5VntyYCH/ERAXib
	ZcS6WQr38frdMem24PD3T7wM/oLoeQSggxHh66jF9WqeY54i2P8OL6hUDeGRtKr4
	aFSXyPaRwlhXFm5NWfPf10kXaHYWbJt33Sx/cqUbo/VPVGYte/O5jPXZtHFyBA8R
	R6Ry/wiRWAKeaCXmdB5tCijArDgWD4Ja31moh0h6MSF8M+tLLb29/yWyKGiJCR8F
	xGeaog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjudh4kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:05:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDH5hTM003612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:05:43 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:05:42 -0800
Message-ID: <07c321a2-2304-c318-3630-7bff8839968d@quicinc.com>
Date: Fri, 13 Dec 2024 10:05:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/amdxdna: Add include interrupt.h to
 amdxdna_mailbox.c
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <mike@fireburn.co.uk>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241213163856.1472207-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241213163856.1472207-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xqFwDcwMWJQf7hSIzWKAi8zR3UCuJbQv
X-Proofpoint-ORIG-GUID: xqFwDcwMWJQf7hSIzWKAi8zR3UCuJbQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=931 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130120

On 12/13/2024 9:38 AM, Lizhi Hou wrote:
> From: Mike Lothian <mike@fireburn.co.uk>
> 
> For amdxdna_mailbox.c, linux/interrupt.h is indirectly included by
> trace/events/amdxdna.h. So if TRACING is disabled, driver compiling will
> fail.
> 
> Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> Closes: https://lore.kernel.org/dri-devel/CAHbf0-E+Z2O7rW-x+-EKNQ-nLbf=_ohaNzXxE7WD2cj9kFJERQ@mail.gmail.com/
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Pushed to drm-misc-next

-Jeff

