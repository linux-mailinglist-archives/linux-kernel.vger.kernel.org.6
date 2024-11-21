Return-Path: <linux-kernel+bounces-416479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B639D45AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6AF1F2222F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2796136E21;
	Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37454918
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155140; cv=none; b=n8Uu4tiYKz58JgdBXxa/2EwTehikEIqONIKzCPnL1c3QTdJ9coRBqpZogKGK+J5sW+3pn53eL7+rt6Tx1m4uSeYTIGYaD5LHcdzWENeK0Nf6qgf1hrDlB+Gv5ZAaGLww2S4g+WIdXqoifC6QRS/3SNbOVQ/TXdIcD//Zper4Wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155140; c=relaxed/simple;
	bh=AHY4q3E9pzEdtckfjjT7S+RxVTFaYWcHzpEMStRjQcM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oSPC6I6pd/ai7xoxjuiPzi07HRA+VL2AuozTeZbsr8Y7aboyqpiKU98sLKxBkf1+Z07VPyZiCKDqTvNg29HuHivY6VHUpIRRxQQaazOTvAc9FKgP/a9ltRVUBXOXoATz+at7WFnrcYGapeE0/WE6ZnCgQB7ZQ4KH1r0lQ6YIkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160FAC4CED1;
	Thu, 21 Nov 2024 02:12:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tDwgj-00000002Zho-1R9X;
	Wed, 20 Nov 2024 21:12:57 -0500
Message-ID: <20241121021257.192412005@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 20 Nov 2024 21:12:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>
Subject: [for-next][PATCH 1/2] jump_label: rust: pass a mut ptr to `static_key_count`
References: <20241121021226.575757843@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Alice Ryhl <aliceryhl@google.com>

When building the rust_print sample with CONFIG_JUMP_LABEL=n, the Rust
static key support falls back to using static_key_count. This function
accepts a mutable pointer to the `struct static_key`, but the Rust
abstractions are incorrectly passing a const pointer.

This means that builds using CONFIG_JUMP_LABEL=n and SAMPLE_RUST_PRINT=y
fail with the following error message:

	error[E0308]: mismatched types
	  --> <root>/samples/rust/rust_print_main.rs:87:5
	   |
	87 | /     kernel::declare_trace! {
	88 | |         /// # Safety
	89 | |         ///
	90 | |         /// Always safe to call.
	91 | |         unsafe fn rust_sample_loaded(magic: c_int);
	92 | |     }
	   | |     ^
	   | |     |
	   | |_____types differ in mutability
	   |       arguments to this function are incorrect
	   |
	   = note: expected raw pointer `*mut kernel::bindings::static_key`
	              found raw pointer `*const kernel::bindings::static_key`
	note: function defined here
	  --> <root>/rust/bindings/bindings_helpers_generated.rs:33:12
	   |
	33 |     pub fn static_key_count(key: *mut static_key) -> c_int;
	   |            ^^^^^^^^^^^^^^^^

To fix this, insert a pointer cast so that the pointer is mutable.

Link: https://lore.kernel.org/20241118202727.73646-1-aliceryhl@google.com
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411181440.qEdcuyh6-lkp@intel.com/
Fixes: 169484ab6677 ("rust: add arch_static_branch")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 rust/kernel/jump_label.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 2f2df03a3275..b5aff632ecc7 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -26,7 +26,7 @@ macro_rules! static_branch_unlikely {
 
         #[cfg(not(CONFIG_JUMP_LABEL))]
         {
-            $crate::bindings::static_key_count(_key) > 0
+            $crate::bindings::static_key_count(_key.cast_mut()) > 0
         }
 
         #[cfg(CONFIG_JUMP_LABEL)]
-- 
2.45.2



