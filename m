Return-Path: <linux-kernel+bounces-550828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28678A56496
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DE81898239
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485520E00E;
	Fri,  7 Mar 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DRnKGxWz"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC520CCCD;
	Fri,  7 Mar 2025 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341872; cv=none; b=VUJvX2fnOAsvFXQhOjYqWgti2OWqPqCgZsuC9UCuopurWh0YTq/4uZE9aEyqWnzbu2taWA5xhYB2rUdCHK9yy2x3GcteujExQ1nb4Aaj4Wyx+4UZMd67XZcz9Yt0qXfut/sH4JmUXpN03rQZmSTo6GMN66/3rCvNmz3Jd6sx63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341872; c=relaxed/simple;
	bh=egRFo9NMAA9KzbtxdSxLFxMjKPYWVfG5kJB14HxMM+o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUmEOJnsKvxqKXBCS0jgE/ObC5P5rDiuXhlJxrtgzT9xIfMfeJHGLyr0MVS1kL9agtY50EDKYdbCDqqpLcyALkoJUvYYD2SHUBHgHBbJOPNvjGrmExdj1JHQ7dnPTWVOWulQqvdPbYVvs5GtuTe2boDmr4kApl81BvJUhkxLeao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DRnKGxWz; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741341862; x=1741601062;
	bh=tHRq3IPn0p6dHilslzS4AMRjsMeM5Fcpnj4lA9LQfdc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DRnKGxWzrMepMTjOrUleGXgezlfqzRZCFPPhtjnVaImi3GZP7QeQKStImPnHcDr4o
	 GF9bqm9tx5nJvR/c+ScRlum4+iyjB5vnE3MhGqZ7Y4XTd9hf5PToAhM3+JDcg00oFX
	 TN/fOKft2L2KfJZXbkUGbN2IiCZ7jzMPQcDyhnOKUgMhK295Eh0eqWP51qcBHcFA40
	 pCjBeycwRMBzAPh5MONtJ5I3RlS6F4RAMNIRTNQXBfILHbjWMSHgsSfDC4EDpR/dxq
	 x8Tpt1MZ0tNFCsPhJWoDzazrXWihqC4tKOczPp7G9LZOhAPKop2+nQLuuhkbHr/Q2K
	 tuMg1vtwyW26Q==
Date: Fri, 07 Mar 2025 10:04:16 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v5 2/4] rust: make Owned::into_raw() and Owned::from_raw() public
Message-ID: <20250307-unique-ref-v5-2-bffeb633277e@pm.me>
In-Reply-To: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 4da456a556aebaee80d18f19a13684450dff6f0a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It might be necessary to be used from some drivers

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 0cae5ba6607f0a86d2f0e3494f956f6daad78067..e0ce3646a4d3b70c069322a9b0f=
25c00265a2af8 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -616,7 +616,7 @@ impl<T: Ownable> Owned<T> {
     ///
     /// Callers must ensure that the underlying object is acquired and can=
 be considered owned by
     /// Rust.
-    pub(crate) unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
         // INVARIANT: The safety requirements guarantee that the new insta=
nce now owns the
         // reference.
         Self {
@@ -630,8 +630,7 @@ pub(crate) unsafe fn from_raw(ptr: NonNull<T>) -> Self =
{
     /// This function does not actually relinquish ownership of the object=
.
     /// After calling this function, the caller is responsible for ownersh=
ip previously managed
     /// by the `Owned`.
-    #[allow(dead_code)]
-    pub(crate) fn into_raw(me: Self) -> NonNull<T> {
+    pub fn into_raw(me: Self) -> NonNull<T> {
         ManuallyDrop::new(me).ptr
     }
 }

--=20
2.48.1



