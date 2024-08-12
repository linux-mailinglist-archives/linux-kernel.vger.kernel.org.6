Return-Path: <linux-kernel+bounces-283036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705394EC37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0930A1F2272C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547917276D;
	Mon, 12 Aug 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoxvuOy8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA41779BB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464003; cv=none; b=nTEM6WZheVyHjfSV/F8oEfca38uhG7ZC2KtjgIjeULDLNa4x0XuVmNv8FeFtPcEtfGDrxg805cZEIpmfPEIWcFFM+T40OU3Th71btrVY26EI9yXPtmqSztJnnh/3uUsaaZ3pZkoGMvkHmHDaiOEOuD9Vp1FqzHxY/crDbYrYMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464003; c=relaxed/simple;
	bh=A23uUvQ7BdMbF5zWE+OLndw2Turmi86y1ZGhT+Okjbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ20COOMSGYHA1ed29KagNvBPmdQN49IiNd7J/eFgiyr54g5hdtiLxb0z0JvydZXW529KoXvJD/HHJGkMagKnRED3i6Yyiw16Kg3Z3SDek89ZVkMBs5ffrBLUX69LnTqGSshbtl5oJwBRO9ls3ImSoZN6Bht1O6e78gm4nJB/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoxvuOy8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ab63a388bso139963266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463999; x=1724068799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efqfVk4wKUu5y2Eyqs3KUsdZhsPQcKGa1y+niD5IcF0=;
        b=IoxvuOy8kF2cVguoCm/uSh6VbbikzIvbpW9avQPfnSR03J57klWKCl0OuheIqdc58M
         w9O9f1LGukXaI1c9c6URP/TV9ESkNMgp1v1LUu049slhoQSmFrY75dCxHdFDANWOcfpL
         H6nXvZxfeTtHvtUBAvqrRt9h9PIAjeSJzt295aqbY9Oj5wWQCdoZcefgRpK5fWxZxHR4
         EmbbEYQK6n6ghbZfDbiQsdOhB1AXnRHBQDBiCNfJxkGZzkhaVTK/Oqjn2h/8S1usewck
         aX09ifZq8BUuhZpNsUGg3zWpO6z85QQuvz1y77/KAOo6gdGBgGYhPqtvTM7urI14xSGL
         Eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463999; x=1724068799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efqfVk4wKUu5y2Eyqs3KUsdZhsPQcKGa1y+niD5IcF0=;
        b=hJJNiURg6VxEDIq1r0UG/RTJXEecjCPr7gl5SmpBP5LoFj28xKqTMOBlMTgGYOeMew
         FgIvhzW4YdpZq9jG44JydUVJEtlFjQo1KopJB95yvuY737UesJ4LGAITJaOUsSnqJ7JC
         +BrWFK+OFjq7xS48r+qX2WBkzZRWfvy2aUunm2715TiHy8XlVma0gkwwIkbvrgBzFWQb
         FCxrQHOlVNKGIhqw0mPgHvigtNwL3eemiJxx5fDfLsl3X2hCIF2IG6QPq29AUo+q1coR
         HySebR0ig8QuCyACPDV20juAgzO6V8JM088GZ+zwep3TkfyEFA1OOruuQbkAaQRGrllI
         DaJA==
X-Forwarded-Encrypted: i=1; AJvYcCWwdUxZbZh1R9JEgP2NMCkvN5oaG/G2gIGzLvZQPCVi3Ut14qUyiqD9XnlzaTnm6owT9fZtAQ7IKyq6m1xy8m2TBJlNhAd/DGUCPjaI
X-Gm-Message-State: AOJu0YyGg/RXnf/keLJ65F91CWWHojdml5L/kwrcyloQuW/tD7AKIyvD
	xv9cJTTRrpXFBA0wh9/zSN03BJxI6je1RuQwqIYjq4o6OihhLxDVzuEFOYzUdP8=
X-Google-Smtp-Source: AGHT+IGiz6BT46LDWsI4Kfhh8bbjUUZbNV/Nqu7ImfCdRuAQ78vk+RWaGtts3dHDU6gbsnhG/C8MMg==
X-Received: by 2002:a05:6402:2347:b0:57d:669:caf2 with SMTP id 4fb4d7f45d1cf-5bd44c66b08mr14452a12.25.1723463999358;
        Mon, 12 Aug 2024 04:59:59 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04aesm2055970a12.76.2024.08.12.04.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:59:58 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH v2 2/4] percpu: Assorted fixes found by strict percpu address space checks
Date: Mon, 12 Aug 2024 13:57:36 +0200
Message-ID: <20240812115945.484051-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812115945.484051-1-ubizjak@gmail.com>
References: <20240812115945.484051-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assorted fixes to prevent defconfig build failures when
strict percpu address space checks will be enabled.

These show effeciveness of strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/x86/kernel/head64.c      | 3 ++-
 drivers/base/devres.c         | 2 +-
 fs/aio.c                      | 2 +-
 include/linux/cleanup.h       | 4 ++--
 include/linux/prandom.h       | 1 +
 kernel/events/hw_breakpoint.c | 4 ++--
 kernel/workqueue.c            | 2 +-
 lib/percpu_counter.c          | 2 +-
 net/core/dev.c                | 2 +-
 9 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..f5d6ad351cc4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -560,9 +560,10 @@ void early_setup_idt(void)
 void __head startup_64_setup_gdt_idt(void)
 {
 	void *handler = NULL;
+	struct desc_struct *gdt = (struct desc_struct *)(uintptr_t)init_per_cpu_var(gdt_page.gdt);
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.address = (unsigned long)&RIP_REL_REF(*gdt),
 		.size    = GDT_SIZE - 1,
 	};
 
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index a2ce0ead06a6..894f5a1e6d18 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1231,6 +1231,6 @@ void devm_free_percpu(struct device *dev, void __percpu *pdata)
 	 * devm_free_pages() does.
 	 */
 	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
-			       (__force void *)pdata));
+			       (__force void *)(uintptr_t)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
diff --git a/fs/aio.c b/fs/aio.c
index 6066f64967b3..e8920178b50f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -100,7 +100,7 @@ struct kioctx {
 
 	unsigned long		user_id;
 
-	struct __percpu kioctx_cpu *cpu;
+	struct kioctx_cpu __percpu *cpu;
 
 	/*
 	 * For percpu reqs_available, number of slots we move to/from global
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d9e613803df1..f7e1158cbacf 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -154,7 +154,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return (void *)(uintptr_t)*_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
@@ -211,7 +211,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 									\
 static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 {									\
-	return _T->lock;						\
+	return (void *)(uintptr_t)_T->lock;				\
 }
 
 
diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f7f1e5251c67..f2ed5b72b3d6 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
+#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6c2cb4e4f48d..d82fe78f0658 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -849,7 +849,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 
 	cpu_events = alloc_percpu(typeof(*cpu_events));
 	if (!cpu_events)
-		return (void __percpu __force *)ERR_PTR(-ENOMEM);
+		return (void __percpu __force *)(uintptr_t)ERR_PTR(-ENOMEM);
 
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
@@ -868,7 +868,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 		return cpu_events;
 
 	unregister_wide_hw_breakpoint(cpu_events);
-	return (void __percpu __force *)ERR_PTR(err);
+	return (void __percpu __force *)(uintptr_t)ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(register_wide_hw_breakpoint);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1745ca788ede..32729a2e93af 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -377,7 +377,7 @@ struct workqueue_struct {
 
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
-	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
+	struct pool_workqueue __rcu * __percpu *cpu_pwq; /* I: per-cpu pwqs */
 	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
 };
 
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 51bc5246986d..3d0613ac7e73 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -209,7 +209,7 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 		INIT_LIST_HEAD(&fbc[i].list);
 #endif
 		fbc[i].count = amount;
-		fbc[i].counters = (void *)counters + (i * counter_size);
+		fbc[i].counters = (void __percpu *)counters + (i * counter_size);
 
 		debug_percpu_counter_activate(&fbc[i]);
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..5cad88cf029c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10860,7 +10860,7 @@ noinline void netdev_core_stats_inc(struct net_device *dev, u32 offset)
 			return;
 	}
 
-	field = (__force unsigned long __percpu *)((__force void *)p + offset);
+	field = (unsigned long __percpu *)(void __percpu *)(p + offset);
 	this_cpu_inc(*field);
 }
 EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
-- 
2.46.0


