Return-Path: <linux-kernel+bounces-202917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E78FD2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634D51C214C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56744188CDF;
	Wed,  5 Jun 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbbDkeVD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD731155C9E;
	Wed,  5 Jun 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605006; cv=none; b=Ww/JQ0MR0ellWAkdQUka9yAS8vic682ueCh7tVJABeYQGS82hB3xhm5z0+QcEn7geEH9er4PS7xs4H6v7mF8IK+OurRZf/mISKc9yYpYVggFF8be6UDyRiTyrL7v+995LvgSoH0vI0Iqoz5kVJ3el37IHjESYwXwqyAkawah6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605006; c=relaxed/simple;
	bh=Uk4F6huVa5XVCebhX4m3GtY249tQ2fZnfXToD3W0gNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czcznLr9hxEcU7X1aqnIBXX2YA6qF10ADMd//AACqYP6uaFxjJGwc5YEOJhUSenacIuTugSN1IWsy8ASW/4s89yuH7pVl4uOxrbvmumpY3p032dHKwG3icdR9A8lEFlIy6zteYMb9ORSPOE9L3iyccqWfQMPUg8j6dGvNS7Ywek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbbDkeVD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455GPYHc026406;
	Wed, 5 Jun 2024 16:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=jZInZY8/J56xPzD+Z72XOMl6Q8n4CzYCLULVHfxks0w=;
 b=pbbDkeVDYnQOEC4YIE+adlpvOqtfdXDg/TMoGt/vWCfFN/KuJ/8WIF2qb5frsliAnzsJ
 CGmq4h+zrcgmUvoKKUmP0Siajdl/UGIiCRHvnjN2ko54e+lw51XjWJKtDBguqLIttMBf
 REDhEsdLU8OJ8QQqZAW5kp0Rx2nQJzBr3Y4KAXipBI3qV5HQ9WeO5MRd+jvlrIXfx0g3
 CqjQpBMpzEX0D1UpswkZBPoGpb8nCDq0j3DDw3CbLCZnroZZC+RMG7943qJniUpZf0JS
 rNR7Wh1i0cLN0InMzpmjDlTDvg6IVBVtTk13bjd1GimxjjBuWjvc3LHT662teFyqRvkp Qw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yju1j84c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:29:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 455GMbRF026899;
	Wed, 5 Jun 2024 16:29:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffn53su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:29:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 455GThAo59441408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 16:29:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB5858045;
	Wed,  5 Jun 2024 16:29:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E18CD58054;
	Wed,  5 Jun 2024 16:29:42 +0000 (GMT)
Received: from [9.61.121.242] (unknown [9.61.121.242])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Jun 2024 16:29:42 +0000 (GMT)
Message-ID: <4c0eddbf-5397-490c-8c70-a581c7949b49@linux.ibm.com>
Date: Wed, 5 Jun 2024 11:29:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: aspeed: System1: Updates to BMC board
To: Ninad Palsule <ninad@linux.ibm.com>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240605160604.2135840-1-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20240605160604.2135840-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DWBAAnD3eDYp6YEr3NCd0y8b3QDf_7B-
X-Proofpoint-ORIG-GUID: DWBAAnD3eDYp6YEr3NCd0y8b3QDf_7B-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxlogscore=809
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406050124


On 6/5/24 11:06, Ninad Palsule wrote:
> - Changed temperature sensor monitor chip from tmp423 to tmp432


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index dcbc16308ab50..f3efecc7eb8d0 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -1138,7 +1138,7 @@ i2c8mux0chn6: i2c@6 {
>   			reg = <6>;
>   
>   			temperature-sensor@4c {
> -				compatible = "ti,tmp423";
> +				compatible = "ti,tmp432";
>   				reg = <0x4c>;
>   			};
>   		};
> @@ -1599,7 +1599,7 @@ i2c15mux0chn6: i2c@6 {
>   			reg = <6>;
>   
>   			temperature-sensor@4c {
> -				compatible = "ti,tmp423";
> +				compatible = "ti,tmp432";
>   				reg = <0x4c>;
>   			};
>   		};
> @@ -1615,7 +1615,7 @@ regulator@40 {
>   			};
>   
>   			temperature-sensor@4c {
> -				compatible = "ti,tmp423";
> +				compatible = "ti,tmp432";
>   				reg = <0x4c>;
>   			};
>   		};

