Return-Path: <linux-kernel+bounces-400012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564939C07B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6BA1C23A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410F21263F;
	Thu,  7 Nov 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KHSLFBw+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8A212179
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986685; cv=none; b=nh1Q5/k+jpxeXEE0RLqDM9yqpA28+FXzfUUvQo2N7V111ziQvvSFs4LDPToe8dOKnveCZ3qctT7WQjwtC04jNXlix6of1w40N4bzYR576iol/T2NJl1LwQoThvkSJryNrcnScH1IEzMlGOFLIz9EBxkW/Iptb0LFSnwLtrN7pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986685; c=relaxed/simple;
	bh=uTtxbK1KkHbSV7imncUwFD/GcVa5GjOETTtRUonhtG0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i79Zmgwk6slrlYJflFTrQm3tZWNgri4qjCVzk7J7qiqisRmh3VtIPH1t1YKVIYlBmLvOP/HDi8ZPW/QORlmylFqlp8SU8LL0W/9jPrEuI/aX5Tl5u+w/vi/zCzzFerigZHvi1H7ZFha960RKw5MR2npa4KpSo4sz/VcJx0YkQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KHSLFBw+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DACkD031874;
	Thu, 7 Nov 2024 13:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cpO2DR
	eB9Um5un2fBZB28pXP2mdRWx/P0qc5OUcuszg=; b=KHSLFBw+D0guHtIDTkEUFF
	P6US4otvhKg18lFonZAYmL/EOminirHHWKZKGlxwvOEhrUDPYzqpRUjIpoUpvkc2
	r1JJ9GOeVzTQOvtAj5eApVHwmDwQgtPKhKULhAFUwlt128kME+qjiG7H441PiANr
	T2QL2YdLEez/wV7uYSJncs0cpuvgN+9jx+MvcFGnS1P7aR/0NokNOHgIiymvroNG
	6kfX3qKqgVWsgqsjHfMSNwCRCf6HyUE/HIZ7PIwuLtNrnZts8W5VbCx3kx1fNnyU
	WEgsGCAkdGddkdiOTt53g8mg3UAxoHcVcu+DTFjbCHSzzMHLd6DAxyObzGC3GEDg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rx6pg3j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 13:37:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7Dbx9o031186;
	Thu, 7 Nov 2024 13:37:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rx6pg3hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 13:37:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A77207n013298;
	Thu, 7 Nov 2024 13:37:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmr9aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 13:37:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7DbvEQ28705464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 13:37:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7106558056;
	Thu,  7 Nov 2024 13:37:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5393958052;
	Thu,  7 Nov 2024 13:37:55 +0000 (GMT)
Received: from [9.171.53.204] (unknown [9.171.53.204])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 13:37:55 +0000 (GMT)
Message-ID: <6f0cd0ce-f217-4397-8785-7590d1e0e0e0@linux.ibm.com>
Date: Thu, 7 Nov 2024 19:07:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] cpumask: gcc 13.x emits compilation error on PowerPC
To: Brian Norris <briannorris@chromium.org>
Cc: kees@kernel.org, nathan@kernel.org, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, Gregory Joyce <gjoyce@ibm.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
 <CA+ASDXPKosUXy1x7Yvbu3pEYiMfDPSt69xt3Jq-zHw66yeUSRw@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CA+ASDXPKosUXy1x7Yvbu3pEYiMfDPSt69xt3Jq-zHw66yeUSRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6I1WU0t8p1DzAJfnl6smgNWsXbAuhZeA
X-Proofpoint-ORIG-GUID: Jbp61f5Cue1bCdhy13qBJFYQD_e8nntQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070106



On 11/6/24 23:30, Brian Norris wrote:
> Hi,
> 
> On Wed, Nov 6, 2024 at 5:02 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> Hi,
>>
>> Of late, I've been encountering the following compilation error while using GCC 13.x and latest upstream code:
>>
>> Compilation error:
>> ==================
>>   <snip>
>>   CC      kernel/padata.o
>> In file included from ./include/linux/string.h:390,
>>                  from ./arch/powerpc/include/asm/paca.h:16,
>>                  from ./arch/powerpc/include/asm/current.h:13,
>>                  from ./include/linux/thread_info.h:23,
>>                  from ./include/asm-generic/preempt.h:5,
>>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>>                  from ./include/linux/preempt.h:79,
>>                  from ./include/linux/spinlock.h:56,
>>                  from ./include/linux/swait.h:7,
>>                  from ./include/linux/completion.h:12,
>>                  from kernel/padata.c:14:
>> In function ‘bitmap_copy’,
>>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>>   114 | #define __underlying_memcpy     __builtin_memcpy
>>       |                                 ^
> 
> FWIW, I think Kees already was fielding a similar report a few days ago:
> 
> Re: Fortify compilation warning in __padata_set_cpumask()
> https://lore.kernel.org/all/202411021337.85E9BB06@keescook/
> 
Thanks for this pointer! This one appears exactly similar to what I encountered on PowerPC. 

> IIUC, he was hoping for better compiler diagnostics to help out there.
Hmm ok
> 
> (Also, I imitated Thomas's .config notes from that report and couldn't
> reproduce with my GCC 13.2.0.)
> 
> I also happen to see there are a few scattered instances of either
> disabling or working around -Wstringop-overread false positives in the
> tree today.
> 
So shall we wait until we get better diagnostics from GCC or can we bypass this 
error temporarily with either using __NO_FORTIFY (as I proposed  in my another 
email) or disable -Wstringop-overread for kernel/padata.c file? Later when we 
find a better fix, we may then revert this change. 

Thanks,
--Nilay

