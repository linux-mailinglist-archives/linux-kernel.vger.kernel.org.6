Return-Path: <linux-kernel+bounces-346636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252598C700
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A31C22133
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A41CCECF;
	Tue,  1 Oct 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IvtO6703"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC87194A43;
	Tue,  1 Oct 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815790; cv=none; b=MbmCjdBD+JUhj/AZupS1ETbioiH41AFo534JNEy/iCSV4spERe+rl9VSlcQYiXKXkstaOokrgi2CJABJAvjOPTPTnT1O0bUMpd4UTYr5fjX7XVyGzv9o5r1PrqvaZ/LSIvgQe3Lqf/LxfW006BI6TCCTs1Iq1lIHcryxGWxKndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815790; c=relaxed/simple;
	bh=JyDo3knD1EFDqzAusXkgpM8ACQ5ic7nRKE2t1wYX6Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqnyuNMaqS/5/KwLduTrYO+AqBl3N06HRiXkDCymfDecx6Pkt/lwdFWmLrIDHOpWK3xfW3D6zaw/ojVbM/A3/fLm7NSlzrVTdWG21ryFKWoumpNNGU4mcdVD7DEnCArmjiM+5PajbS9/sy6dzBuD2WSkt9/5RickB9f3KK4eb7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IvtO6703; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491KNUvq018120;
	Tue, 1 Oct 2024 20:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=R
	VUctId8N8zdwF8Tjcg+NHQHHDQSbDQZsrQMS6bWH/Y=; b=IvtO6703ybOZK+jlk
	xkD31VS+iD3eqEMPnb1ENNzZpvQgohOcmJ+yrmUpv1NsqP1xlFYeiP0R5ZUSxaAR
	VBVs4OSd5FQcUYzrW6c1hORyNk7XOuwYEK4RBiZmYbn0S2QVUjcpRSH1DzmbLBzg
	zEth8hv4bM7kUzvaQ6/sMYRrN3uiGGy4t6z2XUchA97WWKiGjIvdJywpBxlfjJ+H
	aCWaWjunXdlwSvWo40nNCZ9LsAwNox/awRuLOtZwylhYq039SC/uiPKTXSyNb/So
	Bmc+yKeq3F8U4DjpbFUBbKx/uwyzKDyuuHc/nF4jOZDNz3nYdAQWqziPx7J6wZ5x
	BMJmA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420r2rg2jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 20:49:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491IjFOE014151;
	Tue, 1 Oct 2024 20:49:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk6hpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 20:49:29 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491KnSNR5440186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 20:49:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE3B5805D;
	Tue,  1 Oct 2024 20:49:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0C758059;
	Tue,  1 Oct 2024 20:49:28 +0000 (GMT)
Received: from [9.61.115.177] (unknown [9.61.115.177])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 20:49:28 +0000 (GMT)
Message-ID: <6b1a98c5-6184-48d2-86e5-1ca8f44b5fc0@linux.ibm.com>
Date: Tue, 1 Oct 2024 15:49:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] ARM: dts: aspeed: system1: Enable serial gpio0
To: Ninad Palsule <ninad@linux.ibm.com>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20241001191756.234096-1-ninad@linux.ibm.com>
 <20241001191756.234096-3-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20241001191756.234096-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -PAj4LzxBdn-jCnjAmt3t34IM3C6T9RE
X-Proofpoint-ORIG-GUID: -PAj4LzxBdn-jCnjAmt3t34IM3C6T9RE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=785
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2410010138


On 10/1/24 14:17, Ninad Palsule wrote:
> Enable serial GPIO0. Set number of GPIO lines to 128 and bus frequency
> to 1MHz.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 1cbf257fb0a0b..c0219167a337a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -398,6 +398,12 @@ &emmc {
>   	clk-phase-mmc-hs200 = <180>, <180>;
>   };
>   
> +&sgpiom0 {
> +	status = "okay";
> +	ngpios = <128>;
> +	bus-frequency = <1000000>;
> +};
> +
>   &ibt {
>   	status = "okay";
>   };

