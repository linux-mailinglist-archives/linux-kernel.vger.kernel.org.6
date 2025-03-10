Return-Path: <linux-kernel+bounces-553768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4CA58E91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F71A7A25E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBB8224258;
	Mon, 10 Mar 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PEqfv7xm"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE4224245;
	Mon, 10 Mar 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596602; cv=none; b=W0lwoSPf5HQN6oHm2b3M1f5ncz1LqibYez8I9HAW1yKRobfDb4epTIxnZs2258YhRt517GMe0Hlsl3fA/nzFjOQWi2ndRcSVCjT3GsKST37MAFY4BR73ntyjBnfkWz6696vf8/PxkS0rQ0J1U/N1p8ZHQ38Gbd5hBEFA4veX1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596602; c=relaxed/simple;
	bh=3g6HqJALm9PC2X7ZPY/+eNaIsmJ1fVUeN5WwfZCJNOU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNaUfSnY0DC/xM0AceEt39AxZMMW8w0ZfuItw3Fxn9Bw4vX8/PAFnZtEJQvlHxE42yK0EaTVXL09UelzxRg8OMQ2nOzel9Zudbas8tbTkg7E8B89kaTFUODv2heNrGbaW5t/Xzew0nnDrmYyoMkNGGC0NtCRttKmdDyKZoFS+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PEqfv7xm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741596598; x=1741855798;
	bh=Hq1lq/+K9Z2N4w2heo3+vMaGQX0iUM1anpEHyba8+iM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PEqfv7xmcP9nkb89WvXdAVkYBM6tCDsiyFF8n7sYkMzNw0saUAWk+XgjC+BScg56l
	 fTP43I8qjUsgUGPEXxPwefO/7zdChrszeiOo0Y1G/G0agVDwNRdsn0x2VB7Ykgev0h
	 BvCqqgVRcZTBTBJm4w8Cbacp78trwCpYVNdUORS4P7wZj9jGjfvwgz3f7ZA1UoRCCg
	 lE8+VVNJs7kcShBLe6ISjn2ocsKc8HBQDEDM/zvV1VuSa1rz3s8wt7OTM82+68L9Y7
	 zKJkhDX8jNDWDbokJsOEkAb5x23M8c7Qo8hrKvNjCpHyNGCjRaArzaWDkmk1bWBcmw
	 aaWnJELvOJkMA==
Date: Mon, 10 Mar 2025 08:49:50 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v6 2/5] rust: make Owned::into_raw() and Owned::from_raw() public
Message-ID: <20250310-unique-ref-v6-2-1ff53558617e@pm.me>
In-Reply-To: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: df77e08561b794cff6297f2e11ce8472c0595ab9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It might be necessary to be used from some drivers containing C code like,
e.g. binder. It basically is needed for every implementation of an Ownable
outside of the kernel crate. Also the examples for OwnableRefCounted need
it.

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



