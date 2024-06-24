Return-Path: <linux-kernel+bounces-227553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABF915325
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801951C226E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199B19D89D;
	Mon, 24 Jun 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bWPasvFq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642E14264C;
	Mon, 24 Jun 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245389; cv=none; b=J2r2GtPb+vVx4erZCzhPGNzjxiNuGY6UAcIViRa6KLH5VgHW+xXLcZALtgK+X+IU3AjDYcGC+L2xpkqDR+aDGLi2olxFA9jkQCqjCRpcB7zy/SIOyvWr1YxADzRufmbud1XLDjNDO3x7hFJJWSyD2ct4zMa97lJ0fhN9gX1YLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245389; c=relaxed/simple;
	bh=crGQnyvQ3WV2pooiE0nYH0RPMIhwc0fCco/rfImN3Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vEw99XVleBAqeGW7Ac68MsVp1w+xlhmaAqDg4vv3ZTr3PjcCwJ7VqNjzxsTZqOpbBOCw9vPevXE60tcjU7rrz/U6CoriapuXqVATV17fkvlLHlNiLF4wUkosez5Qud+w91s0gZ+r0BsRej2MUlB/Mb8z7+lO4qhlg5tiRJde38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bWPasvFq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8YkWt007960;
	Mon, 24 Jun 2024 16:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XGm1PQQvfx1GHXN3o4N9cO5QcBAnrPqv25v9cbmeBg=; b=bWPasvFqW7UZ36Br
	oVN4v3D94qOvVU7TMXKw6PDwUaFVm4cd/eaQObPytgai0lEldY2zP8DIckIN2EHr
	FUvaCGqKm+uCwuRnNiA++hQPKcK056eWcJvrfK1sTG3M9E6l75gELO2NJT43z8jp
	AStHRYHv68hl6u5DuK+KxXLTvXHsn2FoXaiIf+E+6gMy86WHG2S1dYaUgbcmRKvh
	M3UR4qkLd0nl50BCOHjiYplAhszPntEYc5GpP4ARAlpjJ1UDy3IHa0/xYQT6warT
	7AHiJlje0zDW+PvFIfK0oOBIgtXgWgMGAXl5T5a7S/kdqOd6SJ8fMwP54vlmy/1K
	aKH6PA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnjrv8gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 16:09:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OG9dZ7000695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 16:09:39 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 09:09:39 -0700
Message-ID: <df490024-440c-45aa-a420-312ad24a26e0@quicinc.com>
Date: Mon, 24 Jun 2024 09:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240608-md-drivers-mailbox-v1-1-6ce5d6f924ad@quicinc.com>
 <05841850-aeb6-47b6-916b-f4889d971d5c@collabora.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <05841850-aeb6-47b6-916b-f4889d971d5c@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cYCySJiXn-1OvVH0nsbecfNuw1Y8RnXJ
X-Proofpoint-ORIG-GUID: cYCySJiXn-1OvVH0nsbecfNuw1Y8RnXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_13,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240129

On 6/24/2024 4:34 AM, AngeloGioacchino Del Regno wrote:
> Il 08/06/24 18:31, Jeff Johnson ha scritto:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
>> index 4aa394e91109..8247584bcbeb 100644
>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>> @@ -790,4 +790,5 @@ static void __exit cmdq_drv_exit(void)
>>   subsys_initcall(cmdq_drv_init);
>>   module_exit(cmdq_drv_exit);
>>   
>> +MODULE_DESCRIPTION("Mediatek Command Queue(CMDQ) driver");
> 
> MODULE_DESCRIPTION("MediaTek Command Queue (CMDQ) Mailbox driver");
> 
> After which,
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

ack, v2 coming


