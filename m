Return-Path: <linux-kernel+bounces-571444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E111FA6BD43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7045C16736E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49C1D79A3;
	Fri, 21 Mar 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfZoLcI6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48821191484;
	Fri, 21 Mar 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567861; cv=none; b=eK1Ro1urkLb0E09eSeUKVoODXk0+ZTNXiRQbNzmP6cBWA/7HdewiOH140a5RjqxH7c1nneFP0LWZt1mq0Q8YSL42CLDVud8IgtOFdR22agLAtFqfu5145D/dOzMkeNU+GcyK/MJpJyLrEV/mUZTYE2Li5LmjzZ4briqwvJrhlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567861; c=relaxed/simple;
	bh=JofJA9YIAu8ZNlMBVwcqyxuF4uUm1QL2UdVB33tJMBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KdNQRDRY0+jpaYmM24Wvkr6s3RaACpfKMn1cETdi0A6rSUagxtoW+19fpoliXmwMZndXzVJWOxFoQw0qMuHwC9g5Yc1V9E2r4zx4mvkwlOUE5gMdirl8geu+L0DlM5IhW/YXnLukSwJtFBtLKljQpZNfqE2ea/wlIQdUGo8yKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfZoLcI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATEER031803;
	Fri, 21 Mar 2025 14:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lUAuubmhP/bAgXWQaiCREHxXWbMHCn3WKpV9q57SXdk=; b=cfZoLcI6hOuqbkYM
	RJbQINSNj8Y0/DFE+IguY2WfAbFWf4skwfZTlrciWzr+M6zrVxrpYxHwPtxvxFKz
	GupoPjJN4R5ggnfO2SO3hMFJKLcCGN236KCEv5r0phMve4WoMgAAkhJ7cB6rBEk1
	SPk7Rnclqt/e8AcLmtAWFrVvJptrWcjkpO07OszwNdCMmcoCptKU/7KRias5bOGL
	pAWjSiSCGICQMzJqPXvxgDGjsOT8Sr2pKPg4YnlUCGiodFefl8GlXWUO7dvzRXtG
	VRSCK2M4ssTHDUNlwnHTK5RZxGyyG8RtfI9qnE+T0Q6A0LkHQ6SV8xlGsc4LdeEs
	D3r4sA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gt5kjfc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 14:37:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52LEbVTd032366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 14:37:31 GMT
Received: from [10.111.179.44] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Mar
 2025 07:37:30 -0700
Message-ID: <acbe5688-9be4-489b-8a9c-4950dc3b8133@quicinc.com>
Date: Fri, 21 Mar 2025 07:37:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [greybus-dev] [PATCH] staging: greybus: fix line length issue
To: ErickKaranja <karanja99erick@gmail.com>, <hvaibhav.linux@gmail.com>,
        <johan@kernel.org>, <elder@kernel.org>, <gregkh@linuxfoundation.org>,
        <outreachy@lists.linux.dev>
CC: <greybus-dev@lists.linaro.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20250321115545.24468-1-karanja99erick@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250321115545.24468-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N3pmzDtsjdnERo5NIcyFkfj6JxdhvGaw
X-Proofpoint-ORIG-GUID: N3pmzDtsjdnERo5NIcyFkfj6JxdhvGaw
X-Authority-Analysis: v=2.4 cv=PsuTbxM3 c=1 sm=1 tr=0 ts=67dd79ac cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=UII2AE8if6k0RuonElUA:9
 a=QEXdDO2ut3YA:10 a=KpMAsf9diV4A:10 a=ftr0zfsHvHYA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210106

On 3/21/2025 4:55 AM, ErickKaranja wrote:
> Fix line length exceeding 100 columns in arche-platform.c. The code now
> follows Linux kernel coding style guidelines by keeping lines under the
> maximum allowed length of 100 characters.
> 
> Reported by checkpatch:
> 
> CHECK: line length of 101 exceeds 100 columns
> 
> Signed-off-by: ErickKaranja <karanja99erick@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index d48464390f58..1a82a7a3991c 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -179,8 +179,8 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  				 */
>  				if (arche_pdata->wake_detect_state !=
>  						WD_STATE_COLDBOOT_START) {
> -					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> +					arche_platform_set_wake_detect_state
> +						(arche_pdata, WD_STATE_COLDBOOT_TRIG);
>  					spin_unlock_irqrestore(&arche_pdata->wake_lock,
>  							       flags);
>  					return IRQ_WAKE_THREAD;

I see you already received some good feedback. However I think the most
important feedback wasn't given, namely that checkpatch performs rigorous
enforcement of Coding Style guidelines that themselves are not always rigorous.

For line length the Coding Style still says the "preferred limit" is 80
columns. But whether it is 80 or 100, the Coding Style has this very important
caveat: Statements longer than [the limit] should be broken into sensible
chunks, unless exceeding [the limit] significantly increases readability.

<https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings>

Obviously this is subjective, but for me the original code is significantly
more readable than the patched code.

So the takeaway is that not every checkpatch issue should be "fixed".

/jeff

