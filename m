Return-Path: <linux-kernel+bounces-514953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F4A35DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0AE3AF7CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519724291F;
	Fri, 14 Feb 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N70aOHMt"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD551EA91
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537615; cv=none; b=UmrjjI1+7TadShsGxCNxnuOAA3nFWvphltr2UIU3UHZ74/cPamtELaObdg7MHngugLRSNzKcIZC/nnTP0YXqdjhkaLwIAdSHq2pHaji99jm3PEtEUdkjndfnmKS5QU9DWPnbgSwc8FF2sTvuVCaqtLM4LiJN/T07JT/E7iWxkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537615; c=relaxed/simple;
	bh=Rb98PaVbPDZkKYN/RY4MOwLXB/EFizOr62EuPijWgBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnHONk1cLDo9e72C5NNdDtq6HismMvJpZco1Iu8kmrC7OCqRvFWJIGC/6h+KrEvu8vpxxhvONj4uay8lcwRt+ShMnXBcATnwXxcaiy/jwNhxFuXp2TjshagzquAP+k71SNsJHEMh8P3KLo/BNTLYfgZMdlRtkYausXZODsoz+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N70aOHMt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5OJbI010280;
	Fri, 14 Feb 2025 12:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SIQpZM
	zGZrldU/1bEWKd+aQqNiMGG457ywKG5GbG4z8=; b=N70aOHMtq8+CZaVNR6XJi9
	l1LkPrnjbWHPXW44CZx4UQ0R+rU6KZCPOrej8b/iXY36qzvanI4ThSBz37gR1Q2Q
	IPtvQSqJGcp7KwkpGSaXoPqfTD9unZNGIyvCi91C/dlFuSa181THj8QehOec1vFY
	9cffl4SFFirtFUnVTkZ/UJzhtBfibmdd2aeOca7t2JfkFAfbaFQeUxVqMQPELFGE
	/Ax9QyRl4EiCCro2/OF237UuDk9E7tlU181zxO0IyhF+PY+5+64n2ohrWQkgGCZj
	wR4fhOuH57KS2g/aCWrPVyFdfwUY6dE117ypjChTZM/nQHAj93k9ZfIA2dxRB4aw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44syn81wxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:52:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ECqwVG025200;
	Fri, 14 Feb 2025 12:52:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44syn81wxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:52:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBZ9bm001051;
	Fri, 14 Feb 2025 12:52:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknkkxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:52:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ECqt5N42140106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:52:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8572520043;
	Fri, 14 Feb 2025 12:52:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28BC62004E;
	Fri, 14 Feb 2025 12:52:51 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.125.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 12:52:50 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] powerpc/code-patching: Disable KASAN report during patching via temporary mm
Date: Fri, 14 Feb 2025 18:22:47 +0530
Message-ID: <173953661682.199877.13295619540278726758.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1c05b2a1b02ad75b981cfc45927e0b4a90441046.1738577687.git.christophe.leroy@csgroup.eu>
References: <1c05b2a1b02ad75b981cfc45927e0b4a90441046.1738577687.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q5jwVCIH-Wkiuq9oi1Dmxf7-NrLK3270
X-Proofpoint-GUID: 2j3UAGZW-ZS4xgwiNH9Ipj2klGkHJs0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxlogscore=336 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140092

On Mon, 03 Feb 2025 11:14:57 +0100, Christophe Leroy wrote:
> Erhard reports the following KASAN hit on Talos II (power9) with kernel 6.13:
> 
> [   12.028126] ==================================================================
> [   12.028198] BUG: KASAN: user-memory-access in copy_to_kernel_nofault+0x8c/0x1a0
> [   12.028260] Write of size 8 at addr 0000187e458f2000 by task systemd/1
> 
> [   12.028346] CPU: 87 UID: 0 PID: 1 Comm: systemd Tainted: G                T  6.13.0-P9-dirty #3
> [   12.028408] Tainted: [T]=RANDSTRUCT
> [   12.028446] Hardware name: T2P9D01 REV 1.01 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
> [   12.028500] Call Trace:
> [   12.028536] [c000000008dbf3b0] [c000000001656a48] dump_stack_lvl+0xbc/0x110 (unreliable)
> [   12.028609] [c000000008dbf3f0] [c0000000006e2fc8] print_report+0x6b0/0x708
> [   12.028666] [c000000008dbf4e0] [c0000000006e2454] kasan_report+0x164/0x300
> [   12.028725] [c000000008dbf600] [c0000000006e54d4] kasan_check_range+0x314/0x370
> [   12.028784] [c000000008dbf640] [c0000000006e6310] __kasan_check_write+0x20/0x40
> [   12.028842] [c000000008dbf660] [c000000000578e8c] copy_to_kernel_nofault+0x8c/0x1a0
> [   12.028902] [c000000008dbf6a0] [c0000000000acfe4] __patch_instructions+0x194/0x210
> [   12.028965] [c000000008dbf6e0] [c0000000000ade80] patch_instructions+0x150/0x590
> [   12.029026] [c000000008dbf7c0] [c0000000001159bc] bpf_arch_text_copy+0x6c/0xe0
> [   12.029085] [c000000008dbf800] [c000000000424250] bpf_jit_binary_pack_finalize+0x40/0xc0
> [   12.029147] [c000000008dbf830] [c000000000115dec] bpf_int_jit_compile+0x3bc/0x930
> [   12.029206] [c000000008dbf990] [c000000000423720] bpf_prog_select_runtime+0x1f0/0x280
> [   12.029266] [c000000008dbfa00] [c000000000434b18] bpf_prog_load+0xbb8/0x1370
> [   12.029324] [c000000008dbfb70] [c000000000436ebc] __sys_bpf+0x5ac/0x2e00
> [   12.029379] [c000000008dbfd00] [c00000000043a228] sys_bpf+0x28/0x40
> [   12.029435] [c000000008dbfd20] [c000000000038eb4] system_call_exception+0x334/0x610
> [   12.029497] [c000000008dbfe50] [c00000000000c270] system_call_vectored_common+0xf0/0x280
> [   12.029561] --- interrupt: 3000 at 0x3fff82f5cfa8
> [   12.029608] NIP:  00003fff82f5cfa8 LR: 00003fff82f5cfa8 CTR: 0000000000000000
> [   12.029660] REGS: c000000008dbfe80 TRAP: 3000   Tainted: G                T   (6.13.0-P9-dirty)
> [   12.029735] MSR:  900000000280f032 <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI>  CR: 42004848  XER: 00000000
> [   12.029855] IRQMASK: 0
>                GPR00: 0000000000000169 00003fffdcf789a0 00003fff83067100 0000000000000005
>                GPR04: 00003fffdcf78a98 0000000000000090 0000000000000000 0000000000000008
>                GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                GPR12: 0000000000000000 00003fff836ff7e0 c000000000010678 0000000000000000
>                GPR16: 0000000000000000 0000000000000000 00003fffdcf78f28 00003fffdcf78f90
>                GPR20: 0000000000000000 0000000000000000 0000000000000000 00003fffdcf78f80
>                GPR24: 00003fffdcf78f70 00003fffdcf78d10 00003fff835c7239 00003fffdcf78bd8
>                GPR28: 00003fffdcf78a98 0000000000000000 0000000000000000 000000011f547580
> [   12.030316] NIP [00003fff82f5cfa8] 0x3fff82f5cfa8
> [   12.030361] LR [00003fff82f5cfa8] 0x3fff82f5cfa8
> [   12.030405] --- interrupt: 3000
> [   12.030444] ==================================================================
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/code-patching: Disable KASAN report during patching via temporary mm
      https://git.kernel.org/powerpc/c/dc9c5166c3cb044f8a001e397195242fd6796eee

Thanks

