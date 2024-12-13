Return-Path: <linux-kernel+bounces-445212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39059F12E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A435D280948
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D91F4702;
	Fri, 13 Dec 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JItMc7rN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D841F4724
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108529; cv=none; b=u/GZdSegu90idVnItzrW+OpJa/eFkZQQMwHRIJuzW54ThF4DRbiImtN+R+eh+XEe/zLESQ5jJYU5iSjT52hlDD4GhHnSBq0CNm04WY++ZyzHzukoYtxBMVVz1dd7MczzDw9dGXizEUfuzZQFKAcfUUvgntNA4OmJRDiSI/srhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108529; c=relaxed/simple;
	bh=F+PSoW18XCHJh7jXxn+wOmqFghhq4cdybSry9sA/hSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EcDQWkZy9PWS0yzblEbRvKEFy+AeM5O3dFYRdqTyBA+KtJ1hkX5Oqi1wDr5lmTDZ7xi/kctGYYjBbFY91n7JFg4giqMLml/hJ7T7DZC8yVXW+hB57LOnOCLyQeYhIA+g5cqyB4PQZi3gwtSf7ZiiRIDxcg8kf8YDyV4i+Kit/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JItMc7rN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8PQqW032215;
	Fri, 13 Dec 2024 16:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TV4fvxr20xkDU5x3+d+HSlOf8l9QwuxUqiXP6pVDA1k=; b=JItMc7rNJFcxhj98
	V6OURYIcZKHWGyaQk76un/BsSyLjQVdfuf3tALjH3lw705YAk+xgjFWh80tuNmEQ
	WH95XWCrecjQbjayyFeZ0tg5K37ec/svf1/S3EFUiThlaPsgMnGDFXqc6S7uwlr3
	T4Jwi6hLY2FQ8PWU4VKBiKFyIqMOLXdlQUiwtksmnjQJaU6AgpSGY8c9i6ztsNN4
	2ENwyNzMgUWDElVfndyfkG+Ivd29VFadxz66Ju0RVQtMuOViDYoDzLj4W02MCBs0
	Lhgmx6tZH+auGvPtcMrbRQtJDXnKrpuBR+cFE7Z7EA7GJs2+BGzyPBWpWXHjLoNw
	+h8O/Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfg7bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:48:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGmgAc003928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:48:42 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:48:41 -0800
Message-ID: <043f5590-ecd0-46b5-7aba-3ee680563e26@quicinc.com>
Date: Fri, 13 Dec 2024 09:48:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 5/8] accel/amdxdna: Add query firmware version
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-6-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-6-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n8drTW21rxAp1uLPNJiC7xoeW6ceGFxS
X-Proofpoint-ORIG-GUID: n8drTW21rxAp1uLPNJiC7xoeW6ceGFxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130118

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> Enhance GET_INFO ioctl to support retrieving firmware version.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Warning below through.

>   enum amdxdna_drm_get_param {
>   	DRM_AMDXDNA_QUERY_AIE_STATUS,
>   	DRM_AMDXDNA_QUERY_AIE_METADATA,
> @@ -382,7 +396,7 @@ enum amdxdna_drm_get_param {
>   	DRM_AMDXDNA_QUERY_CLOCK_METADATA,
>   	DRM_AMDXDNA_QUERY_SENSORS,
>   	DRM_AMDXDNA_QUERY_HW_CONTEXTS,
> -	DRM_AMDXDNA_NUM_GET_PARAM,
> +	DRM_AMDXDNA_QUERY_FIRMWARE_VERSION = 8,

This would normally be considered breaking the uAPI, but since this 
driver is not yet in a released kernel, this is allowed. Keep this in 
mind for the future (can add things, but not remove them).

