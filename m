Return-Path: <linux-kernel+bounces-225161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978B912CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BBF284A10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D20178CE8;
	Fri, 21 Jun 2024 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LyZegx3K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD72E417
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993169; cv=none; b=AF9niWnu4wPdSpDEA+Gk32zLHno+yG2nHwxlC4PAWCcXO/aOAZO8kPEoW3MqocSg9PQiTPSyrscSjVVF090cMAJE6p75CKSpUbcoNMYrlUEswsqv3tRZiV2s5FQeMgW9c4phPEByTZbFqWd2qTCUZz7DHOlpI9xcxWH4BaugUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993169; c=relaxed/simple;
	bh=KNh6b54fJDutjFvV40lNhoX86spB5JmET8ZphhgCgt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j7+JhpgtgSRWX81DJFaUjjo6eHvdDdVLBC0ykIzVtPsGgSZTQtg2ewJYi8aOeTOR9UK8v591GAUr1poVHD0bU9WYr1ml+M9xNyju8uVj0xSojp4sbDmhCnN36hR4QzwDG/+rUCEW3LF1ZrfI+jeggA3iGDtcOFJoNyQ/54heeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LyZegx3K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEUsme018246;
	Fri, 21 Jun 2024 18:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FVzABO56FBwecMnPFjmmt8/6HkRAmgxR4mr5lrxImD0=; b=LyZegx3K9jaKvpUn
	xzvug8LJYjLw0XY/z1WhjkmCiA05fafFUpV4K8DE7QjZ338sz3o6dbb5kseWVgOX
	LQvVxxLx2fVjyo2X4P5u0drWu8VbBGzLXVoG1kjf9j0nixUjLuEdt/2Nm/YKLWoN
	7EtrVNtKGI2URbu/CZCjbQrg3O9Tn+fOnTOQRW+oLKW8yer2QvOJDTvzcZOYSqGY
	GBCTOMCKEy/nvNCx6ih3DZ+l6sNL+XxFnngnM0/kEK8DgUnWQlE/wDjtp5xXM25E
	ksW5l0PVZVJrmYODcIL3W5p2rOzRePT+0kK9ZWIoVuZxXV+l/nB6EEgsvjnVK3Q2
	ZUIT5Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrp1bafn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 18:05:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LI5oCf018394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 18:05:50 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 11:05:50 -0700
Message-ID: <f1523b95-383c-4bfa-adb0-221a124a42c3@quicinc.com>
Date: Fri, 21 Jun 2024 11:05:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel-xinpeng-xpp055c272: add check for
 mipi_dsi_dcs_enter_sleep_mode
To: Chen Ni <nichen@iscas.ac.cn>, <neil.armstrong@linaro.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240620074802.852544-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240620074802.852544-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -ps-y7kSEwBW1ik60rlFjPEjhvBptZnS
X-Proofpoint-ORIG-GUID: -ps-y7kSEwBW1ik60rlFjPEjhvBptZnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210131



On 6/20/2024 12:48 AM, Chen Ni wrote:
> Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
> index 22a14006765e..d7c9df673f35 100644
> --- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
> +++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
> @@ -139,7 +139,7 @@ static int xpp055c272_unprepare(struct drm_panel *panel)
>   	if (ret < 0)
>   		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
>   
> -	mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>   	if (ret < 0) {
>   		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
>   		return ret;
> -- 
> 2.25.1
> 

