Return-Path: <linux-kernel+bounces-312592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9796988C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415D21F22935
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDE1AD24B;
	Tue,  3 Sep 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IGXOM+p+"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A71A3040;
	Tue,  3 Sep 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355043; cv=none; b=e3QDD4oIETuXtL3DCwLtV2k2iw65HtXVkf7RHR0EBvUbUn8aqnWWTKDDFExyjfEgDK+7KSy0wcTt56xk0TiTc5Xh5I+b1a9gOsqHqSFLwTpvq6o2kki9n1gjJ5F/B2p5wiGsC4v9PKQ2mfAr64qSIKSJsU2RJ7DJocF6KQaelPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355043; c=relaxed/simple;
	bh=WMOLNLEuu79pWx/Bm+nM0LfbddfQQ5r7RhYkLkL+6pk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euUA9bGW5VFOq5nvhtQc3WFeowm8zODpjuNKlc1T1wxeuZ+AEuMVQwOPTCDLWEj545W2pM6n9wbKe/0WnW+szrnky3HVvcvTvyUX9rWVgQL9AZ8RKhFb1GZlvwCZqGrJxSJ16b6cnhxuRj1kTcSSXqy4/OF3xpbWX0r1qfG6gSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IGXOM+p+; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725355040; x=1725614240;
	bh=1q2ZyqwbBX+dwifVasitzAtKlq2IOaoabRbdNMrLue4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IGXOM+p+iZ5s6mmJ1GYocJ5qGtaA2hhi6bxTGvwsI/YnNc0nAqQSZDi+OkPhqsNkm
	 A3lAxqV85YagkuAVnuMP2Q3Wd15bbK6FfPJXKDqZSGpqOUQLu5qCquC/0ySj2Sipa8
	 ADyC+JpiQu3jU8Co1I3MX5JxZ0rcmm8yHCnvm7XUYK/w+IPrb85AAqkhLTxWBewB35
	 opJG7+NDZsmrdxXaLX5882JE9dgu0dz4mLpRfqPN0VyE5L/9argdlUwppzmOCm9fGS
	 T6QxueDwhW3GMG0SFv0wFH+cFVkavjsRHu3rTiVYqxbQYaE7cd83ewwA0kFig7Mser
	 9dnXN2Gg9GiEg==
Date: Tue, 03 Sep 2024 09:17:16 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: sync: require `Sync` for `Backend::GuardState`
Message-ID: <20240903091700.172734-2-benno.lossin@proton.me>
In-Reply-To: <20240903091700.172734-1-benno.lossin@proton.me>
References: <20240903091700.172734-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a0625bdc9e38187cbe73ad7d2cb7270e734f7347
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`Guard<T, B>` implements `Sync` when `T` is `Sync`. Since this does not
depend on `B`, creating a `Guard` that is `Sync`, but with `!Sync` state
is possible. This is a soundness issue, thus add the bounds to the
respective impls.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/sync/lock.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e73ac9d97b29..336ad2f0ec06 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -153,8 +153,13 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
     _not_send: PhantomData<*mut ()>,
 }
=20
-// SAFETY: `Guard` is sync when the data protected by the lock is also syn=
c.
-unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
+// SAFETY: `Guard` is sync when the data protected by the lock and the gua=
rd state is also sync.
+unsafe impl<T: ?Sized, B: Backend> Sync for Guard<'_, T, B>
+where
+    T: Sync,
+    B::GuardState: Sync,
+{
+}
=20
 impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
     pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
--=20
2.46.0



