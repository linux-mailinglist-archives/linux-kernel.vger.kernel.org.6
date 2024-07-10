Return-Path: <linux-kernel+bounces-246940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64192C91C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2450D281CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255F37703;
	Wed, 10 Jul 2024 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO4IEtsW"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7B28683;
	Wed, 10 Jul 2024 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581975; cv=none; b=FKeVFbPgjrEJ+569fAwssmDo+kD/KwQ6ifwrWTOvTebwqdCr7NGuthrvA1C4bAaPRqem90PIxK7FQ6UljdEwn3ING0vM2lmlsjSrFBhK2Af8Uhw19t+txE1WnrYKnuZMaHWewXdx2oEqHBSgxPwPS0PYqEb2egHR56ufITfUVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581975; c=relaxed/simple;
	bh=66/xON+hb2Qf5vVQk4X/r72CH1q0IpJHIkAkAdmH1Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXbwvfI+h4Q86WzFP6b8WtGxeY91Q7D/3vuOC7wmv4OilsL3wfBWilGnEbTuTKpFBQBcq8lhGnRXd3HFR5czX68lmyGBIlwfxtayEpSXMFrIZ4mtFQNCKMHGyKJg1h6824xMV/4NIEhhty3saxLOZVsDtbzwGeUsxMbtu4trRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO4IEtsW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447d5376923so21886861cf.2;
        Tue, 09 Jul 2024 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720581972; x=1721186772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sfUqp+KEKp+iEpCVS+30hZiv3NZrSiROYXcYZoJxi08=;
        b=KO4IEtsWLXY7NSaffjmyELcyJQwojvG57dBvWn16hIpQcJ2JrEpqLGmSATfNgM6nJ7
         YPz/kGgdQvhpG7SstzmVIFURSm1hsTHQLsxjSmmvfqlF42KATLuIGvWQgcYN9vmz+j0B
         yUICvOPwzaTXR3iPH5gTq5D2LqN1aNJX1lzZTY0MmcxtrpH6LZF6Ri3sBJzkPSW20TP0
         SE1mtdLuUzZcHZPD0XwXkNZzRPbrvA+YbcPtId1cRvd7Pkasl30hFhHaVJd/BNzUBJE9
         k14PSr9jcZu769EH0XKQLCQecZRO+4MP4MJ2knWh3RJHaCiRcc5xd1LY+YM4dyxxLbeZ
         zn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581972; x=1721186772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfUqp+KEKp+iEpCVS+30hZiv3NZrSiROYXcYZoJxi08=;
        b=KCAF+k8RUFka9R0+DGypWB/QJmNKQXIi9coyWxe5cQPL43Es/4rO4LT0a4hb6LOU4T
         /NanghYI1jwvC/U9yjzZGQ/cCfYq1j7rn5FM6M7B292srjidUaOOW+JVUMZ8EB3B0utH
         pIxGSU0uFshAS0JBEVxpHjHyNYdcFsZQaqbenVfTB/mcTyWuc2Gi37fusW50vqbjNo/z
         4heh6Y5wQ/zEi5Z7jb5XDOMxJDP0RToulc51iu5XItl9ToExdoXlDgu4dyP48U/LJeCE
         ncPBmj3FehtqMXkoZ3T2NecUFxl2VyLHCu6AtGfnZ35SE5d1XXaUuKu8n5Yrx3gP/h8x
         8wVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmgNseOUeXwOWgIrPGNSPWumy6cxXS6qHKRjfcOoC48M91/FaBt3WBYoLt6n/l4mA2t2prPVW6Ihu+lnSccYsNkZSK71NWAZeGfBvBzJ5O5RT+LY2oFO6aImdL9vgiBzOXWJGKlA86
X-Gm-Message-State: AOJu0YyXKcDaxx2y6qxpjfCQtDs4Vip85bJJ+5HyFpPaKSIAbiAvQjoC
	c+a1qOQQsu+Jtf4hn21CROUMImd4a9nosNqafoHvL65YIQhb8zWq
X-Google-Smtp-Source: AGHT+IHt+gtkNMoenXtzeqHEHKoTMcGMdaiq6T3o6v3P4TP5Q3MvauRfLjBJbP9wznjIu4GO08B9qg==
X-Received: by 2002:ac8:5784:0:b0:447:e48d:f067 with SMTP id d75a77b69052e-447fa85373bmr50692531cf.14.1720581972335;
        Tue, 09 Jul 2024 20:26:12 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd224esm16403731cf.62.2024.07.09.20.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:26:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1B28F1200043;
	Tue,  9 Jul 2024 23:26:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Jul 2024 23:26:11 -0400
X-ME-Sender: <xms:Uf-NZkQSO9KFc8b2bEQ6A7gAhIO026ouNKcLsHpSuZgabVXgWHTmMg>
    <xme:Uf-NZhz7NazEJMkc50obAW5kCPBHYWS24LELP8fOQOTo7ABrZ7MA4m_UAWn8JY055
    FSSuTU8gLQUyWCCUw>
X-ME-Received: <xmr:Uf-NZh1rx49BBKq2otOmZFV7NogHbiRGuhEGzZ5vcF15l6hSA8QG7hw2ZEo6xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedtgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepkeejueelvedujeefveegvdeukeetkeeileehhefghfeuhfetudeufffhudejgfdu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnshhtrghntggvrdhinhdprghspg
    hpthhrrdgsrghrpdhgvghtrdgsrghrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Uv-NZoAVxIuoON6D9NdO9MsvD5QLNylEXtRA1CATJloZxKgQjEjEGg>
    <xmx:Uv-NZtjrEbzHV-F9PZ612RmsTrvENcJ0Vt26HxF_eFUbub-L13mMPA>
    <xmx:Uv-NZkoXjGltpn4N1jo0zKcttdikO3bqE31ZplzSe_2g2rAre8b6BQ>
    <xmx:Uv-NZgj4Z-RMSJox_7OVUjdeuyuzVOdtYh5WjWvQqXGyHmBCKbBlBw>
    <xmx:U_-NZkSYLElYzcP_j9L-b__9SZK8rD-cc0ydSAOHsMEQ_Q_pUrSGOWE6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jul 2024 23:26:09 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Trevor Gross <tmgross@umich.edu>,
	gregkh@linuxfoundation.org
Subject: [RFC PATCH] rust: types: Add explanation for ARef pattern
Date: Tue,  9 Jul 2024 20:24:47 -0700
Message-ID: <20240710032447.2161189-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the usage of `ARef` and `AlwaysRefCounted` is growing, it makes sense
to add explanation of the "ARef pattern" to cover the most "DO" and "DO
NOT" cases when wrapping a self-refcounted C type.

Hence an "ARef pattern" section is added in the documentation of `ARef`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
This is motivated by:

	https://lore.kernel.org/rust-for-linux/20240705110228.qqhhynbwwuwpcdeo@vireshk-i7/

 rust/kernel/types.rs | 156 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..70fdc780882e 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -329,6 +329,162 @@ pub unsafe trait AlwaysRefCounted {
 ///
 /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
 /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
+///
+/// # [`ARef`] pattern
+///
+/// "[`ARef`] pattern" is preferred when wrapping a C struct which has its own refcounting
+/// mechanism, because it decouples the operations on the object itself (usually via a `&Foo`) vs the
+/// operations on a pointer to the object (usually via an `ARef<Foo>`). For example, given a `struct
+/// foo` defined in C, which has its own refcounting operations `get_foo()` and `put_foo()`. Without
+/// "[`ARef`] pattern", i.e. **bad case**:
+///
+/// ```ignore
+/// pub struct Foo(NonNull<foo>);
+///
+/// impl Foo {
+///     // An operation on the pointer.
+///     pub unsafe fn from_ptr(ptr: *mut foo) -> Self {
+///         // Note that whether `get_foo()` is needed here depends on the exact semantics of
+///         // `from_ptr()`: is it creating a new reference, or it continues using the caller's
+///         // reference?
+///         unsafe { get_foo(ptr); }
+///
+///         unsafe { Foo(NonNull::new_unchecked(foo)) }
+///     }
+///
+///     // An operation on the object.
+///     pub fn get_bar(&self) -> Bar {
+///         unsafe { (*foo.0.as_ptr()).bar }
+///     }
+/// }
+///
+/// // Plus `impl Clone` and `impl Drop` are also needed to implement manually.
+/// impl Clone for Foo {
+///     fn clone(&self) -> Self {
+///         unsafe { get_foo(self.0.as_ptr()); }
+///
+///         Foo(self.0)
+///     }
+/// }
+///
+/// impl Drop for Foo {
+///     fn drop(&mut self) {
+///         unsafe { put_foo(self.0.as_ptr()); }
+///     }
+/// }
+/// ```
+///
+/// In this case, it's hard to tell whether `Foo` represent an object of `foo` or a pointer to
+/// `foo`.
+///
+/// However, if using [`ARef`] pattern, `foo` can be wrapped as follow:
+///
+/// ```ignore
+/// /// Note: `Opaque` is needed in most cases since there usually exist C operations on
+/// /// `struct foo *`, and `#[repr(transparent)]` is needed for the safety of converting a `*mut
+/// /// foo` to a `*mut Foo`
+/// #[repr(transparent)]
+/// pub struct Foo(Opaque<foo>);
+///
+/// impl Foo {
+///     pub fn get_bar(&self) -> Bar {
+///         // SAFETY: `self.0.get()` is a valid pointer.
+///         //
+///         // Note: Usually extra safety comments are needed here to explain why accessing `.bar`
+///         // doesn't race with C side. Most cases are either calling a C function, which has its
+///         // own concurrent access protection, or holding a lock.
+///         unsafe { (*self.0.get()).bar }
+///     }
+/// }
+/// ```
+///
+/// ## Avoid `impl AlwaysRefCounted` if unnecesarry
+///
+/// If Rust code doesn't touch the part where the object lifetimes of `foo` are maintained, `impl
+/// AlwaysRefCounted` can be temporarily avoided: it can always be added later as an extension of
+/// the functionality of the Rust code. This is usually the case for callbacks where the object
+/// lifetimes are already maintained by a framework. In such a case, an `unsafe` `fn(*mut foo) ->
+/// &Foo` function usually suffices:
+///
+/// ```ignore
+/// impl Foo {
+///     /// # Safety
+///     ///
+///     /// `ptr` has to be a valid pointer to `foo` for the entire lifetime `'a'.
+///     pub unsafe fn as_ref<'a>(ptr: *mut foo) -> &'a Self {
+///         // SAFETY: Per function safety requirement, reborrow is valid.
+///         unsafe { &*ptr.cast() }
+///     }
+/// }
+/// ```
+///
+/// ## Type invariants of `impl AlwaysRefCounted`
+///
+/// Types that `impl AlwaysRefCounted` usually needs an invariant to describe why the type can meet
+/// the safety requirement of `AlwaysRefCounted`, e.g.
+///
+/// ```ignore
+/// /// # Invariants:
+/// ///
+/// /// Instances of this type are always refcounted, that is, a call to `get_foo` ensures that the
+/// /// allocation remains valid at least until the matching call to `put_foo`.
+/// #[repr(transparent)]
+/// pub struct Foo(Opaque<foo>);
+///
+/// // SAFETY: `Foo` is always ref-counted per type invariants.
+/// unsafe impl AlwaysRefCounted for Foo {
+///     fn inc_ref(&self) {
+///         // SAFETY: `self.0.get()` is a valid pointer and per type invariants, the existence of
+///         // `&self` means it has a non-zero reference count.
+///         unsafe { get_foo(self.0.get()); }
+///     }
+///
+///     unsafe dec_ref(obj: NonNull<Self>) {
+///         // SAFETY: The refcount of `obj` is non-zero per function safety requirement, and the
+///         // cast is OK since `foo` is transparent to `Foo`.
+///         unsafe { put_foo(obj.cast()); }
+///     }
+/// }
+/// ```
+///
+/// After `impl AlwaysRefCounted for foo`, `clone()` (`get_foo()`) and `drop()` (`put_foo()`)  are
+/// available to `ARef<Foo>` thanks to the generic implementation.
+///
+/// ## `ARef<Self>` vs `&Self`
+///
+/// For an `impl AlwaysRefCounted` type, `ARef<Self>` represents an owner of one reference count,
+/// e.g.
+///
+/// ```ignore
+/// impl Foo {
+///     /// Gets a ref-counted reference of [`Self`].
+///     ///
+///     /// # Safety
+///     ///
+///     /// - `ptr` must be a valid pointer to `foo` with at least one reference count.
+///     pub unsafe fn from_ptr(ptr: *mut foo) -> ARef<Self> {
+///         // SAFETY: `ptr` is a valid pointer per function safety requirement. The cast is OK
+///         // since `foo` is transparent to `Foo`.
+///         //
+///         // Note: `.into()` here increases the reference count, so the returned value has its own
+///         // reference count.
+///         unsafe { &*(ptr.cast::<Foo>()) }.into()
+///     }
+/// }
+/// ```
+///
+/// Another function that returns an `ARef<Self>` but with a different semantics is
+/// [`ARef::from_raw`]: it takes away the refcount of the input pointer, i.e. no refcount
+/// incrementation inside the function.
+///
+/// However `&Self` represents a reference to the object, and the lifetime of the **reference** is
+/// known at compile-time. E.g. the `Foo::as_ref()` above.
+///
+/// ## `impl Drop` of an `impl AlwaysRefCounted` should not touch the refcount
+///
+/// [`ARef`] descreases the refcount automatically (in [`ARef::drop`]) when it goes out of the
+/// scope, therefore there's no need to `impl Drop` for the type of objects (e.g. `Foo`) to decrease
+/// the refcount.
 pub struct ARef<T: AlwaysRefCounted> {
     ptr: NonNull<T>,
     _p: PhantomData<T>,
-- 
2.45.2


