Return-Path: <linux-kernel+bounces-234792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B822A91CB07
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE33B22C21
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65552033A;
	Sat, 29 Jun 2024 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+xhhoeu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D532C684
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636782; cv=none; b=Fo2ZzHk29zM9C5a7eKGEj02+87u1OuwNBTSARK2B7Y8SGRtSLPunLvQdX/e3u0DwyE4Dn431tYFswmRKO4mwugf386E/GfdRVsWGuhMnWFsP7l1wpUwjDEzYh/Qe0eDhz0awaNHfGV/JF9mlLCkfxrj3EyoM5nRE2WA4VEmLLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636782; c=relaxed/simple;
	bh=hTg0m15hao46yudGVG866WlZpeOh7SkeZz5wgAoJGm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a0/IWdyF1XYX2CnMDLA3uumawouk5r9KD9d9IjnA1SNaIYwicGFi7Um7xoEPZDBuoe8RQeh3Nh29aQYjYQfkCZ3o6lzreKoePPOqUHJi1WQC6XfMJY+rgN4V08Jn0PvJ0nYA2Gai9h0SlK2Mt5ZcdoIY9sS6RH2pZtSOC4azjvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+xhhoeu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T4ab6C028498;
	Sat, 29 Jun 2024 04:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VYjkpS9rvu4zTA/sXPiOwttTNNhhPJDzKngsyZMHEBg=; b=k+xhhoeuv7Gxs94h
	qEP2t9obimHowg2mkmux8WFy6PwmIk4a0RNnVhdxsKJ/53uT9fpJIkUzYmbF/TDA
	pk1Y01ugVvpJMsavTzCHkMzgRtKiGTnBaGnHKZQSvloUgCIgsvNsSDyf3O7PoUeT
	E8LxLpM/v2V+Ml7D58286JW5gcICv32a+yQDGyBG08Ra75E6t437IDjFhkmjypVy
	KbVaMhXBcNa28B4FxT/MWynqxGq87IA7Pf1LV1MubQH0fzs29WZn+CcBW+RSmJzC
	8NMT4NZmX5VbS8T5onOHs7WUMiLzZIhfjanMWNCZ9O2r2/xRQCK3cvLt91kn4fSU
	L0rMTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402an706nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 04:52:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T4qeHB026787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 04:52:40 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 21:52:40 -0700
Message-ID: <0aa9e0aa-3d8f-4277-8348-99b9dd176954@quicinc.com>
Date: Fri, 28 Jun 2024 21:52:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm: Add panel backlight quirks
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alex Deucher
	<alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo
 Siqueira <Rodrigo.Siqueira@amd.com>,
        Mario Limonciello
	<mario.limonciello@amd.com>,
        Matt Hartley <matt.hartley@gmail.com>,
        Kieran
 Levin <ktl@framework.net>, Hans de Goede <hdegoede@redhat.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Dustin Howett <dustin@howett.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yP_U84sdQLgyQ95bNMSMJL6UQFEAH4E5
X-Proofpoint-ORIG-GUID: yP_U84sdQLgyQ95bNMSMJL6UQFEAH4E5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_01,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290034

On 6/23/24 01:51, Thomas Weißschuh wrote:
> Panels using a PWM-controlled backlight source without an do not have a
> standard way to communicate their valid PWM ranges.
> On x86 the ranges are read from ACPI through driver-specific tables.
> The built-in ranges are not necessarily correct, or may grow stale if an
> older device can be retrofitted with newer panels.
> 
> Add a quirk infrastructure with which the valid backlight ranges can be
> maintained as part of the kernel.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
...

> +EXPORT_SYMBOL(drm_get_panel_backlight_quirk);
> +
> +MODULE_LICENSE("GPL");

Missing a MODULE_DESCRIPTION()

This will result in a make W=1 warning


