Return-Path: <linux-kernel+bounces-552000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10DCA573DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F13B0C66
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA925C710;
	Fri,  7 Mar 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZQd26g2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CB2580DD;
	Fri,  7 Mar 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383690; cv=none; b=rwOtjAPVXH51pUvwwWRYMlPtlPKf7Zp7dCYjZmfs24KisifCa4JQbNWAVH7X+fDfMQqpskLFq/zRdSyNoi6WKKMqIGUci+4vzS8dNe7+jLzup85NbIIumRK7rWi5qi/OO0eBX4bBi8qSYIAL1AqJt2ZkNidsB8RN54RBacTqD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383690; c=relaxed/simple;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBBKomc4Jc7XO0ilXhMzhN4ENhG6ilTj8A+Fdc+OSA9nStKPRfkKKlvSXMWBsmy0msO3y81LKfaqhS2QlnFHvujXGkqakFPSMx/SsV72AcLxp0cvHuD5+9HWQoWUkcVwjoCWkfdMx1OsgcUHRHNApd0WUqFvG6ZWZ6vmTraPQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZQd26g2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4334CC4CEE7;
	Fri,  7 Mar 2025 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383689;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZQd26g2zHdYtvhX2t5RnyQ6MhMw0jR7KUeZUtTiMyrLmMxPHDuINeSICQRbJq8wW
	 hetlsmpLxo+5EcVVfR1hO3g7LrmeK6Z8i9LF/18+Xkj8OJtlo6VQnvAjs4IriB/Fe0
	 iB6f3t9vpOXmSyxeIqRnMLtqI7Q2cDHCaN+54kR/gBg4xNGDsvARrcfvokiQ49X2e9
	 ORLLw5EpvCfQ6n+n5j80ZJPbf3rLM8FH/TXhUt8qqtcKBGQQkaJxE6DOlGOmicFRnE
	 U4Xj3yZ/uTdNNQmiTHbjEl9FL/hs1i8YLD3ocf8I93U+2wgW1kAy2LVx/DIhaWPhni
	 j7ia0QMWo6kGQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:43 +0100
Subject: [PATCH v11 02/13] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-2-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dq5Ev3oIBtW5pDlICfPa1x3atzm8cU94sow
 chUNrjg9W+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnagAKCRDhuBo+eShj
 d0fcD/9BfkMJ6JjTkjriudNavU6WsCEQCsc8ocvGKvXwjd8pNZ1TpLP14Y0d9apjOh9MRrtxqBC
 2aK0K76212t5GqXhNtYPyu4kS/0BM9PWWwQJTFIfsNE4nmcXDYSnmut0Wr6M9h0j7dRznCsxrp7
 UVRgT9TMsucGtsq0xke4GO8DoKHOwn8TYwWTjeGsTBQHxy/D7o7yZRXnbZx1E3GZ0FxvcMd+er5
 2QXFK1fSCK9PY8ScMoLJQxzceugWOajrjC4GKTPt6K9gUqrEBwxlHrbyo1jC2VbzagWD7DclVY7
 C988KJGRg+H+EXbhM3sbDhbg8eWYiuDJeOPJ4VIGfajaL3FFwQhXI7WR85EdjqOQLTpowJbvvdl
 nU8QdgJ7sRIuoG3mh/ZjHG39ywXNZzLio7bDgjrJCndc7lozE+coTQw+ZJoOMv/NUrHpd0NBDaN
 okcBOIif4aqbGuli+tP93ss6uFB2KgBWYRsf0MViHt7dFFsHDAx+Oz7vcrSNughh25JNgLw7/a/
 qpVAs4W/XVjHA4kOM7sw4Clot7rixGfRIqyTd4PdYd5WMQOrkkS+i2mwBJHL/GtMCIHiBYZEH/U
 f4PF8RPf1uU87MVnlV1wGZhfrt7/HY9Y1ug+4oWp5WUSoLBhEL89ZXCUsCf7SYzynt0Le/zTWGC
 dxBI7CRepIcsaTA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to get a pointer to the data contained in an `Arc`.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---

This is a dependency for:

rust: hrtimer: implement `HrTimerPointer` for `Arc`
---
 rust/kernel/sync/arc.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a4372..1dfa75714f9d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -246,6 +246,15 @@ pub fn into_raw(self) -> *const T {
         unsafe { core::ptr::addr_of!((*ptr).data) }
     }
 
+    /// Return a raw pointer to the data in this arc.
+    pub fn as_ptr(this: &Self) -> *const T {
+        let ptr = this.ptr.as_ptr();
+
+        // SAFETY: As `ptr` points to a valid allocation of type `ArcInner`,
+        // field projection to `data`is within bounds of the allocation.
+        unsafe { core::ptr::addr_of!((*ptr).data) }
+    }
+
     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
     ///
     /// # Safety
@@ -539,11 +548,11 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
     }
 
     /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been deconstructed with
-    /// [`Arc::into_raw`].
+    /// [`Arc::into_raw`] or [`Arc::as_ptr`].
     ///
     /// # Safety
     ///
-    /// * The provided pointer must originate from a call to [`Arc::into_raw`].
+    /// * The provided pointer must originate from a call to [`Arc::into_raw`] or [`Arc::as_ptr`].
     /// * For the duration of the lifetime annotated on this `ArcBorrow`, the reference count must
     ///   not hit zero.
     /// * For the duration of the lifetime annotated on this `ArcBorrow`, there must not be a

-- 
2.47.0



