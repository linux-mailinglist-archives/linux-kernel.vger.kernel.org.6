Return-Path: <linux-kernel+bounces-558845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F74A5EC03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD39175194
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C351FBC93;
	Thu, 13 Mar 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kcqKEMp5"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB541FBCB5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849209; cv=none; b=LmSz6TPBvqIB7BlCpfCjae5bc2KImjgPsZ/Zjxs9cPsbSfnfztpIbrUU7TSmHnQ0S3LGjRBUU1mztOa+PBiS4RJShdk/ATBCdKvdDATAYCfl8x24fmjBT1fgDUwnvzC5PO2Z73Ems5AzDb8WPNBMAHjizNVtM8StvZtBKqWmEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849209; c=relaxed/simple;
	bh=BGUCEjt5SlMT9vb21bPFbp/fyZs2TbJTxwJnm4lO8Iw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mPVcSDHUBtdBnaR4Q2qDELBEsnMUTqET7a4DmXZHp5zOpKu16751mT63Bnp94CBHejiNDiILakJyXeFzt3hDlgu6822RJ8YFxs4qznl7dER1YfoHT6IQti/12RcUghwWp1pye93Fio1nZVrv3pLO94qDj2t6o7pVG843j0sAuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kcqKEMp5; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741849200; x=1742108400;
	bh=djQl18gs7ugtrECL7LEUFfDha//AOWkZdwb0B2q5pVg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=kcqKEMp5ddPpX7OXgTYtafMds2IU3pKu+hkM+W5ecg654TwMaAVS7fTYVaRMhh+TP
	 8zVp9nNJZuWpNXI4VYHCzhTIKPajBv2LGRGZRi7xDIjAvS+MJoyzmhwZejKebk5kBq
	 UrMgqtkJgVoohp57ujT7RYu4IAQqwpIAugeMJjwAhiXAtdBeRDw71LosB5n4i2VtmX
	 kLwHIzxjMrjJMOt3rbYDc01hD9Ms/kmyVTQ++fXorLQaMZ3f00jYQTxe832oAcRmwt
	 r2a2Ikrvr+1QAqldCkSte5fFeC+5YH6J7nL2l2+6qd+Jb0y21GmXZo76qbM6LalcIg
	 BW0JqGAajkwmA==
Date: Thu, 13 Mar 2025 06:59:57 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v8 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 77ac3587ed09bd5c63a3d260b1af78a4da19e7b9
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
 rust/kernel/types.rs            | 404 ++++++++++++++++++++++++++++++++++++=
++--
 8 files changed, 426 insertions(+), 31 deletions(-)
---
base-commit: 4b2ee22fe32ea9b255926effbb6f26450607c391
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--=20
Oliver Mangold <oliver.mangold@pm.me>



