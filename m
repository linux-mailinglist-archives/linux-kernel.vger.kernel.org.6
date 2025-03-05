Return-Path: <linux-kernel+bounces-546065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2CA4F5EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D925418898F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3119DF48;
	Wed,  5 Mar 2025 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azHsOzLu"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A817D2FF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147477; cv=none; b=JbYhVRD3l+YL91UA0w5LbULIJ49hM7cao2DgaZFowLmr9UkxWgeTtGTt2C9sIizeIQHhZA2i02gKyrTI/gtfoii53i14Qeo1CjEpopwTSVmM+DlAOIzHHH9P0BRflcvJj4LNuzWzV0jkeOMYrrgkoq6X/cbp0FAYfXc+fob2ago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147477; c=relaxed/simple;
	bh=0Hk2CosclC19MySD3GnC7bFG71KMiLMn3FJ3byKgCIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaocXrIs+7WDlWRQAN4KNRb6ZRF6XFSe3Jb/5KPWACxru5ltDSD4MpdBL1Mu5mK6viyjx/VHSqr0P5kamOK1/dJKT/oNHdxWV6WNjVQYL6ou35PQv2g9an5bXHDLLotJ0hse0VK9p0/NT9TEZtawnqQg5ywncfOoDECQwzImGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azHsOzLu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253kZg5017524;
	Wed, 5 Mar 2025 04:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=at5cRb
	HFoiACXGYCVV6rNbcnvoVnHFO7e8uHBBjB/bI=; b=azHsOzLuSTa1VfvWMn/ex2
	m6JjuQKE8w5Bl75RbAMZz71udFLKEekLbliiXCw9GkBn3SWbL5OAxPjw/UiUbNyF
	EHg3+EKTJdjOAY0B+HOx64h7thmtEovjAbVFY3Mc1RNvv3X/iGVhpHhba1kZlUNk
	ype1eAL5DiJrijO0UA0muykjTn22ejI4dgsuhGXWdSV38o0z3hoq3zLQsTWOkMJV
	Yq4TCFMaGl5HJJ20NDe0L2WangYVbto2AUn/tljIdPgnJwf0bNzDnDmZQWXAu6rS
	rsZ4zMospka+QkBmS19k+EQ0DUTwwxin5Yvl8XiM90PmzGdFCO2MGooUWsQYniEw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08r20u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 04:04:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52544LG4019820;
	Wed, 5 Mar 2025 04:04:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08r20s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 04:04:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5251p0Hg032243;
	Wed, 5 Mar 2025 04:04:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt13yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 04:04:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52544K9Q16843376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 04:04:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91FE558058;
	Wed,  5 Mar 2025 04:04:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E81758061;
	Wed,  5 Mar 2025 04:04:18 +0000 (GMT)
Received: from [9.204.204.161] (unknown [9.204.204.161])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 04:04:18 +0000 (GMT)
Message-ID: <934be33f-ba7d-4363-a1c8-e9e7c381646a@linux.ibm.com>
Date: Wed, 5 Mar 2025 09:34:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Fix 'intra_function_call not a direct call'
 warning
Content-Language: en-GB
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <88876fb4e412203452e57d1037a1341cf15ccc7b.1741128981.git.christophe.leroy@csgroup.eu>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <88876fb4e412203452e57d1037a1341cf15ccc7b.1741128981.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BMoyFnfcoA69ScC0GRn7TsTduTMu21sc
X-Proofpoint-GUID: 17god4V6OdBT9Q1UpgOS2logHQAv34U2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_02,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=768 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050028

Hello Christophe,

On 05/03/25 4:30 am, Christophe Leroy wrote:
> The following build warning have been reported:
>
>    arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
>    arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
>
> This happens due to commit bb7f054f4de2 ("objtool/powerpc: Add support
> for decoding all types of uncond branches") because that commit decodes
> 'bl .+4' as a normal instruction because that instruction is used by
> clang instead of 'bcl 20,31,+.4' for relocatable code.
>
> The solution is simply to remove the ANNOTATE_INTRA_FUNCTION_CALL
> annotation now that the instruction is not seen as a function call
> anymore.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com
> Fixes: bb7f054f4de2 ("objtool/powerpc: Add support for decoding all types of uncond branches")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/kernel/switch.S            | 1 -
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 --
>   2 files changed, 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/switch.S b/arch/powerpc/kernel/switch.S
> index 608c0ce7cec6..59e3ee99db0e 100644
> --- a/arch/powerpc/kernel/switch.S
> +++ b/arch/powerpc/kernel/switch.S
> @@ -39,7 +39,6 @@ flush_branch_caches:
>   
>   	// Flush the link stack
>   	.rept 64
> -	ANNOTATE_INTRA_FUNCTION_CALL
>   	bl	.+4
>   	.endr
>   	b	1f
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index ea7ad200b330..83f7504349d2 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1524,14 +1524,12 @@ kvm_flush_link_stack:
>   
>   	/* Flush the link stack. On Power8 it's up to 32 entries in size. */
>   	.rept 32
> -	ANNOTATE_INTRA_FUNCTION_CALL
>   	bl	.+4
>   	.endr
>   
>   	/* And on Power9 it's up to 64. */
>   BEGIN_FTR_SECTION
>   	.rept 32
> -	ANNOTATE_INTRA_FUNCTION_CALL
>   	bl	.+4
>   	.endr
>   END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)


Applied this patch on top of linux-next 20250303, and it fixes the below 
reported warning.

arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call



Please add below tag:

Tested-By: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.


