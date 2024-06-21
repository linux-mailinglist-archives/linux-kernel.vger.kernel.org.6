Return-Path: <linux-kernel+bounces-224446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E5912281
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CCC1C23C20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695FE17167F;
	Fri, 21 Jun 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U10Mn5DP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801876034
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966135; cv=none; b=KLMVnJEtCyU+zKi0rmoSJb+iB479cvWnD2wN0poLjGAEjoVJbd4lpJ9bR9Aa0gCNSir861AnIMTQ+DoosU+6ZHDkps1GOwCVL+q1YcvUXqB6l+BxKSUc58bGp/MnVRDG05434jVLVDS017VweL7+Fqw2xrk18b+gBZVDpi35PsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966135; c=relaxed/simple;
	bh=3Lw7KdJjlLxunIjzSI5anXQ+XVW7oO6tvpp6EHXDDcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D2+gD6SlHq4fJ24kppS00benOoS1q73/1qT74qylV4vTxaZtxZmPP1hH0qoIZjURdKCTlnhFnu4Uuil4Gz1Q5saG8L4pykzuZQHkOxQU94GCmuZS4i3QmIi8FtaouCdeuDnoSyim+2xexUQcTGI8/Nxj0//9vELxC0wj8ICSK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U10Mn5DP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627f20cff42so31637877b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718966132; x=1719570932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3eABDz1M5CfNPOmLh6hSg0SPvosrOCJFcrFqSGbIDiw=;
        b=U10Mn5DP/knA//qUIxdPEjlg+owwParo2KwSXMZKGG9im7+2K/PE9oee8nqGHp/6Hz
         27yUO5cOLFLcCLu837OgEPv1SSPSWGYAm/Qytw7UmHBgsBg6OSqP70NGseNtBXBBjHzb
         uT5xqmqGLgOOLVtwlM12YLMJOKaKXdVFY7XLn3mHvEQUgKKI8KskiFoXK0r2VBPNceV3
         i57yKgVkwuw8AIU6ixsWuGteC+oLRdzQ+8ya7WlbiLMlKZBNzRogTY0GFMnlo1xvtK2/
         xQGDaHzPq7N5wKDSqPM/R0x6wk07hoguTjP+ekp2KANgGHhD0sAhorTJ3Q53YqEg4gtZ
         h8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966132; x=1719570932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eABDz1M5CfNPOmLh6hSg0SPvosrOCJFcrFqSGbIDiw=;
        b=Z+080MwojeQL4tWGNKmMLPh03w61J6eVo0eaG2/98GHVZwXm2JOEt2WPVfy2AzwK5h
         kY6/VGgNr+2GiXO92pyS82EyJOpaj1l4tUgz4pZhtm4r1fqZDUk4sM9ogVJafTKlmrYT
         LI+5hy3seMDUFt37nAhftSHHxPDjFu+SIikpJD8Ot2XS9/s4ZgnHiTZADCzM9qBRN8XU
         yqPU8OHvX7kJnHEZbEe70m9i+NGv2xl2GkdtH2pGtJPCHeJNx0MdTE0b5oWVm97i5qTY
         Ivy9dvay7qUSbrwO3+3DygtSoAzfX9g8lk6b5p7vXo+7HIfCA5pkCWjX9WUKIZzQzECw
         rMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF8HwvZdc9ze8VznhmixwM6gEXIPImt0d434fPcQQmeZXjeHrKTOYFlZJyc69KeZwWsU5lzccsXkE2bQMJ3dE3iiLEl4Jo62G86Okp
X-Gm-Message-State: AOJu0YyJsa8NY+NEakwpEyXmfw+aQUyfVQ6UCERkOi5SeBhK2emiL9Bt
	YzLqDwRJyLKEGOip3bl3KamhyGFJ4dSFuNXDsmvaQG9I0vV8NiKTnK6c8tzlMBkXaBaWav+1xyb
	mBqlz/O42AnHkLw==
X-Google-Smtp-Source: AGHT+IGgj+LrDRDzSB/jQ/HSB/gzIfKHF378aY4D7NhVMRl0uS5JczfBNVnpd/4RAl+dYYs7Da80IKv0McjFgVE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:18cd:b0:df7:b717:10c2 with SMTP
 id 3f1490d57ef6-e02be0f145dmr1819814276.2.1718966132063; Fri, 21 Jun 2024
 03:35:32 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:35:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG1XdWYC/23MQQ6CMBCF4auYWVvTKbSoK+9hXLQwwCRKSUsaD
 eHuFlaSuHwv+f4ZIgWmCNfDDIESR/ZDHsXxAHVvh44EN3mDkqqURhoxBVvT6HmYRIGE2l0klRV
 CBmOglt9b7P7Iu+c4+fDZ2gnX928moZDCaI1GVa7V6G6d992TTrV/wdpJ6sei3FmVbWvJ2eaMr tB6Z5dl+QKHNDdx4QAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3Lw7KdJjlLxunIjzSI5anXQ+XVW7oO6tvpp6EHXDDcw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmdVdvongHF5FFp5wmjddlI2qC3Ap5SiseOB5gM
 Sk4/3H4CxKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZnVXbwAKCRAEWL7uWMY5
 RpOLEACX9A90/BXzUnKyX5BwP3ZRcJpcLCLaVnC8JiSjYlvMqd35lorsftDj7hPH7jY+ATnpnEi
 24PuJvxNBGkk0rpkbbaRWfjMd4KA10TymYiCVC9y04ik3UmgD1oFibL5GNDlR8bDzm+3ko60Jqb
 o5NFc8bDq6o61K4jGF3uZ/JEzhyAcF+Rf7MwcXa8ZWsSGrqBZQoROA0crek13qaYB811HUD3ATg
 JJ/RZGbFY09jhTw73hlMZkBOvh1rFmW/kkc0C5zZH2d6GfZlWzvDR49d/mrt/1PxuifDWMA7zCs
 T4gSvHRRAoJfyUPCRM0KTGO+1NN80jKQ78tA8ZDwJxJdwki6zClbWrLdLsPwiqMf74GO8iKUlkC
 2oFo4MowrkIyEbZ+dyh6/DApUSTMnc73BXuWywAqj4Tqc+1B6MbNeBPRxwqmOhR1t2SakhXtZFk
 EgnDq2NJZEB6J2Y9G+HcWBkuXIfKA/SW0g7AssYNrhN/wvobPoeGRPIEIPYOB7IVpHtToGpXieI
 utzENuqHKDLsOmZOM2bdgOF7TSRc1s0/wyJvSnGshpqOQhSu4QJim7regTWp6dEvzWy4NxnBh6v
 IyOZb+Um0A7f3V2XVDxLdSITSvtpDYbi/lY5capaomYzFWnQPXkyp1WKC/hQLTGnVAZhJJJb0yB SLnjc6FRSMdG0KQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
Subject: [PATCH v3 0/2] Tracepoints and static branch in Rust
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

An important part of a production ready Linux kernel driver is
tracepoints. So to write production ready Linux kernel drivers in Rust,
we must be able to call tracepoints from Rust code. This patch series
adds support for calling tracepoints declared in C from Rust.

To use the tracepoint support, you must:

1. Declare the tracepoint in a C header file as usual.

2. Add #define CREATE_RUST_TRACE_POINTS next to your
   #define CREATE_TRACE_POINTS.

2. Make sure that the header file is visible to bindgen.

3. Use the declare_trace! macro in your Rust code to generate Rust
   functions that call into the tracepoint.

For example, the kernel has a tracepoint called `sched_kthread_stop`. It
is declared like this:

	TRACE_EVENT(sched_kthread_stop,
		TP_PROTO(struct task_struct *t),
		TP_ARGS(t),
		TP_STRUCT__entry(
			__array(	char,	comm,	TASK_COMM_LEN	)
			__field(	pid_t,	pid			)
		),
		TP_fast_assign(
			memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
			__entry->pid	= t->pid;
		),
		TP_printk("comm=%s pid=%d", __entry->comm, __entry->pid)
	);

To call the above tracepoint from Rust code, you must first ensure that
the Rust helper for the tracepoint is generated. To do this, you would
modify kernel/sched/core.c by adding #define CREATE_RUST_TRACE_POINTS.

Next, you would include include/trace/events/sched.h in
rust/bindings/bindings_helper.h so that the exported C functions are
visible to Rust, and then you would declare the tracepoint in Rust:

	declare_trace! {
	    fn sched_kthread_stop(task: *mut task_struct);
	}

This will define an inline Rust function that checks the static key,
calling into rust_do_trace_##name if the tracepoint is active. Since
these tracepoints often take raw pointers as arguments, it may be
convenient to wrap it in a safe wrapper:

	mod raw {
	    declare_trace! {
	        fn sched_kthread_stop(task: *mut task_struct);
	    }
	}
	
	#[inline]
	pub fn trace_sched_kthread_stop(task: &Task) {
	    // SAFETY: The pointer to `task` is valid.
	    unsafe { raw::sched_kthread_stop(task.as_raw()) }
	}

A future expansion of the tracepoint support could generate these safe
versions automatically, but that is left as future work for now.

This is intended for use in the Rust Binder driver, which was originally
sent as an RFC [1]. The RFC did not include tracepoint support, but you
can see how it will be used in Rust Binder at [2]. The author has
verified that the tracepoint support works on Android devices.

This implementation implements support for static keys in Rust so that
the actual static branch happens in the Rust object file. However, the
__DO_TRACE body remains in C code. See v1 for an implementation where
__DO_TRACE is also implemented in Rust.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Support for Rust static_key on loongarch64 and riscv64.
- Avoid failing compilation on architectures that are missing Rust
  static_key support when the archtectures does not actually use it.
- Link to v2: https://lore.kernel.org/r/20240610-tracepoint-v2-0-faebad81b355@google.com

Changes in v2:
- Call into C code for __DO_TRACE.
- Drop static_call patch, as it is no longer needed.
- Link to v1: https://lore.kernel.org/r/20240606-tracepoint-v1-0-6551627bf51b@google.com

---
Alice Ryhl (2):
      rust: add static_key_false
      rust: add tracepoint support

 include/linux/tracepoint.h      |  18 ++++-
 include/trace/define_trace.h    |   7 ++
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/static_key.rs       | 143 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/tracepoint.rs       |  47 +++++++++++++
 scripts/Makefile.build          |   2 +-
 7 files changed, 218 insertions(+), 2 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


