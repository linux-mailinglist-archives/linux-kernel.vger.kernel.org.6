Return-Path: <linux-kernel+bounces-416480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F79D45AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEFC1F2259E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067213AA53;
	Thu, 21 Nov 2024 02:12:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E467A0D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155140; cv=none; b=Q4vCy5tFZI+IxIeaCXK8DnaBoOT4h+S55ECvYENL1sRwBI/1HEeqITZP1Z/Np+HBx/Oeiy5ly+cEZajW6Ujtjcta0z2rcitWKWwRkSIFc+gXGTKX1lJNJoogJiH7WOMdbQNFZ5EWnLpPOpqCV5tPzzYL3ZCNg8tMVviv4NgcYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155140; c=relaxed/simple;
	bh=jKh9nRPLGScJAFprkK5YSEkVNnzGAg7RF1vxzoTG+BU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bz4RzJ3JkUynD8Ljt8rbLFgBU4I50ZOUk4yZP4SYID0YbFcofM8JrA0SrkeMYkLGDsx15HGCvrPbqf6mrkRwTqDhH7k6P295tOMCQXBypy4puSRuT1Ez1os8MTDKdhjR5ofy9fSqeH3sXDCdrFhVj4ICz5fhUay3eDvv3oH7JOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F4C4CED6;
	Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tDwgj-00000002ZiK-29hx;
	Wed, 20 Nov 2024 21:12:57 -0500
Message-ID: <20241121021257.362820940@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 20 Nov 2024 21:12:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Miguel Ojeda <ojeda@kernel.org>
Subject: [for-next][PATCH 2/2] rust: jump_label: skip formatting generated file
References: <20241121021226.575757843@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Miguel Ojeda <ojeda@kernel.org>

After a source tree build of the kernel, and having used the `RSCPP`
rule, running `rustfmt` fails with:

    error: macros that expand to items must be delimited with braces or followed by a semicolon
     --> rust/kernel/arch_static_branch_asm.rs:1:27
      |
    1 | ...ls!("1: jmp " ... ".popsection \n\t")
      |       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      |
    help: change the delimiters to curly braces
      |
    1 | ::kernel::concat_literals!{"1: jmp " ... ".popsection \n\t"}
      |                           ~                                ~
    help: add a semicolon
      |
    1 | ::kernel::concat_literals!("1: jmp " ... ".popsection \n\t");
      |                                                             +

This file is not meant to be formatted nor works on its own since it is
meant to be textually included.

Thus skip formatting it by prefixing its name with `generated_`.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Link: https://lore.kernel.org/20241120175916.58860-1-ojeda@kernel.org
Fixes: 169484ab6677 ("rust: add arch_static_branch")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 rust/Makefile                                                 | 4 ++--
 rust/kernel/.gitignore                                        | 2 +-
 ..._branch_asm.rs.S => generated_arch_static_branch_asm.rs.S} | 0
 rust/kernel/jump_label.rs                                     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename rust/kernel/{arch_static_branch_asm.rs.S => generated_arch_static_branch_asm.rs.S} (100%)

diff --git a/rust/Makefile b/rust/Makefile
index bc2a9071dd29..99db963637e6 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -36,7 +36,7 @@ always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.o
 obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
 
-always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/arch_static_branch_asm.rs
+always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/generated_arch_static_branch_asm.rs
 
 # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
 ifdef CONFIG_RUST
@@ -427,7 +427,7 @@ $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
 	+$(call if_changed_rule,rustc_library)
 
 ifdef CONFIG_JUMP_LABEL
-$(obj)/kernel.o: $(obj)/kernel/arch_static_branch_asm.rs
+$(obj)/kernel.o: $(obj)/kernel/generated_arch_static_branch_asm.rs
 endif
 
 endif # CONFIG_RUST
diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
index d082731007c6..6ba39a178f30 100644
--- a/rust/kernel/.gitignore
+++ b/rust/kernel/.gitignore
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-/arch_static_branch_asm.rs
+/generated_arch_static_branch_asm.rs
diff --git a/rust/kernel/arch_static_branch_asm.rs.S b/rust/kernel/generated_arch_static_branch_asm.rs.S
similarity index 100%
rename from rust/kernel/arch_static_branch_asm.rs.S
rename to rust/kernel/generated_arch_static_branch_asm.rs.S
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index b5aff632ecc7..4e974c768dbd 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -39,7 +39,7 @@ macro_rules! static_branch_unlikely {
 #[cfg(CONFIG_JUMP_LABEL)]
 const _: &str = include!(concat!(
     env!("OBJTREE"),
-    "/rust/kernel/arch_static_branch_asm.rs"
+    "/rust/kernel/generated_arch_static_branch_asm.rs"
 ));
 
 #[macro_export]
@@ -48,7 +48,7 @@ macro_rules! static_branch_unlikely {
 macro_rules! arch_static_branch {
     ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
         $crate::asm!(
-            include!(concat!(env!("OBJTREE"), "/rust/kernel/arch_static_branch_asm.rs"));
+            include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_static_branch_asm.rs"));
             l_yes = label {
                 break 'my_label true;
             },
-- 
2.45.2



