Return-Path: <linux-kernel+bounces-350849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF00990A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931E3B215B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0981DAC83;
	Fri,  4 Oct 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dCFHK+Aq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3731E378C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064639; cv=none; b=LvPpdet87ZeP5rG3AUHdTp+l24X0MLkbVhDx4CeQiFBjYXqxFN4t8dj3ZbfJ+vLVQoZ9WqOXYGE3jbU5n76ZFE8tIG4W+9l3YdsAvJZSncBllpWJYx2jfjpdszxiN6gLJKh0MDUqOJJMpj8vDX2IPz6YTWTktY2DdP2yxm9dR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064639; c=relaxed/simple;
	bh=G1vf8AtsHpbMdFO5DG6cbwjT+Qn+ZOl3zyxy18tPSZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qZYiuRKaEsVamRCKIH6ZPgFk5YKJU+KW/kG6l1yyioAbsPpNRGOkjrZfyO6m+iItvJk86fb2sVL1ghv8JmVnCWU5iuocPexd0JhAMalmblhXUQ/e9IbU4QqwiX5DdS9preEmYqDld6PAAxKzwRN8r+qMCknuxg2puhBFqMU+QRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dCFHK+Aq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Aeo9A014160;
	Fri, 4 Oct 2024 17:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RjVAIODgIMe6TcbnIeo3RvgBeLIP865au+8FkWupWgM=; b=dCFHK+Aq1D39Kj8q
	/8zZqnnMxcaPungOtziwi19nWb9Kdky8tavB4xRDm7/HgM+yavWP8Vf9WV356Y1S
	JB7n6LUYGDGD2v+h7C/AdCyCNnB6TeG0XeP20nJ1dPcQXrKB2fuwlXwYEgP3Hnsp
	sRjMXIhkVZYGV07590sBwexPoh2beoGoA8bqlYRvXO6S6EFI2e6dybc5xy/xYkQY
	4vnGLIB1SkVwHWdtw+DtQIq+KRlwCTHyYVXJYibd7Ec5gmY6qfYxgu6spllS5snv
	0WLnJg9e+FmP8q7uTKBwTfsOvQST7bwu/aHXze1xj/MEl7qEcvlEgodvCpORBvHY
	slJ/kg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205e2xc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 17:56:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494HuwkL016729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 17:56:58 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 10:56:57 -0700
Message-ID: <d5694bb9-e035-c4ba-392e-ca06562355d1@quicinc.com>
Date: Fri, 4 Oct 2024 11:56:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 06/11] accel/amdxdna: Add GEM buffer object management
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-7-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-7-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gxZCMvLNNaZWAXU2vSgITrRDBLVmKIfm
X-Proofpoint-ORIG-GUID: gxZCMvLNNaZWAXU2vSgITrRDBLVmKIfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=791
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040123

On 9/11/2024 12:05 PM, Lizhi Hou wrote:
> +/**
> + * struct amdxdna_drm_create_bo - Create a buffer object.
> + * @flags: Buffer flags. MBZ.
> + * @type: Buffer type.
> + * @pad1: MBZ.
> + * @vaddr: User VA of buffer if applied. MBZ.
> + * @size: Size in bytes.
> + * @handle: Returned DRM buffer object handle.
> + * @pad2: MBZ.
> + */
> +struct amdxdna_drm_create_bo {
> +	__u64	flags;
> +	__u32	type;
> +	__u32	pad1;
> +	__u64	vaddr;
> +	__u64	size;
> +	__u32	handle;
> +	__u32	pad2;
> +};

Why not eliminate both padding fields by either moving "handle" up, or 
"type" down?

