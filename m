Return-Path: <linux-kernel+bounces-240535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 705C7926E82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11267B242C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4E14A0BF;
	Thu,  4 Jul 2024 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qWQLNf4E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9PS3LOnT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qWQLNf4E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9PS3LOnT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E6149DE9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067568; cv=none; b=PdbY9P/X8fUovlVC37M4PpdQkJ+ZlYWjGhlPugHxups8QEuXkxwD/DcqIiMk7ir0V7BysmLLxh4C2bCrtaHvPmk2UsMmdPl6DQuEO6n1q9+LQwkfVx5hioChu1teo1dXI6+WTeNhVIZNR03z3JWKeAeAV0wx6N1D95OUeQi2UAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067568; c=relaxed/simple;
	bh=RcwFClZPGTFoXt0drfryl0gzPaFgfKFSVQ5t/DvqB4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPJZkq80HPfQGs4wVdZs0DHy7oN6KVG8NqkSM14BugIEuYzepruNAmi1iZ3QntzGaaUtSgRi+kHJCmYlWnnd0I9TgQpgX8lFN3ZO6rFIqf5a0jpFv3BRy+MvU/hFVDPCmVlwQlFnUNE4gmLjiyF/tNm2xQE+W6oZmdMcPKxSXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qWQLNf4E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9PS3LOnT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qWQLNf4E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9PS3LOnT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D89E621180;
	Thu,  4 Jul 2024 04:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eR5Nhbb0ANiKXQprN8VC6tLG959+ERIV2i0QqHsYD4=;
	b=qWQLNf4EDHAPFOcSiw8o9yIVaDWy3wN7EvJ2sANX/QaSm9/dzdpfyxkS+tGCPT67FTj67/
	qxSBubrEfCFMg2meOU9ONT/982yfM0wORqljjkCK0CIkPk/MmyWkBuIbujyg+alQu42Nox
	+3A8UPaXHPIjQsi6zuoCjBr/Vxx+ZLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eR5Nhbb0ANiKXQprN8VC6tLG959+ERIV2i0QqHsYD4=;
	b=9PS3LOnTWX4tc9eF256ZXVJczKFHze/Ne7gNltkr5CcTePNcTuvg5Xdekx74hNiZwcr4HX
	nEMGuKsw4KpydzBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eR5Nhbb0ANiKXQprN8VC6tLG959+ERIV2i0QqHsYD4=;
	b=qWQLNf4EDHAPFOcSiw8o9yIVaDWy3wN7EvJ2sANX/QaSm9/dzdpfyxkS+tGCPT67FTj67/
	qxSBubrEfCFMg2meOU9ONT/982yfM0wORqljjkCK0CIkPk/MmyWkBuIbujyg+alQu42Nox
	+3A8UPaXHPIjQsi6zuoCjBr/Vxx+ZLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eR5Nhbb0ANiKXQprN8VC6tLG959+ERIV2i0QqHsYD4=;
	b=9PS3LOnTWX4tc9eF256ZXVJczKFHze/Ne7gNltkr5CcTePNcTuvg5Xdekx74hNiZwcr4HX
	nEMGuKsw4KpydzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C103213889;
	Thu,  4 Jul 2024 04:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +JDnKuwlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:44 +0000
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
Subject: [PATCH 44/45] mm/hugetlb_vmemmap: Make vmemmap_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:31 +0200
Message-ID: <20240704043132.28501-45-osalvador@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

Skip hugetlb vmas as we are not interested in those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb_vmemmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..3e6fd5ae27bd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -151,9 +151,21 @@ static int vmemmap_pte_entry(pte_t *pte, unsigned long addr,
 	return 0;
 }
 
+static int vmemmap_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
+	return 0;
+}
+
 static const struct mm_walk_ops vmemmap_remap_ops = {
 	.pmd_entry	= vmemmap_pmd_entry,
 	.pte_entry	= vmemmap_pte_entry,
+	.test_walk	= vmemmap_test_walk,
 };
 
 static int vmemmap_remap_range(unsigned long start, unsigned long end,
-- 
2.26.2


