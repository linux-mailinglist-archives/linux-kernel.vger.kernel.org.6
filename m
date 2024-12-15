Return-Path: <linux-kernel+bounces-444846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289599F0D69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C98188BD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0D1E0492;
	Fri, 13 Dec 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WR9W7c00"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95338DE1;
	Fri, 13 Dec 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097060; cv=none; b=Q4KQPoUI1bP9/x8W/wkTnuy+d3KdelLiIZU32GSSv8E1AgiegPb94IdTtupwBU8Yxd9ebIpZbGxFZKgImLRNMDsP1VbWh8/BwM22nD+bYDf2GQNfFIzdLoP19DyekyTTuXKYAW+XnbQjWz2DHQCpNzu//iqm6oB0SCQ9c9aCmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097060; c=relaxed/simple;
	bh=qoFk5BHIQXYDzLpPruQaqO0fOwCLOUhE6gz5VlyFQPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oTanHOY9/nlIURupLtfTTVmriaLZF7Nr11HJbkom/xvi7KuQbqz7hhS/VHM2eL9phw8a89vOE5boh0TvKs9joX4e4d0VF4skke27fRj1rLDojVIGDg61vNJdp9BUWoiSOoVPxylUDM6hLjWvBoLwEhribRLTz787L5LTWCxSsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WR9W7c00; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhkrg017764;
	Fri, 13 Dec 2024 13:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6oSf14VYTD1Dy2OgN5EQWQcU/iRtkhJhW3V9nmUxeNA=; b=WR9W7c00T3eeYcq6
	mlqzuu3xjHe8Pzrh8EjGXhoEFmXXPiefxmVSsUCQ6g2F1Ge7KavuyDpe8M33ZWQZ
	9wZT0YSP+BffhqT/wMenfdfogsYKZ6ikHyCPR8CrwcTfSp64mfvotA55AxH4ytTb
	lcamLdaBpvNjl2yJaiaRkFcNQjIVZtuVW5Pe2xjXPROmcLd42PFZO6wdoe+dhFa6
	OO4MBb9u1n1ObmArd1DomysBl8GMzh4xtCWEfKOMo6NUfcUnBdh28p02LI9Eizd6
	AStpW4FYSWZk7eocJJBQIshixd6sFg+LrvFeTLtkUeu0v29r62sDKvrhSMw1wrpc
	Rq2c+A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac09hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:37:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDDbOnQ017995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:37:24 GMT
Received: from [10.204.101.130] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 05:37:17 -0800
Message-ID: <e2ae139a-0285-455a-a2b1-520deeeacc0b@quicinc.com>
Date: Fri, 13 Dec 2024 19:07:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: display/msm/gmu: Document RGMU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <20241104-add_initial_support_for_qcs615-v5-4-9dde8d7b80b0@quicinc.com>,
        <20241022-qcs615-clock-driver-v4-3-3d716ad0d987@quicinc.com>,
        <20240924143958.25-2-quic_rlaggysh@quicinc.com>,
        <20241108-qcs615-mm-clockcontroller-v3-7-7d3b2d235fdf@quicinc.com>,
        <20241108-qcs615-mm-dt-nodes-v1-1-b2669cac0624@quicinc.com>,
        <20241122074922.28153-1-quic_qqzhou@quicinc.com>
References: <20241213-qcs615-gpu-dt-v2-0-6606c64f03b5@quicinc.com>
 <20241213-qcs615-gpu-dt-v2-2-6606c64f03b5@quicinc.com>
 <28bf46a5-dedb-4491-b9be-23fdfb99035f@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <28bf46a5-dedb-4491-b9be-23fdfb99035f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F2-cLpN7sj4SRHwnUinA5cU8tO6xNmBd
X-Proofpoint-GUID: F2-cLpN7sj4SRHwnUinA5cU8tO6xNmBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130096

On 12/13/2024 4:23 PM, Konrad Dybcio wrote:
> On 13.12.2024 11:35 AM, Akhil P Oommen wrote:
>> RGMU a.k.a Reduced Graphics Management Unit is a small state machine
>> with the sole purpose of providing IFPC support. Compared to GMU, it
>> doesn't manage GPU clock, voltage scaling, bw voting or any other
>> functionalities. All it does is detect an idle GPU and toggle the
>> GDSC switch. So it doesn't require iommu & opp table.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
> 
> The bindings file exists so that people that are not in the know, can
> reference it and learn about the hardware. Please spell out IFPC, as
> that's a non-obvious, hw-specific  acronym.
> 
> Otherwise looks ok

Ah right. Krzysztof schooled me that a while ago.
Will update.

-Akhil.

> 
> Konrad


