Return-Path: <linux-kernel+bounces-262325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4593C41E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D161F227E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096F19DF70;
	Thu, 25 Jul 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIGrO0HS"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A319D8AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917671; cv=none; b=SVhTktVcFbTIo7F49BHAU0NW2zhI2+YbrbdFKhY0Sr80N+QSwWOMJwrv8PMT9SPzCWSVgrGk9aBLFlidjn3V0vw6g0h/5BVqC3zn1dSrFT04wxiH6JLwTi3VekbPzcvYHziIqS9gN9Wrm25011EltU0vhhJdUcqIVfIgglfdVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917671; c=relaxed/simple;
	bh=Y7EveGwaFZVeZYYvVcVUkcGhuSESwjRgqqnewAo3pxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TC44a80YK93AOlPIl6yVOVv8cOqLb2NypC6yWoKMJFkQIMEaZpU6hnDc/UzTzXZpv8vTOI05pw6ilLEWmYrA8XbMludiJck5i9FOyi3Wyf/wW95bALYut6IX/6xCxjpahNf3A1lHL7cq9Zra9k/14sU/RVCxe/YiNa7ynGojCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIGrO0HS; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ef1ba2a5e6so2361861fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917668; x=1722522468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqu9hbcZjiCiJxMWwW1DRQvdcpwKODwZoAJXE9dNBuQ=;
        b=IIGrO0HSUwM4JAC1W6HTDEVta8UwvgIgaq88d/TfulzvvsxkQfw3uS6r3JcQfoC0Ql
         +0LdZO3H5fjctx2dZ1S470carvP6nQiUFf7mlS50fwJOxkgzmfe6pO3F4FZTCH0FfRo2
         MeIiuA/NSRuc+AhdcV0HohR6k/iAWpXOp8qXwQzGqCTJ3I4clDWkLeg7kFim+v++p6MB
         8d2sNOURRwOOvhyqa2foU/J8cGtTeleb3B/qqp6pyrtYBtzkiKwNa6dd/e/Qm5N8c4gl
         66mzTpUn0uN+yav+VEfvKrtmPmrkRRboLdrOaXpJoU21MIifqyWIamjX3p18YPJZYKxY
         Jp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917668; x=1722522468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqu9hbcZjiCiJxMWwW1DRQvdcpwKODwZoAJXE9dNBuQ=;
        b=etFjHaNyFfdFJANM0B5urVFDaUnYXnnl+NC2lUz3pohhCif3A/0iUb1RczCcik4qUW
         I7yelcQI4eq8kwSUFMDjRF6UfEkAx0tCGHOcmDL7AACb1giFXc9XvG4ILStyeEUQy2T1
         gfK4tqMCYwj3ARMs5+5b/ZTpUpJRVBz+NlDcRoIILGAX+nId0c6OUtAqlszetlE9nWg1
         urUbDkzMytYWZZ4Gfxz0lXp9Sya70NvY77NaqG06tr1Mng+5aGR49NGACEgoOy9itipS
         lB3m1KvVS6VFYEQGeWHSBYVkVBKa8F5sM9DhuGVd9ngQGF0pBUzJrce9046ibPHWnRcV
         QFgA==
X-Forwarded-Encrypted: i=1; AJvYcCWMtzFqiIgcaHbgtfReBdefgz2BR5QVvBrn7wx8MvvPWh3p57VWO2c/Pg2p4uiLmk831fFp18/PfBe7bUPrubjExkAd6m9sPYdNmqbm
X-Gm-Message-State: AOJu0Ywjm/ujOWx0W7fOkEGtZwK1OHz9CHS2yKzwPwvzHMw/8DqdkCle
	1moxjUlAyCZQDgmkxoML6ogv8S1a0fPVstgMY58kK00/dWpVlQBTH7uCoFsdvxQ9yY/H64h0zoi
	rpsI6O1vWYMAflw==
X-Google-Smtp-Source: AGHT+IFnXRADlnUEbxl0mtBvfwQuGp+zFQ+sJ+3vf/k0s7kKBVZQ+Ew6ChUoyD+TuMMrhdtMCgU3QmSJ6KPBxEQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:97c4:0:b0:2ef:1bc3:3fa with SMTP id
 38308e7fff4ca-2f039b3999emr48501fa.0.1721917668172; Thu, 25 Jul 2024 07:27:48
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:35 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y7EveGwaFZVeZYYvVcVUkcGhuSESwjRgqqnewAo3pxw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDXe7TQovfSy+bcM+80aWs50pz7TKA1NVt2F
 dKLuFFnsZ2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg1wAKCRAEWL7uWMY5
 RpJIEAC1c3zbht1aNR9FY2+6fNMS99tzB2GUHPJaEdtuUJ4ILd1Eg60NRfZuOdJcp58SdE75C4R
 DxcTruQkGWaQ6GUOHi9LcnOfO3YgxzHKdjnFeZ2XRdB4o6kP+V4oaT4h9GI0TmllzHOl0iAcP7y
 iCJe5J+1zEo2PUPeR5sq1dJhzJ1gisMMlqu/kdCZ0hZhpHI3OEF+RPnb2CfZrSGm6ywXyLtrRGT
 X9idZihV/78sRUhhwXb1OU5xaJgrd2ltriARLf66c4dI/jkqurNSSWMgYZhoAZq4o4BjXuQoVXK
 kqjrAK06BgJLj2sKp8GR4QqRoZha6rndpSyDkUIfOi1MqFgJLpMUW0Z/SBLyap9Ya56+zsemE2J
 LzWfzOAT76t8xTPDvN9pNG1jKHgsNGYBFSRyraWlUtVZD7YD7o8Zk6LSP3cF4bDdc7DIJOlKFWh
 U6IDSZ575oMK4ltRD7KwcKnioadJrujgwOJCobcqzSkRVs5cQ5KNOW4LG9OyBEkhdj6bj32CLHh
 Ry7preBUES11aSl79B8RNZnVgoD8PRXx0RkXS6lsY914s60hjcYDMDi6PdjCVYhOFGWg1BimRf/
 O48jMkZXjXyM2HA8rSAFAwwAhFfyzQSIOKc50Q/E0Go2O+gM2Nd4pzF2WvZxI+Mmq+i3d8zcOLg F/mNAgZB1cBXWOA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-2-55a2e80deaa8@google.com>
Subject: [PATCH v8 2/8] rust: task: add `Task::current_raw`
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

Introduces a safe function for getting a raw pointer to the current
task.

When writing bindings that need to access the current task, it is often
more convenient to call a method that directly returns a raw pointer
than to use the existing `Task::current` method. However, the only way
to do that is `bindings::get_current()` which is unsafe since it calls
into C. By introducing `Task::current_raw()`, it becomes possible to
obtain a pointer to the current task without using unsafe.

Link: https://lore.kernel.org/all/CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCmX0Ang3tAgGHA@mail.gmail.com/
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/task.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 278c623de0c6..367b4bbddd9f 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -97,6 +97,15 @@ unsafe impl Sync for Task {}
 type Pid = bindings::pid_t;
 
 impl Task {
+    /// Returns a raw pointer to the current task.
+    ///
+    /// It is up to the user to use the pointer correctly.
+    #[inline]
+    pub fn current_raw() -> *mut bindings::task_struct {
+        // SAFETY: Getting the current pointer is always safe.
+        unsafe { bindings::get_current() }
+    }
+
     /// Returns a task reference for the currently executing task/thread.
     ///
     /// The recommended way to get the current task/thread is to use the
@@ -119,14 +128,12 @@ fn deref(&self) -> &Self::Target {
             }
         }
 
-        // SAFETY: Just an FFI call with no additional safety requirements.
-        let ptr = unsafe { bindings::get_current() };
-
+        let current = Task::current_raw();
         TaskRef {
             // SAFETY: If the current thread is still running, the current task is valid. Given
             // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
             // (where it could potentially outlive the caller).
-            task: unsafe { &*ptr.cast() },
+            task: unsafe { &*current.cast() },
             _not_send: NotThreadSafe,
         }
     }

-- 
2.45.2.1089.g2a221341d9-goog


