Return-Path: <linux-kernel+bounces-223091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A286C910D71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DC6B22351
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDBE1B29CE;
	Thu, 20 Jun 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fegmP9DW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC3156256;
	Thu, 20 Jun 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902023; cv=none; b=Ds0Osn90suaCMVolTReRbUAMekjd3PFrmP/Pn3zjve0ypKQ8jj/FAvyqMPzBIHC/IO0SQHsxfIANKMnuEEjZ0jaV0HW8ofp1+RKqAgl2UKW9wdp64xcgG7+m2bak3oSD9hwcMxrf4YwNmPci0DtNVRv2R+2DVbXAorkIfjUr2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902023; c=relaxed/simple;
	bh=epXh3rLE7y9mqyDYLfmkgLGfYFG75JXwTtv8UWZ2l/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u5TOAFg1Y1HOJIBGmiN8CvtVcQe+cS4YZm0c4BbGcB4ieh4kp0DRd3My26kB3MyezxxCFXfzA8u0mF1C4l9aeTNR4VtuPymZQww/w0s4dAlOK6rV54O/G3R7bzNS8D2G1vqI6l2v11Q+01THcYRkUR62VAxQsUccWemitXoNE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fegmP9DW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9v4CR028203;
	Thu, 20 Jun 2024 16:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7d96SAAhuN0e7Yp4L88+zHmhz7A5Q4sqxXzYOawyTrI=; b=fegmP9DWbEQJ0y2G
	62wIXYPK8MsXKOTAxf76019BoP8/LxHepTuLnTi28HVQ0jHahWesX7D9fMm3Gph6
	94IU81YV5b+3mfvJIt1FczA5s1JCCEfTaaAUVxRrreO8ayv2zGmjmFOpRjRvlhfz
	RYATh6CGZ6b1VI1HnAh8qvl3cIz3RsEKPMCPKN629M15MuMX/0HJGZORGPXv70nu
	yFLdRxUINLC7lLhV1PNugqF5FjgkE0rwLAwBSXIzArTgQvq8G+fVKqyNO8jlPvIi
	aShcVK42k65yZ6Jt8agFUnTe6NZQm+9Aoz6LhYt2No+mVLzg/3BbKFnQPC5OVFq6
	ZlOvog==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv7jejb3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:46:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGknx2007782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:46:49 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:46:49 -0700
Message-ID: <1d5dc2bb-773c-4877-9660-fff5517c2df3@quicinc.com>
Date: Thu, 20 Jun 2024 09:46:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples: configfs: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240601-md-samples-configfs-v1-1-83ef2d3c0088@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240601-md-samples-configfs-v1-1-83ef2d3c0088@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0c0oGRJiJ3A6_0idJjyTq_xaCNKB-9fB
X-Proofpoint-ORIG-GUID: 0c0oGRJiJ3A6_0idJjyTq_xaCNKB-9fB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406200121

On 6/1/2024 5:12 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/configfs/configfs_sample.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  samples/configfs/configfs_sample.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
> index 37a657b25d58..fd5d163828c5 100644
> --- a/samples/configfs/configfs_sample.c
> +++ b/samples/configfs/configfs_sample.c
> @@ -364,4 +364,5 @@ static void __exit configfs_example_exit(void)
>  
>  module_init(configfs_example_init);
>  module_exit(configfs_example_exit);
> +MODULE_DESCRIPTION("Sample configfs module");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240601-md-samples-configfs-946b278a9d47
> 

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.

