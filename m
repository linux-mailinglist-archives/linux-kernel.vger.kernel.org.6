Return-Path: <linux-kernel+bounces-269453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149459432F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B65D1F20C82
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6F1BE23A;
	Wed, 31 Jul 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EIkWPSNS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3qN7f9Ie";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EIkWPSNS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3qN7f9Ie"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25D1B3F22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438709; cv=none; b=MMh0uPi+6Jq6oNt/v6IWWFHzO6P6lzOk0o9KN41ykNGjYVdh0Yd6kee3GVIoR0hIP7xznCSDGR9gxU7ouH5i3MLkWDVLkzEkFdx3tQMFbbrtNXMSO0wSzAjFzjd8PCZz3fQ0cE1rfuPIeCPLCbmr2oA2aarf41TWeg3X24UdxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438709; c=relaxed/simple;
	bh=uOIITmGM91VdgVptZH1x2tDeAKCbJM8ipfAeKi6mpO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snpGArzaKZY3ZtfWZsp5N/a63Gi5vvlB4g7CFZG6Zyjsx14/sXD8aFhW091DAKP+VZlM+uekgG0JXgnn+Xf6678AUZsUBc9ltadQstzhCPNM4Cb2vzy8N5SN4GEU8U410rEWQn/6DGpMSQML5va9sCfVIJhN2BP51kV4c4IfaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EIkWPSNS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3qN7f9Ie; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EIkWPSNS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3qN7f9Ie; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DD601F833;
	Wed, 31 Jul 2024 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722438705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg4N38Q3G0SdX08ZmyhgKmq/Y3k/Z7pvtjhZ8a5AhU=;
	b=EIkWPSNSdz3TYY4sX0iuFviVPwYjsbyk1jiww0xT9D/LwMXKdOcsC1ou+4z2ymhcNI/R8l
	gw9D2Hh2COWXZGDKoRaGJqnYQEmyrzWMUkD9JwgnJDm7a4gd8NDocROoM9KsP6uwHTNxfr
	I1/C0KwQFdWEGw75TL39jxt2vLWPAok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722438705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg4N38Q3G0SdX08ZmyhgKmq/Y3k/Z7pvtjhZ8a5AhU=;
	b=3qN7f9Ie7aEWsFTWpA/vDr+Sx7VbsTot9X8n/77BOJ4yMhffXRQkUBys6OeQuFiIH9at9l
	sDt9C+VjDWhz41Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722438705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg4N38Q3G0SdX08ZmyhgKmq/Y3k/Z7pvtjhZ8a5AhU=;
	b=EIkWPSNSdz3TYY4sX0iuFviVPwYjsbyk1jiww0xT9D/LwMXKdOcsC1ou+4z2ymhcNI/R8l
	gw9D2Hh2COWXZGDKoRaGJqnYQEmyrzWMUkD9JwgnJDm7a4gd8NDocROoM9KsP6uwHTNxfr
	I1/C0KwQFdWEGw75TL39jxt2vLWPAok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722438705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivg4N38Q3G0SdX08ZmyhgKmq/Y3k/Z7pvtjhZ8a5AhU=;
	b=3qN7f9Ie7aEWsFTWpA/vDr+Sx7VbsTot9X8n/77BOJ4yMhffXRQkUBys6OeQuFiIH9at9l
	sDt9C+VjDWhz41Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8065413297;
	Wed, 31 Jul 2024 15:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GroHHDBUqmbJAgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 31 Jul 2024 15:11:44 +0000
Date: Wed, 31 Jul 2024 17:11:34 +0200
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
Message-ID: <ZqpUJnhi5l38ijwj@localhost.localdomain>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
 <ZqpTaKHdrYt61HYy@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqpTaKHdrYt61HYy@localhost.localdomain>
X-Spamd-Result: default: False [-4.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.10

On Wed, Jul 31, 2024 at 05:08:24PM +0200, Oscar Salvador wrote:
> On Wed, Jul 31, 2024 at 12:02:47PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jul 29, 2024 at 11:10:15AM GMT, Oscar Salvador wrote:
> > >   * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
> > > @@ -1300,7 +1307,6 @@ static const struct file_operations hugetlbfs_file_operations = {
> > >  	.read_iter		= hugetlbfs_read_iter,
> > >  	.mmap			= hugetlbfs_file_mmap,
> > >  	.fsync			= noop_fsync,
> > > -	.get_unmapped_area	= hugetlb_get_unmapped_area,
> > 
> > This is causing a NULL pointer deref error in the mm self-tests,
> > specifically hugepage-shm.
> > 
> > This is because in __get_unmapped_area(), you check to see if the file has
> > an f_ops->get_unampped_area() however ('wonderfully'...) the shm stuff
> > wraps it, so this will be shm_get_unmapped_area() which then accesses the
> > underlying hugetlb file and _unconditionally_ calls
> > f_op->get_unmapped_area(), which you just made NULL and... kaboom :)
> > 
> > You can't even add null check in to this wrapper as at this point
> > everything assumes that you _can_ get an unmapped area. So yeah, it's kinda
> > broken.
> > 
> > This makes me think the whole thing is super-delicate and you probably need
> > to rethink this approach carefully, or least _very carefully_ audit users
> > of this operation.
> 
> Thanks for reporting this Lorenzo, highly appreciated.
> 
> I will check, but..
> 
> > By doing this you are causing an compilation error (at least on my compiler
> > with an x86-64 defconfig-based build):
> > 
> > arch/x86/mm/hugetlbpage.c:84:1: error: no previous prototype for
> > ‘hugetlb_get_unmapped_area’ [-Werror=missing-prototypes]
> >    84 | hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Something is off here.
> 
> git grep hugetlb_get_unmapped_area

Heh, of course I saw what is wrong after pressing intro.
Ok, with the entire series applied you should not see this problem as
hugetlb_get_unmapped_area gets totally wiped out, but checking out only
this commit indeed throws an error.

I will see how I can reshufle this.

thanks!


-- 
Oscar Salvador
SUSE Labs

