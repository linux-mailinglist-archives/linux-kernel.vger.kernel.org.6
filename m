Return-Path: <linux-kernel+bounces-553194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D5A5855D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096ED163922
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7001DFE23;
	Sun,  9 Mar 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lifuUnW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2B1DE88D;
	Sun,  9 Mar 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533810; cv=none; b=JmmIJQGTHcgZMquCoF3L86uXI+xndcqn4CL68XdTpnsoeIxuXVi/hL2hU9ADI1fMCPLaETkpq9VddOgRtFD+KTURHRksy/ZiEvHyD3q2Lb26SBs3ESqx5a4u8jkn4lcNqDyZWhlxBQhCQ9bidpsku4FjVxRkgPFo//IBgc8LZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533810; c=relaxed/simple;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3dH1NvzYc+pwdy0x40uWZnib6Sfcy1YVfGaMzcPP0UATMsHMNAnifFjiSzqBl3M27kZVrXGk/+1LwJsSbbKTSw9bEiPkMtIA7PflsEjl4h65n2hKan+BB68AGD7meukBBR+hDizmk57SHETttygLcj6cOJ7Eif3jRYlye/cNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lifuUnW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF31C4CEF0;
	Sun,  9 Mar 2025 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533809;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lifuUnW9VTJO6b1EaevXAteYIcj4+ENT2modzKW5G0+zTkfRCWH78oYcDrRdBZ0S3
	 GmTqWLTzujOu6Gh4USsR7FFIebj2iqvvsXI+mmIaScSCJlPlpirZDCHvsYe6l7tRPS
	 0a9uv/7PJDGwo+FnzNwfqPL5H5wWhHgVAud+6YvV4PVTHdv/DR/gr6NEhItulCAPvS
	 6+qbNSKMVbajXx6cIsmXNG79tJbOKAQ9WxnzwBcI89J/zBV2DN4bMLews5m+6Tnx4z
	 GlQS8Rc6NAWOdv0vuf1UEP4nyJDEAG90n6QK4bcqYilIsmoAyDKVSDOcbOA6ZxUhQ0
	 DLTa/Z9N/sDYQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:53 +0100
Subject: [PATCH v12 02/13] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-2-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFoc4QCddRfOBqTbH64MPdX14gT/LUfOwrrZ
 O8zhs3+bgiJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xaAAKCRDhuBo+eShj
 d1p4D/4iOQYzLnxtexmkJroI6Xc2DFwLLtvwShqZCZaNrnd7qLHQ0Shdl/fN1M8bdlrvcE+vw3W
 k7R+y4x/fzkWcqnAJU0uVBfxNlKCH0VCIq/35DR2HW+9gVpAkr68guzLCs9dGCQAJuuDORcVMib
 i8x8z0CcQ+KkkA5g4kl4uzK68hO2gUtVEUIQQ55B4qKIzWSbeEUt/4feAE4FzfxBAncYccZqDyY
 nhAQkh1zvzr1mtNJIeRNJnvgAJOu/Ge08y1AaZ6xdisHkkfsyPz7Z4ROVpyj+9CkcBUYc0wEpjb
 tfDDbt/Y4J2xjXn0eKBBJJ0QstuN+tTLr57zFP0PJpggCs43ilH7PyYEShdoIvsWVxLh+KT1dN7
 O9S0TQ1ohn5pF2NSmy1ZZhqr3OBKWAgYGCUziKhhcsPTESVMr5VdrCuh0gyumHf9DRUWUeat82f
 3h80s45OK5+0NPk4czjMOR9F2R7c6QwaeWtiZS+fjua09Dp7S7qJgDpODvoAsif+JlAXtgKZIlW
 G1AX6OHtK3rZwKdjbqB0SUYjTVrHMmHx0fm4vVwCDeyifs0/cgaVjfGMlBZ3BOR9/XZn+kODWz3
 22QMbV/7AqIVjMjRQ3QF7YB4lAalscyZO1J6fc5IX1CGBOtu3dbBm6ptymZFfANrMP3iQpJ+rWG
 AyKYHNUAD+vbzZQ==
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



