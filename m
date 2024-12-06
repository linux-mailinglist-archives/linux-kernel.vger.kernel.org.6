Return-Path: <linux-kernel+bounces-434671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F39E69A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FA61884412
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B601F03E4;
	Fri,  6 Dec 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeDAikPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17521EF097;
	Fri,  6 Dec 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475937; cv=none; b=Qm3UYO0uw8QSbXGHpzZzPmfM1a5TsIhLx2+9UFGFoRpuxKllVazTT+7BrvVTpRjO+B2tkgtpGEC7qxwoOoFQ6qXPQVCPKKw8t5AcFttb4QSFvL1xPsu5DkiyunF+k376U4EBxw0qHh4Ha5sCgkZ9K/iYdfCNS90vHUyuw9HwECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475937; c=relaxed/simple;
	bh=RZlItOZezRowXOLbsBUld7wmGQAUobHGREmd6YYqaDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMYBG1P74KfpmCMfRbsxKQrdf2VLUedErSiQ5WcfOoa0cMy4HbF0DOBX72A6o3K/rnevptBJZDUc+ovmoBw3tNTa8GbnzWfPb8ong51d0wCk+cnvl6Vx6PIhPm3sBFoI45LrOr8CcPeVNfyEWdvVmFn5TPruAJzsnX+NzAjr8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeDAikPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81986C4CED1;
	Fri,  6 Dec 2024 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475937;
	bh=RZlItOZezRowXOLbsBUld7wmGQAUobHGREmd6YYqaDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeDAikPSlCiDr6NEVNvzPn4isnpWs57s0DFGtEbum25hLbCv8nWTt5MhqZTPfM9qN
	 hZx3GHCVdSCWVEU3AFbupBaYgfz8g/qpBC6+9ThJvsPvrcVXKL35/3YVnQez3p1NWk
	 56tSWJ8pFU1vVY9tu4jJqtV1LpOf9BVxeecJLHfvIZPk2fULZogBnn+k9eYM2aZMJ8
	 p6VyzrNElRiLh91Q0Mt8YPLuKUhc9XerQaIfibF90bsLBs5ewyhjolvRobt+RF9vU7
	 8Ow7g2Z0qbJ7zSEQx4i8+DC0xhO9jGJROeq5Lej7e6lvADkgOmgIK6FM2Wg9ffmYWl
	 KKgpNP9vbJtzw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out miscdevice::this_device
Date: Fri,  6 Dec 2024 09:05:04 +0000
Message-ID: <20241206090515.752267-3-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206090515.752267-1-lee@kernel.org>
References: <20241206090515.752267-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where a pointer to a `struct device` will become
necessary (e.g. for calling into dev_*() functions).  This accessor
allows callers to pull this out from the `struct miscdevice`.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 rust/kernel/miscdevice.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 7e2a79b3ae26..55340f316006 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -10,11 +10,13 @@
 
 use crate::{
     bindings,
+    device::Device,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     prelude::*,
     str::CStr,
     types::{ForeignOwnable, Opaque},
 };
+
 use core::{
     ffi::{c_int, c_long, c_uint, c_ulong},
     marker::PhantomData,
@@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
     pub fn as_raw(&self) -> *mut bindings::miscdevice {
         self.inner.get()
     }
+
+    /// Returns a pointer to the current Device
+    pub fn device(&self) -> &Device {
+        // SAFETY: This is only accessible after a successful register() which always
+        // initialises this_device with a valid device.
+        unsafe { Device::as_ref((*self.as_raw()).this_device) }
+    }
 }
 
 #[pinned_drop]
-- 
2.47.0.338.g60cca15819-goog


