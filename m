Return-Path: <linux-kernel+bounces-185529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F678CB655
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62EF1F21E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056721494CC;
	Tue, 21 May 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC1lw5KQ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307B9475
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334277; cv=none; b=CEDhhbh3j/hRKS4fuRR+V8ebT2IklReJRzOB79moczfrqlaNoAoiFV7st7k7zG2Bd0VXrEe4ifLSWW3Q9IjSBBxs2GURYNIJbZyHzkMdeEco00GQu4+NLUf++BX5d/0Q09hNAcyIQ5Zgnz3NSR+tBt5mgQ0bwFkquDJHZa4URzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334277; c=relaxed/simple;
	bh=Fqqr9Gm/hKAmSln+mHjB6Y1RS2l94gl0TeOwIgxgghk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbUc5s/hNA5g25b+HPcNgxt7q3eCti8/fz6TOxlG1qEjcJpz5norOfEIN/Fy6JXaKoyBZIpL7n1KJhCtcTGXAMXll9srHhywDncRshnTXmMpTUPi1pMJ8MekDOMjsonQd7OQxzRilE/TBX021nvDjRa0ReVtHxcL7MPvlJoGt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC1lw5KQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571c2055cb1so2546471a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716334274; x=1716939074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqPAZZjPqHvDwLszD6b8Qm4Tg+BARirbGA2Pdbnf72s=;
        b=RC1lw5KQP/XvKUA9OMU/i+p432BSCWWZsUN6uuTuYrMhjrUIleN36DU5BsdYSJAmEp
         EhBfZX5lROts0YraWHFmPY2qQlAaGxEr2yslCulSzgXYGOXLrXQ2etO2Xo6GxXBtWdjQ
         KEfTNg3ZYxXE7u74AdIVKI4dcmYlo46SAil7QDzE8sNYgf2k5iPbKwZ98U2oQNoDOe1i
         sjy48Ub8OiYE9O9nmFxYC/uAUNlc/xB2mGaMymc46qy8urJKP/A+j7HKhp3xnI5Kt8ib
         DXkSt4yHTcPappD5SJ5h/ICqS6ZNFAKh6bHNahVH33mj+LghIdKRLjhAERv1ZVUKqMLY
         oUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716334274; x=1716939074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqPAZZjPqHvDwLszD6b8Qm4Tg+BARirbGA2Pdbnf72s=;
        b=qMOkfSvmkamCRnmZT4iqddIRDXIuqjMW6Sk/v2YAG1PyuA0DepRovdqZ/eOhIfQ0az
         My40NBPB0dR8MlPcWHrvmpfhKVRxSe6747ctEgfn4fNauExgbsv8pivyN+AZ3/Y4yEbr
         +5cp2vQpmAylL66yMPClcb4nY4/g5KzPo6zXwL7QYIxhxXYe0BzhikSgilJccXtqO63e
         qsYw6P/JOu4vuE7Smc52S+gwkok83LfCL1CZxjqmrucosm/9Q5XmRyYUzR335Ly2PFtb
         uZKiK74ZUhZ7FXIJpierOdrGPFAf99w0k3b6Tnu0B76iBqVoG1J1UJnnQJ4k5D8o/jkv
         aWgw==
X-Forwarded-Encrypted: i=1; AJvYcCVlLqQAJUXZgtUJDEFkCISWRxCFNCO1FQJ1TciO+f0UiAvQsirXn1wWLQN7BPsCB+n2kSQsMPosVFmAzkQ2XxvtxPkjzAer1O4xcd+H
X-Gm-Message-State: AOJu0Yztag1OcyBZCTYQmDpf3ZaRxMl/K0uuLDa+tSMpP/mn3VmYM8YY
	9U+D060ArGqOlYwmJK+i2uCs46s6BUj4RaYJEHAedDAZViBw2vn2
X-Google-Smtp-Source: AGHT+IHtXE1d5G9pJ2WTi0OrYXevd9wa+c0tBu9ShIuzfN2sQswRwV5MPugbx6A52VwQzgEJNaW9fg==
X-Received: by 2002:a50:8e17:0:b0:573:55cc:2f50 with SMTP id 4fb4d7f45d1cf-57832c585c5mr141882a12.37.1716334273685;
        Tue, 21 May 2024 16:31:13 -0700 (PDT)
Received: from f.. (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57825a6f47bsm1333062a12.64.2024.05.21.16.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:31:12 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: dennis@kernel.org
Cc: tj@kernel.org,
	hughd@google.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] percpu_counter: add a cmpxchg-based _add_batch variant
Date: Wed, 22 May 2024 01:31:00 +0200
Message-ID: <20240521233100.358002-1-mjguzik@gmail.com>
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

v3:
- add a missing word to the new comment

v2:
- dodge preemption
- use this_cpu_try_cmpxchg
- keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL

 lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 44dd133594d4..c3140276bb36 100644
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


