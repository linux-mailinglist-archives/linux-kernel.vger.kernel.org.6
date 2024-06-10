Return-Path: <linux-kernel+bounces-208312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD332902363
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1361C2242D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F713E03F;
	Mon, 10 Jun 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umrWojCO"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB113D8BF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028114; cv=none; b=FFOwh0+4wuqexmegPqZGr4j1UrK7Navxsx5SWYF/h49GqNEmEN4ooWSNZK+/8cE0O2teAweDr7lLH2wvo6Wcvauwpg9/IC6PO0J4eNT5b+HUAHbpYm4arI3X862Jh/mjVqcJakoOUCKDdUUywxaM/CeJqPPoprsUiwCc3uv/jjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028114; c=relaxed/simple;
	bh=Cbr/oyqLs30l5kHzPHIKBFw+7ijjcP/soSV8d5bF/6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5+/uzieR9pZDLgd4ISGqgfa14nq/NJo7VrEEN0u3pKrTF9NNqoD+GGq0Hw6gUsqhVcWZdKmGyyDRGqtzEAm+YrFP3luZIHc37mIkwCACV8rX5wffaQ1I44Ph2Yu2ilW25370GLlqPvro2aryzSR7B+Wh/OWryFaNgNYUFlt/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umrWojCO; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2eae2731a15so18898621fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718028111; x=1718632911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHgyDe9OFhKfiKpcPG5odSWdTyuUd8K6Z6ATNBTmhDw=;
        b=umrWojCOZLvj1CmIiRlfeXgyBFWZaZkYQGx5Fl5U25WeqiqXsq6U2+S4xmUTAq6QDN
         2zYwfaBl836JpAHcEe7+ahhnRKqCM9QddBM30bUkZ2zZRge96Pv+gfklhePA6eGs8XFS
         fuHlcDhu68iLkqhFGQjbfZ2li4oYK5XGgMckVBQ/FWE+T4KNKSfP40C7nhMTWMIzg2lp
         6ew5bTWRmIeaFz46b6dGlpf/KirENE0eyW2AKEFEboGT1AzUzB6N4ActZqHBjZUYLjTl
         mVNoRNaFTRD0L9RElLOQGRPdZrNfz7rwzOWnW8InjQY6nbexoQOBVt436X4nIdiQSunx
         hZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028111; x=1718632911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHgyDe9OFhKfiKpcPG5odSWdTyuUd8K6Z6ATNBTmhDw=;
        b=FPNZp877xYA+hOcQ55y7jPWrITVuyNz0gLexeiUQKiI74vBMRV7I7yStd+ZvDMzFI5
         8gCBscth2c1JB9e3lSQogHenb90CghjcAfcndtmOKOD3275C8B46i1lmUjkzgRnV4nnV
         05sKDJrZiNLgMLalLjlLNTxehuDWbfTxeyuG3LBgUAYHqSDCne4arnQNx2v+U/Iza3wX
         K9D2ijr3b5OqdZ+/pQ5IIiJMcDAhzbWxIaBfqJNTM/yp9pUY9qwBOpF2jNBKLl/LhOC+
         ZRXktXi0obrlCxOcGm2vHsJZnyUQTXU8quFdlacdqUIEVerAGn8skCW8yILGPXYkipRp
         4PKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTor7q2dxhrQt6+Ti4KjEyDQQuHj9Uetw+sC6llc/TyRSkMFK4OXcHwrlF0TDrAGHGK+tKyrtXyrM/9idWF90XQTz1WjR7Hz5UyqCF
X-Gm-Message-State: AOJu0YyK4q4wJJ1S3VaPAolH5VrhYLzwahkygh4XDgrxYy7yRgmeadSL
	HxQgAVoplIqQn/V1lrA2uI0gBrwXVakFsG8V36IaKuygDA43j/DH6oZA13fNZ/ZwGgN9Zu85ADJ
	VWEkC93aLbxU2Eg==
X-Google-Smtp-Source: AGHT+IEccQhl85iyAkHm79GW1ZTFlTgN5K/F0xRloYf0k9KFN8QZT/uSMpgILMSEjfT1xaJgdafVpHDBL+WygIg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:2c19:0:b0:2eb:ec37:ad85 with SMTP id
 38308e7fff4ca-2ebec37b072mr18821fa.9.1718028110654; Mon, 10 Jun 2024 07:01:50
 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:01:05 +0000
In-Reply-To: <20240610-tracepoint-v2-0-faebad81b355@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240610-tracepoint-v2-0-faebad81b355@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5679; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Cbr/oyqLs30l5kHzPHIKBFw+7ijjcP/soSV8d5bF/6c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmZwdFyoZES6wUnB8a6HfkMMvV3cAI2deGLmDYw
 YjVBlpZV9SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmcHRQAKCRAEWL7uWMY5
 RgKLD/99q9BaDPXlZi93F4HrhWiyx3jSWWiL3FlVntMFmRjh30wfOBLJwSneVkTvLDr/UONVh6p
 LgRKlhQfXVYFHK3JFfYbEXSonuGFWkaRFPF0A+i3XuYUosnS+LxNcHv0md16126nUtrhtEyMgr4
 1B+m6thCprxdnJU8KofRtFvz2cRAP9Z2KPVorFBL7libs3XRcJfO9HHaYYcqT0hSm/MzLvq9OBt
 AzNIa1ZZD8AvNn+vnKjZr6wvpJmJ5ljiXTUskTc/qQ4eyho0izkoHRMMhqanxI3G8LMNoXmGUB3
 3iP2ZECiFB5tlDP0yKmP6Ee42WcFqrTcVP3y8coiQv9efgKDc9j75g/0F+VXWGSXwpiEA+z5L3h
 WsovfcZE48Wo6Nk0HxaplalVElXl941R/ZDxDrpyru9Gxisty496fmuy2Era2M3EYq9iVeM67zE
 RsEJBkAlP08pvJ27sEtl8PwTOtsZI7Jrq1jsWxICXSw62nG1KAAuIMoRAOGg7hQb6Pjmis9ZOns
 VMtVqXExCcdnki/ribs68aTwAfl6RG4YLLKb6ddtlH9NTvNYVBPZmrJhqFWn8PGZOsQOuU3WrTv
 NeZYWE3flvevie9DeqTfo1zMKwDvi7Mdtrh8IBC6uskew3ZG3LRkYqckoR9zN8WfVcrCT8+HAv2 7lhMJU9ONZeRPxQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240610-tracepoint-v2-2-faebad81b355@google.com>
Subject: [PATCH v2 2/2] rust: add tracepoint support
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Make it possible to have Rust code call into tracepoints defined by C
code. It is still required that the tracepoint is declared in a C
header, and that this header is included in the input to bindgen.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/tracepoint.h      | 18 +++++++++++++++-
 include/trace/define_trace.h    |  7 ++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..d82af4d77c9f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)
 #endif
 
+/*
+ * Declare an exported function that Rust code can call to trigger this
+ * tracepoint. This function does not include the static branch; that is done
+ * in Rust to avoid a function call when the tracepoint is disabled.
+ */
+#define DEFINE_RUST_DO_TRACE(name, proto, args)
+#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)			\
+	notrace void rust_do_trace_##name(proto)			\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			cpu_online(raw_smp_processor_id()), 0);		\
+	}
+
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -253,6 +267,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
+	extern void rust_do_trace_##name(proto);			\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
@@ -337,7 +352,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
-	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
+	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
+	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
 #define DEFINE_TRACE(name, proto, args)		\
 	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..b47cc036acba 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -72,6 +72,13 @@
 #define DECLARE_TRACE(name, proto, args)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
+/* If requested, create helpers for calling these tracepoints from Rust. */
+#ifdef CREATE_RUST_TRACE_POINTS
+#undef DEFINE_RUST_DO_TRACE
+#define DEFINE_RUST_DO_TRACE(name, proto, args)	\
+	DEFINE_RUST_DO_TRACE_REAL(name, PARAMS(proto), PARAMS(args))
+#endif
+
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
 
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..d442f9ccfc2c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a0be9544996d..96f8f11c51f2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod sync;
 pub mod task;
 pub mod time;
+pub mod tracepoint;
 pub mod types;
 pub mod workqueue;
 
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
new file mode 100644
index 000000000000..1005f09e0330
--- /dev/null
+++ b/rust/kernel/tracepoint.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for tracepoints.
+
+/// Declare the Rust entry point for a tracepoint.
+#[macro_export]
+macro_rules! declare_trace {
+    ($($(#[$attr:meta])* $pub:vis fn $name:ident($($argname:ident : $argtyp:ty),* $(,)?);)*) => {$(
+        $( #[$attr] )*
+        #[inline(always)]
+        $pub unsafe fn $name($($argname : $argtyp),*) {
+            #[cfg(CONFIG_TRACEPOINTS)]
+            {
+                use $crate::bindings::*;
+
+                // SAFETY: It's always okay to query the static key for a tracepoint.
+                let should_trace = unsafe {
+                    $crate::macros::paste! {
+                        $crate::static_key::static_key_false!(
+                            [< __tracepoint_ $name >],
+                            $crate::bindings::tracepoint,
+                            key
+                        )
+                    }
+                };
+
+                if should_trace {
+                    $crate::macros::paste! {
+                        // SAFETY: The caller guarantees that it is okay to call this tracepoint.
+                        unsafe { [< rust_do_trace_ $name >]($($argname),*) };
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
2.45.2.505.gda0bf45e8d-goog


