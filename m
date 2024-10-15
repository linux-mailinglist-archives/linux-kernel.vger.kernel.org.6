Return-Path: <linux-kernel+bounces-366291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801999F344
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A81F20E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04501F76AD;
	Tue, 15 Oct 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O+QTdlfW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581481F669B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011019; cv=none; b=h3iktR3b6mUTLG+cm4orjzpPrC6eUZiuwoIvSuYQunIMoiEx0mER23UOdSeseTF0ZetYu2aKQUue24vOvafeqJKvqQshDuU9d2q+Xk2r4YkksCwvLHEegx6Bw8MBNz5t1e0YXUEY7eOtJNHrT2URsX+T8NpIcRfDOJ8iLdsz0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011019; c=relaxed/simple;
	bh=IKD0YPhleOTs1MhC+Wzhj3ihF+ze4dhi8QVZcF4QzX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IZGmUGltnfc9rmevekwrKUNdTyjEmacnNQOERJP1l4puSBfGvTqgRNOVA0NAHjJ0VqJ+q5tmlKccZsQWTlgjvk2O0SmplGKsB51ETtDnOFgZgrM00to6s1lobDarS6vjxzziWI1cOOTT1JsBCUU11QT+PlxVFOw6ccfkrpWQTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O+QTdlfW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FFk7jp012970;
	Tue, 15 Oct 2024 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ujyBCPa3GayROeLLvHeKHHHN+7AEfBzvB6jZL4sLn6A=; b=O+QTdlfWdfDwt+Bs
	u07V/Y0D5mhGHCnvSv/fTlMxisPrEUgs8BCPvSQTIpK8s20k4hDGDXzsDmkV/rId
	fGvDuZo2pfboCXvvQyUOFjtWCvSkwC+8A65dYJLaydgyBCz92PnFji9j1qbDuvHP
	x2yODPniTcoOzD+7HLcxUw6qGiH2iWIRC2EI2Jj82z1IDr67tfUnP8hlbz4nLuko
	fTUeVig62b0VAvBPu/x3AFYX8qIXBJ4e6W2351sD2f7cdSR8YFaKh6zqhgEUpIBS
	qAXLr+W2QGosJ78SBcfgiqPHQTMaph1H7KqGkpWC9N4yA70xwxrgKtW5wZMKQ7K5
	qtPb+Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429uap86rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:49:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FGnuWC027907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:49:56 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 09:49:56 -0700
Message-ID: <d97f803f-7eb2-481f-b40f-5784c74aa29e@quicinc.com>
Date: Tue, 15 Oct 2024 09:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] drm/panel: s6e3ha8: select
 CONFIG_DRM_DISPLAY_DSC_HELPER
To: Arnd Bergmann <arnd@kernel.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dzmitry Sankouski <dsankouski@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Michael Trimarchi
	<michael@amarulasolutions.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241015153442.3757061-1-arnd@kernel.org>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20241015153442.3757061-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2_AUkrDNuKEuiI6ixM-PQfwl6z-XlcMe
X-Proofpoint-GUID: 2_AUkrDNuKEuiI6ixM-PQfwl6z-XlcMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150115



On 10/15/2024 8:34 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new driver needs the dsc helper code to be available:
> 
> x86_64-linux-ld: vmlinux.o: in function `s6e3ha8_amb577px01_wqhd_prepare':
> panel-samsung-s6e3ha8.c:(.text+0x16b1e65): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Select it from Kconfig as we do for other similar drivers.
> 
> Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
> v2: add dependency to the correct driver
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index ddfaa99ea9dd..128c12e8b84f 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -703,6 +703,7 @@ config DRM_PANEL_SAMSUNG_S6E3HA8
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
>   	select VIDEOMODE_HELPERS
>   
>   config DRM_PANEL_SAMSUNG_S6E63J0X03
> -- 
> 2.39.5
> 


