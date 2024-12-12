Return-Path: <linux-kernel+bounces-443690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DBB9EFAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19D41893E41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496D22FE19;
	Thu, 12 Dec 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WqiYTPB8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09110223C7A;
	Thu, 12 Dec 2024 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027054; cv=none; b=Lr6CzMFT4UOeipVOTAw/3jLpfvgvfs82cYKCVxgOM+Dej0LegqGPAKwXuwv6PdXuT1X3kd5kzOoxzDuQWB148OFfHcUwjiik3mILd1R47+twhEA141Wn8bLZgEoK/QkAMntyBR8iuuxaI9Jn2eb0xWIhcQVftyVehzd4WiyVHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027054; c=relaxed/simple;
	bh=nZH/uWxD189Evx1ngKvL1fasRRvTsPFehNUW1HYUr5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XegLOjSpw2atitJpWTlNnUEDpA4spZwsqA2+4Q0srx+Fjr8mEsEifG5fGLUyhlECZFHnDNsxaFiR67MAMRfhr9Rkqf7KlQh8yrddjxvPKsXPrXFZV87ZyK+dqtYW0ka6qrYv3Hcxl9VaaEhI5iiC7BI6CDYn0vAK6jcXrIBfQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WqiYTPB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCGvbVE029911;
	Thu, 12 Dec 2024 18:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s2oXJFUSdO4b3N0K1tz9zIWqIb8TBGZozHuxtL/NG40=; b=WqiYTPB8dqHWp8Um
	e1m2JHTUlzjbjeqNfGLgBho6B/UjQG5T5S0+HzdoEDn3wBFhNBG9TDkZL9mDzt4W
	gLg3G5oMtxIgKFzUrNDJkwKCjd9cR0eaJTjK8M5yPFTYV0A4GHM2xQ/c1nwHmV7c
	vYu2BfkttXiuJLYDBX29mdQShOuXm1rjYrBWMu0sRHikTizkZRVDCcxF0ak5CkWs
	fCyY7VKRmXokF6rDWYnmsjS9umeVZC83zoNf+Q8+gnoqxmlf9WKtpbFE7EC+W7iq
	tONGNvTNoxWH413KN7OWw6zSaWQkQ1WbfInTZLRyFbF989VWAfVOVvqRai7FiM3h
	DOkoWg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd4xuujk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 18:10:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCIAVvV015187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 18:10:31 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 10:10:31 -0800
Message-ID: <7fa714e0-b9db-45a4-a7c4-118cf21dc590@quicinc.com>
Date: Thu, 12 Dec 2024 10:10:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/panel: add Raydium RM67200 panel driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Andy Yan <andyshrk@163.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona
 Vetter <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <kernel@collabora.com>
References: <20241210164333.121253-1-sebastian.reichel@collabora.com>
 <20241210164333.121253-3-sebastian.reichel@collabora.com>
 <2cbbc5d6-2d6b-4afe-a0ef-7f59d28724dc@quicinc.com>
 <2kfapf6iolb65g3kss2hulwpqiczyyk6vvv37pqthm7o625umf@vuo7saus5kcy>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <2kfapf6iolb65g3kss2hulwpqiczyyk6vvv37pqthm7o625umf@vuo7saus5kcy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wa0Ju1jR_y0qDp3vsQHUignnVGZZ_BJG
X-Proofpoint-GUID: Wa0Ju1jR_y0qDp3vsQHUignnVGZZ_BJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=925 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120129



On 12/10/2024 2:41 PM, Sebastian Reichel wrote:
> Hello Jessica,
> 
> On Tue, Dec 10, 2024 at 09:45:09AM -0800, Jessica Zhang wrote:
>> [...]
>>> +static const struct raydium_rm67200_panel_info w552793baa_info = {
>>> +	.mode = {
>>> +		.clock = 132000,
>>> +		.hdisplay = 1080,
>>> +		.hsync_start = 1095,
>>> +		.hsync_end = 1125,
>>> +		.htotal = 1129,
>>> +		.vdisplay = 1920,
>>> +		.vsync_start = 1935,
>>> +		.vsync_end = 1950,
>>> +		.vtotal = 1952,
>>> +		.width_mm = 68, /* 68.04mm */
>>> +		.height_mm = 121, /* 120.96mm */
>>> +		.type = DRM_MODE_TYPE_DRIVER,
>>> +	},
>>> +	.regulators = w552793baa_regulators,
>>> +	.num_regulators = ARRAY_SIZE(w552793baa_regulators),
>>> +	.panel_setup = w552793baa_setup,
>>
>> Just curious, will there be other panels with different regulators and init
>> commands added for this driver in the future?
> 
> I don't know any other RM67200 based panels. But the init sequence
> contains lots of vendor specific registers and I'm pretty sure it
> is specific to the W552793BAA. I put the regulators into the panel
> specific section, because the datasheet for the RM67200 specifies
> slightly different ones than the w552793baa datasheet. Thus I expect
> that other displays might have slight differences.

Ack, thanks for clarifying.

In that case,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Greetings,
> 
> -- Sebastian


