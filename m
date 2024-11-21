Return-Path: <linux-kernel+bounces-416698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0F99D48ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E1B2823E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949551BC9FC;
	Thu, 21 Nov 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GtIyNnnK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF351C9EDC;
	Thu, 21 Nov 2024 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178065; cv=none; b=d4sXzi6BWqEbPG//t6bq7yFsP4cwOTgUZxPDFysyks8Chr8DkyMnycvJDvpsrwiQyqIo4zopceX8kQMxqrExqSn0BYoNolPd9VUblTkZD/AxzqDsEqW+0/ao+hXcl681q5ko6Mc0sXgqWhklRYBchqZJeiQ4pUPXTvPFaN8RCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178065; c=relaxed/simple;
	bh=Vry2g7337vu1Ft6Yb4O73qK4tSoKqYW/1AMpJXSYL18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t2B/CmriQSgHnExSseXTyLSBRbgTbuTvQ8kAq6+RplLJDqwN26jJrjZRm3V31tPr4YzoYBG7bxmDnAUIjEdULpWafsWpNc6ty2PuXUHrubXFhe/ffzM3pvWaJKxrWy7eent1bkzc49VBAmN3tGqPvBvNG15e3pV3qdQG2eTDEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GtIyNnnK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7v4Yk023179;
	Thu, 21 Nov 2024 08:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUCma6B8MbebG5Nj11w4j3yZiHg7x1/TbxHrorAQOzM=; b=GtIyNnnKDDU8r8i9
	fsl9PXnG/7Jj3uSaHqeM62XSWSnidnU5g8ABoXa6LpLbQcVyGw3/C7t5AyZbA3OT
	HYJIrg+6iuf/sdpbsyHslvwCbjWr61hDyv4gEm2HVt+HG+Zq+2zndAV/RRKwMpnx
	oO9dPrd2Zo2p2C4iYQXPmZqH1Y6avwHO2tW1LcGnQObCa5GGNoIC6KKdYPUz8gk3
	oTwSow+SNNsZRfrFUjmxDWUn8HYf5nHm4XMfyubxG9UWGUCELaDEAS6Lln9Davfc
	0sqdqATSgjdyfGbJDX3au1aR4GfPn9iCpzqQjuhBcDMP5PmE5fycdMAEQl9btoxI
	HrsRhA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320wk0468-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 08:34:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL8YFug015215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 08:34:15 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 00:34:12 -0800
Message-ID: <96bc29bf-b601-4852-ac9a-50091698529d@quicinc.com>
Date: Thu, 21 Nov 2024 14:04:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add microchip USB5807 HUB
To: Rob Herring <robh@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.656f2a13-85bf-42a3-8490-f97f2538d8c3@emailsignatures365.codetwo.com>
 <20230522074510.16367-1-mike.looijmans@topic.nl>
 <168474408440.1935852.10036260685386476051.robh@kernel.org>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <168474408440.1935852.10036260685386476051.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KlKYCdFRF9HKg7k2sQGbLC4em1auLBd7
X-Proofpoint-GUID: KlKYCdFRF9HKg7k2sQGbLC4em1auLBd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210066

Hi @Mike

Do you have plans to mainline this change?

We are using microchip hub in one of our project and we need this driver,
we have taken your change and able to enable usb hub.
Please check if you can push updated patchset addressing the comments 
from Rob.

On 5/22/2023 1:58 PM, Rob Herring wrote:
> On Mon, 22 May 2023 09:45:09 +0200, Mike Looijmans wrote:
>> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
>> This driver resets the chip, optionally allows D+/D- lines to be
>> swapped in the devicetree config, and then sends an ATTACH command to
>> put the device in operational mode.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v3:
>> Add minItems
>>
>> Changes in v2:
>> Rename to microchip,usb5807.yaml
>> Remove reset-gpios description
>> Add maxItems
>> Add vddXX-supply properties
>>
>>   .../bindings/usb/microchip,usb5807.yaml       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.example.dtb: usb-hub@2d: swap-dx-lanes: size is 32, expected 8
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230522074510.16367-1-mike.looijmans@topic.nl
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
Thanks,
Akash

