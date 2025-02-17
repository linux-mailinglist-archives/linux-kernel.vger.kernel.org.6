Return-Path: <linux-kernel+bounces-512008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00220A332A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C13A94FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564F205AC3;
	Wed, 12 Feb 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tX065EKa"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447920409E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399450; cv=none; b=IUAtYQeZ1qXj6ArIr3QwA9/KaVcXZVttHzJV75r2QDSiYV1lftaHYHXHyfs1I7DE98t/vyaFAR3GfkXA4WJlR98UBJ86N32QCi6Jt3S+v47+psn4tkzZrRqeSugYlCTDzvSndcit7Y8XeUXEMihKt/KWFwbBV9SoCbV2bD/RCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399450; c=relaxed/simple;
	bh=4JuFZc5w2LCt7uJHwRk3CddKeQ1pM4baFKxQ+C/RUgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XT9XgrxnpHFqIWpl9V7gDGHeZGqQRh89PQHQ0ol58DpcSR1yUVZVCpT9s7l0t5saKqIZGeXFqiXgmeND9iPQxskPh5EdMDsqmAWNGwNKZ4hFVd+pIraRrYdIGMoJgjKLG3W83A7mVSTzvfPqcVcJ5/rGjW3PMDG0EA2pxd4/Oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tX065EKa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f42c8f5f6so2550435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399448; x=1740004248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp6JXzWQDgJraueffuAM7pmy5niWB0JPsWhbLqxLJuY=;
        b=tX065EKaTv2mhh/296KU6+We68bngvpU4VoQcvg4TJpK+hcGk11cPQgmJYQyZXLEIB
         QP1l5MM75EiEaaGjOEHkdBKNu5ME92ZaHMR27CM2Us0bQGmTaRxpV8N/fsRzrKOYLHkj
         ww3e1f9ckxTHWtOgVJXn8bYz6qBuBDSGifRrR4otJ2rUR7zvsWzQn4bKTU8sKAq0bVGd
         1suxjupeIMoibl2EWX2BfFYDQdFlMAVoGdWbtzJI1rMUIgrv92xny91j7OzNyDhFeQLk
         MyVyvhroQRus3NlQBnuCVT2o2xEALOXWDrkrDIUI6Lxgi0IH8e8VYyTlMsT0j7HSbgkI
         DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399448; x=1740004248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp6JXzWQDgJraueffuAM7pmy5niWB0JPsWhbLqxLJuY=;
        b=at4mawQlFybv4bRRQ93OwxG4wKmuum8yVyHVABSaFcUcQOx97ncn0CHlc3uhIGm1ML
         FtXpLA5DbFg1RV02mX6hXrHzkwMZuMjiRA/HXsiMLpnj7lMd31phb3Cu/wj9RpZbdiS6
         NldBLCVRgwlJ9hkUd+mf1qBVMxj5IJWp0K0+f3pHgi+TgXH9wGnn43qNDfpwRMbwlOl6
         0s1TQmfLrysxDqje+4Pec6S0L5TJ8T6LPXleR4anF1WIkX7OTqwkhQMv/db13F/sZGGM
         4uGV9BXungEzC0z7/9WvyCXHXBEhHqmM5KUNtN9uFoFTOLVKDpCEV4X8gj/bDuMoOmaS
         +59A==
X-Gm-Message-State: AOJu0YzNGqvYj5Mpvr0SZ8gs/zxuTwnnuQ9EBUjpDDueA5Y01hgddfQq
	ntfADBEyAhXCfSzVDzy9Tx2dBda6hwBORNvRcAY0wVaup19zG2rQWV1d2nXUnDzGpWezC4x2NiT
	zOtpMXUcKkwP57V/r5YfhSgHre7zIKq+PgFtpB7V423z3+xufB9+6VKV5lGzsDkKmsTBBwI09/8
	HtGqAbCq+VRcWfTSa4TgMUM0Ef23+oTTgyHzX/ndz6
X-Google-Smtp-Source: AGHT+IEBBiJFCF3wEaVNJRVbpU0yixawbj3CSdHQuUgkpm5T1RSKHo6nSIBj+hC+a0gSgUgMG6dxyJIN0Pc=
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:2f8:4024:b59a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d549:b0:216:6901:d588
 with SMTP id d9443c01a7336-220d1ed1f92mr17422035ad.15.1739399447824; Wed, 12
 Feb 2025 14:30:47 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:54 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-4-ctshao@google.com>
Subject: [PATCH v5 3/5] perf lock: Make rb_tree helper functions generic
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rb_tree helper functions can be reused for parsing `owner_lock_stat`
into rb tree for sorting.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5d405cd8e696..9bebc186286f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -418,16 +418,13 @@ static void combine_lock_stats(struct lock_stat *st)
 	rb_insert_color(&st->rb, &sorted);
 }
 
-static void insert_to_result(struct lock_stat *st,
-			     int (*bigger)(struct lock_stat *, struct lock_stat *))
+static void insert_to(struct rb_root *rr, struct lock_stat *st,
+		      int (*bigger)(struct lock_stat *, struct lock_stat *))
 {
-	struct rb_node **rb = &result.rb_node;
+	struct rb_node **rb = &rr->rb_node;
 	struct rb_node *parent = NULL;
 	struct lock_stat *p;
 
-	if (combine_locks && st->combined)
-		return;
-
 	while (*rb) {
 		p = container_of(*rb, struct lock_stat, rb);
 		parent = *rb;
@@ -439,13 +436,21 @@ static void insert_to_result(struct lock_stat *st,
 	}
 
 	rb_link_node(&st->rb, parent, rb);
-	rb_insert_color(&st->rb, &result);
+	rb_insert_color(&st->rb, rr);
 }
 
-/* returns left most element of result, and erase it */
-static struct lock_stat *pop_from_result(void)
+static inline void insert_to_result(struct lock_stat *st,
+				    int (*bigger)(struct lock_stat *,
+						  struct lock_stat *))
+{
+	if (combine_locks && st->combined)
+		return;
+	insert_to(&result, st, bigger);
+}
+
+static inline struct lock_stat *pop_from(struct rb_root *rr)
 {
-	struct rb_node *node = result.rb_node;
+	struct rb_node *node = rr->rb_node;
 
 	if (!node)
 		return NULL;
@@ -453,8 +458,15 @@ static struct lock_stat *pop_from_result(void)
 	while (node->rb_left)
 		node = node->rb_left;
 
-	rb_erase(node, &result);
+	rb_erase(node, rr);
 	return container_of(node, struct lock_stat, rb);
+
+}
+
+/* returns left most element of result, and erase it */
+static struct lock_stat *pop_from_result(void)
+{
+	return pop_from(&result);
 }
 
 struct trace_lock_handler {
-- 
2.48.1.502.g6dc24dfdaf-goog


