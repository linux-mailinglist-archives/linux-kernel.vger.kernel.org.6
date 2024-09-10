Return-Path: <linux-kernel+bounces-322596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F7972B57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0936DB22381
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3618453F;
	Tue, 10 Sep 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eJPFyJGc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="74BzRS9G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C4YXpm7r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/wH8E5Ra"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E3149E00
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955253; cv=none; b=ZpqqhT+74ENUXVt5JDuYvXHhREF639ONn8zY8H2iZ833rgOsAuxvscHcJX0w9wJaf7L2oFbhdk2uYOAPZcHhntwXyVHzQl20WHC15TwcqdnsDvTSyJAi+z/mwIvBSBNGqqvWh1Arbgw2lnFY4FTncPKxvSoRjKaPi/vk9idzMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955253; c=relaxed/simple;
	bh=OcAqzfYHYJ32Xl6KjrTHbbEUmNqSPmrkbUQ8Z89F+vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAM+zTnWiW+6as3al/ZQ0iA39uSNxcO4i+B9GmSCGmMYKQQYNDI55wLPqjO1RUymgita9zE5qt4h+FurDdQ2gqkNPM7X/RPkfOEdhMQ/ZNw42Y2NEwH3rp83QRGM8oFxEHbwTAfHVZ251z373AOTzujftdfXQwfJIp8KPzvcSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eJPFyJGc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=74BzRS9G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C4YXpm7r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/wH8E5Ra; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 983061F807;
	Tue, 10 Sep 2024 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yhO/qT0Y3vWGEa3fn0GR7ldtqThYO6oEScDupqRpLgQ=;
	b=eJPFyJGc7T5bsLOx7C9nrdYUPc+aCgqJTr8YSFsdVEhlNIAJvRKWsMmMNeCnzybrrlttKo
	Ai9Y7LbsGvSNEK89VL68GLp/JN6p5btcwdslj5Dtj9iegSyQucC3KYz0DmKOWN1t5PIH8Q
	UsXpLZzZhusa2FS9G+zZn4IJgZJHPzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yhO/qT0Y3vWGEa3fn0GR7ldtqThYO6oEScDupqRpLgQ=;
	b=74BzRS9GV3ZxX2uSR4O8WJojQp9lt4qAik3zfRUzFcFSm+DsjM5YPAi2y8fB+z1nsuQm0h
	B085gA7RQpJFZfBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C4YXpm7r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/wH8E5Ra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725955248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yhO/qT0Y3vWGEa3fn0GR7ldtqThYO6oEScDupqRpLgQ=;
	b=C4YXpm7ruSLBIiVmdwThvMhXaOUW8TeKXPmnGIZlwBLQ2Leveh2tjAOHIZnbOsAB1Kczph
	9YPyiMh/fgFa/0DzOdN9Fp/Eo6786LG026TdBxJJcNjP+nFr8/vH+Ded4cxzuMOqQTcgoA
	9DT80zsrMr12mr4acFeGtY2T54KL6xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725955248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yhO/qT0Y3vWGEa3fn0GR7ldtqThYO6oEScDupqRpLgQ=;
	b=/wH8E5Rab0LLjfUunG1XAkVXoT0RgMvIzhTYwCnkAXzKKLh9epmiDaz0cYKl+QwyRt6/Im
	4eeyt5BB2CzayNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB03C132CB;
	Tue, 10 Sep 2024 08:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id calzMq/832Y2MQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 10 Sep 2024 08:00:47 +0000
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
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 0/9] Unify hugetlb into arch_get_unmapped_area functions
Date: Tue, 10 Sep 2024 10:00:21 +0200
Message-ID: <20240910080030.1272373-1-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 983061F807
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

rfc -> v1: Fix s390 compilation errors
           Tested on s390
v1  -> v2: Rebased on top of mm-unstable
           Fix sparc64 compilation errors
v2  -> v3: Rebased on top of mm-unstable
           Fix bug reported by Lorenzo Stoakes


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

 arch/loongarch/include/asm/hugetlb.h |   4 -
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
 18 files changed, 145 insertions(+), 553 deletions(-)

-- 
2.46.0


