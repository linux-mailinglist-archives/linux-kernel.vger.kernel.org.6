Return-Path: <linux-kernel+bounces-240527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E13926E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADDF1F25323
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D951482EA;
	Thu,  4 Jul 2024 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBgo3NSc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sCT0CMUz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBgo3NSc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sCT0CMUz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759531474B5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067558; cv=none; b=jOwWxv3UY9luCsgKstxkOUqcTltsxIeMwf/MyVs5HeAafFGucCORXOqWapR7dqNLK5k78a/pUg0rhxHHBKy0lk+F4Gyvltby+r2+s1e5cqRlD6mcnGXaXasN90nlP1c4OMePItaEC0mlUX+eWkYzHOxsEHwrH+keOTjA1UMv4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067558; c=relaxed/simple;
	bh=3U59ZP18lkNdZ7l489KUIyawpNPZopBBsX003E0BKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWTC70yMn+mIsPVxq7hSd11/skG+viX34Il519CvoaCn0CDS71GfuMsdZ8udoI4cJClp4ULrG119YmGzZPxUr3Usy402pmbhat8rMNTTo2eb3+5GQaUAVnyWWkrvsaEJUFH4OCGMkB0EniNSWel6d2a8Zky4RfM+EQbkbX+j7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBgo3NSc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sCT0CMUz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBgo3NSc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sCT0CMUz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4E2A21180;
	Thu,  4 Jul 2024 04:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNX/My9OkoTrzpvFpT5zCUWuebklZgLLB1xxXIoHYo=;
	b=MBgo3NSczt8U7EEAXcD2SQA8wQ51zLbu6/4GLxv3/acFo/O9aeAjJinYHrahN+wHh6WN6E
	nJWgfUf/qMJFBilRyvUHpRCrHv3QH2RC9j0K0L3OAEZimxeISUardGz2TZ7zET0RJVlsf9
	vPaxOvkBTgVVPFz9W64mTDrSkfrzns0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNX/My9OkoTrzpvFpT5zCUWuebklZgLLB1xxXIoHYo=;
	b=sCT0CMUzMRt8XjozOQiz7eH0jI8RX27HURNG1GIXpzDYx1fhHI5xooLjdVheihL1p8vQfG
	66YxnUMPC011JyDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNX/My9OkoTrzpvFpT5zCUWuebklZgLLB1xxXIoHYo=;
	b=MBgo3NSczt8U7EEAXcD2SQA8wQ51zLbu6/4GLxv3/acFo/O9aeAjJinYHrahN+wHh6WN6E
	nJWgfUf/qMJFBilRyvUHpRCrHv3QH2RC9j0K0L3OAEZimxeISUardGz2TZ7zET0RJVlsf9
	vPaxOvkBTgVVPFz9W64mTDrSkfrzns0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNX/My9OkoTrzpvFpT5zCUWuebklZgLLB1xxXIoHYo=;
	b=sCT0CMUzMRt8XjozOQiz7eH0jI8RX27HURNG1GIXpzDYx1fhHI5xooLjdVheihL1p8vQfG
	66YxnUMPC011JyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F1113889;
	Thu,  4 Jul 2024 04:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QADdHuIlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:34 +0000
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
Subject: [PATCH 36/45] fs/proc: Make clear_refs_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:23 +0200
Message-ID: <20240704043132.28501-37-osalvador@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

Skip hugetlb vmas as we are not interested in those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5df17b7cfe6c..df94f2093588 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1579,6 +1579,9 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 	struct clear_refs_private *cp = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
 	if (vma->vm_flags & VM_PFNMAP)
 		return 1;
 
-- 
2.26.2


