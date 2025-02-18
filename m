Return-Path: <linux-kernel+bounces-519526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87926A39DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC723ACDED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8E26A0DA;
	Tue, 18 Feb 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeWEHhiO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDF26FA44;
	Tue, 18 Feb 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885353; cv=none; b=I2IdXeOe6pzJtz/pJt9nLCr2SsXkiD4Xsc0V6+bK43p+l1jxKnFpULBmAKuw4EJRQKYoFwMxNKBI3dFjtH7wK4OS/sOR6P6NySzrZFIHxs/8GjmggfSvW0E15JN9D0KAsQFnNFT7fVMxSFLFSBGHRdDy9+3Mq8cXZ3258WlccHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885353; c=relaxed/simple;
	bh=Ez4aj26Rj9v0Tc5hX/M4I+wHtR6Yagi0UV+Q7KodWVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OX9RwsQkCn8lHREr+E7U9SSEd1V/iHZrqpF8YkhjsoVyleE1Js4NZGoNLLJRD6TzvxODdYKoIbwU6yB+YCSQjiQvwfgYXmaUaFiIzKmR2YrZa4Tc29MtwdKyOt0c0yXuQE40Aa0O/jE1GxQNXhe21UhSo+Dyh2FTGrrQ2wH9j5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeWEHhiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5DAC4CEE2;
	Tue, 18 Feb 2025 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885353;
	bh=Ez4aj26Rj9v0Tc5hX/M4I+wHtR6Yagi0UV+Q7KodWVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LeWEHhiOChKpDCaVnffjNtrv/FRpoNfvfUmpPDdVJ3b2t/xkil7kcRHfnZU94k80d
	 dYbmInce+hLU5fAz5DJfSOb+TC86BKMnjFSOEmmOfvJces63qkRswuTmf8Hmii/SCB
	 /jrTkOjcM3EKHsnDcD4YAQNq+6mbyT/T6OaUmaDpn39xoditFYx5dAJ6iM3chcllWt
	 6/hYyMqW8XYXjG13xfdXsSK7CC5VMg3y+hYpLQdpOS9SC0OND11a+pHnmQoEN01Dwt
	 FISBUXOq5aUV1W24ok8a0+a/SqT8yb+2zMoHBHiV5J9EEyboLv1mXBOyD28Kub4Aiw
	 ZoNXmhtByPf5w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:08 +0100
Subject: [PATCH v8 03/14] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-3-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Ez4aj26Rj9v0Tc5hX/M4I+wHtR6Yagi0UV+Q7KodWVw=;
 b=kA0DAAgB4bgaPnkoY3cByyZiAGe0irHIh2mK2WwXbNVDufwNITe4i9OKLLfpI4G1lkwVGeoR4
 YkCMwQAAQgAHRYhBBLB+UdWv3wqFdbAEuG4Gj55KGN3BQJntIqxAAoJEOG4Gj55KGN3RCMP/0Nx
 y5tXia/7wo0PPkzyFt8tH1JzhoBlbp1F7dD2Cu4rHBnkoMdvXonDWbaNPEpa057799LMgu9DpAs
 rU0YU0zBgAczpfGw8VOPUR9rD6bFJdBRjLcVhsJGHBRf/qiiqFWgTh0Quio+L+v/V8XXu4b2c4g
 yZjTCXtToNBvj+MW2e6OKIEFFHLtbmPsXxZLnFt4Ou34YEucjBJ8H5LpDNFGp7vOb6RikgGVkm5
 BIk3aWrkpDXgv1s1RR6tsbfq5Dn2GfimTvMWowzUirm4JFpzKZOR4n9uYHhM4ViSbJZ3JjLsdt7
 TkDgo8Cu8kIqHLooiYnKbn5ZuEiZ0Y/1fDcVukncWmXsXt8oZQVW1t4BJl5Zg1QmbrVifwh0Ha7
 2bt63naeBXH0iz7gywbNeHcidkNttxgmTERITEldDQvfooZ6ScWDai3z4TFctDo2pKuUyfkoGRD
 Y4Yygbai8oU+Cerf8Ctb7QWLhheusEAJrT835spTE302TrQsnwGWFWTnUMhguCBOut4iSihKCnH
 EkMDSYWIxuIZKn44qHXiV5EfXwY7V4DTyCxdAAzH8fLbXWctGdnVZXfH1dD9N4Nt7Es54G8iTdm
 bnEamz5Kk+pgBJFVJ5rDFfCagNq0c/UtQmsYdnnhPpw67yWFuvDwlbOm7HRQNArBTDmJz+7IWsA
 kB0Ls
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to get a pointer to the data contained in an `Arc`.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---

This is a dependency for:

rust: hrtimer: implement `HrTimerPointer` for `Arc`
---
 rust/kernel/sync/arc.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a43725..1dfa75714f9d6 100644
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



