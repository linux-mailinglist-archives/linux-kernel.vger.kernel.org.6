Return-Path: <linux-kernel+bounces-190537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3638CFF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30A01F2106F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79215DBC8;
	Mon, 27 May 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vh099PAn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KrIgFpoO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vh099PAn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KrIgFpoO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072491581E2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811836; cv=none; b=jCVnHEgmsCuL1CuUQiuvj0jlTSPTn2PHxHTD+TGd8bbSkSvC3uFNscKHIUIaaH+8d0I0JCYyf6X7WpVN6BHuzfQ2hAJDWvRPL3Ch2ilGsmrqdSvK+4klgOtTpVM416sWmSWg6slrHx1y+R5R4QbHHM/zFdl054z/0NGtYwl/diI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811836; c=relaxed/simple;
	bh=rxSMY/7v0j7cE64TTIN3xDz8o8QHgdkPvnrkVPNcJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG7ua6HTDZihUZ++u03DBRpoGARBAjMxp0xByETf4XJxsjAyCiCwE5aYScGlL7O6K86mHw4kI1mb5bfh4tNJhYc05vZxDCS7GCR84yNtHU4qeb5W/407tQ6tX8TDMdVG1KI5yjvSBoekPz5fVvA13UMCPIakkypp0z+EsjzTQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vh099PAn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KrIgFpoO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vh099PAn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KrIgFpoO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 285A921E8D;
	Mon, 27 May 2024 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716811833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvaI30Lc501OfGJxpLRPDdHJVdqbMySFwG1G/Pb/Fhs=;
	b=vh099PAndxLyEPIsy9E4zQcvEjjwomGo17E1z61rShLO1l/oy81WjLcrx6E9YBLFqcxuN1
	4NJKbjtWlt3gj3LXl4MROawdJ3lmA1PecehlPSKQumw0obvCt/GfrrY1ZDa+xZTM0QWg8m
	CoFvcrONeO5ObJq6WjivL7O0auPCm7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716811833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvaI30Lc501OfGJxpLRPDdHJVdqbMySFwG1G/Pb/Fhs=;
	b=KrIgFpoO8KoA/E7A1TKrafaMlo1xGEQnE5ztSYWcl7Qbv4WAXr8pwACx+wRii1Hg3aHJRi
	PiXfifP6mdP/otAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716811833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvaI30Lc501OfGJxpLRPDdHJVdqbMySFwG1G/Pb/Fhs=;
	b=vh099PAndxLyEPIsy9E4zQcvEjjwomGo17E1z61rShLO1l/oy81WjLcrx6E9YBLFqcxuN1
	4NJKbjtWlt3gj3LXl4MROawdJ3lmA1PecehlPSKQumw0obvCt/GfrrY1ZDa+xZTM0QWg8m
	CoFvcrONeO5ObJq6WjivL7O0auPCm7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716811833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mvaI30Lc501OfGJxpLRPDdHJVdqbMySFwG1G/Pb/Fhs=;
	b=KrIgFpoO8KoA/E7A1TKrafaMlo1xGEQnE5ztSYWcl7Qbv4WAXr8pwACx+wRii1Hg3aHJRi
	PiXfifP6mdP/otAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E42613A88;
	Mon, 27 May 2024 12:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SHkOIDh4VGYEVgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 12:10:32 +0000
Date: Mon, 27 May 2024 14:10:23 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 08/16] powerpc/8xx: Rework support for 8M pages
 using contiguous PTE entries
Message-ID: <ZlR4L9g9uQ6j7J3Y@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <09f4ae803da751de7741f3d6bc5d94b8acf18829.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f4ae803da751de7741f3d6bc5d94b8acf18829.1716714720.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Sun, May 26, 2024 at 11:22:28AM +0200, Christophe Leroy wrote:
> In order to fit better with standard Linux page tables layout, add
> support for 8M pages using contiguous PTE entries in a standard
> page table. Page tables will then be populated with 1024 similar
> entries and two PMD entries will point to that page table.
> 
> The PMD entries also get a flag to tell it is addressing an 8M page,
> this is required for the HW tablewalk assistance.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I did not look close into KSAN bits, and I trust you with the assembly part,
but other than that looks good to me, so FWIW:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Just a nit below:

> +#define __HAVE_ARCH_HUGE_PTEP_GET
> +static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
> +{
> +	if (ptep_is_8m_pmdp(mm, addr, ptep))
> +		ptep = pte_offset_kernel((pmd_t *)ptep, 0);

Would it not be more clear to use pmd_page_vaddr directly there?


-- 
Oscar Salvador
SUSE Labs

