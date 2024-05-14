Return-Path: <linux-kernel+bounces-179160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63EE8C5C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43109B21878
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7335180A87;
	Tue, 14 May 2024 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mKTR+aaK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k9frE569";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mKTR+aaK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k9frE569"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9082A1D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719789; cv=none; b=laSr0U1FI6ANup6+8s47UZZWyht2t9Ij7GdSydSC5SelEuy0v4/9CSiWWIizSvhVpAtd7eXWLm8Iv7w8NCsVz5fVtdg4y/onAOfQ6CRk2tK2+15gToC7ySCocLgDxRN+1yQ/hWELQntSfrEdw606fyJ5rc02guspsScAjzrltds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719789; c=relaxed/simple;
	bh=JWldUvsrnIWGGZLfJMS4s8rA7OagaQQUPi1HdgCX6b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7LUaJc2BH0taaayIiF+Nr7QEdzurNdXJMfkUn3ikOSI4kiXum5oza2er9d3OsxWwF0/uJ7FzQpwWCM6kvM72Y6gwE7ndTOEtk0eXpUmOEhUARFihcz9HGc4LVZoaj/X8RjcULSPWf+rsp/lHqODc+K7b1I+tJv0VRxaM0PYUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mKTR+aaK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k9frE569; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mKTR+aaK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k9frE569; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 862361FB6C;
	Tue, 14 May 2024 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715719786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8/TImExnPcn0/P4PnWsqrauOrC1YnmySZaU3kuuKQg=;
	b=mKTR+aaKzODX7Bm5w+mkknOuaO+jQQbCeLDym0is6AC8PmHYyN73dBi0/hYTnEDofuxj8I
	Kx6PgXdk12mRN2ld6Yd4E5D27Hlf5mWPJFCGPgE+QXWp915yIRKXeXXDemrCc4ZBJYCb1k
	WOoKWXyX5jM/nzSiNnnqm5xz7ai09fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715719786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8/TImExnPcn0/P4PnWsqrauOrC1YnmySZaU3kuuKQg=;
	b=k9frE569ZnCt5JYUlUd2v5N4OV51TvkKRoEmTpdpMQ2eEuLOUzTKFZAGFr82Xh1MKEl6Qr
	0iBt6+BWhUaPkCDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715719786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8/TImExnPcn0/P4PnWsqrauOrC1YnmySZaU3kuuKQg=;
	b=mKTR+aaKzODX7Bm5w+mkknOuaO+jQQbCeLDym0is6AC8PmHYyN73dBi0/hYTnEDofuxj8I
	Kx6PgXdk12mRN2ld6Yd4E5D27Hlf5mWPJFCGPgE+QXWp915yIRKXeXXDemrCc4ZBJYCb1k
	WOoKWXyX5jM/nzSiNnnqm5xz7ai09fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715719786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8/TImExnPcn0/P4PnWsqrauOrC1YnmySZaU3kuuKQg=;
	b=k9frE569ZnCt5JYUlUd2v5N4OV51TvkKRoEmTpdpMQ2eEuLOUzTKFZAGFr82Xh1MKEl6Qr
	0iBt6+BWhUaPkCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92F761372E;
	Tue, 14 May 2024 20:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F3YiIWnOQ2aMJAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 20:49:45 +0000
Date: Tue, 14 May 2024 22:49:44 +0200
From: Oscar Salvador <osalvador@suse.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
Message-ID: <ZkPOaAUZrRWRGke0@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-5-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-5-bjorn@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.63 / 50.00];
	BAYES_HAM(-1.33)[90.33%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.63
X-Spam-Flag: NO

On Tue, May 14, 2024 at 04:04:42PM +0200, Björn Töpel wrote:
> +static void __meminit free_vmemmap_storage(struct page *page, size_t size,
> +					   struct vmem_altmap *altmap)
> +{
> +	if (altmap)
> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +	else
> +		free_pages((unsigned long)page_address(page), get_order(size));

David already pointed this out, but can check
arch/x86/mm/init_64.c:free_pagetable().

You will see that we have to do some magic for bootmem memory (DIMMs
which were not hotplugged but already present)

> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +void __ref vmemmap_free(unsigned long start, unsigned long end, struct vmem_altmap *altmap)
> +{
> +	remove_pgd_mapping(start, end, true, altmap);
> +}
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
> +#endif /* CONFIG_MEMORY_HOTPLUG */

I will comment on the patch where you add support for hotplug and the
dependency, but on a track in LSFMM today, we decided that most likely
we will drop memory-hotplug support for !CONFIG_SPARSEMEM_VMEMMAP
environments.
So, since you are adding this plain fresh, please consider to tight the
hotplug dependency to CONFIG_SPARSEMEM_VMEMMAP.
As a bonus, you will only have to maintain one flavour of functions.


-- 
Oscar Salvador
SUSE Labs

