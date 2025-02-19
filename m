Return-Path: <linux-kernel+bounces-521281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F0A3BB12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098AC3A5F20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4B1CEAC2;
	Wed, 19 Feb 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ahMRc9Px"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040991C4609;
	Wed, 19 Feb 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958997; cv=none; b=ZnJIf+v2aEXupPr7TeVaFxnoxifUvYFakjzP0RJwHwasVIJ9J59sKWBI57Hds7ZACVmyxxI7gEnfQ82AO3g67QifWbss5bP3La7uTEUiWtVe78Mmrcztvuv4xT1xcWPkW/Kj8WZynzoB0tZYrTqXsI7pVniWA7GBUIrQeZ1pCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958997; c=relaxed/simple;
	bh=jDgKVGai1z3sWPM9IuWzma+OqGU7EB/fxf5/K+gyJkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W64a7a51iGWm9AspP343x82NR+DUBwVKWIwOpYpbyOPpHyRcKV1pVQ0innAdflAdIJtoFgDwQ9GmtzU5TvJK9pWERgriRXH+E7F1Yjg0o27SbN59Et+O0W/L+axsX4w7KpDKHCNUPkkiscc/w/ykNNKLXp5dZw/gahBwlmCfRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ahMRc9Px; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8NNLP011711;
	Wed, 19 Feb 2025 09:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTRegoBGFPIFTm1vQCmpjF+s+zePWQ5s7bofqlf4CEA=; b=ahMRc9PxgWqdGUdJ
	yZ/hAHHjeal7Wf5/0mRa2D2OUXG57LYAa8eHGHw0BD/UAICRj32B3/cYiHp+D0FD
	pLSlvlM7iEHfwHmR32oT/3MqlUA7qqUCLjq5onB87emsN/AZ4wvlmdw8ahHp2fcw
	tO01x/J/peoB+6vWWRraxNvq+eBmlIkFdIZcByAZ60kIMidNd+7YjYD/Xe8DR4is
	Eej8vqamVH00iBGDYk+DByba6GHBkSHTsr1uWinLiDyEReTLNOo4VRP5I+xr5FHm
	DhXK7M4aS1ItQBuiqDGhbTqaOt2omXExxJ46kIXubSyYxT37bGMSH6tH8iJGZ3pA
	mlSrAQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1j1ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:56:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51J9uMhj024875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:56:22 GMT
Received: from [10.64.68.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Feb
 2025 01:56:16 -0800
Message-ID: <0171746e-1d3c-42e5-9cde-7dcf2708ffc3@quicinc.com>
Date: Wed, 19 Feb 2025 17:56:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: display/msm: Redocument the
 dp-controller for QCS8300
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com>
 <wyd7i47pkafa7n2yjohuvlh4btasxle4rw5xm55h4bhv24yvah@pfo224xz4xfl>
 <b4008932-ce56-4cc0-9b53-2253051514da@kernel.org>
 <CAA8EJpoowyKcwDQgbWy4xGHzngNQOcWt_z_Xc49GFB1qYjYO6A@mail.gmail.com>
Content-Language: en-US
From: Yongxing Mou <quic_yongmou@quicinc.com>
In-Reply-To: <CAA8EJpoowyKcwDQgbWy4xGHzngNQOcWt_z_Xc49GFB1qYjYO6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KfHerWKYaQvqFn9ajLKEt9yanHq-fSCx
X-Proofpoint-ORIG-GUID: KfHerWKYaQvqFn9ajLKEt9yanHq-fSCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=821 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190079



On 2025/2/12 20:26, Dmitry Baryshkov wrote:
> On Wed, 12 Feb 2025 at 12:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 12/02/2025 11:41, Dmitry Baryshkov wrote:
>>> On Wed, Feb 12, 2025 at 03:12:24PM +0800, Yongxing Mou wrote:
>>>> We need to enable mst for qcs8300, dp0 controller will support 2 streams
>>>> output. So not reuse sm8650 dp controller driver and will add a new driver
>>>> patch for qcs8300 mst feature. Modify the corresponding dt-bingding file
>>>> to compatible with the qcs8300-dp.
>>>
>>> NAK for a different reason: QCS8300 is still compatible with SM8650.
>>> Enable features instead of randomly reshuffle compats. In this case,
>>> enable MST for both architectures.
>>>
>> So the original patch was probably correct...
> 
> I have no idea. I'd let Yongxing Mou to comment on this. It would be
> nice  instead of getting a lengthy explanation of obvious items to get
> an answer to an actual question: is QCS8300 compatible with SM8650 or
> not. In other words whether they can support the same number of MST
> streams on each controller or not.
> 
Hi, in hardware, the SM8650's DP controller supports 2 INTFs, while the 
QCS8300's DP0 controller supports 4 INTFs.In sst mode, only one INTF 
will be used, they are same, but for MST, sm8650 supports 2 streams 
while qcs8300 support 4 streams. Thanks.


