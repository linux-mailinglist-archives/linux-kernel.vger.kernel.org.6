Return-Path: <linux-kernel+bounces-240531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2668926E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD3D1C214ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C8B1494A2;
	Thu,  4 Jul 2024 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j6iEK8Pq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vQ4JL4C6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j6iEK8Pq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vQ4JL4C6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D205148848
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067564; cv=none; b=pXJ5LZwH4RfIKOLZlbXa+AyCSJqmJ+BCDkmsQIFy1lrFIRnhmLyXJ3AdNcdDzXi+hodv/S6EsIrotRm87E9L6c/lkJ+V3k24b1tZAdsyL/4CkO4qybmDSHl7immywvwK+c2002fb9TVgHIQfHzspRH4FC/R7FCfo1LhPUJ4kqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067564; c=relaxed/simple;
	bh=LA4Bt0HatbsR7tMBIK5rYy4CCuaafzjwktEMfkTXsI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4C9CaG6kQrlGnyTRWiVExyiod0WOLHXn8Eboa31oe6fxiImlcZ5qQiFMOtSO6hlepXlojfg7JQeSFv1lHOwUZ9WsTLRgo6Kth/hkDIBpg+JkhGQlciY4t31V7PXOsoOeePIuyMvV7UNt8S1Jg+Y7V3yj1sYNZ+SWUZjsv2aSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j6iEK8Pq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vQ4JL4C6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j6iEK8Pq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vQ4JL4C6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D03B721C11;
	Thu,  4 Jul 2024 04:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvSHNTt8bLluhGl3df5sQFwppsiw5zo4fh71urj/PzI=;
	b=j6iEK8PqgI9QRFImbu/UVsJysu4KND3ZF8Hf9UZxL94XKAaxTl/7gm9F4NIZVKQ4NnS873
	TQNyiXjMCFq8XNcKsBsPNmyqfm2qouwQCrbcFcFAGdwMNdfwK24xrwVgkLwP2jbuyhvLUH
	BPd9xM4HZ98MSq7QMtepwwtCtWt/SOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvSHNTt8bLluhGl3df5sQFwppsiw5zo4fh71urj/PzI=;
	b=vQ4JL4C6UPipOlC2cZ+CsrSqGZzo+7etIj0YNYzIdJOh1eq9XU9yhO8jX+7cuSFjbBdfjf
	W0zSPHZ7LidSpVCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvSHNTt8bLluhGl3df5sQFwppsiw5zo4fh71urj/PzI=;
	b=j6iEK8PqgI9QRFImbu/UVsJysu4KND3ZF8Hf9UZxL94XKAaxTl/7gm9F4NIZVKQ4NnS873
	TQNyiXjMCFq8XNcKsBsPNmyqfm2qouwQCrbcFcFAGdwMNdfwK24xrwVgkLwP2jbuyhvLUH
	BPd9xM4HZ98MSq7QMtepwwtCtWt/SOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvSHNTt8bLluhGl3df5sQFwppsiw5zo4fh71urj/PzI=;
	b=vQ4JL4C6UPipOlC2cZ+CsrSqGZzo+7etIj0YNYzIdJOh1eq9XU9yhO8jX+7cuSFjbBdfjf
	W0zSPHZ7LidSpVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3B513A82;
	Thu,  4 Jul 2024 04:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2CQKJuclhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:39 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 40/45] mm/madvise: Make madvise_free_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:27 +0200
Message-ID: <20240704043132.28501-41-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Skip hugetlb vmas as we are not interested in those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/madvise.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index e60311636c4c..08f72622913f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -805,8 +805,20 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+static int madvise_free_test_walk(unsigned long start, unsigned long end,
+				  struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
+	return 0;
+}
+
 static const struct mm_walk_ops madvise_free_walk_ops = {
 	.pmd_entry		= madvise_free_pte_range,
+	.test_walk		= madvise_free_test_walk,
 	.walk_lock		= PGWALK_RDLOCK,
 };
 
-- 
2.26.2


