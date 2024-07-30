Return-Path: <linux-kernel+bounces-268024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D3941F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E37F282581
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207418B467;
	Tue, 30 Jul 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NJk564pU"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFC18A6A9;
	Tue, 30 Jul 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363801; cv=none; b=Dn8ILWYgRdYT/+cc9cvSBNo5IjMFlTHUr3R7ggSBpdcqMsNlC97ACc9Kn4ZhCPpikCU/iJiLI1U2F18nhe012yLoErb/yf5T4tKdPeJYiKB+aXBSL81S3NjAkbfn2L1QMYgDinJRLLLlCxyC8kaBFECM/X6BE5uN1olGpI1mVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363801; c=relaxed/simple;
	bh=jqWHMLlBfs0E7tVTLVJoMjr6kf+df8ncwqCODbBgApg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=A5vWzwFnAGn8VUMo2V0hcK6xn5h7p/YvnEDkcFkC1JIXEYLgI6abG5BMTKisrJQK7OqGmi5dCUhAKIwH/Or5HgxWVmGZsGv1ctw1/XCudOWeK43FMVgqfE2TqITm90nhT8u6GhewWALgraslen2kfHEyIRkJOyCGvP6tNfEJS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NJk564pU; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2n4xgnck75ebxihhzb4mhzjq2i.protonmail; t=1722363792; x=1722622992;
	bh=VtiI+AVVb7X9vRbJuCaUOBusb2ARD7uslQ3MY9nSpeI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NJk564pUQXg9usYQXymdm1YbkIG0YR/YnlpZYe56og6pfELpNZto4BPsV+VrixkfV
	 5flUBOFWtBMsRUq3ROX+pivqcmUNnKwJKjAekkDsHyjooFNW3rb/D7NH2QDrXGXCrY
	 wAE9/mZXuulLeUeM4XBPdzuGWwAU9DrFb7igfhN9GEyqFzYPq7zFSCoto+vsX1sKPQ
	 4HZOBPf8YWiKoPl+riq/ftIqxua8BrQPPn6KLE3IUEitF+DyEVw7rrZ60TZIZllD1X
	 iBqIECrmiqvJmOLrScXg5rvcNQLzTh1qwTxl7DXu+FibqA5/pXzIQp6lGfIIPwDmi3
	 7DhUkUVbUBAhQ==
Date: Tue, 30 Jul 2024 18:23:04 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: types: improve `ForeignOwnable` documentation
Message-ID: <20240730182251.1466684-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 12f6702fb6a6c68c58ee66c46826ef1b7c26c565
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There are no guarantees for the pointer returned by `into_foreign`.
This is simply because there is no safety documentation stating any
guarantees. Therefore dereferencing and all other operations for that
pointer are not allowed in a general context (i.e. when the concrete
type implementing the trait is not known).
This might be confusing, therefore add normal documentation to state
that there are no guarantees given for the pointer.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/types.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..0306ec4010a7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -26,7 +26,10 @@ pub trait ForeignOwnable: Sized {
=20
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
-    /// The foreign representation is a pointer to void.
+    /// The foreign representation is a pointer to void. There are no guar=
antees for this pointer.
+    /// For example, it might be invalid, dangling or pointing to uninitia=
lized memory. Using it in
+    /// any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwna=
ble::borrow`],
+    /// [`ForeignOwnable::try_from_foreign`] can result in undefined behav=
ior.
     fn into_foreign(self) -> *const core::ffi::c_void;
=20
     /// Borrows a foreign-owned object.
--=20
2.44.0



