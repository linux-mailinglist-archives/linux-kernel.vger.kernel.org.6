Return-Path: <linux-kernel+bounces-350981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41106990BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD041F210CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6C1EABDD;
	Fri,  4 Oct 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GGkDwsV9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE741EABBC
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066055; cv=none; b=Ro1RxcysvUt+Zm4giP6W3MVK62CyMAoe3zRR3VekDoZv7f/ird9e3Tikji4efOAFgqcYfrvOVUr2oeZEIkmnWPPLngo2tQPE+SZaJRIsniN4tzv2pbyG8XXjg+hgjSv7s5cVBkh6AcLnI6C8q5uO8DU7ooLtWnlCAncIQGVqQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066055; c=relaxed/simple;
	bh=FCEOV28vZFeo2JvsOrDKak1h2a8bL4EbET6FPhzohpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAChRndsQKWNU7zZeD8OSziojeGnEORMaH6nUBDGTVr0O7QtKR1AvDNZQSsD670GMgGHZFVOMNIDcL7CxW66ZcPz7BqaTo40eUCKVsFMFvXmrERMV3hqBAwdP89BJ/pO2nzz6b5xM9YAxoJLpvhKelMvBlxV0aS6F1cQGWQMIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GGkDwsV9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494AE7qO032696;
	Fri, 4 Oct 2024 18:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w7U9Iz4T63Hri05kLr6t2UzHA17vtCnF+ABQccaowb8=; b=GGkDwsV9dSxWTcyo
	KZ9dUiWA3kEis+j7W4sJ0s1rgJH7H/J5BgvjG4f1jkv1vSqvT3wD+XuGjk8jSd0N
	EB9BnOPCDf8dv2oafzj7XcGirhcSZyejX7Mg0XKhMpcx++PdJN4719apVb5pCGOy
	cOIAx3G3ibNGAgJXfIoTmko06EjwmPvF2UJAya1U2mI3814+kYiQh5DTTORzcSP4
	hj+o7k523T5IBA8t3Xkt/435oA11okY1QAaJfEW9fUSGjYfuECdgKVRDO3EtUlrs
	cnQBPPFujLLXBX4hRAUldgxlGdlIYh8wteVvcUWtXtCBTvmHvh142iORZa7N816T
	h6iWng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205f2xf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 18:20:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494IKoc5017971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 18:20:50 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 11:20:49 -0700
Message-ID: <016d4da1-a139-30ef-a9ed-970564e710ac@quicinc.com>
Date: Fri, 4 Oct 2024 12:20:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 09/11] accel/amdxdna: Add error handling
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-10-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-10-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yH9b4g-Jfh1ntK-D2fdIWceiw4WrK5Kn
X-Proofpoint-ORIG-GUID: yH9b4g-Jfh1ntK-D2fdIWceiw4WrK5Kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=895 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040126

On 9/11/2024 12:06 PM, Lizhi Hou wrote:
> +/*
> + * Below enum, struct and lookup tables are porting from XAIE util header file.
> + *
> + * Below data is defined by AIE device and it is used for decode error message
> + * from the device.
> + */
> +
> +enum aie_module_type {
> +	AIE_MEM_MOD = 0,
> +	AIE_CORE_MOD,
> +	AIE_PL_MOD,
> +};
> +
> +enum aie_error_category {
> +	AIE_ERROR_SATURATION = 0,
> +	AIE_ERROR_FP,
> +	AIE_ERROR_STREAM,
> +	AIE_ERROR_ACCESS,
> +	AIE_ERROR_BUS,
> +	AIE_ERROR_INSTRUCTION,
> +	AIE_ERROR_ECC,
> +	AIE_ERROR_LOCK,
> +	AIE_ERROR_DMA,
> +	AIE_ERROR_MEM_PARITY,
> +	/* Unknown is not from XAIE, added for better category */
> +	AIE_ERROR_UNKNOWN,
> +};
> +
> +/* Don't pack, unless XAIE side changed */
> +struct aie_error {
> +	u8			row;
> +	u8			col;
> +	enum aie_module_type	mod_type;

As far as I am aware, the compiler will use multiple variable sizes to 
define an enum. This feels very fragile.

> +	u8			event_id;
> +};

