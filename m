Return-Path: <linux-kernel+bounces-250265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392B92F5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B47B21188
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCBB13D622;
	Fri, 12 Jul 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oHk5bmR0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E713D606
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767484; cv=none; b=NA/heNaHFIpUVqVUcddApqdcJca7bTI38jH9Ny/AYSybRWMlbysYEEQEBwFFUqOF+PvIH83YE1c510XwXu5ThrfWpQ650PHAMOZ9UqV7G+6F6brU2aKbC0XV0jF8Hi/eb/f19IaDNVZc7IOEkCbOywBH15M7guQJ0BQPj/IeDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767484; c=relaxed/simple;
	bh=ieyKAhbt+lIipFZ47eBGZp7oX0CiDC2hFslH7TJnkOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFX8TlW2VHXae5KrezP+h/QhPecSJN3yuXgE2kxqr42+VgaSq4/JIMrJ+WayTCrHKf/B2SWcd+CsmhVeUI26jFd2etDXnP+LqbKuzp0hStR4y3tFE1S8EmZ0yMY+voMcy09rk727EqSS95n/sNwbsFFE0FSvvED1nL8oGlrOJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oHk5bmR0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C6vopL024405;
	Fri, 12 Jul 2024 06:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	M7gzbLnnGVnh80CAsF+l/k3aXOGnGr5FYMa/ZtXw5w=; b=oHk5bmR03qPGeYP+L
	B9/GDEejbz0/Dh8fxLQ9OdNyFFDDcdjCvzlPGq1sfLb34p32KRrIV3PtD40bDutu
	tEs1aKy8XT0ub6R6H39opkfqnR9P5jsqR6oFFND54T2i09jfobksZ7qZYIe71eiK
	pjEcvz8oIQt/Bk/JbmMgw2ChH2fH+Yf7tgLUy1Wb3LuDABpn15WuiWdrls/hp95w
	ipCcUS9KBRQGwQj5MLCjRL+Rbuc5Snj8Q53y5CpGCjE1ITv26BeCXZ6Biz2xKtPl
	PkTY68ne8UJ3qfQwGSxjG6heE/BaJv9LHOvgWMcTo+nvzz/k1wsVrdrA7cUrBz+4
	+Fexg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40avm00h7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:57:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C6Wkou024599;
	Fri, 12 Jul 2024 06:54:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrn52k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:54:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46C6sKg156361314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 06:54:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 697EC20049;
	Fri, 12 Jul 2024 06:54:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC1C20040;
	Fri, 12 Jul 2024 06:54:18 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 06:54:18 +0000 (GMT)
Message-ID: <68d0328d-531a-4a2b-ab26-c97fd8a12e8b@linux.ibm.com>
Date: Fri, 12 Jul 2024 12:24:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <petr@tesarici.cz>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
 <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
 <20240712082124.272e079f@meshulam.tesarici.cz>
 <06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
 <20240712084826.3128cba2@mordecai.tesarici.cz>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240712084826.3128cba2@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iqj4ZjiX9l0jMc1WGu3CVHFw32yDLriF
X-Proofpoint-GUID: Iqj4ZjiX9l0jMc1WGu3CVHFw32yDLriF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_04,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=682
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120046



On 12/07/24 12:18, Petr Tesarik wrote:
> On Fri, 12 Jul 2024 12:01:29 +0530
> Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>
>> Hello Petr,
>>
>> On 12/07/24 11:51, Petr Tesařík wrote:
>>> On Fri, 12 Jul 2024 10:00:09 +0530
>>> Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>>>   
>>>> Hello Petr,
>>>>
>>>> Just want to mentioned few points about the commit message. No strong
>>>> opinion on changing the commit message.
>>>>
>>>> On 11/07/24 16:04, Petr Tesarik wrote:
>>>>> From: Petr Tesarik <ptesarik@suse.com>
>>>>>
>>>>> There is no reason to restrict access to this attribute, as it merely
>>>>> reports whether crash elfcorehdr is automatically updated on CPU hot
>>>>> plug/unplug and/or online/offline events.
>>>> Now, it is not just elfcorehdr; there could be multiple kexec segments
>>>> based on the architecture's needs.
>>>> For example, on PowerPC, it is elfcorehdr and FDT.
>>> Right. I am even working with a PowerVM LPAR on an L922 system now. ;-)
>>>
>>> OTOH I was just too lazy to invent my own description, so I took it
>>> from Documentation/ABI/testing/sysfs-devices-system-cpu. That one
>>> could be improved. And a couple of other places... Expect a patch.
>> Thanks for point it out, I will send a patch to fix the ABI document for
>> crash_hotplug and other places in the kernel. Thanks,
> Oh, I was planning to do that, but if you want to send a patch
> yourself, I won't duplicate efforts. There are other cleanups on my
> TODO list.

Yes, I will take care of this.

Thanks,
Sourabh Jain

