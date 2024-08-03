Return-Path: <linux-kernel+bounces-273328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3E946785
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 07:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14471F2188D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7113A13D8B2;
	Sat,  3 Aug 2024 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUjotTFQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C142A82
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 05:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722663191; cv=none; b=p8/rMytaKPWROpwJbKUYhsosTo0dFWRmRWS8FsFA7w9NBP61P2dlbBo6ydtLCenLoT5xdNnF5fctbj0Gxb8cGcgaqjDLllSBDUgIHrdyuTGYk9hIeECjYcLZW28jOyFAzfkJxSgcRQ/gRY5PA6ykARgSiLcx3EJDbEZtXYyhKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722663191; c=relaxed/simple;
	bh=hvUd3OORrhy9zSUxl2DS9XEmSs8zWXzIOk8rRpBAdt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aZ/dOCT+zrUlCYvnGxZZ3nc3uGLnKMGAkYeCdsAkdaXBIM+RPI5YWjuhh5lIIU6tRBrJ8M3HrEMsMQ1OVXANI2AqZPhxYukEq5wapmDxV6knwAexdXaKjkZfXxmDXZe9BHMBHsWmtJJwVZKjYBfMbudmWWu0Thwnqi+KVPVYkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUjotTFQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be470f76bso3065375276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722663189; x=1723267989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dVMABDG6zvtzBrluDCQkwCGip5NCjvJGZc7ooD15Ipc=;
        b=vUjotTFQmXdoFgNjtnrNUgk/90RdJc06r0urhzJpvkRpzleVcQp3lY53gHiLXBa55l
         FX1NdEiTB5979B1VQad7H2gL2j7A3duhmaCH1WfEbpH0n+cvBhKSD9gqJXR2ecHIoX2C
         3FLgVCnWy+PGrjy2gV2/WbhBr0WKq1k53z1jU+DaaAJKbnU8wtXPPGNJJ5mY7W6TeHSa
         zJeH8WUPKvOXWWOcIO8847cVxS7SNPNgRgSY0RiGSDshb90QYnTMF3idmlpfrrRw3MXv
         fE7Enm0UiUPA4zArNghcsuWPN+EZF0O/9AUkBHDVhzbclNRVMMBVmjV+QaXaZbkmYKxn
         +HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722663189; x=1723267989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVMABDG6zvtzBrluDCQkwCGip5NCjvJGZc7ooD15Ipc=;
        b=eDGIX4PaPBhr4IqHHKWOamZyEGNKCt+pvp+Kkg6pCrYUk4H7MVbxdb3xHnrTrciEOX
         XTUwf0BOYDAWZf3gkGiK7NYpTFneMGCFledKEB9KxaI2DDGEaQBBKQCu6JvK5udfweDE
         YfHX/lCaAUHmsMJBVWfgzkIo68Jcdk8m3oAuEfYWxNES+IwSMvq9YkPpCOPZ5uiRrHdb
         Lad55ar8/3VVtweFb8Z7QGBeC9o3XDgKFHQ05Zq83XKvgGnxhr5BMFYOQhbW5yz5geDc
         T1p7frGnMP1/t8QlPgrCbnfDcc52CCDtRTIE1eoC/an6lpIaTIdP6OUoqUPnj3NQOPoq
         ZW+w==
X-Forwarded-Encrypted: i=1; AJvYcCWXohrM0ONBBL24/XZtWws8fLHKmj5takKhiW+1BWdszYsmVGVG427JriMamk4OWJYlzhQhlEKRcHJ64o7RquIzKHc6sHtoO3kOWgZm
X-Gm-Message-State: AOJu0Yx0IlFkwUKmtJZmsCKqvjeAoszGyYlda+WQ/xIfIK4ePSvsFsgI
	aSrFxmmgqs2okxZ4YlXNhzBpHfjstYMhHQzop2Ow4a9zv6kv5h6OkuqHhyay33jZqlYdQSDiSI3
	Atbw7JWmR78cN9MCRxQ==
X-Google-Smtp-Source: AGHT+IGiZEPPAQNY2/nwbwVwRsUGjO4TgUlfihhyR0VvwxRkt7mU9aLbAmPrEM8xOeTxVidxnOufplpnPgFzgwEo
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2313:b0:e05:65b7:32d9 with
 SMTP id 3f1490d57ef6-e0bde22af67mr16846276.6.1722663189151; Fri, 02 Aug 2024
 22:33:09 -0700 (PDT)
Date: Sat,  3 Aug 2024 05:33:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240803053306.2685541-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: make the lock critical section obvious in shrink_worker()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Takero Funaki <flintglass@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the comments and spin_{lock/unlock}() calls around in
shrink_worker() to make it obvious the lock is protecting the loop
updating zswap_next_shrink.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

This is intended to be squashed into "mm: zswap: fix global shrinker
memcg iteration".

---
 mm/zswap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index babf0abbcc765..df620eacd1d11 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1364,24 +1364,22 @@ static void shrink_worker(struct work_struct *w)
 	 * until the next run of shrink_worker().
 	 */
 	do {
-		spin_lock(&zswap_shrink_lock);
-
 		/*
 		 * Start shrinking from the next memcg after zswap_next_shrink.
 		 * When the offline cleaner has already advanced the cursor,
 		 * advancing the cursor here overlooks one memcg, but this
 		 * should be negligibly rare.
+		 *
+		 * If we get an online memcg, keep the extra reference in case
+		 * the original one obtained by mem_cgroup_iter() is dropped by
+		 * zswap_memcg_offline_cleanup() while we are shrinking the
+		 * memcg.
 		 */
+		spin_lock(&zswap_shrink_lock);
 		do {
 			memcg = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
 			zswap_next_shrink = memcg;
 		} while (memcg && !mem_cgroup_tryget_online(memcg));
-		/*
-		 * Note that if we got an online memcg, we will keep the extra
-		 * reference in case the original reference obtained by mem_cgroup_iter
-		 * is dropped by the zswap memcg offlining callback, ensuring that the
-		 * memcg is not killed when we are reclaiming.
-		 */
 		spin_unlock(&zswap_shrink_lock);
 
 		if (!memcg) {
-- 
2.46.0.rc2.264.g509ed76dc8-goog


