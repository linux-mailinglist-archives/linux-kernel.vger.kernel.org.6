Return-Path: <linux-kernel+bounces-183451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D98C9930
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4637C1F20F78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9E18AF4;
	Mon, 20 May 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THhhE5S8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F61865A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716189257; cv=none; b=SF1jdDi2dNeHQM1Thy+KV9/A+1LnhwesMcRPXyu5u9e5uKCTvs7FvMoW9xCS+ClG2RyNKz6mg46eeZqaSjy4jTvP73qyfYrSzjhX7ttC/1qXWKHjDBtdbyWWmKxCE8dFelYhDU0WX5/zi1+3gxcPqpk0bL8xRpYvFaz0YvxNWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716189257; c=relaxed/simple;
	bh=HqRomw7PvD7opEbwRuNt2g5NQH+EA6onQdBZHNyIvL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxQg8rc6uPnYFiBQ4USWuM2MvjYkWIrPrpmqM4d3Sr0Kf/qvODcvOcZ2IZkO9/myuUZCzCCf0KyidlRC/uXUPJ7RRXoHqtaw/Pxo0wWB/5GyGljpH8kQN27j6tTIfIdJhiRA37qt4twlHaTgE08uthDsJ2mXuK7RjUp1SZ0hCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THhhE5S8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so7693155a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716189254; x=1716794054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ3PltnZNdgwNAbMD6uwjPtdVhRlQYrC9JSG8VMmpxQ=;
        b=THhhE5S8rSNZP7f1xd2b9AHpC0alJ1LZyZkT8p3svqwo89v30ZS4Kjte+SZr70+9KT
         075P420dHWkc+rEzO1D/IiBYcOh/apx0v5M0PczJtJOmf8i+x9gV2zJ4FvagRuWKI2h3
         UiCYKawjKu3dr50/czkU1MsuZSHRUnnU+TJzCinA9z4rPHADbJm6pBPauTjbLBs16027
         cP4FFkboexPdy39UsoDNpPEubCtxItCHS0pXiFn4oJPK8C5EMzIvtGcRDzdY08sWxfLw
         Xii5hRch7tDQkrblFpepIlhM87Hu4JlHMb5jzezOcmM6zTngLoTwy4+0tRcQkjrYGF/h
         hpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716189254; x=1716794054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZ3PltnZNdgwNAbMD6uwjPtdVhRlQYrC9JSG8VMmpxQ=;
        b=FMPPeMgSLUCvUadWcAOBEyoBZ9RRgE7pdGxuE3sDKhoqexzbeCRpTE8BMJ/Jak3pT2
         TpOWEIGyVxvICxF1lB4VgkgtoFDl/UZThTgzxcd0rvIG6zlkeRsSCzzjmCyhplQpUg7M
         ozMo9vJ5XwEsYapNoJtw3/x4xY4Ae3lAuzYkLp1MUOZLSO/gp8GuuNSukD6wcbAC3kX7
         mja1p7YXu6Lv2As90HWLdZ5AanWipEgYXBbZSLeJghUjGwmNpc50QS2WQbMgn/yPX9Tg
         XRe6GaTcMWSR4mKJtycmJIvgm05W6IM5Vi+UvbRzNw8AkASLlNKBVKMVsHkzVDdt05xG
         06bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk80AU4ym6+FYSxrkC7Hbb+S53XUpkeOWiSvPg8x646UW0Qz+v+ngLT6HSKw+fF+etD+SqcW/Xkg9vNSBrgyalB/Yrr6R1rhVFpNyI
X-Gm-Message-State: AOJu0YygpvuGsnv/iLLhHd4HEY6V4tTZ+mdZqINdRwxjn9kzX3tNPvOM
	aUDQQXtZkGXmLe2ChV/IRKRgaX3UvEtklFi8MwQv9NJNOe3GtFNW
X-Google-Smtp-Source: AGHT+IFpcWecaqheR6olE2EQ7ViMsVokrPeDzwE+eEfMtuGuvWEkz3ZG4+3aCMSdskzOZNNg8PcScg==
X-Received: by 2002:a50:9ec5:0:b0:568:8e22:4eff with SMTP id 4fb4d7f45d1cf-5734d6df0d5mr18026097a12.37.1716189254152;
        Mon, 20 May 2024 00:14:14 -0700 (PDT)
Received: from f.. (cst-prg-73-12.cust.vodafone.cz. [46.135.73.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfde7sm14701087a12.48.2024.05.20.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:14:13 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: dennis@kernel.org
Cc: tj@kernel.org,
	hughd@google.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] percpu_counter: add a cmpxchg-based _add_batch variant
Date: Mon, 20 May 2024 09:14:07 +0200
Message-ID: <20240520071407.201618-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was "percpu_counter: reimplement _add_batch with __this_cpu_cmpxchg".

I chatted with vbabka a little bit and he pointed me at mod_zone_state,
which does the same thing I needed except dodges preemption -- turns out
cmpxchg with a gs-prefixed argument is safe here.

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

v2:
- dodge preemption
- use this_cpu_try_cmpxchg
- keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 44dd133594d4..80ec2ffc981a 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -73,17 +73,50 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 EXPORT_SYMBOL(percpu_counter_set);
 
 /*
- * local_irq_save() is needed to make the function irq safe:
- * - The slow path would be ok as protected by an irq-safe spinlock.
- * - this_cpu_add would be ok as it is irq-safe by definition.
- * But:
- * The decision slow path/fast path and the actual update must be atomic, too.
+ * Add to a counter while respecting batch size.
+ *
+ * There are 2 implementations, both dealing with the following problem:
+ *
+ * The decision slow path/fast path and the actual update must be atomic.
  * Otherwise a call in process context could check the current values and
  * decide that the fast path can be used. If now an interrupt occurs before
  * the this_cpu_add(), and the interrupt updates this_cpu(*fbc->counters),
  * then the this_cpu_add() that is executed after the interrupt has completed
  * can produce values larger than "batch" or even overflows.
  */
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+/*
+ * Safety against interrupts is achieved in 2 ways:
+ * 1. the fast path uses local cmpxchg (note: no lock prefix)
+ * 2. the slow path operates with interrupts disabled
+ */
+void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
+{
+	s64 count;
+	unsigned long flags;
+
+	count = this_cpu_read(*fbc->counters);
+	do {
+		if (unlikely(abs(count + amount)) >= batch) {
+			raw_spin_lock_irqsave(&fbc->lock, flags);
+			/*
+			 * Note: by now might have migrated to another CPU or
+			 * the value might have changed.
+			 */
+			count = __this_cpu_read(*fbc->counters);
+			fbc->count += count + amount;
+			__this_cpu_sub(*fbc->counters, count);
+			raw_spin_unlock_irqrestore(&fbc->lock, flags);
+			return;
+		}
+	} while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));
+}
+#else
+/*
+ * local_irq_save() is used to make the function irq safe:
+ * - The slow path would be ok as protected by an irq-safe spinlock.
+ * - this_cpu_add would be ok as it is irq-safe by definition.
+ */
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
 	s64 count;
@@ -101,6 +134,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 	}
 	local_irq_restore(flags);
 }
+#endif
 EXPORT_SYMBOL(percpu_counter_add_batch);
 
 /*
-- 
2.39.2


