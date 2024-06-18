Return-Path: <linux-kernel+bounces-219657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C727C90D624
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5D71C22A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD202158876;
	Tue, 18 Jun 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FaHz0LTb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06A2139AC;
	Tue, 18 Jun 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721987; cv=none; b=EUf3CpHb+em4MlhyKnQjTbuIhd0RXjaIkHKRHSxRUWEePSCn036TAhR7b18NC5uvsR351osayk9gEmSBfps7IiUXFoMNhRbquQWZfGT5Nqg6Tbc3OqmqAL2zwl01Gz833bhqQtbDhUArohN1f+oqT0c3wE4w3oo4qUJjfmWQj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721987; c=relaxed/simple;
	bh=fukWbmx4Pn2pTyJOFRUZc4NXCWcgWo+BcbbO5PdfbSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jZI3BX5Zxf+0RYnxC8Ix2blGPh4DYb9MPBsZUkOwQX4btIhw91GJrLOzRVCiv9ES4J7Wng2D4VhyZxhI6zsRrutpmZMDI6nY+mf2vmMpnTH9zFdgiZBymbRguDxhXgsbHpBkBVwiLxp571xvzVriNG45HvbqAZ+iTs39fs4ZihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FaHz0LTb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAplKd001257;
	Tue, 18 Jun 2024 14:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WO8KYgNz3uTg6+MlBwKDt9QO1R1LkJOmDUu0c9k4BIs=; b=FaHz0LTbmBTzVfAB
	AVC4L8mOZDdprjHOnw9diOWFTxpnty7rPE9bKK1PgzxzJXL37N/CbsvSA14xlN2j
	FYOr/ePQE0/9MSqFo+n72R5dp93IXgz+MnC8qXW+AL+NwekvhqaMUJQwrtYanqUN
	ko0Vep7cDA37drQKowh/LStbKFuQ5gRlCKvJgGkpTBJX2+K5cJnp1KSUEbTuGqkD
	Y98DyMqee/vHlhGhI65z+Atm9LGHBPMq+kplARSsAztXy1+bYJF5eQuPg+sKk1gi
	wmKKuiRG8Y0EUF35MdKLzPbKXuhS2a6GrPDhg8LelhowpcR2Fp76l1Kq8Mg1QS7s
	0uIp2w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu1b0spmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:46:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IEkJvw003275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:46:19 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 07:46:18 -0700
Message-ID: <a9a90666-5b3f-478d-8c88-002e23aee48b@quicinc.com>
Date: Tue, 18 Jun 2024 07:46:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240617-md-m68k-arch-m68k-v1-1-57d38beaeb13@quicinc.com>
 <CAMuHMdWD0Je3HZ+RJyfdxKxKcBp7nt6ooP_YUpiju77Zf1QzVw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAMuHMdWD0Je3HZ+RJyfdxKxKcBp7nt6ooP_YUpiju77Zf1QzVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nX1uQMjgfFnUf-9jM2l6DKaD-bLmW3LZ
X-Proofpoint-ORIG-GUID: nX1uQMjgfFnUf-9jM2l6DKaD-bLmW3LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180110

On 6/18/2024 12:36 AM, Geert Uytterhoeven wrote:
> Hi Jeff,
> 
> On Tue, Jun 18, 2024 at 1:47 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfblock.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfcon.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/emu/nfblock.c
>> +++ b/arch/m68k/emu/nfblock.c
>> @@ -193,4 +193,5 @@ static void __exit nfhd_exit(void)
>>  module_init(nfhd_init);
>>  module_exit(nfhd_exit);
>>
>> +MODULE_DESCRIPTION("ARAnyM block device driver");
> 
> I think that should be s/ARAnyM/Atari NatFeat/, as I believe NatFeat
> is also available on other Atari emulators. See also nfeth.c
> 
>>  MODULE_LICENSE("GPL");
>> diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
>> index 17b2987c2bf5..0ab2e4d08871 100644
>> --- a/arch/m68k/emu/nfcon.c
>> +++ b/arch/m68k/emu/nfcon.c
>> @@ -173,4 +173,5 @@ static void __exit nfcon_exit(void)
>>  module_init(nfcon_init);
>>  module_exit(nfcon_exit);
>>
>> +MODULE_DESCRIPTION("ARAnyM console driver");
> 
> Likewise.
> 
>>  MODULE_LICENSE("GPL");
> 
> If you agree, I can make these changes while queuing in the m68k tree
> for v6.11.

You are the domain expert here. I'd be very happy for you to make the changes :)

/jeff


