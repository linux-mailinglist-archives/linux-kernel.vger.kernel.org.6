Return-Path: <linux-kernel+bounces-256281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D5934C12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775DE2852CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829513210D;
	Thu, 18 Jul 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jP04u4Ti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Pl4KKTX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b3oSIphJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0UiQITRe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75431EA80
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300356; cv=none; b=gr84NjayVa72V8aBWgHcMh5DUasqtesKBp8GBfRPm/CH14ZpbvimN4bAtLSFU8nnNfvq6BD1JYLLVHJW4Tt6MU03pHysUhKAuhKRAR84cTbkzekactI4ogaaVUOOt0v2APxQbZyQ30+QZInyf+Mm5ed3hoe3GeL4owdYGnmcIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300356; c=relaxed/simple;
	bh=oOBzUDACGWmqlTkywrzVC20TPybCG2SsiDfnXEa5qtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JS42nc5r0XsQb7JZFZFTHX3lZlMRH1vaotsxPRMzooTq+pHKXqWdQcuZXKsbsn+fjvVVinznn19MxSISps5dNhL+xKrca2v723PETmyrFxhDLeix3lGF27K42xD8qgR2POLehpvVqIZENpzDcAquiQZJv9qWG/lNASKHnIqmXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jP04u4Ti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Pl4KKTX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b3oSIphJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0UiQITRe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09B201FBB6;
	Thu, 18 Jul 2024 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFAOU3HyKG9tRnPsNhPL4DSqpPq3LSyftAT+pe/MGVc=;
	b=jP04u4TiFtdKUVsw6+9h8RaPMeXwEoXBKSJnSVFW9sTMNqZpJmB9fyZ+fEKvT25o+der97
	H/XJyqu0ITsQOMtsgF9fp/bSaTyDYv84pLa6tSpLHnJ/aStbYYfBaBJF6NTbVAf5l/hGRQ
	K8iQtRSGON/uO34Q5eQM3LEnqn+fNdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFAOU3HyKG9tRnPsNhPL4DSqpPq3LSyftAT+pe/MGVc=;
	b=+Pl4KKTXhjQVfMnKnTxftQjY0L0MOKhjrW01aYcbEbs43kTz6+Z0pUO/f4QXBFl7aTIxXi
	frydlOmrb6BpKvCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b3oSIphJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0UiQITRe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721300352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFAOU3HyKG9tRnPsNhPL4DSqpPq3LSyftAT+pe/MGVc=;
	b=b3oSIphJjh+WSEs76GyYowWwp39g3y4SEXwzhbWSQRdL5B8DPCt91cP3JJGciTykcAZamj
	fGLFxucGm9SKpL2+a7aVZx7/NXgPB0v5QOAR+J5b4nzrKRQDjnPVBEM0kwQ/Ya0FdqJKEP
	/gZQmXocc+Vc/cetvw3gEdO8Iflj8to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721300352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZFAOU3HyKG9tRnPsNhPL4DSqpPq3LSyftAT+pe/MGVc=;
	b=0UiQITRe7i8FD6UiEBclgT1AvrbjB8BWsjYhd5Et8mDY6kf7OLg7mrwzYmPp0UnS6iXud3
	FB6Iwhr+/Aq5VyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F26F0136F7;
	Thu, 18 Jul 2024 10:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PD7ZNX71mGbnVAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 18 Jul 2024 10:59:10 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/9] Unify hugetlb into arch_get_unmapped_area functions
Date: Thu, 18 Jul 2024 12:58:54 +0200
Message-ID: <20240718105903.19617-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09B201FBB6
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Level: 
X-Spamd-Bar: /

Hi all,

this is a first attempt to get rid of a fair amount of duplicated code
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
 arch/parisc/mm/hugetlbpage.c         |  23 ------
 arch/powerpc/mm/book3s64/slice.c     |  49 +++++++-----
 arch/s390/include/asm/hugetlb.h      |  73 ++++--------------
 arch/s390/mm/hugetlbpage.c           |  84 ---------------------
 arch/s390/mm/mmap.c                  |   9 ++-
 arch/sh/include/asm/hugetlb.h        |  15 ----
 arch/sparc/kernel/sys_sparc_32.c     |  16 +++-
 arch/sparc/kernel/sys_sparc_64.c     |  36 +++++++--
 arch/sparc/mm/hugetlbpage.c          | 108 ---------------------------
 arch/x86/kernel/sys_x86_64.c         |  24 ++++--
 arch/x86/mm/hugetlbpage.c            | 100 -------------------------
 fs/hugetlbfs/inode.c                 |  92 ++---------------------
 include/asm-generic/hugetlb.h        |  15 ++--
 include/linux/hugetlb.h              |  21 +++---
 mm/mmap.c                            |  19 ++++-
 18 files changed, 153 insertions(+), 554 deletions(-)

-- 
2.45.2


