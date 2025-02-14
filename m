Return-Path: <linux-kernel+bounces-514955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E54A35DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD6188FADB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE726137C;
	Fri, 14 Feb 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XUX7IPjM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC8230985
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537636; cv=none; b=dgidpSZObBqsayLDlAYooe1OIb8symXnDvvP1b+qmx0kiXpY15s5WzQBlbJsysWhrFiJ4qM9AQyaWGclCewsJdB6dLFaJtUiWfwdKiPNWsdtFuq8JYdoigFkQIpsujSRBTEZzZ+6hD/LJD12x3ev/NUHQ1t/c8J6XckOOKSDHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537636; c=relaxed/simple;
	bh=xWW33JH6vP/O0Pr3K9QTselo2p3m+l18GsNLSTsnBCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+b8FtuPmXS8GiNEc7VU4GxAcbxkeXD5h8O8QQw5JgLiNZFEQsqVZpCEgClK15jXtQ7NNqZRRW+YzTEsWC/I0dKJrhPUrVr+Y4uGdBCEEZqb8RjCvFKFA1sIbkSfUanMcB85WxBrF98QN799g/IrHnrMyu5fKIJY0R+OrT9spSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XUX7IPjM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EB7VWw013089;
	Fri, 14 Feb 2025 12:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K/vHlx
	tp8u2AsFXYa5DpBNIqpU2zSvYFe8jdl1RRDL4=; b=XUX7IPjM1KRdHKzc4SqX70
	fE+vn3LRBcAf+Qj8YRC98Tnkwa54F96gwKheFYWxDEYaaS4yU/Y4msAdjCbL5oRa
	+OhkoVWFwnhcI+0n9YcFvyT1Ju8qcieeWG/4ccGOw45T0JYtaw9S/alsgb2CzQhR
	XK/LTc89wxJgs3t5i4BP1Zd33CGw0niVhjcmLdJHdH9gI+1gDxuzspbAf5EPxf9T
	C19MaIivT3oOwVMFDoFdIx2RduJKN8COoJZJznM50NczUv3e/vGVhBr1SSLofWfA
	U8YUmpCRfuUzqCrDvBYI1iV6C4IXg2JC6+28jzlH/h/WWMxa2EawmLJN/18ns1pQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44svp0ambn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:53:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ECr6YH003082;
	Fri, 14 Feb 2025 12:53:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44svp0ambm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:53:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAX7pc028244;
	Fri, 14 Feb 2025 12:53:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyurww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:53:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ECrAH351970326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:53:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 184CA20043;
	Fri, 14 Feb 2025 12:53:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6BA720040;
	Fri, 14 Feb 2025 12:53:05 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.125.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 12:53:05 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH v2] powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC
Date: Fri, 14 Feb 2025 18:23:03 +0530
Message-ID: <173953661683.199877.9730863250927440226.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <06621423da339b374f48c0886e3a5db18e896be8.1739342693.git.christophe.leroy@csgroup.eu>
References: <06621423da339b374f48c0886e3a5db18e896be8.1739342693.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RRd7hmEcIPgC1HcBVjzk2ByDOy6x_H5c
X-Proofpoint-GUID: OUzYFy5Itgqmw9uNZPi0y7RtKoOzsu1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=538 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140092

On Wed, 12 Feb 2025 07:46:28 +0100, Christophe Leroy wrote:
> Erhard reported the following KASAN hit while booting his PowerMac G4
> with a KASAN-enabled kernel 6.13-rc6:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in copy_to_kernel_nofault+0xd8/0x1c8
>   Write of size 8 at addr f1000000 by task chronyd/1293
> 
>   CPU: 0 UID: 123 PID: 1293 Comm: chronyd Tainted: G        W          6.13.0-rc6-PMacG4 #2
>   Tainted: [W]=WARN
>   Hardware name: PowerMac3,6 7455 0x80010303 PowerMac
>   Call Trace:
>   [c2437590] [c1631a84] dump_stack_lvl+0x70/0x8c (unreliable)
>   [c24375b0] [c0504998] print_report+0xdc/0x504
>   [c2437610] [c050475c] kasan_report+0xf8/0x108
>   [c2437690] [c0505a3c] kasan_check_range+0x24/0x18c
>   [c24376a0] [c03fb5e4] copy_to_kernel_nofault+0xd8/0x1c8
>   [c24376c0] [c004c014] patch_instructions+0x15c/0x16c
>   [c2437710] [c00731a8] bpf_arch_text_copy+0x60/0x7c
>   [c2437730] [c0281168] bpf_jit_binary_pack_finalize+0x50/0xac
>   [c2437750] [c0073cf4] bpf_int_jit_compile+0xb30/0xdec
>   [c2437880] [c0280394] bpf_prog_select_runtime+0x15c/0x478
>   [c24378d0] [c1263428] bpf_prepare_filter+0xbf8/0xc14
>   [c2437990] [c12677ec] bpf_prog_create_from_user+0x258/0x2b4
>   [c24379d0] [c027111c] do_seccomp+0x3dc/0x1890
>   [c2437ac0] [c001d8e0] system_call_exception+0x2dc/0x420
>   [c2437f30] [c00281ac] ret_from_syscall+0x0/0x2c
>   --- interrupt: c00 at 0x5a1274
>   NIP:  005a1274 LR: 006a3b3c CTR: 005296c8
>   REGS: c2437f40 TRAP: 0c00   Tainted: G        W           (6.13.0-rc6-PMacG4)
>   MSR:  0200f932 <VEC,EE,PR,FP,ME,IR,DR,RI>  CR: 24004422  XER: 00000000
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC
      https://git.kernel.org/powerpc/c/d262a192d38e527faa5984629aabda2e0d1c4f54

Thanks

