Return-Path: <linux-kernel+bounces-370979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742C9A3495
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B621C20EED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAE185923;
	Fri, 18 Oct 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSKZILIW"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0B17CA03;
	Fri, 18 Oct 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230722; cv=none; b=KXtCIBbvz5a5YcVfbArUWGP2Ox6jfepaKMV7ZZSBAhodnZ8k4E4yFSnIoLhT9CzzsRGRrj8ST948DgRraOvr8dtppnOcnAsPLsUSNx27zNN+pAweUzcV9S73h7Gmvn0XLZJAcrU2QuzrdVwX1x+nT/z9GfsgfUu8p6mZ3jS418I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230722; c=relaxed/simple;
	bh=sgxh/WHiLpybhwyMhrRAlSI5uIMmb/7HK3IJyI+qd5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzCGBPsUIDvBbIPuHOwQuAel9CEcOUq40huheRvHHvXs9mn+v1GQIJWl8+jEYmHFTnurL7U4ZXKCD02AGHmMirMxiR6CyH2NbnhBcpTr5yrQw1Dzb8akm2T86xqURsLMYuvcxlo8UPGnAK2zk+gynkR5D/pg6AGi0Q6YW1srPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSKZILIW; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609967ab7eso13632321cf.3;
        Thu, 17 Oct 2024 22:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230719; x=1729835519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFPesI8y6EBdRmBeoozqipL4P2PTKsdAJwTlUVr16qI=;
        b=FSKZILIWltP4hqTsKzKbjV1r1gwSITqyttyq3A3vfJ6RVkLclvQMSY67JwLq3SO3Xb
         UHbtnudXOXTBORi0NcpYMUAyMoh7J3eA0gBpm4Pno5N1FlQpOL2b2nQiZK0ypn0G3ahA
         e1pjgM4hQ/Azes09cESth5O43jo8mML+L9zXy9mknm86RP4vH88XjJ2E78cYurd1zAse
         R2rj3+veC/8pVPrCo752xj9hGJPKdcl70i5xLHsmX4P0MVlM+vIL913sT8XhrddQk2jK
         /tgigHtZJ/z36jVu9sX7OHQyiiXdgOSvZn/9wC44W6TCovhK2GovI0LZiYE4JSSbKlmq
         FMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230719; x=1729835519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFPesI8y6EBdRmBeoozqipL4P2PTKsdAJwTlUVr16qI=;
        b=GUQDo7Y7sOLt4ezHvkxV01T7ur3afjGUMhEEznvH/0y8PUUAJnYt5tQg22hwvkCPiQ
         OqqSdTWsEjRqT4RPQwnsHspxiiHfS4HjQjvKtVoV63Y9cxEB1Dg6uTabM+6eqyO1NijS
         DutuJJ0DL6oWXek6dmv39FEPRD+UpGo/L+t0XV0wICT9zTJAKMXUqrnAIIDMElaDEURo
         /V3EVHIrhs1ikWCHIW44Ne+CCE3agzijgbn6nuWzZN7SXkmt/OrZ/uueTSux22fICR9C
         T9p99pmEl2mCbjZ0fapzT8B4wjfoJhmAuL1Q0lLoUSuPtEcmtHDogPaypfUMmJang3YT
         rXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkGKT/gOd6D8dz8rCRXcHHcNfBXJepsMcBdLUSC0v67AFLX/1xFAuF0GrhXyIFIhHYLL3DfaOmRTFjAzo=@vger.kernel.org, AJvYcCVOv2JybUHxIbH5NDiJp+WWbWSQgkPcb4RAZZtDp3IuH/NHzcs8nBSmvStWI6vYmiZeARShn1Pca2QQda3R6Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxts6tCxfaFkeXvoszwGtWWrO9DoYgnLa0hilo8mzWO+hP1apEn
	bRe8AgslGc4KeNnKMB3MQw8+uOAK0bMICiZiaJmVLy4Y0lTJ0DnjQ5FSNw==
X-Google-Smtp-Source: AGHT+IHNqFF39yGW5Isneevii6EHRqn159vrnCCrDQpMh6Ez0SYrHXWlQ5pzlHBj9XglnMdC0ZnZuA==
X-Received: by 2002:ac8:5f89:0:b0:456:8b5e:bcf3 with SMTP id d75a77b69052e-460aee6fa78mr18494111cf.52.1729230719396;
        Thu, 17 Oct 2024 22:51:59 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460aea63322sm3958191cf.95.2024.10.17.22.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:51:59 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 745721200073;
	Fri, 18 Oct 2024 01:51:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Oct 2024 01:51:58 -0400
X-ME-Sender: <xms:fvcRZ8P_vPg1UuXp73lxYi_wNSNN_uDYNBENmexIMXxVbcVW2xiiUw>
    <xme:fvcRZy80_N-LgSCjAP77JR0AI2FLYRQO3jGlMpip6ihGOadWOibY9xcn-natushKB
    Hc9YkonD7gnBvsWLA>
X-ME-Received: <xmr:fvcRZzTK-MmuPzkonJGrTD-ErlwPEH3SJP-Z3AAn1gr1uKbOwpKMPYbvJi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlh
    hinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:fvcRZ0s8bEkanUfa4_on2w55vCxRCVIyc61gzCrmtNr9kLZNnxcYDg>
    <xmx:fvcRZ0fSqFzFd3dYvhmDFyNylc9XdkKU7-U_q7-rAumMgTo9-hLTDA>
    <xmx:fvcRZ43uJw08areeSVMo-7Y47M9bUK1Jpj0xJz9SExDKd8yiA45QEA>
    <xmx:fvcRZ4_R7Bx-pT0HdK0VK94gVJKeZGiiAo9ejsQ0ovLvI1qtcuZVIw>
    <xmx:fvcRZ7-AoE91Mvu8Fg1nhU00mZdc18YcPizvkAk7-lEyD6Ns56R8t6yq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:51:57 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [POC 1/6] irq & spin_lock: Add counted interrupt disabling/enabling
Date: Thu, 17 Oct 2024 22:51:20 -0700
Message-ID: <20241018055125.2784186-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018055125.2784186-1-boqun.feng@gmail.com>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the nested interrupt disabling and enabling is present by
_irqsave() and _irqrestore() APIs, which are relatively unsafe, for
example:

	<interrupts are enabled as beginning>
	spin_lock_irqsave(l1, flag1);
	spin_lock_irqsave(l2, flag2);
	spin_unlock_irqrestore(l1, flags1);
	<l2 is still held but interrupts are enabled>
	// accesses to interrupt-disable protect data will cause races.

This is even easier to triggered with guard facilities:

	unsigned long flag2;

	scoped_guard(spin_lock_irqsave, l1) {
		spin_lock_irqsave(l2, flag2);
	}
	// l2 locked but interrupts are enabled.
	spin_unlock_irqrestore(l2, flag2);

(Hand-to-hand locking critical sections are not uncommon for a
fine-grained lock design)

And because this unsafety, Rust cannot easily wrap the
interrupt-disabling locks in a safe API, which complicates the design.

To resolve this, introduce a new set of interrupt disabling APIs:

*	local_interrupt_disalbe();
*	local_interrupt_enable();

They work like local_irq_save() and local_irq_restore() except that 1)
the outermost local_interrupt_disable() call save the interrupt state
into a percpu variable, so that the outermost local_interrupt_enable()
can restore the state, and 2) a percpu counter is added to record the
nest level of these calls, so that interrupts are not accidentally
enabled inside the outermost critical section.

Also add the corresponding spin_lock primitives: spin_lock_irq_disable()
and spin_unlock_irq_enable(), as a result, code as follow:

	spin_lock_irq_disable(l1);
	spin_lock_irq_disable(l2);
	spin_unlock_irq_enable(l1);
	// Interrupts are still disabled.
	spin_unlock_irq_enable(l2);

doesn't have the issue that interrupts are accidentally enabled.

This also makes the wrapper of interrupt-disabling locks on Rust easier
to design.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/irqflags.h         | 32 +++++++++++++++++++++++++++++++-
 include/linux/irqflags_types.h   |  6 ++++++
 include/linux/spinlock.h         | 13 +++++++++++++
 include/linux/spinlock_api_smp.h | 29 +++++++++++++++++++++++++++++
 include/linux/spinlock_rt.h      | 10 ++++++++++
 kernel/locking/spinlock.c        | 16 ++++++++++++++++
 kernel/softirq.c                 |  3 +++
 7 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5fde53..7840f326514b 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -225,7 +225,6 @@ extern void warn_bogus_irq_restore(void);
 		raw_safe_halt();		\
 	} while (0)
 
-
 #else /* !CONFIG_TRACE_IRQFLAGS */
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
@@ -254,6 +253,37 @@ extern void warn_bogus_irq_restore(void);
 #define irqs_disabled()	raw_irqs_disabled()
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
+DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
+
+static inline void local_interrupt_disable(void)
+{
+	unsigned long flags;
+	long new_count;
+
+	local_irq_save(flags);
+
+	new_count = raw_cpu_inc_return(local_interrupt_disable_state.count);
+
+	if (new_count == 1)
+		raw_cpu_write(local_interrupt_disable_state.flags, flags);
+}
+
+static inline void local_interrupt_enable(void)
+{
+	long new_count;
+
+	new_count = raw_cpu_dec_return(local_interrupt_disable_state.count);
+
+	if (new_count == 0) {
+		unsigned long flags;
+
+		flags = raw_cpu_read(local_interrupt_disable_state.flags);
+		local_irq_restore(flags);
+	} else if (unlikely(new_count < 0)) {
+		/* XXX: BUG() here? */
+	}
+}
+
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
 DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
diff --git a/include/linux/irqflags_types.h b/include/linux/irqflags_types.h
index c13f0d915097..277433f7f53e 100644
--- a/include/linux/irqflags_types.h
+++ b/include/linux/irqflags_types.h
@@ -19,4 +19,10 @@ struct irqtrace_events {
 
 #endif
 
+/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
+struct interrupt_disable_state {
+	unsigned long flags;
+	long count;
+};
+
 #endif /* _LINUX_IRQFLAGS_TYPES_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 63dd8cf3c3c2..c1cbf5d5ebe0 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -272,9 +272,11 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 #endif
 
 #define raw_spin_lock_irq(lock)		_raw_spin_lock_irq(lock)
+#define raw_spin_lock_irq_disable(lock)	_raw_spin_lock_irq_disable(lock)
 #define raw_spin_lock_bh(lock)		_raw_spin_lock_bh(lock)
 #define raw_spin_unlock(lock)		_raw_spin_unlock(lock)
 #define raw_spin_unlock_irq(lock)	_raw_spin_unlock_irq(lock)
+#define raw_spin_unlock_irq_enable(lock)	_raw_spin_unlock_irq_enable(lock)
 
 #define raw_spin_unlock_irqrestore(lock, flags)		\
 	do {							\
@@ -376,6 +378,11 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	raw_spin_lock_irq(&lock->rlock);
 }
 
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+{
+	raw_spin_lock_irq_disable(&lock->rlock);
+}
+
 #define spin_lock_irqsave(lock, flags)				\
 do {								\
 	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
@@ -401,6 +408,12 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 	raw_spin_unlock_irq(&lock->rlock);
 }
 
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+{
+	raw_spin_unlock_irq_enable(&lock->rlock);
+}
+
+
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	raw_spin_unlock_irqrestore(&lock->rlock, flags);
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 89eb6f4c659c..e96482c23044 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -28,6 +28,8 @@ _raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
 void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 								__acquires(lock);
+void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+								__acquires(lock);
 
 unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 								__acquires(lock);
@@ -39,6 +41,7 @@ int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
+void __lockfunc _raw_spin_unlock_irq_enable(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 								__releases(lock);
@@ -55,6 +58,11 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_lock_irq(lock) __raw_spin_lock_irq(lock)
 #endif
 
+/* Use the same config as spin_lock_irq() temporarily. */
+#ifdef CONFIG_INLINE_SPIN_LOCK_IRQ
+#define _raw_spin_lock_irq_disable(lock) __raw_spin_lock_irq_disable(lock)
+#endif
+
 #ifdef CONFIG_INLINE_SPIN_LOCK_IRQSAVE
 #define _raw_spin_lock_irqsave(lock) __raw_spin_lock_irqsave(lock)
 #endif
@@ -79,6 +87,11 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_unlock_irq(lock) __raw_spin_unlock_irq(lock)
 #endif
 
+/* Use the same config as spin_unlock_irq() temporarily. */
+#ifdef CONFIG_INLINE_SPIN_UNLOCK_IRQ
+#define _raw_spin_unlock_irq_enable(lock) __raw_spin_unlock_irq_enable(lock)
+#endif
+
 #ifdef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
 #define _raw_spin_unlock_irqrestore(lock, flags) __raw_spin_unlock_irqrestore(lock, flags)
 #endif
@@ -120,6 +133,14 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
+static inline void __raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	local_interrupt_disable();
+	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
+}
+
 static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
@@ -160,6 +181,14 @@ static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 	preempt_enable();
 }
 
+static inline void __raw_spin_unlock_irq_enable(raw_spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, _RET_IP_);
+	do_raw_spin_unlock(lock);
+	local_interrupt_enable();
+	preempt_enable();
+}
+
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 61c49b16f69a..c05be2cb4564 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -94,6 +94,11 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	rt_spin_lock(lock);
 }
 
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
 #define spin_lock_irqsave(lock, flags)			 \
 	do {						 \
 		typecheck(unsigned long, flags);	 \
@@ -117,6 +122,11 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 	rt_spin_unlock(lock);
 }
 
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 						   unsigned long flags)
 {
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7685defd7c52..a2e01ec4a0c8 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -172,6 +172,14 @@ noinline void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_lock_irq);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
+noinline void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	__raw_spin_lock_irq_disable(lock);
+}
+EXPORT_SYMBOL_GPL(_raw_spin_lock_irq_disable);
+#endif
+
 #ifndef CONFIG_INLINE_SPIN_LOCK_BH
 noinline void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 {
@@ -204,6 +212,14 @@ noinline void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_unlock_irq);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQ
+noinline void __lockfunc _raw_spin_unlock_irq_enable(raw_spinlock_t *lock)
+{
+	__raw_spin_unlock_irq_enable(lock);
+}
+EXPORT_SYMBOL_GPL(_raw_spin_unlock_irq_enable);
+#endif
+
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
 noinline void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index b756d6b3fd09..fcbf700963c4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,6 +88,9 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+DEFINE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
+EXPORT_PER_CPU_SYMBOL_GPL(local_interrupt_disable_state);
+
 /*
  * SOFTIRQ_OFFSET usage:
  *
-- 
2.45.2


