Return-Path: <linux-kernel+bounces-554037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C781DA59209
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD9416D913
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F4227E8B;
	Mon, 10 Mar 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j7XUFTAb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A4229B0D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604131; cv=none; b=lg/h4a8NK/atd1pk+XztoeJ4GcFfTQKRF8xMcMGb8ykLwS0WWqoUnL7IHcjNqyzOY07OJc7QfPVq5gKx15IVDotqXJxCpiqXPCKyZSDQbublID+XhXHGpDCnuod8BzrC6VBDuwCv5mtfGmlZVpJVCnzg8kPajxyLzTMdpxQZUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604131; c=relaxed/simple;
	bh=fGWn+2G04R3qm8+c82nI3DUfxmRTbLBvaENUjP/WOQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+wK6DEDsvZUvOUsKkVaEV8K+ffDEWSyfXuIblkqj0/U+X3doAl7yBiWqAIV4rvR1XvaC3COui2E8H5Pg0UdRThbqfSm0Hlf3uHYkdVE7JLmqIvCGyOJLbUAi/VeW6SVJnNZiYGBlD7yExvEjWaWos+NpXxEnk0O/SBRO7nPXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j7XUFTAb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9MuE9004874;
	Mon, 10 Mar 2025 10:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6iZ9/w
	cBwBYCzKU8am/ivIu/X5tKkVMhn4jG3gfvsok=; b=j7XUFTAb3FsuLz/3YJX0Km
	RQymhb/uSz24KhLYhWDIiJfSzTluyOrU5PsESkqqe9KgeQTayDUDwjPDFQc/F3c8
	w4bC1XqwfY41FGcZqQ9czbR4ODax0oLueLsm1US9sYX23M/ead/7jd26IXXg6IJC
	QdkoeAT4E/ERDWMXwqA/J5uErR9ZNCX2j8d3qL+KAurYWC/u2G3C5rROKoqoLzuY
	P7Ymx+pCrHWERkU627kNS7oA4tJgwLfKjBs//9YjfcLm0tfc53bYFtNlZhzBRZUk
	UcSWtfUG2G4FA8qHpOtoa0JuK1DrQuE4ZCcml+EUvJ9ZRpk8vbaAyOu5NDu8RgBQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459j5p2qyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 10:55:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9lCs5006991;
	Mon, 10 Mar 2025 10:55:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45907sxd8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 10:55:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AAtDZW54722988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:55:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3318420040;
	Mon, 10 Mar 2025 10:55:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06A8220043;
	Mon, 10 Mar 2025 10:55:12 +0000 (GMT)
Received: from [9.43.113.177] (unknown [9.43.113.177])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Mar 2025 10:55:11 +0000 (GMT)
Message-ID: <87fae526-178b-4231-bbe7-dfdd61ac183c@linux.ibm.com>
Date: Mon, 10 Mar 2025 16:25:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PowerPC: Observing Kernel softlockup while running ftrace
 selftest
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <dc78f68f-baae-4758-8f6c-86bbbbef54c3@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <dc78f68f-baae-4758-8f6c-86bbbbef54c3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 74WmZwYWbnDEEhF2BO0eet7Heh8dWep5
X-Proofpoint-ORIG-GUID: 74WmZwYWbnDEEhF2BO0eet7Heh8dWep5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100083

Venkat, can you confirm if the issue is reproducible
disabling CONFIG_PPC_IRQ_SOFT_MASK_DEBUG  ?


On 06/03/25 6:04 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> I am observing soft lock up's while running ftrace selftest on linux- 
> next kernel.
> 
> Kernel Version: next-20250305
> 
> make run_tests
> TAP version 13
> 1..2
> # timeout set to 0
> # selftests: ftrace: poll
> # Error: Polling file is not specified
> not ok 1 selftests: ftrace: poll # exit=255
> # timeout set to 0
> # selftests: ftrace: ftracetest-ktap
> # TAP version 13
> # 1..155
> # ok 1 Basic trace file check
> # ok 2 Basic test for tracers
> # ok 3 Basic trace clock test
> # ok 4 Basic event tracing check
> # ok 5 Test tracefs GID mount option
> # ok 6 Change the ringbuffer size
> # ok 7 Change the ringbuffer sub-buffer size
> # ok 8 Snapshot and tracing_cpumask
> # ok 9 Snapshot and tracing setting
> # ok 10 Test file and directory ownership changes for eventfs
> # ok 11 Basic tests on writing to trace_marker
> # ok 12 trace_pipe and trace_marker
> # not ok 13 Test ftrace direct functions against tracers # UNRESOLVED
> # not ok 14 Test ftrace direct functions against kprobes # UNRESOLVED
> # ok 15 Generic dynamic event - add/remove probes with BTF arguments # SKIP
> # ok 16 Generic dynamic event - add/remove eprobe events
> # ok 17 Generic dynamic event - Repeating add/remove fprobe events # SKIP
> # ok 18 Generic dynamic event - add/remove fprobe events # SKIP
> # ok 19 Generic dynamic event - add/remove kprobe events
> # ok 20 Generic dynamic event - add/remove synthetic events
> # ok 21 Generic dynamic event - add/remove tracepoint probe events on 
> module # SKIP
> # ok 22 Generic dynamic event - add/remove tracepoint probe events # SKIP
> # ok 23 Generic dynamic event - add/remove/test uprobe events
> # ok 24 Generic dynamic event - selective clear (compatibility)
> # ok 25 Checking dynamic events limitations
> # ok 26 Event probe event parser error log check
> # ok 27 Fprobe event VFS type argument # SKIP
> # ok 28 Function return probe entry argument access # SKIP
> # ok 29 Fprobe event parser error log check # SKIP
> # ok 30 Generic dynamic event - generic clear event
> # ok 31 Generic dynamic event - check if duplicate events are caught
> # ok 32 Tracepoint probe event parser error log check # SKIP
> # ok 33 event tracing - enable/disable with event level files
> # not ok 34 event tracing - enable/disable with module event # UNRESOLVED
> # ok 35 event tracing - restricts events based on pid notrace filtering
> # ok 36 event tracing - restricts events based on pid
> # ok 37 event tracing - enable/disable with subsystem level files
> # ok 38 event tracing - enable/disable with top level files
> # not ok 39 Test trace_printk from module # UNRESOLVED
> # ok 40 event filter function - test event filtering on functions
> # ok 41 ftrace - function graph filters with stack tracer
> # ok 42 ftrace - function graph filters
> # ok 43 ftrace - function graph filters
> # ok 44 ftrace - function profiler with function graph tracing
> # ok 45 ftrace - function graph print function return value # SKIP
> # ok 46 ftrace - function trace with cpumask
> # ok 47 ftrace - test for function event triggers
> # ok 48 ftrace - function glob filters
> # ok 49 ftrace - function pid notrace filters
> # ok 50 ftrace - function pid filters
> # ok 51 ftrace - stacktrace filter command
> 
> 
> Warnings:
> 
> 
> [ 2668.008907] watchdog: BUG: soft lockup - CPU#0 stuck for 2265s! 
> [swapper/0:0]
> [ 2668.008954] Modules linked in: bonding(E) nft_fib_inet(E) 
> nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) 
> nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) 
> nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) 
> nf_defrag_ipv4(E) ip_set(E) rfkill(E) nf_tables(E) nfnetlink(E) 
> mlx5_ib(E) ib_uverbs(E) ib_core(E) pseries_rng(E) vmx_crypto(E) 
> dax_pmem(E) drm(E) drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) 
> cdrom(E) sd_mod(E) sg(E) lpfc(E) nd_pmem(E) nvmet_fc(E) nd_btt(E) 
> ibmvscsi(E) scsi_transport_srp(E) ibmveth(E) nvmet(E) nvme_fc(E) 
> mlx5_core(E) nvme_fabrics(E) papr_scm(E) mlxfw(E) nvme_core(E) 
> libnvdimm(E) tls(E) psample(E) scsi_transport_fc(E) fuse(E)
> [ 2668.010198] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Kdump: loaded 
> Tainted: G        W   EL     6.14.0-rc5-next-20250305 #1
> [ 2668.010242] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP
> [ 2668.010276] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> [ 2668.010316] NIP:  c000000000039f90 LR: c00000000007c1a4 CTR: 
> c000000000039f44
> [ 2668.010354] REGS: c000000002c9f538 TRAP: 0900   Tainted: G        W 
> EL      (6.14.0-rc5-next-20250305)
> [ 2668.010392] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 22002844  XER: 20040000
> [ 2668.010639] CFAR: 0000000000000000 IRQMASK: 0
> [ 2668.010639] GPR00: c00000000007c1a4 c000000002c9f510 c000000001688100 
> c000000002c9f508
> [ 2668.010639] GPR04: 8000000002823033 c000000002c61700 c000000002c61700 
> 0000000000000178
> [ 2668.010639] GPR08: 0000000000000002 0000000000000049 0000000000000000 
> 0000000000002000
> [ 2668.010639] GPR12: c000000000328588 c000000003020000 0000000000000000 
> 0000000000000000
> [ 2668.010639] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2668.010639] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2668.010639] GPR24: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000003
> [ 2668.010639] GPR28: 0000000000000002 0000000000000000 fcffffffffffffff 
> c000000002c9f760
> [ 2668.011572] NIP [c000000000039f90] __replay_soft_interrupts+0x5c/0x22c
> [ 2668.011628] LR [c00000000007c1a4] return_to_handler+0x0/0x40
> [ 2668.011680] Call Trace:
> [ 2668.011715] [c000000002c9f510] [c00000000003a018] 
> __replay_soft_interrupts+0xe4/0x22c (unreliable)
> [ 2668.011809] [c000000002c9f6c0] [c00000000007c1a4] 
> return_to_handler+0x0/0x40 (replay_soft_interrupts+0x28/0x40)
> [ 2668.011918] [c000000002c9f6e0] [c00000000007c1a4] 
> return_to_handler+0x0/0x40 (interrupt_exit_kernel_prepare+0x20c/0x250)
> [ 2668.012025] [c000000002c9f730] [c00000000000da68] 
> interrupt_return_srr_kernel+0x8/0x18c
> [ 2668.012098] --- interrupt: 700 at arch_local_irq_restore+0x90/0x280
> [ 2668.012149] NIP:  c00000000003a1f0 LR: c00000000033b458 CTR: 
> 00000000000008fb
> [ 2668.012188] REGS: c000000002c9f760 TRAP: 0700   Tainted: G        W 
> EL      (6.14.0-rc5-next-20250305)
> [ 2668.012224] MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE> CR: 
> 28002844  XER: 20040000
> [ 2668.012509] CFAR: c00000000033b454 IRQMASK: 0
> [ 2668.012509] GPR00: c00000000033b458 c000000002c9fa00 c000000001688100 
> 0000000000000000
> [ 2668.012509] GPR04: 000000000000001c 0000000000000000 0000000000000018 
> c0000000c89ff980
> [ 2668.012509] GPR08: c0000000c89ff980 0000000000000000 c0000000c89ff980 
> 0000000028002844
> [ 2668.012509] GPR12: c000000000325fd0 c000000003020000 c0000000000ffde8 
> 0000000000000000
> [ 2668.012509] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2668.012509] GPR20: 0000000000c00000 0000000000000008 0000000000000000 
> 0000000000000000
> [ 2668.012509] GPR24: 0000000000000000 c000000000000000 fffffffffffffeff 
> c000000004070500
> [ 2668.012509] GPR28: 0000000000000002 0000000000000003 00000000913f411d 
> fcffffffffffffff
> [ 2668.013441] NIP [c00000000003a1f0] arch_local_irq_restore+0x90/0x280
> [ 2668.013492] LR [c00000000033b458] rb_commit+0xc8/0x280
> [ 2668.013541] --- interrupt: 700
> [ 2668.013575] [c000000002c9fa00] [0000000000000000] 0x0 (unreliable)
> [ 2668.013667] [c000000002c9fa40] [c00000000033b458] rb_commit+0xc8/0x280
> [ 2668.013738] [c000000002c9fa70] [c00000000033e6a4] 
> ring_buffer_unlock_commit+0x38/0x1b0
> [ 2668.013807] [c000000002c9fab0] [c00000000034d53c] 
> trace_function+0xcc/0x19c
> [ 2668.013877] [c000000002c9fb00] [c00000000035ec14] 
> function_trace_call+0x154/0x1d4
> [ 2668.013951] [c000000002c9fb50] [c000000000329f88] 
> arch_ftrace_ops_list_func+0x15c/0x290
> [ 2668.014021] [c000000002c9fc20] [c00000000007c0cc] ftrace_call+0x4/0x4c
> [ 2668.014092] [c000000002c9fdd0] [c0000000000ffde8] 
> pseries_lpar_idle.part.0+0x10/0x164
> [ 2668.014163] [c000000002c9fdf0] [c00000000007c1a4] 
> return_to_handler+0x0/0x40 (arch_cpu_idle+0x50/0x120)
> [ 2668.014269] [c000000002c9fe10] [c00000000007c1a4] 
> return_to_handler+0x0/0x40 (default_idle_call+0x50/0x10c)
> [ 2668.014375] [c000000002c9fe30] [c0000000001f52bc] 
> cpuidle_idle_call+0x1b8/0x240
> [ 2668.014447] [c000000002c9fe90] [c00000000007c1a4] 
> return_to_handler+0x0/0x40 (do_idle+0x100/0x1ac)
> [ 2668.014554] [c000000002c9fee0] [c00000000007c1a4] 
> return_to_handler+0x0/0x40 (cpu_startup_entry+0x4c/0x50)
> [ 2668.014661] [c000000002c9ff10] [c000000000011280] rest_init+0xf0/0xf4
> [ 2668.014732] [c000000002c9ff40] [c000000002006604] 
> start_kernel+0x50c/0x5e0
> [ 2668.014806] [c000000002c9ffe0] [c00000000000ea9c] 
> start_here_common+0x1c/0x20
> [ 2668.014878] Code: 71298000 408201ec 892d0933 7d2a48f8 554a07fe 
> 0b0a0000 792ad7e2 0b0a0000 61290040 38610028 992d0933 48042259 
> <60000000> 39200000 e9410130 f9210160
> 
> 
> If you fix this issue please add below tag.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> Regards,
> 
> Venkat.
> 
> 


