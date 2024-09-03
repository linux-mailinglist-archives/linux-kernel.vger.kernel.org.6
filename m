Return-Path: <linux-kernel+bounces-312593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4F96988D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EE01F23355
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764A1AD24D;
	Tue,  3 Sep 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="COv944RY"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915391A265F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355043; cv=none; b=pcYI81vGmYNklksewHD3kPn5DmjkjvExmLuns2GVpXBILzi7iS4bpkTAV6OYveku3QL5zhTgh8T4pzBd86mULKCgKjkVjCJnotTHAhu3rlpQJaPyyAWMk1+u0zlgtQ5KogcmE8HBapsuU0nZudPy5LjpqO40hD5471JUh51nLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355043; c=relaxed/simple;
	bh=veMtTO+Zq9LEs64H0Eo0ZdYVc1H+p4j+N/1YNfHm99o=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MvzmDPUuAja4X+0NBqpGoBh0OSdtVmuVMfQ7PV5MyZMGmSjUP92xKmzYNnka6mTb4N2oApqZK0BD/7rmBefEDxSkziuBMf73/YF4hoCi8D0hRoGtruadM/P62yuL5CNxHkrXq+8nsIaAtL+x/O5N6a+k71DC7dCIhSv+3DY1hHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=COv944RY; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725355034; x=1725614234;
	bh=F89AGc4Si2DckedbN1VwOKWOLa5WaiFl9fYAV1+w5JU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=COv944RYqVX6c5U0klnN4zEKSfB3KApMaQq/SZP0Vzdt32W+ZFHanZ6nt9NO/dAEv
	 q6RWAE025g7Hio4/25KyR7GWvPtVQQ7pXrFclnh40zvrHpdGm4O71rhNxVWS9TQU9s
	 8PeEfu42x5v8pOJfy5ZczpzcK3mjtoWRlmZK8b87EPmECfnCpn0jDVWbx3ZoS4g0mk
	 tFDrO0bejzzGnvmnKuV20EVf1xkVH3r4fG04sbGCZ0NvpnFXDgLZJmQO7lTkDe9dbG
	 6k6XoMnML650/jTzKZY3zrE9kqZ1MHRwiHC+68Lx1sqVecThY9FlsO/2uH7Y6UC1/R
	 x9AwCrRNwfZeQ==
Date: Tue, 03 Sep 2024 09:17:10 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: sync: require `Send` and `Sync` for `Backend::State`
Message-ID: <20240903091700.172734-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d1cdb3d0d6cde0625d711fe8401f49319c769020
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`Lock<T, B>` implements `Send` and `Sync` when `T` is `Send` or `Sync`
respectively. Since this does not depend on `B`, creating a `Lock` that
is `Send` and `Sync`, but with a `!Sync` or `!Send` state is possible.
This is a soundness issue, thus add the bounds to the respective impls.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/sync/lock.rs | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..e73ac9d97b29 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -97,12 +97,23 @@ pub struct Lock<T: ?Sized, B: Backend> {
     pub(crate) data: UnsafeCell<T>,
 }
=20
-// SAFETY: `Lock` can be transferred across thread boundaries iff the data=
 it protects can.
-unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
+// SAFETY: `Lock` can be transferred across thread boundaries iff the data=
 it protects and the
+// backend state can.
+unsafe impl<T: ?Sized, B: Backend> Send for Lock<T, B>
+where
+    T: Send,
+    B::State: Send,
+{
+}
=20
 // SAFETY: `Lock` serialises the interior mutability it provides, so it is=
 `Sync` as long as the
-// data it protects is `Send`.
-unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
+// data it protects is `Send` and the backend state can be shared.
+unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B>
+where
+    T: Send,
+    B::State: Sync,
+{
+}
=20
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.

base-commit: a335e95914046c6bed45c0d17cabcd483682cf5e
--=20
2.46.0



