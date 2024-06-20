Return-Path: <linux-kernel+bounces-223112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B96E910DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98851F21BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8C1B29D7;
	Thu, 20 Jun 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nGnjGjaU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46291B3737;
	Thu, 20 Jun 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902795; cv=none; b=IkhPxqFw/YbKmqx5v4RF+Zk/veIE5VBCFDAy0Uj4rnzaZJvhUbOYYR2XiGvGnfFHdMgvmnLBjcGJQgrJIarrBHAG43SuvjmOb5qPdOKgRoZnoVyjf2cbsHgINAi7qXYeYo7XKOmTAwWGYp2uN+SE48FxMMZNHxDsOI7JgWM1W7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902795; c=relaxed/simple;
	bh=yslZy45VbYP1yW2aGMj8CUOo6xg5RYzQ5QhA06ED5ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oyOW50yBKYYpn/wucqrOyjvPsdqVX7a7xIiMH0YzKEOPCLv5ad+11mk76flijv/NtbR7exWptfzcKmAywnBnLHGZorP26IGqrpvN2B/6BsQKkbAzV7s5mpWKIW+Gb0HGh1YhKEv5DGKnzoNXoR64O1yzTHzsd93fnqUH/43/SC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nGnjGjaU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KDlrpH023990;
	Thu, 20 Jun 2024 16:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zCR8Jnol5fCH6PMiF68r+prkAGog8fq49s8XRKpLXY4=; b=nGnjGjaU9FEKTK9r
	3e/19IRRVvVMSjyK6zk0SOTYGZmDg1J9hALjR6STvws0P0tKTYlh9uMrrumk/86B
	pPYA0Tz81Y8eEoJtUGPZlIJzxF9+hInpaTGTDICeLy4DgTAXdNmQMbTmqVjZVENq
	qgpnLN8lMhZTdJfzX5/7u9zkHZBF1ZzhU1KFrf68puFv13TneTMGFecIhhC2FjCR
	qbEIkCRGjeHoW0n4ja2t2kbgdtBrBrHRU6Ooxr2O2BHhMJBsBTym+xWR51C3JzjG
	/CRnRlumR7lTr7PqVI4B61n+JO00Oy3V90YHNgjUH1cfLVzzxIW+0N+WcoUDVOns
	auoqhA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvnmh8g3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:59:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGxdwS014097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:59:39 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:59:38 -0700
Message-ID: <3767aabb-daf5-4439-b796-a20c0ee281ce@quicinc.com>
Date: Thu, 20 Jun 2024 09:59:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kfifo: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Stefani Seibold <stefani@seibold.net>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240601-md-samples-kfifo-v1-1-de34345c5fd8@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240601-md-samples-kfifo-v1-1-de34345c5fd8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ah0U9v0dIupO7eHSNDzOLMkw6PlGHOLe
X-Proofpoint-GUID: Ah0U9v0dIupO7eHSNDzOLMkw6PlGHOLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200122

On 6/1/2024 5:50 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/bytestream-example.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/dma-example.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/inttype-example.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/record-example.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  samples/kfifo/bytestream-example.c | 1 +
>  samples/kfifo/dma-example.c        | 1 +
>  samples/kfifo/inttype-example.c    | 1 +
>  samples/kfifo/record-example.c     | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/samples/kfifo/bytestream-example.c b/samples/kfifo/bytestream-example.c
> index 642d0748c169..4ae29a12cc8a 100644
> --- a/samples/kfifo/bytestream-example.c
> +++ b/samples/kfifo/bytestream-example.c
> @@ -191,5 +191,6 @@ static void __exit example_exit(void)
>  
>  module_init(example_init);
>  module_exit(example_exit);
> +MODULE_DESCRIPTION("Sample kfifo byte stream implementation");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
> diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
> index 74fe915b7ffe..48df719dac8c 100644
> --- a/samples/kfifo/dma-example.c
> +++ b/samples/kfifo/dma-example.c
> @@ -138,5 +138,6 @@ static void __exit example_exit(void)
>  
>  module_init(example_init);
>  module_exit(example_exit);
> +MODULE_DESCRIPTION("Sample fifo dma implementation");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
> diff --git a/samples/kfifo/inttype-example.c b/samples/kfifo/inttype-example.c
> index c61482ba94f4..e4f93317c5d0 100644
> --- a/samples/kfifo/inttype-example.c
> +++ b/samples/kfifo/inttype-example.c
> @@ -182,5 +182,6 @@ static void __exit example_exit(void)
>  
>  module_init(example_init);
>  module_exit(example_exit);
> +MODULE_DESCRIPTION("Sample kfifo int type implementation");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
> diff --git a/samples/kfifo/record-example.c b/samples/kfifo/record-example.c
> index e4087b2d3fc4..e4d1a2d7983c 100644
> --- a/samples/kfifo/record-example.c
> +++ b/samples/kfifo/record-example.c
> @@ -198,5 +198,6 @@ static void __exit example_exit(void)
>  
>  module_init(example_init);
>  module_exit(example_exit);
> +MODULE_DESCRIPTION("Sample dynamic sized record fifo implementation");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240601-md-samples-kfifo-40ba0aa7042f
> 

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.

Adding Andrew & Greg since they've signed off on these files in the past

/jeff

