Return-Path: <linux-kernel+bounces-281255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61994D4DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59ADB22395
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CF21CAAC;
	Fri,  9 Aug 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pKAT8HQL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A142E62B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221603; cv=none; b=UNFeksOXtIAJF0KSVOcEY3Ef4epa0rst5V4QCHynCOCyLlBgkRT0z8CRBFfyDP70x/4D7Y2805U8U8eHlWLVSmAlPlqkfs7X8lyCvultCiBEJURn4vEFxtQZbyCV62PeEIL+npVuCbJpwY2aLiCeHZvsxXv2/Z77TKAXaW4KHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221603; c=relaxed/simple;
	bh=R8HUVla8dELySLDwzNjNuBF2djytYlbhmCPM4Fgj0ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ogA3LYd5WlBmuFXQZwhQXdR9hBduCLm2BQVqDDWi9zictQxoWHlDXID43OM3dM1pkt7EsFO+ANEy1BAy6lOKsxxi/MYMLnSMHYKdfSnr2/BLF1+lMVLQKPbDKWr5QAopIzgwc3v5B4fqjkJ5ri2etvIyXC80mQIQfiKBy7gG7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pKAT8HQL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479AZ2ak004864;
	Fri, 9 Aug 2024 16:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W4AM0skEw2EGTbmvxd/JH3BWHycEem5bzdl0AaWSKLE=; b=pKAT8HQLAfsNpyAF
	T35UF/Mm7Vk0+2eJ0yjat3Z3wny8dex1wK/HyTXySVHj0vhSVGjQMo5ush8GB/XF
	mCPusV32a119aHkq4xS0LgNfQUrETgUfhVWWk9+LKXM1WIJ7McD0nF4cmaXZdv/H
	U1myHF07q5T+OW7M7aoECjRZe7wutVfhbTy6JV+I1wFhByQ6bny1uR0FO6x1k/Sr
	flViyMZBsLTKCW7bfGUi5diHEfhKQ6o8gzDds6NgZOE5SxaxW11ikjXu3uXepvR3
	mkQwI/AnQifekFSf04VHB+4da5XygbDHYngcTlf6tPjKAHHbj4o0HBTtesu7mqCQ
	myK0QA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40whg38vax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:39:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479Gdvcf027581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 16:39:58 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 09:39:57 -0700
Message-ID: <b10c8754-7062-7543-e766-fb18570fb122@quicinc.com>
Date: Fri, 9 Aug 2024 10:39:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 05/10] accel/amdxdna: Add GEM buffer object management
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <20240805173959.3181199-6-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240805173959.3181199-6-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aUykT3Iq-22hlOvm_xtD_fxSh0Q6zjNb
X-Proofpoint-GUID: aUykT3Iq-22hlOvm_xtD_fxSh0Q6zjNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=719 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090118

On 8/5/2024 11:39 AM, Lizhi Hou wrote:
> +/**
> + * struct amdxdna_drm_create_bo - Create a buffer object.
> + * @flags: Buffer flags. MBZ.
> + * @type: Buffer type.
> + * @vaddr: User VA of buffer if applied. MBZ.
> + * @size: Size in bytes.
> + * @handle: Returned DRM buffer object handle.
> + */
> +struct amdxdna_drm_create_bo {
> +	__u64	flags;
> +	__u32	type;
> +	__u32	_pad;
> +	__u64	vaddr;
> +	__u64	size;
> +	__u32	handle;
> +};

Needs padding

