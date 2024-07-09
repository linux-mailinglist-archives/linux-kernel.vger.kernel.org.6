Return-Path: <linux-kernel+bounces-246599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0F92C427
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A446283923
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364141836DC;
	Tue,  9 Jul 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="psGr9yHA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263691B86ED;
	Tue,  9 Jul 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554879; cv=none; b=lP6E4w5ao+BwRXu/fQ2YZaWfNlWPOgT1CM2D5iCAnPz8pOQVuRFEdfwK52WO3MlY/5gvnRChz4KLrdr1Fd6fYXfsgtAMjSuJXnYBf/QtCIjr7kUKMXdaPk/rcngOAi+sXC3COKSfeM3LKXm0hlStaRbvXdvA1wJ7fInmw9tii0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554879; c=relaxed/simple;
	bh=/lerPipFofMS16XG2NmAetlTrp37j/8H3xkX8//eLjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=maXne0E3lVS9/CbCAqtzXToy2il7V/XOf3ZGfYrm7IXCEV4FLdobJJgJ0DtqeuRUS55xc2KyFegF3UCeFgHSk8AOhCv9zkog1xyoOOc2g/LtJfRF9KJnP6bzVyh7oLxhwuvReBe2QVUIbIBBolnZVDYagmV7UxO8McfxfCx7MHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=psGr9yHA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BjsJs003751;
	Tue, 9 Jul 2024 19:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/AFCoLS0ROkwyZbhoUTcFYBbGIrHJj7O3gfi+EWhZsY=; b=psGr9yHA5UHcxR+w
	3kTt5evImTkq4xv7ebOdpi+cfwmafnfsZaE9aZufDVXboUpAqjDJMIrYh8Cqoa6P
	8u31Y9sXd6VJn0O1qBAeeZyF0Tt8dAHb5gidPaYN2SpPIvwRqo6y9lgW1r05jgYp
	8PZT71RkuU0H+uyO6Xk+9Z6C5OgN+LSlY4348G01i0hwSk/lar0cn/dToab0sYJ1
	5j4b8XUpfxuUUK2dr2p2HETRP6R3mU4ivEx4KQPVKgSUvk7twXFLF7lbSQKp3xIF
	JeyoO2eDpvMGKw4/5lkgXP1aXsTYchsq+zYzg3lz1EtExjGZoj48Xj45XSDz+8/I
	bQjJaQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0rabdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 19:54:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Jrm7p018290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 19:53:48 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 12:53:47 -0700
Message-ID: <3808c973-1315-420c-900d-122a73a34f9e@quicinc.com>
Date: Tue, 9 Jul 2024 12:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: kprobes: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7PGJ1pyxWz4TcoXL8gV1ajE05RWow9uy
X-Proofpoint-GUID: 7PGJ1pyxWz4TcoXL8gV1ajE05RWow9uy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090134

On 6/22/2024 9:34 PM, Jeff Johnson wrote:
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  arch/arm/probes/kprobes/test-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
> index 171c7076b89f..6e9041a76b8b 100644
> --- a/arch/arm/probes/kprobes/test-core.c
> +++ b/arch/arm/probes/kprobes/test-core.c
> @@ -1664,6 +1664,7 @@ static void __exit kprobe_test_exit(void)
>  
>  module_init(run_all_tests)
>  module_exit(kprobe_test_exit)
> +MODULE_DESCRIPTION("ARM kprobes test module");
>  MODULE_LICENSE("GPL");
>  
>  #else /* !MODULE */
> 
> ---
> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
> change-id: 20240622-md-arm-arch-arm-probes-kprobes-34037098a2c3

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.


