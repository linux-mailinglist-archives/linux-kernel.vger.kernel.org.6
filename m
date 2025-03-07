Return-Path: <linux-kernel+bounces-550854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8847BA56504
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34F91897855
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32D212D82;
	Fri,  7 Mar 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCR4QhtK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3620E324;
	Fri,  7 Mar 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342715; cv=none; b=BMyzV8+7+wnDs/2/0wInR9/icXVJMGnCoC2ULd9IRzCXC6Mht0gSuKLYP3sFlQRd1nMyqYrvcx74k8kHv+vCW/vfD1SGabXK+mT9GJpsFDRbunOCmSYOB21MVNau/kbJDqNuXuGEyLWFPCug+ngzX+a5bCCvO6S2m89RmPiXlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342715; c=relaxed/simple;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1D5ugBdvTYVKtWkvIoDNx+F/eFbSc8aT++xTFerjGmwz7O1DEQVrOUMdya7vGX95Ato4zHwfb1bZjF3ceEGDeVFkpGMkFxSV5TDF/tp6/nJYw5lJe2ZmoyurCx8QHjOStxDmw404K/bnwnuibyihYNoUH/RCiZgpnijuVHQyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCR4QhtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02552C4CEE7;
	Fri,  7 Mar 2025 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342713;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RCR4QhtKCnvuocIxUWwPtaKyELKCr+5sfoMsme6TFkSzbMYYlbrwWXw4c5C0mlH63
	 LpsOrq/EIxLghGTz2r271dVV94uT3Kakvcx9JCbe2jjfNUkxLOyg9gJmGSSXUiHkx4
	 50mnZ/Ik3q84gcpAkOqKWZcZGjzi6U6udNWsOAT0vELSXxW9bSC7yUMsbEhOiDPqGj
	 L3K6LznZybmiexUUuwsuYlnbVm7HZpbaPD7VZ9X9Jr/ob6UjnuoSbjqQyIKPehauLk
	 Y/7HMLfRz+wCVmRZM8uASQ9UVOjC6ULhQS4+Bx8x5+ajfOFUNGVVNHRKgPoRciNb9O
	 /8M+7RBrilPSw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:47 +0100
Subject: [PATCH v10 02/13] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-2-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ3h4HVK134wr8qBW+CEbxOwelYSsXaF+eu0
 GMH/60xwDmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGdwAKCRDhuBo+eShj
 dyPWD/4lb7IjmgfCckrzz75cvV8dHuBhHpRiR88q8Hh2BdwDen17l2jq52Ow5XeWvW3Ww8nlb75
 T3iXdNJRK0Tr6MCfi1EwqMdwnbNQvROvrD6E0RJwxr+ZMDiD2AjAeKcM6u/0WUJN4ZM3v85fUNT
 Kr32rozskBlUb74zba7pqgEgn3Ytpvf4FG9IOdmlnEQ6pbMWsrRzoJ5KPikffovhlzBHGHFK8Ht
 rjQRp1xlsILUnbAPZk+R1wjg7F4f1MMV/QTT11/Jc/C/8UZi/HHeA60sA2rDmgS/1Ut8s4B+oeI
 Vu/z2N1Am1DEgyrkMoy0ot7IZ1x6ETlp92piOY/wrB0WclstrwDUBQSGY757vEKmt9/Zsgz8C7i
 ujDO7TCh9yWshJVDWhM1RKSfu2R7/cntMu/6lT/qvpA09gLh2p5+YsCyGWG4sl+GWYIkEYszdpZ
 eMGp5DPKD700C4Pzzz6LZ2hv1NDb87AalzmYpw3p7fxZdQ/UEd6eko6R4dpegapEehH7jRnBzlT
 gjf/ncBr9mF14Z/oYk6Nm4dSHnM73O24jzcJZfAX5C/i5wt+yWoVYQ/7v9JEcKJfQfeL6CetN2v
 Lx7h4HmtBEYzP1g6Ur5ZE57srlKmBIZ9jbnumd3wxAPK9jO+pAqUvCAlW91E0hk3W0Dvr/XYlCC
 TAOXWcAEFoVFgXA==
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



