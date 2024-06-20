Return-Path: <linux-kernel+bounces-223072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17F910D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BD9289B20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32A1B5803;
	Thu, 20 Jun 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DkfI6Ctt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A81B4C33;
	Thu, 20 Jun 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901235; cv=none; b=s3GYQYWDfoAWDCo7uPVQg2Qtf/2y2mxxi9pB2UrXWH+jSGTNVWmSsQGQrO1/KUwuJGbvmX/bTr97UaKkUWCTEvs39yQZ4adaTYheAJiYTdQIBXGYfY8GLYbzpzYGOPzzSqhSBVuEL39bkwS17rNPti2yuOcwP6VFUXJLnugQSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901235; c=relaxed/simple;
	bh=RNgUpp5ngH8wYl2qfQFqUuFadetFFxrM2HUEsdCjH1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mz/4fWAMY/r+m7rTozIJbdrRL+UP60Cfv5sgnOd126ce1wWGL3usDlJNqUP97jooWXIXmL+18ZJ2TyjBoFVN3GP7b66ggzdMXUtUD0rubiXnvsCSNewxZfisEhZ6EisMjUaPs+BZSdv+kKgPU1MibNTsHWRzdhNH0OfIYwKTTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DkfI6Ctt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9v8vL002503;
	Thu, 20 Jun 2024 16:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oh/CAC/sDqIIlPrHKU8LYuixNaVaNu3PjAR2BFS9aFg=; b=DkfI6Ctty/GbJbTX
	LzyiC/JzyFgAHgoED9p6Zq2ie+mVQzr1tQNqQ62EtSNhAhb7KQvBpmb2k/IjVf5U
	afV9TVnNXfiVYX09WJ2PBzvM7S2LneTHsD/gLGjYVL9hmy3wvSjr/Hr2Y43544rN
	TZ6BpKKv7INrieMcpberhp8auUU5ybFoMVxkpKwwyDb+SE/D9kfrtldYHAUOul+m
	SvUbz7nwu/TPMTq5BtXMAaJYZyeIth9dj33kS+T5gl/CoorUkzcu1y/GMHvCBJbc
	fJxcKzjRLLRz4VmaxdeIfnvsv3e7QeW43/xrWwVgATaKN5t9MRv6S9XvF1dVY12p
	MABTGw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvaqbsxrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:33:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGXnX0010689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:33:49 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:33:48 -0700
Message-ID: <c6c9b27d-7c5e-416f-9c22-20da9416e72c@quicinc.com>
Date: Thu, 20 Jun 2024 09:33:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_th: msu-sink: add missing MODULE_DESCRIPTION()
Content-Language: en-US
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240530-md-intel_th_msu_sink-v1-1-ae796336e7b9@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240530-md-intel_th_msu_sink-v1-1-ae796336e7b9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 034CuY6Z8DpznfTk1ljTHjyuwYcXXTsg
X-Proofpoint-ORIG-GUID: 034CuY6Z8DpznfTk1ljTHjyuwYcXXTsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200119

On 5/30/2024 9:55 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/hwtracing/intel_th/msu-sink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/intel_th/msu-sink.c
> index 891b28ea25fe..256ce3260ad9 100644
> --- a/drivers/hwtracing/intel_th/msu-sink.c
> +++ b/drivers/hwtracing/intel_th/msu-sink.c
> @@ -116,4 +116,5 @@ static const struct msu_buffer sink_mbuf = {
>  
>  module_intel_th_msu_buffer(sink_mbuf);
>  
> +MODULE_DESCRIPTION("example software sink buffer for Intel TH MSU");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240530-md-intel_th_msu_sink-12db94b5c088
> 
Following up to see if anything else is needed to get this merged.
Adding Greg since he's signed off on this file in the past.

/jeff

