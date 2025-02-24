Return-Path: <linux-kernel+bounces-528983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D7A41EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2A3A6AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D733254857;
	Mon, 24 Feb 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jehlrj6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCCF2512D2;
	Mon, 24 Feb 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398798; cv=none; b=U19QfjuX+HxecL6g9nnfk3CtT6dZly+MyePSXAjTKO2KFUz11zMnEFdrQJIBFnY4Zx21tB2eCAE5o/DkzpImW9lJlWfO3GwATFfwDulZDPKRRDYK3mW9LXHZXZwXuOXQ5O/9QB4BIM+Q6stgrQjjvn2ZGqo56Xu4E4ZUVS/fRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398798; c=relaxed/simple;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhNXgOxgOkv0BjHz6g+obKr8oay3LumRJaQ6ePTf6AlOPN+R1xg3ujSEG8t6iPmArYSLvBAA8t0a9UKI7CW09hacmArHBvp2a0k+hqHY2YLuG2Z/R3rk/zS0yKWl0G7surrIFNjohPaqDBLqbCrCQrC7n1z8jtMyvWesfQ9A1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jehlrj6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F1C4CEE6;
	Mon, 24 Feb 2025 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398798;
	bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jehlrj6Fy59ueGbZq184namXTNyWTvz3YHbpUpN7GJn6+lNlZdX1rDphQEorxTeZf
	 koeWXzIUk+0ytmYKTSTyRYkPsEp3CWsOJ8hfAtOpKiqkrZA7kDZdBELAIXQsAAYSRj
	 96pNizEzIoCLRzbDjPLCfv1QwvqJLg58qG9uTHfa/0k3BqAuyIpvamfb59nc0EWQfS
	 JyLknZvoZv2ShjUmMZkGcJOy7+rQqXpYh4GSmf3pBdEiboC7we1syd45OJ804/XOVd
	 /eBHaldSUYCrcRehy0ZFyNd+lRaaCGJuhAKRCwX3FiLG12fzswrf0yDY6mX8WokJx4
	 iVSVe8gk0OBbg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:36 +0100
Subject: [PATCH v9 02/13] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-2-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+Kma+nbFYfjc4yGFhq1umBDIXU4Jat/HmaZ3lk50G20=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAdj+YLySAKo9zDsGZQfQxAHbhFR3dO/o6Pu
 o+8gKS8KsaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgHQAKCRDhuBo+eShj
 dzs7D/9Pl4CTzAU6DWHc1V180GZY0GWKM6oRmN1DbXI3UIwFNqXgcKt0VJ3f3pZFrck+sRrG2aL
 V4ipXkQsMK0eOyzb7Z9HwKyi6Uy2X0siWoZXoqBiiLR90wfIx42rd8TT1m92LC99veyGH1seE6z
 63w7voF0h/3MIs4Kl1Ow1HmBFALjJkPQ/VJVcSOAF1+0Pu1v5zrFeeDdeTw+kJzVk9FE2gniz/j
 IY3eHqu71jMCo8KZtWF60gtUkt2be3irhPK3EhKLl1q2KNqzLYRzEEJNBGBXghlAY9rwhdPxh7X
 +3lHR10opiF/X3xLq7iTRLVRqz1HiGYrrFPds0hccPgn176O1tNuZ38RK4l0OOpVQ5Jqunyckbj
 dmiRFPWMJKZJhu1ccfysIeD9QvE0iMOHJjNrYs3zBNRmgsyhhXUpfHF8Xop3T4A4GAPKEufBNH1
 xqu6PAuZraipJowThYSUivuwQ1PvkzOEiXq6uPSoAfsXXb9f3SwSv6vSjvRvZoevY93Q9+cAMWX
 OO3cA3Zb+G/Oiwdycf2n+APDOBHGYS4qRpMuxYe30y5YZzkznyMheyrxymuIb6jvvC/TWy2/VdR
 PsVjs88K339iCaAsyS6HAaAftyIPGugPokYoV5q+ilvX7jKVn9eTTCepG9x20uziCgI7CS6iSqR
 8uZIFYs2i1iEQjg==
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



