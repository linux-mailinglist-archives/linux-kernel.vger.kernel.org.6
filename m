Return-Path: <linux-kernel+bounces-449457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C79F4F50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92591885FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F421F9405;
	Tue, 17 Dec 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr9FyvHy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2A1482E7;
	Tue, 17 Dec 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448823; cv=none; b=Iqt8FDGLHAPb6Rj3JVYEQoPrW0gSReVUMpf3HuQK1t/TaqKRV0+5nfjTyJCJmTfXeF+2fc7ttZA0ID7QK7WtmHeawYJnxsjvOOyVWpysVG5DDNgqfdO2mmcNZAbTJvn1fWbfe6HDd8FknEccIpmnXGXF3HZCq4VMoOGD1cPi7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448823; c=relaxed/simple;
	bh=aU3i369UGy3y1q8jWHIGozb7YdRezhyOhvtwK08LAa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B90E61LaPn8Bw95bU9pkZQBm1Q9frs6e43olXNKa+t2tjeo7pvNMEn34VFx0WS414YyyETLwuqN/IL5BceXI6ApuCK3qz9WfRSHPLWjuLoQXg4qCd7r+NXXGkTyaE3/m3qlQRMJ0zYoA4BBFIPzho5mfMHE9kkTHb8Ax6lufNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr9FyvHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB0FC4CED3;
	Tue, 17 Dec 2024 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448823;
	bh=aU3i369UGy3y1q8jWHIGozb7YdRezhyOhvtwK08LAa8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dr9FyvHyXhgQm7+T+4Xt+K/TDxwLRsN92+LzoSyMl6CF3l7AYDAjO0uzhhmCqalTB
	 YUqlOk4yGGRs3nvVw0PWb8alzJwQfevAF+LxKcnibNJ00/oXshsifVKDLoIAjagNoU
	 7Al81evqBUp0p4hckgmagRGseiWyIKmo/ROv80pBLySphwYgqZvnfHvm3djtdf4Qnw
	 C9pBLEfk2N9KnkoeYRxbxHjAccivF0iDKvZSvuYTKS3xdacWDHVUWxG5K+FbyZ4djX
	 ereyIAP1BUVQ95E+Qk7bPuMYaWfKNbN/mltin8VrKLXqeamdvr39OqEOkb14couFR/
	 6hPFYGgARQyEA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:34 +0100
Subject: [PATCH v5 03/14] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-3-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=aU3i369UGy3y1q8jWHIGozb7YdRezhyOhvtwK08LAa8=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYTGjzQEzj8dKhz3E/Exy2volMGLExqfJVVT
 xvzZjs2sE6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWEwAKCRDhuBo+eShj
 d5vKD/9gXTHnCWwOkdFZm7xlp10yG1nHe7MR2A72J8VS8V5RvV0gLgn8tLUSDFxfVlZ5Vryev0E
 aInNLWa9C7VEF4xcWmxcTGzd9A7RVuxuJebgQTd+xmbrfTfu+6NTI3ST7aHMCWZXfLUWE2Yzkdn
 gG3ndW+JfNy/lFBoEyK+VqROmaAlZaExIzsDcwnRJy6WMabBJybewAmqqCKHFjMEpQz7rY1VgKt
 hIf9t6G9bQopI0erEEbQjbB/8BvG16pkz6VztcOMs6T01ynKZz6Dvioor8sVadsvZkhjYrSBOV6
 N8kLS4g/L1uLUhKT/NjlVnLx8kMjVPXauCw/EjxUpcCB8Ls8uZY2LE3DfAU5V179D/T6pkjgH7B
 j4J/+roKdf5ZZaUG1QhknNhagpEvaF9/Ma73YzBtBWxZdTW5/lU2uFH7Ds9ereOJ2qwxJgRAVCW
 trz1Icv3yY5LS0rUk1u8GfqeS46ZT2ORjeGFT2aD1az8kb/buJAMVyMvZsN8d56RFizk5+Vx5ET
 BPVgpiMDP714ECPaCyoCvDwUUCEAGqqWuOl7oKbtgtv7LSIM6sbaoquWn6LkdVURs498YxGXUfc
 6qrJ/7zcVau+s9WBf4zNnX1eLBnki/JOLIc9AIYKaVX4iF4sxpgfJsi1ywm1hPlR+u2g25dEXtg
 mP438o+E1GlkOPA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to get a pointer to the data contained in an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/arc.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index fa4509406ee909ca0677b78d5ece966089ce6366..3d6111ddb007285b26eca2177a412033f4ac5dcb 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -233,6 +233,15 @@ pub fn into_raw(self) -> *const T {
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
@@ -508,11 +517,11 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
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



