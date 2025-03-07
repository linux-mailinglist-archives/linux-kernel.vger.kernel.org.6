Return-Path: <linux-kernel+bounces-550827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC92A56495
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C31897DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23920DD75;
	Fri,  7 Mar 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VaICkP4u"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43820E018
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341862; cv=none; b=aTBWz6G7FlV+GPb+ZY4XHstX0cD/TA5TVZtMPHm6vqxjrgaSwWyGPBrARyDK4C1gt3lNJEKFtBVRDDmnr00ePoE3wIZFecYK8/JVQ4+iFJEj4EBNWuS1bH317hGaxpBkOqi/5rxRNW+9ACdRlQ6VRaFXNcWd57CmWKNKYJThw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341862; c=relaxed/simple;
	bh=90QTGs32AVSI2VPyezjC4MXe2zHbVhBn/KoTJEbuTnI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oKwnT4uyrXYpztZA9CctDctrkkI87sRzZpQgT/tTtTGMYvTbgGFbcaqC+ncvgesneNjb366nrDoHp3UnG89t34a1fo6Hou1JihCHB/6f7tV50J8IgkaDAFm0IURtrWShmImyiyhZMQtGknB+JkVh5Pl6kIHLKt8P1X1ygkWD7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VaICkP4u; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741341850; x=1741601050;
	bh=/LuWRpfcUgT1jCP92H5hhq9N4YDUmLEzZnbmTQBxK+w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=VaICkP4udZ8d2Sv4S5DSlDK10fOVF8qm6Tp9HnuAolxjDE+7T6bsLGSVdbt9ja6U3
	 dhAgBvhvdbHrvNgd82l5CeGyQz15+ejN4cobnYVBWJukYkgM9nAtKBookO3qRdgPT9
	 LrvL9MeTMGV/kWE4i3a5i+UzpqHdQ21TYdkB3OwCdORtOkpV/n6oQJmEFjW4plDhuw
	 zIxGyc4q2G4CZJFBg2DCPyjxeV1ttU2eIXjb9p/wqmSnGM44X8gBOTLBqUWO2peGZh
	 Caa7aQ69eg5pIJXDK0kgIv2PiEvMHLqO2oXUo8rV94B11bK6kANX31Thd9VidISB5u
	 8oqgsMCngqtTg==
Date: Fri, 07 Mar 2025 10:04:04 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v5 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <20250307-unique-ref-v5-0-bffeb633277e@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: aee66c4aa5d0a23295b7c21e27f221bccab1317b
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

Oliver Mangold (3):
      rust: make Owned::into_raw() and Owned::from_raw() public
      rust: rename AlwaysRefCounted to RefCounted
      rust: adding OwnableRefCounted and SimpleOwnableRefCounted

 rust/kernel/block/mq/request.rs |  11 +-
 rust/kernel/cred.rs             |   8 +-
 rust/kernel/device.rs           |   8 +-
 rust/kernel/fs/file.rs          |  10 +-
 rust/kernel/pid_namespace.rs    |   8 +-
 rust/kernel/task.rs             |   6 +-
 rust/kernel/types.rs            | 422 ++++++++++++++++++++++++++++++++++++=
++--
 7 files changed, 442 insertions(+), 31 deletions(-)
---
base-commit: 4b2ee22fe32ea9b255926effbb6f26450607c391
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--=20
Oliver Mangold <oliver.mangold@pm.me>



