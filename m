Return-Path: <linux-kernel+bounces-255261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CADD933E20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAE21F22FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FA17F51A;
	Wed, 17 Jul 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cr2dPmgD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E517FABD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224899; cv=none; b=sXwXY2tPEGa0MLlZpZEQGu1oAzH1sVI10sA3A9kSSW0DEVRMcKbNkvpw1lnL1NYJfqcP/jJll3+0NNR6J3SpNXordDXcbWJh+EV6zdBbTcpnxSSrp60k8s64uVyUxdkLGxaBGUD/WMEKSfWaxs6OJbzTvT2U6tbQqDa3NDwjo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224899; c=relaxed/simple;
	bh=mWYwh8spoB8/2mFMsyfLMTNUQDzkXCo3jXgz3rsNuzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IvmVwCpPwTNoYe2wkKjfM9UPGmpuIw9cDdwW5cAEFaOCNRPDW3dbLpLw8VF0CiRH4lOm3aeel/lj2vWtH9Y5WC/T6hyFbEFVMXJElGuPGAsbSqGUCKVZUujiy7gEj95qBCeiu11JpmrPrurs1tqKZKZ+olXVEcWKhC+V65ANWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cr2dPmgD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H76i3Y024197;
	Wed, 17 Jul 2024 13:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3/CuFUBriEgeb8fHBJW8fnHSKkf6Ie7Q90Do5vL7KTQ=; b=cr2dPmgDbXy5130d
	dTUibBwTpdeAJOzlw9cmB8HLM1TWr875bifNBf+HLXEXZVRlYs9Z+LnDJ9CZCazZ
	e40isf0eCg6KXseKrFsv1ZzpnIQrzpiibpPTgdvPRf5K43R9HSZj4khGeb8YFoSQ
	4/1Byta2Lm3wwnhvsmd1e2y0B0YBh6DawqKyOuZGIwujj5lEah+Vv8oDZRL7yrlL
	DrSEwekP8DjkMCnbh0dFbMwxlKN+F1NsGJGcO6PKWwpLibDoTROZQGit2mAFpoXy
	uaIEZgkA8cYFkMEWqg7sd06HxLVZ6ZRLwomcmuvoFlTU8twDs8WtHnEKS8G5PWbW
	FeuYzQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfu2gyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 13:59:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HDxSqM005425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 13:59:28 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 06:59:28 -0700
Message-ID: <0e51cb05-9323-40df-aa53-89c8a1df1cf1@quicinc.com>
Date: Wed, 17 Jul 2024 06:59:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>,
        Vamsi Krishna Attunuru
	<vattunuru@marvell.com>
CC: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
 <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <024d85a1-6a4e-4552-a5dd-adebfb195be8@app.fastmail.com>
 <SJ0PR18MB52463B1A7393F36673548989A6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <20240717134135.GA24892@thelio-3990X>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240717134135.GA24892@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dWkpP7YoLZsLf0HkeEMqfNE-pDvab4EM
X-Proofpoint-ORIG-GUID: dWkpP7YoLZsLf0HkeEMqfNE-pDvab4EM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_09,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=905 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170107

On 7/17/2024 6:41 AM, Nathan Chancellor wrote:
> On Wed, Jul 17, 2024 at 12:17:08PM +0000, Vamsi Krishna Attunuru wrote:
>>
>>
>>> -----Original Message-----
>>> From: Arnd Bergmann <arnd@arndb.de>
>>> Sent: Wednesday, July 17, 2024 5:20 PM
>>> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>
>>> Cc: linux-kernel@vger.kernel.org; Nathan Chancellor <nathan@kernel.org>;
>>> Jeff Johnson <quic_jjohnson@quicinc.com>
>>> Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve
>>> compilation issues on 32-bit ARM
>>>
>>> On Wed, Jul 17, 2024, at 13: 45, Vamsi Krishna Attunuru wrote: > > Neither of
>>> them worked in our case, HW folks also confirmed that only > 64bit access
>>> work correctly. > I will just include the header that address the compilation
>>>
>>> On Wed, Jul 17, 2024, at 13:45, Vamsi Krishna Attunuru wrote:
>>>>
>>>> Neither of them worked in our case, HW folks also confirmed that only
>>>> 64bit access work correctly.
>>>> I will just include the header that address the compilation errors
>>>> with ARCH=arm, anyways nobody will use this driver on 32-bit kernel.
>>>
>>> Please just use a Kconfig dependency then. If the device requires 64-bit
>>> register access, then the driver should not use the fallback.
>>
>> Ack, since it needs to skip compilation on 32-bit platforms, can you please
>> confirm below change is suffice or not.
>>
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -588,7 +588,7 @@ config NSM
>>  config MARVELL_CN10K_DPI
>>         tristate "Octeon CN10K DPI driver"
>>         depends on PCI
>> -       depends on ARCH_THUNDER || COMPILE_TEST
>> +       depends on (ARCH_THUNDER || COMPILE_TEST) && 64BIT
> 
> I think it would be a little clearer written as
> 
>   depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> 
> because ARCH_THUNDER can only be defined when 64BIT is set. Regardless
> though, that should resolve the issue.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Cheers,
> Nathan

I took Nathan's suggestion locally,

Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>

