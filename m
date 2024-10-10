Return-Path: <linux-kernel+bounces-360084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECB999441
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD352847A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7C1CDFD4;
	Thu, 10 Oct 2024 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GttoVNpy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EE18C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594911; cv=none; b=kC6oPykL1rFTZFIyk7GpWJSn2cW/xKQ7b/GVbuFN+QoVf1ZBJ4yTUYmjwhcHIXNSasYCkLcgZcsKMFXE504H+FsbvHgFkUb7Q2yfL+xhi6iODi77/QLFSkZf1QIhtdvQe0LoyULHeBYqzdGLYUOA7zSGvLl9FJ0PyJ3mCOnyMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594911; c=relaxed/simple;
	bh=bumgDyRGTFiBiaIZnppbRe/eRh6TQuxM4SNxG9djhVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K12A9QH6aDNj01uSc4/lEGh/MCHWm+zaU4q4dI6k2It34YhR9t71eDpUbj92qQWHarfB9oe9m8sIhOPED4uv195pQPZ0wXqIbXBbcp0GQq0enM6LigZO6oMF8msZyJLB4jInmijxXrfSnJHwpp8k3RS4xPOHO3/Up3QlOMRbNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GttoVNpy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ACVS6v011485;
	Thu, 10 Oct 2024 21:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oOekQo7FC1Y0W0enLPIwp12z
	oNbPhtNw71yxpqAqUPE=; b=GttoVNpyPYxZSK/vDB/z7KVszTV+LMnosTmgjh6U
	z/vS5SNl+cBvGfu0NhyVoqsTkMqJRfyW50VVOqKD/ff0671zU67edAap5svjIKzd
	xhKL368Qo53Iz0z5eFUDQhHgxQmr7t8wfsUl+NmGR+05TX1GV3tLIZVPZV29C5wH
	Kr1GgPLDp5XLIS7CODHnEE6SCWWqwtsvbXMv31gKkpLCOTAw8dBwafVichPnLWZT
	0hbANES9BLPjNvdUoTYnR1nIyeI+iaSBY6+zApk7yyycOKbhA2K5c2DGzobs6bVn
	m4W6Lac9KSTCAFceL/VGgskBBmGZfRZZ9AAYeQLk80r9eQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 425xthurqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 21:14:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49ALEmpw001081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 21:14:48 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 14:14:48 -0700
Date: Thu, 10 Oct 2024 14:14:47 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Breno Leitao <leitao@debian.org>
CC: <akpm@linux-foundation.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>, Xiong Nandi <xndchn@gmail.com>,
        "Kent
 Overstreet" <kent.overstreet@linux.dev>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Carlos Llamas <cmllamas@google.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: remove trailing space
Message-ID: <20241010141343071-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20241003103009.2635627-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241003103009.2635627-1-leitao@debian.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QHNDZYEIaiOQxBwkCEGDliIjZvKL4N8d
X-Proofpoint-GUID: QHNDZYEIaiOQxBwkCEGDliIjZvKL4N8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1011 mlxlogscore=635 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100140

On Thu, Oct 03, 2024 at 03:30:05AM -0700, Breno Leitao wrote:
> decode_stacktrace.sh adds a trailing space at the end of the decoded
> stack if the module is not set (in most of the lines), which makes the
> some lines of the stack having trailing space and some others not.
> 
> Do not add an extra space at the end of the line if module is not set,
> adding consistency in output formatting.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  scripts/decode_stacktrace.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 826836d264c6..4b3502a007fd 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -311,7 +311,12 @@ handle_line() {
>  	parse_symbol # modifies $symbol
>  
>  	# Add up the line number to the symbol
> -	echo "${words[@]}" "$symbol $module"
> +	if [ -z ${module} ]

After adding the quoting as mentioned by Carlos,

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> +	then
> +		echo "${words[@]}" "$symbol"
> +	else
> +		echo "${words[@]}" "$symbol $module"
> +	fi
>  }
>  
>  while read line; do
> -- 
> 2.43.5
> 

