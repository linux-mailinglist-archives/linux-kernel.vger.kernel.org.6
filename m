Return-Path: <linux-kernel+bounces-240492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F645926E54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32F6284EE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D421A0C;
	Thu,  4 Jul 2024 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TnzHIbUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bF+fGAUR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TnzHIbUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bF+fGAUR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A02F23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067514; cv=none; b=oKnhvx9wM34Ll97px3+8mhqSovx4PESpamhCA9JT/KvXhJ2kEiT+ZyqK6InqMsjBmpEWO2xnNp9k9p7Z7Hqn2IZ+ZVbiTNR29GaAh6qFK4plpZ1hD6MNcKhTamxdocnrJeyB36OPVBZiY8gocSkYQzo/T7rtF+BVcLiFKsEi/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067514; c=relaxed/simple;
	bh=KFdArfnfqEUxgBAxz6IkehnNwcNlGS1yjQG75QAse0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7xfrlhe1+QxkdP7oIcGypjJTbc9j8N+vysPa1Ug0N022UVLt/cvMu2Nv6dw9eHgu2bENv/bTW88W2t/1SAmQBBOfclrSNc2sjmJ4OWX65aZbdfuFlgZSQqGo+9UUWKsYV/zszRe5urDcL/bSw0KhAbwdFNcmgTL2q/7saS5cKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TnzHIbUf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bF+fGAUR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TnzHIbUf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bF+fGAUR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97BAB1FCF7;
	Thu,  4 Jul 2024 04:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJqkPqmkpON5Zxkai/QS1QclW4CGF+6WU8c6arXYcis=;
	b=TnzHIbUfH5DwSZglMNw4Qi9u/goipKZZo3b5tCXWSNzXHcGWuTfIuyoCPpBaZ7EQWJZ4xP
	xc8s51VaseURhWTMdpAiOLKejN3kTYWph/K3arXExfBqJilkikxqtS1oEa7zsCdFYmuN0K
	Qf9du4CansKgid+LQOtm3331g59SMt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJqkPqmkpON5Zxkai/QS1QclW4CGF+6WU8c6arXYcis=;
	b=bF+fGAURxq2QVQDGIfnETCWk/28DcKQ+0DPeiRUpZJTGyNdki5AfAv3X8A2SjYr3HMCp0b
	41nDiQe78mUbZ7Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJqkPqmkpON5Zxkai/QS1QclW4CGF+6WU8c6arXYcis=;
	b=TnzHIbUfH5DwSZglMNw4Qi9u/goipKZZo3b5tCXWSNzXHcGWuTfIuyoCPpBaZ7EQWJZ4xP
	xc8s51VaseURhWTMdpAiOLKejN3kTYWph/K3arXExfBqJilkikxqtS1oEa7zsCdFYmuN0K
	Qf9du4CansKgid+LQOtm3331g59SMt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJqkPqmkpON5Zxkai/QS1QclW4CGF+6WU8c6arXYcis=;
	b=bF+fGAURxq2QVQDGIfnETCWk/28DcKQ+0DPeiRUpZJTGyNdki5AfAv3X8A2SjYr3HMCp0b
	41nDiQe78mUbZ7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C25713A82;
	Thu,  4 Jul 2024 04:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YDqrGbUlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:49 +0000
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
Subject: [PATCH 01/45] arch/x86: Drop own definition of pgd,p4d_leaf
Date: Thu,  4 Jul 2024 06:30:48 +0200
Message-ID: <20240704043132.28501-2-osalvador@suse.de>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

We provide generic definitions of pXd_leaf in pgtable.h when the arch
do not define their own, where the generic pXd_leaf always return false.

Although x86 defines {pgd,p4d}_leaf, they end up being a no-op, so drop them
and make them fallback to the generic one.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/include/asm/pgtable.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5bb902c..772f778bac06 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -252,13 +252,6 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
-#define p4d_leaf p4d_leaf
-static inline bool p4d_leaf(p4d_t p4d)
-{
-	/* No 512 GiB pages yet */
-	return 0;
-}
-
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 #define pmd_leaf pmd_leaf
@@ -1396,9 +1389,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
-#define pgd_leaf	pgd_leaf
-static inline bool pgd_leaf(pgd_t pgd) { return false; }
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages
-- 
2.26.2


