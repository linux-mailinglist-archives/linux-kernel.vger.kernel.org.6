Return-Path: <linux-kernel+bounces-186896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580F8CCA89
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7E2B214E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AA4685;
	Thu, 23 May 2024 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z76hBx5t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC01A34
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429401; cv=none; b=c0loQ8PlRaQNDT4gmK6obXuHkTXkCw+/VJBe735pQwFu9c91tucsX3aKxk3q9ZQMIsbdXQWBROi6DVKYnOForEGv8YkbtxHfPPthF03N3O0uh6aAidtkOQ3//k0Zw96IFp0Kh0GSWSkDuu7KvAzWFTOoumK/XbqqSOBO9Xz0QMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429401; c=relaxed/simple;
	bh=odqsliIp1bqB03SOjUukVLUc8qbuCHFi+9Xo8awy+IQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTP1tCAAS22Ju08NgncvhAs9GJHO7VCb0IosgNq2LBW8JkQkViN56m2+CKwFvQ9cQ+9TavqWz0GzG6f6h3zme7/4omsr1yGtZ+QbNIi3JDaXfPoI71ciC0uWCSKyfDJKOadg91wNjoKvJoqu2g+/eRqeA0IIdbNkDptpjVHihvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z76hBx5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MHXLut010132;
	Thu, 23 May 2024 01:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=xCFv3e6r0rcQyZLLSdgTL
	+V8y45gOmc5gjoqM82CGt0=; b=Z76hBx5tMQsXewixk7qlbnkp0tSSEp/llANtO
	iqFW/9IZr2GGIJCHNxn7TGGJw0VX6FMj0UunwDqVFb+X5MHkTMQ3svGcJS8VUbVt
	RGXIs3Eixcq/AIDegYWfMvhPVpp8/DaKU7ukMfk0tMfF7mrioEbcg+LtLG14M8+V
	reBBcPWMSyI1vWX1CGzr6FttY5PntQeRI7CzNIOexUDb3mHzkSSCBdthXKP8RTkF
	65UHkVRB3A/0K2mtR/eq5R0jtYSW8874FV7wXSYN6f/RDpEP/NLFcuElWexr32Wy
	O+ljcUqvf+bQRfcBB0pFfTI957B74HElk8aX4+bT0qC1sO8OQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqat8tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 01:56:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N1uYN6009240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 01:56:34 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 18:56:34 -0700
Date: Wed, 22 May 2024 18:56:34 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Xiong Nandi <xndchn@gmail.com>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <quic_bjorande@quicinc.com>, <cmllamas@google.com>
Subject: Re: [PATCH v2 1/2] scripts/decode_stacktrace.sh: wrap nm with
 UTIL_PREFIX and UTIL_SUFFIX
Message-ID: <20240522185039245-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240523010318.12934-1-xndchn@gmail.com>
 <20240523010318.12934-2-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523010318.12934-2-xndchn@gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tX6hcs2pQ3mkCwgg2uFScb_dj3eDzK8q
X-Proofpoint-ORIG-GUID: tX6hcs2pQ3mkCwgg2uFScb_dj3eDzK8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_14,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=475 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405230012

On Thu, May 23, 2024 at 09:03:17AM +0800, Xiong Nandi wrote:
> Since System.map is generated by cross-compile nm tool, we should use it here
> too. Otherwise host nm may not recognize ARM Thumb-2 instruction address well.
> 
> Signed-off-by: Xiong Nandi <xndchn@gmail.com>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  scripts/decode_stacktrace.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index fa5be6f57b00..2bc3a54ffba5 100755
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
>  		if [[ $base_addr == "" ]] ; then
>  			# address not found
>  			return
> -- 
> 2.25.1
> 

