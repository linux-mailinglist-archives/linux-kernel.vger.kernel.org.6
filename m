Return-Path: <linux-kernel+bounces-396572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265329BCEFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584461C21B34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FE1D9A76;
	Tue,  5 Nov 2024 14:19:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D71D9A5D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816347; cv=none; b=q6mbwGcSMBreaOPvDQj2M4B9LBoKRxTxj7TxnDh1KRBtsom0YiHNAWYtwQLsBIDfxVstNt6gYXQt5czalY8cXJGeHxqdmBrJMOt2ppk2U968zMdnNJgT3IsMMZ9KwD1M7ppZiYzUXmgj1g/OWUnWQ7oeqHdHuP/tuoRessuoFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816347; c=relaxed/simple;
	bh=ACVEjkmkBoxN7z2/h75UB1/XLKq2cAQVWj9edkewhzc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=M932QLhMqF+4FeFOGVHhLtFqe3Uz0pOHYNoX0+Fh9bsxk0/1OJABKYAEITjDPCCYOA+DzDluFDnjgJVwitq/5L/rN97fpIM04IzZpWqoS0CYu9DoP+xi7a0svcb9rG8wlvautfIAuHd+jAuldRprHflrLLTbPjowVXlcTSLIJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5DAC4CED0;
	Tue,  5 Nov 2024 14:19:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t8KOi-00000000Why-2uzS;
	Tue, 05 Nov 2024 09:19:08 -0500
Message-ID: <20241105141846.641050484@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 05 Nov 2024 09:18:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing/rust: Add tracepoints for rust code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
rust/for-next

Head SHA1: 169484ab667788e73d1817d75c2a2c4af37dbc7f


Alice Ryhl (5):
      rust: add static_branch_unlikely for static_key_false
      rust: add tracepoint support
      rust: samples: add tracepoint to Rust sample
      jump_label: adjust inline asm to be consistent
      rust: add arch_static_branch

----
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
 create mode 100644 include/trace/events/rust_sample.h
 create mode 100644 rust/helpers/jump_label.c
 create mode 100644 rust/kernel/.gitignore
 create mode 100644 rust/kernel/arch_static_branch_asm.rs.S
 create mode 100644 rust/kernel/jump_label.rs
 create mode 100644 rust/kernel/tracepoint.rs
 create mode 100644 samples/rust/rust_print_events.c

