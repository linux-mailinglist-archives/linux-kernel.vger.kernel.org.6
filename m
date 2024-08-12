Return-Path: <linux-kernel+bounces-283512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E194F5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C142282F24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE318800E;
	Mon, 12 Aug 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqwHgrmA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD345191
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483990; cv=none; b=gY+tXFZOF1hWlpJubIkmMy5PGzzBi7sQbYsMW8kmRFzSQJMPnqjyeI6Nn0xp4wp1C5tAVi6t9BcP/GlCRb2MfArsVdU6H+4t7kJ6uSzfPg+kA1kyShSuEr9YIsBNitxxqUCkw/IZO8nAOHltdElwYeN3Yh+N9I0A9mswojNsNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483990; c=relaxed/simple;
	bh=ZNMTgLSJGLtMqLJ0VptIct+dwjBGcG/7CQ74HRTh41M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwRiB+Q9h/ZZSCed1fZVv6aQ6hMFxFgSGm3mXtMN/DUVHbF6mUDpNVpaopjFBt6TUSX4aMCpMOlqt36zN9NMB22bKh4yrgy+JIDD4Q1rq9hFORBHtKThuyidRyrSIbJpM1KktyOdjQmuJKSb0RCgDHL5V9duPlIexzBDXn4T2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DqwHgrmA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDuhwB021077;
	Mon, 12 Aug 2024 17:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
	/pIHPGukFww5UVBkbeqCpVhGCIB3kKpYWQiZ6H3wMQ=; b=DqwHgrmAOm+1QSATX
	8mNVaoOtb0gGIm5DtI2ihslwecamF08CWBhIXdQK9+DSvH0CLmujTQFJ2d9I38lu
	TMulQdrdrB7SkuKhHhIREgvG4DjbLdMWC70qgNmXYhfpcSsDTFY0e/1VIrZfLRsp
	3c7VdID8m/xLBWXSbC2KT6+SQKJRxtaUdfUqPlhz+3Ea1Nfx9Tk/lQgFJS9O2NIY
	jTkOL4Y16npNNJbJkUfCET0awRMJQYA5tw3DY9iUmEAXSqcbeTy9A07hIsb9wqjO
	y9abaE92nDD3GkEcoIvu9OL2t9N8knDFospkJGFGjzWOVvMgfRjYpJkpUUsU4E2W
	dY/eg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpnj7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 17:32:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47CHWRAx007792;
	Mon, 12 Aug 2024 17:32:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpnj7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 17:32:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47CFHeSP016309;
	Mon, 12 Aug 2024 17:32:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhpfgdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 17:32:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47CHWNnR57278934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 17:32:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B0320040;
	Mon, 12 Aug 2024 17:32:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 816EC2004D;
	Mon, 12 Aug 2024 17:32:20 +0000 (GMT)
Received: from [9.124.215.101] (unknown [9.124.215.101])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Aug 2024 17:32:20 +0000 (GMT)
Message-ID: <1a973dda-c79e-4d95-935b-e4b93eb077b8@linux.ibm.com>
Date: Mon, 12 Aug 2024 23:02:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
 <87msn785f0.fsf@oracle.com> <87sewzkjy5.fsf@mail.lhotse>
 <e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com>
 <87sewr6o5w.fsf@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <87sewr6o5w.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uHSaCvOqvOSaywXq-kSPLkaiy7DYphBc
X-Proofpoint-GUID: k7keq3FgG7ILWn0WXoblt8lWuTC2dQ4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_10,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=680
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408120126



On 7/3/24 10:57, Ankur Arora wrote:
> 
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 

Hi.
Sorry for the delayed response.

I could see this hackbench pipe regression with preempt=full kernel on 6.10-rc kernel. i.e without PREEMPT_AUTO as well.

There seems to more wakeups in read path, implies pipe was more often empty. Correspondingly more contention
is there on the mutex pipe lock in preempt=full. But why, not sure. One difference in powerpc is page size. but
here pipe isn't getting full. Its not the write side that is blocked.



preempt=none: Time taken for 20 groups  in seconds        : 25.70
preempt=full: Time taken for 20 groups  in seconds        : 54.56

----------------
hackbench (pipe)
----------------
top 3 callstacks of __schedule collected with bpftrace.

			preempt=none								preempt=full

     __schedule+12                                                                  |@[
     schedule+64                                                                    |    __schedule+12
     interrupt_exit_user_prepare_main+600                                           |    preempt_schedule+84
     interrupt_exit_user_prepare+88                                                 |    _raw_spin_unlock_irqrestore+124
     interrupt_return_srr_user+8                                                    |    __wake_up_sync_key+108
, hackbench]: 482228                                                               |    pipe_write+1772
@[                                                                                 |    vfs_write+1052
     __schedule+12                                                                  |    ksys_write+248
     schedule+64                                                                    |    system_call_exception+296
     pipe_write+1452                                                                |    system_call_vectored_common+348
     vfs_write+940                                                                  |, hackbench]: 538591
     ksys_write+248                                                                 |@[
     system_call_exception+292                                                      |    __schedule+12
     system_call_vectored_common+348                                                |    schedule+76
, hackbench]: 1427161                                                              |    schedule_preempt_disabled+52
@[                                                                                 |    __mutex_lock.constprop.0+1748
     __schedule+12                                                                  |    pipe_write+132
     schedule+64                                                                    |    vfs_write+1052
     interrupt_exit_user_prepare_main+600                                           |    ksys_write+248
     syscall_exit_prepare+336                                                       |    system_call_exception+296
     system_call_vectored_common+360                                                |    system_call_vectored_common+348
, hackbench]: 8151309                                                              |, hackbench]: 5388301
@[                                                                                 |@[
     __schedule+12                                                                  |    __schedule+12
     schedule+64                                                                    |    schedule+76
     pipe_read+1100                                                                 |    pipe_read+1100
     vfs_read+716                                                                   |    vfs_read+716
     ksys_read+252                                                                  |    ksys_read+252
     system_call_exception+292                                                      |    system_call_exception+296
     system_call_vectored_common+348                                                |    system_call_vectored_common+348
, hackbench]: 18132753                                                             |, hackbench]: 64424110
                                                                                                                                                                 



--------------------------------------------
hackbench (messaging) - one that uses sockets
--------------------------------------------
Here there is no regression with preempt=full.

preempt=none: Time taken for 20 groups  in seconds        : 55.51
preempt=full: Time taken for 20 groups  in seconds        : 55.10


Similar bpftrace collected for socket based hackbench. highest caller of __schedule doesn't change much.

	preempt=none                                                                             preempt=full


                                                                                    |    __schedule+12
                                                                                    |    preempt_schedule+84
                                                                                    |    _raw_spin_unlock+108
@[                                                                                 |    unix_stream_sendmsg+660
     __schedule+12                                                                  |    sock_write_iter+372
     schedule+64                                                                    |    vfs_write+1052
     schedule_timeout+412                                                           |    ksys_write+248
     sock_alloc_send_pskb+684                                                       |    system_call_exception+296
     unix_stream_sendmsg+448                                                        |    system_call_vectored_common+348
     sock_write_iter+372                                                            |, hackbench]: 819290
     vfs_write+940                                                                  |@[
     ksys_write+248                                                                 |    __schedule+12
     system_call_exception+292                                                      |    schedule+76
     system_call_vectored_common+348                                                |    schedule_timeout+476
, hackbench]: 3424197                                                              |    sock_alloc_send_pskb+684
@[                                                                                 |    unix_stream_sendmsg+444
     __schedule+12                                                                  |    sock_write_iter+372
     schedule+64                                                                    |    vfs_write+1052
     interrupt_exit_user_prepare_main+600                                           |    ksys_write+248
     syscall_exit_prepare+336                                                       |    system_call_exception+296
     system_call_vectored_common+360                                                |    system_call_vectored_common+348
, hackbench]: 9800144                                                              |, hackbench]: 3386594
@[                                                                                 |@[
     __schedule+12                                                                  |    __schedule+12
     schedule+64                                                                    |    schedule+76
     schedule_timeout+412                                                           |    schedule_timeout+476
     unix_stream_data_wait+528                                                      |    unix_stream_data_wait+468
     unix_stream_read_generic+872                                                   |    unix_stream_read_generic+804
     unix_stream_recvmsg+196                                                        |    unix_stream_recvmsg+196
     sock_recvmsg+164                                                               |    sock_recvmsg+156
     sock_read_iter+200                                                             |    sock_read_iter+200
     vfs_read+716                                                                   |    vfs_read+716
     ksys_read+252                                                                  |    ksys_read+252
     system_call_exception+292                                                      |    system_call_exception+296
     system_call_vectored_common+348                                                |    system_call_vectored_common+348
, hackbench]: 25375142                                                             |, hackbench]: 27275685



