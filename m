Return-Path: <linux-kernel+bounces-179992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE68C688E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE312B22C07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B013F45D;
	Wed, 15 May 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iz3johUN"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AA6214D;
	Wed, 15 May 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783091; cv=none; b=f9g9gd60hM2f2A/gBu7UHkZ/FmtXB7heo/QDnLiFytWlzucoEU40gARswWqCvsBWlnPUqvBMkGd4FX3N1qjI71TG2v2ak3TRkuajWGU0a++W4X5Q5PVngd81U/C+XYqcBhFTumjU3npjal9GZ0OHju0ztQ/FcbdYEaRKHDfhEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783091; c=relaxed/simple;
	bh=jysTCSeSPP+d4LVZA/8WGJP2W+S2rHqhd5jJtb8il5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEsM+MlA3OYXQebIf3HosrbNBMAA9lK6KgVShn3Pb9uHl8m7r2Xkcv9jwbW4MVYHusS4CiCTyN5IS1fXDkAgbYkq+MBM7NFIUWTRyTxN4zWjZZrIOUfC50G9jVVb+oeYdFavsnSAGX4sb8FlvAI6K11MAFMvK//yKbOSDkun6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iz3johUN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FDrH1V024113;
	Wed, 15 May 2024 14:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UbWHN1sdtUzORelYPZPXsKZvcyObnhYrWi7LkONWmvs=;
 b=Iz3johUNNr3WMpuIiV7mlLfxroTo9Eu+dZeNDtWOR9AJ8Ho7MAS/7y31FOdhlRP4EpLl
 7n7pglR2rWV5miv3St5ERjjM+aVqOzV2Tz62oDMqRiIpKfodOxGmEdL4nCaCP4XI9YiC
 VdhVFgFVm+kHnFvY4/uJXu8Z8VRxYXgwBV3KYh1hy+PYHRuD/J+hFTw1NbaLCyM3CpcK
 Rmai6+p5BAdX+PjGEMIjrhIgjYVnoGh1PbYI5Bx7r3pPXVQYBuSas7w4sLfA8aH21tDK
 8QDLq4h2IB1jm2e3YjCH9O1p4optP5r/D4TL8VY54R5IXUvkkAmYNkOrRbgzYBPr2aq5 6Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xau82eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:24:35 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FC17Y3002257;
	Wed, 15 May 2024 14:24:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pc20c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:24:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FEOVpQ21824184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 14:24:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82A8858053;
	Wed, 15 May 2024 14:24:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0896058043;
	Wed, 15 May 2024 14:24:31 +0000 (GMT)
Received: from [9.61.107.19] (unknown [9.61.107.19])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 14:24:30 +0000 (GMT)
Message-ID: <4c370b26-9b23-4d14-961d-885f88dc4cd5@linux.ibm.com>
Date: Wed, 15 May 2024 09:24:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] dt-bindings: fsi: ast2600-fsi-master: Convert to
 json-schema
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-8-eajames@linux.ibm.com>
 <4f8a29a0-b31a-485a-90af-4a8df35fd48d@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <4f8a29a0-b31a-485a-90af-4a8df35fd48d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K49QThoSX65Z30F_TC7A2QfmB094GXMf
X-Proofpoint-ORIG-GUID: K49QThoSX65Z30F_TC7A2QfmB094GXMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405150100


On 5/15/24 09:21, Krzysztof Kozlowski wrote:
> On 14/05/2024 21:54, Eddie James wrote:
>> Convert to json-schema for the AST2600 FSI master documentation.
> Nothing explains dropping fsi-master compatible. Every deviation from
> conversion should be explained in the commit msg. Otherwise it is not
> conversion but a change...


The fsi-master compatible was not in the previous documentation. It was 
in the example, not in the description of what compatible strings are 
allowed, so this is a pure conversion.


Thanks,

Eddie


>
>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v4:
>>   - Remove the addition of the AST2700 compatible
> Best regards,
> Krzysztof
>

