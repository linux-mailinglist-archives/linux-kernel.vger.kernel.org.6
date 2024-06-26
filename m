Return-Path: <linux-kernel+bounces-231215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561949187C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1411F2418C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47A18FDC8;
	Wed, 26 Jun 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jDlnClEO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963018FC6C;
	Wed, 26 Jun 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420264; cv=none; b=j0aep3E2oT7c4hcQfUv5J186EZfZpNSaX+eYFmx9zNLm2sg2WlcZxlMNP1VNmp4UNCgSoUBkGbler3WXkV1dlrg2ht9vn0UkLrb3xmA7MYs9eKZUs4g0tvU8xpNuz6ZmKlKh7KdTvCE2ckJh3yOw08CBOhydPS1jVzbyoSH/9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420264; c=relaxed/simple;
	bh=At/qzozbLfAvFw7+L0WhPfrEf4RSfQ2LAtdp3gpHQ6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZS2bdSAn8HBzR+VM3aRpWH1yFonvfBi0mA8IkllgRYE9FAuj/gWF4mKRNcjJZTBpqEAC/A1UWdqZ2qBJLjPat94zRoofW4S1ANdqXjTI3DoqPb5l+CpIEJK72PNm/QQUQxDqeeEjYR0YQQG2FowKOybfLXTZMaw4LqdcoXk/+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jDlnClEO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfSw6029244;
	Wed, 26 Jun 2024 16:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5/6C5SdG8OI18Y+HiCARcvjCdehBUsFZqN0lGsXWb/c=; b=jDlnClEOY+mpkt8M
	cjbMckXocnvCe4AWgsGChJbnTE6P1zLzYXo/JzQIVIDL2et/mctBCM/k7V0nUtgF
	vpnext7yh1kHOwPWc1iRvDEE0080KTxZ6Wiw5PrxrsuBKtKy+SAwqnxkt0azv8Hw
	xDw1x7ytYq7Jsa6kwjcA8R6n4v0ZUvRrFdWuZRP5/j/IlSiBorIxRw5gdLVQ2dx/
	Y6/tjL4yLnvo4Djsoo4eSn5EFk+xuGbEmTn8OlVz7lEk3EzQpxo5KpON/Im7F7Io
	DDw2xi1xr+feYsm2UNq3c53BZiI7kXUelP1wM1zB8cBFraO0ypqyEpLiJQPdF/9s
	tqAjug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6su9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:44:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QGiI46015849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:44:18 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:44:17 -0700
Message-ID: <3306a32f-3f15-40d8-8789-c1ae101d594c@quicinc.com>
Date: Wed, 26 Jun 2024 09:44:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611-md-drivers-usb-serial-v1-1-c6ada535890a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 19t7o3sv68TS96iTKNO1gg5WuerclBd7
X-Proofpoint-ORIG-GUID: 19t7o3sv68TS96iTKNO1gg5WuerclBd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=698 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260122

On 6/11/2024 10:52 AM, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/usb/serial/ch341.c             | 1 +
>  drivers/usb/serial/mxuport.c           | 1 +
>  drivers/usb/serial/navman.c            | 1 +
>  drivers/usb/serial/qcaux.c             | 1 +
>  drivers/usb/serial/symbolserial.c      | 1 +
>  drivers/usb/serial/usb-serial-simple.c | 1 +
>  drivers/usb/serial/usb_debug.c         | 1 +
>  7 files changed, 7 insertions(+)

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

