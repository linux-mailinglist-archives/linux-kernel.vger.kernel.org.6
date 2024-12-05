Return-Path: <linux-kernel+bounces-432552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B459E4CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B7D18818E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1041917FB;
	Thu,  5 Dec 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G2etOVnW"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D992391A6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370846; cv=none; b=Wmf4O3K67Oh72UPd3t/lPF470TuHRuo5lJTYlnhpt9cPhyLwlMmvkeYtOiJ3wf45+zV3ENK53+DgQhumlV8DH7VkxtfF0yBCQWhgiHV0UbTFAVqv9OXDERILj/SOMCz2gKbB9QRC+Onk/BAU/JA/IwllY/iMEjiBN6KbHDoqxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370846; c=relaxed/simple;
	bh=63vk3LYhYIw6ZF7UKMUpyXqV9jqbhGy8BoaBSVHGW+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OWK7kOGJF1olPt8HkaFHkOK/Oi/Fwv0DHJC6CWYftFKbrQie6dyDOpO/UkLDIr5li5cf+vmkeq3qsChtoKtSi+rVsEuKtYsnz3gvb7SA+3pTtikTK7YC2M9gBwVMeHGA1WoSve+h06tw2zQNGwKdcyvIEfYQkmT7O4vLaLc7Whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G2etOVnW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733370841; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DI5axKZxvqy0r34ohLbYqCMjGG76VnNbtUIB821Ba+A=;
	b=G2etOVnWQYDq7HqEEyuS0xlbDuD1eNGKXEOlxB49XdA1JGK6rKmi6VLdvkuQPcq0BqN6mZwshuYjgNxh0t+ktX+9ttWR/Heao8xFwonQKUaBfqNGeXjWptgLozwxPW5jp/lLXIdFuD6fMT15ZArsJjX2QO7ifj8SCJcfWOt9InI=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKrhZ-H_1733370840 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 11:54:01 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	david@redhat.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: drop redundant anonymous statistics for file folios migration
Date: Thu,  5 Dec 2024 11:53:48 +0800
Message-Id: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5d65c8d758f2 ("mm: count the number of anonymous THPs per size") adds
a new anonymous counter per THP size, however, when folio_mapping() is not NULL
during folio migration, it means this is not an anonymous folio, so remove the
redundant anonymous statistics in this case.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e9e00d1d1d19..d7fdfdd23fd0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -523,8 +523,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
-	if (folio_test_anon(folio) && folio_test_large(folio))
-		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
 	if (folio_test_swapbacked(folio)) {
 		__folio_set_swapbacked(newfolio);
-- 
2.39.3


