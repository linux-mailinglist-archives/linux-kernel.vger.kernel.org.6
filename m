Return-Path: <linux-kernel+bounces-544028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C8A4DC95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15BE3B2B33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AE1FF5F9;
	Tue,  4 Mar 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VV4St/cn"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6991FCD00
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087742; cv=none; b=Z9z9EFPido4f4CqijebBQ80jjiDuiwgVwZ78YWxkg9S5A1S7hg+1U/pYpjLCKQBQYYIFwgpu8FwTsGzXrgrglDReuI2s9DsSdvNduhDN6QhdKuRZWYtis8+NJjnlouDfyfUl6Mph0gOktzfJeAV/SrrXYtL9fF8ZO9GfXs9+3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087742; c=relaxed/simple;
	bh=k7/ns6k+jC8YH5yC8ti9Hx6GiB2hICgAKqN2/m6TX4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ng9XPmbIZ9QODtN+n+RNvCkWa8pyzy9S9fXLa4NJjPUHBt5Y0pQBINp3EV/TIYC+u6dmbkK3TEjF4CphhaLnWMrBoVSrJjwPOJhvnsCqhtwuPhOlNo4jhFUCPfvRYSWtvFx34wZRGJgwjKpYmqxEEQVM057WMb5A6+6QBdJc2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VV4St/cn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5243jgqn021527;
	Tue, 4 Mar 2025 11:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HB09KY
	Dfr5AgqHYVGRS5BenMKUM+GUnC0qmbOWI8zsE=; b=VV4St/cndBGXFGGeVBHVkn
	sHXAoyQSNdhnPwWhZCHthEhRCWMGwgUkSKY+Dw4t7iTxqtcAxQVssyC74o+yxid6
	S4dTKYRMK288aoF0gUNsxOu9rf9Mkk2axONd/AfCH0NG1QkILAlYs3W4eFdhOFuR
	LriJ0LOAsd4PhTugYpTMiuM8vsuIcCbGWEQmjkmUKJxq7+xkcRcZFMKml3Al3thZ
	kC8GurlOj17jrXqRbsed/PN3Qxiu0UV1ymEaHdCyUepe8xzSU/7Dsvkg45UBWe0s
	flMaEBZ4RPjCtLkrStCxFAvPk39MWXwYz8rVb4T6vHvwgDMbmZTgxbwz8GCrqfjw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7j4eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:28:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5249VsZb025044;
	Tue, 4 Mar 2025 11:28:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f91vny8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:28:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524BSf1127329098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 11:28:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68B3A5805A;
	Tue,  4 Mar 2025 11:28:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EB8358051;
	Tue,  4 Mar 2025 11:28:37 +0000 (GMT)
Received: from [9.43.105.169] (unknown [9.43.105.169])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 11:28:36 +0000 (GMT)
Message-ID: <bfcce9ce-bc26-4088-8d27-0797fc0d22d3@linux.ibm.com>
Date: Tue, 4 Mar 2025 16:58:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build Warnings at arch/powerpc/
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
 <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
 <8ba544e7-cf2a-4807-a056-683115805721@csgroup.eu>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <8ba544e7-cf2a-4807-a056-683115805721@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F-gHy7AAVCittyDFXVYiNSidux3HVXLP
X-Proofpoint-GUID: F-gHy7AAVCittyDFXVYiNSidux3HVXLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097



On 3/4/25 2:26 PM, Christophe Leroy wrote:
> 
> 
> Le 04/03/2025 à 07:13, Madhavan Srinivasan a écrit :
>>
>>
>> On 3/4/25 10:42 AM, Venkat Rao Bagalkote wrote:
>>> Greetings!!
>>>
>>>
>>> Observing build warnings with linux-next and powerpc repo's. Issue is currently not seen on mainline yet.
>>>
>>> PPC Repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpowerpc%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8e0f8501f09c48dbb43608dd5ae3c9bf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638766656585342184%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=e5BrJzcrtlITkLF31KltGExQ5Qe8fDVTMV6VfR4w9o8%3D&reserved=0 merge branch
>>>
>>> PPC Kernel Version: 6.14.0-rc4-g1304f486dbf1
>>> next Repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8e0f8501f09c48dbb43608dd5ae3c9bf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638766656585355246%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=meQyZfB75HhJFCL6AX93slsyVwnogGPYFabDXl%2FLzDA%3D&reserved=0 master branch
>>>
>>> next Kernel Version: 6.14.0-rc5-next-20250303
>>>
>>>
>>> On linux-next kernel issue got introduced b/w next-20250227 and next-20250303
>>>
>>>
>>> Build Warnings:
>>>
>>> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
>>> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call
>>> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
>>>
>>>
>>
>> Can you please specific the compiler and compiler version you found this issue with
>>
> 
> Can you also tell which defconfig you are using or provide your .config
> 
> It might also be helpfull if you can provide a disassembly of the three file.o around the warned address.

I could recreate the issue with gcc 11.4.1 20231218 with today's linux-next (but could not recreate with gcc 14 or gcc 11.3.0)

(20d5c66e1810 (HEAD -> master, tag: next-20250304, origin/master, origin/HEAD) Add linux-next specific files for 20250304)

warning for one of the switch.S file :

  CC      arch/powerpc/kernel/syscalls.o
  AS      arch/powerpc/kernel/switch.o
arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
  CC      arch/powerpc/kernel/irq.o
  CC      arch/powerpc/kernel/align.o
  CC      arch/powerpc/kernel/signal_64.o

Objdump of switch.o:
arch/powerpc/kernel/switch.o:     file format elf64-powerpcle

Disassembly of section .text:

0000000000000000 <flush_branch_caches>:
       0:	a6 02 28 7d 	mflr    r9
       4:	05 00 00 48 	bl      8 <flush_branch_caches+0x8>
       8:	05 00 00 48 	bl      c <flush_branch_caches+0xc>
       c:	05 00 00 48 	bl      10 <flush_branch_caches+0x10>
      10:	05 00 00 48 	bl      14 <flush_branch_caches+0x14>
      14:	05 00 00 48 	bl      18 <flush_branch_caches+0x18>
      18:	05 00 00 48 	bl      1c <flush_branch_caches+0x1c>
      1c:	05 00 00 48 	bl      20 <flush_branch_caches+0x20>
      20:	05 00 00 48 	bl      24 <flush_branch_caches+0x24>
      24:	05 00 00 48 	bl      28 <flush_branch_caches+0x28>
      28:	05 00 00 48 	bl      2c <flush_branch_caches+0x2c>


arch/powerpc/kernel/switch.S failing src section:

.balign 32
.global flush_branch_caches
flush_branch_caches:
        /* Save LR into r9 */
        mflr    r9

        // Flush the link stack
        .rept 64
        ANNOTATE_INTRA_FUNCTION_CALL
        bl      .+4
        .endr
        b       1f
        nops    6

Maddy 


> 
> Christophe


