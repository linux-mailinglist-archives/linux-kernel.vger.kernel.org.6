Return-Path: <linux-kernel+bounces-179879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6C8C66DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1DB1C211B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46485C41;
	Wed, 15 May 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ma4PFVCS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F963BBED;
	Wed, 15 May 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778408; cv=none; b=QOvW4a52o7dSQO3NdzVrPgLvSulGjJ1hZO39M35EV5FoKTClPujiWfvEquS1v5RqrqloiGo6xCy55lBE2ViPX/xLaOh8O3I9+gCaWuPFe5OLaFV8OPY5fQe+7M0nJZJvHgy47GGG22W/uCR9w6Ywzpm+uEXnVKs+lIFRmHN9fX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778408; c=relaxed/simple;
	bh=bOt7jiJjqvR3Xb0uZ0VGKUcbibFf3eOrvAtuGYaYrrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn2pXIJOAf7Nyv1rrl3mPAYn6UbYjf1Ug59/brJp1iyXSaahWhihMGh0jrdnlQrTT9GwjXnQo+UtKLsetbHsW2K57iPY6bPS2uUsoE43i3tP99HnX2HCyjKWOOV3jaDXrMdwSCbN1okeJzuyXCyVZCjhaqmqaiIRt9WomoPt4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ma4PFVCS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FD6Uoq022929;
	Wed, 15 May 2024 13:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XcohvDplrYpovplc1395I8uKQ9hZtisQ4Yf3MvSI9os=;
 b=ma4PFVCSkulcVFsM6IKjcUTcubcPiK/Y3takDTz1XX6jYsudj8E5/RmQR1vZCtz3FQ0T
 yrx1kIhOvaPT2oWic5gXDK8xhJEu+kfPXAdvW6LGsJPA4sGVrq17is1jfvLGFToWChaU
 y6GTDI5H3DMhR/FYzHe+DP60/pVX7XUZuwfiXsnzc1KhuQ6oIBZfkgr49aFsZHK5KYHP
 dsy+ybcbNftKnn1DiVNl1CRtAN0AyGvb+5QADdbiGDUFaucPTsarH9hbPGVxvOMR/l22
 pi43taPddzKPZU3exTmzl3XYlEZpvsJN88D82VBYN4NoyeXp1cY9ryIgAYAUgQfuaFrB 4g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4te9rh2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:06:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FBVlui020403;
	Wed, 15 May 2024 13:06:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kd03v8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:06:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FD6QrW24969812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 13:06:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3071058070;
	Wed, 15 May 2024 13:06:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8DA058068;
	Wed, 15 May 2024 13:06:25 +0000 (GMT)
Received: from [9.61.107.19] (unknown [9.61.107.19])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 13:06:25 +0000 (GMT)
Message-ID: <3128df9c-0883-4aad-a959-76f175e8e9a4@linux.ibm.com>
Date: Wed, 15 May 2024 08:06:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] dt-bindings: fsi: fsi2spi: Document SPI controller
 child nodes
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-2-eajames@linux.ibm.com>
 <5e8eb8a7-c497-4960-8c1c-e58586f53c9f@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <5e8eb8a7-c497-4960-8c1c-e58586f53c9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6o8wOsYhCb8iLLCIcPeWZCkMHNww2G5H
X-Proofpoint-ORIG-GUID: 6o8wOsYhCb8iLLCIcPeWZCkMHNww2G5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150092


On 5/15/24 03:14, Krzysztof Kozlowski wrote:
> On 14/05/2024 21:54, Eddie James wrote:
>
>>   properties:
>>     compatible:
>> @@ -24,6 +23,17 @@ properties:
>>       items:
>>         - description: FSI slave address
>>   
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^spi@[0-9a-f]+$":
>> +    type: object
>> +    $ref: /schemas/spi/ibm,spi-fsi.yaml
> Are you sure you do not have dependencies? Nothing was explained about
> this in the cover letter or changelog.


I did mention that it depends on the SPI binding change below the commit 
message in this patch. I guess I should have kept these two together...

Thanks,

Eddie


>
> Best regards,
> Krzysztof
>

