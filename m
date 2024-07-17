Return-Path: <linux-kernel+bounces-255745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D19344A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E61C213B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5C47F7A;
	Wed, 17 Jul 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ah2WwMFb"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76350297
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254368; cv=none; b=uuaJC/RGTD8kPhVSeQ797y9SFrD64d7WmA7kTVvw+8nBFJnuxeyK3zb+zQ3GJO9K/DLCPv4UOQpVNXNwjUBkwcGKmOVzfzrVMQ4Ugf9sNbKprvtnJcc9OCrU0v0L73GJfiPbVBBNAAuAfItU2sRUnTdyWJwym0bqU3eSTiOE2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254368; c=relaxed/simple;
	bh=Y9pTw1o0mi0D9g/rlNNcDb0to08VNUjyU2T6DuPV3Sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjMDwRI1tr34mKywhOaUsuKIAEAQOV3BhjGktXImfZQrzuQEpC5VH93Yj1qOeKFhn8GMOtrI3/3KxXrjGylUX+lZE+GOjAlCGwtGqmSxQPI1KhA0a9GbAorJssTvtCkxVRBuQMqsDqnunWLbxNANFLZIfgXkT6Q8CDpowv4Nitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ah2WwMFb; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721254363; x=1721513563;
	bh=y29vr5MpVdYdUaBoMLF0I39s2PWZuV3JMS+02+MZ0lQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ah2WwMFbc0IpeMTZpEfYJ0AQRyN/CggWSlM/2dIfYTAuTAwAPo2OLP4vkyhdyYxCs
	 mSyuwP90RvYiyByLRQgJ3zZEQTB0UAdodmgBqWI5uWJld6Ea4U3ir29t+JV0Ru5NyD
	 V6PqXGtSLe/twMqEBWQTwlR17TYAKXzpvhD519be+ededeL4RgScNpfbfd/ZuMiQaT
	 hboX901z/9w2tmQqDWo7k3+xWT8XrzgSbuWhwS0Shqne70jI/ZC7yNI9ncks7HLiaE
	 MV0iqZ+QvkDH0qQXv5Xh+OAYFxjsTk3v6BI/a148sj9C5nt8wVFJZZtY6bLi9tH8sb
	 oPcJj/9mdPGXA==
Date: Wed, 17 Jul 2024 22:12:37 +0000
To: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 2/5] doc: rust: safety standard: add examples
Message-ID: <20240717221133.459589-3-benno.lossin@proton.me>
In-Reply-To: <20240717221133.459589-1-benno.lossin@proton.me>
References: <20240717221133.459589-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e95b376a888855bc5a19fc4fdf5906c20e918f31
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add examples of good and bad safety documentation.

There aren't many examples at the moment, as I hope to add more during
discussions, since coming up with examples on my own is very difficult.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 .../rust/safety-standard/examples.rst         | 70 +++++++++++++++++++
 Documentation/rust/safety-standard/index.rst  | 23 ++++--
 2 files changed, 86 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/rust/safety-standard/examples.rst

diff --git a/Documentation/rust/safety-standard/examples.rst b/Documentatio=
n/rust/safety-standard/examples.rst
new file mode 100644
index 000000000000..d66ef3f8954a
--- /dev/null
+++ b/Documentation/rust/safety-standard/examples.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. highlight:: rust
+
+Examples
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Unsound APIs
+------------
+
+Simple Unsound Function
+***********************
+::
+
+    struct Data {
+        a: usize,
+    }
+
+    fn access_a(data: *mut Data) -> usize {
+        unsafe { (*data).a }
+    }
+
+One would normally call this function as follows, which does not trigger U=
B::
+
+    fn main() {
+        let mut d =3D Data { a: 42 };
+        println!("{}", access_a(&mut d));
+    }
+
+However, a caller could also call it like this, which triggers UB using on=
ly safe code::
+
+    fn main() {
+        println!("{}", access_a(core::ptr::null_mut()));
+    }
+
+And this would result in a dereference of a null pointer.
+
+
+Sound ``unsafe`` Code
+---------------------
+
+The Importance of the API Boundary
+**********************************
+
+Is the following API sound?::
+
+    fn foo(r: &mut u32) {
+        let ptr: *mut u32 =3D r;
+        let val;
+        unsafe {
+            val =3D *ptr;
+            *ptr =3D 0;
+        }
+    }
+
+It better be sound, but one could argue that it is unsound, since one coul=
d replace the ptr
+initialization by ``ptr =3D core::ptr::null_mut()``::
+
+    fn foo(r: &mut u32) {
+        let ptr: *mut u32 =3D core::ptr::null_mut();
+        let val;
+        unsafe {
+            val =3D *ptr;
+            *ptr =3D 0;
+        }
+    }
+
+But this modification is not allowed, since it goes beyond the API boundar=
y of ``foo``. This way
+any ``unsafe`` code that relies on surrounding safe code could be shown to=
 be unsound. Instead one
+should only consider safe code using the API, in this case, there is no wa=
y to make the code
+incorrect, since a reference is always valid to dereference during its lif=
etime.
diff --git a/Documentation/rust/safety-standard/index.rst b/Documentation/r=
ust/safety-standard/index.rst
index 1cbc8d3dea04..bebebda06831 100644
--- a/Documentation/rust/safety-standard/index.rst
+++ b/Documentation/rust/safety-standard/index.rst
@@ -92,21 +92,28 @@ And this would result in a dereference of a null pointe=
r.
 In its essence, a sound API means that if someone only writes safe code, t=
hey can never encounter UB
 even if they call safe code that calls ``unsafe`` code behind the scenes.
=20
+For more examples of unsound code see examples.rst.
+
 Because unsoundness issues have the potential for allowing safe code to ex=
perience UB, they are
-treated similarly to actual bugs with UB. Their fixes should also be inclu=
ded in the  stable tree.
+treated similarly to real UB. Their fixes should also be included in the s=
table tree.
=20
 Safety Documentation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-After trying to minimize and remove as much ``unsafe`` code as possible, t=
here still is some left.
-This is because some things are just not possible in only safe code. This =
last part of ``unsafe``
-code must still be correct. Helping with that is the safety documentation:=
 it meticulously documents
-the various requirements and justifications for every line of ``unsafe`` c=
ode. That way it can be
-ensured that all ``unsafe`` code is sound without anyone needing to know t=
he whole kernel at once.
+No matter how hard one tries to remove ``unsafe`` code, it is impossible t=
o completely get rid of it
+in the Kernel. There are things that are impossible for safe code. For exa=
mple interacting with the
+C side. So one can never be completely sure that there are no memory issue=
s lurking somewhere.
+
+This is where safety documentation helps: it meticulously documents the va=
rious requirements and
+justifications for every line of ``unsafe`` code. That way the risk of wri=
ting unsound ``unsafe``
+code is reduced drastically.
+
 The gist of the idea is this: every ``unsafe`` operation documents its req=
uirements and every
 location that uses an ``unsafe`` operation documents for every requirement=
 a justification why they
 are fulfilled. If now all requirements and justifications are correct, the=
n there can only be sound
-``unsafe`` code.
+``unsafe`` code. Reducing the global problem of correctness of the whole k=
ernel to the correctness
+of each and every ``unsafe`` code block makes it a local problem. Local pr=
oblems are a lot easier to
+handle, since each instance can be fixed/reviewed independently.
=20
 The ``unsafe`` keywords has two different meanings depending on the contex=
t it is used in:
=20
@@ -238,6 +245,8 @@ Further Pages
 .. toctree::
    :maxdepth: 1
=20
+   examples
+
 .. only::  subproject and html
=20
    Indices
--=20
2.45.1



