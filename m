Return-Path: <linux-kernel+bounces-254550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0439334A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B961F21542
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F043A1442E8;
	Tue, 16 Jul 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C+sTG0f2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E86F079;
	Tue, 16 Jul 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721173439; cv=none; b=neiP833SWfZtnCekoJRqvLOTLum4YtEybwbjDNxbV3QW0QO5nEUetFsx/EoPpWCBcFBhuZzRPeEjR//JBgTRMjnijvKsg/MEDjOttVD+v8eJ6CQry1nrv2X8TZ4Ta5JwKk2aNGaNHaz8A4LPePEg0B6wEhdbscTkZkVmrbVqYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721173439; c=relaxed/simple;
	bh=JAgdu+9OpTZPi2IVaMQAqtoBaYEPT5bMQjn0wMqPYrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E2SbfoUGE9zl5OYoza7zp0F3OpFyqqkj87HEfEddhmnYsRjPAqwI/nTrtjQqt4J7RMUephcQwuhlTYez+I9zIWC++nnyaIAJ/T8AIRA4rI8omH3MZVGV6Y/w8c+MkW8gx4kog3vHlvlPmuUakwA5K5cJnGXAAukirenVRBZlQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C+sTG0f2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHf5TC027012;
	Tue, 16 Jul 2024 23:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N3QJ5/o/wDR3TZtIE94AfbmLbVWg1q+EHZ/P1r1AiVg=; b=C+sTG0f2IMrnTAlx
	4lk2QaJ4v/CcGvT5+BB4BGpLGPxpFumq8mOwZ8gnPNZInGHl+N6YXUaLmbKzDLHj
	2K7veyXTejKeunE66CPV9GkvVW4D2OGsK3W7xkpAf9hFrmAr+7eMDLDSMOuk7C5F
	4q0u2R2TYxypbZW1hi/eQMdk2YRi99/EQfzNwIO/fOCoT/bRKwkD1tyJm9IrZ5iq
	qf8w0m1c/zcyLLh7Ejuu2P/X/E3PhZyUkRXC78ctdGuN3o4vAB/mzO4Rj5ky2O/f
	9WskK7p8+NlIZgiGcwRgyczAVyL4JBR8p8c7KBE715OiYWbcWfSPPUteyC7z9Ull
	NFaZVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs0m4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 23:43:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GNhZE5003908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 23:43:35 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 16:43:34 -0700
Message-ID: <7145cd8e-590a-4260-a738-dc1a386e7787@quicinc.com>
Date: Tue, 16 Jul 2024 16:43:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmem: layouts: add U-Boot env layout
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle
	<michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-boot@lists.denx.de>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>
References: <20240715135434.24992-1-zajec5@gmail.com>
 <20240715135434.24992-2-zajec5@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715135434.24992-2-zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HjDUvP7cKZSBjai9_qJv7ION5Anjs5h9
X-Proofpoint-GUID: HjDUvP7cKZSBjai9_qJv7ION5Anjs5h9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_02,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=956
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160174

On 7/15/24 06:54, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables are stored in a specific format. Actual
> data can be placed in various storage sources (MTD, UBI volume, EEPROM,
> NVRAM, etc.).
> 
> Move all generic (NVMEM device independent) code from NVMEM device
> driver to an NVMEM layout driver. Then add a simple NVMEM layout code on
> top of it.
> 
> This allows using NVMEM layout for parsing U-Boot env data stored in any
> kind of NVMEM device.
> 
> The old NVMEM glue driver stays in place for handling bindings in the
> MTD context. To avoid code duplication it uses exported layout parsing
> function. Please note that handling MTD & NVMEM layout bindings may be
> refactored in the future.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> This change was originally sent (and approved by Miquel) as a
> [PATCH V3 6/6] nvmem: layouts: add U-Boot env layout
> 
> I just adjusted it to the approved binding and updated commit message.
> I kept Miquel's Reviewed-by tag due to minimal changes.
> 
> I've successfully tested this code using it in both ways: as NVMEM
> device driver & NVMEM layout.
> 
>   MAINTAINERS                        |   1 +
>   drivers/nvmem/Kconfig              |   3 +-
>   drivers/nvmem/layouts/Kconfig      |  11 ++
>   drivers/nvmem/layouts/Makefile     |   1 +
>   drivers/nvmem/layouts/u-boot-env.c | 203 +++++++++++++++++++++++++++++
>   drivers/nvmem/layouts/u-boot-env.h |  15 +++
>   drivers/nvmem/u-boot-env.c         | 158 +---------------------
>   7 files changed, 234 insertions(+), 158 deletions(-)
>   create mode 100644 drivers/nvmem/layouts/u-boot-env.c
>   create mode 100644 drivers/nvmem/layouts/u-boot-env.h
> 
...

> +module_nvmem_layout_driver(u_boot_env_layout);
> +
> +MODULE_AUTHOR("Rafał Miłecki");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);

Is this missing a MODULE_DESCRIPTION()?

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the 
description is missing") a module without a MODULE_DESCRIPTION() will 
result in a warning with make W=1.

I'll hopefully have all existing warnings fixed in 6.11 so please avoid 
adding new ones :)

/jeff

