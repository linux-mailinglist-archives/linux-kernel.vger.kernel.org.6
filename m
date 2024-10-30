Return-Path: <linux-kernel+bounces-389119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7A9B68D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2062831C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C792144AA;
	Wed, 30 Oct 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBdDCRdX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C2213EDC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304302; cv=none; b=PCrrOYJXiZxRirXCTOXEE8OvkZLRkLLonwcy4c2WDHbeD3OxUv65BdtFkWbe0Haz/J/KBcun5GRHuiFkP1XAbK7eO15PoTkw0Yr1MQYNG4dHnX6TNgMdwkxmGb6IIeDipkCoiSom4YbHmdi+rUB7zL4pmM7hMcXeeibkrJFAbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304302; c=relaxed/simple;
	bh=XID7x+7coWgnGBd5wIl/yqAS/1AzuHdHb0QK8txVMPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lcamGoqhbYpycLejBPX0gH5ujEipiPGbvrJpwvLcljfs9Se9PhPCMW/iP74R6l+oI3R6VWBWbRouI7nJacHvkdOqKgM4GOmkeoQeFGtRDKHRPqzIIMlPqDVXQyi8CSAYTVN0hQrxfjU031GfLJrALdzHFkCKKTTVDHMbLDaYjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBdDCRdX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so48859185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730304297; x=1730909097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ5bBsDzzqub9ZaWqauRG4tAucTaa9wcfj1E33xP3xc=;
        b=cBdDCRdXZxHP8hRCvT71eaRnlgkNgevqUA/Mf26Y68AaLnIGuslkR9rabnvQQzr5Y4
         SA9XWwtaXAc/ARVQ6d7I4xbXuQ1okAeormt0/ysJyZd+cr+C1ChHwg4qEzWnNKxh/v19
         nfRp2umk9K9b6lTVWP3BZjL7Oz+zkFtvlvv62D+FRw8cWZPTcNEUeflx3mOscNlKXi6o
         aIkH6bcO7PgEThnbToQvBRijBaKtXDlhfWn+cUbr7k1FpDWfbvSIQvLJ8o3bfVvDkNr4
         VZu0cFUStb7PkdDnxBaa9fS0sDbDTpPRF6PkZfhxxe7lWShL9PDQRAFgZxYHH7LwVsyR
         g/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304297; x=1730909097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ5bBsDzzqub9ZaWqauRG4tAucTaa9wcfj1E33xP3xc=;
        b=j3xr9tJBMftSOf1kHt6AyXXRYxrODVBTN1ez+EXeTflPdPf0Z4GCzH91f2NjKxHpbA
         0VrphDdozYswvbUiALcBYXbByrRfIGnBWTXCXvZ7m2wbmLn1JAVGh0zU1rfgVG0Vy3Bx
         Ekf8vLOmlc5vm9vd/AQM13dW8EZc0Mq+sLEC3ST4CK4J5fSPF+uR8eJSWY5pOU+mL2TQ
         1LoZ/8I/zeRuX2omuuAFg82tohi4mKJGQ2Nzjuxv+Jjt1vkEwpd1mDp5uMO7xUt3JyjT
         uvaCjhuIsamKhavfvixueCvpHt6hJir0HtSNijsMZoO7odTCxIWV53Jn1IjjlWNjMiMC
         lIEA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sNLYgDn8DLCmMHO8IzRDj9kPSkKAEGeE58JAdR2wPZSoI10yAlp9nORk0xels+1ZoHjYK2CViQIg1Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ccuacpVv0tlto3mVtxEhWLS3kzdPd9TrpAjQt1deh8NoANs3
	kH5m5S2hG5A2vAoZUphTg3UJ/qCbYpJ0rJMfYPPOLgDXOYEubazgKiLuPRRuhqnZWm1U38VEJR6
	ZIYanGhB7En26TA==
X-Google-Smtp-Source: AGHT+IFVYJyJpHqXosREWKNk401dPodMtz/gzxt4mu2tfZOK6kHkRJP3u08JeJC4s0ELkJy7XaI8OGX/S3j3MuY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:6a99:b0:431:4509:696a with SMTP
 id 5b1f17b1804b1-4327b6f8619mr645e9.2.1730304297194; Wed, 30 Oct 2024
 09:04:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:04:24 +0000
In-Reply-To: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XID7x+7coWgnGBd5wIl/yqAS/1AzuHdHb0QK8txVMPI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnIlkhPSPbRePqgmcZkeV4PnRFaF06ORWPyb4Hd
 ZssKOLJjQqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZyJZIQAKCRAEWL7uWMY5
 RqSUD/9jfyehgB5qzKfR0aAlCXJYAKb9ZzLWaNn1EmqHjp8saPikwqUESI5omMnEt6W8h+4ok42
 pV4kX4p2S2qQqcKff9S5dttdXhdH2JZOmIXfwdu5yXJPN7oj5BpzCol3VvJux1Nx3JaScViKnG4
 4e0udKPwtlAyubQDD/+0Uk/9ayGweHYNvknT+8hoyjxsNDfCl5mTdR5pa3yXcSQMfXN4Ck+MOQh
 VD91Vo5mSBpn2DItkLSUPSKgIP9aK7q4yXIaKLf9WgPwcsdzNxuJ/Ak1+IWPdqzEjp0hiq67KkE
 hmiSAknb+A1aOfNv9gGpdRM+AuuoXsLOnhD5/yv+0utf5lP32ktyNBPq4IoJMANrT0kqkJ+nAIu
 gs5Eut6gmmuj9FgL+wjElrMboABY6QE/SENYeDZe4xLaDnxQKSqfvem36mOcMTP7j/02/GHoSYB
 RyLsXv/rPzX0s467Y++J+vePxJuIrQFgS8PVcnA/8dnKfeoU+kE4buLiFk6G/HoS4dxGyqiYbF3
 HMltLodkWAYZfs+nfTY3uUa5C7nDIZ+/QXJMyQ2VmpXgulpY7tPclpC1MxbFNAiPxW9jO1qVqOS
 GF2ERKm5fU5AwBn6KmQYgLsii6hIO/c+lfx1ndbl1K1zCZ0cC906aD5HA9HZrjMJ1EsMzzSVauC RVr59LvwW7YPQNA==
X-Mailer: b4 0.13.0
Message-ID: <20241030-tracepoint-v12-1-eec7f0f8ad22@google.com>
Subject: [PATCH v12 1/5] rust: add static_branch_unlikely for static_key_false
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
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add just enough support for static key so that we can use it from
tracepoints. Tracepoints rely on `static_branch_unlikely` with a `struct
static_key_false`, so we add the same functionality to Rust.

This patch only provides a generic implementation without code patching
(matching the one used when CONFIG_JUMP_LABEL is disabled). Later
patches add support for inline asm implementations that use runtime
patching.

When CONFIG_JUMP_LABEL is unset, `static_key_count` is a static inline
function, so a Rust helper is defined for `static_key_count` in this
case. If Rust is compiled with LTO, this call should get inlined. The
helper can be eliminated once we have the necessary inline asm to make
atomic operations from Rust.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  1 +
 rust/helpers/jump_label.c       | 14 ++++++++++++++
 rust/kernel/jump_label.rs       | 30 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 47 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..e0846e7e93e6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,7 @@
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
+#include <linux/jump_label.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..17e1b60d178f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "jump_label.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/jump_label.c b/rust/helpers/jump_label.c
new file mode 100644
index 000000000000..fc1f1e0df08e
--- /dev/null
+++ b/rust/helpers/jump_label.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2024 Google LLC.
+ */
+
+#include <linux/jump_label.h>
+
+#ifndef CONFIG_JUMP_LABEL
+int rust_helper_static_key_count(struct static_key *key)
+{
+	return static_key_count(key);
+}
+#endif
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
new file mode 100644
index 000000000000..4b7655b2a022
--- /dev/null
+++ b/rust/kernel/jump_label.rs
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for static keys.
+//!
+//! C header: [`include/linux/jump_label.h`](srctree/include/linux/jump_label.h).
+
+/// Branch based on a static key.
+///
+/// Takes three arguments:
+///
+/// * `key` - the path to the static variable containing the `static_key`.
+/// * `keytyp` - the type of `key`.
+/// * `field` - the name of the field of `key` that contains the `static_key`.
+///
+/// # Safety
+///
+/// The macro must be used with a real static key defined by C.
+#[macro_export]
+macro_rules! static_branch_unlikely {
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
+        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
+        let _key: *const $crate::bindings::static_key = _key.cast();
+
+        $crate::bindings::static_key_count(_key.cast_mut()) > 0
+    }};
+}
+pub use static_branch_unlikely;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48..708ff817ccc3 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod firmware;
 pub mod init;
 pub mod ioctl;
+pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;

-- 
2.47.0.163.g1226f6d8fa-goog


