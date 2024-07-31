Return-Path: <linux-kernel+bounces-269424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8E29432B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C426D1F23C67
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866C1758B;
	Wed, 31 Jul 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QHZERTQr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lZ9oCMgJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QHZERTQr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lZ9oCMgJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0317591
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438515; cv=none; b=dR3UldyS8dyRRlTUJm15UA83c4PkA4YnA8lkuCTDfZjtTWV8HvEPSNSefXLxGb9bv0OoP+tA2IiczlaznHtDms6tmt1WHHzrf7xbQy24Zlr9VIkcpx8oFn9UVyKi/GZAyJz+T1OajI4/D+TrwPJukhJ7C4upKvHmcOk2kKRvCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438515; c=relaxed/simple;
	bh=OxTsD5Hu8BdeqiVTTMft4KdH4o8UsVtLUKZevVjlb7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGpv6/t4PH2KCknm8OyYeWIAS4/IxhG2CbgXuq/6eIpd5CScMd3wTpXd8xykBFh+C+UFbUzTwTHu8DPmifeBvu4+9Z1m/SmndpDP0H47C1hdpAfW9oi9hVJsfM5i/+Bq0TOIjlbcHkj8XtBwFc+wdPfUTS6Z9l+3vYHcgh9g8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QHZERTQr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lZ9oCMgJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QHZERTQr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lZ9oCMgJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A36221F6E6;
	Wed, 31 Jul 2024 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722438506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwp8xAbk3X/CxJzE8xc/YbQEeo68FxxlFa0BXZImWLc=;
	b=QHZERTQrG5TRZ3d4zFgNUv9c/gvXRmGOnhc7TDFAWmMOtp47A/yeGISpPRCpCHdWgarohE
	7DMP78ue68VJZsuFlYC7WnmU5UtLjhr27YTW9QeYk4IkodZhY5V9Cev3NKhSZBNLOKeW5N
	ZX7w93jAwOutsTj/ndqbpvUTZNm1DGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722438506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwp8xAbk3X/CxJzE8xc/YbQEeo68FxxlFa0BXZImWLc=;
	b=lZ9oCMgJ88fl5BeXMilddt/5HwB0VS01xWomZ22vB2GBwdSeHr7djZkOdY/g7kGi+RUuHM
	8Cx6AUciYO4ApUAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QHZERTQr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lZ9oCMgJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722438506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwp8xAbk3X/CxJzE8xc/YbQEeo68FxxlFa0BXZImWLc=;
	b=QHZERTQrG5TRZ3d4zFgNUv9c/gvXRmGOnhc7TDFAWmMOtp47A/yeGISpPRCpCHdWgarohE
	7DMP78ue68VJZsuFlYC7WnmU5UtLjhr27YTW9QeYk4IkodZhY5V9Cev3NKhSZBNLOKeW5N
	ZX7w93jAwOutsTj/ndqbpvUTZNm1DGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722438506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwp8xAbk3X/CxJzE8xc/YbQEeo68FxxlFa0BXZImWLc=;
	b=lZ9oCMgJ88fl5BeXMilddt/5HwB0VS01xWomZ22vB2GBwdSeHr7djZkOdY/g7kGi+RUuHM
	8Cx6AUciYO4ApUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BE8313297;
	Wed, 31 Jul 2024 15:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q007AGpTqmayAQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 31 Jul 2024 15:08:26 +0000
Date: Wed, 31 Jul 2024 17:08:24 +0200
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
Message-ID: <ZqpTaKHdrYt61HYy@localhost.localdomain>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A36221F6E6
X-Spam-Score: -4.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]

On Wed, Jul 31, 2024 at 12:02:47PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jul 29, 2024 at 11:10:15AM GMT, Oscar Salvador wrote:
> >   * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
> > @@ -1300,7 +1307,6 @@ static const struct file_operations hugetlbfs_file_operations = {
> >  	.read_iter		= hugetlbfs_read_iter,
> >  	.mmap			= hugetlbfs_file_mmap,
> >  	.fsync			= noop_fsync,
> > -	.get_unmapped_area	= hugetlb_get_unmapped_area,
> 
> This is causing a NULL pointer deref error in the mm self-tests,
> specifically hugepage-shm.
> 
> This is because in __get_unmapped_area(), you check to see if the file has
> an f_ops->get_unampped_area() however ('wonderfully'...) the shm stuff
> wraps it, so this will be shm_get_unmapped_area() which then accesses the
> underlying hugetlb file and _unconditionally_ calls
> f_op->get_unmapped_area(), which you just made NULL and... kaboom :)
> 
> You can't even add null check in to this wrapper as at this point
> everything assumes that you _can_ get an unmapped area. So yeah, it's kinda
> broken.
> 
> This makes me think the whole thing is super-delicate and you probably need
> to rethink this approach carefully, or least _very carefully_ audit users
> of this operation.

Thanks for reporting this Lorenzo, highly appreciated.

I will check, but..

> By doing this you are causing an compilation error (at least on my compiler
> with an x86-64 defconfig-based build):
> 
> arch/x86/mm/hugetlbpage.c:84:1: error: no previous prototype for
> ‘hugetlb_get_unmapped_area’ [-Werror=missing-prototypes]
>    84 | hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~

Something is off here.

git grep hugetlb_get_unmapped_area

returns nothing.
After this, arch/x86/mm/hugetlbpage.c should only contain:

  #ifdef CONFIG_X86_64
  bool __init arch_hugetlb_valid_size(unsigned long size)
  {
          if (size == PMD_SIZE)
                  return true;
          else if (size == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
                  return true;
          else
                  return false;
  }
  
  #ifdef CONFIG_CONTIG_ALLOC
  static __init int gigantic_pages_init(void)
  {
          /* With compaction or CMA we can allocate gigantic pages at runtime */
          if (boot_cpu_has(X86_FEATURE_GBPAGES))
                  hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
          return 0;
  }
  arch_initcall(gigantic_pages_init);
  #endif
  #endif

so what is going here?
Maybe the series was not properly applied to mm-unstable?

I will have a look.


-- 
Oscar Salvador
SUSE Labs

