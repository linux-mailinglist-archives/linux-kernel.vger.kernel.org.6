Return-Path: <linux-kernel+bounces-319529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CC696FDEE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C711A283543
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679DD15921B;
	Fri,  6 Sep 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GekqTmeH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9A01B85DD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661417; cv=none; b=hS+nZTJZgSNz4duJq37T414fMvaJVPu9+pG1LHzxndtvQTjt9GvsgoDrnfNfZzMzwCs0fX0QwRQHO75TGqS5QXwxVyi35VZcvaoPJSe80509eIi5uE7/NzgZJMNeL1pW66e5WrJ9kWdUcvklZ7BJSkLYW8XejZaACYcnrMjDpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661417; c=relaxed/simple;
	bh=fP27mWgoxSKcYk0uKDVXSIn+LnjcUDlnE1XRNHALj5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=VWQf8oIRV/t4XQPFsvxf6loQhZm10/UGybx3UxjobgYExErM44DxSWMkNsFFJTOMM1zZYTN2CbgWAkeBwXlJpknodUwtIUx2F8YarbWo3IlBSnzmNunPYC9/uAeJn3t8GO+d4QdDP7snbA1yDo7+PqK8AaxvkYrEXpuAYEUFKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GekqTmeH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486JSBOE027907;
	Fri, 6 Sep 2024 22:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEcgDkFWC8V16KamwSiOCBpRXeLHVHVUVK0CFZ3l4tw=; b=GekqTmeHyNdpcykF
	NFPKxTxesceSzpzU9AAnnQldPOpTBFTEyi7Q+xvYI1uXHhNwKZ/xLGme72LOnWej
	DdpKIsfP2QfGt3LKfFmZkORcdiBEbr3IfZhyYIPsDH2Bur0NqJrLb6a1RPyxCYVj
	Ezk0DrjmwcdaWiHRRanzUJaPbikcRQ6fv6cEmlqqE3pGyIwxhqcXcnKW56YkKfXU
	EmikmRgYvEIzzyokUckE8db0cqqCrKQQyuMFAA2Holcb12jGtg5Ei6+DKA4eSHOT
	LRAkFbne9Deu+kFXN6nGur9f5oINJywSQvuVpinjI7ZtlXIQtVjl49nkfy5RrXnc
	up5MQA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx1ujra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 22:23:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486MNMim016964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 22:23:22 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 15:23:22 -0700
Message-ID: <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
Date: Fri, 6 Sep 2024 15:23:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped
 functions
From: Jessica Zhang <quic_jesszhan@quicinc.com>
To: Tejas Vipin <tejasvipin76@gmail.com>, <neil.armstrong@linaro.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <dianders@chromium.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
 <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com>
Content-Language: en-US
In-Reply-To: <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0wGASOgVacZOkZtzPK6kxYJw2RVtSrYz
X-Proofpoint-GUID: 0wGASOgVacZOkZtzPK6kxYJw2RVtSrYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_07,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060166



On 9/6/2024 3:14 PM, Jessica Zhang wrote:
> 
> 
> On 9/4/2024 7:15 AM, Tejas Vipin wrote:
>> Changes the himax-hx83112a panel to use multi style functions for
>> improved error handling.
>>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> 
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Hi Tejas,

Just a heads up, it seems that this might be a duplicate of this change [1]?

Thanks,

Jessica Zhang

[1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1

> 
>> ---
>>   drivers/gpu/drm/panel/panel-himax-hx83112a.c | 297 +++++++++----------
>>   1 file changed, 136 insertions(+), 161 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112a.c 
>> b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
>> index 466c27012abf..47bce087e339 100644
>> --- a/drivers/gpu/drm/panel/panel-himax-hx83112a.c
>> +++ b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
>> @@ -56,198 +56,173 @@ static void hx83112a_reset(struct hx83112a_panel 
>> *ctx)
>>       msleep(50);
>>   }
>> -static int hx83112a_on(struct hx83112a_panel *ctx)
>> +static int hx83112a_on(struct mipi_dsi_device *dsi)
>>   {
>> -    struct mipi_dsi_device *dsi = ctx->dsi;
>> -    struct device *dev = &dsi->dev;
>> -    int ret;
>> +    struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>>       dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETEXTC, 0x83, 0x11, 0x2a);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPOWER1,
>> -                   0x08, 0x28, 0x28, 0x83, 0x83, 0x4c, 0x4f, 0x33);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDISP,
>> -                   0x00, 0x02, 0x00, 0x90, 0x24, 0x00, 0x08, 0x19,
>> -                   0xea, 0x11, 0x11, 0x00, 0x11, 0xa3);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDRV,
>> -                   0x58, 0x68, 0x58, 0x68, 0x0f, 0xef, 0x0b, 0xc0,
>> -                   0x0b, 0xc0, 0x0b, 0xc0, 0x00, 0xff, 0x00, 0xff,
>> -                   0x00, 0x00, 0x14, 0x15, 0x00, 0x29, 0x11, 0x07,
>> -                   0x12, 0x00, 0x29);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDRV,
>> -                   0x00, 0x12, 0x12, 0x11, 0x88, 0x12, 0x12, 0x00,
>> -                   0x53);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x03);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT,
>> -                   0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
>> -                   0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
>> -                   0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
>> -                   0x84, 0x7c, 0x74, 0x6b, 0x62, 0x5a, 0x51, 0x49,
>> -                   0x41, 0x39, 0x31, 0x29, 0x21, 0x19, 0x12, 0x0a,
>> -                   0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
>> -                   0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
>> -                   0x40);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT,
>> -                   0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
>> -                   0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
>> -                   0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
>> -                   0x84, 0x7c, 0x74, 0x6b, 0x62, 0x5a, 0x51, 0x49,
>> -                   0x41, 0x39, 0x31, 0x29, 0x21, 0x19, 0x12, 0x0a,
>> -                   0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
>> -                   0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
>> -                   0x40);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT,
>> -                   0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
>> -                   0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
>> -                   0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
>> -                   0x84, 0x7c, 0x74, 0x6b, 0x62, 0x5a, 0x51, 0x49,
>> -                   0x41, 0x39, 0x31, 0x29, 0x21, 0x19, 0x12, 0x0a,
>> -                   0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
>> -                   0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
>> -                   0x40);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT, 0x01);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTCON,
>> -                   0x70, 0x00, 0x04, 0xe0, 0x33, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPANEL, 0x08);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPOWER2, 0x2b, 0x2b);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP0,
>> -                   0x80, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x08,
>> -                   0x08, 0x03, 0x03, 0x22, 0x18, 0x07, 0x07, 0x07,
>> -                   0x07, 0x32, 0x10, 0x06, 0x00, 0x06, 0x32, 0x10,
>> -                   0x07, 0x00, 0x07, 0x32, 0x19, 0x31, 0x09, 0x31,
>> -                   0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x08,
>> -                   0x09, 0x30, 0x00, 0x00, 0x00, 0x06, 0x0d, 0x00,
>> -                   0x0f);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP0,
>> -                   0x00, 0x00, 0x19, 0x10, 0x00, 0x0a, 0x00, 0x81);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP1,
>> -                   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
>> -                   0xc0, 0xc0, 0x18, 0x18, 0x19, 0x19, 0x18, 0x18,
>> -                   0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x3f, 0x3f,
>> -                   0x28, 0x28, 0x24, 0x24, 0x02, 0x03, 0x02, 0x03,
>> -                   0x00, 0x01, 0x00, 0x01, 0x31, 0x31, 0x31, 0x31,
>> -                   0x30, 0x30, 0x30, 0x30, 0x2f, 0x2f, 0x2f, 0x2f);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP2,
>> -                   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
>> -                   0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x19, 0x19,
>> -                   0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x3f, 0x3f,
>> -                   0x24, 0x24, 0x28, 0x28, 0x01, 0x00, 0x01, 0x00,
>> -                   0x03, 0x02, 0x03, 0x02, 0x31, 0x31, 0x31, 0x31,
>> -                   0x30, 0x30, 0x30, 0x30, 0x2f, 0x2f, 0x2f, 0x2f);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
>> -                   0xaa, 0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xea,
>> -                   0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xea, 0xab, 0xaa,
>> -                   0xaa, 0xaa, 0xaa, 0xea, 0xab, 0xaa, 0xaa, 0xaa);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
>> -                   0xaa, 0x2e, 0x28, 0x00, 0x00, 0x00, 0xaa, 0x2e,
>> -                   0x28, 0x00, 0x00, 0x00, 0xaa, 0xee, 0xaa, 0xaa,
>> -                   0xaa, 0xaa, 0xaa, 0xee, 0xaa, 0xaa, 0xaa, 0xaa);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
>> -                   0xaa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0xff,
>> -                   0xff, 0xff, 0xff, 0xff);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x03);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
>> -                   0xaa, 0xaa, 0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>> -                   0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xff, 0xff, 0xff,
>> -                   0xff, 0xff, 0xaa, 0xff, 0xff, 0xff, 0xff, 0xff);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTP1,
>> -                   0x0e, 0x0e, 0x1e, 0x65, 0x1c, 0x65, 0x00, 0x50,
>> -                   0x20, 0x20, 0x00, 0x00, 0x02, 0x02, 0x02, 0x05,
>> -                   0x14, 0x14, 0x32, 0xb9, 0x23, 0xb9, 0x08);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTP1,
>> -                   0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTP1,
>> -                   0x00, 0x00, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00,
>> -                   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -                   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00,
>> -                   0x00, 0x00, 0x00, 0x02, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0xc3);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETCLOCK, 0xd1, 0xd6);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0x3f);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0xc6);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPTBA, 0x37);
>> -    mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0x3f);
>> -
>> -    ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
>> -        return ret;
>> -    }
>> -    msleep(150);
>> -
>> -    ret = mipi_dsi_dcs_set_display_on(dsi);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to set display on: %d\n", ret);
>> -        return ret;
>> -    }
>> -    msleep(50);
>> -
>> -    return 0;
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETEXTC, 0x83, 
>> 0x11, 0x2a);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPOWER1,
>> +                     0x08, 0x28, 0x28, 0x83, 0x83, 0x4c, 0x4f, 0x33);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDISP,
>> +                     0x00, 0x02, 0x00, 0x90, 0x24, 0x00, 0x08, 0x19,
>> +                     0xea, 0x11, 0x11, 0x00, 0x11, 0xa3);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDRV,
>> +                     0x58, 0x68, 0x58, 0x68, 0x0f, 0xef, 0x0b, 0xc0,
>> +                     0x0b, 0xc0, 0x0b, 0xc0, 0x00, 0xff, 0x00, 0xff,
>> +                     0x00, 0x00, 0x14, 0x15, 0x00, 0x29, 0x11, 0x07,
>> +                     0x12, 0x00, 0x29);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDRV,
>> +                     0x00, 0x12, 0x12, 0x11, 0x88, 0x12, 0x12, 0x00,
>> +                     0x53);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x03);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT,
>> +                     0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
>> +                     0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
>> +                     0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
>> +                     0x84, 0x7c, 0x74, 0x6b, 0x62, 0x5a, 0x51, 0x49,
>> +                     0x41, 0x39, 0x31, 0x29, 0x21, 0x19, 0x12, 0x0a,
>> +                     0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
>> +                     0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
>> +                     0x40);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT,
>> +                     0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
>> +                     0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
>> +                     0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
>> +                     0x84, 0x7c, 0x74, 0x6b, 0x62, 0x5a, 0x51, 0x49,
>> +                     0x41, 0x39, 0x31, 0x29, 0x21, 0x19, 0x12, 0x0a,
>> +                     0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
>> +                     0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
>> +                     0x40);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT,
>> +                     0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
>> +                     0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
>> +                     0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
>> +                     0x84, 0x7c, 0x74, 0x6b, 0x62, 0x5a, 0x51, 0x49,
>> +                     0x41, 0x39, 0x31, 0x29, 0x21, 0x19, 0x12, 0x0a,
>> +                     0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
>> +                     0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
>> +                     0x40);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT, 0x01);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTCON,
>> +                     0x70, 0x00, 0x04, 0xe0, 0x33, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPANEL, 0x08);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPOWER2, 0x2b, 
>> 0x2b);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP0,
>> +                     0x80, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x08,
>> +                     0x08, 0x03, 0x03, 0x22, 0x18, 0x07, 0x07, 0x07,
>> +                     0x07, 0x32, 0x10, 0x06, 0x00, 0x06, 0x32, 0x10,
>> +                     0x07, 0x00, 0x07, 0x32, 0x19, 0x31, 0x09, 0x31,
>> +                     0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x08,
>> +                     0x09, 0x30, 0x00, 0x00, 0x00, 0x06, 0x0d, 0x00,
>> +                     0x0f);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP0,
>> +                     0x00, 0x00, 0x19, 0x10, 0x00, 0x0a, 0x00, 0x81);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP1,
>> +                     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
>> +                     0xc0, 0xc0, 0x18, 0x18, 0x19, 0x19, 0x18, 0x18,
>> +                     0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x3f, 0x3f,
>> +                     0x28, 0x28, 0x24, 0x24, 0x02, 0x03, 0x02, 0x03,
>> +                     0x00, 0x01, 0x00, 0x01, 0x31, 0x31, 0x31, 0x31,
>> +                     0x30, 0x30, 0x30, 0x30, 0x2f, 0x2f, 0x2f, 0x2f);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP2,
>> +                     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
>> +                     0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x19, 0x19,
>> +                     0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x3f, 0x3f,
>> +                     0x24, 0x24, 0x28, 0x28, 0x01, 0x00, 0x01, 0x00,
>> +                     0x03, 0x02, 0x03, 0x02, 0x31, 0x31, 0x31, 0x31,
>> +                     0x30, 0x30, 0x30, 0x30, 0x2f, 0x2f, 0x2f, 0x2f);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
>> +                     0xaa, 0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xea,
>> +                     0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xea, 0xab, 0xaa,
>> +                     0xaa, 0xaa, 0xaa, 0xea, 0xab, 0xaa, 0xaa, 0xaa);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
>> +                     0xaa, 0x2e, 0x28, 0x00, 0x00, 0x00, 0xaa, 0x2e,
>> +                     0x28, 0x00, 0x00, 0x00, 0xaa, 0xee, 0xaa, 0xaa,
>> +                     0xaa, 0xaa, 0xaa, 0xee, 0xaa, 0xaa, 0xaa, 0xaa);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
>> +                     0xaa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0xff,
>> +                     0xff, 0xff, 0xff, 0xff);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x03);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
>> +                     0xaa, 0xaa, 0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>> +                     0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xff, 0xff, 0xff,
>> +                     0xff, 0xff, 0xaa, 0xff, 0xff, 0xff, 0xff, 0xff);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
>> +                     0x0e, 0x0e, 0x1e, 0x65, 0x1c, 0x65, 0x00, 0x50,
>> +                     0x20, 0x20, 0x00, 0x00, 0x02, 0x02, 0x02, 0x05,
>> +                     0x14, 0x14, 0x32, 0xb9, 0x23, 0xb9, 0x08);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
>> +                     0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
>> +                     0x00, 0x00, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00,
>> +                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00,
>> +                     0x00, 0x00, 0x00, 0x02, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0xc3);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETCLOCK, 0xd1, 
>> 0xd6);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0x3f);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0xc6);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPTBA, 0x37);
>> +    mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0x3f);
>> +
>> +    mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +    mipi_dsi_msleep(&dsi_ctx, 150);
>> +
>> +    mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>> +    mipi_dsi_msleep(&dsi_ctx, 50);
>> +
>> +    return dsi_ctx.accum_err;
>>   }
>>   static int hx83112a_disable(struct drm_panel *panel)
>>   {
>>       struct hx83112a_panel *ctx = to_hx83112a_panel(panel);
>>       struct mipi_dsi_device *dsi = ctx->dsi;
>> -    struct device *dev = &dsi->dev;
>> -    int ret;
>> +    struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>>       dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> -    ret = mipi_dsi_dcs_set_display_off(dsi);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to set display off: %d\n", ret);
>> -        return ret;
>> -    }
>> -    msleep(20);
>> -
>> -    ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
>> -        return ret;
>> -    }
>> -    msleep(120);
>> +    mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>> +    mipi_dsi_msleep(&dsi_ctx, 20);
>> +    mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>> +    mipi_dsi_msleep(&dsi_ctx, 120);
>> -    return 0;
>> +    return dsi_ctx.accum_err;
>>   }
>>   static int hx83112a_prepare(struct drm_panel *panel)
>>   {
>>       struct hx83112a_panel *ctx = to_hx83112a_panel(panel);
>> -    struct device *dev = &ctx->dsi->dev;
>>       int ret;
>>       ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), 
>> ctx->supplies);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to enable regulators: %d\n", ret);
>> +    if (ret < 0)
>>           return ret;
>> -    }
>>       hx83112a_reset(ctx);
>> -    ret = hx83112a_on(ctx);
>> +    ret = hx83112a_on(ctx->dsi);
>>       if (ret < 0) {
>> -        dev_err(dev, "Failed to initialize panel: %d\n", ret);
>>           gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>>           regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), 
>> ctx->supplies);
>> -        return ret;
>>       }
>> -    return 0;
>> +    return ret;
>>   }
>>   static int hx83112a_unprepare(struct drm_panel *panel)
>> -- 
>> 2.46.0
>>

