Return-Path: <linux-kernel+bounces-234770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B9191CAC8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E7B1F22DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7631D540;
	Sat, 29 Jun 2024 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MeYDPcHc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800001EB31;
	Sat, 29 Jun 2024 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630528; cv=none; b=EgZobXCNTCZG57NyHguMA99F5qe6m5cHyQXAw1ZpME47O0I/1UDJymFPsXwr27xYmgTindgFLExkMII5vhHmjzxDONkEboFZvtOiT21fCPMfDYDUNPnLqSHsYLtK4uk8rvHYX8mzpRnW+YDuMjLB5SYlNC+vpdRnwfQpp0+ElyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630528; c=relaxed/simple;
	bh=VLey5HTG1ce3qfqn5FGTexMgy6lpFW/kPfkmJKKgxeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ARzzqrtuCnmzgMW8IDT/dvJNj9riTjiWG4mAnQ98Bfvjzee8ixx+ny0jVgJqAMUpF5eXoJJpiZU4Qp29yUgson5ftNU5SciI3tXrPODnMvlSyZw5lM12nO3Szga3Rn55K+H8rJkMpssvycDeP1UFV/lgUB2bNfH4sTMJgpxtQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MeYDPcHc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SFvjGX015158;
	Sat, 29 Jun 2024 03:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HGxVsfN3za+mToVpqfn892s4MHmmP3ddMR1WlCtHhY8=; b=MeYDPcHcGIIjTBgr
	ToUYYCCYs5dwIyqNlxP3yJ2YOmePsgL5uPEYhBfXUyqdELhIOKc8IJnO072KuyhX
	8KIuw7Vt0Ccl5WcbkX823YTlpynlRolkWMVib/u6g/EtgBti2KkaiM6h8WvGQpL2
	Y3fVAHMAyXG8Ew4ePeTLZLwilb3BN0+ON5luRtDD3S08YtXJHi7dx5sx64h+q9aC
	Y01I2LwcNsupwFVe/F5NwQ4Lhl71seX7oVpBgstCigs9/Lv8hN+NgaAnBYOkRWRW
	3sCgiU2PUk5kBQIpcm1WNmrJrqOcfK40cQc6/R+vM1o6OpH6+qn9DL5AYa6BLj1K
	Xiw5xQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqsj1vsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:08:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T38fDL024972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:08:41 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 20:08:41 -0700
Message-ID: <94597a22-7de6-4422-8af2-f243156daca9@quicinc.com>
Date: Fri, 28 Jun 2024 20:08:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: ufs: add MODULE_DESCRIPTION()
Content-Language: en-US
To: Evgeniy Dushistov <dushistov@mail.ru>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240510-ufs-md-v1-1-85eaff8c6beb@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510-ufs-md-v1-1-85eaff8c6beb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SmiD1pkA_clIF74u9KUIbGPHD12l5QmI
X-Proofpoint-GUID: SmiD1pkA_clIF74u9KUIbGPHD12l5QmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290022

On 5/10/2024 12:02 PM, Jeff Johnson wrote:
> Fix make W=1 warning:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ufs/ufs.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  fs/ufs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index 44666afc6209..bc625788589c 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -1540,4 +1540,5 @@ static void __exit exit_ufs_fs(void)
>  
>  module_init(init_ufs_fs)
>  module_exit(exit_ufs_fs)
> +MODULE_DESCRIPTION("UFS Filesystem");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
> change-id: 20240510-ufs-md-7a78d87a7ff4

+Andrew since he's signed off on this file in the past.

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

