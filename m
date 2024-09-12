Return-Path: <linux-kernel+bounces-326152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88649763DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915DE2851F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D518F2DD;
	Thu, 12 Sep 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WMj64vR/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16541189BA5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128240; cv=none; b=o02f82BSNufO/24+JIVT+m5uvcbiqSWJeTBBqRCSVaCLDyvlkrS0dvShFnfvd4uEt1SkgQesd/nd9nSk2T5v7NhTH8NUXU72UbReTQV2c27h8IPRSq0UeET8cJ8euoKlsxvaE5F1vCbujKBB3C3UGcCM8ufLa6XFpo5YkU2qEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128240; c=relaxed/simple;
	bh=AlXxuP1UObQBFKY+VptOImAhmc7gEv6X/O7Zb8Ya0II=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jxh+dzSbepTJIFwcKEYlPHASCazh7ooSl4fqMyKeOKKmaIZnYD1Hwjl6G4e5UPXkG+24AVHGMAOz02D+3aT/Y1p8pZs3HmEat5kzBWjSBkQVMx/zhUp4S7mwo04GjXCMpiIKraImG6y5SC+1763ApLQTKsmpLiz7FjZRLsehTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WMj64vR/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMdOZb025206;
	Thu, 12 Sep 2024 08:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	oYpDSObymtP5trr0Dg3dxQpCaFYppzt85CDjuduwHw4=; b=WMj64vR/seYiXMx8
	nXRJ085pVG5oNXnL+JMhlh/DUT4v/J1X8uk2AjD/ylvQz0heepRoK4QwibbmaFYw
	RNuqMwvu0Tk9s1NQoHR3jYNwc20WwtaKXmO7h8aNK7Yp8lXGc3fg3SxtnsXf9u85
	ZlW2/xJ4ldWDtCPlS6dLx5ghAzidnKEsLdCaJInbYleJIppYlJU3ERLjO0VDpfa7
	fUyXBg3lD/pf1hnUAlFthQf+c5lwtu+sUjFZYyo3IRq0jspQXIp+SKzYVkNhaZlw
	F2hA1JUhN6oy5DKaM3kngv+ADL7pwDKU2aUFsrT+PXd+kR1oqfPTrzpG8rti5ChU
	rW/Abw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyt16t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:03:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C83eC9025017;
	Thu, 12 Sep 2024 08:03:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyt16p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:03:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C5jH8K003122;
	Thu, 12 Sep 2024 08:03:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15u6rhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:03:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48C83cX18651188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 08:03:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74D4A20043;
	Thu, 12 Sep 2024 08:03:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26562004B;
	Thu, 12 Sep 2024 08:03:33 +0000 (GMT)
Received: from [9.43.115.177] (unknown [9.43.115.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Sep 2024 08:03:33 +0000 (GMT)
Message-ID: <f4dcb6b4-2da8-4355-9d89-8b41af30214d@linux.ibm.com>
Date: Thu, 12 Sep 2024 13:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] kexec/crash: no crash update when kexec in
 progress
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
 <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tq5vb7peLAjR_5_8qxwGwQdcYnON-O-e
X-Proofpoint-ORIG-GUID: Gdw-KrRH0ymkfw_x-UoPGfWRmIMBalgj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120055

Hello Baoquan,

On 11/09/24 19:50, Baoquan He wrote:
> On 09/11/24 at 04:51pm, Sourabh Jain wrote:
>> The following errors are observed when kexec is done with SMT=off on
>> powerpc.
>>
>> [  358.458385] Removing IBM Power 842 compression device
>> [  374.795734] kexec_core: Starting new kernel
>> [  374.795748] kexec: Waking offline cpu 1.
>> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  374.935833] kexec: Waking offline cpu 2.
>> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> snip..
>> [  375.515823] kexec: Waking offline cpu 6.
>> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  375.695836] kexec: Waking offline cpu 7.
>>
>> To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
>> are offline are brought online during kexec. For more information, refer
>> to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
>> kexec"). Bringing the CPUs online triggers the crash hotplug handler,
>> crash_handle_hotplug_event(), to update the kdump image. Since the
>> system is on the kexec kernel boot path and the kexec lock is held, the
>> crash_handle_hotplug_event() function fails to acquire the same lock to
>> update the kdump image, resulting in the error messages mentioned above.
>>
>> To fix this, return from crash_handle_hotplug_event() without printing
>> the error message if kexec is in progress.
>>
>> The same applies to the crash_check_hotplug_support() function. Return
>> 0 if kexec is in progress because kernel is not in a position to update
>> the kdump image.
> LGTM, thanks.
>
> Acked-by: Baoquan he <bhe@redhat.com>

Thank you for the Ack!

My understanding is that this patch will go upstream via the linux-next 
tree, as it is based on 
https://lore.kernel.org/all/20240902034708.88EC1C4CEC2@smtp.kernel.org/ 
which is already part of the linux-next master branch. - Sourabh Jain

