Return-Path: <linux-kernel+bounces-279838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F3494C26E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8AA1F23B11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2E190698;
	Thu,  8 Aug 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xngOMi15"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916E190482
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133794; cv=none; b=Q0Zt8VcSkyvfafPHE6y8E9ex13k6zOItmUHjERZZFvAv5VTp9muyE5rBOnBfv9K6ZsAYXvO3Q5CQGZ07TQZ8SKXsZv87U1CXauoBKTN38dKBf92dKqi7UwhqM5eU9Rs/FEQFA48t1QEp2LI3bza+6ccQ8w1BrTPsAU1b54uAzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133794; c=relaxed/simple;
	bh=4PQaFBps8VktqGwrRnYv70CrPEKA5C/LpKWYnG6Le3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZEL3Z2shamG2A91P8KOgFM3Dc2AHIQ0khl1ThsIZMmnPpu7UfIp36Rz6RXD1Aa7f4cES0/bSUk1Nn+PeG6Rn3kTlZWNIu5T/yZf/9wqw99Aad5bY5pGiomfW5pD/xY0ulnV60/gipSKK7FyFy+MxdJDDmvqSHH/NIl4dbraPTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xngOMi15; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64c3f08ca52so22980557b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133791; x=1723738591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6Q99M30pfVow/VZrp0OXErUk9qZ3L/8/fDluo5OZ/Y=;
        b=xngOMi157CPmp9o4UJ88t5aUiLJO3bU4faiKUVD+zbVk8fJ91XED3ToLB3G+Lr5DXt
         iQPLrX5+DWSV9VJy5nWLt6e/CSO6GmLGKElt+BLZ4RS7gj7UJ5fkq8NV6d9XvzyzYY/+
         1HwxK3gdRe9nEtH9UPARXMeo+nxMrmrFV65xccteYOhbdVvbIPUoQhV2bcdaKQMgir8g
         QGvwmNod+bsBEWesN5O73hR159wwPxtiXP2lWzNaYtcemJBdm29/DxymnsztaqFrRsJr
         XNCKuBa+zOfpEosoIj1nYqyviE8T2/gWfDgy1oaEU6TLIc7l93HTUiL9X1ujRA/vbK+b
         sMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133791; x=1723738591;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D6Q99M30pfVow/VZrp0OXErUk9qZ3L/8/fDluo5OZ/Y=;
        b=kai7JSPCVXaMrzBXl1OVQcNJg9dyVmVKMlZ6WEfAZXi2ToKakf/c8kjK/6mTbu1prF
         RCJBTOO3mxlBU2JTeeMjiopVz6rAybBCBn+PwP9LcfK3JwcIGjC5tMfi38BjAcawSpIv
         A8HjZY18EmuaFJUsaaRKVqD4v3CdsgJ5S1mWIY6PVkXPf43gboWaklX0PgVwKmHVaSoq
         cQAY6UOhwz62KvLHo6JjSeQQFPCM7ve4DnhVxBA8GJgsj3CgC3NiDXbIfW5AmTjhFq+E
         Kq7vaKCD8XoiZ1XuLDX/+SHRZytXMlsdtOUyXdvee59NcQWAP3qSm7SByzbVEExekFvM
         yfGA==
X-Forwarded-Encrypted: i=1; AJvYcCXjEsUkbLVEYI4Hg/XPpZJ5Bpt/b178jBnovFGoK8DnfLkbY6gq/m8XMk8c66KTwvkLf63kmEzoBs7Deo77tKGYmNWp8WJwS04npKAk
X-Gm-Message-State: AOJu0Yx5yz+YFdmdIYQbHQJpR6vCyNmzeqPx1z858GwDq4STTJrHnrK+
	8BA9TAc3lOBUyiy8/VApqqfn84+Jz6Hvurl+Te8AnWGkOPkvXnX0Yr8cD5FR/omr2Ts0CZGD62q
	rCm9N66mTKdZW/Q==
X-Google-Smtp-Source: AGHT+IHjKhmt3D8bcbLRy83MdOEq8l2jcjlXOpQD3wWuk5ZNpxZjN0ccli1jrWq07BiA2HaEn1LRXqh39g1w4TM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a81:5b08:0:b0:62c:ff73:83f with SMTP id
 00721157ae682-69bfd009861mr992547b3.8.1723133791340; Thu, 08 Aug 2024
 09:16:31 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:44 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5621; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=O79cAbTLjOkpOxwEF3Z9QrUnv7nzcQMruideT4KM+Fk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9VxvPC11vAKiPwxCea0/BDfH8/XkTnCPamv
 zalojrmzeCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvVQAKCRAEWL7uWMY5
 RqpRD/9vzLR6fVIVLVEQp85pk/Z2XQ6E89etE+ffgbDSHdgTLT/KXtLMLTqf1fnLhQgEVfnm02T
 docSA46GvH4T5g8fiU6sbXk4KACtp6IUAHqPCVi1Vl61gbvx/CK3gN97Tx6n57r5VEegobnCjVN
 W7mTISf/azV8LOUoFVp5DJh4CeQDJYGjiwGeyT1A6ba1becU4CdctxYu9XEJ43NWWB22yxGiCt7
 7ISrlCQ8FHaIqHkyuCfSKP2GD705HrNLTfJxLWfy2htYuoYCs9vDH2VpQTPLduWc039D5JQ3PZm
 0T3t9UmvoWaL9d7MtvbgcAfCvN9Vc5NXcTiISCCeyPn632HpnjKe+1rAODW0mPbxt+eRNO0KrLP
 BQRQZpnzc1NOkTW+v/jgJiUPDoqhPmVxA4BzRl7CCT4/HxoCggL1X3XVB7lzwqEO7OHi1fl7lY1
 5daZxIE0aHSD/ob0P3viYeU3vq0E2pBTYfySSVEBbz42CFPU/l/K5BVgR/w5/nYY+6CIhvuz2If
 npUUIrmmBHbbklZqEazx2GvbzfdnUU8MKQ6PKSRpfj4wCGyFq/TErj5O9iaM1UvC5vwA3EV529v
 1EusNG3U0NQaKopGt+n8YSl8UYf1QI7mM+KksuYmtKzMav7Bgy2gQlY72wP1YBNJA8kduZ03elb WJc5gNhABnwFeUw==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-1-2cb7b934e0e1@google.com>
Subject: [PATCH v9 1/8] rust: types: add `NotThreadSafe`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This introduces a new marker type for types that shouldn't be thread
safe. By adding a field of this type to a struct, it becomes non-Send
and non-Sync, which means that it cannot be accessed in any way from
threads other than the one it was created on.

This is useful for APIs that require globals such as `current` to remain
constant while the value exists.

We update two existing users in the Kernel to use this helper:

 * `Task::current()` - moving the return type of this value to a
   different thread would not be safe as you can no longer be guaranteed
   that the `current` pointer remains valid.
 * Lock guards. Mutexes and spinlocks should be unlocked on the same
   thread as where they were locked, so we enforce this using the Send
   trait.

There are also additional users in later patches of this patchset. See
[1] and [2] for the discussion that led to the introduction of this
patch.

Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWI=
lN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@proto=
n.me/ [1]
Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWI=
lN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@proto=
n.me/ [2]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 13 +++++++++----
 rust/kernel/task.rs      | 10 ++++++----
 rust/kernel/types.rs     | 21 +++++++++++++++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..d6e9bab114b8 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,13 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
=20
 use super::LockClassKey;
-use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::Scop=
eGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    types::{NotThreadSafe, Opaque, ScopeGuard},
+};
+use core::{cell::UnsafeCell, marker::PhantomPinned};
 use macros::pin_data;
=20
 pub mod mutex;
@@ -139,7 +144,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
 pub struct Guard<'a, T: ?Sized, B: Backend> {
     pub(crate) lock: &'a Lock<T, B>,
     pub(crate) state: B::GuardState,
-    _not_send: PhantomData<*mut ()>,
+    _not_send: NotThreadSafe,
 }
=20
 // SAFETY: `Guard` is sync when the data protected by the lock is also syn=
c.
@@ -191,7 +196,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B=
::GuardState) -> Self {
         Self {
             lock,
             state,
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 }
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 55dff7e088bf..278c623de0c6 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,10 +4,12 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
=20
-use crate::types::Opaque;
+use crate::{
+    bindings,
+    types::{NotThreadSafe, Opaque},
+};
 use core::{
     ffi::{c_int, c_long, c_uint},
-    marker::PhantomData,
     ops::Deref,
     ptr,
 };
@@ -106,7 +108,7 @@ impl Task {
     pub unsafe fn current() -> impl Deref<Target =3D Task> {
         struct TaskRef<'a> {
             task: &'a Task,
-            _not_send: PhantomData<*mut ()>,
+            _not_send: NotThreadSafe,
         }
=20
         impl Deref for TaskRef<'_> {
@@ -125,7 +127,7 @@ fn deref(&self) -> &Self::Target {
             // that `TaskRef` is not `Send`, we know it cannot be transfer=
red to another thread
             // (where it could potentially outlive the caller).
             task: unsafe { &*ptr.cast() },
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
=20
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..bb115d730ebb 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -473,3 +473,24 @@ unsafe impl AsBytes for str {}
 // does not have any uninitialized portions either.
 unsafe impl<T: AsBytes> AsBytes for [T] {}
 unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
+
+/// Zero-sized type to mark types not [`Send`].
+///
+/// Add this type as a field to your struct if your type should not be sen=
t to a different task.
+/// Since [`Send`] is an auto trait, adding a single field that is `!Send`=
 will ensure that the
+/// whole type is `!Send`.
+///
+/// If a type is `!Send` it is impossible to give control over an instance=
 of the type to another
+/// task. This is useful to include in types that store or reference task-=
local information. A file
+/// descriptor is an example of such task-local information.
+///
+/// This type also makes the type `!Sync`, which prevents immutable access=
 to the value from
+/// several threads in parallel.
+pub type NotThreadSafe =3D PhantomData<*mut ()>;
+
+/// Used to construct instances of type [`NotThreadSafe`] similar to how `=
PhantomData` is
+/// constructed.
+///
+/// [`NotThreadSafe`]: type@NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe =3D PhantomData;

--=20
2.46.0.rc2.264.g509ed76dc8-goog


