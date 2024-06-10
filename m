Return-Path: <linux-kernel+bounces-208310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCFA902361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CE1282014
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A412F5A3;
	Mon, 10 Jun 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lF1te1Dz"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD177824A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028109; cv=none; b=qD+Tu+Yapb9wmbOQJj0ltU+tc71qb7ZvWan8bqr8EU76O9o05YiYGRXkjRqxsWLBqHfr68yv1HQirrem8t9hJhjWM5vQzgt2CEWabuOyj2h+QMTiRrcc8F5JiKkwVps0UJYBRE12fXmC7ZOUsm9juXpEhAw1hFSCMXP4kSMyy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028109; c=relaxed/simple;
	bh=Z2r4JGubuZTdUYkcXudmGtwYZDpyKW4PXLdrjsGb33s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=atVFPrRLst/GmPGSwdbDZGODzXZHLWmCK5uFO/P9kja4O/S2T9DY/rupc2axblxADuTiBp4yD5Ke2NI9OLk+g8+TI0uYZ8qCfMyfRpIjYMr8ILfU6GvPt9l8fStZ/jnrVlAffD7x5IlzxMa8uf1DVpxpdk+7MjdhZ1whWS2myl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF1te1Dz; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52c89d6b3ebso1019935e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718028105; x=1718632905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1qygvqO2cQy0oabdJmPrTdFKpbyXplDOUqD4kgYMJj0=;
        b=lF1te1Dz4uyzmS2JtsWP/mcnwnIzjvl8KrntdEIgG6qmL2NiOsvuXtjkT/fipdM/56
         THYJbCTVF23rle6lMQxWvCDAPsJ33+m3hTP37ikzmsP7MoFrVrpLWYank2Woff80Wg+r
         /OJ2uvskQzd2ciu6hs7gd8JGljpzgcHMGoNO6P/ezYJOVlWUxx0ixnxoAJrP8wtFdXmj
         7uKVrR2xqPdk0/muqqv2AXaXlCOBeTJVCLhPIotMKAD2qPf/jaQiupIozpSLKSaMh45N
         Kj36OEqMwTey6hnYIRf4Fra82biSjKd+eFDrnlv3jQCgabOW1T08TczPbtSuio2yeYda
         o+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028105; x=1718632905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qygvqO2cQy0oabdJmPrTdFKpbyXplDOUqD4kgYMJj0=;
        b=qHYR14ypm+gTKXVZd0YUHfhCL5pKYYey4GsJ8GBs8sQTjh8ecbmon7/T41IpmaZSIX
         +cJrLHgqlZmoMtAkJJKt1MF07Q5p57E1Zc3deZA3tMTt2P1S8CxmpOM3/AjN95LySzsI
         CeTmG3iltoGz4rYMkvoHAKzju2UiR1UVtF9u1AoQ0h0TYbrAofXRP/W4v6Z28ioDe2qL
         pP26eOn0XZ9kTGgaYXXYWgrclQIQDP+Da+SYAlhU7lLD0bfJEduRJ3eaRYoVUE0VV79X
         2WQ9SDejSrLo27HsV2AbQuZGNY2HzT6mBM3tCWAWtMaDF4KXHXt0T1zXFoU4vtwc1zue
         a1uA==
X-Forwarded-Encrypted: i=1; AJvYcCVGwyRx4MvID/3SVOLbNDCNXzrkCxll1TWphxZ9KeN2uK2wMPIZ5EJTBJEGDHZzBZNkHfIwNq+uP6R8RTSEeKoOqeBeEO1VrCAHtknE
X-Gm-Message-State: AOJu0YziZrewf78cF4cgSUXGZ55Fo/fcKhDVDCbB8oSWEumrS3QqAw3/
	/Twj+jriAnC8bVhK2H4NHZ4VIWIH3dIORxxLaMV4qJ3QUo+lu++ZPrW7BZK1rguXLEJJEs4MhIG
	ON9vPgpMqpNMT3Q==
X-Google-Smtp-Source: AGHT+IE3oyPTDwzBRUl31ISxKFd5SP+5KjGC35K0N8YgEZhRl1PRtia8nuPf234Gj4w9EYUSFy4dsMH58dUYuUc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2585:b0:52b:c144:e468 with SMTP
 id 2adb3069b0e04-52bc144e533mr8081e87.12.1718028104780; Mon, 10 Jun 2024
 07:01:44 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:01:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB8HZ2YC/23MQQ6CMBCF4auQWVvTqbREV9zDsKA4wCTaIS0hG
 tK7W1m7/F/yvh0SRaYEt2qHSBsnllDCnCoY5j5MpPhRGow2tXbaqTX2Ay3CYVUXJLT+qqluEMp hiTTy+8DuXemZ0yrxc9gb/ta/zIZKK2ctOtP40aJvJ5HpSedBXtDlnL++tXQupQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Z2r4JGubuZTdUYkcXudmGtwYZDpyKW4PXLdrjsGb33s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmZwdBku1FOE07yPTtExdpN1rE7NwQnHNcBc5EI
 bh/9uXuo06JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmcHQQAKCRAEWL7uWMY5
 RghED/4rGHdK4QubKiyb+i/JzXCwO9XIfI+7lmns/phyrQIIsRdoEUTUlLePjrnSKkvO6GEbXoh
 Yli9S8zNwM9FWMPrPzYLVji94iqbXPO6yjuFERsOtjBSqDE19koGm9dXWKwZxmWOTaYSIpuTMsi
 6WH9KiQlgVZZe+QGRV6jShoBDE7qxDWTsq+VgPV+xzoGhg064yt+FZwLZvYWOvwVafxyg+g2FGa
 6yMj1dJ76Z3OcAH73zyTUURNghMnDO5w38qZRId7CnwFFGRxUmuHXQvMHdkOZ5N6d+5YN73m0Z7
 fk/POM8pEYaMpv53EqpeJwuXw13+NVM3uQhw42VY8XJqdn7IbMBjsiw6O9fDHwiuPUEiPbiJONC
 UcQV9F7YvKSN6b7L54mNmE6qbqbBR1PaRPOMcJqKS3CjO1BW1lBM5OQrJjXDp0nGOhG49nwq5uM
 xLrjxwrByR157stAxN6o2ds40TPqzcQ5TnC5ek3C+kAvuv64C6Xi1wNE5Nfwi/zwNrBKRugsM9y
 PHDZGH6T/5nBbsG81q/0P7c2Tlq12xKhhWi7dc0jIOKN92lD/YEkT0h/WgaJ/BX4KVzYyoA/JKR
 k55u5mDGlxLzyzXDSgu+x7phpBkFn/QsmqN5Ouz94z/vk+wIVRkFmrM83Xq5ZglvcFGA3K5wRfn BaUqmvDYIrVxckA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240610-tracepoint-v2-0-faebad81b355@google.com>
Subject: [PATCH v2 0/2] Tracepoints and static branch in Rust
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
Changes in v2:
- Call into C code for __DO_TRACE.
- Drop static_call patch, as it is no longer needed.
- Link to v1: https://lore.kernel.org/r/20240606-tracepoint-v1-0-6551627bf51b@google.com

---
Alice Ryhl (2):
      rust: add static_key_false
      rust: add tracepoint support

 include/linux/tracepoint.h      | 18 ++++++++-
 include/trace/define_trace.h    |  7 ++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  2 +
 rust/kernel/static_key.rs       | 87 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/tracepoint.rs       | 47 ++++++++++++++++++++++
 scripts/Makefile.build          |  2 +-
 7 files changed, 162 insertions(+), 2 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


