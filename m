Return-Path: <linux-kernel+bounces-433659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E029E5B55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9AB16C6BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549F22257C;
	Thu,  5 Dec 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX/o4hF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76C222596;
	Thu,  5 Dec 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415944; cv=none; b=dRTG3j73kR23xHeR6V7J4P2kkqChsVqS02SVfRJbB8xqTw+JSZ7NOlc2o2qjO+GKkQJkGQz+hquP37Z0y4akEWa62bHuGP1jAiGKlQRSJFF0VvLpQ1cB5nKcivdq+wIqVClz1hBI1y1lxDYJYWzoWapWXu1YlHO7aMjV2zYYizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415944; c=relaxed/simple;
	bh=RZlItOZezRowXOLbsBUld7wmGQAUobHGREmd6YYqaDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVpq/wNJasMdWAoe25Rrwwl2+fak2P6l9Yx6M5kgi8CuW8//zjPXizdGbNmadnbAC9+AJp9gfNc0zz2clHEH4Y+izrSKGQ39BPsb8Z8SkxGJjhhrll2wy5c3u3sO0NZnbRpnuMBPwopxojjF7ixkVWUzyy1jj1erSIkGe4yqn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX/o4hF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A6EC4CED1;
	Thu,  5 Dec 2024 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415943;
	bh=RZlItOZezRowXOLbsBUld7wmGQAUobHGREmd6YYqaDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uX/o4hF0EYnzOMaBpy9lPRR3UJp46Uu6UF2GCVGgUQ9pu7p25jTk9ovNAJ/6g++pV
	 9J4VyQ5nauNcCpFSJ7ddFZ6+j0qm1IsOQTNSpNPot649yheLFIMKnG1TOG+m+larr7
	 MPycD2ZLx6TGxgorKizOQcn9wEvOFWfvvfnxH8pJl/Pp9n8FRw797JKaDMfzK3Jr2y
	 P4xOLxI5U7FKwUO/bpe/BiuWvS1Z9bCOp6tiZ/BtJXYNxe989xvsRntxl9ZVqcojH0
	 U+impmyLCIsfx9Vfu55szyn9bbYmRCvraWHCqAE3EZ+eiqDyU7iSU4w6aGhb2f94dJ
	 /rSn1eKYOzMqA==
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
Date: Thu,  5 Dec 2024 16:25:18 +0000
Message-ID: <20241205162531.1883859-2-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205162531.1883859-1-lee@kernel.org>
References: <20241205162531.1883859-1-lee@kernel.org>
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


