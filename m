Return-Path: <linux-kernel+bounces-571075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB6A6B8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E69716E23E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0071F2361;
	Fri, 21 Mar 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQsj3Ffq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EC1E3DDB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553032; cv=none; b=FPQfTrHFCfAYlHUnSEl8lfKBp/81b2pM2GKvzOKsvhTlPysH6tPg775DJeHGbDYvf/hejYDTiPT+1J4oSzEBI4lhpCalJBR4FiB5V9eUGwnCmXkhzHJVyUVjiwSAtbRootRcIAyOOPBMExyccaqIXaFkyC2DJh3nOb/fRH55IGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553032; c=relaxed/simple;
	bh=3220tbLZvMQJgycQ/BhCyBX+3nwC9mWgdofjrs97jlI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=JTmhcAGJtGPu77uV7df0sUzA2/E++ztg3UPXyXRVAtHxp7wMruV8NRkbe0bm7R0e77IRc3ZOeANXetJ0V2adEGhnbNWrA8L9RK5PTPimoPKHAf2nMdWggXgzUIjn+6tCiurAI8XYUgUoSIwGDOMeUMR3HSIfZVkA6EM1vRuwuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQsj3Ffq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L1KIHE030525;
	Fri, 21 Mar 2025 10:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qPrhNt
	G5kUgPX7EY3IhX4pYwpWOMQOkxgK/1inO6WEE=; b=lQsj3FfqC+tKNMJRn5YDkJ
	nu3Yw2RAxFNGKgDUQE5DDUyFpEkO8bq5bcZIN0glKEYDhSKl3w7lQaUKBCP94oQM
	T1Uxs06B+ShEDArv2i+Wc0WZ5H+x6MuQ43vCytSiCZABEwJPArCxIKh2oQ02Ycbo
	BIUgsi7LU+7LbSOSksohZ5OlgJMjm1BfHyrRzC+LdNKynTaTShBdmjLcMQyyZqgB
	exy5NOwcBAO9GjBXLhny3QV4L9NHExow7fl5ZgQBeicR2kbURrRAOwaN7s6m4G1g
	JSmm+BxZruQyYf6jWo3w7cQcvZfgH//xll5RFmlbW94o4U4R6Z6BZ8nm/FEzoZoA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21wvja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:30:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8uP1O023208;
	Fri, 21 Mar 2025 10:30:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3m4mqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:30:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52LAUNLl32440620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:30:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 315925805C;
	Fri, 21 Mar 2025 10:30:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B84145806A;
	Fri, 21 Mar 2025 10:30:21 +0000 (GMT)
Received: from [9.61.240.173] (unknown [9.61.240.173])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 10:30:21 +0000 (GMT)
Message-ID: <99ad46fd-71cf-4e3d-8632-f22960aec4a2@linux.ibm.com>
Date: Fri, 21 Mar 2025 16:00:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>, riteshh@linux.ibm.com
References: <e4b1ccf8-c626-4683-82db-219354a27e61@linux.ibm.com>
In-Reply-To: <e4b1ccf8-c626-4683-82db-219354a27e61@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jYsY48JzYY32QnJSkkOKScWcM8Ijr4ZK
X-Proofpoint-GUID: jYsY48JzYY32QnJSkkOKScWcM8Ijr4ZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210077


On 21/03/25 3:50 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
>
> I am observing Kernel oops while running brtfs/108 TC on IBM Power 
> System.
>
> Repo: Linux-Next (next-20250320)


Additional Info:

BTRFS tool: btrfs-progs v6.12

BTRFS tool repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

XFS Repo:https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/

>
> Traces:
>
> [  418.392604] run fstests btrfs/108 at 2025-03-21 05:11:21
> [  418.560137] Kernel attempted to read user page (0) - exploit 
> attempt? (uid: 0)
> [  418.560156] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [  418.560161] Faulting instruction address: 0xc0000000010ef8b0
> [  418.560166] Oops: Kernel access of bad area, sig: 11 [#1]
> [  418.560169] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [  418.560174] Modules linked in: btrfs blake2b_generic xor raid6_pq 
> zstd_compress loop nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 bonding 
> nf_defrag_ipv4 tls rfkill ip_set nf_tables nfnetlink sunrpc 
> pseries_rng vmx_crypto fuse ext4 mbcache jbd2 sd_mod sg ibmvscsi 
> scsi_transport_srp ibmveth
> [  418.560212] CPU: 1 UID: 0 PID: 37583 Comm: rm Kdump: loaded Not 
> tainted 6.14.0-rc7-next-20250320 #1 VOLUNTARY
> [  418.560218] Hardware name: IBM,9080-HEX Power11
> [  418.560223] NIP:  c0000000010ef8b0 LR: c00800000bb190ac CTR: 
> c0000000010ef888
> [  418.560227] REGS: c0000000a252f5a0 TRAP: 0300   Not tainted 
> (6.14.0-rc7-next-20250320)
> [  418.560232] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 44008444  XER: 20040000
> [  418.560240] CFAR: c00800000bc1df84 DAR: 0000000000000000 DSISR: 
> 40000000 IRQMASK: 1
> [  418.560240] GPR00: c00800000bb190ac c0000000a252f840 
> c0000000016a8100 0000000000000000
> [  418.560240] GPR04: 0000000000000000 0000000000010000 
> 0000000000000000 fffffffffffe0000
> [  418.560240] GPR08: c00000010724aad8 0000000000000003 
> 0000000000001000 c00800000bc1df70
> [  418.560240] GPR12: c0000000010ef888 c000000affffdb00 
> 0000000000000000 0000000000000000
> [  418.560240] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [  418.560240] GPR20: c0000000777a8000 c00000006a9c9000 
> c00000010724a950 c0000000777a8000
> [  418.560240] GPR24: fffffffffffffffe c00000010724aad8 
> 0000000000010000 00000000000000a0
> [  418.560240] GPR28: 0000000000010000 c00c00000048c3c0 
> 0000000000000000 0000000000000000
> [  418.560287] NIP [c0000000010ef8b0] _raw_spin_lock_irq+0x28/0x98
> [  418.560294] LR [c00800000bb190ac] wait_subpage_spinlock+0x64/0xd0 
> [btrfs]
> [  418.560339] Call Trace:
> [  418.560342] [c0000000a252f870] [c00800000bb205dc] 
> btrfs_invalidate_folio+0xa8/0x4f0 [btrfs]
> [  418.560384] [c0000000a252f930] [c0000000004cbcdc] 
> truncate_cleanup_folio+0x110/0x14c
> [  418.560391] [c0000000a252f960] [c0000000004ccc7c] 
> truncate_inode_pages_range+0x100/0x4dc
> [  418.560397] [c0000000a252fbd0] [c00800000bb20ba8] 
> btrfs_evict_inode+0x74/0x510 [btrfs]
> [  418.560437] [c0000000a252fc90] [c00000000065c71c] evict+0x164/0x334
> [  418.560443] [c0000000a252fd30] [c000000000647c9c] 
> do_unlinkat+0x2f4/0x3a4
> [  418.560449] [c0000000a252fde0] [c000000000647da0] 
> sys_unlinkat+0x54/0xac
> [  418.560454] [c0000000a252fe10] [c000000000033498] 
> system_call_exception+0x138/0x330
> [  418.560461] [c0000000a252fe50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [  418.560468] --- interrupt: 3000 at 0x7fffb1b366bc
> [  418.560471] NIP:  00007fffb1b366bc LR: 00007fffb1b366bc CTR: 
> 0000000000000000
> [  418.560475] REGS: c0000000a252fe80 TRAP: 3000   Not tainted 
> (6.14.0-rc7-next-20250320)
> [  418.560479] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44008804  XER: 00000000
> [  418.560490] IRQMASK: 0
> [  418.560490] GPR00: 0000000000000124 00007ffffcb4e2b0 
> 00007fffb1c37d00 ffffffffffffff9c
> [  418.560490] GPR04: 000000013d660380 0000000000000000 
> 0000000000000000 0000000000000003
> [  418.560490] GPR08: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [  418.560490] GPR12: 0000000000000000 00007fffb1dba5c0 
> 00007ffffcb4e538 000000011972d0e8
> [  418.560490] GPR16: 000000011972d098 000000011972d060 
> 000000011972d020 000000011972cff0
> [  418.560490] GPR20: 000000011972d298 000000011972cc10 
> 0000000000000000 000000013d6615a0
> [  418.560490] GPR24: 0000000000000002 000000011972d0b8 
> 000000011972cf98 000000011972d1d0
> [  418.560490] GPR28: 00007ffffcb4e538 000000013d6602f0 
> 0000000000000000 0000000000100000
> [  418.560532] NIP [00007fffb1b366bc] 0x7fffb1b366bc
> [  418.560536] LR [00007fffb1b366bc] 0x7fffb1b366bc
> [  418.560538] --- interrupt: 3000
> [  418.560541] Code: 7c0803a6 4e800020 3c4c005c 38428878 7c0802a6 
> 60000000 39200001 992d0932 a12d0008 3ce0fffe 5529083c 61290001 
> <7d001829> 7d063879 40c20018 7d063838
> [  418.560555] ---[ end trace 0000000000000000 ]---
>
>
> If you happed to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>
>

