Return-Path: <linux-kernel+bounces-516907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F9A37984
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD8A3A84D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41979D2;
	Mon, 17 Feb 2025 01:52:58 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A9149E0E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757178; cv=none; b=SJdEHa6O/K02AMj999uhJjF+3NblaKz0mAMblq/UrK51jTgGfQN9iEZHq+faZGmOUtntEPQUTCYvTcSHozV4m6DA4a8QIxARH8O+rkAcjGxV3jxSLvAKnCFJ6U7HHn1HeIDtzYaVIJUe54S1KLk/6KbzlHcS8Z+nBhoLvosCC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757178; c=relaxed/simple;
	bh=55j4AyKcBlIfibNkpZp6wLj+HjsQPiJItBPhenO1yQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtnhT1+SRTfXTZPS2TI933aHm9A9zFZ8D9n8xhg/kYnKaDgxUoz8YTrFF0SXCvzvcchj9pXgMqm+UjAqqSKa9iRBeC8bGVfPn55t7y7o5/Z46ZPCVq3ASn4q8k9iQz7TwFr3Nu+u3N2POljV9eKXdnTPa2N+x5dB+LsjMRUymK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yx5Gw4VCWz11P4t;
	Mon, 17 Feb 2025 09:51:20 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id AE0F8140155;
	Mon, 17 Feb 2025 09:52:48 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemg100017.china.huawei.com
 (7.202.181.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 09:52:47 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <mhocko@suse.com>
CC: <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] mm: memory-hotplug: check folio ref count first in do_migrate_range
Date: Mon, 17 Feb 2025 09:43:28 +0800
Message-ID: <20250217014329.3610326-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217014329.3610326-1-mawupeng1@huawei.com>
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100017.china.huawei.com (7.202.181.58)

From: Ma Wupeng <mawupeng1@huawei.com>

If a folio has an increased reference count, folio_try_get() will acquire
it, perform necessary operations, and then release it. In the case of a
poisoned folio without an elevated reference count (which is unlikely for
memory-failure), folio_try_get() will simply bypass it.

Therefore, relocate the folio_try_get() function, responsible for checking
and acquiring this reference count at first.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/memory_hotplug.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3de661e57e92..3669b3e2d962 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1795,12 +1795,12 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (folio_test_large(folio))
 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
 
-		/*
-		 * HWPoison pages have elevated reference counts so the migration would
-		 * fail on them. It also doesn't make any sense to migrate them in the
-		 * first place. Still try to unmap such a page in case it is still mapped
-		 * (keep the unmap as the catch all safety net).
-		 */
+		if (!folio_try_get(folio))
+			continue;
+
+		if (unlikely(page_folio(page) != folio))
+			goto put_folio;
+
 		if (folio_test_hwpoison(folio) ||
 		    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
 			if (WARN_ON(folio_test_lru(folio)))
@@ -1808,14 +1808,8 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			if (folio_mapped(folio))
 				unmap_poisoned_folio(folio, pfn, false);
 
-			continue;
-		}
-
-		if (!folio_try_get(folio))
-			continue;
-
-		if (unlikely(page_folio(page) != folio))
 			goto put_folio;
+		}
 
 		if (!isolate_folio_to_list(folio, &source)) {
 			if (__ratelimit(&migrate_rs)) {
-- 
2.43.0


