Return-Path: <linux-kernel+bounces-240497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21618926E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAFE285534
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7D61FF8;
	Thu,  4 Jul 2024 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZiVO/eg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yNbA1i/f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZiVO/eg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yNbA1i/f"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9949650
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067520; cv=none; b=juPMAvOf5C6mRHnN1tLR59KrKcXFNA0nsi4IT62IYwhbmTDTi0KMAXjImYQy35+QucBgK18UyChBxzGYDb4eGi2dv0S1YO3ts9CgZs3WVi2PAl6zCgKrmI06fWbuTIdPUMKWuX1AKQ4e63yR++h1pLcivsslEDnvTRP+12ZBicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067520; c=relaxed/simple;
	bh=kngb8nlng11G16IWBCLNBURCZpdeETcwn2HiGHKXpo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hltFak9xqg7ZDdmomn02IJnfU5Sdpthl95mYLKhViy8m1bencEzfmlOz/eISmD20s0t0TfepQTAXZPtiasKsZQ7CUrkFPGcxOlYUMbuMu5lKv4PyT33XjfbiG3sDHdUrx8CTSUfBl7y3y9jpfcXodtakqgQ/DgRYPMcXBrwyxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZiVO/eg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yNbA1i/f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZiVO/eg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yNbA1i/f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0726C1FCF9;
	Thu,  4 Jul 2024 04:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/rRNjZ7G0L51JRh0RrYbiNiKS2AE7CnLW4VygCa50U=;
	b=JZiVO/egdO1NVZ9h89++ifx1zQVaAaRFVXTNxdvP7+Eqp6m0SFCnQDqtDBNPLeRwhOr/3k
	RIAR/120aKOEkaNyNgfpVNaziAWXWsQJTL2b+KTKfAdROuN3yyhKk9oEtfYU7aWFSE8j9d
	IVYd41OVz8gn1ZHBdLdnAJCiolhzEpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/rRNjZ7G0L51JRh0RrYbiNiKS2AE7CnLW4VygCa50U=;
	b=yNbA1i/f3g+Uk1+/g4XzzNXwTBw31YbefcoyfvVe9XSdiq9mU3Rgm3u5T2CICi+Xi0VqWq
	O+llDAuqdN+YiJDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/rRNjZ7G0L51JRh0RrYbiNiKS2AE7CnLW4VygCa50U=;
	b=JZiVO/egdO1NVZ9h89++ifx1zQVaAaRFVXTNxdvP7+Eqp6m0SFCnQDqtDBNPLeRwhOr/3k
	RIAR/120aKOEkaNyNgfpVNaziAWXWsQJTL2b+KTKfAdROuN3yyhKk9oEtfYU7aWFSE8j9d
	IVYd41OVz8gn1ZHBdLdnAJCiolhzEpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/rRNjZ7G0L51JRh0RrYbiNiKS2AE7CnLW4VygCa50U=;
	b=yNbA1i/f3g+Uk1+/g4XzzNXwTBw31YbefcoyfvVe9XSdiq9mU3Rgm3u5T2CICi+Xi0VqWq
	O+llDAuqdN+YiJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE2E513A82;
	Thu,  4 Jul 2024 04:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPQSMrslhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:55 +0000
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
Subject: [PATCH 06/45] mm/pagewalk: Do not try to split non-thp pud or pmd leafs
Date: Thu,  4 Jul 2024 06:30:53 +0200
Message-ID: <20240704043132.28501-7-osalvador@suse.de>
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

Hugetlb pages will be handled in the generic path, so do not try to split
pud or pmd leafs if they are not thp.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/pagewalk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a9c36f9e9820..78d45f1450aa 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -119,7 +119,8 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		 * Check this here so we only break down trans_huge
 		 * pages when we _need_ to
 		 */
-		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
+		if (((!walk->vma || is_vm_hugetlb_page(walk->vma)) &&
+		    (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
 		    walk->action == ACTION_CONTINUE ||
 		    !(ops->pte_entry))
 			continue;
@@ -169,7 +170,8 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (walk->action == ACTION_AGAIN)
 			goto again;
 
-		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
+		if (((!walk->vma || is_vm_hugetlb_page(walk->vma)) &&
+		    (pud_leaf(*pud) || !pud_present(*pud))) ||
 		    walk->action == ACTION_CONTINUE ||
 		    !(ops->pmd_entry || ops->pte_entry))
 			continue;
-- 
2.26.2


