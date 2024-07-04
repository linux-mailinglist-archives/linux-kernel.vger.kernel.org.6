Return-Path: <linux-kernel+bounces-240530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A8926E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C9E28A754
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE049148FF5;
	Thu,  4 Jul 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hwqDJNVK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSnnQJXR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hwqDJNVK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSnnQJXR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5E1487E1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067562; cv=none; b=npJeGzK8vTQMnCPzFJ6JcXiQjUIJHrVwHoqfszDeSTpIVtWhIrlF0GqplXJvfvm/uaBsB0VhBBJrfcYgQvTCMq0bi8rw8NADeFuCoz4KJjjM9ZaVkZXcArW8iyTnrO8K2mISbmpJrCH5Oh0VdpeRtFs/o6kBQi4aOTrTXbhAchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067562; c=relaxed/simple;
	bh=8gai68bXl2uiZ/cXNMkqDGWXNRoE9vEx1D9cFzbOn7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8xevVpa02vnh9/5leWZf5Xu5a27OFD0d+SAOZ2r71OG9/7Wu0K4wq52jC6F7R09NEQbgTpiE1SIPDpLU3NqY3dS3R1WPLj6iATQieA7T6sE272lHX8PhzcdiUu0xNmUZmfaKuEqa8Soap1X8a43NCTdJbuBLPih5cSL+MiCYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hwqDJNVK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSnnQJXR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hwqDJNVK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSnnQJXR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9876421C10;
	Thu,  4 Jul 2024 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRMEygtt9hYpWc9+hDgMaQcaULG8MqCO3fZe7sMmEA=;
	b=hwqDJNVK/CCOylYSLTwWXUVICQyx83G/knpDrCzGjHxZsYrpDDVMSCB321NNI98Hf7c5Fe
	fliGr2rF4bdqNm4A5diMwERQGXRj6hZTmNR2Bkz1zFSjM3T+0O/7G2l+AXTUcqMyvnhuqU
	fHH0ZeRfPHMYS1U4b1g+F9jlmYWgAqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRMEygtt9hYpWc9+hDgMaQcaULG8MqCO3fZe7sMmEA=;
	b=LSnnQJXRLmy1Y92nnMR+gbafnAKL4iJ1SAKvsbEP0jdZUQgWseUiTP/YO4XvsimDx5/+i6
	QWKNbAFvKiCbi8AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRMEygtt9hYpWc9+hDgMaQcaULG8MqCO3fZe7sMmEA=;
	b=hwqDJNVK/CCOylYSLTwWXUVICQyx83G/knpDrCzGjHxZsYrpDDVMSCB321NNI98Hf7c5Fe
	fliGr2rF4bdqNm4A5diMwERQGXRj6hZTmNR2Bkz1zFSjM3T+0O/7G2l+AXTUcqMyvnhuqU
	fHH0ZeRfPHMYS1U4b1g+F9jlmYWgAqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRMEygtt9hYpWc9+hDgMaQcaULG8MqCO3fZe7sMmEA=;
	b=LSnnQJXRLmy1Y92nnMR+gbafnAKL4iJ1SAKvsbEP0jdZUQgWseUiTP/YO4XvsimDx5/+i6
	QWKNbAFvKiCbi8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F2E913889;
	Thu,  4 Jul 2024 04:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEcAFuYlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:38 +0000
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
Subject: [PATCH 39/45] mm/madvise: Make madvise_cold_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:26 +0200
Message-ID: <20240704043132.28501-40-osalvador@suse.de>
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
 mm/madvise.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4c7c409e8b4a..e60311636c4c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -565,8 +565,20 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	return 0;
 }
 
+static int madvise_cold_test_walk(unsigned long start, unsigned long end,
+			   struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
+	return 0;
+}
+
 static const struct mm_walk_ops cold_walk_ops = {
 	.pmd_entry = madvise_cold_or_pageout_pte_range,
+	.test_walk = madvise_cold_test_walk,
 	.walk_lock = PGWALK_RDLOCK,
 };
 
-- 
2.26.2


