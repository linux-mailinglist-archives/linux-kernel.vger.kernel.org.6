Return-Path: <linux-kernel+bounces-553766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2571A58E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869743A7670
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3441224245;
	Mon, 10 Mar 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="D4g8k9Xj"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAE35965;
	Mon, 10 Mar 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596587; cv=none; b=aifxku16aeY8eydbT06CfxKMOJomauKF63Yg/gLId08Q74umgqoycifDSNsrqqpfp826mIK47altU0xseYb7IeMcgtX8QzPed4r/z9RuTIHEjyH2pNoavPjI+B1I/xXBdlYXqoACbm6uey5AOMwd4AeNzb5yWYLy/8DfVrodGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596587; c=relaxed/simple;
	bh=gqM3NoEeAZm6/VzvYFvJOiBl1ItaG8rw5z+rKyEHlqw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W/bunRaaf5w15jJaucO/5EW8kysGlWieX0I+YGbUPCfvGns5YervsZgNpiEhOsDvEJDoRwnCe5Io2m/32JbDacyljCGKYunsTPhtVzRsWyo01zC7sfyZWjc7xMRtRoOHHdfNZMQ2ujgo27HN+11AnVp5/T/vIsSJ5AJlbn4A03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=D4g8k9Xj; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741596583; x=1741855783;
	bh=UYCu4LxmRD0Ub2TOub8oliHnzSoyOyvtTpbtXxWhWQc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=D4g8k9Xj/zBzpMYEWFef0kDFNzpw6pBWICxoUCWuWXPa7D9CxYgVRLe0GrEpKiLS7
	 qWPJ44wRK+0fM1vDMiujSYEFz/V9q4NScRTpajtxGBg1bgyEmUwYIMNQhFYkYAoW8Q
	 vTg+jt8z6T8ifZhYdv6HTynKTXarqDDgI8DI7Nw9WaYMhM0PpJ274qRq+w0vMAdYp7
	 oF1HKaJqaNCqbfkKksIYzWba76ReoMFRbvQn5A32TS4L5fZ5J0+BgUTDNTwufZ9hIq
	 W44RpYWqopoLkREXgFx3jSLr1/q2xYCpw3Ao8XS0/P2NHSZljYVv9JZThBWqVr5JcD
	 makno0fTjl/yQ==
Date: Mon, 10 Mar 2025 08:49:36 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v6 0/5] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <20250310-unique-ref-v6-0-1ff53558617e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: ea42df7de3f3ec312828a66d278f093500440502
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
      rust: make Owned::into_raw() and Owned::from_raw() public
      rust: rename AlwaysRefCounted to RefCounted
      rust: adding OwnableRefCounted and SimpleOwnableRefCounted

 init/Kconfig                    |   3 +
 rust/kernel/block/mq/request.rs |  10 +-
 rust/kernel/cred.rs             |   8 +-
 rust/kernel/device.rs           |   8 +-
 rust/kernel/fs/file.rs          |  10 +-
 rust/kernel/pid_namespace.rs    |   8 +-
 rust/kernel/task.rs             |   6 +-
 rust/kernel/types.rs            | 429 ++++++++++++++++++++++++++++++++++++=
++--
 8 files changed, 451 insertions(+), 31 deletions(-)
---
base-commit: 4b2ee22fe32ea9b255926effbb6f26450607c391
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--=20
Oliver Mangold <oliver.mangold@pm.me>



