Return-Path: <linux-kernel+bounces-388372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AD9B5E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E31B1C20F10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCD1E2312;
	Wed, 30 Oct 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DEMqJNHK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGyfx+/R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TICKER+c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYiOW9we"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B8194A73
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279912; cv=none; b=G2lzoVuVDnjTDxhyKXNQ+OBDeCte3JbMCPw2wO/6a+TLIVgHr1GuVbSX0GkhqfbOQI3zdfb7RTW77Kt/gHrzeGyH9JrjydJSkbqiIlRCnjNePHRLuCTu+8uGqmhLCl1HoWW+skQL/6Vk67yAAElPS2ga/gIH9TweW4daZ1wvE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279912; c=relaxed/simple;
	bh=Q2W3/EWP5kYvcaco9DS/ZcI4xXejoGuv59TnFyM+lEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g12esU92XcL+rsLGsDuQ+2B1R3ESIDsmVkXx2tF+hRoPsxlRDWoBL8vvXmYg1bU2AMQLAT17ptpthen6TSpjeysuy+KdDsJxxg7+c9Bp2wH0lu/LL3asJZIDPWJapMd49U4ATaY6kv9pbZbiKu+Zl9bSLl0Irh+uakKBX7BVMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DEMqJNHK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGyfx+/R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TICKER+c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYiOW9we; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEA5B1FB5D;
	Wed, 30 Oct 2024 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730279908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iL32MhgwIVaUwx+2Rkq/tXWgVqdWXvRc6rQkuMz1UM8=;
	b=DEMqJNHKLrzjfQIOYSGiK/vbrffMlFkYdttRh6PLK6FUtI2MAC0iFVxODzCFNNC/d7ahdZ
	ynSXDjRPoBCFPhD92MHFM7rtLKZ6aDVIo+C3aX5vDO/H4t0cb/z/LClnywdrLYHGJKbjYF
	qkraDveVoaqIsqyI5mvE4AMe8dW2ziA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730279908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iL32MhgwIVaUwx+2Rkq/tXWgVqdWXvRc6rQkuMz1UM8=;
	b=QGyfx+/RWv5NzERuJEmjW1Ktp00aW5LjfovFQ06FFLQ92InL08AjAilsKNbfhO1e1Zgzp9
	10LQIbkISY/C8NAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730279907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iL32MhgwIVaUwx+2Rkq/tXWgVqdWXvRc6rQkuMz1UM8=;
	b=TICKER+cps5YRQkApPvfWcrO/hO6e4sM4gA+qCXyIDBb0n82ijdYuTJCH+iJx7+CiHXS6h
	qKU8vN/nIQt6MVRWqaAbj+aM697ha6e08qyhSQl6XcgHkeazaFBdRnGNiJ4lOInAqzg6GY
	l4SiKsPV05vb3MGAYt6nvQf5/l6shsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730279907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iL32MhgwIVaUwx+2Rkq/tXWgVqdWXvRc6rQkuMz1UM8=;
	b=rYiOW9weIzCs0fwyW//c92HnOskpX3UOQV3TSCItpyUhHTBGeiMGtuuyLAhU/u3zjfLFWp
	7hcEJ/N4XQUN5LAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1A2213AD9;
	Wed, 30 Oct 2024 09:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iVcZJ+P5IWc0IQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Oct 2024 09:18:27 +0000
Message-ID: <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>
Date: Wed, 30 Oct 2024 10:18:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,google.com,vger.kernel.org,kvack.org,linux-foundation.org,redhat.com,arm.com,kernel.org,davemloft.net,gaisler.com,HansenPartnership.com,gmx.de];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/29/24 19:11, Lorenzo Stoakes wrote:
> Currently MTE is permitted in two circumstances (desiring to use MTE having
> been specified by the VM_MTE flag) - where MAP_ANONYMOUS is specified, as
> checked by arch_calc_vm_flag_bits() and actualised by setting the
> VM_MTE_ALLOWED flag, or if the file backing the mapping is shmem, in which
> case we set VM_MTE_ALLOWED in shmem_mmap() when the mmap hook is activated
> in mmap_region().
> 
> The function that checks that, if VM_MTE is set, VM_MTE_ALLOWED is also set
> is the arm64 implementation of arch_validate_flags().
> 
> Unfortunately, we intend to refactor mmap_region() to perform this check
> earlier, meaning that in the case of a shmem backing we will not have
> invoked shmem_mmap() yet, causing the mapping to fail spuriously.
> 
> It is inappropriate to set this architecture-specific flag in general mm
> code anyway, so a sensible resolution of this issue is to instead move the
> check somewhere else.
> 
> We resolve this by setting VM_MTE_ALLOWED much earlier in do_mmap(), via
> the arch_calc_vm_flag_bits() call.
> 
> This is an appropriate place to do this as we already check for the
> MAP_ANONYMOUS case here, and the shmem file case is simply a variant of the
> same idea - we permit RAM-backed memory.
> 
> This requires a modification to the arch_calc_vm_flag_bits() signature to
> pass in a pointer to the struct file associated with the mapping, however
> this is not too egregious as this is only used by two architectures anyway
> - arm64 and parisc.
> 
> So this patch performs this adjustment and removes the unnecessary
> assignment of VM_MTE_ALLOWED in shmem_mmap().
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -6,6 +6,8 @@
> 
>  #ifndef BUILD_VDSO
>  #include <linux/compiler.h>
> +#include <linux/fs.h>
> +#include <linux/shmem_fs.h>
>  #include <linux/types.h>
> 
>  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>  }
>  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> 
> -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> +						   unsigned long flags)
>  {
>  	/*
>  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
>  	 * backed by tags-capable memory. The vm_flags may be overridden by a
>  	 * filesystem supporting MTE (RAM-based).

We should also eventually remove the last sentence or even replace it with
its negation, or somebody might try reintroducing the pattern that won't
work anymore (wasn't there such a hugetlbfs thing in -next?).

>  	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
>  		return VM_MTE_ALLOWED;
> 
>  	return 0;
>  }

