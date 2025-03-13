Return-Path: <linux-kernel+bounces-558930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF2A5ED3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1377A31A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B721FBCA9;
	Thu, 13 Mar 2025 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wVVBZDUw"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBA31DEFE7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852016; cv=none; b=BxFxXxxnMebHVeIxWFnKSmTGNPLtJfZq/ueLF9EAy2vHgzGYVccSU9hvaKQ/vEqLdKlq2pqOZvuJ82PahHyYSzysSNO/FVvt+08oya446TWLkoY1qTJ7RHrgbF9nlODO9PHBkyMxFicQMNEu7VrrGGUr6rXHztKx5RDbO6hIjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852016; c=relaxed/simple;
	bh=Kcw/cri+106dKos1f1Natr9iLqISBP6t2M/k6NuJoeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWryv0WVNmBLzD9dO84zV7ZkGMl7UaMJkoP4aaSmM54Di3VtKswdxJptLSoHLwlObnNa2P7t0rDeYTqOocKmW/FCgp5jisfow20PD//+jb+bbnq7Ubj4llWiSm0NS+fPzY1whDCPGW+5jal8HWqbQmPBcEvAdsCp+t4OHwsMLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wVVBZDUw; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741852002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A1k4rvRiNGwMmsF5RLcMl0KSYAR5wW+8BJa1JeXnczs=;
	b=wVVBZDUwJMfdTy9EFL9OKjRb4HM/biVq9ZaJh0Ar2oo+cRJH67geNPyjJXZhKgquo6Pz3I
	Wbpa/MhNEg05bLPlCgxyLOvtff4qSGAzTB/CmziQ+4OAX3PgItsWQYflwsOBo1hP15oKD9
	QgZ7J4exDWdpCXvn2EGXIGxCzjGmJsE=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@Gmail.com>
Subject: [PATCH] rust: sync: optimize Rust symbol generation for PollCondVar
Date: Thu, 13 Mar 2025 15:45:36 +0800
Message-ID: <20250313074537.729578-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@hotmail.com>

When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
with ARCH=arm64, the following symbols are generated:

$nm vmlinux | grep ' _R'.*PollCondVar  | rustfilt
ffff800080019e90 T <kernel::sync::poll::PollCondVar>
			::new::{closure#0}::{closure#0}::panic_cold_explicit
ffff8000805b8e04 T <kernel::sync::poll::PollCondVar
			as kernel::init::PinnedDrop>::drop
ffff8000805b8e04 T <kernel::sync::poll::PollCondVar
			as core::ops::drop::Drop>::drop

This Rust symbol
(<kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop)
is trivial wrappers around the C functions __wake_up_pollfree
and synchronize_rcu. It doesn't make sense to go through a trivial
wrapper for its functions,so mark them inline.

After doing so, the above symbol will not in output.

Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
---
 rust/kernel/sync/poll.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d5f17153b424..a4f92c545fec 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -107,6 +107,7 @@ fn deref(&self) -> &CondVar {
 
 #[pinned_drop]
 impl PinnedDrop for PollCondVar {
+    #[inline]
     fn drop(self: Pin<&mut Self>) {
         // Clear anything registered using `register_wait`.
         //
-- 
2.43.0


