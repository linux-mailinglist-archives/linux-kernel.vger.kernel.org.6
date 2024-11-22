Return-Path: <linux-kernel+bounces-418729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF39D64C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673E0B21A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6621DF96A;
	Fri, 22 Nov 2024 20:10:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB076183CBE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306215; cv=none; b=OGmVmbNIjX3q2nxEOUsy8BhMrDTGUvidho4SSroQdOUl78j78a+F68Pgoef8SC6mOKQgRQX8FxllZc0ZrmIdb2BOkbj4a2dSCAlTZBJ8gGkqrc+JRyNApOEvCsW7FZVkVrIBGY5Vach7SOE/SHIwA8ETpCp/ydmu1Tmp9gmwQT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306215; c=relaxed/simple;
	bh=wRfiaTuptdtOXSaYDnvVNW+BWBMtgQwMbdAu/s66aZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FnztUY3eIxNx9U/G25VKsMEBe+2a5qorib88qPCU8fy8C22KKXL9+pKTGIiGTo3UWuuAZ3WXnLQop4lmZr5MCTp4hVRk9CZDJqSjm0hBflex0CzPkjCvfINNw3xOoYJ63fhUmXFuFa5aMdkR0L6rhoDD6Fop4LWIc6bj3VWbBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B629C4CECE;
	Fri, 22 Nov 2024 20:10:14 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:10:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Subject: [GIT PULL] tracing: Add Rust support to trace events for v6.13
Message-ID: <20241122151054.7e60cbb9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Add Rust support for trace events:

- Allow Rust code to have trace events

  Trace events is a popular way to debug what is happening inside the kernel
  or just to find out what is happening. Rust code is being added to the
  Linux kernel but it currently does not support the tracing infrastructure.
  Add support of trace events inside Rust code.

[
   Note, this code and the diffstat are dependent on the trace topic branch
   getting pulled in first:

     https://lore.kernel.org/all/20241120214531.45d75a60@gandalf.local.home/

   This work was started on that branch to avoid conflicts. But they have
   since split, where the trace branch has code that is not in this branch.
]

Please pull the latest trace-rust-v6.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-rust-v6.13

Tag SHA1: 054686ef1afc70c0676fe2d2594cf4dd63923719
Head SHA1: 8af7a50167833b6b22e30c008bbf95ab3ff1a5fb


Alice Ryhl (6):
      rust: add static_branch_unlikely for static_key_false
      rust: add tracepoint support
      rust: samples: add tracepoint to Rust sample
      jump_label: adjust inline asm to be consistent
      rust: add arch_static_branch
      jump_label: rust: pass a mut ptr to `static_key_count`

Miguel Ojeda (2):
      samples: rust: fix `rust_print` build making it a combined module
      rust: jump_label: skip formatting generated file

----
 MAINTAINERS                                        |  1 +
 arch/arm/include/asm/jump_label.h                  | 14 ++--
 arch/arm64/include/asm/jump_label.h                | 20 ++++--
 arch/loongarch/include/asm/jump_label.h            | 16 +++--
 arch/riscv/include/asm/jump_label.h                | 50 ++++++++-------
 arch/x86/include/asm/jump_label.h                  | 35 ++++------
 include/linux/tracepoint.h                         | 28 +++++++-
 include/trace/define_trace.h                       | 12 ++++
 include/trace/events/rust_sample.h                 | 31 +++++++++
 rust/Makefile                                      |  6 ++
 rust/bindings/bindings_helper.h                    |  3 +
 rust/helpers/helpers.c                             |  1 +
 rust/helpers/jump_label.c                          | 14 ++++
 rust/kernel/.gitignore                             |  3 +
 rust/kernel/generated_arch_static_branch_asm.rs.S  |  7 ++
 rust/kernel/jump_label.rs                          | 74 ++++++++++++++++++++++
 rust/kernel/lib.rs                                 | 37 +++++++++++
 rust/kernel/tracepoint.rs                          | 49 ++++++++++++++
 samples/rust/Makefile                              |  3 +
 samples/rust/rust_print_events.c                   |  8 +++
 samples/rust/{rust_print.rs => rust_print_main.rs} | 18 ++++++
 scripts/Makefile.build                             |  9 ++-
 22 files changed, 375 insertions(+), 64 deletions(-)
 create mode 100644 include/trace/events/rust_sample.h
 create mode 100644 rust/helpers/jump_label.c
 create mode 100644 rust/kernel/.gitignore
 create mode 100644 rust/kernel/generated_arch_static_branch_asm.rs.S
 create mode 100644 rust/kernel/jump_label.rs
 create mode 100644 rust/kernel/tracepoint.rs
 create mode 100644 samples/rust/rust_print_events.c
 rename samples/rust/{rust_print.rs => rust_print_main.rs} (85%)
---------------------------

