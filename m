Return-Path: <linux-kernel+bounces-346639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1163E98C70D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F881C220E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F421CCEFD;
	Tue,  1 Oct 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qULLUFVC"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DC1BBBDC;
	Tue,  1 Oct 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815969; cv=none; b=Qdclt/N9nOY7PbSU3yyNCUV51KnKj4r8tFhjX8u1I3WHI7LE5eACqaJLsa9mcPw1QtEEhZGBECHhyKBuD/OPBlsFQY66F2akFxmSr0yBfSzDYgro+9uMQcVLsLykOCg0lLauakPMvkkvyCkTO0dCPIYJ6pII+E62NiC7wnuVuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815969; c=relaxed/simple;
	bh=gLU95uxMNh4+B26hlDjhsU3mhgoZ4qh5cBeKUtmW10U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuFsXH9hkRf3d4T+/AM0YHSmgaCxJ6+ExnKsM+hFZbYKILPo1Qr2Prd/T9SlX8UhMyOtwOqGeBmSGqssQszDtucBu07ptxXAQdgVLTtwYKjG+SfcAx+qXc38oCpazuSSzZ0AkQs2LqaN6sHEjZDY0W35wokg3cHVkKAgD/sCIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qULLUFVC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491KqYEi010830;
	Tue, 1 Oct 2024 20:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=r
	ooI+IAD5MvdFCFwtLHhq3xYNtHGUAW5X4cbhbuFckI=; b=qULLUFVCBLeUUjIn9
	doQIiqugJfYpJ5Tf3w+IIS9M8Pm4MmpyRmXjaiasietpRkyXWRFLozXqAKH4+B71
	gjlSysbS9dKbSq+ug5TxOWL0vARjq0cak9OZHSi27+5q7UVnlZAZRt7aHz8fBjc8
	s8FA+ITEDPTvwBCupVzlVnx5/YPWttOXjidSDr6TgqmVSapiKFA4UbMOm5ClOAE1
	0LbJ/NbVoUDKlsykLIeM07k9t9+ePGG3KmufkPi7PWUNeBCj57wffXJHp+E+YV08
	zpUFEVv5D/YmIN6bHs2ZkoAcRkMo/iaVSoogkJHRLAVMFN49EyvE63GXfAu0WZxL
	p1Fbw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420qyq03fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 20:52:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491JspeN002346;
	Tue, 1 Oct 2024 20:48:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu169xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 20:48:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491Kmd4v32768332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 20:48:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64CD158059;
	Tue,  1 Oct 2024 20:48:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE41A5805D;
	Tue,  1 Oct 2024 20:48:38 +0000 (GMT)
Received: from [9.61.115.177] (unknown [9.61.115.177])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 20:48:38 +0000 (GMT)
Message-ID: <dabd422e-4ec1-48a7-9841-9faf4137820e@linux.ibm.com>
Date: Tue, 1 Oct 2024 15:48:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] ARM: dts: aspeed: system1: Bump up i2c busses freq
To: Ninad Palsule <ninad@linux.ibm.com>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20241001191756.234096-1-ninad@linux.ibm.com>
 <20241001191756.234096-2-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20241001191756.234096-2-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WFi6jJaaitELYhhUkqrANDnF_zjgqZcP
X-Proofpoint-ORIG-GUID: WFi6jJaaitELYhhUkqrANDnF_zjgqZcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=792
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2410010138


On 10/1/24 14:17, Ninad Palsule wrote:
> Bump up i2c8 and i2c15 bus frequency so that PCIe slot and FPGA runs
> faster


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index f3efecc7eb8d0..1cbf257fb0a0b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -1007,6 +1007,7 @@ i2c7mux0chn7: i2c@7 {
>   
>   &i2c8 {
>   	status = "okay";
> +	bus-frequency = <400000>;
>   
>   	i2c-mux@71 {
>   		compatible = "nxp,pca9548";
> @@ -1468,6 +1469,7 @@ i2c14mux0chn7: i2c@7 {
>   
>   &i2c15 {
>   	status = "okay";
> +	bus-frequency = <400000>;
>   
>   	i2c-mux@71 {
>   		compatible = "nxp,pca9548";

