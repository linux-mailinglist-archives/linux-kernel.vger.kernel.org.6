Return-Path: <linux-kernel+bounces-269527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C59433D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3216E2868F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E401BD00F;
	Wed, 31 Jul 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oJcjR3VS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXywWQYL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oJcjR3VS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pXywWQYL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92C1BBBD9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441939; cv=none; b=SWMlP3wRue0xoMHHs3FvVpvIxhO/uh+OOAPXMJMGgNTHNKReR7wer9EndcB8YAvz+QPTNBnoqIV6RAvnqxnKo3EU2ddx32oPFbX7nV+FSogfa3GkvsuCXeqW2gqDY71dBqOAZeAPDiTNhyOU0u0mCX2Yq49SW0+WQKd6wg3WGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441939; c=relaxed/simple;
	bh=tyUGTtpvkAN/3mchvYJD6+QYbbD7BQk21DeGvldxm+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnWdX3lN9ITRMoIsQ52D6wt1zOZfNzUWl0sZyYzZ10YA4PvyO2NGkwtmon57WVsq3apXL8bwptkJDQ0AE4xNmObyNZPbJWlZZP/GlBU3POGM8dkPY0c5bFzN73tcR8NzPAtpTQNU12MLWLmCU3AZsJYYcwMFh4RIE3DGe9+H0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oJcjR3VS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXywWQYL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oJcjR3VS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pXywWQYL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D93B21A70;
	Wed, 31 Jul 2024 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722441851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny1cQJm2Lwyao+X/FxxVd6jUz5C/XMTTGu2oaWCfi4M=;
	b=oJcjR3VS2GX2IeLTqS9h91H8Bg9dxaIuzRM4nH70z+W4uLn4KJ9y72unrG3h6ywQd0a8QR
	O2ftrCYZvOTG/e3lLLsZYPvmoElT4fC/greQQX0x5NDyzCpiSDfDoeEb3uiVo8mQ9lpB7H
	i0/Xv2FRg0GLS98GQOamel7pPChUwOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722441851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny1cQJm2Lwyao+X/FxxVd6jUz5C/XMTTGu2oaWCfi4M=;
	b=pXywWQYLENY8SqT86qk1rM6n4kTpF9M6bKUG9IfhQUVtDviPbTBMVorZJfJAway4vtPSE4
	iYxvDqZMjrtEYXAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oJcjR3VS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pXywWQYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722441851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny1cQJm2Lwyao+X/FxxVd6jUz5C/XMTTGu2oaWCfi4M=;
	b=oJcjR3VS2GX2IeLTqS9h91H8Bg9dxaIuzRM4nH70z+W4uLn4KJ9y72unrG3h6ywQd0a8QR
	O2ftrCYZvOTG/e3lLLsZYPvmoElT4fC/greQQX0x5NDyzCpiSDfDoeEb3uiVo8mQ9lpB7H
	i0/Xv2FRg0GLS98GQOamel7pPChUwOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722441851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny1cQJm2Lwyao+X/FxxVd6jUz5C/XMTTGu2oaWCfi4M=;
	b=pXywWQYLENY8SqT86qk1rM6n4kTpF9M6bKUG9IfhQUVtDviPbTBMVorZJfJAway4vtPSE4
	iYxvDqZMjrtEYXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C807C1368F;
	Wed, 31 Jul 2024 16:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jXscLnpgqmZ0EgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 31 Jul 2024 16:04:10 +0000
Date: Wed, 31 Jul 2024 18:04:04 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <ZqpgdBk-3Bcl3Mvr@localhost.localdomain>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
 <ZqpTaKHdrYt61HYy@localhost.localdomain>
 <354e4db4-e257-48a4-9e05-7f0595728ec6@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354e4db4-e257-48a4-9e05-7f0595728ec6@lucifer.local>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: 6D93B21A70

On Wed, Jul 31, 2024 at 04:19:09PM +0100, Lorenzo Stoakes wrote:
> Yeah this is at commit aee8efc95fc2 ("mm: make hugetlb mappings go through
> mm_get_unmapped_area_vmflags").
> 
> If you:
> 
> git checkout aee8efc95fc2
> git grep hugetlb_get_unmapped_area
> 
> You'll see it.
> 
> I'm guessing you remove this in future commits, but the kernel must be able
> to build at every revision so we can bisect (I found this issue through a
> bisect and had to fix this up to check).
> 
> A trivial fix is just to provide the prototype immediately prior to the
> function decl, however the more correct solution is probably to do the
> removals at the same time.

Yeah, I just squashed the removal commit and this one.

> This bit is just a bit of a slightly nitty cleanup to make sure things
> build at every commit, the first issue is the really key one, just needs
> some tweaking to deal with the frankly bloody horrible SHM stuff... Do not
> blame you for missing that one!

I did not check closely yet, but are blowing up in:

 if (shmem_huge != SHMEM_HUGE_FORCE) {
         ... 
	 if (file) {
		 VM_BUG_ON(file->f_op != &shmem_file_operations)

 ?  


-- 
Oscar Salvador
SUSE Labs

