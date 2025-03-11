Return-Path: <linux-kernel+bounces-555669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72DA5BB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F6170CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2A32222DD;
	Tue, 11 Mar 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBI+eHOG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88916225A59
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682860; cv=none; b=f23tZg4SSmXitdZZnIf1gyOPMjJ3tuzfSS+qfoZM/BCqvr4apFbq6xxQLN3cTbbgXVvm742b1cdNGTTk5aWzNS6uv9SvEBHrn7qtkGKm7UnxaEJkIOe0MXUvigOqEHe/2E9GM3KXa15x4G2CZGLIUZdraZYcMcUH0lj82SJqiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682860; c=relaxed/simple;
	bh=oZvqMeDxNsMGT+uCdRcvoUVLbqSeJlxX3YD1UX70p2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TI8sAMj/7wY4ebAJGwHeniAOUyPeTUsb4lwau3Gwz4qO2MzZkg6blKqDUPTFYU5f9kI7C9znzAXrJg510Oj8X6uDjutNp7sM3r38DuiJGBmrXkXC5WcKdTUKfETvHw8lNnHKReoQFpXsAjlAA9Li6R1uMmKPZhOR1L1Ov2GVGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBI+eHOG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B3kLgU002214;
	Tue, 11 Mar 2025 08:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1NEJHK
	reQRf8TYmEQtw7jBiV5M3M/i95+kR0z4U2GWs=; b=BBI+eHOGNAdwr6qQjjtnvN
	F9apyS7pbjUVj4tLXH2Ov0+FR9y4prd+DOulP8HPqihzMIhtHUoAR5qVzQ9ge104
	l1eRef/NyCLWlV31EFWsphLAqwMKQ0XEHrib9N7GV/I+djWbUzXoXlBpwsspo3Lm
	vKuiYVsqtZOu5Z87r+AXfZg4N9hqwXd2+FM2REqmb11qf/X8qPiyV0BL0+IcscsU
	RRQ4MO/jdsLBD3J9zQ07rg1LmydHH2XvEi+8HRNVTs1SNn04u95Kw6rLJECKEeU6
	AyK9ikY2tV30Zhi4ZCqrLPwcs+YOWJDG328y0DnwOGRXkN+nG+//eGhwEXnvbFVw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb1cvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:47:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7Y4Bp014527;
	Tue, 11 Mar 2025 08:47:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ekay60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:47:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52B8lNWm5243588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 08:47:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7241258062;
	Tue, 11 Mar 2025 08:47:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E32858045;
	Tue, 11 Mar 2025 08:47:21 +0000 (GMT)
Received: from [9.204.206.207] (unknown [9.204.206.207])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 08:47:21 +0000 (GMT)
Message-ID: <5cd65d1f-37ea-4051-82ea-e6879bfc288a@linux.ibm.com>
Date: Tue, 11 Mar 2025 14:17:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250307] Build Failure
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 58Ph_biZIyZmFrfEOkZx5D3hQ7fGbute
X-Proofpoint-GUID: 58Ph_biZIyZmFrfEOkZx5D3hQ7fGbute
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=976
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110057



On 3/9/25 6:08 PM, Venkat Rao Bagalkote wrote:
> Greetings!!,
> 
> I see linux-next-20250307 fails to build on IBM Power9 and Power10 servers.
> 
> 
> Errors:
> 
> In file included from ^[[01m^[[K<command-line>^[[m^[[K:
> ^[[01m^[[K./usr/include/cxl/features.h:11:10:^[[m^[[K ^[[01;31m^[[Kfatal error: ^[[m^[[Kuuid/uuid.h: No such file or directory
>    11 | #include ^[[01;31m^[[K<uuid/uuid.h>^[[m^[[K
>       |          ^[[01;31m^[[K^~~~~~~~~~~~~^[[m^[[K
> compilation terminated.
> make[4]: *** [usr/include/Makefile:85: usr/include/cxl/features.hdrtest] Error 1
> make[3]: *** [scripts/Makefile.build:461: usr/include] Error 2
> make[2]: *** [scripts/Makefile.build:461: usr] Error 2
> make[2]: *** Waiting for unfinished jobs....
> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call
> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
> make[1]: *** [/home/linux_src/linux/Makefile:1997: .] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> Please add below tag, if you happen to fix this issue.
> 

Fixes has been posted to handle these errors 

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/88876fb4e412203452e57d1037a1341cf15ccc7b.1741128981.git.christophe.leroy@csgroup.eu/
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/7aa7eb73fe6bc95ac210510e22394ca0ae227b69.1741128786.git.christophe.leroy@csgroup.eu/

and these are already part of powerpc/next-test, will be moved to powerpc/next soon

Maddy

> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> Regards,
> 
> Venkat.
> 
> 


