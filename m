Return-Path: <linux-kernel+bounces-275208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898439481D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBAEAB21D42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677A165F19;
	Mon,  5 Aug 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXVrJQHv"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B937165EE7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883239; cv=none; b=ifHbJiBPuRtwVPd7JcthfJq6ku4ANhJhFRrSOj+H6yKwTQIBnDy065qkpw66xaOr4GpX8by+xOuL/7RgDPAcJkAcCJtbgQjpAlzk5f3erSqidqqjqZLy6ZIuNYxkt4Iohknlh1OS/M13K1MVQe8hTsRtWqVkoVRQtDiPQxIsK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883239; c=relaxed/simple;
	bh=/CUHva9R4qh40v4PXGdZpG7qraQNBpsnib80AoLfVts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkIUFM4YroCsW9+TI7AEH0hvYax+ooe4dK62AQxI+u+E/wbX+RmOY/WoQxf/D884dvgp6zqtdmvTpwdWtGGquGIi3xbmTYjbwbTL3VJJTXMjwjHlkzOGIfIg5C7iGgqFklQv6lJ2Y0B76mhAxRjLA/irBDEOvQ4ReoN01UYb8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXVrJQHv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so4129567a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722883236; x=1723488036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvmD+ez0KqmrlVq3MNB02uXxyKID9fWAsFipmCLltBQ=;
        b=UXVrJQHvrX7hy1gtSIHY46Ew8K0GXT3ov5aXtQ/7Rgdq6CkBUxilQBNR4PkEP53t54
         I5joXxfmAO56DWsUXuA6C6T+NA85Nin53I63kKteY/Aw0gWolnIWzX/FlS5sUHEi8SMj
         gD1+9ziBsfVI0VJG02B72Fey8bUZTh9SjSOjMygrJaYo+lBLmYhFKOUd/h7cbvatO/hn
         +Es/PpwVTPHh9veAIW8hHFhqoqkziKafuk+NRnWTc3SGVvXXHDxSFggb6Tyg4UmorwJS
         BYltEZ6iOoRj/MnR0dIVY+tw0IpBKxTgISOOd7o3o9pad0s9WJ/bur2PddVgpgIS2S+b
         TtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883236; x=1723488036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvmD+ez0KqmrlVq3MNB02uXxyKID9fWAsFipmCLltBQ=;
        b=igVKgaAaJeAYjZ+jb3A4uPYXx6Fv2EAhqBDkXhMnBNpHsjRrWsI3zQjqauRknwWDfl
         5mtIP0qWhTIrIC+EbxCCl+7r1V/KTiU3fAz9aUa2ceIayWXC0mKWacP3pW8aB878XEQf
         JrckFhRDueOR5ujBSomZMJkYOEZvgmnsCnlQy+oA2CnbegoeYuNjTD0p8oe7idd1IXpL
         NlfLZsJJXyAgcnUg38QCFUxxW0bv1yEZncAXNFgA7dirJds3/9Q6o6KuI4lt2CviqDQc
         2izUcqBkziNZX4Gb0JAL7VvM5/STwV25e+PB30zhfRKJXe3Dz1fn7mDymdc8osU3VW/o
         NLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCWgSWrZxqUuEMjj84wT2f8/j8lBPrrPkpZ8sueYo5Tcnbv8ah0LELvG06dyZa8R0yawW9r89kGL/W3XMOQblmfrbA/WvlpTjuC1vC
X-Gm-Message-State: AOJu0YyaaXFZQXV9aaftBJUoTxY5vCf2nokq+wcMGbnVKfDNytsAZKdm
	XE5zqHmxJW12lGyW4DffHRnhKs7DeXHP7wsXRXi3YTnnjP7z8tPM
X-Google-Smtp-Source: AGHT+IGT8P8MH8PUrIhAbGQwOI91FhpuTTEeBpD91PRfdIvScb2atdeUvkPb95VBGym8haoLNMyXMg==
X-Received: by 2002:a17:907:c00f:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a7de956af6dmr465965066b.21.1722883236392;
        Mon, 05 Aug 2024 11:40:36 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12ad3sm478517266b.88.2024.08.05.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:40:35 -0700 (PDT)
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
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 2/3] percpu: Assorted fixes found by strict percpu address space checks
Date: Mon,  5 Aug 2024 20:39:00 +0200
Message-ID: <20240805184012.358023-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805184012.358023-1-ubizjak@gmail.com>
References: <20240805184012.358023-1-ubizjak@gmail.com>
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
2.45.2


