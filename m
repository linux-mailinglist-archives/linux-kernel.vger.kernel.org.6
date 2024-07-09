Return-Path: <linux-kernel+bounces-246595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3F192C40F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE82282144
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53A18003D;
	Tue,  9 Jul 2024 19:48:31 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5911B86DB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554511; cv=none; b=FJ4Vakgx2ulj+QzR1qRokDeP1/VdlsgjK/x6bKBtzu25eWuaz8zIgMXs1kQAU9Un/s+RIHFc/herrCpgG2sW4kxjduefpKMNUjbMzDQ4o03HZ0fDtagVlVB9LArhwpR7QcqFwhOh56PsPLXBAAAmjAFHK2SRz7+DcDs8vXnxruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554511; c=relaxed/simple;
	bh=WYZbynAxn0GnCdrts1qUKkW8U9GcBxK1qFe2mSggAYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBfBn57bjUojWiLK3+zUVLTlOk9dQWvgLfPz1+DPcrEwzwAqLV/XUffR1559vRBqACHzWFYE83BqjbuSUZLUufqrLMPj4qWFrTkzJDxFMZTddurHA9uPlCUPZ8sUIfyN/wVj5BwpFftG/ikylhlI6xKirkZGYLjlgPIbquGhO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WJWkg1HkPz9sSr;
	Tue,  9 Jul 2024 21:48:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xf_IeGqSmWKy; Tue,  9 Jul 2024 21:48:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WJWkg01nkz9sSq;
	Tue,  9 Jul 2024 21:48:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A3C098B778;
	Tue,  9 Jul 2024 21:48:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id NiN-SJ2v4SUl; Tue,  9 Jul 2024 21:48:26 +0200 (CEST)
Received: from [192.168.233.17] (unknown [192.168.233.17])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FBE08B773;
	Tue,  9 Jul 2024 21:48:26 +0200 (CEST)
Message-ID: <56a0340a-2534-4d2e-92e4-cf27a6358b23@csgroup.eu>
Date: Tue, 9 Jul 2024 21:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>
References: <b601e1a88e3a5d4d93b130fa20184b555e2a2bea.1720074307.git.christophe.leroy@csgroup.eu>
 <c8cb83b709740f7ac835997b88c5ddda610f66ab.1720074307.git.christophe.leroy@csgroup.eu>
 <Zoa2Qnpzl97hmpHC@x1n>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zoa2Qnpzl97hmpHC@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/07/2024 à 16:48, Peter Xu a écrit :
> On Thu, Jul 04, 2024 at 08:30:05AM +0200, Christophe Leroy wrote:
>> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
>> issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h
>>
>> Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
>> erroneously defined by architectures that do not implement the
>> related page level.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   include/asm-generic/pgtable-nop4d.h | 1 +
>>   include/asm-generic/pgtable-nopud.h | 1 +
>>   include/linux/pgtable.h             | 6 +++---
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
>> index 03b7dae47dd4..75c96bbc5a96 100644
>> --- a/include/asm-generic/pgtable-nop4d.h
>> +++ b/include/asm-generic/pgtable-nop4d.h
>> @@ -21,6 +21,7 @@ typedef struct { pgd_t pgd; } p4d_t;
>>   static inline int pgd_none(pgd_t pgd)		{ return 0; }
>>   static inline int pgd_bad(pgd_t pgd)		{ return 0; }
>>   static inline int pgd_present(pgd_t pgd)	{ return 1; }
>> +static inline int pgd_leaf(pgd_t pgd)		{ return 0; }
>>   static inline void pgd_clear(pgd_t *pgd)	{ }
>>   #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
>>   
>> diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
>> index eb70c6d7ceff..14aeb8ef2d8a 100644
>> --- a/include/asm-generic/pgtable-nopud.h
>> +++ b/include/asm-generic/pgtable-nopud.h
>> @@ -28,6 +28,7 @@ typedef struct { p4d_t p4d; } pud_t;
>>   static inline int p4d_none(p4d_t p4d)		{ return 0; }
>>   static inline int p4d_bad(p4d_t p4d)		{ return 0; }
>>   static inline int p4d_present(p4d_t p4d)	{ return 1; }
>> +static inline int p4d_leaf(p4d_t p4d)		{ return 0; }
>>   static inline void p4d_clear(p4d_t *p4d)	{ }
>>   #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
>>   
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 2a6a3cccfc36..b27e66f542d6 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -1882,13 +1882,13 @@ typedef unsigned int pgtbl_mod_mask;
>>    * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
>>    *   pXd_devmap(), or hugetlb mappings).
>>    */
>> -#ifndef pgd_leaf
>> +#if !defined(__PAGETABLE_P4D_FOLDED) && !defined(pgd_leaf)
>>   #define pgd_leaf(x)	false
>>   #endif
>> -#ifndef p4d_leaf
>> +#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(p4d_leaf)
>>   #define p4d_leaf(x)	false
>>   #endif
>> -#ifndef pud_leaf
>> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(pud_leaf)
>>   #define pud_leaf(x)	false
>>   #endif
>>   #ifndef pmd_leaf
> 
> Is it possible to do it the other way round, so that we can still rely on
> "ifdef pxx_leaf" to decide whether to provide a fallback, and define them
> properly when needed?

What do you mean by the "other way round" ? Did I do a mistake ? I can't 
see it.

The purpose here is:
- If the architecture has the said level and implements pXd_leaf(), 
that's fine
- If the architecture has the said level and doesn't implement 
pXd_leaf(), that's also fine, a fallback is provided.
- If the architecture doesn't have the said level but implements 
pXd_leaf(), it will conflict with the definition in 
include/asm-generic/pgtable-nopXd.h and the build will fail.

The purpose is to make sure architectures don't implement pXd_leaf() at 
the wrong level, for instance:
- an architecture without PMDs shall not implement anything else than 
pmd_leaf()
- an architecture without P4Ds shall not implement pgd_leaf().


> 
> IMHO it was a neat way to avoid worrying on any macro defined; it'll be as
> simple as "if function xxx not defined, let's define a fallback for xxx".
> Per my limited experience it helped a lot on avoid compile issues here and
> there..

That will still be the case.

This patch adds: "if function xxx is defined for wrong level, break the 
build"

Christophe

