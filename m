Return-Path: <linux-kernel+bounces-240532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57B926E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E358B261AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9851494AC;
	Thu,  4 Jul 2024 04:32:45 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F4148FFB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067565; cv=none; b=T5PpIrwF1Q4ku9zmZOcwb/1huwjYsDoNuw2K6YHCLK8k62pK4Ev+WYpXiV/Z3GDuwG1OIT3ZWvRtUKCysBjP6vSN848sRL0TlSfpgx3hE2VvgEdRjSZ/gOk6X7F5PeIPU/wtPJ41lh9nrnH0QXQR+8kLGUUT6MGVUZXMmWAofCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067565; c=relaxed/simple;
	bh=9GYDzTTbrab85piNyP7RffzjbFiX+hGhrD3+y5lm5SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzq7mfg9VUOXfKXSMCAOQM5B3lXws4TV3B6WSR+QdwNKAwRxoZ1G5HzKK55lIug5pSxZ1QgHPUrmOCnfECrJubuM73e5DBE+tRos/zJk6Yqib0Tk9DiuqoORIIyExuOQRl2oOSV4pZIAIVER2QEvwZ9uGDjosHPbM633u93Uino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27A961FCF8;
	Thu,  4 Jul 2024 04:32:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0274313889;
	Thu,  4 Jul 2024 04:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAXCNuglhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:40 +0000
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
Subject: [PATCH 41/45] mm/migrate_device: Make migrate_vma_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:28 +0200
Message-ID: <20240704043132.28501-42-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 27A961FCF8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Skip hugetlb vmas as we are not interested in those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/migrate_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa..c44ac45b207d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -279,8 +279,20 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	return 0;
 }
 
+static int migrate_vma_test_walk(unsigned long start, unsigned long end,
+				 struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
+	return 0;
+}
+
 static const struct mm_walk_ops migrate_vma_walk_ops = {
 	.pmd_entry		= migrate_vma_collect_pmd,
+	.test_walk		= migrate_vma_test_walk,
 	.pte_hole		= migrate_vma_collect_hole,
 	.walk_lock		= PGWALK_RDLOCK,
 };
-- 
2.26.2


