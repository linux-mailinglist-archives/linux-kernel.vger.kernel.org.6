Return-Path: <linux-kernel+bounces-365862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE099EC77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF561C232DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41F1D515B;
	Tue, 15 Oct 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFC54ksT"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642151D5144
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998127; cv=none; b=hK3wNrNCAkUm8+yJ7gm2Vy8yb+1OY2Yl4iwalexa7M+zexzcYbw96aAwJugZN0umYLb/p9AeqUpG6IKzUo0SY4xf8Kp6om0R15LDXJGPMrUXYg8/tNGt0d1GS2rLKPN+aaB2/+JsVP+8jCymZPRh4zCc6IkTxJy9aPqUu+D1rqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998127; c=relaxed/simple;
	bh=rrhBrBc+qvOCCcPqzb2+wUP0QjsBHHS8osxeBJXVnA8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FONP/AVH6PSlb4e2tTqdkNlEshwLtkWdDWCZ4S0wvP/jDQOFUd4Qs3BZrNfrIAugy0r7Pnr/P7Karo7MrLYvm/J046G/+cJrMRAQaz5LNT0KgakCCoAJI3cK1FJwJj/Dww+n1/AsB7GrraOYZJ1Uy6CfaB286hsVNmVkUXIqC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFC54ksT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d563a1af4so1483136f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728998124; x=1729602924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hoRLJEvz7irCXQivoQ+pb+FwvQNe9+OAJ0vzs/OATXM=;
        b=ZFC54ksTUFlewIYaFMVyrhOCRGTFrBplAPkyDaGehmETRf7nqgKGnMZf/caEfpkbYg
         nzRTK+Y57eB9nH6U9g3VnakSyBXrnjjfzoM7MW06OV+UFKRjR/Eye2pxlviSUI8vuvW5
         kx3QyWjbADYOEu6//CfvfU8ReCccxg95/idktLlrfIN0iHgASjMoW2AMp460cTM+I0dr
         VbvYFKirY2mMAD2WIBeuf/vOICyhcPBpNUzkmfxnUZhY9ptnv6WMO3Z3vPd6z6v+dNYl
         rML8LXPQbEzZ011IC7kB79p1ar+E2KvMbX3VHZQQzf4DO8SL/qUOJk50FUGcku/5hUTc
         bgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998124; x=1729602924;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoRLJEvz7irCXQivoQ+pb+FwvQNe9+OAJ0vzs/OATXM=;
        b=oqb/J+PHBr0fX0xj8jljZsdoezcBlfNLfPjYzLjoClCG5GCKnzZIAyEFTsHaXt/i1z
         TexNBPUTRBHSpLWjUqenXuRnP8HSvC/9e+3sLk/BAm7PjxMnrFHyiqdLHcJTrdO6gS1x
         G11+4BSbhsw3nGV2APEwsrNbdeKhWNZxX8UbQMz2/Ovzk0sh4L5GwT8WS/Qo+sXFyODC
         9eScNXxy55Tog3KV4uqEN/gXYB6OFD/LMvHLAvMxw/BfMxUnqZmAFHGIgD51svQz65Nq
         uiqV6nUs/WCQSm716jtht8g6APXzu1gtcjsxtFGRkthEVbzNHvrCaO+uNDrAk8GEFh2E
         P5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/NmWRp6WH7kBOLYqIuEW8Zrxm7LPZ9Ib0evPKKpw3NN+v1II0BuwVOTuNZbXnJXrPbxeswMVrxCz2nZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5upOvADG+ar4jWR0TYwVh7Zh4V3ub5rSLpTEmqx4p7gH+OKa
	Exp2QfSCgd70pGPQfdM26cMF33cuNDI10E8Gjsm0hiAuKa7z9d95n9+K7BBNOmLJknKlAvnqgZR
	KvLxbl1YPvFpSwQ==
X-Google-Smtp-Source: AGHT+IGB+6IhvdLWc6tPWiAp1cZCw12Xh9NGDAKDDG+YlQKWgCSiO9km/Ea5ijizW73RyBbMT/bf9K6yb/iXiWo=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:adf:ef52:0:b0:37d:4e56:9a42 with SMTP id
 ffacd0b85a97d-37d86bb88c3mr103f8f.4.1728998123431; Tue, 15 Oct 2024 06:15:23
 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:14:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM9qDmcC/23RzW7DIAwH8FepOC+TzTc97T2mHSCYFmlrqqSKN
 lV995EcNhA92tLvj23ubKE508KOhzubac1Lni6lQHw5sPHsLycaciwNxoFL0KCH2+xHuk75chs
 EEqrggKRBVsB1ppS/97T3j1Kf83Kb5p89fMWt+zRmxQEGrRRqbkJSGN5O03T6pNdx+mJbzsori
 9BYXmzyFHy0GIRSnRWV5dhYUawjKYnI82B7K2trGyuLFUpExYV3I/ZW/VsLvLFqn9mjltLJOPb
 76tq27+piPRfJAiRE6zprKovtnU2xUYMLDnWw2FtbWd7ObLeZYVTWOdIpis66P4sA7Z1dseijC CYa65/si1BhbHH5bxhMCpFk1EHx9tKPx+MX1WiDcMQCAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5896; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rrhBrBc+qvOCCcPqzb2+wUP0QjsBHHS8osxeBJXVnA8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDmrTDvc9AHxNexAsNlXKCw6r9RsObABOQs0Yu
 0na8cLKMsGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw5q0wAKCRAEWL7uWMY5
 Ril4EACEEPWIsnxWUmp0EulhBZxkpCfaANF/knPC098SJ1716PZ2nxf9BGUe5QuWeDFtEGHmtW0
 4KpMKAuId6o2ya+/wIN8Su9bPFEA92WH0OPa73srl31I8cAj/xt1rQ3VAEJrYtaffdHDmbFIfUm
 gF1r5a07aJ3t9dVW+EgVv+sLVzP2eAzB2hMeG6d3Sn8x0agjTjddaHGFyy2pobdFfPbADxHqyeW
 DduR8eX8D1iH/oM5o5D7krrgURZEzjR0kUtgoL0NSAdonx1aQsoU1vOGKNR5ux9z3OTfvTPSCT8
 IBgI0ItSSw/DdLJ8DzbRK+LX2zDI1DEv032C4luAm3i9X9qtqiv10fhzDAQGx4A1vIEOlSL0bSx
 7roGpbCf5yJA2BIJOgUGNDCnKUCaM6rHGaV7bYjP+V5P7AEmZ0+VMkS9JKSWWcz2D2k+WtPtv62
 VcUOXVPjjA2Y0A081Iv72HF2l4nFPXY4212q5EDcNyRK5Gf4QC2eDZ8l/noTer4Y8WPkUu9W7Is
 ngRLQFngXoWv8KlwSb2h4IEYJtrYmSf0XQRh6l3gTC+9cxTgGsqq4pD6qlGY7erJ++UxVQUYKLW
 YQroPanOFPJzBxGOGRvbn6Zuh7ze67log3wsSPtXihtxF+xok/mAobTsrPl/wYeMzbOy1A+AR2M kaHTj0sqJaMTIJA==
X-Mailer: b4 0.13.0
Message-ID: <20241015-tracepoint-v11-0-cceb65820089@google.com>
Subject: [PATCH v11 0/5] Tracepoints and static branch in Rust
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

An important part of a production ready Linux kernel driver is
tracepoints. So to write production ready Linux kernel drivers in Rust,
we must be able to call tracepoints from Rust code. This patch series
adds support for calling tracepoints declared in C from Rust.

This series includes a patch that adds a user of tracepoits to the
rust_print sample. Please see that sample for details on what is needed
to use this feature in Rust code.

This is intended for use in the Rust Binder driver, which was originally
sent as an RFC [1]. The RFC did not include tracepoint support, but you
can see how it will be used in Rust Binder at [2]. The author has
verified that the tracepoint support works on Android devices.

This implementation implements support for static keys in Rust so that
the actual static branch happens in the Rust object file. However, the
__DO_TRACE body remains in C code. See v1 for an implementation where
__DO_TRACE is also implemented in Rust.

Based on top of commit eb887c4567d1 ("tracing: Use atomic64_inc_return()
in trace_clock_counter()") from trace/for-next, which is in turn based
on top of v6.12-rc2.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v11:
- Fix build failure with CONFIG_JUMP_LABEL disabled.
- Remove CONFIG_HAVE_JUMP_LABEL_HACK duplication.
- Remove explicit export of rust_helper_static_key_count.
- Add Gary's Reviewed-by to first patch.
- Link to v10: https://lore.kernel.org/r/20241011-tracepoint-v10-0-7fbde4d6b525@google.com

Changes in v10:
- Rebase on trace/for-next.
- Use static_branch_unlikely as of [PATCH] tracepoints: Use new static branch API.
- Update second patch as of [PATCH] tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL.
- Link to v9: https://lore.kernel.org/r/20241001-tracepoint-v9-0-1ad3b7d78acb@google.com

Changes in v9:
- Rebase on v6.12-rc1.
- Add some Reviewed-by tags from Boqun.
- Link to v8: https://lore.kernel.org/r/20240822-tracepoint-v8-0-f0c5899e6fd3@google.com

Changes in v8:
- Use OBJTREE instead of SRCTREE for temporary asm file.
- Adjust comments on `asm!` wrapper to be less confusing.
- Include resolution of conflict with helpers splitting.
- Link to v7: https://lore.kernel.org/r/20240816-tracepoint-v7-0-d609b916b819@google.com

Changes in v7:
- Fix spurious file included in first patch.
- Fix issue with riscv asm.
- Fix tags on fourth patch to match fifth patch.
- Add Reviewed-by/Acked-by tags where appropriate.
- Link to v6: https://lore.kernel.org/r/20240808-tracepoint-v6-0-a23f800f1189@google.com

Changes in v6:
- Add support for !CONFIG_JUMP_LABEL.
- Add tracepoint to rust_print sample.
- Deduplicate inline asm.
- Require unsafe inside `declare_trace!`.
- Fix bug on x86 due to use of intel syntax.
- Link to v5: https://lore.kernel.org/r/20240802-tracepoint-v5-0-faa164494dcb@google.com

Changes in v5:
- Update first patch regarding inline asm duplication.
- Add __rust_do_trace helper to support conditions.
- Rename DEFINE_RUST_DO_TRACE_REAL to __DEFINE_RUST_DO_TRACE.
- Get rid of glob-import in tracepoint macro.
- Address safety requirements on tracepoints in docs.
- Link to v4: https://lore.kernel.org/rust-for-linux/20240628-tracepoint-v4-0-353d523a9c15@google.com

Changes in v4:
- Move arch-specific code into rust/kernel/arch.
- Restore DEFINE_RUST_DO_TRACE at end of define_trace.h
- Link to v3: https://lore.kernel.org/r/20240621-tracepoint-v3-0-9e44eeea2b85@google.com

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
Alice Ryhl (5):
      rust: add static_branch_unlikely for static_key_false
      rust: add tracepoint support
      rust: samples: add tracepoint to Rust sample
      jump_label: adjust inline asm to be consistent
      rust: add arch_static_branch

 MAINTAINERS                             |  1 +
 arch/arm/include/asm/jump_label.h       | 14 ++++---
 arch/arm64/include/asm/jump_label.h     | 20 +++++----
 arch/loongarch/include/asm/jump_label.h | 16 ++++---
 arch/riscv/include/asm/jump_label.h     | 50 ++++++++++++----------
 arch/x86/include/asm/jump_label.h       | 35 ++++++----------
 include/linux/tracepoint.h              | 28 ++++++++++++-
 include/trace/define_trace.h            | 12 ++++++
 include/trace/events/rust_sample.h      | 31 ++++++++++++++
 rust/Makefile                           |  6 +++
 rust/bindings/bindings_helper.h         |  3 ++
 rust/helpers/helpers.c                  |  1 +
 rust/helpers/jump_label.c               | 14 +++++++
 rust/kernel/.gitignore                  |  3 ++
 rust/kernel/arch_static_branch_asm.rs.S |  7 ++++
 rust/kernel/jump_label.rs               | 74 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                      | 37 +++++++++++++++++
 rust/kernel/tracepoint.rs               | 49 ++++++++++++++++++++++
 samples/rust/Makefile                   |  3 +-
 samples/rust/rust_print.rs              | 18 ++++++++
 samples/rust/rust_print_events.c        |  8 ++++
 scripts/Makefile.build                  |  9 +++-
 22 files changed, 374 insertions(+), 65 deletions(-)
---
base-commit: eb887c4567d1b0e7684c026fe7df44afa96589e6
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


