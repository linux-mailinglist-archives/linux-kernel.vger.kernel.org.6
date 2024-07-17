Return-Path: <linux-kernel+bounces-254656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5299335E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6431C21FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37ED6FC7;
	Wed, 17 Jul 2024 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MXZTiMAP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4B469D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188541; cv=none; b=SOzyttKXygkUQziCKmVCO9ZT84VwHCnxObKbUlMZhXKlNbOd5FZ73f6p0qLGhW8FV13JsflysvrYE5lBGfuQlwARmXhAsmNuP4Y998wUD73W3E1+dorXcPsPScjRs2PcyezZXpPKKXgmCQjvkZsJT7tGpCOtYar07D0rYiYxl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188541; c=relaxed/simple;
	bh=F11Lw15fDi0mu0plYIWMtfzDLymxQXfVW/JHWk22/tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=glsuXi7d9d5qh1zyQ3ASPAEikhuqkbo1DlV8ftRrhEWhtd+dxzqwVI267citDu1CG4jWTdmLz3IcBnZnfVqw2gRF4gRjdRxvkidsVi3EEHBMM5I3UUKI3aQoUKYze2bEO42830Vazr5/lh5nBgjaB1lgqSrdIrK7HYtX1J1YJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MXZTiMAP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHfZcT005677;
	Wed, 17 Jul 2024 03:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IOVTpfvhcuxqvgbi9pbxBB9iihYU9yehdijeAuQYOs4=; b=MXZTiMAPlsLDvv+n
	BsET/ex/twaXNJzpbooIUhUrwnLfCrdDzwsDfMO7dEtB4WMH2703NNfDpQeKrhBj
	yVUyIlnJicr14A+5umG3aZ01q5ZlhgeiuNYZJOo1OiGUlStfNSnrBFtqLcTrqrsB
	u7e1kt9KPMgDPcvAfV1Xe6TMvLmdTaQX/6MLMkr7s+WdZR6qOGAHD/AhCqDxZahH
	eh/mNRXGw7G/+kpNYq7G/XHPM13YKwYMRGix+FA8OU4RF2kKaDhX2v8knI7zUs4b
	0hHtdvOsywhlSytt48oEjGswbUgldrzYAv8EUawn59AkVT9MbzP/ruLgrLW63XyC
	xWA1mw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfugy7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 03:55:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46H3tGsv018349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 03:55:16 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 20:55:16 -0700
Message-ID: <920e1e90-d72c-48e0-b7da-c2ac77128f6b@quicinc.com>
Date: Tue, 16 Jul 2024 20:55:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
To: Greg KH <gregkh@linuxfoundation.org>,
        Vamsi Krishna Attunuru
	<vattunuru@marvell.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071053-mahogany-cavalier-6692@gregkh>
 <MW4PR18MB524491EEA2A628469595FE47A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071012-backpedal-punctured-5d7b@gregkh>
 <SJ0PR18MB52467C544972534F6DECDC48A6A62@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <2024071232-kindling-either-de2c@gregkh>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <2024071232-kindling-either-de2c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GYXOwqPNwVJ8odkyVHkP3-HnaMWWudXd
X-Proofpoint-ORIG-GUID: GYXOwqPNwVJ8odkyVHkP3-HnaMWWudXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_04,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=925
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170028

On 7/12/24 01:54, Greg KH wrote:
> On Fri, Jul 12, 2024 at 08:44:22AM +0000, Vamsi Krishna Attunuru wrote:
>>
>>>>>>>>
>>>>>>>> +config MARVELL_CN10K_DPI
>>>>>>>> +	tristate "Octeon CN10K DPI driver"
>>>>>>>> +	depends on ARM64 && PCI
>>>>>>>
>>>>>>> Why does ARM64 matter here?  I don't see any dependency required
>>> of it.
>>>>>>>
>>>>>> Thanks, Greg, for your time. This DPI device is an on-chip PCIe
>>>>>> device and only present on Marvell's CN10K platforms(which are
>>>>>> 64-bit ARM SoC
>>>>> processors), so added those dependency.
>>>>>
>>>>> Then perhaps keep the ARM64 and add a COMPILE_TEST option as well so
>>>>> that we can build this as part of normal testing?
>>>>>
>>>>> So that would be:
>>>>> 	depends on PCI && (ARM64 || COMPILE_TEST) right?
>>>>>
>>>> Yes, it makes sense to add. Can I send this fix as next version now so
>>>> that it will show up in next release, please suggest.
>>>
>>> Send it as a follow-on patch on top of my tree, doing what Arnd suggested.
>>
>> Hi Greg, I submitted the follow-on patch on top of your char-misc-testing.
>> Please let me know if there is any additional action required on my part.
> 
> Just now applied, this crossed in the email ether.
> 
> greg k-h

I'm trying to build with some legacy drivers enabled to find some 
remaining missing MODULE_DESCRIPTION() macros, and when trying to entice 
some warnings from ARCH_NETWINDER this series gave me the same errors 
flagged earlier:

drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_write':
drivers/misc/mrvl_cn10k_dpi.c:190:9: error: implicit declaration of 
function 'writeq'; did you mean 'writeb'? 
[-Werror=implicit-function-declaration]
   190 |         writeq(val, dpi->reg_base + offset);
       |         ^~~~~~
       |         writeb
drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_read':
drivers/misc/mrvl_cn10k_dpi.c:195:16: error: implicit declaration of 
function 'readq'; did you mean 'readb'? 
[-Werror=implicit-function-declaration]
   195 |         return readq(dpi->reg_base + offset);
       |                ^~~~~
       |                readb


Seeing these on linux-next tag: next-20240715
Will the fix reach linux-next soon?

/jeff


