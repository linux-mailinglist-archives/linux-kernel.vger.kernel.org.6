Return-Path: <linux-kernel+bounces-186898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F98CCA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C971C20DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60004C7E;
	Thu, 23 May 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T/7Y40EX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0229AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429637; cv=none; b=elqGSRdT+YEFyl7igGeTeIt1NLQkxrX2FzqrvCQHNH6qI71yUMikFS9FEK8pnE/WF+X35zF8ul93T7SKeKhVTJLz+6hNB4IYLIQ5daK2L1zCxryUxcu/ZgrpOwJWzmMMS+4vQ2s+fQg1ov2TAEMAYOkkMhi5AMoLoCJXkfaho7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429637; c=relaxed/simple;
	bh=5LuGAZn2G3frjwFiOv9YFsKhgCgVPleiTQXpWm6omWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORmgFDbua8pPsF7GfhDxc0nyAU/XJPSC7NKRPqHkdP54NVlmwUfrG67WlVy9/ZcRMuvPaxfHT6aJ8Cn/1wSJLnRpdH+gWdsxmN3/2YKcLCQyteR4Am6gKvXbIgXjIQrt5YmW6AbWzXJhQ0cmEzS/UQAAd6GVCBeGVd3kfIgn03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T/7Y40EX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MMlVAQ021900;
	Thu, 23 May 2024 02:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=+LiIFNnp6+uDCpIGI0uQw
	zsJP44iemqQPuHh35TTH/4=; b=T/7Y40EXa5Aunn831lSIzB8/MchWN4FhKZqpE
	TkUQVGHEKj2/WDyvXybYE9XcZax8Nt9EUDu8R1BpD7lvybwJc4kP/MKzILjRQP8V
	8k7au/LSkLyTMHVMlPKSYcAfbdgftzqyFIER9m9Y+e3agidJsigrQnxGSsBqloEm
	2iG7qv21TpBZh7eBRX+wowrMgB/GtH97k1ATIAmeBSIM1nvNQgAXzN9YZQmx87US
	V1O+dRm51YcvcLnuqrv/8rqgw/8DTfn+n4k3SJ1N6tkVLhQ6L/Z8Yvx3+EMiX+kg
	oKv6pdn4UQt2Az/BCQftl5MmBS1V2g5E/oNOKbwGjP3KwGAiA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pr2tcwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 02:00:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N20V5b024652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 02:00:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 19:00:30 -0700
Date: Wed, 22 May 2024 19:00:30 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Xiong Nandi <xndchn@gmail.com>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <quic_bjorande@quicinc.com>, <cmllamas@google.com>
Subject: Re: [PATCH v2 2/2] scripts/decode_stacktrace.sh: better support to
 ARM32 module stack trace
Message-ID: <20240522185741891-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240523010318.12934-1-xndchn@gmail.com>
 <20240523010318.12934-3-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523010318.12934-3-xndchn@gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SnbSIRKPCwKH0CNOIzPaKPfb-F7DeyVb
X-Proofpoint-GUID: SnbSIRKPCwKH0CNOIzPaKPfb-F7DeyVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_14,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=651 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230012

On Thu, May 23, 2024 at 09:03:18AM +0800, Xiong Nandi wrote:
> Sometimes there is special characters around module name in stack trace,
> such as ARM32 with BACKTRACE_VERBOSE in "(%pS)" format, such as:
> [<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000 [test])
> 
> After stripping other characters around "[module]", it can be finally decoded:
> (dump_stack_lvl) from hello_init (/foo/test.c:10) test
> 
> Signed-off-by: Xiong Nandi <xndchn@gmail.com>
> ---
>  scripts/decode_stacktrace.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 2bc3a54ffba5..324e4a6c260a 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -283,8 +283,8 @@ handle_line() {
>  
>  	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
>  		module=${words[$last]}
> -		module=${module#\[}
> -		module=${module%\]}
> +		module=${module#*\[}
> +		module=${module%\]*}

I think it'd be better to just remove the parenthesis similar to how is
done in the symbol name.

That is:

		module=${words[$last]}
		module=${module#\[}
		module=${module%\]}
		# some nice comment explaining only the closing paren is
		# need to be stripped
		module=${module%\)}
		modbuildid=${module#* }

>  		modbuildid=${module#* }
>  		module=${module% *}
>  		if [[ $modbuildid == $module ]]; then
> -- 
> 2.25.1
> 

