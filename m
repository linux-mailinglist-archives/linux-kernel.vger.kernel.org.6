Return-Path: <linux-kernel+bounces-181933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF48C8386
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5B828287F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215736B01;
	Fri, 17 May 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTHS//Pv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744C2E65B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938292; cv=none; b=Dz3DIfMFXdbI2So9sLc9P6/MJePVQu4TOB2TdT/xVp7LPUdcL/2ZaCEHR8bJt4TvcmbSC4maxdfOlnisOIR5BszNjOjUnQcG9JOqFap+DZrgYF2/D+RiWTQS1AqIL7RnV8cYV+rw9j0Wk/69A1ZhHXHumCnxJgS0/sNCNf3rx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938292; c=relaxed/simple;
	bh=aeDZ5/WJiHjEiF4UH6hboVPOjxNA69bgm3eiTRgYmfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OX96kC3uh0/WlPBgpMW0xfZdz/c/Gcng18oKq0gtEnMOxAVXW82fc7VW1la87kiLztgTmu1xc80nC4u6IyI2OGBenxYcIyEVijIi1hnGlOlqiP5Wz4TKX8KoZq+0CpUEDSvPa3eRlH2DONhS59kELko5VIAudgcHHa5BibUSTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTHS//Pv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de615257412so15657307276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938290; x=1716543090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FoM0hENjKLBpCTA6LD8LoCEIVh28wUrtYe5zjuUaY20=;
        b=wTHS//Pv9aS0HMrNUFIYFIxCoomkKone3teSU2eV9hyWdrj94qJBB9PDDVHvRAYH6t
         XBBRV82x8cnApte60YxVTnlhtzCfsZ5DT6qc3r/kQUtF7YSEZvaLKFmlYwvt2UhGX6io
         /VTHczQSCw2iQTgUCnpW7Ij7IC+pz45XpNG7OvHn8VOD96Te0OL+U+p7tBteeM+CQZKE
         4pqK/h1Tms++WMg99fN/GMiLGNLLoW9x877V0YVI73wPseKVJw7HGospEbe5AGyaLdE9
         jb7p/hYGJIHG2pceC4jYP3DwYDRMMrikayR6ucVOAZB0a1zQwwFqbEQgp21OLHXqE4Fw
         tw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938290; x=1716543090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoM0hENjKLBpCTA6LD8LoCEIVh28wUrtYe5zjuUaY20=;
        b=CpzpBse/SjSnibu1SXh7xi02keuK99/Ze1v0seGRjyDzxCakkXx9B3looFKNTT9BX3
         Rjk7iftqMFze1WIUVGBMPNaShR5Bmd/nSMa5BqAj94k4VoTDCxUx8P+0URuC2UDHZZIe
         D6JO9jcp+woKf7jLHPZNpRHD+yDsXYw8qqIgCPjq4982STmrRjXmcjkuiWqcE+6wfE0Z
         rk2kZjZg9LF42NiUsIX6qN5i+t98+YUDnvdppw2kah1pZw/D7eQEsW6VhGPs2bBYtQkm
         iG5nzVr0YcL/F+c1cUYyyTs2kt4S1ZpoLNidLUVwI7+cNYKgEjv1UiSvV3lUowl5vT8A
         oD4g==
X-Forwarded-Encrypted: i=1; AJvYcCVwYouIVeXgyOILvAPdPaOXACa1NWHykFxT1sijMra41fMWDMF+BsoSltN547MlRWvHJJ8hBJTmSBYADeE1uB4VWbstD1GQl9r9vnHt
X-Gm-Message-State: AOJu0Ywzb8uLtN1ue3H5WIRCBSGn2Pd3WvIzD2Z0MM34M+uKho0HnAdT
	kUV3lSlkoK79Get8tX4Mt+UGzQMXyd47BVrRjuhUKTV47JzdeB+Ioum8PNjLAhfQUDOGqKwcKOx
	aZQU6H0HcoHtveQ==
X-Google-Smtp-Source: AGHT+IHqZFQYWseUZbrAsp2HKPq882M8bbzO/ZeWgfL3ka1KdvfqLDDlOcmyC8pxOd0YlXBUEA0l6P4hkzYI+KI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:120f:b0:dcb:e982:4e40 with SMTP
 id 3f1490d57ef6-dee4f38b7cbmr5719897276.12.1715938290507; Fri, 17 May 2024
 02:31:30 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:35 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=aeDZ5/WJiHjEiF4UH6hboVPOjxNA69bgm3eiTRgYmfw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPlD7Oe7kOoxP0nNZ3unp+A7N+q81ujbarxp
 ByY9LWIQQWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj5QAKCRAEWL7uWMY5
 RoVpD/9ZGmHXHgnq3gdIVS7E2I7522L3OwFyacELzf4GgQe4FbsWhm2hwa1CCs9GO94YVSqSzzD
 bv4Vk0eWQgQLr4h0oAaVyw8rcj3SwJePix4BpX63h/NFtNAuraN+9eGlpeqMAp5AuFngvODxmVL
 dfLiimUZFfADSAbdm76cegTNXh/UMFt6oAyMo4eEeQlzZu3nN0UFBT7/4mjVbEv75zPUcGtEhb3
 Cv+BZpiM6Hndk/ARU8mqLuS3/Z9imkpCHUGRcPMomKNNmu9lawhjWE/1sEdyRvrhO+r1sVlEhWS
 tCQYqKrwl1J99laLFjWSXbh8IcTMIWHBNW0jCAeRNTcLta3610181saMhwTpEnS2Mzh9FhtWvJ7
 pA/WDvWQgXMRM/ey/5rLOnCb93KR/GP18WH+pITYarWVVpbT9z0fIc+Hes5gP5zU/l97qE1vFbu
 wB7gaBBja7R5xELsYsJJZXR8I8fw9UB3/IpUEsEEYSsCaRy4CmdWMCo5lPw3+d13uHSSzwnwkSI
 m6/2UM3Bk+ejNVi4qoY41mE4OPADCNI/rKIgbAxw/WaNyW/5x0kJ13+YJo3y5fbSU3KIcQuWZkP
 uvr4VQWsTjIM3qMull44hNghLKpkYC7D4WtGUQ9OlVUzeQ6BdnDvhAN120FwdV3B8Yg4r5KQWF2 YGeeTkqAHc3xJ+Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-2-b25bafdc9b97@google.com>
Subject: [PATCH v6 2/8] rust: task: add `Task::current_raw`
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
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>
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
2.45.0.rc1.225.g2a3ae87e7f-goog


