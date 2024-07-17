Return-Path: <linux-kernel+bounces-255746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26D9344A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB231C216EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985FC4AEE6;
	Wed, 17 Jul 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RUhMl4/e"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10456766
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254377; cv=none; b=P+SK61L/8x5KGwZAQYaQjuDfHDksnlKvWWQyNP4R+VmX+SP5EXIrp4X//WQlVUTA/ldyW6n0n9LCZH0pbprIwwhGecXAPloFeeeB2y1JLbE7VRf0hj0t2LXPJr/C9UmbRRNfEW2HKxh8gHApKCEgPAeq7WvdsU/5uOf64jOOoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254377; c=relaxed/simple;
	bh=ONg/nFcBNrIzbLWP0TcanDXAe/zRmgKLYFbZ/oLUcg0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQ4b56Rn1JBiMPiNx4JQ9VVqfRsYJPWNabdtflph65uxYCBvn5GI0XsM2MssOA9H+Smfkk1GZ/Np9b7/L5jLE8kt4YLZ8Lr5qlZhhTGIjM0HBx6aiGVdEyWthY2YVxjHQ6dApy4tqyQpsXMLhSuA6j4LjreS4EmdV6bF3TyPixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RUhMl4/e; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721254372; x=1721513572;
	bh=oz6BK2MUmyOZPB0wPkkUnoUOUyDBcVri6eLFVMypisA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RUhMl4/eWLf6HlbiTez6FwBvrNoAi+edyyY+hRRYGxHwWl9IPZDq2V+ECsqc8XdnT
	 +iX+m5ic8NGvX0fewA4KstzZN6yg7CQMNbLVB+irTD5j2vWquvMEpvD4UXkUjdyfRx
	 80zXNd0ESx91KyPfyVFK+bT0k9WMTzCaE9Y8LV7tVb0Q4JgQKED9FD2V4CRshMIQ2r
	 +VQVhSPy8YkMu5r42pubahgC7XZAH3puJFGYcgXAyWW9qlTfakiqg3R22Jr9wg5chr
	 PIfZwo46E6xtE2QmWBsDoPtK+UHN4O5AdnnZumvuW9XIqVnBFF+ushKqckwav3uVIJ
	 yBEq7WTsrnQ5w==
Date: Wed, 17 Jul 2024 22:12:45 +0000
To: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 3/5] doc: rust: safety standard: add guarantees and type invariants
Message-ID: <20240717221133.459589-4-benno.lossin@proton.me>
In-Reply-To: <20240717221133.459589-1-benno.lossin@proton.me>
References: <20240717221133.459589-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: acfa0d42b8ce024edca46e621c7bf4a4ed0f08fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add documents about `# Guarantees` and `# Invariants` sections.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 .../rust/safety-standard/guarantee.rst        |  9 +++++++++
 Documentation/rust/safety-standard/index.rst  | 16 +++++++++++++++
 .../rust/safety-standard/type-invariants.rst  | 20 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 Documentation/rust/safety-standard/guarantee.rst
 create mode 100644 Documentation/rust/safety-standard/type-invariants.rst

diff --git a/Documentation/rust/safety-standard/guarantee.rst b/Documentati=
on/rust/safety-standard/guarantee.rst
new file mode 100644
index 000000000000..4d8c811c2bed
--- /dev/null
+++ b/Documentation/rust/safety-standard/guarantee.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Guarantees
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Functions and ``struct``, ``enum`` and ``union`` types can list guarantees=
 that ``unsafe`` code can
+rely upon in the ``# Guarantees`` section. Guarantees are listed in an uno=
rdered markdown list.
+The wording of guarantees is identical to the wording of requirements.rst.=
 To refer to the return
+value of the function, use ``$ret``.
diff --git a/Documentation/rust/safety-standard/index.rst b/Documentation/r=
ust/safety-standard/index.rst
index bebebda06831..40b17f59709c 100644
--- a/Documentation/rust/safety-standard/index.rst
+++ b/Documentation/rust/safety-standard/index.rst
@@ -221,6 +221,20 @@ similarly to :ref:`unsafe-Blocks`::
     // SAFETY: <justification>
     unsafe impl Foo for Bar {}
=20
+Guarantees
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Functions are also allowed to declare certain guarantees that ``unsafe`` c=
ode is able to rely upon.
+For example when returning a raw pointer, a common guarantee would be to s=
tate that it is valid. See
+guarantee.rst for more info. Importantly, guarantees can also be given by =
safe functions.
+
+Type Invariants
+---------------
+
+Type invariants are a kind of guarantee. Like their name suggests, they al=
ways hold (invariant --
+never changing). They can only be specified on ``struct``, ``enum`` or ``u=
nion`` types. See
+type-invariants.rst for more info.
+
 General Rules
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -246,6 +260,8 @@ Further Pages
    :maxdepth: 1
=20
    examples
+   guarantee
+   type-invariants
=20
 .. only::  subproject and html
=20
diff --git a/Documentation/rust/safety-standard/type-invariants.rst b/Docum=
entation/rust/safety-standard/type-invariants.rst
new file mode 100644
index 000000000000..dd7e9bda80e5
--- /dev/null
+++ b/Documentation/rust/safety-standard/type-invariants.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Type Invariants
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``struct``, ``enum`` and ``union`` types can list type invariants. They ar=
e a kind of
+:doc:`guarantee <guarantee>` that ``unsafe`` code can rely upon. They are =
listed in an unordered
+list in the ``## Invariants`` subsection of the ``# Guarantees`` section. =
The wording of invariants
+is identical to the wording of requirements.rst. Invariants hold for the e=
ntire lifetime of an
+object. During the call of the ``drop`` function these invariants may be v=
iolated, since objects
+that are being dropped can never be observed.
+
+Objects with invariants need ``INVARIANT`` comments whenever they are cons=
tructed or a field with an
+invariant is modified. The comment is similar to ``SAFETY`` comments and n=
eeds to justify that the
+invariant holds. See justifications.rst for how to justify requirements.
+
+Sometimes it is needed to violate an invariant temporarily. For example wh=
en inside of a function
+one can temporarily violate the invariant, as long as it is later reestabl=
ished and no external code
+can observe the violation. These violations must also be documented using =
the ``INVARIANT``
+comments.
--=20
2.45.1



