Return-Path: <linux-kernel+bounces-544166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F5DA4DE21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B38A7A3EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612D202C5B;
	Tue,  4 Mar 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ib1QG8Ar"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996720298A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091953; cv=none; b=rc5EkGDcS9XK7QkmoI937qjkBkmvkXzVBaTfuwtpIBUTaZMP9WgJtHKpWKRPgLgWUCcnaOZ8o/FBqxwXdSj/nusUy8QRs6bo9nTgcftcpEo6GqDlyiTDZGGI6C9zb0yvqhYN+Vy7HWQuBIGr+1HmrMjCxJLrqURQscE2PDTcusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091953; c=relaxed/simple;
	bh=CZAIYWq75l7OVbFltKTukf48RnoGPmkrfxNnNE0UZRM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VOOjUMwwJbftHDkx+6+/EzielRDP+FhHRrevVBxlIUMKF57vHqj9UmAWdXpBugnaw8WEx3UikOP8B57LiTCU0GHGoDpDu7iQTgPESvCX0nXal3VXktokf/XimoZP8b3RNAu4htfGW8LXWffsBVH0n3BB1rNg2JSm+2EOM1LxGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ib1QG8Ar; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5243joPm021783;
	Tue, 4 Mar 2025 12:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I1c9fs
	tLTzy44ZUVu7Lett6l+VBM2IvtubxWH37Fjq0=; b=ib1QG8ArExfz3MyTPxet3h
	Eiuyc70UoqQ7+C/5Heqd9WF7tFO9yyx50lKZFrQOC/5lOr6PY5lRaSoDdbTfo4+e
	zTOzbc37w4uynV7gxQVo+9FfnDs4Qi3G08cmgD4C99Ab7uhvsM4ouKCmMX0/zQGC
	DLSl7Agw/OTbKlMzyP7F29FOxey2/gyoVMACdIPxgj3nPWPWCdmRkLqegvj80RpG
	dj8H+PtuuL9nSxdJB9qdziGTxqRyo0VdaIG1som15hfOZPtq315uzFsXOG/MnJuS
	f3384dPJRUB0JEVL4Wt33+YbQ4Bs6bOjdkG1IGw5YF4al4TRT7izgOwbDzcUY2sA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7jdsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:38:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524C5EAc013772;
	Tue, 4 Mar 2025 12:38:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kn9b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:38:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524CcqUu25756290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 12:38:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061265805F;
	Tue,  4 Mar 2025 12:38:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A74958051;
	Tue,  4 Mar 2025 12:38:48 +0000 (GMT)
Received: from [9.43.105.169] (unknown [9.43.105.169])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 12:38:47 +0000 (GMT)
Message-ID: <fe937273-d81a-4f6c-9eba-b96b711b4644@linux.ibm.com>
Date: Tue, 4 Mar 2025 18:08:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build Warnings at arch/powerpc/
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
 <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
 <8ba544e7-cf2a-4807-a056-683115805721@csgroup.eu>
 <bfcce9ce-bc26-4088-8d27-0797fc0d22d3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <bfcce9ce-bc26-4088-8d27-0797fc0d22d3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kZ3E3pdPJJc4GMLcWZe_BCZ62He4JSX_
X-Proofpoint-GUID: kZ3E3pdPJJc4GMLcWZe_BCZ62He4JSX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040102



On 3/4/25 4:58 PM, Madhavan Srinivasan wrote:
> 
> 
> On 3/4/25 2:26 PM, Christophe Leroy wrote:
>>
>>
>> Le 04/03/2025 à 07:13, Madhavan Srinivasan a écrit :
>>>
>>>
>>> On 3/4/25 10:42 AM, Venkat Rao Bagalkote wrote:
>>>> Greetings!!
>>>>
>>>>
>>>> Observing build warnings with linux-next and powerpc repo's. Issue is currently not seen on mainline yet.
>>>>
>>>> PPC Repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpowerpc%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8e0f8501f09c48dbb43608dd5ae3c9bf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638766656585342184%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=e5BrJzcrtlITkLF31KltGExQ5Qe8fDVTMV6VfR4w9o8%3D&reserved=0 merge branch
>>>>
>>>> PPC Kernel Version: 6.14.0-rc4-g1304f486dbf1
>>>> next Repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8e0f8501f09c48dbb43608dd5ae3c9bf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638766656585355246%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=meQyZfB75HhJFCL6AX93slsyVwnogGPYFabDXl%2FLzDA%3D&reserved=0 master branch
>>>>
>>>> next Kernel Version: 6.14.0-rc5-next-20250303
>>>>
>>>>
>>>> On linux-next kernel issue got introduced b/w next-20250227 and next-20250303
>>>>
>>>>
>>>> Build Warnings:
>>>>
>>>> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
>>>> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call
>>>> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
>>>>
>>>>
>>>
>>> Can you please specific the compiler and compiler version you found this issue with
>>>
>>
>> Can you also tell which defconfig you are using or provide your .config
>>
>> It might also be helpfull if you can provide a disassembly of the three file.o around the warned address.
> 
> I could recreate the issue with gcc 11.4.1 20231218 with today's linux-next (but could not recreate with gcc 14 or gcc 11.3.0)
> 
> (20d5c66e1810 (HEAD -> master, tag: next-20250304, origin/master, origin/HEAD) Add linux-next specific files for 20250304)
> 
> warning for one of the switch.S file :
> 
>   CC      arch/powerpc/kernel/syscalls.o
>   AS      arch/powerpc/kernel/switch.o
> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call

I guess this is becos, for bl .+4, we recently added in the arch_decode_instruction (decode.c) to set the type as INSN_OTHER

        case 18: /* b[l][a] */
                if (ins == 0x48000005)  /* bl .+4 */
                        typ = INSN_OTHER;

Which I think is the issue here, changing it to INSN_CALL from INSN_OTHER fixes the warning 

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 26d5050424a9..ffd63a61a585 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -56,7 +56,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
        switch (opcode) {
        case 18: /* b[l][a] */
                if (ins == 0x48000005)  /* bl .+4 */
-                       typ = INSN_OTHER;
+                       typ = INSN_CALL;
                else if (ins & 1)       /* bl[a] */
                        typ = INSN_CALL;
                else            /* b[a] */


Maddy

>   CC      arch/powerpc/kernel/irq.o
>   CC      arch/powerpc/kernel/align.o
>   CC      arch/powerpc/kernel/signal_64.o
> 
> Objdump of switch.o:
> arch/powerpc/kernel/switch.o:     file format elf64-powerpcle
> 
> Disassembly of section .text:
> 
> 0000000000000000 <flush_branch_caches>:
>        0:	a6 02 28 7d 	mflr    r9
>        4:	05 00 00 48 	bl      8 <flush_branch_caches+0x8>
>        8:	05 00 00 48 	bl      c <flush_branch_caches+0xc>
>        c:	05 00 00 48 	bl      10 <flush_branch_caches+0x10>
>       10:	05 00 00 48 	bl      14 <flush_branch_caches+0x14>
>       14:	05 00 00 48 	bl      18 <flush_branch_caches+0x18>
>       18:	05 00 00 48 	bl      1c <flush_branch_caches+0x1c>
>       1c:	05 00 00 48 	bl      20 <flush_branch_caches+0x20>
>       20:	05 00 00 48 	bl      24 <flush_branch_caches+0x24>
>       24:	05 00 00 48 	bl      28 <flush_branch_caches+0x28>
>       28:	05 00 00 48 	bl      2c <flush_branch_caches+0x2c>
> 
> 
> arch/powerpc/kernel/switch.S failing src section:
> 
> .balign 32
> .global flush_branch_caches
> flush_branch_caches:
>         /* Save LR into r9 */
>         mflr    r9
> 
>         // Flush the link stack
>         .rept 64
>         ANNOTATE_INTRA_FUNCTION_CALL
>         bl      .+4
>         .endr
>         b       1f
>         nops    6
> 
> Maddy 
> 
> 
>>
>> Christophe
> 
> 


