Return-Path: <linux-kernel+bounces-229435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27258916F93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF701C20F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C1176FAE;
	Tue, 25 Jun 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DwSelJb0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9884437A;
	Tue, 25 Jun 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337829; cv=none; b=q4Dsyjc+154h3BS9p7YHXl7d0edkf4wx6c8VDYEB973cXeuuJtf5JAvjh+BBOenBIE3tEX05JnBMVRH+fW53N+HGp3WkWV/NtGSPNDrP3xvzcMSbZVPQI1CtvEdg5Df8Fty08Liyzd0SFdv2fPZXvpywXF27aK4VW7VHhUIJSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337829; c=relaxed/simple;
	bh=4CuXhQpxVmG8DvGCRAddmsDGShEx/lT3hBz2JxHU+/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EnMvHEPxWAiq4buE74UGM/KB57YlVkplznA+xyF6oCiAHOVZZrh6aWDGnHv165htacgPz4sdTDzBPcyTV68J6G4KTlW6j1e973MybgbzC1uGrn7cd2nH/KOGQreH5FrUmvG7lEvqIR8Sy5h5fBJT6SOZ7yaN/EboanYnTuGBu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DwSelJb0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHS2Re029597;
	Tue, 25 Jun 2024 17:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VQQNERkNf0HLY+jMaMWeDAkHWbLSQDCSmJl9/Wcx/KU=; b=DwSelJb0pXg/yofT
	E8nEaXYbikygMgjLxlH7btpVWaA9Aw5Vod7VOhMHu+cocdvAK58ZU4uVRSo/M5dR
	kOkNrkBqqsbTVTkLmxlAaSE1lB7FetXqt87UlDOH1J9GOMqW+CNCxpmWiYRXT79W
	B40IxlIg0h92rHvdeRfWe6JFoeBgIF7XnKqQlzIpPMBRGIJLI6fN5Asd+Ets0Fhc
	iElXTU/+GLyQVPOZHBzRcW6CNFzd/XTyRnsW+uUEKFQzRVov9rfZHMHCedRenzV8
	FqH3+b3tgqKj2Ngpsi6CtmEk8H0rnn8ILJlo7k8F1jMAqiHJGBz13EF3zAEiekYQ
	qofERA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywq077aq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:49:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PHnpji017991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:49:51 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 10:49:51 -0700
Message-ID: <a5734572-c822-493a-a15a-63dcf37d60cc@quicinc.com>
Date: Tue, 25 Jun 2024 10:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/panel: jd9365da: Modify the method of sending
 commands
To: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
CC: <dmitry.torokhov@gmail.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.co>,
        <dianders@google.com>, <hsinyi@google.com>, <jagan@edgeble.ai>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shuijing Li
	<shuijing.li@mediatek.corp-partner.google.com>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <de8ab492-272c-4bed-92eb-a0c3303543b2@quicinc.com>
 <CA+6=WdSDSvcMJsmUNW6NXqNXktYjp0xdqk8Y+FakiPBYcXfgGw@mail.gmail.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <CA+6=WdSDSvcMJsmUNW6NXqNXktYjp0xdqk8Y+FakiPBYcXfgGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4WWi98j1awuvR9CY8EGO0G0fIcqMTqS8
X-Proofpoint-GUID: 4WWi98j1awuvR9CY8EGO0G0fIcqMTqS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250131



On 6/25/2024 5:13 AM, zhaoxiong lv wrote:
> On Tue, Jun 25, 2024 at 7:41 AM Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>>
>>
>>
>> On 6/24/2024 7:19 AM, Zhaoxiong Lv wrote:
>>> Currently, the init_code of the jd9365da driver is placed
>>> in the enable() function and sent, but this seems to take
>>> a long time. It takes 17ms to send each instruction (an init
>>> code consists of about 200 instructions), so it takes
>>> about 3.5s to send the init_code. So we moved the sending
>>> of the inti_code to the prepare() function, and each
>>> instruction seemed to take only 25μs.
>>>
>>> We checked the DSI host and found that the difference in
>>> command sending time is caused by the different modes of
>>> the DSI host in prepare() and enable() functions.
>>> Our DSI Host only supports sending cmd in LP mode, The
>>> prepare() function can directly send init_code (LP->cmd)
>>> in LP mode, but the enable() function is in HS mode and
>>> needs to switch to LP mode before sending init code
>>> (HS->LP->cmd->HS). Therefore, it takes longer to send
>>> the command.
>>>
>>> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
>>
>> Hi Zhaoxiong,
>>
>> Just curious, if the host expects that commands are sent in LP mode, why
>> isn't the MIPI_DSI_MODE_LPM flag set before sending the DCS commands?
>>
>> Thanks,
>>
>> Jessica Zhang
> 
> hi jessica
> 
> We have tried to set dsi->mode_flags to MIPI_DSI_MODE_LPM in the
> probe() function,
> but this seems to still happen. MTK colleagues believe that the host
> dsi configuration is
> still in LP mode during the prepare() function, and when in the
> enable() function, the host
> dsi is already in HS mode. However, since the command must be sent in
> LP mode, it will
> switch back and forth between HS->LP->HS.
> 
> Add Mediatek colleagues（shuijing.li@mediatek.corp-partner.google.com）

Got it. Even drivers that call their init commands in prepare() set the 
LPM flag [1][2] when applicable so I was just wondering why this driver 
doesn't seem to set LPM at all even though it is going into LP mode.

[1] 
https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c#L46

[2] 
https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/panel/panel-visionox-r66451.c#L46

> 
> 
>>
>>> ---
>>> Changes between V5 and V4:
>>> - 1. No changes.
>>>
>>> V4:https://lore.kernel.org/all/20240620080509.18504-2-lvzhaoxiong@huaqin.corp-partner.google.com/
>>>
>>> Changes between V4 and V3:
>>> - 1. Only move mipi_dsi_dcs_write_buffer from enable() function to prepare() function,
>>> -    and no longer use mipi_dsi_dcs_write_seq_multi.
>>>
>>> V3:https://lore.kernel.org/all/20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com/
>>>
>>> ---
>>>    .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 24 +++++++++----------
>>>    1 file changed, 11 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>>> index 4879835fe101..a9c483a7b3fa 100644
>>> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>>> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>>> @@ -52,21 +52,9 @@ static int jadard_enable(struct drm_panel *panel)
>>>    {
>>>        struct device *dev = panel->dev;
>>>        struct jadard *jadard = panel_to_jadard(panel);
>>> -     const struct jadard_panel_desc *desc = jadard->desc;
>>>        struct mipi_dsi_device *dsi = jadard->dsi;
>>> -     unsigned int i;
>>>        int err;
>>>
>>> -     msleep(10);
>>> -
>>> -     for (i = 0; i < desc->num_init_cmds; i++) {
>>> -             const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
>>> -
>>> -             err = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
>>> -             if (err < 0)
>>> -                     return err;
>>> -     }
>>> -
>>>        msleep(120);
>>>
>>>        err = mipi_dsi_dcs_exit_sleep_mode(dsi);
>>> @@ -100,6 +88,8 @@ static int jadard_disable(struct drm_panel *panel)
>>>    static int jadard_prepare(struct drm_panel *panel)
>>>    {
>>>        struct jadard *jadard = panel_to_jadard(panel);
>>> +     const struct jadard_panel_desc *desc = jadard->desc;
>>> +     unsigned int i;
>>>        int ret;
>>>
>>>        ret = regulator_enable(jadard->vccio);
>>> @@ -117,7 +107,15 @@ static int jadard_prepare(struct drm_panel *panel)
>>>        msleep(10);
>>>
>>>        gpiod_set_value(jadard->reset, 1);
>>> -     msleep(120);
>>> +     msleep(130);
>>> +
>>> +     for (i = 0; i < desc->num_init_cmds; i++) {
>>> +             const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
>>> +
>>> +             ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +     }
>>>
>>>        return 0;
>>>    }
>>> --
>>> 2.17.1
>>>

