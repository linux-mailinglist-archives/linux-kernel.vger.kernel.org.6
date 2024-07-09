Return-Path: <linux-kernel+bounces-244986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E392AC89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B388A1C225F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF48153837;
	Mon,  8 Jul 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J7fz5MBP"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8C152798
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481004; cv=none; b=hUeDOH8M1Lg97tWVOMTNelhmYaFuyH5poMr8S4Cl5MnLrGtLaG/tpOegMhuRsACswUIfyUdOt6RARBGHOrElo3kOBnCsZrCwXTc0z8VQlde0jWqu1evWnk++K6pmqeY0GhcPY1RH9Xzqly+yzIQPMLQ9V1cVcujLPNmhNhYnBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481004; c=relaxed/simple;
	bh=6psedXWiVhgGXMWXvYNxOstdCMvuxEuuwfA7iWcmcGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAK60qiORE1m98zDr/7ZE1y9UpWd2/UPXmZ/Yn0kaud02sAGndBkCSospSbPpB8mFexvHUj6iHG5o8u3deiNwtGCaWJ7VMh1D3C7UqfXCRKQO8M6CNdxactEJyvXDQUGbu4Uuz30LKznwHRmTzj9dkjrgy8F60b0ocSbjyVmjPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J7fz5MBP; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c669a0b5d1so1390781eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1720481002; x=1721085802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPQjFOQJrmmumJb1CUQeupQXr/aSCBOnaBJ4NRUg9Dk=;
        b=J7fz5MBPnO7ZcRAM1NEBK6HhCyqgLuxeeR7JFnPDgN0OT786Ey2UmZztDThJ8+7xac
         G0hOt/ezroK3iASmFcIqkXLxKqWUlT+3zePAzfq+1AalgBgWQevISLNC6v5SixHWnaZj
         q93g9mgVht9kZ8oKP3IUt9b3p0j7eAWxZblRsOysCEhG2F8NI+QezNw4FFf9jFT2N+Ak
         rPyqs7UDXYwbKhTj3OiIwyr4qTC2E1yrh8mroiIyw202hk0J3FKfcuKIYVjDNnwLg4EG
         aXmpcIhzZI04j2xQFsln2mjjEWZXC20kcXyFkNgmv/F7Q5XDkGk8rd+/20zKFu7l3CCi
         H6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720481002; x=1721085802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPQjFOQJrmmumJb1CUQeupQXr/aSCBOnaBJ4NRUg9Dk=;
        b=oBFj3izZULnnA29XbEP5qeeTaW5/j1Joq8htBN9KQNnMF5bGCMxM+5+Y82a2geJout
         8ngVHlge+aqFv2f3NV0GvOYSQIHHpZUvS8aG2Op+m3jc27PwaKRfJ9/Q5elbJ6ZmKFyI
         Kl7Ygreo+1o6Hlf8d+4yE+M/xE/zlPY6mYpd2EpwwUOjjmfQKIib4CZkA6jBWM1jhn/A
         ZosFTSz0PpPyzbxKHB7f8J9ubsdZ7CIyotzaIjabFDfsXFagXZnJAfCUZ28UUp5DAy6Y
         hVakXtASNDiTa1Cq5WQY4pcNP24dqf37x87U1ABUpqCYqfivuI1xvLs6STZySLNhBL6Y
         QcSg==
X-Forwarded-Encrypted: i=1; AJvYcCXnSRytTK/kFAbRZvEuH362JiXYu13QAxWZLSTnU0+51yJb672zdvPqRMsitR1FTU/qAOrPYJWCHmuqL/Ddt6DP2dOsKvOHnnCzibAL
X-Gm-Message-State: AOJu0YzWY92AjP+N/xzNXoAt1m5XRP7FVR9q0cXok6GJ3QMrPxz29SVY
	xSbsIGNOVIDC3k68v4mnT0TytvqbZJbyrSiaGuaOiMVkuw2KutgR9ozz8HjGJhA=
X-Google-Smtp-Source: AGHT+IHgvnicgkruRjYUzVyfO9REfGDXS1M/onpZY0ms8UA43OsIKnZ+wnQ7WF0Kfvrq6b8u0H6N7A==
X-Received: by 2002:a05:6871:24e0:b0:25e:56a:9665 with SMTP id 586e51a60fabf-25eaebc6866mr612181fac.43.1720481001985;
        Mon, 08 Jul 2024 16:23:21 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b438bfa86sm437775b3a.47.2024.07.08.16.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:23:21 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] debug patch for perf report segfault
Date: Mon,  8 Jul 2024 17:23:02 -0600
Message-ID: <20240708232302.15267-3-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708232302.15267-1-cachen@purestorage.com>
References: <20240708232302.15267-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debug patch to apply on 0dd5041c9a0e ("perf addr_location: Add
init/exit/copy functions")

---
 tools/perf/util/callchain.c | 4 ++++
 tools/perf/util/callchain.h | 9 +++++++++
 tools/perf/util/machine.c   | 8 ++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index b0dafc758173..2c1d9b8ff8d9 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1067,6 +1067,10 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	node->ip = ip;
 	map__zput(node->ms.map);
 	node->ms = *ms;
+    if (ms && !ms->maps) {
+        pr_info("%s addr of node->ms %p ms %p has no maps map %p symbol %p\n",
+                __func__, &node->ms, ms, ms->map, ms->sym);
+    }
 	node->ms.map = map__get(node->ms.map);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index d95615daed73..8bba51be33a9 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include "map_symbol.h"
 #include "branch.h"
+#include "debug.h"
 
 struct addr_location;
 struct evsel;
@@ -213,6 +214,14 @@ static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
 {
 	cursor->curr = cursor->first;
 	cursor->pos = 0;
+    if (cursor->curr) {
+       struct callchain_cursor_node *curr = cursor->curr;
+       struct map_symbol *ms = &curr->ms;
+          if (ms && !ms->maps) {
+            pr_info("%s: cursor %p curr %p ms %p\n", __func__, cursor, curr, ms);
+            dump_stack();
+          }
+    }
 }
 
 /* Cursor reading iteration helpers */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9fcf357a4d53..e6c90bb6b842 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2357,6 +2357,10 @@ static int add_callchain_ip(struct thread *thread,
 			goto out;
 		}
 		thread__find_symbol(thread, *cpumode, ip, &al);
+        if (!al.maps) {
+            pr_info("%s: i'm here! al.map %p al.sym %p ip >= PERF_CONTEXT_MAX: %d cpumode %d ip 0x%lx\n",
+                    __func__, al.map, al.sym, ip >= PERF_CONTEXT_MAX, *cpumode, ip);
+        }
 	}
 
 	if (al.sym != NULL) {
@@ -2384,8 +2388,8 @@ static int add_callchain_ip(struct thread *thread,
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
 
-	if (!branch && append_inlines(cursor, &ms, ip) == 0)
-		goto out;
+//	if (!branch && append_inlines(cursor, &ms, ip) == 0)
+//		goto out;
 
 	srcline = callchain_srcline(&ms, al.addr);
 	err = callchain_cursor_append(cursor, ip, &ms,
-- 
2.34.1


