Return-Path: <linux-kernel+bounces-381858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A699C9B058A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A95A28424D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7485206505;
	Fri, 25 Oct 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uIj8TvxQ"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9521FB89B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865855; cv=none; b=kZZbZMZ1XKGfgbTSSbOgNLabfR/n1W4g4N9a7hVfe0PKd2zde3/s8XkPadFtYO0A1/eOd7Xq2kZm78EJT6XTyEVFqWvTH8mru4ztczMgInSUreI6kwa87iUC0LPbRFv2imaPmRU5wNphevbIaSM6/HPu7REbfjOqt7pqeRdsGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865855; c=relaxed/simple;
	bh=TWudHctEQ5knuTlK6Wu7BZNOHdMM0HIGFJ1bh884wfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7GagY5iGsqni37q5tLjGP0SljjH9ylggESsrlg0d8Ufw17cNaeMbM8Rl68LeqNaYxiC3BL6gckcs47H3+8IVf9b7mJzo+vsiKeNl4vk2TCgg/2Qw5RiHnaaqgwnO8tq/6vkcNvYf+NAi6b2Mx3SDvtbiiot+t5ISOFe7/SK7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uIj8TvxQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b152a23e9aso145637185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729865850; x=1730470650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFJ7qeo3WN9Qtar7fFSc4KOFTyi0KFll6s9kH9IhHuM=;
        b=uIj8TvxQYayP18CDbfRyXOSKZfMs8hQxXJlF4455h1oIMwFyRb2i714pzI0VvLjOsx
         wLEb2mxz+bKVnLNCC8sevj+ED47+JD5BM5s1KF6T2lbkKkY2nfGvX6+zCX2C3tdgvo5m
         pzTKfiYGKFQWnsm18cKBow1an6LSDC+WioennO2/5bsy3s6xEtQm8zP2/6vXtRi5FiRX
         CFuJ5IftYtCbBjNYpLRovBWP0Nt3q+/VBnAl0ZoHuDYNk9L8B57nIgxYt7jvdlqcE9wx
         RphZrY55v3g2fGRyd+X1y7a/ISC5Z6XH+I66d9lLz2rf2ye8iBDy0m5QAohtg3UVyRQ+
         SacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729865850; x=1730470650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFJ7qeo3WN9Qtar7fFSc4KOFTyi0KFll6s9kH9IhHuM=;
        b=qIbtjycmmrPvabcACmIZGNgIKUz0r+wGNAQTywiZ3zkcUZYwmq615tYCI6pptBkBQN
         mdlnJPL6UCv6l3NI3auSfg8yldmlVTvz6EbhxlptRvdC4ep/kwNBEazvOhnFuyXhBans
         4q1U1Z1HKszIa1sfAxKM5WP9hE7t6yLc1DFuegDI0nQKu+vqDyqowyf+QeHel3JD1vLk
         JnrS50qGgYQ6RkSRR1quR1IpdqF+MYyBevFA2tnTmCIWjIiq5rS5QA71l9vstdVFsfrB
         8pb50fk+sc3Y6W9YJjY+DZvdH3gbGbLcS1NCJTnwxl04DEOZrETP1KfYruZk4U5gRall
         SZQA==
X-Gm-Message-State: AOJu0YzgobRpChkK34+bj1ymtYHCWUENHS0/p0tJbykY14L+79O9zDrN
	kLpDq4uVBvb894+7Dm+aCh9le5HaEbNuQiKIZUpHawsi7ZhAEiKzeri1lJMsLeHKddEyAJ9D2KP
	t
X-Google-Smtp-Source: AGHT+IE7mLrQ4PS1T6eK7H6zyqpO+N3XayG6pjPmJzubg5i3rO0Sb5RLmu37pfnSWox+jGrQ8fS7Pg==
X-Received: by 2002:a05:6214:5bc4:b0:6ce:12da:1dfc with SMTP id 6a1803df08f44-6d08d6dbc20mr74253646d6.4.1729865848617;
        Fri, 25 Oct 2024 07:17:28 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179753621sm6115576d6.22.2024.10.25.07.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:17:28 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel-team@meta.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	weixugc@google.com,
	dave.hansen@linux.intel.com,
	osalvador@suse.de,
	shy828301@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] vmscan,migrate: fix double-decrement on node stats when demoting pages
Date: Fri, 25 Oct 2024 10:17:24 -0400
Message-ID: <20241025141724.17927-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When numa balancing is enabled with demotion, vmscan will call
migrate_pages when shrinking LRUs.  Successful demotions will
cause node vmstat numbers to double-decrement, leading to an
imbalanced page count.  The result is dmesg output like such:

$ cat /proc/sys/vm/stat_refresh

[77383.088417] vmstat_refresh: nr_isolated_anon -103212
[77383.088417] vmstat_refresh: nr_isolated_file -899642

This negative value may impact compaction and reclaim throttling.

The double-decrement occurs in the migrate_pages path:

caller to shrink_folio_list decrements the count
  shrink_folio_list
    demote_folio_list
      migrate_pages
        migrate_pages_batch
          migrate_folio_move
            migrate_folio_done
              mod_node_page_state(-ve) <- second decrement

This path happens for SUCCESSFUL migrations, not failures. Typically
callers to migrate_pages are required to handle putback/accounting for
failures, but this is already handled in the shrink code.

When accounting for migrations, instead do not decrement the count
when the migration reason is MR_DEMOTION. As of v6.11, this demotion
logic is the only source of MR_DEMOTION.

Signed-off-by: Gregory Price <gourry@gourry.net>
Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
Cc: stable@vger.kernel.org
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 923ea80ba744..e3aac274cf16 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
 	 * not accounted to NR_ISOLATED_*. They can be recognized
 	 * as __folio_test_movable
 	 */
-	if (likely(!__folio_test_movable(src)))
+	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
-- 
2.43.0


