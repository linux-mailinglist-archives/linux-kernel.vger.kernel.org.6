Return-Path: <linux-kernel+bounces-174821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BEC8C1571
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C81F2224E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8E7F7EF;
	Thu,  9 May 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RlU7l2ER"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E567F465;
	Thu,  9 May 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282842; cv=none; b=NS2SBUCNW7SK2Ath8DeW/GAW9nkpLPJnipJcfMTk/+yBtLKnXB4+95+YOaTVDAwZDz/12ZRJy030NrORbZNpHqTIqyZzqVUTMyCH3g40WtNdi+5cYkQsTrpJ2g7DYHcPImvdheIWSdcBtEBG8VCFQ6ThU7xeW/rHTFDoMmsUh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282842; c=relaxed/simple;
	bh=DgidH46JzdElmzKRkD0XRpPfXUWe49LpzRRfv5weKf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GI5d/xLXtE7Wf0dZjls78QwlF/OxKkz8hLI2R1WKLX+s9pvl4G05zhQ79BdkIMxPGC9xtrvBf/yuKD+2zns23ktzCKuptJfB+X8h+gAwriQXBDonc2cZWnkTpxZ1LYhGus8bmwfwoQ/pLHfRufjZX0i/FYHu9JJ/bmPRWWU2Dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RlU7l2ER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449DcT1g011436;
	Thu, 9 May 2024 19:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GDuI+FONF4k4STlgME8DvLuc5b4wpOL/cwLiyZ0C66w=; b=Rl
	U7l2ERTvW9F3bxil03h3vKmZeWi0cQz3Z/qjF8TeYgPy51IcAhIFTO4o/I3f8b/O
	F5yH3MThV9EOomI6C7ImfdB2VeoT279nx4MD2xKJs+AsjbcQojtEHlJPeqKzMYY5
	ckDAHStrSEVeo2Ct9xtvRgp8DXUZYWDSq/x9QxNqUTdu+fmCHaG9UynD42AfxHD6
	OrvU2YbV43bMV7eoli+AJY4499IubARpGWIwYWwK7pfQ4E/Drelplm5YFpl34fnX
	rhD1wHUZUQ6FSDP4GjPp3Fz9EQywuDun8entbpfTPc4Z8c/URYb6QVvfAP7/szPu
	A5dOKN2+JD5mJTQoJmJQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09ejufs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 19:27:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449JRCwQ022111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 19:27:12 GMT
Received: from [10.110.104.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 12:27:11 -0700
Message-ID: <389f63a0-c00f-719b-085f-d562c2b5da08@quicinc.com>
Date: Thu, 9 May 2024 12:27:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dpu: fix encoder irq wait skip
Content-Language: en-US
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
        Rob Clark
	<robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean
 Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240509-irq_wait-v1-1-41d653e3784e@gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240509-irq_wait-v1-1-41d653e3784e@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TIX1gsMOKwQammEIUK1RvTdPG5U7ZaA6
X-Proofpoint-ORIG-GUID: TIX1gsMOKwQammEIUK1RvTdPG5U7ZaA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_11,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090136



On 5/9/2024 10:39 AM, Barnabás Czémán wrote:
> The irq_idx is unsigned so it cannot be lower than zero, better
> to change the condition to check if it is equal with zero.
> It could not cause any issue because a valid irq index starts from one.
> 
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

I think we also need

Fixes: 5a9d50150c2c ("drm/msm/dpu: shift IRQ indices by 1")

With that,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 119f3ea50a7c..cf7d769ab3b9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -428,7 +428,7 @@ int dpu_encoder_helper_wait_for_irq(struct dpu_encoder_phys *phys_enc,
>   		return -EWOULDBLOCK;
>   	}
>   
> -	if (irq_idx < 0) {
> +	if (irq_idx == 0) {
>   		DRM_DEBUG_KMS("skip irq wait id=%u, callback=%ps\n",
>   			      DRMID(phys_enc->parent), func);
>   		return 0;
> 
> ---
> base-commit: 704ba27ac55579704ba1289392448b0c66b56258
> change-id: 20240509-irq_wait-49444cea77e2
> 
> Best regards,

