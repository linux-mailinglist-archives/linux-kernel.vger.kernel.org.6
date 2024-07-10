Return-Path: <linux-kernel+bounces-247468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C124D92CFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F297D1C23A52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA63190676;
	Wed, 10 Jul 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBNmnGWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RRkG/rNk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBNmnGWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RRkG/rNk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E218FDB1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608692; cv=none; b=kS344sD6dFCeF0zyiYl1mYElLd2EXETGcsxGiAlGuj+6rj0oFshPhfwfkMOANEPaeA0wV+nOQef5HTtLWcUbbv4a6HKXOPsmz/IRsMlKR5GUAIJ5sCL4D0dLLf3t83Z07dx3IyP94h4OrjF+alm3kBAYrUNUZuZTVuL7ONH2jRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608692; c=relaxed/simple;
	bh=Oxtj9igO7IB71huIIa4lAOohyMNhVdUJX7elO4wiDIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4Rz/6+vDg3PVS8PnlGv01IUUfr0uZLSRCicYdBwltBkPNohGhk2ieCIdSZA4hWwMt4IEHm28kzoPXPdIXO8ACR+AkaBoQVB+N3Kx5PS3HR8pT9O6e9ndSBtWeMtQ8op4hv/U0+VFe2gL9xYuapvtMsL8NuRNsy6GOGInR7e2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBNmnGWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RRkG/rNk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBNmnGWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RRkG/rNk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A44CC1F827;
	Wed, 10 Jul 2024 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lrvDJU5l0ovDwxP58k+bdBMB6XPqMoeORnc5Pk5QfAg=;
	b=MBNmnGWtS9A/JKjJJfjp3uPtoUEOogBb+ZcM9IGAbRTHitdeUx6B18/6Tez6OlPCZRq7Je
	YuwVDLHZYgnAr4n5j0IFVT/uyoumfLhfT53iXQR0k8Nwpe4UJHiN0lriIx3XQnYIphd0fb
	S51sfCM5M/d1vR0E9ktYIahAL1k5/04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lrvDJU5l0ovDwxP58k+bdBMB6XPqMoeORnc5Pk5QfAg=;
	b=RRkG/rNk+i5L7QD+eXwAXJ1qZaTXOUJB8E1OIRbUSds0D3zKRcaCq/tQAJbgtDdPu3vTPU
	dkUGvxTcWR4JkoBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lrvDJU5l0ovDwxP58k+bdBMB6XPqMoeORnc5Pk5QfAg=;
	b=MBNmnGWtS9A/JKjJJfjp3uPtoUEOogBb+ZcM9IGAbRTHitdeUx6B18/6Tez6OlPCZRq7Je
	YuwVDLHZYgnAr4n5j0IFVT/uyoumfLhfT53iXQR0k8Nwpe4UJHiN0lriIx3XQnYIphd0fb
	S51sfCM5M/d1vR0E9ktYIahAL1k5/04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lrvDJU5l0ovDwxP58k+bdBMB6XPqMoeORnc5Pk5QfAg=;
	b=RRkG/rNk+i5L7QD+eXwAXJ1qZaTXOUJB8E1OIRbUSds0D3zKRcaCq/tQAJbgtDdPu3vTPU
	dkUGvxTcWR4JkoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C98D1369A;
	Wed, 10 Jul 2024 10:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SI+DGalnjmazcwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 10 Jul 2024 10:51:21 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Donet Tom <donettom@linux.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 0/8] Unify hugetlb into arch_get_unmapped_area functions
Date: Wed, 10 Jul 2024 12:50:34 +0200
Message-ID: <20240710105042.30165-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

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

LTP mmapstress and hugemmap testcases were ran on arm64, powerpc64le and
x86_64 without raising any issue.

Oscar Salvador (8):
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
  mm: Consolidate common checks in hugetlb_mmap_check_and_align

 arch/loongarch/include/asm/hugetlb.h |   4 -
 arch/mips/include/asm/hugetlb.h      |   4 -
 arch/parisc/include/asm/hugetlb.h    |  15 ----
 arch/parisc/mm/hugetlbpage.c         |  23 ------
 arch/powerpc/mm/book3s64/slice.c     |  49 +++++++-----
 arch/s390/include/asm/hugetlb.h      |  16 ----
 arch/s390/mm/hugetlbpage.c           |  84 ---------------------
 arch/s390/mm/mmap.c                  |   8 +-
 arch/sh/include/asm/hugetlb.h        |  15 ----
 arch/sparc/kernel/sys_sparc_32.c     |  16 +++-
 arch/sparc/kernel/sys_sparc_64.c     |  36 +++++++--
 arch/sparc/mm/hugetlbpage.c          | 108 ---------------------------
 arch/x86/kernel/sys_x86_64.c         |  24 ++++--
 arch/x86/mm/hugetlbpage.c            | 100 -------------------------
 fs/hugetlbfs/inode.c                 |  92 ++---------------------
 include/asm-generic/hugetlb.h        |   7 --
 include/linux/hugetlb.h              |  21 +++---
 mm/mmap.c                            |  19 ++++-
 18 files changed, 129 insertions(+), 512 deletions(-)

-- 
2.45.2


