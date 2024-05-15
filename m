Return-Path: <linux-kernel+bounces-179998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762D8C68AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BAD1C22059
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB013FD9C;
	Wed, 15 May 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jguI5Um/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9D13FD76;
	Wed, 15 May 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783331; cv=none; b=eIQWOs1pwmgY13jwfMrNXF5vQ8Tf4LOVvL8n3SCTf60z2DqSnk6kwZKNmPVO6H1fRDB/FYKpFxEhcbTtKQnnt4Xdo/0nrpJ0ygjNM6wVmCcEEEqyOYLCm3cydn9JCe9W2k2ifG7reDZi4HZWHyxQntELctfHh+oKzlHKGVZJgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783331; c=relaxed/simple;
	bh=X3ugixuFmBKbH+/wg1V0mJmlxSm09dgUnVw7YrwvAjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UGeahNrn16dNPar6gr+S0Dh1ZAvSoKLb8GCIl1JcYp2aQiuPvHigTOG7Jq39AkeQAliPx+GZ2mLL0XNC/+Oi0HclTulhLbP2CrXDA5HikRSN281eDuYnuXlajaMJUxt0jLgsfAsFK8xXwzjkWs8ZgbaExh40gbyjV/RvpJaCIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jguI5Um/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FERScT006433;
	Wed, 15 May 2024 14:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QdT6CG/5OFKK9w/WzsRK8OHNtwYZpkXWBaKtLQ+53xg=;
 b=jguI5Um/gEEUEv4ZkIXwnKVTYTd4EsyW1I/UN41RbhTInaxnGVUwPAd6ZiWZGssLMTAu
 RyPxjcP5ZHaD3xHaWFCRCnaRP1iglkNnkG9QVO857dzBsrcYel2yXAiJJQMlmcHhv8tm
 6SU8cycdbKj754uUFIyYMR2OY9aVH8GCaj8W+/Ef4NlcQOrSJ01Cej+5Xfc/uSiGZuJJ
 sfyO2ZWzDBXKUy0PZXqdp8CUfzvQG8PB06H/xPNRE98gKzCAj51T2g03WbQVRWfXR4sg
 Ee1ePyrnnRYkX8vemQiekfZwm4kmfv8Ef0J/jh7CNvlXcHEyYpDIiEupk7nCEcavJ5PF Yw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xtvr03x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:28:37 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FEJEQe018828;
	Wed, 15 May 2024 14:28:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tm93r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 14:28:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FESXv929360748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 14:28:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81EFF58059;
	Wed, 15 May 2024 14:28:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0524E58053;
	Wed, 15 May 2024 14:28:33 +0000 (GMT)
Received: from [9.61.107.19] (unknown [9.61.107.19])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 14:28:32 +0000 (GMT)
Message-ID: <a219f01e-a856-46cb-83c4-4fde99b8addd@linux.ibm.com>
Date: Wed, 15 May 2024 09:28:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] dt-bindings: fsi: Document the FSI controller
 common properties
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-6-eajames@linux.ibm.com>
 <9200e46a-3cb5-4363-a560-ee3d88e05ced@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <9200e46a-3cb5-4363-a560-ee3d88e05ced@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vw8CO38aYMjrGg8gTlgdHUreZq6_3bfN
X-Proofpoint-GUID: Vw8CO38aYMjrGg8gTlgdHUreZq6_3bfN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150101


On 5/15/24 09:18, Krzysztof Kozlowski wrote:
> On 14/05/2024 21:54, Eddie James wrote:
>> Since there are multiple FSI controllers documented, the common
>> properties should be documented separately and then referenced
>> from the specific controller documentation.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v4:
>>   - Add interrupt controller properties
>>   - Add clock-frequency property to FSI controller and CFAM
>>   - Add detail to chip-id property description
>>
>>   .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>> new file mode 100644
>> index 0000000000000..8620e4da6de77
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fsi/fsi-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: FSI Controller Common Properties
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description:
>> +  FSI (FRU (Field Replaceable Unit) Service Interface) is a two wire bus. The
>> +  FSI bus is connected to a CFAM (Common FRU Access Macro) which contains
>> +  various engines such as I2C controllers, SPI controllers, etc.
>> +
>> +properties:
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  '#interrupt-cells':
>> +    const: 1
>> +
>> +  clock-frequency:
>> +    minimum: 1
>> +    maximum: 200000000
> This is a deprecated property in general. Why did it appear? It does not
> exist in current bindings and nothing in commit msg suggests changes in
> the bindings themselves.


OK, is there some document that describes what properties are 
deprecated? Because it's used all over the place in the bindings. Anyway 
I need this property, I can rename it if you like. I can also update the 
commit message to indicate that I'm adding it.


Thanks,

Eddie



>
>> +
>> +  interrupt-controller: true
>> +
>> +  no-scan-on-init:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      The FSI controller cannot scan the bus during initialization.
>> +
>> +patternProperties:
>> +  "cfam@[0-9a-f],[0-9a-f]":
>> +    type: object
>> +    properties:
>> +      chip-id:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Processor index, a global unique chip ID which is used to identify
>> +          the physical location of the chip in a system specific way.
>> +
>> +      clock-frequency:
>> +        minimum: 1
>> +        maximum: 100000000
> Same question.
>
>
> Best regards,
> Krzysztof
>

