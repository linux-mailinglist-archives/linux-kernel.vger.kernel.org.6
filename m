Return-Path: <linux-kernel+bounces-240496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282A926E58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42C71C21E82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52055476B;
	Thu,  4 Jul 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h+c3YldW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="frfAxxwF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h+c3YldW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="frfAxxwF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5C45979
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067518; cv=none; b=InmsHhwaIObXJtDRBN4IDO45QJKRl2cQ1Pszs4xa5PD4jIKEVtqIergWybJ0ES+MgcghY4eRHjzCM4dgng2pI8VQDZ92q4W/R8CaZPIOCB+xA+kM1AfNu4QDVYM4IiK+QAZiAJY6tVsHc7ub2Je9QakSxePXpzZvGC4c/gwpDMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067518; c=relaxed/simple;
	bh=c/HemdA2aDxHy0Qr3edOwoMNWIqOMDdImC7HbbxLkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6XPWnz/ewjFFHKnjvXk3rYQBipMc5NousrhSiGISKUVf0H2qnIlTH18Fkhrm3vXwFbw1Gx70u2crLBD8CLz+H5FOG089TvVhKGX9OS+Kq7+wc47DHSWICmPun6kd52uUWi5W0TmohRzLRUar2iNF+ebEFG5oAJ7hLFZRkPNNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h+c3YldW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=frfAxxwF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h+c3YldW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=frfAxxwF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD80C1FCFB;
	Thu,  4 Jul 2024 04:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCzlv35dbgXloc5Cmstin2CCiJG29oVOef/hhtOkA+o=;
	b=h+c3YldWsDCWou0FH1uqAUtnGxvDkmkrw5MQS+eAbm6nc4xHjoC7SiMmO1KgT1ogxMucRW
	JsZAInX2H9tHjZJ29ry01mlBA/1iNay0rlLOoCB6DCVmON6lUqsmtsj4w0Z5P4bSRXrmdd
	E1ywbhdn4+EiM/LJbQhJoM39l9zXjNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCzlv35dbgXloc5Cmstin2CCiJG29oVOef/hhtOkA+o=;
	b=frfAxxwFBvqVUDaANiozJD91Zhfd1mCsF2hzZSdarkYr3nve6JYZaO/PFTJ73t684ex8JF
	l+vQvnp2Om9NkABQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCzlv35dbgXloc5Cmstin2CCiJG29oVOef/hhtOkA+o=;
	b=h+c3YldWsDCWou0FH1uqAUtnGxvDkmkrw5MQS+eAbm6nc4xHjoC7SiMmO1KgT1ogxMucRW
	JsZAInX2H9tHjZJ29ry01mlBA/1iNay0rlLOoCB6DCVmON6lUqsmtsj4w0Z5P4bSRXrmdd
	E1ywbhdn4+EiM/LJbQhJoM39l9zXjNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCzlv35dbgXloc5Cmstin2CCiJG29oVOef/hhtOkA+o=;
	b=frfAxxwFBvqVUDaANiozJD91Zhfd1mCsF2hzZSdarkYr3nve6JYZaO/PFTJ73t684ex8JF
	l+vQvnp2Om9NkABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7EBF13889;
	Thu,  4 Jul 2024 04:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eHJfJLolhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:31:54 +0000
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
Subject: [PATCH 05/45] mm/pagewalk: Enable walk_pmd_range to handle cont-pmds
Date: Thu,  4 Jul 2024 06:30:52 +0200
Message-ID: <20240704043132.28501-6-osalvador@suse.de>
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

HugeTLB pages can be cont-pmd mapped, so teach walk_pmd_range to
handle those.
This will save us some cycles as we do it in one-shot instead of
calling in multiple times.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/pgtable.h | 12 ++++++++++++
 mm/pagewalk.c           | 12 +++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..3a7b8751747e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1914,6 +1914,18 @@ typedef unsigned int pgtbl_mod_mask;
 #define __pte_leaf_size(x,y) pte_leaf_size(y)
 #endif
 
+#ifndef pmd_cont
+#define pmd_cont(x) false
+#endif
+
+#ifndef CONT_PMD_SIZE
+#define CONT_PMD_SIZE 0
+#endif
+
+#ifndef CONT_PMDS
+#define CONT_PMDS 0
+#endif
+
 /*
  * We always define pmd_pfn for all archs as it's used in lots of generic
  * code.  Now it happens too for pud_pfn (and can happen for larger
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d93e77411482..a9c36f9e9820 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -81,11 +81,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 	int depth = real_depth(3);
+	int cont_pmds;
 
 	pmd = pmd_offset(pud, addr);
 	do {
 again:
-		next = pmd_addr_end(addr, end);
+		if (pmd_cont(*pmd)) {
+			cont_pmds = CONT_PMDS;
+			next = pmd_cont_addr_end(addr, end);
+		} else {
+			cont_pmds = 1;
+			next = pmd_addr_end(addr, end);
+		}
 		if (pmd_none(*pmd)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
@@ -126,8 +133,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
-
-	} while (pmd++, addr = next, addr != end);
+	} while (pmd += cont_pmds, addr = next, addr != end);
 
 	return err;
 }
-- 
2.26.2


