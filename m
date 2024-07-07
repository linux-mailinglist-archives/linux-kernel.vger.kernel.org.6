Return-Path: <linux-kernel+bounces-243446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC7E929632
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE493281B04
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03616FA8;
	Sun,  7 Jul 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSum78R6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633F4C98
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312745; cv=none; b=sDuHWgh9rS8X5vCn6qbBIyxmB1pKDNBXPQPZ6eU7XGBZiteEeL6gUAc4UDfrsoX4rSBLSeNgyyskUXZl8kI2WwoHlQKYZLjEw16wkbwuyhcdmXPWzvp1pDivgvZomERCTfG40GrnG28kBHUxcyo9G2/JlDqkKnnOAnoouG/sxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312745; c=relaxed/simple;
	bh=/MW+vrHxwtv1Z2jwb4J7vsEvvyJDF+ox57TF1JOPjFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAxH25P9XhufE2Eg4U+O/umt1r9ywyRJyoV3kVorHL2mt/GP2xsJ4ZkM4pvSvsRh5Wgb8YKi/z0eZLtejhqKLyjnF9VMMOo7YvePeOrdtED6mAUI8Hhr/VEfDQ9gZt6eXjrG2JxAnJtjNvTQGcea+EWdV5zRm1gPdhcmBgaj/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSum78R6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720312743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gQj5flv6blMz+D63TYKnFNy2JktE4M3hkANmL8zKBo=;
	b=GSum78R6STYQpuk2WV3WwWc/rzF5N3KUlaffCfzELBPoBlLtWd2oHagkgm7eajeQu4jUHM
	GJ+Ljydi+fgWM51Vaish6Ym5J/eEUIyuFjfJKRNpNw/R7qA2/HOzb8I/kE2F+jCmifYOS8
	/hAWAiTPiRduLhZiwV1HtXedLCvd2ug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-PzCjcYWINUWKhM88d_Drcg-1; Sat, 06 Jul 2024 20:39:01 -0400
X-MC-Unique: PzCjcYWINUWKhM88d_Drcg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42660bca669so4053285e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 17:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720312739; x=1720917539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gQj5flv6blMz+D63TYKnFNy2JktE4M3hkANmL8zKBo=;
        b=MkT3+iZzaDwRxUHRl/9PnohaiZZxQ3enAYHH8PaNH+PfTC9xT6xwTk2ZLmU+/GBxMV
         7helLtXF9PDimXKWUhqJuO41MXAIoEPGchY8xs6DufRYIBOxaRanoBcwbEECEcImmYvV
         S7eedbFmq8yK+WBiUa3RyXV+8jREgMM8SXH8E1EFp2RWJJB0n0vhrNnxzsFYkZ9acwhy
         2yahjRyj8OtkonuAMAlDLHrtoklsE/12rZGPl7hif9GKwnmfQRVidQi2l3Y+E4frNYZ5
         VVkfXTTq22+9RK8ky0gn8slrF5fxYV3OZtV4OOQ7ZKjEv9xE+fwGGbNRokbDI3pg8gmN
         AdBA==
X-Gm-Message-State: AOJu0YyKYQ5J/jB8UL0NfO6mT04AplCK3KXSZycLlMxW+iu0vVqE/F8s
	mk5S1LIDvPIpOuYtHw7vLl+EoCd0SSj4W8ILsTK3rNTyCD19FYvZ6waHY1Qaa8TThulQA//p8kt
	7mn3vKYyOsGlUQrsNqjvCG8ZQ/8MMAZvPtJ0O2Ztb2IHFiEykbaxmEhhf2SuCnA==
X-Received: by 2002:a05:600c:379a:b0:426:5587:752e with SMTP id 5b1f17b1804b1-42655877719mr33419555e9.14.1720312739248;
        Sat, 06 Jul 2024 17:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeUh5IO7KWMPcicWSLYk4ZZjnPEV+n+2NKOXuGneKmtsdgE6z78eQpMX18t8aVR+bAJpGy/g==
X-Received: by 2002:a05:600c:379a:b0:426:5587:752e with SMTP id 5b1f17b1804b1-42655877719mr33419505e9.14.1720312738961;
        Sat, 06 Jul 2024 17:38:58 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426602e4461sm33139085e9.36.2024.07.06.17.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 17:38:58 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: mcgrof@kernel.org,
	russ.weight@linux.dev,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 2/2] firmware_loader: fix soundness issue in `request_internal`
Date: Sun,  7 Jul 2024 02:38:26 +0200
Message-ID: <20240707003835.69090-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707003835.69090-1-dakr@redhat.com>
References: <20240707003835.69090-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`request_internal` must be called with one of the following function
pointers: request_firmware(), firmware_request_nowarn(),
firmware_request_platform() or request_firmware_direct().

The previous `FwFunc` alias did not guarantee this, which is unsound.

In order to fix this up, implement `FwFunc` as new type with a
corresponding type invariant and unsafe `new` function.

Reported-by: Gary Guo <gary@garyguo.net>
Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/firmware.rs | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 106a928a535e..d765ecc85d38 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -7,11 +7,24 @@
 use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
 use core::ptr::NonNull;
 
-// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
-// `firmware_request_platform`, `bindings::request_firmware_direct`
-type FwFunc =
+type RawFwFunc =
     unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
 
+/// # Invariants
+///
+/// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
+/// `firmware_request_platform`, `bindings::request_firmware_direct`
+struct FwFunc(RawFwFunc);
+
+impl FwFunc {
+    /// # Safety
+    ///
+    /// Must be one of the functions listed in the type invariants.
+    unsafe fn from_raw(func: RawFwFunc) -> Self {
+        Self(func)
+    }
+}
+
 /// Abstraction around a C `struct firmware`.
 ///
 /// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
@@ -48,7 +61,7 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
 
         // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
         // `name` and `dev` are valid as by their type invariants.
-        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
+        let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
         if ret != 0 {
             return Err(Error::from_errno(ret));
         }
@@ -60,13 +73,20 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
 
     /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
     pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
-        Self::request_internal(name, dev, bindings::request_firmware)
+        // SAFETY: `bindings::request_firmware` is valid by the safety requirement of `FwFunc`.
+        let func = unsafe { FwFunc::from_raw(bindings::request_firmware) };
+
+        Self::request_internal(name, dev, func)
     }
 
     /// Send a request for an optional firmware module. See also
     /// `bindings::firmware_request_nowarn`.
     pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
-        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
+        // SAFETY: `bindings::firmware_request_nowarn` is valid by the safety requirement of
+        // `FwFunc::new`.
+        let func = unsafe { FwFunc::from_raw(bindings::firmware_request_nowarn) };
+
+        Self::request_internal(name, dev, func)
     }
 
     fn as_raw(&self) -> *mut bindings::firmware {
-- 
2.45.2


