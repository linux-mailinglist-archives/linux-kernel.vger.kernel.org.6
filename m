Return-Path: <linux-kernel+bounces-259578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2E9398CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E6A1F2272C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD3D13B5B9;
	Tue, 23 Jul 2024 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QuCxIsGN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92B2F2A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721707338; cv=none; b=nUVhlQ06JdmbAh07fZKZR6tmEg9+8XNblkTf9QjasW18J0UnqA8xjcWFLn0tRXBxePZHk5cDhPbB/eWLmt0iJ1R1PhtgUC3IhWWl5AuXD2znwjfG8pQnsm2TDTSjjI7vezYoYE9iV/kS6GI86+nN7ly4KFAKcn2Yl0ZVdE71w2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721707338; c=relaxed/simple;
	bh=Avn0+3iLRruUv1ilE6xNHUJuStzLUxXgHLfOfKjcPRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=IKOdVmZtRQZ6BO6PHZkaxsuDhWs4L2NUiRbe5S7QnXi+2ropuNHozqATV2d11wl+pZrhmRcfQ/Nz7BdlrfItoHZJEw0gW5V3dANODpv8X2BNjTzNob7AFX9ZaYGKgNpnnpmNENcBFbCZv+AkPnbXdiBzqp7qKS64eDKQf7yn9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QuCxIsGN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N3vbd8026227;
	Tue, 23 Jul 2024 04:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:from:subject:to:content-type
	:content-transfer-encoding; s=pp1; bh=xK8bDYo3Wg9wXSAPraLH30XZgs
	yLCh6pjokjNEWHwhI=; b=QuCxIsGNjdBR13ZCh9fixDH9rAFiDC60+/770He9le
	ci7OemPzltr7jgG5oJu0NrOQU1dfmgSqU2WDzhpdV9savrogTjuG5K9Vv1MjRWQr
	8y0yli2Z5ruqu5jLD3QKhUwkh8Qg6UqGsQtHCUxqClv+vG6w174LkYMFW5DIb/Mi
	5Kkq+ZE+705g3RWpbLE6OfyM+cpmrkMaP7SkgKLzLHTBW5S7tX0UtDDESXLlqdIt
	BBDP12ciwUh8YOP6qQxF5RYvPYK7/DzgYHt3mMd2BaVuNh/kjRbffCVUhvFHcNAi
	7PWgD66FMjiA/GVukF/9OVQWJNTepeo1yYdI4UvylhQA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j1jsrb82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 04:01:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N2689s006236;
	Tue, 23 Jul 2024 04:01:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjua1h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 04:01:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N41pOQ64225732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 04:01:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A686F5805A;
	Tue, 23 Jul 2024 04:01:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38A825805E;
	Tue, 23 Jul 2024 04:01:49 +0000 (GMT)
Received: from [9.43.42.215] (unknown [9.43.42.215])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 04:01:48 +0000 (GMT)
Message-ID: <81b8966a-5c11-4413-a57f-fa2216b15b15@linux.vnet.ibm.com>
Date: Tue, 23 Jul 2024 09:31:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [Linux-next-6-10-20240722][PowerPC] Observing Kernel Warnings at
 kernel/time/timer_migration.c:1714
To: anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WDgSXtJ5Ai5l3rQQ72ybvsFXBkRW6mM4
X-Proofpoint-ORIG-GUID: WDgSXtJ5Ai5l3rQQ72ybvsFXBkRW6mM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=542
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230027

Greetings!!!


Observing kernel warnings at kernel/time/timer_migration.c:1714 while 
booting with linux-next-6-10-20240722 kernel on PowerPC system.


[    0.006496] ------------[ cut here ]------------
[    0.006500] WARNING: CPU: 0 PID: 1 at 
kernel/time/timer_migration.c:1714 tmigr_cpu_prepare+0x130/0x154
[    0.006507] Modules linked in:
[    0.006510] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.10.0-next-20240722-auto #1
[    0.006514] Hardware name: IBM,9009-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
[    0.006515] NIP:  c00000000029ac10 LR: c00000000016c4b4 CTR: 
c00000000029aae0
[    0.006517] REGS: c0000000bb4c7740 TRAP: 0700   Not tainted 
(6.10.0-next-20240722-auto)
[    0.006519] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
2800428f  XER: 0000000d
[    0.006527] CFAR: c00000000029ab24 IRQMASK: 0
[    0.006527] GPR00: c00000000016c4b4 c0000000bb4c79e0 c0000000015a3d00 
0000000000000000
[    0.006527] GPR04: 0000000000000040 0000000000000001 0000000000000000 
0000000000000000
[    0.006527] GPR08: 00000007fadd0000 c00000000223c1b8 c000000002cfa568 
c000000002cfa568
[    0.006527] GPR12: c00000000029aae0 c000000003020000 c0000000000112ac 
0000000000000000
[    0.006527] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.006527] GPR20: 0000000000000000 c000000002d0b210 c000000002c71e88 
c0000007fd007808
[    0.006527] GPR24: 0000000000000000 c00000000029aae0 c00000000029aae0 
00000007fadd0000
[    0.006527] GPR28: c000000002d0c000 c000000002237808 c0000007fd00c1b8 
0000000000000000
[    0.006553] NIP [c00000000029ac10] tmigr_cpu_prepare+0x130/0x154
[    0.006557] LR [c00000000016c4b4] cpuhp_invoke_callback+0x1e4/0x7e8
[    0.006562] Call Trace:
[    0.006563] [c0000000bb4c79e0] [80000000ffff8000] 0x80000000ffff8000 
(unreliable)
[    0.006567] [c0000000bb4c7a20] [c0000000bb4c7af8] 0xc0000000bb4c7af8
[    0.006569] [c0000000bb4c7ab0] [c00000000016d200] 
cpuhp_issue_call+0x210/0x274
[    0.006572] [c0000000bb4c7b00] [c00000000016d82c] 
__cpuhp_setup_state_cpuslocked+0x1c4/0x3b0
[    0.006576] [c0000000bb4c7bc0] [c00000000016de1c] 
__cpuhp_setup_state+0xb8/0x1d8
[    0.006580] [c0000000bb4c7c20] [c0000000020496a0] tmigr_init+0x1b0/0x254
[    0.006586] [c0000000bb4c7c90] [c000000000010e78] 
do_one_initcall+0x60/0x398
[    0.006589] [c0000000bb4c7d70] [c000000002006ec4] 
kernel_init_freeable+0x1d4/0x370
[    0.006595] [c0000000bb4c7de0] [c0000000000112d8] kernel_init+0x34/0x26c
[    0.006598] [c0000000bb4c7e50] [c00000000000df7c] 
ret_from_kernel_user_thread+0x14/0x1c
[    0.006600] --- interrupt: 0 at 0x0
[    0.006602] Code: e8010050 eb810020 eba10028 3920ffea 38210040 
ebc1fff0 2c0a0000 7c0803a6 7c69f89e ebe1fff8 7c6307b4 4e800020 
<0fe00000> 4bffff14 60000000 60000000
[    0.006612] ---[ end trace 0000000000000000 ]---


Bad Commit: 07d1022d1680b34a14e6390e3fa978f00c82dae4.


Reverting the above commit, issue is not seen.


Regards,

Venkat.


