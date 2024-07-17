Return-Path: <linux-kernel+bounces-255747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F09344A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB81B284460
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0672D50297;
	Wed, 17 Jul 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CbKxV1ng"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DAB57CB4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254383; cv=none; b=ple1MjdbiRxJZSTovPRqeNYFYunh+I0HVfQqPR8xs+Qidq6aUgHOdqdoyFI2AmGU3iZhxO1LfZLcX2vkrrjaO/Mz1Goe3dp1EJURwYtRJDTG/Lqkd+khOpKoB93+edOtW+4OtANwU6QpEux1c6x9ZDvRmYgVEcimOyiFUrp005E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254383; c=relaxed/simple;
	bh=uGuTjev38iC7jpWZFl8UiFqhRmrP3nbVoD8E9LhFjDs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSF/RCakG+5jBqwXtmlZ2CVcYwGR8CnSfOU1BPryGiCmJgGN4fNdb/Nbmfa6vlxuhR+w7q2ITDimM/SqcdPRA7i7PAK9msYfi1p0K91/8aUseQ+m3DztKE3+QnpB5+G7Rgs4s8hZk5vfeyPIzklueRGMTlgpcDf4AuUjnP4786c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CbKxV1ng; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721254378; x=1721513578;
	bh=z7ju78jvF1rL+El/phSjRSOwLQJ7motRR1uDNwY8R3I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CbKxV1ngnebUMQ8V5Bamuobz2yHpbBo6xORUoBfrQcVPCW1wcJ0FMXaTEyctR+rFH
	 n3pSYsG6XHq8bbhd9Xp1gjziBFh21MbK/ZJuvyh9V4DU8RSCsgZYA+qgRbfHdb9Vw5
	 yeUqVsu22ZwraVCsiSrmCNBXZ0XzaHoF0zgAzl4hkpyrxxS3GkPGUdkf6aKjKONQm2
	 AG1jJvTKve2kJ/+QfC87gRuZOLm2teTnhcQb9rrc3pJjBaKcalHlS780+dBVyJZkQ+
	 CswZ8bbmHcw9Zp3pKdBrrfada4wkTqQQQtjJv01+GT/WbJyCfiEijS3S7ZtDJVSyGY
	 XtfXaGU78fLsg==
Date: Wed, 17 Jul 2024 22:12:53 +0000
To: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 4/5] doc: rust: safety standard: add safety requirements
Message-ID: <20240717221133.459589-5-benno.lossin@proton.me>
In-Reply-To: <20240717221133.459589-1-benno.lossin@proton.me>
References: <20240717221133.459589-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 956c6cb7fd82d52baaca7d3b61df9674951e79c4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add standardized safety requirements.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 Documentation/rust/safety-standard/index.rst  |  5 ++
 .../rust/safety-standard/requirements.rst     | 80 +++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/rust/safety-standard/requirements.rst

diff --git a/Documentation/rust/safety-standard/index.rst b/Documentation/r=
ust/safety-standard/index.rst
index 40b17f59709c..2ef82d7dfbd8 100644
--- a/Documentation/rust/safety-standard/index.rst
+++ b/Documentation/rust/safety-standard/index.rst
@@ -157,6 +157,8 @@ The safety requirements have to be documented in the so=
 called safety section::
         // ...
     }
=20
+See requirements.rst for a full list of standardized safety requirements.
+
 .. _unsafe-Blocks:
=20
 ``unsafe`` Blocks
@@ -208,6 +210,8 @@ are called safety requirements and need to be documente=
d in the same way::
     /// <safety requirements>
     unsafe trait Foo {}
=20
+See requirements.rst for a full list of standardized safety requirements.
+
 ``unsafe`` Impls
 ----------------
=20
@@ -262,6 +266,7 @@ Further Pages
    examples
    guarantee
    type-invariants
+   requirements
=20
 .. only::  subproject and html
=20
diff --git a/Documentation/rust/safety-standard/requirements.rst b/Document=
ation/rust/safety-standard/requirements.rst
new file mode 100644
index 000000000000..b86bfb98179e
--- /dev/null
+++ b/Documentation/rust/safety-standard/requirements.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. highlight:: rust
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Safety Requirements
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+There are many different kinds of safety requirements. The simplest exampl=
e is the validity of raw
+pointers. But there is no limit to what they may require.
+
+Safety requirements are listed in an unordered markdown list in the ``# Sa=
fety`` section on
+``unsafe fn`` and ``unsafe trait`` items. Each list item should only conta=
in a single requirement.
+The items should not specify the same requirement multiple times, especial=
ly not by expressing it in
+different terms.  The ``# Safety`` section should only consist of the list=
 of safety requirements,
+if there is additional information, it should be documented in a different=
 section.
+
+Common Safety Requirements
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
++------------------------+---------------------+--------------------------=
-------------------------+
+| Syntax                 | Meta Variables      | Meaning                  =
                         |
+|                        |                     |                          =
                         |
++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+| ``ptr`` is valid for   |                     | Abbreviation for:        =
                         |
+| reads and writes.      |                     |                          =
                         |
+|                        | * ``ptr: *mut T``   | * ``ptr`` is valid for re=
ads.                     |
+|                        |                     | * ``ptr`` is valid for wr=
ites.                    |
++------------------------+---------------------+--------------------------=
-------------------------+
+| ``ptr`` is valid for   |                     | Abbreviation for:        =
                         |
+| reads.                 |                     |                          =
                         |
+|                        | * ``ptr: *const T`` | * ``ptr`` is valid for re=
ads up to                |
+|                        |                     |   ``size_of::<T>()`` byte=
s for the duration of    |
+|                        |                     |   this function call.    =
                         |
++------------------------+---------------------+--------------------------=
-------------------------+
+| ``ptr`` is valid for   |                     | Abbreviation for:        =
                         |
+| writes.                |                     |                          =
                         |
+|                        | * ``ptr: *mut T``   | * ``ptr`` is valid for wr=
ites up to               |
+|                        |                     |   ``size_of::<T>()`` byte=
s for the duration of    |
+|                        |                     |   this function call.    =
                         |
++------------------------+---------------------+--------------------------=
-------------------------+
+| ``ptr`` is valid for   |                     | For the duration of ``'a`=
`:                       |
+| reads up to ``size``   |                     |                          =
                         |
+| bytes for the duration | * ``ptr: *const T`` | * The pointer ``ptr`` is =
dereferenceable for      |
+| of ``'a``.             | * ``size: usize``   |   ``size`` bytes: all byt=
es with offset           |
+|                        |                     |   ``0..size`` have to be =
part of the same         |
+|                        |                     |   allocated object and it=
 has to be alive.        |
+|                        |                     | * No concurrent write ope=
ration may occur to      |
+|                        |                     |   ``ptr`` at any offset b=
etween ``0..size``.      |
+|                        |                     | * The value at ``ptr`` is=
 a valid instance of     |
+|                        |                     |   the type ``T``.        =
                         |
+|                        |                     |                          =
                         |
+|                        |                     | Additionally ``ptr`` must=
 be:                     |
+|                        |                     |                          =
                         |
+|                        |                     | * non-null,              =
                         |
+|                        |                     | * aligned to ``align_of::=
<T>()`` i.e.             |
+|                        |                     |   ``ptr.addr() % align_of=
::<T>() =3D=3D 0``.          |
++------------------------+---------------------+--------------------------=
-------------------------+
+| ``ptr`` is valid for   |                     | For the duration of ``'a`=
`:                       |
+| writes up to ``size``  |                     |                          =
                         |
+| bytes for the duration | * ``ptr: *mut T``   | * The pointer ``ptr`` is =
dereferenceable for      |
+| of ``'a``.             | * ``size: usize``   |   ``size`` bytes: all byt=
es with offset           |
+|                        |                     |   ``0..size`` have to be =
part of the same         |
+|                        |                     |   allocated object and it=
 has to be alive.        |
+|                        |                     | * No concurrent read or w=
rite operation may occur |
+|                        |                     |   to ``ptr`` at any offse=
t between ``0..size``.   |
+|                        |                     |                          =
                         |
+|                        |                     | Additionally ``ptr`` must=
 be:                     |
+|                        |                     |                          =
                         |
+|                        |                     | * non-null,              =
                         |
+|                        |                     | * aligned to ``align_of::=
<T>()`` i.e.             |
+|                        |                     |   ``ptr.addr() % align_of=
::<T>() =3D=3D 0``.          |
++------------------------+---------------------+--------------------------=
-------------------------+
+
+
+Custom Safety Requirements
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+There are of course situations where the safety requirements listed above =
are insufficient. In that
+case the author can try to come up with their own safety requirement wordi=
ng and ask the reviewers
+what they think. If the requirement is common enough, it should be added t=
o the list above.
--=20
2.45.1



