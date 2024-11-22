Return-Path: <linux-kernel+bounces-418154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082199D5DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D091F22954
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FB1DE2C0;
	Fri, 22 Nov 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Aa4YrEJX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C718A6DE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273897; cv=none; b=LxGuvjIGWXod3wcIvD/MRJkBtIdHzMYsWDEVodIyW+WULiUCUFyP35GAD1VH/C8ebdSB/T3MpADTJEb3eSPJIAXjDXHlgW1PtlEwhxJAoPtw7x3DtfvN6q0T9vWZR42OeeeaikpmflNSyQ7J/vifTkNSXCxhdk4efSasZQtmz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273897; c=relaxed/simple;
	bh=B1BMdajvnVj3yPQNJvx5ZllMDwIbalEUZIVXZrSloB0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ha5C1qDgm/MWuLsbEGYRttORbKlS6QamnnRfliLBeN1QZ55MfC15RHksVCXX9FqosYN1fJHXJlzxAB0RSOcyhWd/iFTqKa0xlgv243oZ8bq4zRSieAP5SvP0lGdw1cPY3pgak1wLYK0qmFqNcEmWDusi8v7Ywpgrj+i/6+5jaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Aa4YrEJX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qPPl006973
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=YozFXk6gs/FK7XKjdfw/BTtHQzLQ
	EaBnhZc+F7jFtjc=; b=Aa4YrEJXc5p5uPRLmL5HsqWpq7vypkbfNJcPM47Z8GEw
	YsoQ/n9cr5MQdpHESmmNnxQdRT6bwOg/NoNAnGxWwqUiYcYdaFLPsUpR/9akMUvk
	PbDiuENcmkLaed11UE0eBQXoulzD1XnaKH2p6LxqD3mP3BtcbdUn1gjtgVsPATsj
	+WX4H6NyoiEeQeRKKMXlXifCdl59zbPY3Znvk+7nFqX9VhyJFC9U+hyzHV6BSQe9
	BfA5O5h1URB0X8ztcytHxxnZ+veY2EneuKUqwE5UHYIGzlY6KVa/mncxTS56IThq
	LlnEiVXTrzsx3tlsJ1LewNcWC/bU8T2QdlV8AUAY6g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu27h68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM2j7V6011847
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjtsk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:27 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMBBQO552429096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E297D58056
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4227658062
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:26 +0000 (GMT)
Received: from [9.61.249.82] (unknown [9.61.249.82])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:11:25 +0000 (GMT)
Message-ID: <9a0a9c6d-4e00-4244-b1da-f0b869ba70eb@linux.vnet.ibm.com>
Date: Fri, 22 Nov 2024 16:41:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-kernel@vger.kernel.org
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [6.12.0-gfc39fb56917b]Kernel OOPs while running perf_fuzzer tests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tKdAcYNXFKwWS3pWo7AKNrYyFxjQr7w9
X-Proofpoint-ORIG-GUID: tKdAcYNXFKwWS3pWo7AKNrYyFxjQr7w9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=836 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220093

Greetings!!!


I am seeing kernel oops while running perf_fuzzer tests. I saw this 
failure couple of times now.

Issue is seen on IBM Power HW.

Repo: Linux Mainline

Kernel Version: 6.12.0-gfc39fb56917b

Traces:

[17479.927041] Oops: Kernel access of bad area, sig: 7 [#1]
[17479.927045] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
[17479.927050] Modules linked in: rpadlpar_io rpaphp uinput torture 
dummy veth nfsv3 nfs netfs dns_resolver tun brd overlay exfat vfat fat 
btrfs blake2b_generic xor raid6_pq zstd_compress xfs loop sctp 
ip6_udp_tunnel udp_tunnel rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd 
auth_rpcgss nfs_acl lockd grace dm_mod nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack bonding 
nf_defrag_ipv6 nf_defrag_ipv4 tls rfkill sunrpc ip_set nf_tables 
libcrc32c nfnetlink pseries_rng vmx_crypto fuse ext4 mbcache jbd2 sd_mod 
sg ibmvscsi scsi_transport_srp ibmveth [last unloaded: zram]
[17479.927118] CPU: 3 UID: 0 PID: 870493 Comm: perf_fuzzer Kdump: loaded 
Tainted: G   M       O       6.12.0-gfc39fb56917b #1
[17479.927125] Tainted: [M]=MACHINE_CHECK, [O]=OOT_MODULE

[17479.927134] NIP:  c0000000003c76f8 LR: c0000000003a69dc CTR: 
c000000000376988
[17479.927139] REGS: c0000005e141f720 TRAP: 0300   Tainted: G M       
O        (6.12.0-gfc39fb56917b)
[17479.927144] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
84008428  XER: 20040000
[17479.927154] CFAR: c0000000003a69d8 DAR: 0000000000000010 DSISR: 
00080000 IRQMASK: 0
[17479.927154] GPR00: c0000000003a69dc c0000005e141f9c0 c000000001614400 
0000000000000000
[17479.927154] GPR04: c008000011e50000 0000000000000000 0000000000000000 
c0000005e141f9e0
[17479.927154] GPR08: 0000000000000000 c00000066726ba50 c0000001160dc800 
0000000000008000
[17479.927154] GPR12: c000000000376988 c000000effffbb00 0000000000000000 
0000000000000000
[17479.927154] GPR16: 0000000000000000 0000000000000000 c0000001160dc800 
c0000001160dc880
[17479.927154] GPR20: c0000001160dd538 0000000000000000 0000000000000000 
0000000000000000
[17479.927154] GPR24: 0000000002002000 c0000001160dd710 c0000000784e5500 
c0000001160dc800
[17479.927154] GPR28: c000000529826508 0000000000000000 c000000002bc2348 
c000000149a42418
[17479.927203] NIP [c0000000003c76f8] bpf_prog_array_delete_safe+0x10/0x50
[17479.927211] LR [c0000000003a69dc] perf_event_detach_bpf_prog+0xf4/0x108
[17479.927217] Call Trace:
[17479.927220] [c0000005e141f9c0] [c0000000003a6924] 
perf_event_detach_bpf_prog+0x3c/0x108 (unreliable)
[17479.927227] [c0000005e141fa10] [c000000000481d58] _free_event+0x26c/0x378
[17479.927234] [c0000005e141fa50] [c0000000004858f0] 
perf_event_exit_event+0xd0/0x1ac
[17479.927240] [c0000005e141fa90] [c000000000489f38] 
perf_event_exit_task+0x238/0x2f4
[17479.927247] [c0000005e141fb00] [c000000000173370] do_exit+0x308/0x5a0
[17479.927254] [c0000005e141fbb0] [c0000000001737f4] do_group_exit+0x4c/0xbc
[17479.927260] [c0000005e141fbf0] [c00000000018ad24] get_signal+0xb4c/0xb50
[17479.927265] [c0000005e141fcf0] [c00000000002184c] do_signal+0x7c/0x324
[17479.927272] [c0000005e141fd90] [c0000000000229c0] 
do_notify_resume+0xb0/0x13c
[17479.927279] [c0000005e141fdc0] [c000000000032578] 
interrupt_exit_user_prepare_main+0x1ac/0x264
[17479.927286] [c0000005e141fe20] [c0000000000328a8] 
interrupt_exit_user_prepare+0x58/0xa8
[17479.927292] [c0000005e141fe50] [c00000000000d8e4] 
interrupt_return_srr_user+0x8/0x154
[17479.927299] --- interrupt: a00 at 0x10015b24
[17479.927303] NIP:  0000000010015b24 LR: 000000001000d2dc CTR: 
0000000000000000
[17479.927307] REGS: c0000005e141fe80 TRAP: 0a00   Tainted: G M       
O        (6.12.0-gfc39fb56917b)
[17479.927312] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002422  XER: 20040000
[17479.927323] CFAR: 0000000000000000 IRQMASK: 0
[17479.927323] GPR00: 0000000000000040 00007fffcbc09a70 0000000010047f00 
00000000000d3a77
[17479.927323] GPR04: 0000000000000000 0000000000000000 0000000000000001 
00007fff884f1010
[17479.927323] GPR08: 00007fff884f1010 00000000000d3a77 0000000000000000 
0000000000000000
[17479.927323] GPR12: 0000000000000000 00007fff884fa5a0 0000000000000000 
0000000000075f96
[17479.927323] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[17479.927323] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000010002ae8
[17479.927323] GPR24: 00007fff884f0000 00007fff884ef6c0 00007fffcbc0c288 
000000001003fce8
[17479.927323] GPR28: 00007fffcbc0c438 00007fffcbc0c278 0000000000000001 
00007fffcbc09a70
[17479.927369] NIP [0000000010015b24] 0x10015b24
[17479.927372] LR [000000001000d2dc] 0x1000d2dc
[17479.927376] --- interrupt: a00
[17479.927379] Code: 3860fff2 ebe10048 4bffffb4 ebe10048 3860fff2 
4bffffa8 3860fff4 4bffffa0 3c4c0125 3842cd18 7c0802a6 60000000 
<e9230010> 38630010 2c290000 4082001c
[17479.927394] ---[ end trace 0000000000000000 ]---


Regards,

Venkat.


