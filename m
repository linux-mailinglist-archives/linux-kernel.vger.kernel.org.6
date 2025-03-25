Return-Path: <linux-kernel+bounces-575240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353DA6FA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1CA7A3497
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BC2571B3;
	Tue, 25 Mar 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LJfndCG8"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC64256C75;
	Tue, 25 Mar 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903839; cv=none; b=g8MiflRpIoG8u1ApnjSMvf7Sg5CBWJ6a7ykdpQYtRfUovLi3UgToU3EpbU/GC7EC9PQIFXtwgWom7vg6A/HUVhYflXHggYOhDS6MadL7g4dlA2iHWBuGWLe07g2xqXnKR4ijbf6p64pz46h7hKVFVMoXb7q5FatkYJa2YvItolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903839; c=relaxed/simple;
	bh=uv5rEwAfI35mfYtsO1888nhbQoqLbcOMTGbeJXWesG0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjmbc2xQqSJdAC8t6vYo9SQnG9dV2NskU0O3WDLmKj+WgVDP9dzoR5aDP6dFxbO/LAqhzAy+m6xmSVrWoUG26eAtnhTUmS9OvVrGlEnOMmh9wBNydvtUbDPPP5EHPEBrYBndXLCoystNZtrtMPdvxE7CujYU/y27nJXpysxWUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LJfndCG8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1742903835; x=1743163035;
	bh=Jj+pkc9dXCPRhxKy38w7QrkzQjWUmpLLTYrhXmW1nM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LJfndCG8QXjvnnvOEq+z/9nAbAPHBP8O4rxmIKS85querz4GXVepUOJzR2Io2bhBk
	 ZjUDN/gmgkzSfouiIaO4lSDzM7mVlMv2zQzMXsVoxtXnKWhQU0tqpuCPPni5MQUyv7
	 WcMB3btfd7XxkuO4wsJjruFM124VUhoDVqVkG00yyITcyGSRofit/3AJu2THZArC7+
	 Oem3nIyGtCaR9dmbyrhYDpVf/Ljm0LJkF9SrTgX1qVBtxhQDbg+l96clSI/x/a422i
	 XKhWMuO8Optc0RaNnPQFJ49Gv/w0NxveKzrG8xdtbwUYiHwmYGZc/psQxo1sM5uj8Q
	 +/FNBoLfAWoVw==
Date: Tue, 25 Mar 2025 11:57:10 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v9 3/5] rust: Add missing SAFETY documentation for ARef example
Message-ID: <20250325-unique-ref-v9-3-e91618c1de26@pm.me>
In-Reply-To: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
References: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 4ead0c349680fb35e5ec173d31ea0aaf1fa7397a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
 rust/kernel/types.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index c8b78bcad259132808cc38c56b9f2bd525a0b755..db29f7c725e631c11099fa91229=
01ec2b3f4a039 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -492,7 +492,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: We do not free anything.
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -500,7 +500,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data =3D Empty {};
     /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: We keep `data` around longer than the `ARef`.
     /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
     ///

--=20
2.49.0



