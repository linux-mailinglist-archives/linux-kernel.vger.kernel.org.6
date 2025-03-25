Return-Path: <linux-kernel+bounces-575236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4AA6FA17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD527A2AED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452EF2566CC;
	Tue, 25 Mar 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="elfqrEPc"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F31EE7A7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903814; cv=none; b=KXKPGSH2b959aKnHdRMKUT3EayrQjvRpqLs2vRLnRu5CGgapncTX/HmXD+3/ImAKLR1znMXoTvcrHsO4FFdFlG6VyiUvTYFCqi7EzHjz0vEVv72ygJiqZZ2ThWt2l9EebBuTEvLKkNcnWlbfqSEmc5gHNg/KJTbrfVltb6h6JM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903814; c=relaxed/simple;
	bh=/veQsmJRJkFPwTpVtC24skqDVFzsfq6j8ZEad3AT74w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IVOdGH2vp5foE9ckHxCEu6Z6VyL8L9fIAOAImCXG1uUUvZ1IlcoV1mj6wkKh4Uqi+IWIzQaThF3gG4NvjvkuDMeG1UQbl4V2QL5ZbmbQKgfKqpGJhylUgHJ0Kog7bHgqxkFMqyuJHUI3Y+aW2jAbUDO0uMC4i4yC8VLpNfliWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=elfqrEPc; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1742903810; x=1743163010;
	bh=v6lQz0HYJecdhWoMvg3cUlowCPMGGjXT5G7g3iRES2I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=elfqrEPczvxfkp+Nf9JaJ/vwr4Planf/GhJ5cUeaXRdMZE3gCrCyLMmFbRbt8HZKY
	 0RjbsgNEzBVLS8+2NFeEC9ly0dbrN1tM8nK4oedyM0nRA6tQEGvXOe1QsI7TlCr2gh
	 V1MOrGtjs2ZYrAOi6h+450r+qU5giGEBlYdr6SqcDs4IyzHm+K2or9gDvZodEwk+Zc
	 tCr1B+rxJXvB1nBpmo66nsE6NZAUuJveWxCHJuBWzXZVRJPluZF+57U9dlKmQyhslo
	 hpFhlLonNSGdfBvswVmovkcRc0xLM1Vr29uJ3vSY+x8z8Qn0QSvUP5s8hyBTPVVKQy
	 2yVXl3qdSD3Xw==
Date: Tue, 25 Mar 2025 11:56:41 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v9 0/5] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 4feff9af5bec964a35bcf6467fc471a240af4a5a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This allows to convert between ARef<T> and Owned<T> by
implementing the new trait OwnedRefCounted.

This way we will have a shared/unique reference counting scheme
for types with built-in refcounts in analogy to Arc/UniqueArc.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
---
Changes in v9:
- Rebase onto v6.14-rc7
- Move Ownable/OwnedRefCounted/Ownable, etc., into separate module
- Documentation fixes to Ownable/OwnableMut/OwnableRefCounted
- Add missing SAFETY documentation to ARef example
- Link to v8: https://lore.kernel.org/r/20250313-unique-ref-v8-0-3082ffc67a=
31@pm.me

Changes in v8:
- Fix Co-developed-by and Suggested-by tags as suggested by Miguel and Boqu=
n
- Some small documentation fixes in Owned/Ownable patch
- removing redundant trait constraint on DerefMut for Owned as suggested by=
 Boqun Feng
- make SimpleOwnedRefCounted no longer implement RefCounted as suggested by=
 Boqun Feng
- documentation for RefCounted as suggested by Boqun Feng
- Link to v7: https://lore.kernel.org/r/20250310-unique-ref-v7-0-4caddb78aa=
05@pm.me

Changes in v7:
- Squash patch to make Owned::from_raw/into_raw public into parent
- Added Signed-off-by to other people's commits
- Link to v6: https://lore.kernel.org/r/20250310-unique-ref-v6-0-1ff5355861=
7e@pm.me

Changes in v6:
- Changed comments/formatting as suggested by Miguel Ojeda
- Included and used new config flag RUSTC_HAS_DO_NOT_RECOMMEND,
  thus no changes to types.rs will be needed when the attribute
  becomes available.
- Fixed commit message for Owned patch.
- Link to v5: https://lore.kernel.org/r/20250307-unique-ref-v5-0-bffeb63327=
7e@pm.me

Changes in v5:
- Rebase the whole thing on top of the Ownable/Owned traits by Asahi Lina.
- Rename AlwaysRefCounted to RefCounted and make AlwaysRefCounted a
  marker trait instead to allow to obtain an ARef<T> from an &T,
  which (as Alice pointed out) is unsound when combined with UniqueRef/Owne=
d.
- Change the Trait design and naming to implement this feature,
  UniqueRef/UniqueRefCounted is dropped in favor of Ownable/Owned and
  OwnableRefCounted is used to provide the functions to convert
  between Owned and ARef.
- Link to v4: https://lore.kernel.org/r/20250305-unique-ref-v4-1-a8fdef7b1c=
2c@pm.me

Changes in v4:
- Just a minor change in naming by request from Andreas Hindborg,
  try_shared_to_unique() -> try_from_shared(),
  unique_to_shared() -> into_shared(),
  which is more in line with standard Rust naming conventions.
- Link to v3: https://lore.kernel.org/r/Z8Wuud2UQX6Yukyr@mango

---
Asahi Lina (1):
      rust: types: Add Ownable/Owned types

Miguel Ojeda (1):
      rust: kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol

Oliver Mangold (3):
      rust: Rename AlwaysRefCounted to RefCounted
      rust: Add missing SAFETY documentation for ARef example
      rust: Add OwnableRefCounted and SimpleOwnableRefCounted

 init/Kconfig                    |   3 +
 rust/kernel/block/mq/request.rs |  10 +-
 rust/kernel/cred.rs             |   8 +-
 rust/kernel/device.rs           |   8 +-
 rust/kernel/fs/file.rs          |  10 +-
 rust/kernel/lib.rs              |   1 +
 rust/kernel/ownable.rs          | 361 ++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/pid_namespace.rs    |   8 +-
 rust/kernel/task.rs             |   6 +-
 rust/kernel/types.rs            |  53 +++---
 10 files changed, 436 insertions(+), 32 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--=20
Oliver Mangold <oliver.mangold@pm.me>



