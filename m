Return-Path: <linux-kernel+bounces-368057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382A9A0AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1861C22138
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA77207A1E;
	Wed, 16 Oct 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0wj2fRe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J1qm3N+v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vkYCij0l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhsqS6c0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FEF16DEB3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083188; cv=none; b=VFYCkY4LN9xtWniz7IMOB5mzUfvPLi1dnRcqEiqt3hC+P2HnuyGCzBR1E60Mb+O2C/Hx0FsyOEmByf9A00rIaBy8LCK/pel7UBxS8QtV9D32f0PQg0AcJvOEFIJqXzxDHOp6wA6C/O1sciP+5CpmPKy9C5+dqbKqCg/AFq0T5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083188; c=relaxed/simple;
	bh=f13yhwRH7SyRIyhCTiGz/fxmpz+PYHtVyAWTuN8bNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtrmD2UBhd4Vcbi9gWSfMhebrZnl9f16lQKdzzTQENjiuyh/aGKIpwQJncvQRNrdAJvGOCeSkRQgJ4ly1/Agu5qTN0NUX3hg+JqvnyJeNKbXMQx1K4eoBmEYyqKtSr2iAiGDG/1nXhV9+uryTdh0LaVE9ECTINc1cdDZ1K6kc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0wj2fRe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J1qm3N+v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vkYCij0l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhsqS6c0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC23E1FC30;
	Wed, 16 Oct 2024 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729083185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRaP0/RinlELspCg0hkyEkka1ZIZ9GjWjhMiDg/1knU=;
	b=m0wj2fRe7nf/JOO90VpDNKl97dYCK1CyDovZlt49wVkG3VMHVL4cGcLJ19KfJlWsORnMxd
	CEJi4HgL4E7A/+9WrG4+mxjgxJx+mb9Y58FG0uWq0xkd5/eKQO64TDL18SzUGyGJpjK09H
	9RHspBBdF5EbSBJ45Hkthuo7rcaHGcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729083185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRaP0/RinlELspCg0hkyEkka1ZIZ9GjWjhMiDg/1knU=;
	b=J1qm3N+vdt5yvm85Qpkfg7lIyyOadwhZHR5Cfd0eoy0E5cwqI0beq/jRLT08MttHbfC1p8
	M5fLqXs2KJPJxnAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vkYCij0l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lhsqS6c0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729083184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRaP0/RinlELspCg0hkyEkka1ZIZ9GjWjhMiDg/1knU=;
	b=vkYCij0l4YbqcQOmiGnzH2QMwu5R3q4pYSaKi1cyEdudiMdE203moRyd+LduQvQJDvbHqH
	2WrCmbMPScHKHItoTgHScuS2ElnGhmeBIeNnSHKaugI+w/oV9xwakiduCcvkQhlT9zFxmA
	ws2TD7XtuMNbdYZ6LDz7llOyx2Cu2I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729083184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRaP0/RinlELspCg0hkyEkka1ZIZ9GjWjhMiDg/1knU=;
	b=lhsqS6c0pcmq+IhuHMH9C/SnJJLxEilX7CuWtzyjz9hNEa7VfyFAj8U8ea2LgtQttsMykU
	EaDKBXoph+W4A9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACCD313433;
	Wed, 16 Oct 2024 12:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id El/VKTC3D2f4fAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Oct 2024 12:53:04 +0000
Message-ID: <25d5f12f-28ca-4320-919a-0cfa2dad1d01@suse.cz>
Date: Wed, 16 Oct 2024 14:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
References: <20241011150304.709590-1-ziy@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241011150304.709590-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CC23E1FC30
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/11/24 17:03, Zi Yan wrote:
> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") forces allocated page to be zeroed in
> post_alloc_hook() when init_on_alloc=1.
> 
> For order-0 folios, if arch does not define
> vma_alloc_zeroed_movable_folio(), the default implementation again zeros
> the page return from the buddy allocator. So the page is zeroed twice.
> Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
> define their own vma_alloc_zeroed_movable_folio().
> 
> For >0 order folios (mTHP and PMD THP), folio_zero_user() is called to
> zero the folio again. Fix it by calling folio_zero_user() only if
> init_on_alloc is set. All arch are impacted.

		   ^ not set?

> 
> Added alloc_zeroed() helper to encapsulate the init_on_alloc check.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/highmem.h | 8 +-------
>  mm/huge_memory.c        | 3 ++-
>  mm/internal.h           | 6 ++++++
>  mm/memory.c             | 3 ++-
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index bec9bd715acf..6e452bd8e7e3 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -224,13 +224,7 @@ static inline
>  struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>  				   unsigned long vaddr)
>  {
> -	struct folio *folio;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> -	if (folio)
> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
>  }
>  #endif
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 82f464865570..5dcbea96edb7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1176,7 +1176,8 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>  	}
>  	folio_throttle_swaprate(folio, gfp);
>  
> -	folio_zero_user(folio, addr);
> +	if (!alloc_zeroed())
> +		folio_zero_user(folio, addr);
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * folio_zero_user writes become visible before the set_pmd_at()
> diff --git a/mm/internal.h b/mm/internal.h
> index 906da6280c2d..508f7802dd2b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1233,6 +1233,12 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>  void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	       pmd_t *pmd, bool write);
>  
> +static inline bool alloc_zeroed(void)
> +{
> +	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +			&init_on_alloc);
> +}
> +
>  enum {
>  	/* mark page accessed */
>  	FOLL_TOUCH = 1 << 16,
> diff --git a/mm/memory.c b/mm/memory.c
> index c67359ddb61a..88252f0e06d0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4719,7 +4719,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  				goto next;
>  			}
>  			folio_throttle_swaprate(folio, gfp);
> -			folio_zero_user(folio, vmf->address);
> +			if (!alloc_zeroed())
> +				folio_zero_user(folio, vmf->address);
>  			return folio;
>  		}
>  next:


