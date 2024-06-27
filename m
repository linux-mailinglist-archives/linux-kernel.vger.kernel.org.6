Return-Path: <linux-kernel+bounces-233053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1891B19A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4343DB22E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C641A2557;
	Thu, 27 Jun 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q6qzWSJR"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAD249F9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524198; cv=none; b=CJ05BfGOnm1X9AKwih6MMYG39dLkidYeDHGzrwOku5W04xibJFFCk1S4wfjeSzcfXOD4Mr861ItuHKJ2Ch4Bn1l+arp8Da0ofeISl0v0suF20F+YntXbWnNCUE2MyGLV3PGvYmET3x/Lhrj0cq3+Mh6PFkUp1lcYA3y/MahJC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524198; c=relaxed/simple;
	bh=6psedXWiVhgGXMWXvYNxOstdCMvuxEuuwfA7iWcmcGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe6wd6qz6nz/9M7b5I9aGm/ndGw1clItRxH1/d9zGmGRC2O5nhISBroViJBm0WU6/68knh+Ywq4n+hdNBr3wgAaTt2l/rOyzT1DvYtJFxqQCs492KZJ5VIAriTN911b2x4UaGoEEI3QEkc5QqAsqd5ngiAJDgL04Vs7deYAa8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q6qzWSJR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-648b16e5e47so20226147b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1719524195; x=1720128995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPQjFOQJrmmumJb1CUQeupQXr/aSCBOnaBJ4NRUg9Dk=;
        b=Q6qzWSJRSwfycBa32Af/82mcnzbvZg+2T570aJTpYnEM+yrJY/1+sUZAgzU2AGnR2e
         9j4E367Kjpm288sjJW/L1wWce7z8Ka/4qmW6h16a49Cd9nAvZ3jF6b8wK9+ep91BjQm7
         6HBhUaZ8ubpSY9IVu2xaoiu1gwvXJRQS6y6Mup2x97NTRasHq0iS3GkLVxwOB44aZ/vm
         XiAnL4I8GFsBrjVtjK1XCcQY8fXY6pfOJ6drAnXXzOXmiyFnTIy4ExkvILky0wKEBLQo
         Yc1upd7rXQNSYLx5R1MkCAxU3mHQh+L/oorgcNG27wcvBb4Joxmd7mhs/Tfjw7YJxa7v
         s3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719524195; x=1720128995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPQjFOQJrmmumJb1CUQeupQXr/aSCBOnaBJ4NRUg9Dk=;
        b=FPhjgTxnT0GSFYdq9l/DUPySI4lrPlMfeJM9okqimjFJczQW+Wgdx5jYL10tmCdI46
         D+QPsUEej9RLQFAaDiRhkRDQvGgRKkwODRHYUbFRsk8l+WGPU7FJdJ9rg29bwZItmek7
         phIv61Ugf4k65O1pLDqxM5ePtN6vlBe+vFsfksa0RCGs3NUr+1diyRrZHFx///bGdj42
         kMa8fM/pT8kik2PGFtEFmbtThstMEc20jKBc4oNsKqnMd+WJMitble4geoX1vsGM8V7Z
         cxOhMPAjk2oEdT2juTlzIU8rHvqF/Yjml8bGs89tWPDqW+TU/s4iKZYq/mAD7lDVdlke
         b5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjfuJatvvhmH+0RE5zW9raLLNc6O7Pddw+WroPxTHHHmdWPv4MvqToy96HhzLNj4S2BTW3kY41XvnPtXr/SqJ4+Xl0huh2drfG9JuA
X-Gm-Message-State: AOJu0Yz2F4/bru9eDN80PXJGDTB2szGwY4KGnpIBIn+TNb0bN5uEd8Ao
	ogSOR9SM3fsqRdwMNJ0UNbiZcmL9pBupLwbeYTNAM/PfwmQvFREnJUOi3xSqg70=
X-Google-Smtp-Source: AGHT+IFHmTkHBvgSC5eiv2wrJhRLko87Wrv6Oi9W77kxorbvatmvGPjjNZmZ7JeLAJnsUivsaJqVQA==
X-Received: by 2002:a81:5b8a:0:b0:630:8fe1:b626 with SMTP id 00721157ae682-64341d1aaf1mr143077457b3.48.1719524195466;
        Thu, 27 Jun 2024 14:36:35 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-64a99c717c0sm1009467b3.2.2024.06.27.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:36:35 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] debug patch for perf report segfault
Date: Thu, 27 Jun 2024 15:36:19 -0600
Message-ID: <20240627213619.718-3-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627213619.718-1-cachen@purestorage.com>
References: <20240627213619.718-1-cachen@purestorage.com>
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


