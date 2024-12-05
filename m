Return-Path: <linux-kernel+bounces-433745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB179E5C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30FA16717D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E1222572;
	Thu,  5 Dec 2024 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U2SdVL01"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27254F4E2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418236; cv=none; b=DcXWohsJhStfLNShgAQI/P1Uosm1fXzj2wLhexfBaoC9oinpgi3rCddNzczG6DycWUib33dY9Vq7daPNaXYu4fPsSY/7P5nz3X0mKBMpvvZ+L+HBm2hbUJJVlNkx7ORmTAyb2ChWU1V8LdfzA7uK8BiW51nWdmGEt7/fJ8DKVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418236; c=relaxed/simple;
	bh=6nF22LXP1sHnZx9uArVqkRkllaAodr959unyvprewI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IKW9CFPf+bO2lCVfVr7PYEMMAE+26tKzAJC+SNB8ZasaUmKYf+4n9xv/04WM8KBgNCymy0MrAZMFF6mOxtCzRK5LEz7L2RLZz8wmN2xeQ+tC+PlvywNfL6NSs4VuUBrnEERL86Pz56qWalUTHnRTyddMco/kLxN5kwRgBWSAMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U2SdVL01; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B58CJHX009954;
	Thu, 5 Dec 2024 17:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TlRG9lr20kr3vkN+TNEGJfsRA7sDv1RaJXESGtew0Zk=; b=U2SdVL01r1tsKhc/
	JTMTfs015aX+wNjEJ6AZ4NT148NZpxSokFD5WpZHfow8yUxk9S5PbWh6RGzMsH3v
	UxdILtY9vJCzexued5sP+eZd6O4LlYLKtrdeDSCw51S0KsIORg2mMSLLvwlWTZae
	tc+qBK2Uq5DLYeUXvGx0w7VlwCkOt1Ap8eWXXqngOhZoBT/AccPZ8nkroml/XGVz
	Ng/qAAGDXAAWhuaxMyvbdPoCQZQpGiY8FcYByjnkNXXBIyuJG1ZfqrgV385YCnYC
	HFtrD9hb8EALcPQmxKLgLiNNVm0VUeceHvnFhiVgEFaWDJjxfbNj7j0jVfhqgSd9
	5upGRQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v800f16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 17:03:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5H3eIp001530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 17:03:40 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 09:03:40 -0800
Message-ID: <5b2828b2-7bdc-4714-ab09-eb0b3fe8f15a@quicinc.com>
Date: Thu, 5 Dec 2024 09:03:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] drm/panel: synaptics-r63353: Fix regulator
 unbalance
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>,
        Michael Trimarchi
	<michael@amarulasolutions.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>
References: <20241205163002.1804784-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20241205163002.1804784-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c-_4Djb1FHHmn6TJXmviHUTIGT8-3MtD
X-Proofpoint-GUID: c-_4Djb1FHHmn6TJXmviHUTIGT8-3MtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050124



On 12/5/2024 8:29 AM, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> The shutdown function can be called when the display is already
> unprepared. For example during reboot this trigger a kernel
> backlog. Calling the drm_panel_unprepare, allow us to avoid
> to trigger the kernel warning.
> 
> Fixes: 2e87bad7cd33 ("drm/panel: Add Synaptics R63353 panel driver")
> Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> 
> ---
> 
> Changes in v2:
> - Add 'Fixes' tag.
> - Add 'Reviewed-by' tag of Neil Armstrong.
> 
>   drivers/gpu/drm/panel/panel-synaptics-r63353.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> index 169c629746c7..17349825543f 100644
> --- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> +++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> @@ -325,7 +325,7 @@ static void r63353_panel_shutdown(struct mipi_dsi_device *dsi)
>   {
>   	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
>   
> -	r63353_panel_unprepare(&rpanel->base);
> +	drm_panel_unprepare(&rpanel->base);
>   }
>   
>   static const struct r63353_desc sharp_ls068b3sx02_data = {
> -- 
> 2.43.0
> 


