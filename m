Return-Path: <linux-kernel+bounces-180039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C92E8C692F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE611C223F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD93156236;
	Wed, 15 May 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qt4VBpKN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CF155A30;
	Wed, 15 May 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785412; cv=none; b=cnnEnkhrDPHfunI6mW1cexLceC5bvdUnAnERfTdcdNtMNYXO+FVDA7z8Y16w8/I8k4ShDgEhKQguvx3hDg4DFPhUHMocz5JDSVUtFozAuWo/1jUyBk39UMU+fmK5wpXN10l1ChJwFDb7BYil7T/JKDBQPtsETko3Ql5bxerg1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785412; c=relaxed/simple;
	bh=FAyHswWUFcqlFWsTaHBnDaW6jjNPZ3Kxz4mJcJOdT88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QkAOxYuGD+GhnvREgV+EVYctxiXeTdXUnucKmt34jN/JTPbWXjNeeFd1OXaZbbaDRmkLlquyhMIiiJZ/N3I1SnGoVGB+qDqkvqmKEX0bla8f15ifJka53soyhMIsa6EP5V9gqJqkzE4dFqPLJ8RSHOiXtWlx/e3xzuVVTKqOoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qt4VBpKN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FEjE7u021827;
	Wed, 15 May 2024 15:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Eg8ZNW6inA9pj/zfkTYeWUoHB8TFL+NlKQ+DAnY0S+c=;
 b=qt4VBpKN0mOcPzlw+NtXcZbmF28CLL+rbgoAP49dYuEfgLbg0AdnfxEXz3579vfRJAIN
 dHZjoQGYFUrsomi2LX5SgGs3uambuLRcuDo+vVp3hj93kcVTlCeFtlRosHzQnCLYMq3M
 bUXYOTCEI1J8NiqM+GwXPoUS6GfLajKhF+Al4s+p+gywEUuwTcctgnz59Cz+X6WZrF8O
 RAmsm2FUNlzHE1z9Ye4yddznXHttpACuNrjPZqt1iGOZvmuyoUWLuy0BMquFx1BhhxKe
 5IZ1EOhtW9XkZoyte5rFiRdqnVx8t3q9Yd5v+izslTJXx0OJrDp2g5ALAA1+AnNdyFfW Jg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4xab04wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 15:02:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FDlEHU018810;
	Wed, 15 May 2024 15:02:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tmevq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 15:02:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FF2nl028836554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 15:02:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52C058063;
	Wed, 15 May 2024 15:02:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2716958065;
	Wed, 15 May 2024 15:02:47 +0000 (GMT)
Received: from [9.61.107.19] (unknown [9.61.107.19])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 15:02:47 +0000 (GMT)
Message-ID: <80713a00-9574-4ae0-8af7-3fe12affcfc1@linux.ibm.com>
Date: Wed, 15 May 2024 10:02:46 -0500
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
 <a219f01e-a856-46cb-83c4-4fde99b8addd@linux.ibm.com>
 <eb6e2b5b-f341-404b-9215-6e80f21a6842@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <eb6e2b5b-f341-404b-9215-6e80f21a6842@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pxzVAUxyJtQ1j4uWStUiK28reHAGBwcK
X-Proofpoint-GUID: pxzVAUxyJtQ1j4uWStUiK28reHAGBwcK
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405150106


On 5/15/24 09:35, Krzysztof Kozlowski wrote:
> On 15/05/2024 16:28, Eddie James wrote:
>> On 5/15/24 09:18, Krzysztof Kozlowski wrote:
>>> On 14/05/2024 21:54, Eddie James wrote:
>>>> Since there are multiple FSI controllers documented, the common
>>>> properties should be documented separately and then referenced
>>>> from the specific controller documentation.
>>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> ---
>>>> Changes since v4:
>>>>    - Add interrupt controller properties
>>>>    - Add clock-frequency property to FSI controller and CFAM
>>>>    - Add detail to chip-id property description
>>>>
>>>>    .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++++++
>>>>    1 file changed, 66 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/fsi/fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>> new file mode 100644
>>>> index 0000000000000..8620e4da6de77
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>> @@ -0,0 +1,66 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/fsi/fsi-controller.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: FSI Controller Common Properties
>>>> +
>>>> +maintainers:
>>>> +  - Eddie James <eajames@linux.ibm.com>
>>>> +
>>>> +description:
>>>> +  FSI (FRU (Field Replaceable Unit) Service Interface) is a two wire bus. The
>>>> +  FSI bus is connected to a CFAM (Common FRU Access Macro) which contains
>>>> +  various engines such as I2C controllers, SPI controllers, etc.
>>>> +
>>>> +properties:
>>>> +  "#address-cells":
>>>> +    const: 2
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 0
>>>> +
>>>> +  '#interrupt-cells':
>>>> +    const: 1
>>>> +
>>>> +  clock-frequency:
>>>> +    minimum: 1
>>>> +    maximum: 200000000
>>> This is a deprecated property in general. Why did it appear? It does not
>>> exist in current bindings and nothing in commit msg suggests changes in
>>> the bindings themselves.
>>
>> OK, is there some document that describes what properties are
>> deprecated? Because it's used all over the place in the bindings. Anyway
> dtschema: dtschema/schemas/clock/clock.yaml
>
> buses anyway should use bus-frequency but it is also legacy one.
>
>> I need this property, I can rename it if you like. I can also update the
> Why do you need it? Why clocks cannot be chosen by drivers and initial
> state selected by assigned-clock-rates?


Well, I could use assigned-clock-rates, though it seems like I'd then 
have to implement the clock provider framework for both the FSI 
controller driver and the CFAM driver, which is a lot of extra work. FSI 
controller isn't really a clock provider, it's a bus like i2c (which 
uses clock-frequency), so it doesn't quite fit in my opinion...


Thanks for your detailed review Krzysztof,

Eddie


>
>
>> commit message to indicate that I'm adding it.
>
>
> Best regards,
> Krzysztof
>

