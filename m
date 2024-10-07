Return-Path: <linux-kernel+bounces-352943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B0992664
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990181C22501
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8EB18B49D;
	Mon,  7 Oct 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ADp55/pX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1lcsC+83";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ADp55/pX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1lcsC+83"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1E18873E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287455; cv=none; b=HwSEyvSusrVB0uNB5zkS9zONJcMmUaMU3E8FEuZni/06/3b8jEkm0ZYKKNDLliK+OiHCZKhos/4k3Ja8WYlvfKIFISfMBI9qSF2VnF4/BE/4fWMDIGHL9DRDdFaGkkW/nx/11kJybkkH9TYNSqsFLIiizmpNUJF5Y6lT8rLrwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287455; c=relaxed/simple;
	bh=fJONQMVPYXZEetwgTFyRzSzzh7LsVRvyvn08ZVwZVaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyLru0gm5MA16ngBSW90MjLgcjsPLGSQqlzhqiJMnsonv2arNw6Upt5ZdOODK4WJz3n/a0RAgbkGt0jZbCd+SRJ3AMc5mLxpDJbZUdLqtHBX6B/JuQQUUhqDJWfjCT/noxMY8T0RrkQEl6fBTmmGHFIXl1MlCIDNu4un9KqqDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ADp55/pX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1lcsC+83; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ADp55/pX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1lcsC+83; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E86AA1F84F;
	Mon,  7 Oct 2024 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nToqOO7GlBoRNGFY8sGJEqoQNYfVFvYYnrXC4X6coa4=;
	b=ADp55/pX5WI3Mg9p7PK4RW8GW+Rn9bxI4wgI+2QNBq6Fe+4lbWESvGl+Utllq62MrtNWPk
	LB4wW1OQQDyXt1J0DpQ0hE9L5/KW2dCukUm8O4glSBuKyPypicn+56LITTQjvd1veOmfLa
	fsOiF7q3ZmEisIn4G3Vi8TEQyc/DUk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nToqOO7GlBoRNGFY8sGJEqoQNYfVFvYYnrXC4X6coa4=;
	b=1lcsC+839ZcPy/lvLPaLQ2i4gypqWEjq3jXCggK/8NOMN8nPKQ6m/eM6boA6rBSXNvnygJ
	GhKSYRbkGEIf8UBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728287451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nToqOO7GlBoRNGFY8sGJEqoQNYfVFvYYnrXC4X6coa4=;
	b=ADp55/pX5WI3Mg9p7PK4RW8GW+Rn9bxI4wgI+2QNBq6Fe+4lbWESvGl+Utllq62MrtNWPk
	LB4wW1OQQDyXt1J0DpQ0hE9L5/KW2dCukUm8O4glSBuKyPypicn+56LITTQjvd1veOmfLa
	fsOiF7q3ZmEisIn4G3Vi8TEQyc/DUk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728287451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nToqOO7GlBoRNGFY8sGJEqoQNYfVFvYYnrXC4X6coa4=;
	b=1lcsC+839ZcPy/lvLPaLQ2i4gypqWEjq3jXCggK/8NOMN8nPKQ6m/eM6boA6rBSXNvnygJ
	GhKSYRbkGEIf8UBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48676132BD;
	Mon,  7 Oct 2024 07:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MH/ODtuSA2d6cQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 07 Oct 2024 07:50:51 +0000
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
Subject: [PATCH v4 1/9] mm/mmap: Teach generic_get_unmapped_area{_topdown} to handle hugetlb mappings
Date: Mon,  7 Oct 2024 09:50:29 +0200
Message-ID: <20241007075037.267650-2-osalvador@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241007075037.267650-1-osalvador@suse.de>
References: <20241007075037.267650-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

We want to stop special casing hugetlb mappings and make them go
through generic channels, so teach generic_get_unmapped_area{_topdown}
to handle those.
The main difference is that we set info.align_mask for huge mappings.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h | 10 ++++++++++
 mm/mmap.c               |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4697539b665..368d552e4860 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1035,9 +1035,19 @@ void hugetlb_unregister_node(struct node *node);
  */
 bool is_raw_hwpoison_page_in_hugepage(struct page *page);
 
+static inline unsigned long huge_page_mask_align(struct file *file)
+{
+	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
+}
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline unsigned long huge_page_mask_align(struct file *file)
+{
+	return 0;
+}
+
 static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
 {
 	return NULL;
diff --git a/mm/mmap.c b/mm/mmap.c
index 9c0fb43064b5..57fd5ab2abe7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -776,6 +776,8 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
 	info.start_gap = stack_guard_placement(vm_flags);
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	return vm_unmapped_area(&info);
 }
 
@@ -826,6 +828,8 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.start_gap = stack_guard_placement(vm_flags);
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.46.1


