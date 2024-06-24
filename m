Return-Path: <linux-kernel+bounces-228087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCA915ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60881C21DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104AA1A2C01;
	Mon, 24 Jun 2024 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DPP2yGcl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B717BA7;
	Mon, 24 Jun 2024 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272524; cv=none; b=IHl95VzyW+kuYCrW723LXDYqWlCs9t4tag5hlj5+D+hLBm4v+VvEmGs+OpbKB4FrJ/LfiNqbgajiPDxK1FZNgXFR+I44eU4k8ZD1hZ0NJY+3mqJ4Eu8xHmQFKXVGBvdQK8DaxhfRpOsCBOOyCYfbnyR3Vr9qMYL1OzY6m9zJHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272524; c=relaxed/simple;
	bh=gce0JHqH9LfHfzOlPJGd0sVC8NxoAh5USZqnunnF/s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AGjjpauoz/ZeumZFQW9/WGRVa++GymUzl18v/JgfB4B/Cy7d+aWa3xmnY5OJZACq8tDQiIYMw/yxUepkjem0zrpt9udYPsUVB48xmaoy2KDKykPXiflvYwZGH2sP01NWPqVXLcnqlf+efqROi8rK7XIY31/pjGUSFVY+tYxTGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DPP2yGcl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OJ7Zer020319;
	Mon, 24 Jun 2024 23:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzbWLwx5kmHGd9u6t0c45ZTO5Zh47AOd4L4VUr6uTAQ=; b=DPP2yGcl//4uCKnd
	sTYZPbT7Ra24eDhVS9KKfP8rBagNQdO6+pWjorfupTj1DRxedibnC2loUA+HW6XX
	dcLB+I8TDTFr63kBozuxnptnQl64BM/IXyDUuL+mHhN+G2XO4HXpeB7DzKxJQuAy
	8IPgoGHmTn+I3n2bN3cLCdUwKLPI97s/bYcGB1NKOJXdvUes56f8iKEn+jfpd/jc
	G36q5h6fVatRwDPxeu4p701qQIF/s/qGomJ0AFX1K/hP1nHQ5uvJx1NfgDL+MGlA
	zsLNScdKaoCSJSTTQs24S43MUrWKg/Q2TpsXjlEFiF8Mz/S5eQ2oQHhWVh4yJE9f
	y0lAVw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6ymvef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 23:41:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45ONfmJh007937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 23:41:48 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 16:41:48 -0700
Message-ID: <de8ab492-272c-4bed-92eb-a0c3303543b2@quicinc.com>
Date: Mon, 24 Jun 2024 16:41:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/panel: jd9365da: Modify the method of sending
 commands
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.co>,
        <dianders@google.com>, <hsinyi@google.com>, <jagan@edgeble.ai>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7m_-aN2Z8ZXD2rpIlvxQAzzlmjWO4sOZ
X-Proofpoint-ORIG-GUID: 7m_-aN2Z8ZXD2rpIlvxQAzzlmjWO4sOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_20,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240190



On 6/24/2024 7:19 AM, Zhaoxiong Lv wrote:
> Currently, the init_code of the jd9365da driver is placed
> in the enable() function and sent, but this seems to take
> a long time. It takes 17ms to send each instruction (an init
> code consists of about 200 instructions), so it takes
> about 3.5s to send the init_code. So we moved the sending
> of the inti_code to the prepare() function, and each
> instruction seemed to take only 25μs.
> 
> We checked the DSI host and found that the difference in
> command sending time is caused by the different modes of
> the DSI host in prepare() and enable() functions.
> Our DSI Host only supports sending cmd in LP mode, The
> prepare() function can directly send init_code (LP->cmd)
> in LP mode, but the enable() function is in HS mode and
> needs to switch to LP mode before sending init code
> (HS->LP->cmd->HS). Therefore, it takes longer to send
> the command.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Hi Zhaoxiong,

Just curious, if the host expects that commands are sent in LP mode, why 
isn't the MIPI_DSI_MODE_LPM flag set before sending the DCS commands?

Thanks,

Jessica Zhang

> ---
> Changes between V5 and V4:
> - 1. No changes.
> 
> V4:https://lore.kernel.org/all/20240620080509.18504-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> Changes between V4 and V3:
> - 1. Only move mipi_dsi_dcs_write_buffer from enable() function to prepare() function,
> -    and no longer use mipi_dsi_dcs_write_seq_multi.
> 
> V3:https://lore.kernel.org/all/20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> ---
>   .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 24 +++++++++----------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 4879835fe101..a9c483a7b3fa 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -52,21 +52,9 @@ static int jadard_enable(struct drm_panel *panel)
>   {
>   	struct device *dev = panel->dev;
>   	struct jadard *jadard = panel_to_jadard(panel);
> -	const struct jadard_panel_desc *desc = jadard->desc;
>   	struct mipi_dsi_device *dsi = jadard->dsi;
> -	unsigned int i;
>   	int err;
>   
> -	msleep(10);
> -
> -	for (i = 0; i < desc->num_init_cmds; i++) {
> -		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
> -
> -		err = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
> -		if (err < 0)
> -			return err;
> -	}
> -
>   	msleep(120);
>   
>   	err = mipi_dsi_dcs_exit_sleep_mode(dsi);
> @@ -100,6 +88,8 @@ static int jadard_disable(struct drm_panel *panel)
>   static int jadard_prepare(struct drm_panel *panel)
>   {
>   	struct jadard *jadard = panel_to_jadard(panel);
> +	const struct jadard_panel_desc *desc = jadard->desc;
> +	unsigned int i;
>   	int ret;
>   
>   	ret = regulator_enable(jadard->vccio);
> @@ -117,7 +107,15 @@ static int jadard_prepare(struct drm_panel *panel)
>   	msleep(10);
>   
>   	gpiod_set_value(jadard->reset, 1);
> -	msleep(120);
> +	msleep(130);
> +
> +	for (i = 0; i < desc->num_init_cmds; i++) {
> +		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
> +
> +		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	return 0;
>   }
> -- 
> 2.17.1
> 

