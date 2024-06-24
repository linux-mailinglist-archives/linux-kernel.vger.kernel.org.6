Return-Path: <linux-kernel+bounces-227983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8983915945
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2081C229F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5879132127;
	Mon, 24 Jun 2024 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jLGItfBf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199C4962C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265935; cv=none; b=S2G18TwTGWzD3mqBxn1rzqoqOsatKHmQ6cs8Jqkzio61HUgsMzeNVnGLBqvexVGZPKWS31meVBLfdLBT89ua7gG9B/GzgDpFcX99FxShijcz6RFoy2BKou7bl5G73RTRwklEaA13MiuYE9+ELj4huMLQNZ2SSf0hmV+BK5gXrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265935; c=relaxed/simple;
	bh=KZHFI+z2yPqZ0/Redp6Sa59uxGn2uSSgGfTaz/HYYeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bCLHiKQGDjCiyAvT1D7mZvauwLLHCEtNOmdsq9bx0B3O1oVy+yGMkqevjEEyrILLmP+NkhsnzvcRhGGXzIKE+jAbYNtb4rCYE3aHscxwt0IDIswHCNHcnur581kC8U3fkggBRDCjQ/1zp7J9GxiXNH6zMShfU4MH99flHKKo++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jLGItfBf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIXKpn031403;
	Mon, 24 Jun 2024 21:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJfuL0Q4wqJdQj8Zn294P4TDfl6ooRaiEcmCqH+v9CA=; b=jLGItfBfKhwOhBGq
	o7/0JqTxeYzjC73I/9TLW6lH5Gr1KPnSqKcXpiBwuzd6v1Tz+csl11LIhTvZiQR9
	VStCom6rzK+MYgiavbI7MSn0XMIuzZCNrMesOybPl67AhZp4NQ49yNjN8gI61mn6
	iOdzWMnHcPX5abPkhd53Ge7y8jXsFpjFRdEk2CUc/5iQWihV1DMP8+Kh0VhTYMTi
	ZEfr8KOBEe1YtHVa9D97i90jrRrpI4UXaOFCXzWyrAGLJiy5LQqqEgld7VLwoeih
	5DJZLsUpJwS+66UwkRysYmJ4V1+WAMzE/PaIC0g28ElUb6egeKlMW4OY1o1hKe8S
	cb/G1w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv4qb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 21:51:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OLpoN1004780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 21:51:50 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 14:51:49 -0700
Message-ID: <348cad10-2642-45d3-a3ce-c29933986b70@quicinc.com>
Date: Mon, 24 Jun 2024 14:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/panel: simple: Add missing display timing
 flags for KOE TX26D202VM0BWA
To: Liu Ying <victor.liu@nxp.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: <neil.armstrong@linaro.org>, <sam@ravnborg.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <emil.l.velikov@gmail.com>
References: <20240624015612.341983-1-victor.liu@nxp.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240624015612.341983-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8jZgkOY9YSRzEAGQVT-xg04291EA5t7K
X-Proofpoint-ORIG-GUID: 8jZgkOY9YSRzEAGQVT-xg04291EA5t7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_18,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240174



On 6/23/2024 6:56 PM, Liu Ying wrote:
> KOE TX26D202VM0BWA panel spec indicates the DE signal is active high in
> timing chart, so add DISPLAY_FLAGS_DE_HIGH flag in display timing flags.
> This aligns display_timing with panel_desc.
> 
> Fixes: 8a07052440c2 ("drm/panel: simple: Add support for KOE TX26D202VM0BWA panel")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-simple.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 20e3df1c59d4..7b70606e5760 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2704,6 +2704,7 @@ static const struct display_timing koe_tx26d202vm0bwa_timing = {
>   	.vfront_porch = { 3, 5, 10 },
>   	.vback_porch = { 2, 5, 10 },
>   	.vsync_len = { 5, 5, 5 },
> +	.flags = DISPLAY_FLAGS_DE_HIGH,
>   };
>   
>   static const struct panel_desc koe_tx26d202vm0bwa = {
> -- 
> 2.34.1
> 

