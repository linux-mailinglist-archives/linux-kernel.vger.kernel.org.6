Return-Path: <linux-kernel+bounces-332119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15297B5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F02CB291AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA01194A52;
	Tue, 17 Sep 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4uefDY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484391946D0;
	Tue, 17 Sep 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612121; cv=none; b=CDbJdJWn9mDavGsGArwME+HTsjnEuChfj0Wz4CcL4XxDTYRrbRfxTKQQaHKz0SSvjH+MDKxwbUsYo4jndjUwRFquWN2EKJe1FI5xk++DSTx4nlOYgBkfT93ViyLOU2LcK4BEhj8Ef+d3ZQn3hPPyGvT9UdpPyMQG6TsUMy3bVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612121; c=relaxed/simple;
	bh=rG+zlpbG3aKerlLcdqeS6p5RwOcwwLNwFsCtFSkRCQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCC4qCrdnzZgTASWTKohSfMRAzQBPA8jskW50KsXNX0owf16ZSeUxnxSJYDHKtj0pkavtxJAv8p5tDg9gUUKFVfzBVmKnwZd1bM/Pp07pndm2lAsKOuYxkM+ge4PTb0cfgVVzbezt1arl4/32/2y9/J49e+zE0Vi0NNW0FBDw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4uefDY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F5EC4CECE;
	Tue, 17 Sep 2024 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612121;
	bh=rG+zlpbG3aKerlLcdqeS6p5RwOcwwLNwFsCtFSkRCQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4uefDY+rmkBUSEmUu8S244mdoSq4ValxL8gDIFJNveHduwM0mc1tT+AaZi9kh+aq
	 yQYVHEAvzB8HYgFvyIoyv2H3q6rUTl727YqMCagJCaMbbHUaxVEqWmt0tuHAKv3/aU
	 d3EbRzKqOo6Dcw1DE6UTSXI8nltg+DG6aOHHmL1u4giI7i3KFLc5gxcU9FSqZfjnZh
	 sS7kvtSMgyaiNPZCJ59bQ/Ks0kY7ysX6RgnGayU2Ik4++zAtfwRmYsXPS0posRjsy3
	 r3TEMfcyupeP9i5Q11Dz8xs5jQF2Fchiv/h4TvsP7GS6dd9NozcxvGnFci4MJAaG4I
	 zlXlVuP9eS6SA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
Date: Wed, 18 Sep 2024 00:27:28 +0200
Message-ID: <20240917222739.1298275-5-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=a.hindborg@kernel.org; h=from:subject; bh=rG+zlpbG3aKerlLcdqeS6p5RwOcwwLNwFsCtFSkRCQU=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZqaktzSUxOMS9Xc1gzc3B1N0lpaWlJClc2UGc0akJhM242TnlnTHlt MHNFTW9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDR BQW9KRU9HNEdqNTVLR04zSHcwUUFKZGJwUjRvT1VvdmZTNS9SZi96Z2ZvcHVMVFZacE5UaGtqTQ pNaG0xNWQ2ejJrcVA5SkRIZXpqZ2JuL2RLY3U4TDV5cXM4Vll5VmpnTzBwT1VYenpQd2FueFhRa lYvU0NHUFNRCkEzOTU2R0U1enNpMEVSY1RPMmczV0lZempwVXJRd0hoQnRyRjNxWVcxVGZib1JE QUlZNVd3R3lwM2dhamd6bmgKckZRMmdVbS85K0F5R3hMK0JJUmdWc1pqR3RaZmFOU1BFVzZqMDB vSUxoWURjdVc3eDBrVXVhclppc2x5T2xWQgpQekFLNVkwRk52a1dsME5ZK2YyQWNIeXpmUVlPM2 UxelVXK3BmSjR1VmdOaXlhT2ZYcHVYenZkSEkzeVI2c3dHCndMR1Z4ZkNURHNCUHhJZ0lvdDNDd FB4YkwrMUtKMXJ4MmljUDZvRzJNc3QvTGJmckEvODlpTWhqWWFaUnIyazQKaTY2NXlBRE52S2dI akhwbys3RldOSUNzWFZvWkZXS0daQm9IQ2tORnMycTdyaGFsZnhpL2pCdVUzWlVqZ1d1KwpXZTF FZlVjaUErdk53U2FzY
 2JxUmM5cDJJeUxuSXFPaXZNdXl6aFB5TlczcExWZkd1Z001VDluN3BRNm NBeDlFClM1L3FmdjFaMWRrZExkWHZWbkcwNXMxM3VNTnQ1bVZnaElBWHNiTkU2NE5FQXcvKzRHM lBhcjBnME56dUt4SHoKZXVNdzJ5SWJycGoveWJyS3Rub0wyZDZOb2hUNzFGUFlGamVJNWx2ZVdx U3ZuYitDMm5BM0o4cnhOSXdQTGY2cAptakVaNDU4WkhDeFVkbEljY2N6QXE1ZjlKd0diMTZPWFl jZmcvbTFVY1R0Mzd3SmQ1eER3bEtobERuVStYLzNjCllWa1Uvcmw1R2ZncStBPT0KPUs2UjYKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Add a method to clone an arc from a pointer to the data managed by the
`Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a57ea3e2b44c..2c95712d12a2 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
         unsafe { Self::from_inner(ptr) }
     }
 
+    /// Clones an [`Arc`] instance from a pointer to the contained data.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an allocation that is contained within a live [`Arc<T>`].
+    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
+        // SAFETY: The caller promises that this pointer points to data
+        // contained in an `Arc` that is still valid.
+        let inner = unsafe { ArcInner::container_of(ptr).as_ref() };
+
+        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot
+        // overflow to zero. SAFETY: By the function safety requirement, there
+        // is necessarily a reference to the object, so it is safe to increment
+        // the refcount.
+        unsafe { bindings::refcount_inc(inner.refcount.get()) };
+
+        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
+        unsafe { Self::from_inner(inner.into()) }
+    }
+
     /// Returns an [`ArcBorrow`] from the given [`Arc`].
     ///
     /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
-- 
2.46.0



