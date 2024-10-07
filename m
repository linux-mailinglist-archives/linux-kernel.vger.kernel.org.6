Return-Path: <linux-kernel+bounces-352942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A86992663
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EB61F22C05
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582C18B487;
	Mon,  7 Oct 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="poOqPz0u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nyQylENW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="poOqPz0u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nyQylENW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0B188736
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287454; cv=none; b=Duk9GgbpQRq931OmpZQL5gq9ZdzCHJGOW82lASlNnqSpoKl2Vb5i1z5EuCHtMSIseC8tc7fb7MACX0b9r7v6cXjLdeUb0g4f+jhI7uuv9MIbzu8JEB22bhegKFJxfSOmsLJDxi1QjxysOvYkeEn6X+xcDM7pfHmK+BP80Z4Kom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287454; c=relaxed/simple;
	bh=kg+FSZ3eOiWcoCwWY+MGAQd0zgxu3ygIg6MxfqRAX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GENAk59lGdf9TtGzymwtqWpeuDSl8B87dHszMH44jqJWgXOe4ClD+2WiUvOSyjMSQNEqITw6hLGRA/9pPj+KM2pTqrQTojoSmxZ8+lbCZfC472mcUw0zMxl+pGAeO5Pi0S6ksnuEKeOy1lYLIbVtDIvfePNB3F7wTDk31QM11ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=poOqPz0u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nyQylENW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=poOqPz0u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nyQylENW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3539121BB5;
	Mon,  7 Oct 2024 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E+D2Dok2cV3K0Z2U3dJxB5/BdOvN2cE918nP3F/1OwU=;
	b=poOqPz0u0LO80DSPbgUL/W3ooEloBAyuHxQlJe6HfnIYEYCdddziy86T4risdDfw+bQKPq
	4gKs5ohjUzcHEqWj6yV5AbViMBaemYzAO/6gsvrJ02AvqhdXX4Zkqd1JjbaWvheYgcpgAL
	Y0EgB4FA3kP6/PG0RGQm1mrmeVtlqgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E+D2Dok2cV3K0Z2U3dJxB5/BdOvN2cE918nP3F/1OwU=;
	b=nyQylENWb3m6KmK5mrXBImmuc36kOzmYxpTdS840zUwwrYHozykOLvRDh0fguAcccIbyjf
	4+NOsj3TJ/FottAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E+D2Dok2cV3K0Z2U3dJxB5/BdOvN2cE918nP3F/1OwU=;
	b=poOqPz0u0LO80DSPbgUL/W3ooEloBAyuHxQlJe6HfnIYEYCdddziy86T4risdDfw+bQKPq
	4gKs5ohjUzcHEqWj6yV5AbViMBaemYzAO/6gsvrJ02AvqhdXX4Zkqd1JjbaWvheYgcpgAL
	Y0EgB4FA3kP6/PG0RGQm1mrmeVtlqgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E+D2Dok2cV3K0Z2U3dJxB5/BdOvN2cE918nP3F/1OwU=;
	b=nyQylENWb3m6KmK5mrXBImmuc36kOzmYxpTdS840zUwwrYHozykOLvRDh0fguAcccIbyjf
	4+NOsj3TJ/FottAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8340A13A55;
	Mon,  7 Oct 2024 07:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /7kuHdqSA2d6cQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 07 Oct 2024 07:50:50 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 0/9] Unify hugetlb into arch_get_unmapped_area functions
Date: Mon,  7 Oct 2024 09:50:28 +0200
Message-ID: <20241007075037.267650-1-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

rfc -> v1: Fix s390 compilation errors
           Tested on s390
v1  -> v2: Rebased on top of mm-unstable
           Fix sparc64 compilation errors
v2  -> v3: Rebased on top of mm-unstable
           Fix bug reported by Lorenzo Stoakes
v3  -> v4: Rebased on top of mm-unstable
           Fix warning and error reported by Intel robot


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
hugetlb_get_unmapped_area, that gets called for hugetlb mappings,
runs some sanity checks prior to calling mm_get_unmapped_area_vmflags(),
so we do not need to that down the road in the respective
{generic,arch}_get_unmapped_area* functions.

More information can be found in the respective patches.

LTP mmapstress hugetlb selftests were ran succesfully on:

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
  mm: Consolidate common checks in hugetlb_get_unmapped_area

 arch/loongarch/include/asm/hugetlb.h |   5 --
 arch/mips/include/asm/hugetlb.h      |   4 -
 arch/parisc/include/asm/hugetlb.h    |  15 ----
 arch/parisc/mm/hugetlbpage.c         |  21 ------
 arch/powerpc/mm/book3s64/slice.c     |  50 ++++++++-----
 arch/s390/include/asm/hugetlb.h      |  73 ++++--------------
 arch/s390/mm/hugetlbpage.c           |  85 ---------------------
 arch/s390/mm/mmap.c                  |   9 ++-
 arch/sh/include/asm/hugetlb.h        |  15 ----
 arch/sparc/kernel/sys_sparc_32.c     |  17 ++++-
 arch/sparc/kernel/sys_sparc_64.c     |  37 +++++++--
 arch/sparc/mm/hugetlbpage.c          | 108 ---------------------------
 arch/x86/kernel/sys_x86_64.c         |  24 ++++--
 arch/x86/mm/hugetlbpage.c            | 101 -------------------------
 fs/hugetlbfs/inode.c                 |  94 +++--------------------
 include/asm-generic/hugetlb.h        |  15 ++--
 include/linux/hugetlb.h              |  22 +++---
 mm/mmap.c                            |   4 +
 18 files changed, 145 insertions(+), 554 deletions(-)

-- 
2.46.1


