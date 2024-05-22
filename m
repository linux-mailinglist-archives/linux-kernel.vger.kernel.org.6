Return-Path: <linux-kernel+bounces-185705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F668CB91B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE74281822
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C72A1AA;
	Wed, 22 May 2024 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bqnYvvHF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C55234
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346138; cv=none; b=U0JyjWCGuX2pT37yCx0qkuWoH3g5LXy7T1iDz6ucaP9G4+wdr9VIeJOqRYZcInc1YBE0Pt1srf5OnbyVVkPeyVmW0bQFe6VDp4lNaV9Jzs24r1YLT4+TnLbo4zxFY1MX9CkCTH8tvn7Cx3AB4EznPE5fMB2TZ4EGVHN0J6qaFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346138; c=relaxed/simple;
	bh=FXn+sW2b8pPqs9iRjnbpeOqZcaBe8BKOgcf5H+CLA1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzkHCsxNo8DrW7ziLwbaUFzwFrqJA3MtHCmtzCmoa/fVaToicjNiwa2medSqRcXONDhdwMwlTcfiEmHKI/Emuc0fRjIYEnusNUXiifrrA10HBrGnaaaNa0rGdMDE6ghYTibixEAXBHabszWF8jjRU99BluAqDh040a/+iF9TuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bqnYvvHF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M2acGh024457;
	Wed, 22 May 2024 02:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=KZVjtFqG2zUl61nuJqUPa
	eabQtJxILRk3ZoCdA3MJaI=; b=bqnYvvHFfHKvH8mKNYQRLlM/NtZBpx65nS4/D
	nEHoAdwtPScIvQwXuv4kpT21FH6iUxgWBj2AYQZAv/VNkUSN1BmkbrS6Sa5vglAh
	8Z2FTDXSGzVhdw+HgoMml1Pcw+2IfGFE76Lc3eNKmHbWKZ7xjfVto6RtARf55ilX
	JVwod/ojiQEZiwPO/MLgREdh+qQBxLp7Y7PmNW3uRig1lshbYmaG1NQg7p52Y0wQ
	G4NGAlWAYlx1D/qJKSSBiNA+AwT0pHDkdfl1rkZZkbtApB/zvADFGbkEEZxa5INv
	/zTGg5OcbFqtpsCV7u6AL8TC/mb+np7p8P2rH2UFvc6HY2mCw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psnfemw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 02:48:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44M2moHl016238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 02:48:50 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 May 2024 19:48:50 -0700
Date: Tue, 21 May 2024 19:48:50 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Xiong Nandi <xndchn@gmail.com>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <quic_bjorande@quicinc.com>, <cmllamas@google.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: better support to ARM32
 module stack trace
Message-ID: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240521005649.12144-1-xndchn@gmail.com>
 <20240522010559.10551-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522010559.10551-1-xndchn@gmail.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GJw0aVTj1GalgJdFY1fA86zvO109Ynwd
X-Proofpoint-ORIG-GUID: GJw0aVTj1GalgJdFY1fA86zvO109Ynwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_01,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=675 clxscore=1011 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220019

On Wed, May 22, 2024 at 09:05:59AM +0800, Xiong Nandi wrote:
> Sorry about the name, it is some kind of abbreviation. So I re-post here:
> ---
> Since System.map is generated by cross-compile nm tool, we should use it
> here too. Otherwise host nm may not recognize thumb2 function address well.
> 
> Beside, sometimes special characters around module name, such as ARM32
> with BACKTRACE_VERBOSE in "(%pS)" format, such as:
> [<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000 [test])
> 
> After stripping other characters around "[module]", it can be finally decoded:
> (dump_stack_lvl) from hello_init (/foo/test.c:10) test
> 
> Signed-off-by: Xiong Nandi <xndchn@gmail.com>
> ---
>  scripts/decode_stacktrace.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index fa5be6f57b00..324e4a6c260a 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -30,6 +30,7 @@ fi
>  
>  READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
>  ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
> +NM=${UTIL_PREFIX}nm${UTIL_SUFFIX}
>  
>  if [[ $1 == "-r" ]] ; then
>  	vmlinux=""
> @@ -158,7 +159,7 @@ parse_symbol() {
>  	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
>  		local base_addr=${cache[$module,$name]}
>  	else
> -		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
> +		local base_addr=$(${NM} "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')

The nm parts should be a separate patch.

>  		if [[ $base_addr == "" ]] ; then
>  			# address not found
>  			return
> @@ -282,8 +283,8 @@ handle_line() {
>  
>  	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
>  		module=${words[$last]}
> -		module=${module#\[}
> -		module=${module%\]}
> +		module=${module#*\[}
> +		module=${module%\]*}

I need to get a moment to play with it. Is my understanding correct that
the problem is that the last word ($module) is:

[test])

and after the existing strip logic, $module becomes test]) whereas
expecting just "test"? Your change is to strip any leading/trailing
characters before/after the [ / ] respectively? Isn't this a problem for
$symbol as well -- it would be "(hello_init+0x13/0x1000" in the example.

- Elliot

>  		modbuildid=${module#* }
>  		module=${module% *}
>  		if [[ $modbuildid == $module ]]; then
> -- 
> 2.25.1
> 

