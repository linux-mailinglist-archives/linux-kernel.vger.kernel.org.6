Return-Path: <linux-kernel+bounces-179144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA78C5C55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246DC1C219C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72C1EA80;
	Tue, 14 May 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LukJ1p5P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0I+MOdkt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LukJ1p5P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0I+MOdkt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576D1E501
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718773; cv=none; b=OlVlAz/L9kq8kUg+K+3DqdnrEPsDA3A9cF1WY0koVH/5QQTJLTgmsmBlm1RfiQvQl5SB2A73c1lDtTNVj2QLDw7EIMH+ASALxCGiko8jKbfshXs5nbITB36hWtbwbRTvijh30CtRJRd5efcKBUGOdsh2llx6zc3k/ovV3Tp54Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718773; c=relaxed/simple;
	bh=RdkQFK1O+AIwgCXbOlknN6KrMEhO+Se7DoIN+ZAc9xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD53M/Fu2HAH0MAMzbipL4afD97aWB+V7YUU7fqy/yKorsJqLEpowF7sQYfm5l6VtigSKzPSH0kp8ZZxZHweDyvDHNpMGJrIDS35z+ujxP29VDyzhSchHOnzsa5G1cjJV/MGaM6FaWlpcWw5wlUmKzmB3g6T01KIItJhtzGm1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LukJ1p5P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0I+MOdkt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LukJ1p5P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0I+MOdkt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 948CB1F911;
	Tue, 14 May 2024 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715718769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=LukJ1p5PWWbiu3qKRQ/sdBVZjjoR0JzQ24HSt7G0MajKuuOYVYByXM20LDzK5JbQMo4ziE
	z56/SLJzivpZcOuRUZw98Ki+vjMIlh040AIgK3vCWPnae6g4phKWqb4LsXlpLf2oKOt2ie
	kBrnRmDUjemc4Kg1FQe04AfOtXVmfyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715718769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=0I+MOdkt9NAN1JNbZ+9l7B9kHwT3WJVbIfpIfdTQse7f9nh8EeVYBmLj1d8T55ebexCPns
	3m0Q9+x/wNs3lhDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LukJ1p5P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0I+MOdkt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715718769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=LukJ1p5PWWbiu3qKRQ/sdBVZjjoR0JzQ24HSt7G0MajKuuOYVYByXM20LDzK5JbQMo4ziE
	z56/SLJzivpZcOuRUZw98Ki+vjMIlh040AIgK3vCWPnae6g4phKWqb4LsXlpLf2oKOt2ie
	kBrnRmDUjemc4Kg1FQe04AfOtXVmfyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715718769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=0I+MOdkt9NAN1JNbZ+9l7B9kHwT3WJVbIfpIfdTQse7f9nh8EeVYBmLj1d8T55ebexCPns
	3m0Q9+x/wNs3lhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A4B1372E;
	Tue, 14 May 2024 20:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kE0NIHDKQ2aOIAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 20:32:48 +0000
Date: Tue, 14 May 2024 22:32:43 +0200
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
Subject: Re: [PATCH v2 2/8] riscv: mm: Change attribute from __init to
 __meminit for page functions
Message-ID: <ZkPKazeHI4CENSP3@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-3-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-3-bjorn@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 948CB1F911
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.49 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, May 14, 2024 at 04:04:40PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Prepare for memory hotplugging support by changing from __init to
> __meminit for the page table functions that are used by the upcoming
> architecture specific callbacks.
> 
> Changing the __init attribute to __meminit, avoids that the functions
> are removed after init. The __meminit attribute makes sure the
> functions are kept in the kernel text post init, but only if memory
> hotplugging is enabled for the build.
> 
> Also, make sure that the altmap parameter is properly passed on to
> vmemmap_populate_hugepages().
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> +static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
> +						  uintptr_t fixed_map_size)
>  {
>  	phys_addr_t pa;
>  	uintptr_t va, map_size;
> @@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	 * memory hotplug, we are not able to update all the page tables with
>  	 * the new PMDs.
>  	 */
> -	return vmemmap_populate_hugepages(start, end, node, NULL);
> +	return vmemmap_populate_hugepages(start, end, node, altmap);

I would have put this into a separate patch.

 

-- 
Oscar Salvador
SUSE Labs

