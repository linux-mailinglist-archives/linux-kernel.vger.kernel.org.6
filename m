Return-Path: <linux-kernel+bounces-377085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B446F9AB9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5778E284769
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DEA1CDFD1;
	Tue, 22 Oct 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk5US8YZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF91CDFC3;
	Tue, 22 Oct 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637362; cv=none; b=tIB2OuIr0kTLrh7m7LfEnKxzc4OKerkIN7AIiwJwAZ4rUD2tAPJjO4RTb3BTUELyOB/xGOusIqOK7MIX6zv+0H21ZL8wNc8u2n9hSAORVxBsWWyqJ33aFIWgJo6izOT2uL6AmId3X+isklQVPN39I/UoY9vWwhWB2IBJ+HTsdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637362; c=relaxed/simple;
	bh=uW9diALEP9ZtiLTXAb1PZ+oZzD1vayfhCvZE6VvGSGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ltg7dsNwhFcsfl4zslL4KewdNq7RQATT/vzvv5yUGOh19O8FZqcVhEKoRWilnMdHiB9X6dOEeMyaxonmckqs7c5SfeJ4j38xn5jzamli9HkLwvTNDcLmxMYJmxKwmv6G6jagoYGvFL/atC+zC6Lp+nrbnrf05BhxtXvyPpnZYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk5US8YZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso5499405e87.1;
        Tue, 22 Oct 2024 15:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637358; x=1730242158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/j3y+C65g8JL4SR/Lkh7VbOU4M9pFoYcH6/NF8qhIk=;
        b=gk5US8YZjUUXbV5FV1CBz+DpqwstZS9YU8OEZVPsg0ptkvjjHMC33TehZUB76nzxkm
         /Z29+nDWzM22s+U2QJ7iHoCiTQpowBoK51d7wbnEph8336hhjU9Y7CR9SrYaO5D2GH6Z
         2OuIdy31zLPB78GlhFKOZr2v/Z6tOcq1MSp9BoxDLVxwWqLeOR9/LhijJIU41RN/9YHW
         g+OlYTycrwYqnIAfMEDJXC7B1xxRAkveh2/AzlHn4RuFDDg9Dpf5qSBscY0hySGEWAI4
         M9YhetLvGUu/DxsaJZdinHzP3blmF995gsQJOAIIjjPaG6xyWHXymOQTw7GOZrsNQ0GK
         q5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637358; x=1730242158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/j3y+C65g8JL4SR/Lkh7VbOU4M9pFoYcH6/NF8qhIk=;
        b=Hu8Ua7HOTiw5UhlludtVFHMxzDzCLWK5gnkNudAPilMJkAmYdR4RTgyMbaTm2qjlyo
         QoBxx3HNNSJPu53Ah4foGpKDD6vdTzKjM2Ks/GmUMH3g9qtqWpnUBBrnUPEP6y3dx6IY
         nE70W+lxyjBxZStvknrvFOmOoaLPneQive2RKuhl1FT2bYcNegOJ3BwMYlxR0vWUV3Xc
         OT1cYy0oKFsJ28H1BTBwVuln39rHVcke7NZceIB4pACUjAF5sNgLqnL0nGSyCoJtiTox
         X5mS6eoqXfe3YF/pKOGcII9A1IZq0/vu7J3OxQS8ae2haiFhq71R1LQRsNilO5OwcO0W
         K27w==
X-Forwarded-Encrypted: i=1; AJvYcCWmImNYGGAbMcfT/x+/46Baxzygm5w9aV/vYIq6W1chl4BCJ+ikav/ntzRpdbKlQoe+EtQiYTIqNSU6+ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKerCEPKHa6vyQ9rBLDF91+iQh6WWWciadp6mNwbO++zjczR2
	Da1tGTaTH+UuITHl6s9Cvbh/M5vRMzy+nlxe3zLezAtBjIv/epRKnh/yhQ==
X-Google-Smtp-Source: AGHT+IGJNc5G/N9oAN/iMJnW3Q1hdzKMq4lY+yTSxrxoH6XLwRn2fVgS/hlgwcDG1ZslsQYakLw6dA==
X-Received: by 2002:a05:6512:281e:b0:539:89f7:3187 with SMTP id 2adb3069b0e04-53b1a36c709mr169463e87.47.1729637358314;
        Tue, 22 Oct 2024 15:49:18 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e595csm894881e87.14.2024.10.22.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:49:16 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 5/5] rust: firmware: implement `Ownable` for Firmware
Date: Wed, 23 Oct 2024 01:44:49 +0300
Message-ID: <20241022224832.1505432-6-abdiel.janulgue@gmail.com>
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

For consistency, wrap the firmware as an `Owned` smart pointer in the
constructor.

Cc: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/firmware.rs | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index dee5b4b18aec..6da834b37455 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,8 +4,8 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
-use core::ptr::NonNull;
+use crate::{bindings, device::Device, error::Error, error::Result, str::CStr,
+            types::{Opaque, Owned, Ownable}};
 
 /// # Invariants
 ///
@@ -52,10 +52,11 @@ fn request_nowarn() -> Self {
 /// # Ok(())
 /// # }
 /// ```
-pub struct Firmware(NonNull<bindings::firmware>);
+ #[repr(transparent)]
+pub struct Firmware(Opaque<bindings::firmware>);
 
 impl Firmware {
-    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
+    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Owned<Self>> {
         let mut fw: *mut bindings::firmware = core::ptr::null_mut();
         let pfw: *mut *mut bindings::firmware = &mut fw;
 
@@ -65,25 +66,26 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
         if ret != 0 {
             return Err(Error::from_errno(ret));
         }
-
+        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::firmware`.
+        let ptr = fw.cast::<Self>();
         // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
         // valid pointer to `bindings::firmware`.
-        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
+        Ok(unsafe { Owned::to_owned(ptr) })
     }
 
     /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
-    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
+    pub fn request(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
         Self::request_internal(name, dev, FwFunc::request())
     }
 
     /// Send a request for an optional firmware module. See also
     /// `bindings::firmware_request_nowarn`.
-    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
+    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
         Self::request_internal(name, dev, FwFunc::request_nowarn())
     }
 
     fn as_raw(&self) -> *mut bindings::firmware {
-        self.0.as_ptr()
+        self.0.get()
     }
 
     /// Returns the size of the requested firmware in bytes.
@@ -101,10 +103,13 @@ pub fn data(&self) -> &[u8] {
     }
 }
 
-impl Drop for Firmware {
-    fn drop(&mut self) {
-        // SAFETY: `self.as_raw()` is valid by the type invariant.
-        unsafe { bindings::release_firmware(self.as_raw()) };
+unsafe impl Ownable for Firmware {
+    unsafe fn ptr_drop(ptr: *mut Self) {
+        // SAFETY:
+        // - By the type invariants, we have ownership of the ptr and can free it.
+        // - Per function safety, this is called in Owned::drop(), so `ptr` is a
+        //   unique pointer to object, it's safe to release the firmware.
+        unsafe { bindings::release_firmware(ptr.cast()) };
     }
 }
 
-- 
2.43.0


