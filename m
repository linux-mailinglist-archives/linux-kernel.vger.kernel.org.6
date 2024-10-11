Return-Path: <linux-kernel+bounces-360523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A65999C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31FBB2253F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684CC1F4732;
	Fri, 11 Oct 2024 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aJfp7qFz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594558F58
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624100; cv=none; b=XV5/BcXJSXPYhOzvHVPMtDdUzW6xQGza3CPWQGMQTJ8is9JsD2cUJPzL7uElQjhxv6UBLhqz2kEthWgfsb3nOotw0K+FlMFV16QziqqjHW07WDlSsWwfZs6pCkceOPrnloH8SJWfdtBM1R5VbSj7Apo6ljX0Aenfv0WWOLkJALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624100; c=relaxed/simple;
	bh=eNRhC/GPjXSyncjg99ffIraDleAcQFRowEzhDHCbMpc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NeEauMpuZ1SkPLdgpKcYhf8pCTKqxr0IMitoLGo5Yaa+8gZxIiH3irvw4bRP4bnZzp2hJsQKKXXT1PlAKraHDqem6Ob2KqeR6dm2jr4Umt4IYhSWzwQDS1oJCr+vSDoB+dqrVXa2c7tCtT7aMYBFum235VtMSr9HntAvwHwiz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aJfp7qFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B1KcOS020937;
	Fri, 11 Oct 2024 05:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0ok5qw2YuaY10CdYOxZW5P7ebPqIFGn73xQbsQnapM=; b=aJfp7qFzprqXx6rR
	XaHR/WpzvJDQO80GnH0s9s8ytoEt+0h+d2wXFRWSk7xrcpvpHK7EdIzvXefNaVkj
	AEjZsRJuwa5ggyUFtppUFn7ygVkZlvSKFaC1haiRqD/reht/eah9fzemlFC2aEcZ
	HNk9UncnoKPT+ki3NdUkv5PWnu0HuERM4EoF58m0xkiz9j7SPkPB7lk/DdY4PUYI
	P4gOu1/C3ryLcjg41GX9nui2Dkjt+PCXEs2zcGh1cFvvYvnEOqVyVZ4lMJCQv6cp
	Qx4YHtlvie4JLzUY6/zDkpYOVy4b5fHTk2A680u0Q6A86ptmi9mg1GSCvA5bC+Sb
	pUSB0Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426db7jfn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 05:21:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49B5LT04012770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 05:21:29 GMT
Received: from [10.216.58.240] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 22:21:02 -0700
Message-ID: <6351b4bd-d763-0892-4915-b667444b0e6c@quicinc.com>
Date: Fri, 11 Oct 2024 10:50:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable WCD937x driver as module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        <srinivas.kandagatla@linaro.org>
References: <20241010052646.2597418-1-quic_mohs@quicinc.com>
 <638a44fc-c693-4270-8643-7cd75a3c6ba6@linaro.org>
Content-Language: en-US
In-Reply-To: <638a44fc-c693-4270-8643-7cd75a3c6ba6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V47C6XP3XAtHQ8AWy6yQ3pdb9aTjyxm1
X-Proofpoint-GUID: V47C6XP3XAtHQ8AWy6yQ3pdb9aTjyxm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=763 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410110031

On 10/10/2024 11:15 AM, Krzysztof Kozlowski wrote:
> On 10/10/2024 07:26, Mohammad Rafi Shaik wrote:
>> Enable Qualcomm WCD937x codec driver as modules
>> since it is now used on the QCM6490 platform.
> 
> QCM6490 is an SoC. Which company? That's a shared defconfig, you must be
> here specific for which product you are making it.
> 
> Which upstream board uses it? Name it (fully) here as well. We add
> things to defconfig for the boards, not for the SoCs. You cannot boot an
> SoC.
> 
Ack, Will update the commit message.

The WCD937x codec now used in Qualcomm QCM6490 IDP board.

>>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Reviewed-by: Rohit Kumar <quic_rohkumar@quicinc.com>
> 
> No one will pick it up... You must Cc your SoC maintainers and mailing
> lists, so they will see it and have in their queue/Patchwork.
> 
> Run get_maintainers on the SoC you are interested in.
> Ack,

Thanks and Regards,
Rafi.

> Best regards,
> Krzysztof
> 


