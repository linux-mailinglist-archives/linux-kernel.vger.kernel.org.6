Return-Path: <linux-kernel+bounces-448177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DA9F3C96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125701891C91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895F1D5150;
	Mon, 16 Dec 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pCHImPtt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDD1D416E;
	Mon, 16 Dec 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383741; cv=none; b=mbqaeTjRb6wtj8CscHcIi6gyxFXy740EhYSJi9HG2wdgTdzphp6fS9pDqnF9PZXw0eOzzES95qN3turVQgf+OflR1qQf5h2ghFDo8qum4Mr1nrjGRLclZXACFfyLFmjYMATOz0z8qkUBRX9B5IoMOMhbxsN3eqH4NFcUK3sG38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383741; c=relaxed/simple;
	bh=IpKmOll/QNsF9XiygnPe5Auztbc4T8d7kw/HzwrO1+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=biszH00AkZb2gyahnfo86Myqtw8ZJXSaNfC6VybMgGJFDIyzHy5e7HwVPzXLFW4yVfG/xQfnpMZqKT/2pORkdE1ijmUfHLSONoEhbSGyXqNTVQWRW7D49LDmc81dc2yf/F/c16AwIFnq3fBhQUpjgHeOhFqDlCvSliS6YBty/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pCHImPtt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGKM0rM029608;
	Mon, 16 Dec 2024 21:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	clprTOdweKSyB5KCU1J42DS6+FLGOTa9h866joKNO00=; b=pCHImPttEZ9X/PUu
	x2UeN11R+1H7dzW1wZj6IpErWMz7tOYwX3ixuJ3bMKPBfL7BNZdQrYBa7+hTKpCx
	CE69HdSZF2JbEcA1ENBoYX46XEbmzk1cCIYruNYNqiTkPDuB0krLrswLhGH72jgE
	+HwVBQhOrohYtH22zyZlTO0xIlMZG5V8PwYUPRKhbwbV2QAbWRncY8Vg1LcPuHiN
	Ap1Y3F5QNSvWVb1MnJUWpK1ioifgI2bp049ycX8IL6qCmHLOpW/HVLTGC3X1HU+1
	P62O62+fMFPSC0OuuhwwgSw6WsEZDZu6jiUiZpUJqItP37WBCw+7WKDNO7PFEjsI
	dA2z8g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ju61r3mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 21:15:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BGLFUkl027467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 21:15:30 GMT
Received: from [10.110.88.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 13:15:28 -0800
Message-ID: <552d11df-4af6-4ee3-8f94-10f8305baeb2@quicinc.com>
Date: Mon, 16 Dec 2024 13:15:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/msm/dpu: link DSPP_2/_3 blocks on SC8180X
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Richard Acayan
	<mailingradian@gmail.com>
CC: Rob Clark <robdclark@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
 <20241216-dpu-fix-catalog-v1-2-15bf0807dba1@linaro.org>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20241216-dpu-fix-catalog-v1-2-15bf0807dba1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EPU57_0bqlsOAu1eQvcIhIXHIKjMbY0x
X-Proofpoint-ORIG-GUID: EPU57_0bqlsOAu1eQvcIhIXHIKjMbY0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 adultscore=0 mlxlogscore=848 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160174



On 12/16/2024 12:27 AM, Dmitry Baryshkov wrote:
> Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.
> 
> Fixes: f5abecfe339e ("drm/msm/dpu: enable DSPP and DSC on sc8180x")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

