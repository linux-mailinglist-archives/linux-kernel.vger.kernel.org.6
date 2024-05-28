Return-Path: <linux-kernel+bounces-193048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC408D261A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC01528E418
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5959617965E;
	Tue, 28 May 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMW+s/Wm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257E178367
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928987; cv=none; b=ecokfY9Wf4/NRxBmOz8qTIdgqUKK3wJgn6rtD/AMQe+Qjmbvm8USEUxjEsb9db+j172AZiKVWPktUQy8VG9w1zBWQCGglt3T+rNa0+I4JBYBzBMp/0hQIyCAcDWHqaErcBIb22zuQxeBfxwwcDxMQxtGM/l1AjhquoJpW95VHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928987; c=relaxed/simple;
	bh=elEC0SOa0tI4N31E4L7FFTJaLhK4BpjXMNwt4d0uNpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paw9SiBLf1RP+1BpPqEVnU4+xBt2meGWakRtqX5/5SjmA04qtn85hbciylZNAJbxqjRXTOTircW43NerCVgruRrcbiZVhKT7O8xOZ5A2Q6DEtJqkD5rl8dQMBmizDqtQDO+THGZwfRP7n1OLF9JE3U7OcZ/RSNZbQM6B4TcdJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMW+s/Wm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso10486935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716928984; x=1717533784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0e+jKy/0Fwk1GGmrtXEpWgTrJX0Xz7tJuQrxdoVOEA=;
        b=PMW+s/WmIrsFPuFrBS1CE8CLlE9MnsU+WeIi+FvC5VC21lTUGXhAUxHBz+j8nRWUbK
         NDo0PHMANZnvmxcF6CP20mXm/aSWZz4/fjuwlsXXVkbGwMrgBD7jYs/iYVI0OkGwyhQ1
         GnALls5v6W5xyDYt9AK/+uCb0F/ws/c3wcWWDOOQbW7I6Nf5576cy7zZSyvrLEMWKZFf
         Ln1Mp91SXLZ2VKHMzjH8QC6HAVPDfX9JOLICLrPxdxtSsz7ZHBbylFPJkDiId/VsLdce
         nWrU/STv2Yc0rcqtB5h3ILxEQgR7ZMUk/nB9sldGa9gbcUQQmcyrQzp8XofVbJBvTxLr
         CqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928984; x=1717533784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0e+jKy/0Fwk1GGmrtXEpWgTrJX0Xz7tJuQrxdoVOEA=;
        b=UJLoT+tpcIx38oDRwrF/S2CicM2fb9BR+7LZHFKjisktKSLxNwru6qHDyj4ftX3Hdc
         WSBfRfaPCZZEruGRatck7CHDsLwkX9nAvmzRTaBMug9MEvYHkYyDz7UHZzk8yvxm99s5
         2bSpB0fb7FmJEPLeeAjyg1Rru/FA5R0fkGXDpvuSLY+hwiNbUAlp1KGcxEARz8rFWySU
         uWkndRiuxJ3ObrkCOpp6vykCd/mYHaI8sdUCvktaeHO1WM13GDsMPU7Avc+0DFXzLFI4
         pwHSwCGYq1PdpgtZJ/39iGlccUzc4X15WvL2giVNdZT2tlNbV86fH8q2rsVjxjyW7yPV
         iFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW4QJK7/PbnN6OuZljWk6K9XOcF938Cg6sjyfsepZgXNsVqBJppoOAPrMjiHocLnGt7nabPk1fVaPa84B3HnJM/cfWldkjiykDGhO+
X-Gm-Message-State: AOJu0YyH1Fa5Ls9HCDnr/JmacyAp1rX2T84khPpi7cGSjw3+d6l/Wu52
	8DtZgEj0viiZTtghpbwj5NJ/OsIMvLBUETfS6Z3w/i+VK7i/HyUx
X-Google-Smtp-Source: AGHT+IG6CIFAgJKe3YOWgetMFHgXYZ+i9ODfyhlwMyMrWDq7Ju8nQYUGfW5MyNQ2NhN2FtIuC6+u2A==
X-Received: by 2002:adf:fcce:0:b0:354:fb1d:694e with SMTP id ffacd0b85a97d-35527058247mr9653920f8f.29.1716928984046;
        Tue, 28 May 2024 13:43:04 -0700 (PDT)
Received: from f.. (cst-prg-92-138.cust.vodafone.cz. [46.135.92.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42120785973sm27888985e9.12.2024.05.28.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:43:03 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: dennis@kernel.org
Cc: tj@kernel.org,
	hughd@google.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4] percpu_counter: add a cmpxchg-based _add_batch variant
Date: Tue, 28 May 2024 22:42:57 +0200
Message-ID: <20240528204257.434817-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---

v4:
- fix a misplaced paren in unlikely(), reported by lkp:
https://lore.kernel.org/oe-lkp/ZlZAbkjOylfZC5Os@snowbird/T/#t

v3:
- add a missing word to the new comment

v2:
- dodge preemption
- use this_cpu_try_cmpxchg
- keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL


 lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 44dd133594d4..51bc5246986d 100644
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
+		if (unlikely(abs(count + amount) >= batch)) {
+			raw_spin_lock_irqsave(&fbc->lock, flags);
+			/*
+			 * Note: by now we might have migrated to another CPU
+			 * or the value might have changed.
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


