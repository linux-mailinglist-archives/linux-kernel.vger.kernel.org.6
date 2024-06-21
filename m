Return-Path: <linux-kernel+bounces-225166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3749912D06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302B91C2254D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AA31791EF;
	Fri, 21 Jun 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e/G+OO6G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF01607A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993356; cv=none; b=LoC/XfMaVXR1YeARpc07+GSK1LIuWc3R0fy4tM5CQqtzLRpbhSnVpfWChPVJMM3CCbw+xOiSZn4Ubs7f94MBa2Cu7o9Oef43EhJtJSJN3WNi+kTc74hiTETtBq+iZyk0yVViiWZDJHnZfGKkdd1I0aESWYlUZtBYVLu7IyiJMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993356; c=relaxed/simple;
	bh=jcXDR5lFp41Y2zp5t2rbwbT0GI3K5k4fUMk2/+chVmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kKRoRVhtHn/6qEC/m6jPUhiPtSVQWICJrYIWgPmiJcvFx3PjK4ZtSvc88xNzOYRi8JiYacIWcz/K91aOjAbgZ1wzLMTlNViGNWyhmgcVay7a1hFPBCwjtotG5eGQouh9SiRuTaEq8+9YbFFxyvlHjhgy9A5G2cQheltDrfRoMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e/G+OO6G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LG0rrE002709;
	Fri, 21 Jun 2024 18:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tOFycU/DJn9zFNFLVu/SMiDl/EE/mroYBZepPxxPbJw=; b=e/G+OO6GJcu1EBWq
	AsaF+hHMc+8ffczNHLXQrJOzbiE8VbfO0MU9QDUkyBuYO85jZwQjFEOR/Q9PneLj
	oDaBKoEHp3VNJuoXESqULiLScykqClvxQdE3iJK3+t0CrP/aA29qdPt9DnOkrVJt
	Kbg86XLitK6RspyrbbzKq06Lc5i5CAnk0ceKeRhjrlLViXN012+S0B798eyWW2bu
	kPwszsPF10MH6w2Cm3LLut4cxBT6cJhQD2riCoNsXW+of4VexnVnNqnsPJn9mJxi
	t7RiWQyfW1D4dyr5/FMlV14yvCdqBWPGdFE42JaxOneMvuK4ayLoFBFnDzQoYsuw
	DuIKPg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yw49esq6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 18:08:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LI8veP020705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 18:08:57 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 11:08:57 -0700
Message-ID: <3973cb77-950a-4491-a0a7-3ac8c51ef5a9@quicinc.com>
Date: Fri, 21 Jun 2024 11:08:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panel: ltk050h3146w: add check for
 mipi_dsi_dcs_enter_sleep_mode
To: Chen Ni <nichen@iscas.ac.cn>, <neil.armstrong@linaro.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240620074720.852495-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240620074720.852495-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 137t4nB-5EZ8L-B2UCWeo9MLkAkUQ0fP
X-Proofpoint-GUID: 137t4nB-5EZ8L-B2UCWeo9MLkAkUQ0fP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210131



On 6/20/2024 12:47 AM, Chen Ni wrote:
> Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> index 292aa26a456d..24bf05d0589f 100644
> --- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> @@ -526,7 +526,7 @@ static int ltk050h3146w_unprepare(struct drm_panel *panel)
>   		return ret;
>   	}
>   
> -	mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>   	if (ret < 0) {
>   		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
>   		return ret;
> -- 
> 2.25.1
> 

