Return-Path: <linux-kernel+bounces-430075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2689E2C53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836052843B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A320011D;
	Tue,  3 Dec 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C4Euj+4g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80A1F75B1;
	Tue,  3 Dec 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255351; cv=none; b=fvOMc9H06ErZvgSUTORroDMoEHdZwzRVpJylOQxEufN0jSfx6KwDixA2/nYfphT4WNRLS6lxYWwhPdaKuWCeV/eGcnUI0v38FzquQZzc8r14DjaYZfo03WBhkAKS6XT5Y99i5VL4prf9qNGxmCuaSaQAiB7NzlCnaoBWal6mVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255351; c=relaxed/simple;
	bh=VgWxs+KYOsRolGhbELpWxm2D9c7p+dwEb7nCWGA8SQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cCrj7ngbAYsTK6lbOJhkciPWI20BPMasrzgbUA/Imuj/1MGfxG446sxGgk9jb1QXsue3sE/bDuwJK7EK9Ke5MGMk71LJG9ZMujPrCUy2U4x3bPKv0M3jq8pG/7fzcdBtfCJ2Rzp95XdYD3yFIvwoTuf9FXk8AFOP0OSN9XX7kR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C4Euj+4g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3H54BS031010;
	Tue, 3 Dec 2024 19:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+qlWJCdACN3uDoeCirvsVrdCJamGztoN021PP8aBD0E=; b=C4Euj+4gxRRTChOh
	4eNztPO4Rj810gofmK4L3OG+aH4k++VmUTPQD1CCVjYPMFm7X/ptDET7KSJun55p
	saOx0999Jfbuiq0bcFfFlOKd6HN2H6U0gWyathK9CesnNskCNyTCi0Coizr0oLrl
	VP8aT0eRXq6xZsyjLO3qEjzUAmHFUJ6ztNdrABcc2Ea1PVVPYZjS7jhMbjy/wqWo
	IuRa7+QV9QaU0HcPLrddaC335D/5UfV6pPzd6fp4x13TtskfqUaMAQyGFVS3sboW
	DFygiFSx48d7k0HV6NmMFrI/69ONTUL2DDV5C3NF4CBtgrzOUoGsqPOFe71JByzK
	T6uzVA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w90syq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 19:49:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3Jn0H7012699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 19:49:00 GMT
Received: from [10.134.71.247] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 11:49:00 -0800
Message-ID: <6d9aea46-b18b-4bc2-86f6-0805258cc3c4@quicinc.com>
Date: Tue, 3 Dec 2024 11:48:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/msm/dp: account for widebus in
 msm_dp_catalog_panel_tpg_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Marijn
 Suijten" <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        "Kuogee
 Hsieh" <quic_khsieh@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20241202-tpg-v1-0-0fd6b518b914@quicinc.com>
 <20241202-tpg-v1-1-0fd6b518b914@quicinc.com>
 <hwomnwmuak3optjooe6g5szqi77nc7znsfjrxqbxx72nqe3e7k@om2e65vaurov>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <hwomnwmuak3optjooe6g5szqi77nc7znsfjrxqbxx72nqe3e7k@om2e65vaurov>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ya0G7rExtnQ0jiRBPGplpdQt7C5vj2gM
X-Proofpoint-GUID: ya0G7rExtnQ0jiRBPGplpdQt7C5vj2gM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030163



On 12/3/2024 6:34 AM, Dmitry Baryshkov wrote:
> On Mon, Dec 02, 2024 at 12:41:58PM -0800, Abhinav Kumar wrote:
>> Adjust the h_active calculation to account for widebus in tpg.
>>
>> Fixes: 757a2f36ab09 ("drm/msm/dp: enable widebus feature for display port")
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_catalog.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
>> index b4c8856fb25d..05c8e1996f60 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
>> @@ -1011,9 +1011,21 @@ void msm_dp_catalog_panel_tpg_enable(struct msm_dp_catalog *msm_dp_catalog,
>>   	u32 v_sync_width;
>>   	u32 hsync_ctl;
>>   	u32 display_hctl;
>> +	u32 h_sync_width;
>> +	u32 h_front_porch;
>> +	u32 h_back_porch;
>> +	u32 h_active;
>> +
>> +	h_active = drm_mode->hdisplay;
>> +	h_back_porch = drm_mode->htotal - drm_mode->hsync_end;
>> +	h_sync_width = drm_mode->htotal - (drm_mode->hsync_start + h_back_porch);
> 
> It's at least drm_mode->hsync_end - drm_mode->hsync_start
> 
>> +	h_front_porch = drm_mode->hsync_start - drm_mode->hdisplay;
>> +
>> +	if (msm_dp_catalog->wide_bus_en)
>> +		h_active /= 2;
>>   
>>   	/* TPG config parameters*/
>> -	hsync_period = drm_mode->htotal;
>> +	hsync_period = h_sync_width + h_back_porch + h_active + h_front_porch;
> 
> Is it equivalent to:
> 
> hsync_period = drm_mode->htotal;
> if (msm_dp_catalog->wide_bus_en)
>      hsync_period -= drm_mode->hdisplay / 2;
> 
> I think it's simpler to handle.
> 

Yes certainly!

Thanks for the feedback. Will fix it up.

>>   	vsync_period = drm_mode->vtotal;
>>   
>>   	display_v_start = ((drm_mode->vtotal - drm_mode->vsync_start) *
>>
>> -- 
>> 2.34.1
>>
> 

