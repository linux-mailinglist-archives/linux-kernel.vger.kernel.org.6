Return-Path: <linux-kernel+bounces-208388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E190245B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DE1C220F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269FD139578;
	Mon, 10 Jun 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ENvOjd4s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FB12F5BE;
	Mon, 10 Jun 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030615; cv=none; b=cj6RIaFAVqiwiQ4ODgaDrJyqV9AZjSuSNsmlKIZw83f2V+ZgplnSrVvL1zkLVST38H7Ze7L/b5FXeNnJ86B2Dl5lAszRsGoRdHK209JPTKHXPkbQzuQskiRzXD/XFIBGb1ZgeUEYISxxth8PPtg5gXORhOjZWmK83brIUuA8bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030615; c=relaxed/simple;
	bh=AdW/5ZmyQ0sdPt/jZjRQEIa5QlnW52hwp6qF3wI62xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6ONWdohQ/+MHrtiexSEr0mdfZjjz+jw1XrosP7aQD8rPlaohM/VgHxjh0DONOj3naf/hc446ogfhuTtmqEyFQ4l4zH92XeuUWRXpFnybk7JKytx4g+JjerYfvv9pl4N5rOTGu4xfxhdrECZ2dxvyr2v/j6v75aXzQX6ocSdzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ENvOjd4s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A0FHmi002948;
	Mon, 10 Jun 2024 14:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/UQQ9H++oZe+xwgJihFR6a+g++Sf6h5Yv7IgtvZo3fk=; b=ENvOjd4sXGajIdHU
	+7e/xb3ey0KYVCPCPva0Ih461Egi/g+FaTRqpZQlKdFRaqWlQDVMB8+/Kc2ZCuQR
	HDTburlqOnhEfnwRELlqnmE8lQfmb+z0oTubku4tpGHtiPFeTUbAzFNtG1vvlDZa
	SInmOrRv9Igxhgjsyz/6ATA52KGs7KBXOO1ikwnIwu47gdzSADGiUkgnajTRomLb
	sYvj6kEJnHZbBbrpPcxVuXgerpNsH6CBgt/1jn3JYb1RoTmZ3370V+G7oT1THiB7
	npKJFOwOfXkdPWkllG+47XChiBgkLBk1k+PL3BXzzMaI5sb7fT9CnLWnxS4tteiH
	JTz6kA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymg2ekx98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AEhLg1028882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:43:21 GMT
Received: from [10.48.242.196] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 07:43:20 -0700
Message-ID: <15a49eeb-aeca-4bd7-8761-5e42fe30aee3@quicinc.com>
Date: Mon, 10 Jun 2024 07:43:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240608-md-drivers-regulator-v1-1-da338665db7a@quicinc.com>
 <29cb4283-34ef-4c90-ad53-ea572576d3fa@collabora.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <29cb4283-34ef-4c90-ad53-ea572576d3fa@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ziACR76-LJqII_3YKXKQuU1PmWJvYdmL
X-Proofpoint-GUID: ziACR76-LJqII_3YKXKQuU1PmWJvYdmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100112

On 6/10/2024 1:43 AM, AngeloGioacchino Del Regno wrote:
> Il 09/06/24 06:53, Jeff Johnson ha scritto:
>> --- a/drivers/regulator/mtk-dvfsrc-regulator.c
>> +++ b/drivers/regulator/mtk-dvfsrc-regulator.c
>> @@ -211,4 +211,5 @@ static void __exit mtk_dvfsrc_regulator_exit(void)
>>   module_exit(mtk_dvfsrc_regulator_exit);
>>   
>>   MODULE_AUTHOR("Arvin wang <arvin.wang@mediatek.com>");
>> +MODULE_DESCRIPTION("MediaTek DVFSRC regulator driver");
> 
> Can you please drop this one?
> I have a series floating that is removing this driver entirely and replacing it
> with a refactored one. Though, it has the same issue, so I'll have to send a v6.
> 
> Anyway, v5 is there:
> 
> https://lore.kernel.org/r/20240424095416.1105639-1-angelogioacchino.delregno@collabora.com

Your v5 looks fine to me:

+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_AUTHOR("Dawei Chien <dawei.chien@mediatek.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek DVFSRC driver");



