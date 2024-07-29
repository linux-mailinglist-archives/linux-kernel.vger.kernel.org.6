Return-Path: <linux-kernel+bounces-265396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9093F0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3C42814A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25A13DDAF;
	Mon, 29 Jul 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kaDWpJbr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fpwvn7x1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GrmYBTQ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FcdlEcST"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663F84D2C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244237; cv=none; b=dw/Ys4GgWVVLa5GAqW0x9Mt5xE1cKEiTfb0j736C/ccDXV9inMs3z2vgzSC7moxe5CvD6H9irCqk7VBrJ2uGFxPwB5H2D2NkuTV/ghsQiWodOFb5MPLCp0EuQiqViZkg/kCL/ivc7p2eoqaeECU8BM1F7Dc2R0zBDo5T17pdfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244237; c=relaxed/simple;
	bh=h8lq2UN4qpy/M7hPhV5Sr7u4LeyxW6rl/wOn1AKPS74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCdK/gdsepxhP7m7qz+lovlJ9GyJy9vuaJbWuhfLzQCnHtYEaf438vsBb8kGlNiU0KEfKO1JLm5WPQpwVJf/MXUy6ElCPoVhaJ1y+OHzm9atttHKfJi75aQlCqqarZsvdEpN2e3eXd1G7xWPoVq4OWySlM94nZIci7wNUq/KQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kaDWpJbr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fpwvn7x1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GrmYBTQ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FcdlEcST; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69FDE21BC1;
	Mon, 29 Jul 2024 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722244233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wMU/Zr7CFASwQ2ifPLF85pGtonf3pJ2NdJJZhywHC6o=;
	b=kaDWpJbrR5EkyTe6kBL2eiWnnnzkCUNHNYeXPKYkcUkHtE4jqYRXCbekRLveCWzWDdYTFW
	8sgTSv+And5/RRn3iWSG7qmJTWWolrGZNbeCLSsi8IAJT4/c0a1nRrJg6NCb32LpucSQZ5
	ihvxsAE3lhiu9nnkrTXEYcO1o3CoqhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722244233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wMU/Zr7CFASwQ2ifPLF85pGtonf3pJ2NdJJZhywHC6o=;
	b=fpwvn7x1vRYjaHLkCoZ4TsM3SH9ZoTQUY0b1Td7zxdv6wLgG0U11wArymmKpsJlIkqmiDu
	FSI+giuqCeQg5PBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722244232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wMU/Zr7CFASwQ2ifPLF85pGtonf3pJ2NdJJZhywHC6o=;
	b=GrmYBTQ7drHzdTHAn7eqYlR0CN996TObxRvBrn6isFsBwUGYG6XLTgXAuYll0K91jwSd1C
	oKwbcMVqnyZ1904XUqva0DNU1qyEBlkGGnvuOEd6hNLXXjEi/dUfIF9nNE6XWZbcUp9yW4
	LX+mJJlCyeX/44/6+97HXUe39WzwZRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722244232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wMU/Zr7CFASwQ2ifPLF85pGtonf3pJ2NdJJZhywHC6o=;
	b=FcdlEcSTPUE5GR9bwgLO8ZRxu+F+bniPrSxwMQsCdEZL2BMeUP4Drh+VI4aZmeE4p/b58S
	Fx8DylnW8SQC1nCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20D131368A;
	Mon, 29 Jul 2024 09:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jisdAodcp2Z4BgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 29 Jul 2024 09:10:31 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/9] Unify hugetlb into arch_get_unmapped_area functions
Date: Mon, 29 Jul 2024 11:10:09 +0200
Message-ID: <20240729091018.2152-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

rfc -> v1: Fix s390 compilation errors
           Tested on s390
v1  -> v2: Rebased on top of mm-unstable
           Fix sparc64 compilation errors

This is an attempt to get rid of a fair amount of duplicated code
wrt. hugetlb and *get_unmapped_area* functions.

HugeTLB registers a .get_unmapped_area function which gets called from
__get_unmapped_area().
hugetlb_get_unmapped_area() is defined by a bunch of architectures and
it also has a generic definition for those that do not define it.
Short-long story is that there is a ton of duplicated code between
specific hugetlb *_get_unmapped_area_* functions and mm-core functions,
so we can do better by teaching arch_get_unmapped_area* functions how
to deal with hugetlb mappings.

Note that not a lot of things need to be taught though.
hugetlb_mmap_check_and_align(), that gets called for hugetlb mappings
prior to call mm_get_unmapped_area_vmflags(), runs some sanity checks
and aligns the addr to huge_page_size(), so we do not need to that
down the road in the respective {generic,arch}_get_unmapped_area*
functions.

More information can be found in the respective patches.

LTP mmapstress and hugemmap testcases were ran succesfully on:

- arm64
- powerpc64
- s390
- x86_64

Oscar Salvador (9):
  mm/mmap: Teach generic_get_unmapped_area{_topdown} to handle hugetlb
    mappings
  arch/s390: Teach arch_get_unmapped_area{_topdown} to handle hugetlb
    mappings
  arch/x86: Teach arch_get_unmapped_area_vmflags to handle hugetlb
    mappings
  arch/sparc: Teach arch_get_unmapped_area{_topdown} to handle hugetlb
    mappings
  arch/powerpc: Teach book3s64 arch_get_unmapped_area{_topdown} to
    handle hugetlb mappings
  mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags
  mm: Drop hugetlb_get_unmapped_area{_*} functions
  arch/s390: Clean up hugetlb definitions
  mm: Consolidate common checks in hugetlb_mmap_check_and_align

 arch/loongarch/include/asm/hugetlb.h |   4 -
 arch/mips/include/asm/hugetlb.h      |   4 -
 arch/parisc/include/asm/hugetlb.h    |  15 ----
 arch/parisc/mm/hugetlbpage.c         |  21 ------
 arch/powerpc/mm/book3s64/slice.c     |  49 +++++++-----
 arch/s390/include/asm/hugetlb.h      |  73 ++++--------------
 arch/s390/mm/hugetlbpage.c           |  85 ---------------------
 arch/s390/mm/mmap.c                  |   9 ++-
 arch/sh/include/asm/hugetlb.h        |  15 ----
 arch/sparc/kernel/sys_sparc_32.c     |  17 ++++-
 arch/sparc/kernel/sys_sparc_64.c     |  37 +++++++--
 arch/sparc/mm/hugetlbpage.c          | 108 ---------------------------
 arch/x86/kernel/sys_x86_64.c         |  24 ++++--
 arch/x86/mm/hugetlbpage.c            | 101 -------------------------
 fs/hugetlbfs/inode.c                 |  97 ++----------------------
 include/asm-generic/hugetlb.h        |  15 ++--
 include/linux/hugetlb.h              |  22 +++---
 mm/mmap.c                            |  19 ++++-
 18 files changed, 156 insertions(+), 559 deletions(-)

-- 
2.45.2


