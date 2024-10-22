Return-Path: <linux-kernel+bounces-377081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690819AB99F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94351F23DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F51CEADA;
	Tue, 22 Oct 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyl/rWM/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5431CDFCF;
	Tue, 22 Oct 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637354; cv=none; b=ODrE9eQ7IK5Cl3TIFc+YMyQbVDU0VpCCpTb5zlDPS4kdSt+XwmVcL1HHFlXoKvOcRN/QUL6oC4uLM6nYAaMld5MsVuIqxJLvasTnfrnvYLp3OE9TOdy6RCS7X3a1r0Y1Eaw/kHv/EUemileaP1Yylfg0K0OjOITS6m7pFvASyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637354; c=relaxed/simple;
	bh=dhg9Ow1q/Pu067jCJtPo7EpABRZtIgMCRV8vgtJBB7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxCGz1C+4/Ku53yLKfFWnV8/3+n1ff8ywlfcTw8edU0zTui1R90yulToQc2MeWteRK4kjJHS6cmYOUstKxCIaqmgTzzJI+1iV76mylPXHdWhOZ+OPE/4t6vQcRBURaZI2J3OuGkmtfoPdmVii9X1sYi/KmtTYBCCqLldLxn0n8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyl/rWM/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so2169424e87.2;
        Tue, 22 Oct 2024 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637351; x=1730242151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8Uz8SZaQ3TwhW3QvRSUwgmeCqFgrOwfQIdlwehb+ho=;
        b=Yyl/rWM/AE03J8uK2jKyPgdtnIAkKsgu/471f98TGZp1P50/Y0p/iwl16ExUz4v+CT
         aYewr47u5iqpc/mzN/UzFa1OLoM+1HcVQXqzQ8fDFGEi4lruG709oiHDiaMj2ZWvJaCh
         ZXWbCClTbYp0B/OZrdC2Dn6/APTxo+/AQgWnsUihEgr1aOKaXC6CM0S8rX548Bk76B/r
         tOM7J5D31GwVbEQwAkzVLxM4q6Axla5KUa3p4Jp5tqbA8Czj7/Lf55mNfmdriAz2owz9
         0oz8Psa+OpRp6KacBHkSTpApDX2osqXcExVOOQp7i1NZfz100JH2EWf9PfArHE7XTAPE
         Bm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637351; x=1730242151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8Uz8SZaQ3TwhW3QvRSUwgmeCqFgrOwfQIdlwehb+ho=;
        b=QQ0GZj260cE4wUgBF0hrhBogAkevZhI0UPbyAaX7nQ8pP3NT/Qj7J7qF8Dlk4D+Mg4
         FE6U2v07JOrlWVBt6oyEYsNN3lrMyPtLWph5GQOfCN6qy2jMkKT0CC4WnINfDIma/Nl8
         mVgw0sxvGpBH7iHORU9X3bkiRKUMMOBlIOX1SydSJkK+JZXy4byn8z7wrhFmEsaC1ibo
         xTmPKWgyv+NbBxB+MOl611ouFA9IToBkZfvUHO6Sdoh1HobjyZRUtK8HzwfAdGL0Lzvi
         417sGlpiS6JuRCCknYgdiBNalmvLSBjJ1bV65GgOREdVygjHnwqxZBX38CtvteuuFyiw
         17Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUVmb/wd+16Lqz0gfoEGZOBvp6gUgtifGJmeEad0pFZfK0K88Fog/s5iIhS1ReXHguOUlT0ICJOJf274QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ueqPC8GlhJjN/pURjS+60Z10eRd1yn6Zka2J1bc5bSICsR7d
	/R1DwBrlpkQieAQfkx6n1ndDHINV3UrGRTw7O2WjZaJvgZGiPBrrd3KXig==
X-Google-Smtp-Source: AGHT+IGaAsE2puMxpOq6QjnrGfOr66sCudnSRqP0Ob/HSYOC5DnqO/Cugp5izgNkTM2hBviumT0CEA==
X-Received: by 2002:a05:6512:23aa:b0:539:8cd1:848 with SMTP id 2adb3069b0e04-53b1a3bae89mr285858e87.61.1729637351019;
        Tue, 22 Oct 2024 15:49:11 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e595csm894881e87.14.2024.10.22.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:49:09 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
Date: Wed, 23 Oct 2024 01:44:45 +0300
Message-ID: <20241022224832.1505432-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the 'Owned' type, a simple smart pointer type that owns the
underlying data.

An object implementing `Ownable' can constructed by wrapping it in
`Owned`, which has the advantage of allowing fine-grained control
over it's resource allocation and deallocation.

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/types.rs | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ced143600eb1..3f632916bd4d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -429,3 +429,65 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// A smart pointer that owns the underlying data `T`.
+///
+/// This is a simple smart pointer that owns the underlying data. Typically, this would be
+/// returned as a wrapper for `T` in `T`'s constructor.
+/// When an object adds an option of being constructed this way, in addition to implementing
+/// `Drop`, it implements `Ownable` as well, thus having finer-grained control in where
+/// resource allocation and deallocation happens.
+///
+/// # Invariants
+///
+/// The pointer is always valid and owns the underlying data.
+pub struct Owned<T: Ownable> {
+    ptr: NonNull<T>,
+}
+
+impl<T: Ownable> Owned<T> {
+    /// Creates a new smart pointer that owns `T`.
+    ///
+    /// # Safety
+    /// `ptr` needs to be a valid pointer, and it should be the unique owner to the object,
+    /// in other words, no other entity should free the underlying data.
+    pub unsafe fn to_owned(ptr: *mut T) -> Self {
+	// SAFETY: Per function safety requirement.
+	Self { ptr: unsafe { NonNull::new_unchecked(ptr) } }
+    }
+}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable> DerefMut for Owned<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+/// An Ownable type is a type that can be put into `Owned<T>`, and when `Owned<T>` drops,
+/// `ptr_drop` will be called.
+pub unsafe trait Ownable {
+    /// # Safety
+    /// This could only be called in the `Owned::drop` function.
+    unsafe fn ptr_drop(ptr: *mut Self);
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    fn drop(&mut self) {
+	// SAFETY: In Owned<T>::drop.
+	unsafe {
+	    <T as Ownable>::ptr_drop(self.ptr.as_mut());
+	}
+    }
+}
-- 
2.43.0


