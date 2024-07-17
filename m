Return-Path: <linux-kernel+bounces-255748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85589344A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A161F22565
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6292537E9;
	Wed, 17 Jul 2024 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h+Nynthh"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5F6EB7D;
	Wed, 17 Jul 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254395; cv=none; b=igPAUDYpHSSyEHEwJp/+MiCd2RyjTtzZqQBEdMwQ3J8KDWdv9oFRSKI/6MizGHOHY8LKhA6OLf8JQoXpFe8pvvlgpEJxZyTkAp+N9vLbv3uFcA3vTr77PlHUfvRZtnHxzwmTQHBzqLM4iBaf62Fn9q/GPnbS1d27jzW7NIuc3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254395; c=relaxed/simple;
	bh=SzS73QiMWiEvVE+b2kR/L9XlmDBOUmYyziDiW39xuTI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STt6Xa+MJXuAoY7HtciKqgNjJLow4K1/Z2go+2ZWDr5nAtCzAd38+8rQ16NTL9k0uYFNspwgkxk5kNATqmThjZEBXOv2Fvm6tZDmwnpyM35f4F7kz79lbl5Idjf8GIkUpTcicWl2XIen+52W0a657EP/e4xcko3IQDxgbytwueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h+Nynthh; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mqb22iym45enpg4fxdy2ivo4ta.protonmail; t=1721254388; x=1721513588;
	bh=9nFMx1FKFdNLaHQF61hemh/G8y0CQiLx5SxJJKIyYVw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h+NynthhFVzd3zVECZ3wv2HCOt5XD+hfbpOXkypP/60ILgy7jiMbPcq8EEGguiqcZ
	 s02I9zXoWiRi2D8S5Fpa+N0Aa26s4iTuf40rrpMQo3TIowWoPnj1AuC4IjgfAWllH4
	 QN1ewS7DmMR6F85g2t1wByapCalmt0CbFuqKpkYK+/4i9i7ra4cixYR6NmiQFRntWM
	 2ChO6bDIOpWJViNuEp5hlhiqTkwirlF3fFzxnCruhipiqd6RnylClnnkzK3knNuTus
	 QZKuhqOvZeFran0w4LiVG+PTD5niOxQ8gx0WCkwyoHl5IiBcerWIns+3WcMPVKMmCG
	 Z6ISFy+rZbe7Q==
Date: Wed, 17 Jul 2024 22:13:01 +0000
To: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 5/5] doc: rust: safety standard: add justifications
Message-ID: <20240717221133.459589-6-benno.lossin@proton.me>
In-Reply-To: <20240717221133.459589-1-benno.lossin@proton.me>
References: <20240717221133.459589-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 73d5a838551154c1c13817a2765de1d74e91bed0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add standardized justifications that are used to justify the safety
requirements.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 Documentation/rust/safety-standard/index.rst  |  5 +++
 .../rust/safety-standard/justifications.rst   | 40 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/rust/safety-standard/justifications.rst

diff --git a/Documentation/rust/safety-standard/index.rst b/Documentation/r=
ust/safety-standard/index.rst
index 2ef82d7dfbd8..db62ad01ebe0 100644
--- a/Documentation/rust/safety-standard/index.rst
+++ b/Documentation/rust/safety-standard/index.rst
@@ -191,6 +191,8 @@ block. For example::
=20
 In this case it is more readable to not split the block into multiple part=
s.
=20
+See justifications.rst for a full list of standardized justifications.
+
 ``unsafe`` Traits
 -----------------
=20
@@ -225,6 +227,8 @@ similarly to :ref:`unsafe-Blocks`::
     // SAFETY: <justification>
     unsafe impl Foo for Bar {}
=20
+See justifications.rst for a full list of standardized justifications.
+
 Guarantees
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -267,6 +271,7 @@ Further Pages
    guarantee
    type-invariants
    requirements
+   justifications
=20
 .. only::  subproject and html
=20
diff --git a/Documentation/rust/safety-standard/justifications.rst b/Docume=
ntation/rust/safety-standard/justifications.rst
new file mode 100644
index 000000000000..72b6943f3d40
--- /dev/null
+++ b/Documentation/rust/safety-standard/justifications.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. highlight:: rust
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Justifications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Since there are so many different safety-requirements.rst, there are also =
many different ways to
+justify them.
+
+Justifications are listed in an unordered markdown list in the ``SAFETY`` =
comments on ``unsafe``
+blocks and ``unsafe impl``. The order and elements of the list must match =
the list present in the
+``# Safety`` section on the respective ``unsafe`` item (e.g. the function =
or the trait).
+
+Common Justifications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In order to use the justifications from the table below, first repeat the =
safety requirement and
+then write ``by <justification>`` where justification is from the table be=
low.
+If you need the conjunction of multiple justifications, then you just inte=
rsperse them with "and".
+
+The term "goal safety requirement" is referring to the requirement that yo=
u are trying to justify.
+
++---------------------------+---------------------------------------------=
-------------------------+
+| Syntax                    | Meaning/Justified Safety Requirement        =
                         |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+| function requirements     | The goal safety requirement is provided by t=
he surrounding function, |
+|                           | as it also has it (or a stronger statement) =
as a safety requirement. |
++---------------------------+---------------------------------------------=
-------------------------+
+| type invariant of ``T``   | The given safety requirement is provided by =
the type invariant of    |
+|                           | ``T``, as it also has it (or a stronger stat=
ement) as a type         |
+|                           | invariant.                                  =
                         |
++---------------------------+---------------------------------------------=
-------------------------+
+| reference validity        | When turning a (mutable) reference into a po=
inter, that pointer will |
+|                           | be valid for reads (and writes).            =
                         |
++---------------------------+---------------------------------------------=
-------------------------+
+| function guarantee of     | The goal safety requirement is provided by t=
he called function       |
+| ``$function``             | ``$function``, as it has it (or a stronger s=
tatement) listed as a    |
+|                           | :doc:`guarantee <guarantee>`.               =
                         |
++---------------------------+---------------------------------------------=
-------------------------+
--=20
2.45.1



