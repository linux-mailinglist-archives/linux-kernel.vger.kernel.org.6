Return-Path: <linux-kernel+bounces-240521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C078D926E74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1CD1F22532
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F3146581;
	Thu,  4 Jul 2024 04:32:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5516145FE4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067551; cv=none; b=HgUdtnSxelfWlEkrOADXzzkgpPaxgx+kDa4GYY7i3Nacg+SEwn2FDladquXvfJG2Lqqv7oziXi2eNoI9yiN61gOWyms6SrNJeDomM7F02l9ypmAk49Io+OwgeypyUSmkbhbzxPniZ0e9y6xg1q7XSQVTx5VyYAj9ddTxozYBiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067551; c=relaxed/simple;
	bh=8hDZyNTIFcoLrIplaNZzSjI6izOqLgxUhvo8Qa79pnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh2LUTjMk7dwmdJLGV2huW5diwa2V4e20jKL49caSzEF7PRrN/RYJ+ywhNIF6tW0dvgAMhh/XrmlTLrWAJ3Od8qS43vpglxnOOHAj8KMVHSFBrJLp2EzMygVCdMSksYG7ofGcmahC7WNF+1IiA15oR3zduQBKILQG32inHAub5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FE1121C11;
	Thu,  4 Jul 2024 04:32:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDC9613889;
	Thu,  4 Jul 2024 04:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qGv2MdolhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:26 +0000
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
Subject: [PATCH 30/45] mm,mincore: Enable mincore_pte_range to handle hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:17 +0200
Message-ID: <20240704043132.28501-31-osalvador@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 0FE1121C11
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

PMD-mapped hugetlb vmas will also mincore_pte_range.
Add the required code so it knows how to handle those there.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mincore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index d6bd19e520fc..5154bc705f60 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -18,6 +18,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/mm_inline.h>
 
 #include <linux/uaccess.h>
 #include "swap.h"
@@ -106,8 +107,9 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
 
-	ptl = pmd_trans_huge_lock(pmd, vma);
+	ptl = pmd_huge_lock(pmd, vma);
 	if (ptl) {
+		/* Better handling of hugetlb is required (pte marker etc.) */
 		memset(vec, 1, nr);
 		spin_unlock(ptl);
 		goto out;
-- 
2.26.2


