Return-Path: <linux-kernel+bounces-180675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A208C71A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E0AB218D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B35322EF3;
	Thu, 16 May 2024 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnS0mFyB"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FE21104
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840943; cv=none; b=SnmexvGhbdWp466dYkTQESTwefVEKffwU5QqDzm18oJgk/GfqLr45E6n+Wbo+2Do85U5y7Y2AMwI7LTci5UkQXwFyhCBuSiKy7WUjj6wikG/DdimETcfnSBkdOBMx5zy1ij37gUzAJ4v08L+iV7M/cAd2LAaM6ImXOXouBfi9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840943; c=relaxed/simple;
	bh=Do8+hrkPYfVF70FufV/8izbbtcXtflTbhGYfCnKVeSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzaPo1MzvWimgXWRY1XfmTe5lGyRK1FyCX2gdCp3dlwz48Wi7etFQo7Bm0wsyZhZL/kgyEPdj4Nf/m8u3kYC1MIE5odzrRAVEF95ttP2lrXAVuyYybhN4nz5L63MOjbsnMaURfrrto5nmUegCqCFAKYtZFgWXvQWO3xWVwhBYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnS0mFyB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34da04e44a2so6008446f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715840940; x=1716445740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rg8sgBlpOEhG+vmyc1NABRGMyciJCtyEIj3MgTpcGM=;
        b=HnS0mFyBl9cPHkDq7DBlS+Rjve+YaW0ikDw/F5Lj+DJviv+Wkwtp0EKMTb8/jddnLs
         U6ZetE02/OpZcSBzMvfJgM1mySm4on+Spp9oH3pgt1YhqsU2tNLj/yq1teBnA/qYHNWL
         05JzXvfGSq+q6LwHbYxRTnvI3AkOQtds+HRqfpw1z5nKIqpubr1+85Ey5Hdb3CavUcG4
         JlQvkvC6NV9PHxvMoDVaxGB40JSOdYV7FkJ6J7RxSFc7wiFCqTLaaYlTVoPT43cz0iIQ
         dYAWKmc89HLpEL+PwmYRjSnhBpP4tJXVhhMfwO34zDb8zwvVPtM9gMyKaqkFk8ctSgTA
         qqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715840940; x=1716445740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rg8sgBlpOEhG+vmyc1NABRGMyciJCtyEIj3MgTpcGM=;
        b=rqEH8FMdWm6TRwUYPY6Jgp24R2dWhnOupWwjt3OtJkDzwfISUuQ13T8yrNVuQ2wNaO
         RzerwWXZjdHgiO6IfgS9cY97BeyV3gX07rCEL4ypQE56G3a6Bl1DvQLGoMNGUxp2brCe
         EK+fLkgvlgCrHG17olfNuyNNf8Odsq45g/ZUbhgBBYdIV3zTOv1IxL8LffGyhO7Izkl4
         zK0jKQFTo+HeVAmR2wRVOJGVmf8M1ApIWbd0P7OjPfN/E8FsmF0iZcsQ4NKGVEuvmMBs
         qHTnPj5QM8idSMhdQJni3NbBwkVq8qMzodBISQ+Xc3E8rVWg1Dqn7NJ11cDKkh4wg4UZ
         fv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVa7MrK1uM6RkSc2wuCqDL2FsZ5vzMtAnj5UQE4h37OcABObG65W3aoT/stzRuCi+5ZDV0pKqOOi4M7dptOdQJAGCgTKAQ5Zbkbn807
X-Gm-Message-State: AOJu0YxMkiiBV/EaB7U/ywlmUFBgvt27tbzRi6FvPSwoicsQRrbg2Xkv
	MJsJcAE0SnDqlvP5lkcRbvckTSjVbU0iIivLbEW2k1jbbX4FTQsy
X-Google-Smtp-Source: AGHT+IGhSwgHBXtvft87CVqxzGNP+iqIxB2m7O1j0hd4rs/o3rysHb4Rqq4nTpjVUhe7m07914zAQA==
X-Received: by 2002:adf:e40e:0:b0:34d:28bd:a83 with SMTP id ffacd0b85a97d-3504a63645amr12021785f8f.22.1715840939805;
        Wed, 15 May 2024 23:28:59 -0700 (PDT)
Received: from f.. (cst-prg-82-229.cust.vodafone.cz. [46.135.82.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc955sm18051149f8f.111.2024.05.15.23.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 23:28:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: dennis@kernel.org
Cc: tj@kernel.org,
	hughd@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] percpu_counter: reimplement _add_batch with __this_cpu_cmpxchg
Date: Thu, 16 May 2024 08:28:47 +0200
Message-ID: <20240516062847.1064901-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces the expensive cli/sti pair with not-lock-prefixed cmpxchg.

While it provides a win on x86-64, I have no idea about other
architectures and I don't have easy means to test there either.

If this is considered a problem then perhaps the variant below could be
ifdefed on ARCH_WANTS_CMPXCHG_PERCPU_COUNTER_ADD_BATCH or something more
concise, you get the idea.

That aside perhaps it is possible to save a branch if there is something
cheaper than preemption counter trip -- this code needs to prevent
migration, does not mind getting descheduled.

================ cut here ================

Interrupt disable/enable trips are quite expensive on x86-64 compared to
a mere cmpxchg (note: no lock prefix!) and percpu counters are used
quite often.

With this change I get a bump of 1% ops/s for negative path lookups,
plugged into will-it-scale:

void testcase(unsigned long long *iterations, unsigned long nr)
{
        while (1) {
                int fd = open("/tmp/nonexistent", O_RDONLY);
                assert(fd == -1);

                (*iterations)++;
        }
}

The win would be higher if it was not for other slowdowns, but one has
to start somewhere.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 lib/percpu_counter.c | 48 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 44dd133594d4..01f0cd9c6451 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -73,11 +73,14 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 EXPORT_SYMBOL(percpu_counter_set);
 
 /*
- * local_irq_save() is needed to make the function irq safe:
- * - The slow path would be ok as protected by an irq-safe spinlock.
- * - this_cpu_add would be ok as it is irq-safe by definition.
- * But:
- * The decision slow path/fast path and the actual update must be atomic, too.
+ * Add to a counter while respecting batch size.
+ *
+ * Safety against interrupts is achieved in 2 ways:
+ * 1. the fast path uses local cmpxchg (note: no lock prefix)
+ * 2. the slow path operates with interrupts disabled
+ *
+ * This deals with the following:
+ * The decision slow path/fast path and the actual update must be atomic.
  * Otherwise a call in process context could check the current values and
  * decide that the fast path can be used. If now an interrupt occurs before
  * the this_cpu_add(), and the interrupt updates this_cpu(*fbc->counters),
@@ -86,20 +89,33 @@ EXPORT_SYMBOL(percpu_counter_set);
  */
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
-	s64 count;
+	s64 count, ocount;
 	unsigned long flags;
 
-	local_irq_save(flags);
-	count = __this_cpu_read(*fbc->counters) + amount;
-	if (abs(count) >= batch) {
-		raw_spin_lock(&fbc->lock);
-		fbc->count += count;
-		__this_cpu_sub(*fbc->counters, count - amount);
-		raw_spin_unlock(&fbc->lock);
-	} else {
-		this_cpu_add(*fbc->counters, amount);
+	preempt_disable();
+	ocount = __this_cpu_read(*fbc->counters);
+retry:
+	if (unlikely(abs(ocount + amount) >= batch)) {
+		raw_spin_lock_irqsave(&fbc->lock, flags);
+		/*
+		 * Note: the counter might have changed before we got the lock,
+		 * but is guaranteed to be stable now.
+		 */
+		ocount = __this_cpu_read(*fbc->counters);
+		fbc->count += ocount + amount;
+		__this_cpu_sub(*fbc->counters, ocount);
+		raw_spin_unlock_irqrestore(&fbc->lock, flags);
+		preempt_enable();
+		return;
 	}
-	local_irq_restore(flags);
+
+	count = __this_cpu_cmpxchg(*fbc->counters, ocount, ocount + amount);
+	if (unlikely(count != ocount)) {
+		ocount = count;
+		goto retry;
+	}
+
+	preempt_enable();
 }
 EXPORT_SYMBOL(percpu_counter_add_batch);
 
-- 
2.39.2


