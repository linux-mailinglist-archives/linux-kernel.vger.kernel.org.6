Return-Path: <linux-kernel+bounces-240511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83850926E68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68C01C23693
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AE1442E8;
	Thu,  4 Jul 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sp75Awte";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mj+n3kpv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sp75Awte";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Mj+n3kpv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C8143883
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067538; cv=none; b=GQOxL5mmWZidn2CDhR//Hito573PYqzMVrlLkV/6HgG31JcOkNJZ0q1CAEmzosjzRoTfKDT/1hMi356dT92D7IFqUh9r1uzHO0MBeDpu3UhHmVYfuZ95KKB4i6dRsESqVSMA8oArRK8+3kqf7S5btNGn24GE9qZFlXt4LLITM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067538; c=relaxed/simple;
	bh=ZlNbxiR3YiE76on6qozqMsygXT/rN9zht/ZciTsCxQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6RcMDtDV1QxfHg7skw19xmCKFKhVtvzXROcDxVmemk8tnk7mYOEMawTtIzjQhDVl40kMKbm/9clqHWAnrNryV3GHpZhSnYN3w3xOYIGW+tBeAhLrjA3fc40krmzMPfVBaXiUxbQCv7N+H7Vr0fkIgRB37W2ODkfZpE4wY3QXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sp75Awte; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mj+n3kpv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sp75Awte; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Mj+n3kpv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 487F31FCF9;
	Thu,  4 Jul 2024 04:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSKmwPU7BkbGtKq84iiMlBZLjbm/8YgbxNgKPRpjw3o=;
	b=Sp75Awtev0kxk3LPqK9XxrdT8mVKHhhRuRIBMOFdY8fEHNVHNNZ06aTT5CglZTRF8npqNz
	2Yy3uyOucP4OPr8Nv3JT4zfkut2bNZa/kPSEfP3yjJrNw6aJH7PjRQ35FXbRRBUM/Hdhb5
	qpJvjTmjFlI704iRP7Ya2VX/BQVd3/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSKmwPU7BkbGtKq84iiMlBZLjbm/8YgbxNgKPRpjw3o=;
	b=Mj+n3kpvgdn1kni7UbDFyJvbmlmLCXttzKSC9JGDxhxjtdRvE8XYhxKLUr9QMKGLWWztko
	A652jlHgiyBk0NDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSKmwPU7BkbGtKq84iiMlBZLjbm/8YgbxNgKPRpjw3o=;
	b=Sp75Awtev0kxk3LPqK9XxrdT8mVKHhhRuRIBMOFdY8fEHNVHNNZ06aTT5CglZTRF8npqNz
	2Yy3uyOucP4OPr8Nv3JT4zfkut2bNZa/kPSEfP3yjJrNw6aJH7PjRQ35FXbRRBUM/Hdhb5
	qpJvjTmjFlI704iRP7Ya2VX/BQVd3/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSKmwPU7BkbGtKq84iiMlBZLjbm/8YgbxNgKPRpjw3o=;
	b=Mj+n3kpvgdn1kni7UbDFyJvbmlmLCXttzKSC9JGDxhxjtdRvE8XYhxKLUr9QMKGLWWztko
	A652jlHgiyBk0NDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28FA913889;
	Thu,  4 Jul 2024 04:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uClaBc4lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:14 +0000
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
Subject: [PATCH 20/45] fs/proc: Enable gather_pte_stats to handle cont-pte mapped hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:07 +0200
Message-ID: <20240704043132.28501-21-osalvador@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

HugeTLB pages can be cont-pte mapped, so teach smaps_pte_entry to handle
them.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e13754d3246e..98dd03c26e68 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3175,6 +3175,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl;
 	pte_t *orig_pte;
 	pte_t *pte;
+	unsigned long size = PAGE_SIZE, cont_ptes = 1;
 
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 	ptl = pmd_huge_lock(pmd, vma);
@@ -3200,6 +3201,10 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
+	if (pte_cont(ptep_get(pte))) {
+		size = PAGE_SIZE * CONT_PTES;
+		cont_ptes = CONT_PTES;
+	}
 	do {
 		pte_t ptent = ptep_get(pte);
 		struct page *page = can_gather_numa_stats(ptent, vma, addr);
@@ -3207,7 +3212,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 			continue;
 		gather_stats(page, md, pte_dirty(ptent), 1);
 
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte += cont_ptes, addr += size, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
 	cond_resched();
 	return 0;
-- 
2.26.2


