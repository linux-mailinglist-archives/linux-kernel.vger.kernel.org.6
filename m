Return-Path: <linux-kernel+bounces-389120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46D9B68D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15BBEB22457
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F821443D;
	Wed, 30 Oct 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXyA4rLi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F7214402
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304303; cv=none; b=hm6GqZXSpmUrKPrtFOKDzXXKnLAnvk2Iq/SO+7MysxFFim3FxZa8apmcILkwbkO+c+Me35BJ68IxQ5SxXYQ4e4aWtIQCjZKzJdf7yHKz6cWrxafJyTZGLl+skAeXQZvl2lQ95cEGxhT0O3sapNgQekoF6tF6kMbrnz3ullomT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304303; c=relaxed/simple;
	bh=7megp7qpFwj2d67QvZOgzlG5lXxVSDo6vxXF2gHW/aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=upWJF4GybH64lMRCoe2m9Z8KbreMPozQQgTaHATJjBlceS1suuWIaW3UJrmrDWrm71pcAcdehNZX3fpIl3rUSv/kxqF/iOeFPhffEFVAVcX1MrUbCidedBY93wbGUqLb0fUrz46M923JbgxNutlE2sBiENqbz8UzRHvaHkpQpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXyA4rLi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so127064457b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730304300; x=1730909100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfKLqMwW2mmYwxXsPR323ofDuLblSEcxc3pN1/E4KgU=;
        b=VXyA4rLie/nq/cDL2oAkxp4iBtcHbddf1mDmVcugjLqa72+gWNhuxB/8q7mQoUoXeX
         Yyh1pe9pPuqlBJ8HMpHVT66h3xymFTY1Y7KTYaYnrR4l13zHz9nJQb86EPY2/piqPpcM
         1SKTbDmNGh/Bq9MCUkiVv4YRZ5Sk9TAcJtVecQfyuwfCiE0QvcCAeyqG8aXpnykZovaZ
         JlIw4ZLJUCmw2cYqKQhuxB6jD95CV8HyVHPPK1eU/63YLBOa5qxdY3hjOMjsbVqiQ4Dn
         liaFqovm45/X51mAbe7hmMRak37Cvxp8KpF3jotIm+MDsS9nRkBPBhQtFGvy+aAqYHJ/
         Dg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304300; x=1730909100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfKLqMwW2mmYwxXsPR323ofDuLblSEcxc3pN1/E4KgU=;
        b=YTfS48FZ3OXCNPMvYwHiQIg2kejbEpMK8IbMUKht0OcMWvG8A2VUoU/v8pHAk0jMJK
         F+0/LO4s3BHSgkRoLWCQdhLa61HsDc4f0bxJkP0qTVkmHh1tLW1qE0w8/dI1dHzeZ3+/
         g0eSNvRKGY4DI9XyfqvOJzykBRW3Sfm8aFywCDt/DrA/lzGfogwR8KbWmg9RcpaerFiL
         soUXGQqI5K52TXJUYOGxDRVs/NNTJrc9fpfeQgoMzu9LZFixm4XZY0Tg5uGEA/Cl27dV
         l0heYauV+Wnf2Vp6I7r95XSXAaLUQ4Wrdpaqc9osUiTFiT4arWdoqkJefu0/gAKfyvvF
         8PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhBQOJ8C47GereC/0AhMMkFoZRO9psv7JTHxP/S8TYSkwRjgn9Zxo8Li/UBl9/wtw5onumP/bwi1Doio0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVj7wROp7x0lxqlV6wLl1ojgqVLpY3kXJ7ao+Y+Vvvp4Lyxtx
	gnv0Zf0nsm2u03sKdQ7XvC9J47kmjks88Js0+LmpNrTpS9yk86WzQOzsyGbV+gt+jFiiaYuybo6
	dHQPeR7wlAMD6AA==
X-Google-Smtp-Source: AGHT+IE5NJJ4RdK4KlubbNmWyDqdAz8dOCEwpQRHV+yTd+D1PrNhQg4C5iPY+ZfTTSN1uOUaaXXUzkM/8COhXTM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:3346:b0:6e3:cb96:f577 with SMTP
 id 00721157ae682-6e9d8ba6bd1mr12229487b3.8.1730304299692; Wed, 30 Oct 2024
 09:04:59 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:25 +0000
In-Reply-To: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7831; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7megp7qpFwj2d67QvZOgzlG5lXxVSDo6vxXF2gHW/aA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnIlkhVNvtEovD+MGZCJxXXKKvp3nFPpUZr7FiV
 lKRDqa90P2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZyJZIQAKCRAEWL7uWMY5
 RllJEACw9+sb/u2gZcS8irGwia+aClYAmOnQq5I0nZUxrWli5nGm22r4jxHyUqgfe65+CfcspQR
 z8BE3C5rmYa6bc47VChBgpExV98+Dk4qVlREciDdlY6buZjaLOH/L5K+OKQIXTMy1adbJnczeq6
 ZuKrVfXBPW1Ycl9/25rtjVmaaLGZnGnj2HX+2gNFqnMBZLr/bfQ2xEYsPwpWAvm7LKar691neRI
 SneNpcO5YmQREJMa9vPLMCg0NfmvPpqAZc+YserPmkkWcMOg4S5F6o+1OeMwyGzBgEhEdpelpJ2
 LcYGKBvHlW5CmLsKdiXdzVb9WTm+sU6SzGceWH0ubAJbRF0RXku7/4EdBLdkZqPU/vzHjdh/5VA
 b4cePqjzKFgE+J9xjRPoj8s85bWQy+DZnkfXtKyqat7U3nemh51HoaEP0NtI72pLMC7GaVg4loL
 0j6YFaBX1jM3VG2UvErEskKrbqtHu3LuLozpYFNbYsc+QZGp1IlZgLnnOHfKAVfRil9J2FRi8wG
 3oifoWiqVDbjSGCnu98DOeie5yzb1ddv1x8AcgoOHzEzMgU+BczUJE+km0AKkppqzw6JnhwKFP2
 lcbOY/0hQKekXGwHeuzlJ4nu3JrVgjfzHN/dR5s/vIcvQXQhl1e6sGYYb2+A+4YoHDL9VX4nr87 G44dDUGYghc+zWg==
X-Mailer: b4 0.13.0
Message-ID: <20241030-tracepoint-v12-2-eec7f0f8ad22@google.com>
Subject: [PATCH v12 2/5] rust: add tracepoint support
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="utf-8"

Make it possible to have Rust code call into tracepoints defined by C
code. It is still required that the tracepoint is declared in a C
header, and that this header is included in the input to bindgen.

Instead of calling __DO_TRACE directly, the exported rust_do_trace_
function calls an inline helper function. This is because the `cond`
argument does not exist at the callsite of DEFINE_RUST_DO_TRACE.

__DECLARE_TRACE always emits an inline static and an extern declaration
that is only used when CREATE_RUST_TRACE_POINTS is set. These should not
end up in the final binary so it is not a problem that they sometimes
are emitted without a user.

Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/tracepoint.h      | 28 ++++++++++++++++++++++-
 include/trace/define_trace.h    | 12 ++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 49 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0dc67fad706c..84c4924e499f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -225,6 +225,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			preempt_enable_notrace();			\
 	} while (0)
 
+/*
+ * Declare an exported function that Rust code can call to trigger this
+ * tracepoint. This function does not include the static branch; that is done
+ * in Rust to avoid a function call when the tracepoint is disabled.
+ */
+#define DEFINE_RUST_DO_TRACE(name, proto, args)
+#define __DEFINE_RUST_DO_TRACE(name, proto, args)			\
+	notrace void rust_do_trace_##name(proto)			\
+	{								\
+		__rust_do_trace_##name(args);				\
+	}
+
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -240,6 +252,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
+	extern void rust_do_trace_##name(proto);			\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
@@ -271,6 +284,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void __rust_do_trace_##name(proto)		\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			TP_CONDITION(cond), 0);				\
+	}								\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key))	\
@@ -285,6 +304,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)	\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	static inline void __rust_do_trace_##name(proto)		\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			TP_CONDITION(cond), 1);				\
+	}								\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key))	\
@@ -339,7 +364,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
-	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
+	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
+	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
 #define DEFINE_TRACE(name, proto, args)		\
 	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index ff5fa17a6259..0557626b6f6a 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -76,6 +76,13 @@
 #define DECLARE_TRACE(name, proto, args)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
+/* If requested, create helpers for calling these tracepoints from Rust. */
+#ifdef CREATE_RUST_TRACE_POINTS
+#undef DEFINE_RUST_DO_TRACE
+#define DEFINE_RUST_DO_TRACE(name, proto, args)	\
+	__DEFINE_RUST_DO_TRACE(name, PARAMS(proto), PARAMS(args))
+#endif
+
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
 
@@ -134,6 +141,11 @@
 # undef UNDEF_TRACE_INCLUDE_PATH
 #endif
 
+#ifdef CREATE_RUST_TRACE_POINTS
+# undef DEFINE_RUST_DO_TRACE
+# define DEFINE_RUST_DO_TRACE(name, proto, args)
+#endif
+
 /* We may be processing more files */
 #define CREATE_TRACE_POINTS
 
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e0846e7e93e6..752572e638a6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 708ff817ccc3..55f81f49024e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -54,6 +54,7 @@
 pub mod sync;
 pub mod task;
 pub mod time;
+pub mod tracepoint;
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
new file mode 100644
index 000000000000..c6e80aa99e8e
--- /dev/null
+++ b/rust/kernel/tracepoint.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for tracepoints.
+
+/// Declare the Rust entry point for a tracepoint.
+///
+/// This macro generates an unsafe function that calls into C, and its safety requirements will be
+/// whatever the relevant C code requires. To document these safety requirements, you may add
+/// doc-comments when invoking the macro.
+#[macro_export]
+macro_rules! declare_trace {
+    ($($(#[$attr:meta])* $pub:vis unsafe fn $name:ident($($argname:ident : $argtyp:ty),* $(,)?);)*) => {$(
+        $( #[$attr] )*
+        #[inline(always)]
+        $pub unsafe fn $name($($argname : $argtyp),*) {
+            #[cfg(CONFIG_TRACEPOINTS)]
+            {
+                // SAFETY: It's always okay to query the static key for a tracepoint.
+                let should_trace = unsafe {
+                    $crate::macros::paste! {
+                        $crate::jump_label::static_branch_unlikely!(
+                            $crate::bindings::[< __tracepoint_ $name >],
+                            $crate::bindings::tracepoint,
+                            key
+                        )
+                    }
+                };
+
+                if should_trace {
+                    $crate::macros::paste! {
+                        // SAFETY: The caller guarantees that it is okay to call this tracepoint.
+                        unsafe { $crate::bindings::[< rust_do_trace_ $name >]($($argname),*) };
+                    }
+                }
+            }
+
+            #[cfg(not(CONFIG_TRACEPOINTS))]
+            {
+                // If tracepoints are disabled, insert a trivial use of each argument
+                // to avoid unused argument warnings.
+                $( let _unused = $argname; )*
+            }
+        }
+    )*}
+}
+
+pub use declare_trace;

-- 
2.47.0.163.g1226f6d8fa-goog


