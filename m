Return-Path: <linux-kernel+bounces-554854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675ECA5A1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E2A174251
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71CE2356A2;
	Mon, 10 Mar 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IhehjCjt"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24377233725
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630471; cv=none; b=RU8bfoh649oGkEMFcsKNRC54eRK6YWfUHw+J5eSyK2KiIoAdCYGres53ibBIrCe8TUiMUq7+73zXN1cSAtxJG923RK+X12bfhkbYTMyB7ed7C0YiVu432Ccp4jdSzAkVE0fERUUnP0Se4bqQemORhJABTGDGlJlKKtxMStkHECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630471; c=relaxed/simple;
	bh=Az6X3nXxUvrPwsXz0EKPfQdrosxiIgR+lp2S0lY+RfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avQ9nxx4yCF4TeXNSp+Psx5odvGpXsKjaJaiTXLEDpbFYPqC7AIGACMkKWX0cXw/bDvRC+j05jPcyDHVzCNStgbj3/EWPUlg/8DnuaORf4vraiwccgp2/iX6w+PVUQKJdv2ahjk1/X9Q7i4AVjWQrYQaPBDIVuZ7i/jFboDxifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IhehjCjt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ACS3BB021499;
	Mon, 10 Mar 2025 18:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aKDbI3+YGJ6bMdW1QwFFc+EXWT7+Ji
	l57FacsSZ1fBA=; b=IhehjCjtDir8UAecMeUEAJMl1Hs54G4SNFWwZRzeeRH7OE
	qdq6FK3jvoQOCbbZ4QRVr8Tn/LvnDGuTESM/kK9mGYtqSazeGeC2JtFh0rUEW+q2
	b2GFIV8/9HkvknL0p0/RB+EZ4Thza480y8R56rj+M4PNmMOqlFE6s6uH2CLgQ8Yi
	Qgu6YZTUI7FL1bokGqxT4Xixp1vl5Jx6kLuoL6MXWz1iia+U75vLVZNnjz30s63s
	v9bcBLOEKMIkML+lYa6gl3taAqHoneHQw6GP6BBbzE0wFX1FpAy6zLRO284Ynn3g
	8UpHeCW4usII+KnN+WA4tdUMy0FyEOC18c48n2TQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042swr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 18:13:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52AIDn3N022209;
	Mon, 10 Mar 2025 18:13:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042swqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 18:13:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AH8wsr023888;
	Mon, 10 Mar 2025 18:13:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kyr5se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 18:13:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AIDkHV47972706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:13:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926AE20043;
	Mon, 10 Mar 2025 18:13:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FFDC2004E;
	Mon, 10 Mar 2025 18:13:46 +0000 (GMT)
Received: from localhost (unknown [9.179.22.167])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Mar 2025 18:13:46 +0000 (GMT)
Date: Mon, 10 Mar 2025 19:13:44 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, liam.howlett@oracle.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v3 5/6] maple_tree: add sufficient height
Message-ID: <your-ad-here.call-01741630424-ext-7048@work.hours>
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
 <20250227204823.758784-6-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227204823.758784-6-sidhartha.kumar@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HHbrunjQ8NBr49QfhYG8dEmYPX8WK_tO
X-Proofpoint-ORIG-GUID: xmaX0HPPsKfch8W7iTDe0WskxktTlma4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100140

On Thu, Feb 27, 2025 at 08:48:22PM +0000, Sidhartha Kumar wrote:
> In order to support rebalancing and spanning stores using less than the
> worst case number of nodes, we need to track more than just the vacant
> height. Using only vacant height to reduce the worst case maple node
> allocation count can lead to a shortcoming of nodes in the following
> scenarios.
...
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/maple_tree.h       |  4 +++-
>  lib/maple_tree.c                 | 17 +++++++++++++++--
>  tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)

Hi Sidhartha,

Starting from this commit, the LTP test "linkat02" consistently triggers
a kernel WARNING followed by a crash, at least on s390 (and probably on
other big-endian architectures as well). The maple tree selftest passes
successfully.

[  233.489583] LTP: starting linkat02
linkat02    0  TINFO  :  Using /tmp/ltp-8P2ZJL0mgN/LTP_lin3flG7N as tmpdir (tmpfs filesystem)
linkat02    0  TINFO  :  Found free device 0 '/dev/loop0'
[  234.187957] loop0: detected capacity change from 0 to 614400
linkat02    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.1 (20-May-2024)
[  234.571157] operation not supported error, dev loop0, sector 614272 op 0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
linkat02    0  TINFO  :  Mounting /dev/loop0 to /tmp/ltp-8P2ZJL0mgN/LTP_lin3flG7N/mntpoint fstyp=ext2 flags=0
[  234.690816] EXT4-fs (loop0): mounting ext2 file system using the ext4 subsystem
[  234.696090] EXT4-fs (loop0): mounted filesystem 29120d07-e10b-43b8-bfb0-6156683a2769 r/w without journal. Quota mode: none.
linkat02    0  TINFO  :  Failed reach the hardlinks limit
[  239.616047] ------------[ cut here ]------------
[  239.616231] WARNING: CPU: 0 PID: 669 at lib/maple_tree.c:1156 mas_pop_node+0x220/0x290
[  239.616252] Modules linked in:
[  239.616292] CPU: 0 UID: 0 PID: 669 Comm: linkat02 Not tainted 6.14.0-rc5-next-20250307 #29
[  239.616305] Hardware name: IBM 3931 A01 704 (KVM/Linux)
[  239.616315] Krnl PSW : 0704c00180000000 00007fffe2b6c314 (mas_pop_node+0x224/0x290)
[  239.616334]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  239.616349] Krnl GPRS: 0000000000000005 001c0feffc355f67 00007f7fe1aafb38 001c000000000000
[  239.616360]            001c000000000000 001c0fef00007f05 0000000000000000 ffffffffffffffff
[  239.616371]            00007f7fe1aaf3e0 00007f7fe1aafb08 001c000000000000 0000000000000000
[  239.616381]            0000000001026838 0000000000000005 00007f7fe1aaf020 00007f7fe1aaefc8
[  239.616399] Krnl Code: 00007fffe2b6c306: e370a0000024        stg     %r7,0(%r10)
[  239.616399]            00007fffe2b6c30c: a7f4ff83            brc     15,00007fffe2b6c212
[  239.616399]           #00007fffe2b6c310: af000000            mc      0,0
[  239.616399]           >00007fffe2b6c314: a7b90000            lghi    %r11,0
[  239.616399]            00007fffe2b6c318: a7f4ff89            brc     15,00007fffe2b6c22a
[  239.616399]            00007fffe2b6c31c: c0e5fefc1f8a        brasl   %r14,00007fffe0af0230
[  239.616399]            00007fffe2b6c322: a7f4ff4b            brc     15,00007fffe2b6c1b8
[  239.616399]            00007fffe2b6c326: c0e5fefc1fa5        brasl   %r14,00007fffe0af0270
[  239.616454] Call Trace:
[  239.616463]  [<00007fffe2b6c314>] mas_pop_node+0x224/0x290
[  239.616475]  [<00007fffe2b85ab6>] mas_spanning_rebalance+0x3006/0x4e90
[  239.616487]  [<00007fffe2b87e7a>] mas_rebalance+0x53a/0x9c0
[  239.616627]  [<00007fffe2b8c10a>] mas_wr_bnode+0x14a/0x1a0
[  239.616639]  [<00007fffe2b9a87c>] mas_erase+0xd9c/0x1120
[  239.616650]  [<00007fffe2b9acbe>] mtree_erase+0xbe/0xf0
[  239.616661]  [<00007fffe0c3b4d2>] simple_offset_remove+0x52/0x90
[  239.616674]  [<00007fffe093dc16>] shmem_unlink+0xb6/0x320
[  239.616686]  [<00007fffe0bc0830>] vfs_unlink+0x270/0x760
[  239.616698]  [<00007fffe0bd473a>] do_unlinkat+0x40a/0x5c0
[  239.616709]  [<00007fffe0bd4a48>] __s390x_sys_unlink+0x58/0x70
[  239.616720]  [<00007fffe0155356>] do_syscall+0x2f6/0x430
[  239.616733]  [<00007fffe2bd3668>] __do_syscall+0xc8/0x1c0
[  239.616746]  [<00007fffe2bf70d4>] system_call+0x74/0x98
[  239.616758] 4 locks held by linkat02/669:
[  239.616769]  #0: 0000780097e89450 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x4c/0xc0
[  239.616799]  #1: 00007800a7de6cd0 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: do_unlinkat+0x1f8/0x5c0
[  239.616831]  #2: 00007800a7de7ac0 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: vfs_unlink+0xc6/0x760
[  239.616860]  #3: 00007800a7de6a58 (&simple_offset_lock_class){+.+.}-{2:2}, at: mtree_erase+0xb4/0xf0
[  239.616886] Last Breaking-Event-Address:
[  239.616895]  [<00007fffe2b6c12a>] mas_pop_node+0x3a/0x290
[  239.616909] irq event stamp: 5205821
[  239.616918] hardirqs last  enabled at (5205831): [<00007fffe03d2be8>] __up_console_sem+0xe8/0x130
[  239.616931] hardirqs last disabled at (5205840): [<00007fffe03d2bc6>] __up_console_sem+0xc6/0x130
[  239.616943] softirqs last  enabled at (5200824): [<00007fffe0246b6c>] handle_softirqs+0x6dc/0xe30
[  239.616955] softirqs last disabled at (5200687): [<00007fffe024508a>] __irq_exit_rcu+0x34a/0x3f0
[  239.616994] ---[ end trace 0000000000000000 ]---
[  239.617009] Unable to handle kernel pointer dereference in virtual kernel address space
[  239.617019] Failing address: 0000000000000000 TEID: 0000000000000483
[  239.617029] Fault in home space mode while using kernel ASCE.
[  239.617049] AS:0000000005dac00b R2:00000001ffffc00b R3:00000001ffff8007 S:00000001ffff7801 P:000000000000013d
[  239.617150] Oops: 0004 ilc:3 [#1] PREEMPT SMP
[  239.617162] Modules linked in:
[  239.617170] CPU: 0 UID: 0 PID: 669 Comm: linkat02 Tainted: G        W           6.14.0-rc5-next-20250307 #29
[  239.617243] Tainted: [W]=WARN
[  239.617248] Hardware name: IBM 3931 A01 704 (KVM/Linux)
[  239.617253] Krnl PSW : 0704c00180000000 00007fffe2b6a988 (mab_mas_cp+0x168/0x640)
[  239.617264]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  239.617272] Krnl GPRS: 0000000000000008 0000000000000000 00007fff00000008 00007f7f00000009
[  239.617279]            0000000000000008 001c000000000000 0000000000000008 0000000000000048
[  239.617285]            001c0ffffc638e09 001c000000000009 0000000000000098 001c000000000000
[  239.617292]            0000000001026838 00007f7fe1aaf608 001c000000000013 00007f7fe1aaef68
[  239.617302] Krnl Code: 00007fffe2b6a97c: b90800e5            agr     %r14,%r5
[  239.617302]            00007fffe2b6a980: 9500e000            cli     0(%r14),0
[  239.617302]           #00007fffe2b6a984: a7740262            brc     7,00007fffe2b6ae48
[  239.617302]           >00007fffe2b6a988: e548a0000000        mvghi   0(%r10),0
[  239.617302]            00007fffe2b6a98e: e3a0f0c00004        lg      %r10,192(%r15)
[  239.617302]            00007fffe2b6a994: a7b80000            lhi     %r11,0
[  239.617302]            00007fffe2b6a998: eb2a0003000d        sllg    %r2,%r10,3
[  239.617302]            00007fffe2b6a99e: e320f0f00024        stg     %r2,240(%r15)
[  239.617350] Call Trace:
[  239.617354]  [<00007fffe2b6a988>] mab_mas_cp+0x168/0x640
[  239.617362]  [<00007fffe2b85bcc>] mas_spanning_rebalance+0x311c/0x4e90
[  239.617369]  [<00007fffe2b87e7a>] mas_rebalance+0x53a/0x9c0
[  239.617376]  [<00007fffe2b8c10a>] mas_wr_bnode+0x14a/0x1a0
[  239.617383]  [<00007fffe2b9a87c>] mas_erase+0xd9c/0x1120
[  239.617389]  [<00007fffe2b9acbe>] mtree_erase+0xbe/0xf0
[  239.617396]  [<00007fffe0c3b4d2>] simple_offset_remove+0x52/0x90
[  239.617403]  [<00007fffe093dc16>] shmem_unlink+0xb6/0x320
[  239.617410]  [<00007fffe0bc0830>] vfs_unlink+0x270/0x760
[  239.617416]  [<00007fffe0bd473a>] do_unlinkat+0x40a/0x5c0
[  239.617422]  [<00007fffe0bd4a48>] __s390x_sys_unlink+0x58/0x70
[  239.617429]  [<00007fffe0155356>] do_syscall+0x2f6/0x430
[  239.617436]  [<00007fffe2bd3668>] __do_syscall+0xc8/0x1c0
[  239.617443]  [<00007fffe2bf70d4>] system_call+0x74/0x98
[  239.617450] INFO: lockdep is turned off.
[  239.617454] Last Breaking-Event-Address:
[  239.617458]  [<00007fffe2b6a8f4>] mab_mas_cp+0xd4/0x640
[  239.617468] Kernel panic - not syncing: Fatal exception: panic_on_oops

