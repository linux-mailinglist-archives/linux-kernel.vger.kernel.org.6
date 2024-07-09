Return-Path: <linux-kernel+bounces-245577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8592B486
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F243B21A20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED1155CAF;
	Tue,  9 Jul 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rhcEp/Mb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UvwW/JJB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rhcEp/Mb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UvwW/JJB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516201553BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518997; cv=none; b=QJRLVslTNlV+go6XXhoEaEt1EVh61Nr8kUQhsexLFiwxfZYcPFMUpPTO54CMSiIZy+lQJEKto71XhV9UEdz9G0CQqvLla/8CEuUiKABMBQlUdNeCSWci/SgUJlFXG8EYpm5KC8B6oEFr8A+WPRs+FmkbjPx01heCLgxGUZcs7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518997; c=relaxed/simple;
	bh=pyW+MepOw5PjwHeCHWGMHFoIXFXKcIpNZwFw09BsOTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUVBHicDpvbtbkEOlG/M5CAOdFr8HJPD2wrAySdjbAkWhtY6EtbMV98M0/bX6EIc3u91WAAgCZYGQVEW0N3axiVuXL64+gwZj8CmTpnIpgMku4A9HMdQQoMi5XbelSLyrMp7hTx89qvSEMNzaUqymm4DzAKgRZhsULDgGLI/yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rhcEp/Mb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UvwW/JJB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rhcEp/Mb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UvwW/JJB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE1FE21B9A;
	Tue,  9 Jul 2024 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720518988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMSXnQRaWruPl/Jbb8f0ExTGnX8AkZHFyonp0Yv7F64=;
	b=rhcEp/MblB7slK79Gre2oegMwS/bbMPzwJ1pYSaX3mVru25zl3eaVgt0W+x6qEELEZDbBj
	6887xhDXW1abZVl6yltZ5QTahrWl5C3WrfmRv+xEDi0SSM4/lt5uBvU+x603YVlz6MEJrG
	A4laRCzIxwnMFmAeY0Kf6P924JoxLq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720518988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMSXnQRaWruPl/Jbb8f0ExTGnX8AkZHFyonp0Yv7F64=;
	b=UvwW/JJB9rtc1rsYQ+n8cvw6k+IeFGqA1qb52uDZ+UT3jYp/LNGKCU5XaCJpOafdlC1oer
	e0tORqQf2ntIrkCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rhcEp/Mb";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UvwW/JJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720518988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMSXnQRaWruPl/Jbb8f0ExTGnX8AkZHFyonp0Yv7F64=;
	b=rhcEp/MblB7slK79Gre2oegMwS/bbMPzwJ1pYSaX3mVru25zl3eaVgt0W+x6qEELEZDbBj
	6887xhDXW1abZVl6yltZ5QTahrWl5C3WrfmRv+xEDi0SSM4/lt5uBvU+x603YVlz6MEJrG
	A4laRCzIxwnMFmAeY0Kf6P924JoxLq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720518988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMSXnQRaWruPl/Jbb8f0ExTGnX8AkZHFyonp0Yv7F64=;
	b=UvwW/JJB9rtc1rsYQ+n8cvw6k+IeFGqA1qb52uDZ+UT3jYp/LNGKCU5XaCJpOafdlC1oer
	e0tORqQf2ntIrkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CF6B1396E;
	Tue,  9 Jul 2024 09:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VjDOEUsJjWYqRAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 09 Jul 2024 09:56:27 +0000
Date: Tue, 9 Jul 2024 11:56:25 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tony Battersby <tonyb@cybernetics.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: Ensure
 generic_hugetlb_get_unmapped_area() returns higher address than
 mmap_min_addr
Message-ID: <Zo0JSVzKKmG_1ADQ@localhost.localdomain>
References: <20240709092122.41232-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709092122.41232-1-donettom@linux.ibm.com>
X-Rspamd-Queue-Id: BE1FE21B9A
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,linux.intel.com,kvack.org,vger.kernel.org,gmail.com,kernel.org,redhat.com,infradead.org,cybernetics.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jul 09, 2024 at 04:21:22AM -0500, Donet Tom wrote:
> generic_hugetlb_get_unmapped_area() was returning an address less
> than mmap_min_addr if the mmap argument addr, after alignment, was
> less than mmap_min_addr, causing mmap to fail.
> 
> This is because current generic_hugetlb_get_unmapped_area() code does
> not take into account mmap_min_addr.
> 
> This patch ensures that generic_hugetlb_get_unmapped_area() always returns
> an address that is greater than mmap_min_addr. Additionally, similar to
> generic_get_unmapped_area(), vm_end_gap() checks are included to ensure
> that the address is within the limit.

Hi Donet,

jfyi: I am already working on other parts of the kernel to avoid hugetlb code
duplication vs mm core.
I am also working on getting rid of hugetlb-unmapped_area specific code
[1].
I still need to perform some more tests but looks promising
code-deletion-wise:

  arch/parisc/mm/hugetlbpage.c     |  23 -------
  arch/powerpc/mm/book3s64/slice.c |  49 ++++++++------
  arch/s390/mm/hugetlbpage.c       |  84 ------------------------
  arch/s390/mm/mmap.c              |  14 +++-
  arch/sparc/kernel/sys_sparc_32.c |  16 +++--
  arch/sparc/kernel/sys_sparc_64.c |  36 ++++++++---
  arch/sparc/mm/hugetlbpage.c      | 108 -------------------------------
  arch/x86/kernel/sys_x86_64.c     |  27 +++++---
  arch/x86/mm/hugetlbpage.c        | 100 ----------------------------
  fs/hugetlbfs/inode.c             |  97 ++-------------------------
  include/linux/hugetlb.h          |  10 +++
  mm/mmap.c                        |  25 ++++++-
  12 files changed, 139 insertions(+), 450 deletions(-)

I plan to post it in a day or two.

[1] https://github.com/leberus/linux/tree/hugetlb-unmapped-area


-- 
Oscar Salvador
SUSE Labs

