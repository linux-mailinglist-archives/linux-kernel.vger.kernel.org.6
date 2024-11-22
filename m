Return-Path: <linux-kernel+bounces-418421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D959D6171
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7B61603FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5212C484;
	Fri, 22 Nov 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrwb6H55"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9694207F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290062; cv=none; b=fTYAHnHyWQh9d1usP5TgBQQf0yCfBxy9MLOY9CWWqgS07eqa6+jwWQ2bl92FWppsVtAATLEDkbBAEyabqq6itCWhnoJZ3Xon6i6RvIFOEYH2r9HI2p7sYz2VdJHiWJzf5iKVLKgXPIKRI7PhoLZILppLqP4unMMQnta+EEfMmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290062; c=relaxed/simple;
	bh=eY74rpC1y4FpYpbxCE7W6Ow6T3LIcTFrZGXMApjCveU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qh9hIJdsRBfZm5Fbg6SozB55OBhlFjKhb1fAdbkfQe/R1+BLIlm/A+ePZCXKGqx/AG2mIJO/UfN5joAisfyhMlcXf5yTybxmUuD1FFbc93NvGvL2AcHDwrZlAedXxccJgu5c/yvf791qNGgZWLYA47AhkaKjdg8/0Yuhq1L0H+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrwb6H55; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso160300866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290058; x=1732894858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTxOguFgwy9tOkyUrOPXOUVNTctOk0wNzBQXya5aVos=;
        b=wrwb6H55JK3J3G5/T8nPK1CnCA7VsupS8iNE74ilYlJ/SwOZFUh4XqHXrERFpd+x7v
         qcxUMZCt+B/iCv0HJJqNhfdMLkDUIWxb9tg5k/EM2gd0WcdflscEsmcPF168hhEegsHp
         iPTHQovm7Nde3eAc4fA666k+ubf4bEptDUM9hTsQMdMlrQnS0x4pfHAjuD3sMmrdTHqI
         BPo/KVTGMWbtL7WMk7LYEur7QQNHFGoKi/Z2QE5jID4L5E9LKesKCFBMjnuvn8r/yNEg
         MUh/UdbcY0R9F9v53zQ3KiF7AGByv5r1yg/01SRPsChWGMY2VRpR5VGwOt8KXYQk15Oh
         dAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290058; x=1732894858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTxOguFgwy9tOkyUrOPXOUVNTctOk0wNzBQXya5aVos=;
        b=ixQCpZrt9wobj++mnMdEkAotjDhqguOBPq6yN+3AUkuYKtD9Nv5MinjxPvx5SV0nIw
         9qdpDKiw9dfZc2lKdwfz2uf9ugQa5+65TgzIpRa1rFTlDsGW2wUYK6zyn/g18lrmA24v
         zu+2MhhHthGw0lyZKSPfOsdoyUiL6QBLPcKe8keue66jUPmlyDzzvgBvqphJa68LU1l0
         JsDBi635ye6pa4Gr01B258TY8WESzeaEHVqMrlmAosZpwfeGUQFytX/5ZkeKWZQEOgim
         tD/+rSwhQ8CPF+w3674ZalTs1nK2zSaYydn/zXH63CU6Q2nT+9bgxAgs8fmrr3CNR5AP
         Upbw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Yjb33sOcB4O9uj93TbR4Zl4+bS88XTcz5fI6kcOSB+hYDSfqUiUgO2WyCMB4zBTgs/Ikz59lNCoVxlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMOevq5yhVnc6QxSgZT0Ob/M8zB54X0KrT0SPU1fiwbhhJ+1W
	uOA9XkDHs5EVLEf2wu2dyjmdjxn0qltLLevAg5VJQUMl4TQzo+rTMXDV2D4j3XZdabf8Gplu9g=
	=
X-Google-Smtp-Source: AGHT+IHC6kfIvPj3vG1i+LAY/CGzJaSxv8wDpDJqxPFx2Qz/GZuoQ+cNZBfybl6y2Mvx/LGv/9WCbm1jIg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:e369:a6f7:a3ea:97bb])
 (user=elver job=sendgmr) by 2002:a17:906:f194:b0:a9a:11e5:c8d3 with SMTP id
 a640c23a62f3a-aa509bc55eamr69466b.6.1732290058216; Fri, 22 Nov 2024 07:40:58
 -0800 (PST)
Date: Fri, 22 Nov 2024 16:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122154051.3914732-1-elver@google.com>
Subject: [PATCH] stackdepot: fix stack_depot_save_flags() in NMI context
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Per documentation, stack_depot_save_flags() was meant to be usable from
NMI context if STACK_DEPOT_FLAG_CAN_ALLOC is unset. However, it still
would try to take the pool_lock in an attempt to save a stack trace in
the current pool (if space is available).

This could result in deadlock if an NMI is handled while pool_lock is
already held. To avoid deadlock, only try to take the lock in NMI
context and give up if unsuccessful.

The documentation is fixed to clearly convey this.

Link: https://lkml.kernel.org/r/Z0CcyfbPqmxJ9uJH@elver.google.com
Fixes: 4434a56ec209 ("stackdepot: make fast paths lock-less again")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/stackdepot.h |  6 +++---
 lib/stackdepot.c           | 10 +++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e9ec32fb97d4..2cc21ffcdaf9 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -147,7 +147,7 @@ static inline int stack_depot_early_init(void)	{ return 0; }
  * If the provided stack trace comes from the interrupt context, only the part
  * up to the interrupt entry is saved.
  *
- * Context: Any context, but setting STACK_DEPOT_FLAG_CAN_ALLOC is required if
+ * Context: Any context, but unsetting STACK_DEPOT_FLAG_CAN_ALLOC is required if
  *          alloc_pages() cannot be used from the current context. Currently
  *          this is the case for contexts where neither %GFP_ATOMIC nor
  *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
@@ -156,7 +156,7 @@ static inline int stack_depot_early_init(void)	{ return 0; }
  */
 depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 					    unsigned int nr_entries,
-					    gfp_t gfp_flags,
+					    gfp_t alloc_flags,
 					    depot_flags_t depot_flags);
 
 /**
@@ -175,7 +175,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
  * Return: Handle of the stack trace stored in depot, 0 on failure
  */
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
-				      unsigned int nr_entries, gfp_t gfp_flags);
+				      unsigned int nr_entries, gfp_t alloc_flags);
 
 /**
  * __stack_depot_get_stack_record - Get a pointer to a stack_record struct
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ed34cc963fc..245d5b416699 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -630,7 +630,15 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
+	if (in_nmi()) {
+		/* We can never allocate in NMI context. */
+		WARN_ON_ONCE(can_alloc);
+		/* Best effort; bail if we fail to take the lock. */
+		if (!raw_spin_trylock_irqsave(&pool_lock, flags))
+			goto exit;
+	} else {
+		raw_spin_lock_irqsave(&pool_lock, flags);
+	}
 	printk_deferred_enter();
 
 	/* Try to find again, to avoid concurrently inserting duplicates. */
-- 
2.47.0.371.ga323438b13-goog


