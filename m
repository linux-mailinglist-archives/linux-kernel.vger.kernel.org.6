Return-Path: <linux-kernel+bounces-554041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B4A59236
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903D13AA359
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DCB227EAB;
	Mon, 10 Mar 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OkhwnAdV"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576B227BAA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604246; cv=none; b=ZmngBhrEFagXIsn1/cWhrgJBOldH2aQd27rXCx9K4nv5FNGCVwMte8vmoNCeueHUfVynodhaUnxan7jmZBVVxUacR6kr1GIgHmULK8YmX2kgB4ZNPlXCcZsxaUHQMhUNDaaiQnusKRZi8b5pgP39auo92qHRoKeMtTTfqJwqKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604246; c=relaxed/simple;
	bh=61A/V3lwSclZiCJInLxEmepbN95X1sJN7svSDJK7DL8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FRC/7vokLkAsxrs498cCOA6A5WrFmvp1pB00qeLxhEuldkdMFnqbGWwxIW6dKGiPRwjfsC5A8jYf1Il0suFDvjeO6hdUnfdwPedJ3ljPgjNqaI5KbTibD6AGSAfUaxomJkg8LYUIy5zNLVbUku1IPJWhNrqRezX6haJvsO44kWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OkhwnAdV; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741604241; x=1741863441;
	bh=hLncp8wa6eofNjWes0vCOaYEUoMimwk7wJagoEBWPLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=OkhwnAdVH6mxIe70vbXH9uMKzaakcvCGlkmAMw0oF7uC2onBQvfXlnuSTeekZZB1Z
	 0Iriaz7UublqKawcfI9Pwra9Y0Z+NK9glPT9URoXAoHGhZUFVKOoCWJph76DHARziG
	 3Q2AsrC3YFiX2UybB6div6lQSAO+LbeGNeU+ta63C54lW085778t4Sn1RruR4KNDtJ
	 nkNcSrTHTVHF8ox+TqrrMA5tYQjiG2lSWs1M2+ZTBff1Gt4rtIMFvmi4hemsk0yaZe
	 UnqS3VZt/fgtejUXVTbq8KQv0Pn5i3I1WLLF0XNfWXorI+jDn+jlrgT+tbzqgcDiBt
	 O9YwJCHfVr4kw==
Date: Mon, 10 Mar 2025 10:57:15 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v7 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: c678b95834604c22f58371b93567e473988925a5
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

Oliver Mangold (2):
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



