Return-Path: <linux-kernel+bounces-180740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E168C727A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A11A28194A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA866CDA8;
	Thu, 16 May 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jnRotsF7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uJQEbuzb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jnRotsF7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uJQEbuzb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40064120A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847047; cv=none; b=I1zzKeJelEH5gqq8D2K2eANJeQ5DtaKgMQWiQ/YhE4AGUs7VlwebGh7AW3znSJhGnj/D9KVWdWF6QhFQnQZMoquXD4oDQETVx0T57LwfN8Mr9NbE5vJE6+HfFsiX0vV0b9LhQ7hBtvyd9RDPDkruuaZn5RZkTRC5yuHVe88+h7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847047; c=relaxed/simple;
	bh=aL3PMgpZy7u4IoqEWZD3hgUyZyAkQSWLrIALj1f132g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjRGL0u2uzjIf4tBWIYjNLcbOYOWtvvv8Lbu9Y+1zyqWhiFTq6aEMz9Zrp0VtrMxBohdZT3GZA1l9Qr/E4f12nnKR4M73o4VR1z0MRCvJObPXwa6LXKAKAJCrxonhlZHTawnkS1vt9S6VQgpP0GuW9pbI1GxYrq8ggYBVuFnnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jnRotsF7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uJQEbuzb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jnRotsF7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uJQEbuzb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0339C5BF55;
	Thu, 16 May 2024 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715847042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6pmMTvznEz1A8KucpTcWmbU5/R4qRpSkytrpW1qlvtE=;
	b=jnRotsF7ozXVpzDT4qkWxo6jXbN2ughSK+YPIx22668HKl1IuC9J8j819qfLS6jiiQHEZa
	Yf8AUnkmXA5wTeb6O2jnbIYfgIAJAtsTHxdr23E969iCERw9+/opYBQv38r29UHqhhZZKm
	PI+Ls8tJo+43qKxqAr2Y+qMg/IMuvDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715847042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6pmMTvznEz1A8KucpTcWmbU5/R4qRpSkytrpW1qlvtE=;
	b=uJQEbuzbZBwubalhOVJlXZulmnaCN61R03J+SXX3ZpxUMT8+Rt8eYJl51a5wu//rpNuSIN
	ni3ACD9XYoQ1SZBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715847042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6pmMTvznEz1A8KucpTcWmbU5/R4qRpSkytrpW1qlvtE=;
	b=jnRotsF7ozXVpzDT4qkWxo6jXbN2ughSK+YPIx22668HKl1IuC9J8j819qfLS6jiiQHEZa
	Yf8AUnkmXA5wTeb6O2jnbIYfgIAJAtsTHxdr23E969iCERw9+/opYBQv38r29UHqhhZZKm
	PI+Ls8tJo+43qKxqAr2Y+qMg/IMuvDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715847042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6pmMTvznEz1A8KucpTcWmbU5/R4qRpSkytrpW1qlvtE=;
	b=uJQEbuzbZBwubalhOVJlXZulmnaCN61R03J+SXX3ZpxUMT8+Rt8eYJl51a5wu//rpNuSIN
	ni3ACD9XYoQ1SZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83A4E13991;
	Thu, 16 May 2024 08:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r7djHYG/RWb0XgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 16 May 2024 08:10:41 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm/hugetlb: Drop node_alloc_noretry from alloc_fresh_hugetlb_folio
Date: Thu, 16 May 2024 10:10:35 +0200
Message-ID: <20240516081035.5651-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.40
X-Spam-Level: 
X-Spamd-Result: default: False [-2.40 / 50.00];
	BAYES_HAM(-2.60)[98.23%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]

Since commit d67e32f26713 ("hugetlb: restructure pool allocations"),
the parameter node_alloc_noretry from alloc_fresh_hugetlb_folio()
is not used, so drop it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..fedce00ff839 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2289,13 +2289,11 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
  * pages is zero.
  */
 static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+		gfp_t gfp_mask, int nid, nodemask_t *nmask)
 {
 	struct folio *folio;
 
-	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
-						node_alloc_noretry);
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
 	if (!folio)
 		return NULL;
 
@@ -2513,7 +2511,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
 	if (!folio)
 		return NULL;
 
@@ -2549,7 +2547,7 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
 	if (!folio)
 		return NULL;
 
@@ -3474,7 +3472,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY], NULL);
+					&node_states[N_MEMORY]);
 			if (!folio)
 				break;
 			free_huge_folio(folio); /* free it into the hugepage allocator */
-- 
2.45.0


