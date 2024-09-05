Return-Path: <linux-kernel+bounces-316396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A795496CEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E37B213F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D58189523;
	Thu,  5 Sep 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9Y9YTY4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF7155C9E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516753; cv=none; b=UVNUH+kxn+4fIqBVqIwcmUFKzuCvGZQEEmNdU++X2pJaKdDT+Hx4xhqO6/C6nhRxnb+ffOW7IThjzRvzJTvvPuTImR41JDGT8Z0P0n76SgtJJhdxr6SeYmtBN9VHs9SX6PzsquY2JcYWpqvR2GlQ2LLodoNvsQ0kxwxg3M2Tq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516753; c=relaxed/simple;
	bh=2q/az6HaCPchXtkkz92LD2DZLCM0KCj/UmgVvpuf8jk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TRRWRLOhpoCJ7GlGF0xPVC+HxS/JPzpNjwGKX6TOAqEuzoYZojDiJIDNjwYIusBwvXCR97jlZ/6078w1TXR+gR2pDQ3HyeSXnN4/JiBhdXgL4K70Bnnu0SEVla5rvlYsOo0pCxZW7Eqou47NRQLWzbPYJ7dLS3tsEYTdsx7GzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9Y9YTY4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e11368fa2e3so899766276.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725516751; x=1726121551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=;
        b=Q9Y9YTY4KCQH6/W4Qgpfv2zqvb8i+7OPL+fkJ8X2wZbXNZVCZy46Abjce+L2EC+FBF
         BJ4R6gNlVTXN+FFqNXpJvkG0M9K/ekQeKPUzn9qsOgBv84Hxyrngcj5Lc+O952Iqtm3O
         HN0zkJoet8VSP2/fQUUMHeknI8yn/0o8KvyDof23chiE/9GDA3o9Jad2niQg07FPCInq
         xH5kZ1g9pRSPsEzcGDLSmJOkEzGi2EIO/Kpp8Hi+8hTAOK0e0FMIkHCEPf9Lkt+rI3q4
         09fdyxMFoMuwhfWgYnMKSNWHwV1LblvRk6RVE9SWrR6J8pNI6qkSPi3KKzYQN3F1wDbF
         c40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725516751; x=1726121551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=;
        b=fzelCK4I8UpI31f4cNPi6hQAmE0n7ceKa1QgcxkwtBAlieHdTU5h9007HznVqArMHB
         QfDvwTEfG0PfScyI/kenzvDPAFTcygAu1ijAajypGWjF38/mcEVCF3EueK9O22k83856
         LhwB9tPhdsGhrTrl5c8XtGl+GsNtgkxCpr93HvVz92Zaw4HEQd4Vnuok2OVBbO153kxf
         /2VQHtzECgdISfglwW3vRAbioV+OCXPt6n4QTEUWbzIDxbQdMsMbJlD4P+OStw6Jz+Yc
         8aehdcsZN6bx4NZ4VO36CclMCovQVwm9bLPz3e9wAPvM/GXy6ogNtGjprQyDshH5+CW6
         j5Og==
X-Forwarded-Encrypted: i=1; AJvYcCVtRMZPcMieTy+nJHPvETmlqgfSWHWdlxvyGF7NdbuBg2u91Xzm20TS1epie9I+4UJZAkQxk6zmsv/oWZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7w8/cS6lmPJz9rq6q/ExjKFkOjPTc0TVuUU0l4E8mT/C0Cpr
	yxQH5pJQYgXF57yADFgYvCjKuhDeCNoYsKVxsXzkaajdI4CIfvAOKbyJ1cOuDIq+OPM2LpAs25O
	s12LbxkRaGw==
X-Google-Smtp-Source: AGHT+IFb1uyLverYDvkTYTYyFuU6LY97S1fxJcQ5+perARjw81iOZxVvfKHhENGCOXBybmboZGZK6CqTqt35rg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ae56:0:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e1a79faf683mr114011276.1.1725516751120; Wed, 04 Sep 2024
 23:12:31 -0700 (PDT)
Date: Thu,  5 Sep 2024 14:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905061214.3954271-1-davidgow@google.com>
Subject: [RFC PATCH] rust: block: Use 32-bit atomics
From: David Gow <davidgow@google.com>
To: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: David Gow <davidgow@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Not all architectures have core::sync::atomic::AtomicU64 available. In
particular, 32-bit x86 doesn't support it. AtomicU32 is available
everywhere, so use that instead.

Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
won't be an issue, but it's not supported in core from upstream Rust:
https://doc.rust-lang.org/std/sync/atomic/#portability

This can be tested on 32-bit x86 UML via:
./tools/testing/kunit/kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y --kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Signed-off-by: David Gow <davidgow@google.com>
---

Hi all,

I encountered this build error with Rust/UML since the kernel::block::mq
stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
is correct -- please correct me if not -- but this does at least get the
Rust/UML/x86-32 builds here compiling and running again.

(And gives me more encouragement to go to the Rust atomics talk at
Plumbers.)

Cheers,
-- David

---
 rust/kernel/block/mq/operations.rs |  4 ++--
 rust/kernel/block/mq/request.rs    | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9ba7fdfeb4b2..c31c36af6bc4 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -11,7 +11,7 @@
     error::{from_result, Result},
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::{marker::PhantomData, sync::atomic::AtomicU32, sync::atomic::Ordering};
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -186,7 +186,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU32::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..418256dcd45b 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -13,7 +13,7 @@
 use core::{
     marker::PhantomData,
     ptr::{addr_of_mut, NonNull},
-    sync::atomic::{AtomicU64, Ordering},
+    sync::atomic::{AtomicU32, Ordering},
 };
 
 /// A wrapper around a blk-mq `struct request`. This represents an IO request.
@@ -159,13 +159,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
     /// - 2+: There are `ARef` references to the request.
-    refcount: AtomicU64,
+    refcount: AtomicU32,
 }
 
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &AtomicU32 {
         &self.refcount
     }
 
@@ -175,7 +175,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU32 {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { addr_of_mut!((*this).refcount) }
@@ -193,7 +193,7 @@ unsafe impl<T: Operations> Sync for Request<T> {}
 
 /// Store the result of `op(target.load())` in target, returning new value of
 /// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+fn atomic_relaxed_op_return(target: &AtomicU32, op: impl Fn(u32) -> u32) -> u32 {
     let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
 
     // SAFETY: Because the operation passed to `fetch_update` above always
@@ -205,7 +205,7 @@ fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64
 
 /// Store the result of `op(target.load)` in `target` if `target.load() !=
 /// pred`, returning true if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+fn atomic_relaxed_op_unless(target: &AtomicU32, op: impl Fn(u32) -> u32, pred: u32) -> bool {
     target
         .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
             if x == pred {
-- 
2.46.0.469.g59c65b2a67-goog


