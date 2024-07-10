Return-Path: <linux-kernel+bounces-247471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567092CFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590201C23AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883C1922CF;
	Wed, 10 Jul 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vWma3QMm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hdePWM/l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vWma3QMm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hdePWM/l"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E4191464
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608694; cv=none; b=Tp31VtN1iI2NSTUh9ASD2oWvR9soiZKKy54ZWm4/ivVEqZcRw7KFYr5XRBaPkFZSBG9PuJa+aYYzjeXgjwMYyuQPmRdPr3s+ATs4vs60yTmrswjjm+dvVp9GAowBvhWLGb9LKT/ctN7O3ETGFyQ3deqbf5kJzOUqu+nagufZ/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608694; c=relaxed/simple;
	bh=2TauxrxoL+LHouGn0r0YOhyAjtnpThDyasMCHFEcPao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PisbfHeHb/FExv3V/76pOvwFVW6Nb46LKmxCiMLxL7+m7qNpgZGuRqbUaeJI+QA4BFvK1g5qYNs6kUHuPipPVjTbPrIz87SRfobqxfc7V/cBO4henCvOsht0DtRBNOz4tCAb5AUW0nAI6RWCb2Me8NBES5UfvyQQ/DUJ+cZqeV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vWma3QMm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hdePWM/l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vWma3QMm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hdePWM/l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 364F61F824;
	Wed, 10 Jul 2024 10:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiX8eoexrmO/wjIpeeQ9glTEYeXiTS6tsv5T+BPJcGU=;
	b=vWma3QMmGeWRXJcr6gHXAh51UbyOC3/rO+Nxlq+dJJq+R+LMUKQD3tP2toFmn9IH4RsdtW
	XWOaFAZBQ7XWMwl6sf/zBMjtQlSOg7hRWPqODWwGD2lRvpSkFQGFg66rLqG3gJUQS7WeWN
	5Sh9v+CKdJQ93f4u5gZe257D5HEOWzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiX8eoexrmO/wjIpeeQ9glTEYeXiTS6tsv5T+BPJcGU=;
	b=hdePWM/lQgzDbtl3y1qRTw5AcA/nnPR2xCuLciXlwjGsJ8dQFNayVGStGn0kpjV3Z5iagx
	rWKWfsL4/uk4quCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720608685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiX8eoexrmO/wjIpeeQ9glTEYeXiTS6tsv5T+BPJcGU=;
	b=vWma3QMmGeWRXJcr6gHXAh51UbyOC3/rO+Nxlq+dJJq+R+LMUKQD3tP2toFmn9IH4RsdtW
	XWOaFAZBQ7XWMwl6sf/zBMjtQlSOg7hRWPqODWwGD2lRvpSkFQGFg66rLqG3gJUQS7WeWN
	5Sh9v+CKdJQ93f4u5gZe257D5HEOWzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720608685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiX8eoexrmO/wjIpeeQ9glTEYeXiTS6tsv5T+BPJcGU=;
	b=hdePWM/lQgzDbtl3y1qRTw5AcA/nnPR2xCuLciXlwjGsJ8dQFNayVGStGn0kpjV3Z5iagx
	rWKWfsL4/uk4quCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BB471369A;
	Wed, 10 Jul 2024 10:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIvoN6tnjmazcwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 10 Jul 2024 10:51:23 +0000
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
Subject: [RFC PATCH 2/8] arch/s390: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Wed, 10 Jul 2024 12:50:36 +0200
Message-ID: <20240710105042.30165-3-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710105042.30165-1-osalvador@suse.de>
References: <20240710105042.30165-1-osalvador@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach arch_get_unmapped_area{_topdown}
to handle those.
s390 specific hugetlb function does not set info.align_offset, so do
the same here for compatibility.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/s390/mm/mmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 206756946589..e98c00df586f 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -73,6 +73,8 @@ static inline unsigned long mmap_base(unsigned long rnd,
 
 static int get_align_mask(struct file *filp, unsigned long flags)
 {
+	if (filp && is_file_hugepages(filp))
+		return huge_page_mask_align(filp);
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
 	if (filp || (flags & MAP_SHARED))
@@ -106,7 +108,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	info.align_mask = get_align_mask(filp, flags);
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!(file && is_file_hugepages(filp))
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 	if (offset_in_page(addr))
 		return addr;
@@ -144,7 +147,8 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = get_align_mask(filp, flags);
-	info.align_offset = pgoff << PAGE_SHIFT;
+	if (!(file && is_file_hugepages(filp))
+		info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.45.2


