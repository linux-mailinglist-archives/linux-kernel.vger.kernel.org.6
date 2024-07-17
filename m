Return-Path: <linux-kernel+bounces-255744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F79344A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5193B2118B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F14D8AF;
	Wed, 17 Jul 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hLJMBFde"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6C44C76
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254360; cv=none; b=EWV+i6ac8HIKJXtHR5QdX8BlHUV5Zz+Na4hNXB8QeMEFpD9xwJmruIF2ah+O/jylsGJTFyHgUqr+ObCR2luXo5Mz6+z7AdpRqJW2fK2mAn2jZQhtpcz6o5WIHnq7e3oo0R5zaCq1wcWp0xLmYbWU2Z9c0KmM0y7qYOamcqRu/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254360; c=relaxed/simple;
	bh=zWQFTA9w8X7oKpZUTpUmOG+aSt3BRQJhi4BZXYUZYG4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7GoRIKZ4UK8+YQBlGcmQXQABNMmDE0JAP11Bo4VaY3fOANmguL7f4b1q3DRw5HL1USv3I5W5AiYvNK95rT+Er30dDSf7/nPSXpDH/1g7UsxX0zJNO6sHXsTvEVl+0Cx6mhIIFEVMtEbCO4LnBiRRBRMKNUrhTNCLbljPxiecEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hLJMBFde; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721254355; x=1721513555;
	bh=Ga3ax7yoxWUsj7eOgiOg45vXpnyPceRh9yN8jZOUScg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hLJMBFderJFgsmCTtOWwESgTa2BDgBNyusksuaLUF8Vl/6zIivuOMcmsqd7y7xn+L
	 mRNnTjGIrY53VhwCfUAzyfq7GjopeoGj7tmvlw0Z2kBCHpogegTOSexxPBmD8RlTym
	 KlNI0mIF/AaFwyTW4i3o0Rr0msm8mlfSjv6Yyod3Tbe1mHM/zBAGEfQh72b365GnhR
	 625dlbUBYzSIbGPZByLO6xr0tuGO+r3UZHBBxoYybHuTaZfyBdCZodanz0PW6EHtLZ
	 GE0AqGR0rxCcEOfsS74QRVhD1GAaQcy3DdfFIEsvWGpS8Rcfkm9LlqBH1z3ttsyWp6
	 Rx3Hv1albMk+Q==
Date: Wed, 17 Jul 2024 22:12:29 +0000
To: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <20240717221133.459589-2-benno.lossin@proton.me>
In-Reply-To: <20240717221133.459589-1-benno.lossin@proton.me>
References: <20240717221133.459589-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c838ea6125a78d3f4bd97fa4110efacac1210195
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`unsafe` Rust code in the kernel is required to have safety
documentation. This is to ensure the correctness of `unsafe` code and is
thus very important.
However, at this point in time there does not exist a standard way of
writing safety documentation. This leads to confusion, as authors
struggle to find the right way to convey their desired intentions.
Readers struggle with correctly interpreting the existing documentation.

Add the safety standard that will document the meaning of safety
documentation. This first document gives an overview of the problem and
gives general information about the topic.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 Documentation/rust/general-information.rst   |   1 +
 Documentation/rust/index.rst                 |   1 +
 Documentation/rust/safety-standard/index.rst | 246 +++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 Documentation/rust/safety-standard/index.rst

diff --git a/Documentation/rust/general-information.rst b/Documentation/rus=
t/general-information.rst
index e3f388ef4ee4..ddfe4e2e5307 100644
--- a/Documentation/rust/general-information.rst
+++ b/Documentation/rust/general-information.rst
@@ -54,6 +54,7 @@ the same invocation used for compilation, e.g.::
 Please note that Clippy may change code generation, thus it should not be
 enabled while building a production kernel.
=20
+.. _rust-abstractions:
=20
 Abstractions vs. bindings
 -------------------------
diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 46d35bd395cf..968e9aace301 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -39,6 +39,7 @@ configurations.
     quick-start
     general-information
     coding-guidelines
+    safety-standard/index
     arch-support
     testing
=20
diff --git a/Documentation/rust/safety-standard/index.rst b/Documentation/r=
ust/safety-standard/index.rst
new file mode 100644
index 000000000000..1cbc8d3dea04
--- /dev/null
+++ b/Documentation/rust/safety-standard/index.rst
@@ -0,0 +1,246 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. highlight:: rust
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Rust Safety Standard
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Safe Rust code cannot have memory related bugs. This is a guarantee by the=
 Rust compiler. Of course
+it is not without caveats: no compiler bugs, no bugs in the specification =
etc. But the possibly most
+important caveat is that of ``unsafe`` code. ``unsafe`` code needs to foll=
ow certain rules in order
+for safe code to enjoy the no-memory-bugs privilege. A simple example of s=
uch a rule is that
+references must be valid for the duration of their lifetime. If any rule i=
s violated, it can lead
+to undefined behavior even in safe code! The term undefined behavior in Ru=
st has a lot stricter
+meaning than in C or C++: UB in Rust is totally forbidden. In C one might =
rely on the compiler
+implementation to ensure correct code generation, but that is not the case=
 for Rust. You can read
+more about UB in Rust
+`here <https://doc.rust-lang.org/reference/behavior-considered-undefined.h=
tml>`_.
+
+If ``unsafe`` code makes our life this difficult, one might ask the questi=
on "why do we even need
+it?" and the answer to that is that it gives users an escape hatch to do t=
hings that the compiler
+normally forbids. ``unsafe`` code is a tool that enables programmers to wr=
ite more performant code,
+or code that interacts with hardware or C. These things are particularly i=
mportant in kernel
+development.
+
+The most effective way to prevent issues in ``unsafe`` code is to just not=
 write ``unsafe`` code in
+the first place. That is why minimizing the amount of ``unsafe`` code is v=
ery important. For
+example, drivers are not allowed to directly interface with the C side. In=
stead of directly
+communicating with C functions, they interact with Rust abstractions. This=
 concentrates the usage
+of ``unsafe`` code, making it easy to fix issues, since only the abstracti=
on needs to be fixed.
+Abstractions also allow taking advantage of other Rust language features. =
Read more in
+:ref:`rust-abstractions`.
+
+Since the correctness of the abstractions is integral for safe code to als=
o be correct, extra effort
+is expended to get them right. Part of that is good safety documentation.
+
+The goals of safety documentation are:
+
+* reduce the amount of bugs in ``unsafe`` code,
+* help readers know why a given piece of ``unsafe`` code is sound,
+* help writers write ``unsafe`` code with confidence,
+* simplify the work of reviewers.
+
+This document standardizes safety documentation. The necessity for this is=
 simple, only a common
+language that all parties understand is effective at the above task. We wa=
nt to avoid
+misunderstandings in safety related matters. An additional benefit is that=
 programmers will not have
+to ponder for the correct phrasing, since they can find it here.
+
+This document assumes that the reader is familiar with Rust code and under=
stands the most important
+concepts of ``unsafe`` Rust. It is recommended that the reader has read th=
e `Rust Book`_. Since this
+document is about safety documentation, almost all examples are going to c=
ontain ``unsafe`` code.
+For this reason it is also recommended to read the `Rustonomicon`_, one of=
 the best resources on
+``unsafe`` code.
+
+.. _Rustonomicon: https://doc.rust-lang.org/nomicon/index.html
+.. _Rust Book: https://doc.rust-lang.org/stable/book/
+
+If you need help coming up with an abstraction, or with writing the safety=
 documentation for an
+abstraction, feel free to reach out on `zulip`_ or the `list`_.
+
+.. _zulip: https://rust-for-linux.zulipchat.com
+.. _list: https://lore.kernel.org/rust-for-linux
+
+Soundness
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+``unsafe`` operations (e.g. ``unsafe`` functions, dereferencing raw pointe=
rs etc.) have certain
+conditions that need to be fulfilled in order for the operation to not be =
UB.
+To evaluate if the ``unsafe`` code usage is correct, one needs to consider=
 the API that wraps said
+``unsafe`` code. If under all possible safe uses of the API, the condition=
s for the ``unsafe``
+operation are fulfilled, the API is *sound*. Otherwise it is *unsound*. He=
re is a simple example::
+
+    pub struct Data {
+        a: usize,
+    }
+
+    pub fn access_a(data: *mut Data) -> usize {
+        unsafe { (*data).a }
+    }
+
+    fn main() {
+        let mut d =3D Data { a: 42 };
+        println!("{}", access_a(&mut d));
+    }
+
+While this example has no UB, the function ``access_a`` is unsound. This i=
s because one could just
+write the following safe usage::
+
+    println!("{}", access_a(core::ptr::null_mut()));
+
+And this would result in a dereference of a null pointer.
+
+In its essence, a sound API means that if someone only writes safe code, t=
hey can never encounter UB
+even if they call safe code that calls ``unsafe`` code behind the scenes.
+
+Because unsoundness issues have the potential for allowing safe code to ex=
perience UB, they are
+treated similarly to actual bugs with UB. Their fixes should also be inclu=
ded in the  stable tree.
+
+Safety Documentation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+After trying to minimize and remove as much ``unsafe`` code as possible, t=
here still is some left.
+This is because some things are just not possible in only safe code. This =
last part of ``unsafe``
+code must still be correct. Helping with that is the safety documentation:=
 it meticulously documents
+the various requirements and justifications for every line of ``unsafe`` c=
ode. That way it can be
+ensured that all ``unsafe`` code is sound without anyone needing to know t=
he whole kernel at once.
+The gist of the idea is this: every ``unsafe`` operation documents its req=
uirements and every
+location that uses an ``unsafe`` operation documents for every requirement=
 a justification why they
+are fulfilled. If now all requirements and justifications are correct, the=
n there can only be sound
+``unsafe`` code.
+
+The ``unsafe`` keywords has two different meanings depending on the contex=
t it is used in:
+
+* granting access to an unchecked operation,
+* declaring that something is an unchecked operation.
+
+In both cases we have to add safety documentation. In the first case, we h=
ave to justify why we can
+always guarantee that the requirements of the unchecked operation are fulf=
illed. In the second case,
+we have to list the requirements that have to be fulfilled for the operati=
on to be sound.
+
+In the following sections we will go over each location where ``unsafe`` c=
an be used.
+
+.. _unsafe-Functions:
+
+``unsafe`` Functions
+--------------------
+
+``unsafe`` on function declarations is used to state that this function ha=
s special requirements
+that callers have to ensure when calling the function::
+
+    unsafe fn foo() {
+        // ...
+    }
+
+These requirements are called the safety requirements of the function. The=
se requirements can take
+any shape and range from simple requirements like "``ptr_arg`` is valid" (=
``ptr_arg`` refers to some
+argument with the type matching ``*mut T`` or ``*const T``) to more comple=
x requirements like
+"``ptr`` must be valid, point to a ``NUL``-terminated C string, and it mus=
t be valid for at least
+``'a``. While the returned value is alive, the memory at ``ptr`` must not =
be mutated.".
+
+The safety requirements have to be documented in the so called safety sect=
ion::
+
+    /// <oneline description of the function>
+    ///
+    /// <full description of the function>
+    ///
+    /// # Safety
+    ///
+    /// <safety requirements>
+    unsafe fn foo() {
+        // ...
+    }
+
+.. _unsafe-Blocks:
+
+``unsafe`` Blocks
+-----------------
+
+``unsafe`` code blocks are used to call ``unsafe`` functions and perform b=
uilt-in ``unsafe``
+operations such as dereferencing a raw pointer::
+
+    unsafe { foo() };
+
+In order to ensure that all safety requirements of ``unsafe`` operations a=
re upheld, a safety
+comment is mandatory for all ``unsafe`` blocks. This safety comment needs =
to provide a correct
+justification for every safety requirements of every operation within the =
block::
+
+    // SAFETY: <justifications>
+    unsafe { foo() };
+
+For transparency it is best practice to have only a single ``unsafe`` oper=
ation per ``unsafe``
+block, since then it is more clear what the justifications are trying to j=
ustify. Safe operations
+should not be included in the block, since it adds confusion as to which o=
peration is the ``unsafe``
+one. In certain cases however it makes it easier to understand if there is=
 only a single ``unsafe``
+block. For example::
+
+    // SAFETY: `ptr` is valid for writes.
+    unsafe {
+        (*ptr).field1 =3D 42;
+        (*ptr).field2 =3D 24;
+        (*ptr).field3 =3D 2442;
+    }
+
+In this case it is more readable to not split the block into multiple part=
s.
+
+``unsafe`` Traits
+-----------------
+
+When ``unsafe`` is on a ``trait`` declaration::
+
+    unsafe trait Foo {}
+
+The ``trait`` has special requirements for implementing it. Similar to :re=
f:`unsafe-Functions`, these
+are called safety requirements and need to be documented in the same way::
+
+    /// <oneline description of the trait>
+    ///
+    /// <full description of the trait>
+    ///
+    /// # Safety
+    ///
+    /// <safety requirements>
+    unsafe trait Foo {}
+
+``unsafe`` Impls
+----------------
+
+When ``unsafe`` is on an ``impl`` item::
+
+    unsafe impl Foo for Bar {}
+
+The ``Foo`` ``trait`` has to be ``unsafe`` and its safety requirements nee=
d to be justified
+similarly to :ref:`unsafe-Blocks`::
+
+    // SAFETY: <justification>
+    unsafe impl Foo for Bar {}
+
+General Rules
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The general thought behind all rules in the safety standard is that everyt=
hing that cannot be
+statically checked by the Rust compiler and guaranteed, needs to be either=
 checked at runtime, or
+have to have safety documentation.
+
+The Kernel uses ``deny(unsafe_op_in_unsafe_fn)``, disallowing ``unsafe`` o=
perations to be contained
+in ``unsafe`` functions without a surrounding ``unsafe`` block, an example=
 violating that would be::
+
+    unsafe fn zero_ptr(ptr: *mut u32) {
+        *ptr =3D 0;
+    }
+
+Denying code like this is becoming the default in modern editions of the R=
ust language. It is also
+easy to see why we would want to deny such code: where would we put the ``=
SAFETY`` comment for the
+pointer dereference?
+
+Further Pages
+-------------
+
+.. toctree::
+   :maxdepth: 1
+
+.. only::  subproject and html
+
+   Indices
+   =3D=3D=3D=3D=3D=3D=3D
+
+   * :ref:`genindex`
--=20
2.45.1



