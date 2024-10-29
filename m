Return-Path: <linux-kernel+bounces-386438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352879B4385
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E831F235D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48562202F64;
	Tue, 29 Oct 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHlYgsje";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4YyJOKj1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHlYgsje";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4YyJOKj1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297141CCB33
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188217; cv=none; b=trhDdEfLcfjJyHDaG/mUeqkH4fl6hpdx1RtvnAubdFDSV9/8gpftC4+uXmANcXx3ue3XEmqjERR9cYzMtdj7FKBFFo62EPIyUvYFC4Jlt2QfwAjiArcyqbcAoJ91zcDGJK6K4oPDVUhNU6gyDN8h4WZ9xbkYdKfAtA1cO5d/izw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188217; c=relaxed/simple;
	bh=Jat8ycELDJW6m9KnK1+e4Hr0aNBp9+rjNnh1cxUtXWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCDxTw3qMDCOyFMsCPhyaYJ66FoJnoNb8nH81mmhypTr5hXE4sxb+CQ3Eg0PYv1fKJfYlINA67CuAdi+PZ1cXaEPakYlR6TO/P3rCsFZELNvJFyyYFxFsLMbXeljjawwqopwClzr6YR7vfWW++QXRKs16FrCbciV5Fzvnsp3sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHlYgsje; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4YyJOKj1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHlYgsje; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4YyJOKj1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3C6F21F9F;
	Tue, 29 Oct 2024 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730188212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3tGCR9SyoDmCFVnfF3niXmAN23SQy4Hlr/EAJvteP4=;
	b=aHlYgsjeWCyTIVhHwQvqm12zR7EXAtSfcG1h5IiI7dux1uRqZWwbJuCMiNXw5WwHLWEbrx
	emQlpkq2UxdLNoL5S83Y7PLBWDPPvCUnYzYQTZJWfkvinRC8O/eABXGXAsxOKQDxsHuMO3
	EFsu34ADIIB6QzWItN9+Q4lSSpsBAr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730188212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3tGCR9SyoDmCFVnfF3niXmAN23SQy4Hlr/EAJvteP4=;
	b=4YyJOKj1L2megsZADnpLDP3KmuNpNuNHDshEWa4kGG2fxE5XojV6IcKP35yeGssDLUhJGr
	6/UDE4+5RZZ2RhAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aHlYgsje;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4YyJOKj1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730188212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3tGCR9SyoDmCFVnfF3niXmAN23SQy4Hlr/EAJvteP4=;
	b=aHlYgsjeWCyTIVhHwQvqm12zR7EXAtSfcG1h5IiI7dux1uRqZWwbJuCMiNXw5WwHLWEbrx
	emQlpkq2UxdLNoL5S83Y7PLBWDPPvCUnYzYQTZJWfkvinRC8O/eABXGXAsxOKQDxsHuMO3
	EFsu34ADIIB6QzWItN9+Q4lSSpsBAr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730188212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3tGCR9SyoDmCFVnfF3niXmAN23SQy4Hlr/EAJvteP4=;
	b=4YyJOKj1L2megsZADnpLDP3KmuNpNuNHDshEWa4kGG2fxE5XojV6IcKP35yeGssDLUhJGr
	6/UDE4+5RZZ2RhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D60DB136A5;
	Tue, 29 Oct 2024 07:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jw/qM7OTIGdAfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Oct 2024 07:50:11 +0000
Message-ID: <ab636f4d-a140-460e-9ee4-fcd1e859ea67@suse.cz>
Date: Tue, 29 Oct 2024 08:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region() error
 path behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Brown
 <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F3C6F21F9F
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/28/24 23:14, Lorenzo Stoakes wrote:
> On Mon, Oct 28, 2024 at 10:28:47PM +0100, Vlastimil Babka wrote:
>> On 10/28/24 22:19, Linus Torvalds wrote:
>> > On Mon, 28 Oct 2024 at 11:00, Vlastimil Babka <vbabka@suse.cz> wrote:
>> >>
>> >> VM_MTE_ALLOWED is also set by arm64's arch_calc_vm_flag_bits():
>> >>
>> >>         if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>> >>                 return VM_MTE_ALLOWED;
>> >
>> > Yeah, but that should just move into arch_validate_flags() too.
>> > There's no reason why that's done in a separate place.
>> >
>> >                      Linus
>>
>> Right, and VM_DATA_DEFAULT_FLAGS is only used in do_brk_flags() which is
>> also an anonymous VMA, and it doesn't perform arch_validate_flags() anyway.
> 
> Unfortunately we can't do this and have everything work entirely
> consistently.

Consistently with the current implementation, which seems inconsiscent wrt
hugetlbfs.

> This is because, while adding a file parameter to arch_validate_flags()
> lets us do this shmem check, we can't be sure MAP_ANON was set and we do
> not have access to this information at the point of the
> arch_validate_flags() check.
> 
> We could check file == NULL, but this then excludes the MAP_ANON |
> MAP_HUGETLB case which is (probably accidentally) permitted by
> arch_calc_vm_flag_bits() and for the purposes of this fix we probably just
> want to keep behaviour identical.
> 
> We could alternatively check the file is shmem _or_ hugetlb but this would
> amount to a change in behaviour and not sure we want to go there.
> 
> Anyway I attach a patch that does what you suggest, I actually compiled
> this one (!) but don't have a system set up to test it (Mark?)
> 
> If we bring this in it should probably be a separate commit...
> 
> ----8<----
> From 247003cd2a4b5f4fc2dac97f5ef7e473a47f4324 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 28 Oct 2024 22:05:44 +0000
> Subject: [PATCH] mm: perform MTE check within arm64 hook entirely
> 
> It doesn't make sense to have shmem explicitly check this one arch-specific
> case, it is arch-specific, so the arch should handle it. We know shmem is a
> case in which we want to permit MTE, so simply check for this directly.
> 
> This also fixes the issue with checking arch_validate_flags() early, which
> would otherwise break mmap_region().
> 
> In order to implement this we must pass a file pointer, and additionally
> update the sparc code to accept this parameter too.
> 
> We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
> we risk inadvertently changing behaviour as we do not have mmap() flags
> available at the point of the arch_validate_flags() check and a MAP_ANON |
> MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
> MAP_HUGETLB would not.
> 
> This is likely an oversight but we want to try to keep behaviour identical
> to before in this patch.

If it's confirmed to be oversight and MAP_SHARED hugetlbfs should be
allowed, we could add another is_file_hugepages() condition

> So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> MAP_ANON.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  arch/arm64/include/asm/mman.h | 18 ++++++++++++++----
>  arch/sparc/include/asm/mman.h |  5 +++--
>  include/linux/mman.h          |  2 +-
>  mm/mmap.c                     |  4 ++--
>  mm/mprotect.c                 |  2 +-
>  mm/shmem.c                    |  3 ---
>  6 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 9e39217b4afb..44b7c8a1dd67 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -6,7 +6,9 @@
> 
>  #ifndef BUILD_VDSO
>  #include <linux/compiler.h>
> +#include <linux/fs.h>
>  #include <linux/types.h>
> +#include <linux/shmem_fs.h>
> 
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  	unsigned long pkey)
> @@ -60,15 +62,23 @@ static inline bool arch_validate_prot(unsigned long prot,
>  }
>  #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
> 
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
>  {
>  	if (!system_supports_mte())
>  		return true;
> 
> -	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
> -	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
> +	if (!(vm_flags & VM_MTE))
> +		return true;
> +
> +	if (vm_flags & VM_MTE_ALLOWED)
> +		return true;
> +
> +	if (shmem_file(file))
> +		return true;
> +
> +	return false;
>  }
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
> 
>  #endif /* !BUILD_VDSO */
> 
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index af9c10c83dc5..d426e1f7c2c1 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -10,6 +10,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long len);
> 
>  #ifdef CONFIG_SPARC64
>  #include <asm/adi_64.h>
> +#include <linux/fs.h>
> 
>  static inline void ipi_set_tstate_mcde(void *arg)
>  {
> @@ -54,11 +55,11 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>  	return 1;
>  }
> 
> -#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
> +#define arch_validate_flags(file, vm_flags) arch_validate_flags(file, vm_flags)
>  /* arch_validate_flags() - Ensure combination of flags is valid for a
>   *	VMA.
>   */
> -static inline bool arch_validate_flags(unsigned long vm_flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long vm_flags)
>  {
>  	/* If ADI is being enabled on this VMA, check for ADI
>  	 * capability on the platform and ensure VMA is suitable
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 8ddca62d6460..82e6488026b7 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -117,7 +117,7 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
>   *
>   * Returns true if the VM_* flags are valid.
>   */
> -static inline bool arch_validate_flags(unsigned long flags)
> +static inline bool arch_validate_flags(struct file *file, unsigned long flags)
>  {
>  	return true;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8462de1ee583..e06171d243ef 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1504,7 +1504,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> 
>  #ifdef CONFIG_SPARC64
>  	/* TODO: Fix SPARC ADI! */
> -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +	WARN_ON_ONCE(!arch_validate_flags(file, vm_flags));
>  #endif
> 
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
> @@ -1587,7 +1587,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		return -EACCES;
> 
>  	/* Allow architectures to sanity-check the vm_flags. */
> -	if (!arch_validate_flags(vm_flags))
> +	if (!arch_validate_flags(file, vm_flags))
>  		return -EINVAL;
> 
>  	/* Map writable and ensure this isn't a sealed memfd. */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6f450af3252e..c6db98b893fc 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -816,7 +816,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  		}
> 
>  		/* Allow architectures to sanity-check the new flags */
> -		if (!arch_validate_flags(newflags)) {
> +		if (!arch_validate_flags(vma->vm_file, newflags)) {
>  			error = -EINVAL;
>  			break;
>  		}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ba1d00fabda..e87f5d6799a7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
> 
> -	/* arm64 - allow memory tagging on RAM-based files */
> -	vm_flags_set(vma, VM_MTE_ALLOWED);
> -
>  	file_accessed(file);
>  	/* This is anonymous shared memory if it is unlinked at the time of mmap */
>  	if (inode->i_nlink)
> --
> 2.47.0


