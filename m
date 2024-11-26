Return-Path: <linux-kernel+bounces-422597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470B9D9BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D3C162B57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1C81D934D;
	Tue, 26 Nov 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN6ZmX1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE471D90A2;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639282; cv=none; b=klhVHUyj6k8Nzj0u/zB5L1GpmACKLe0pHLc+DfITFiWYmN87iu0v8ylD3oELVSFQ+V+IDbCGVBGNlA7/BuyWom4tULsjIBw0NnvLkmQevc824CycVJPKAbqQoFUYG50Rln0QGBj4XX/6EWFUKBl9JX8bVS/jquPfIBisVI2nIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639282; c=relaxed/simple;
	bh=GyJvPB50oeV6Zjav6RVFR1Tf8UwuOKhDrMr6u7Po32g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYcrcB+jEEy6kKPQeANs52wNzlA2cnlUZBn+E/yhb9KRoic+j5ZgCj6dAAnzwPqhI5kSeGm8e4Vfh+B6tcDkl+IUi557yN9mM43dTy+3EDLmp1O8I2+ctHEFrgIbUAjL51xZRZ8q3ciQ4T/IBsX7fpB6o+Scw1huJkxmg9FSjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN6ZmX1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A8F6C4CED2;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732639282;
	bh=GyJvPB50oeV6Zjav6RVFR1Tf8UwuOKhDrMr6u7Po32g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mN6ZmX1AgacyOiV/TTw3yohx+R0OZFhOpYfzAcIlCb89MnCHa8mwLXRFMih5T3C3r
	 TWjDK0Z23lSKAeprFemjgavoYFyfIuDyPEX4a92VfBOZomNTwRRVi/vVwT1FxU+wT0
	 MZgF5dOsK52Og4gQNHyNxkK3UtBl0rCtyIBnggCYOt5f0qKS3g/Hb7lQZSOFVejpyC
	 ZuE2CZrgQATlYN1ozqgh4iAS7tZmKokjPu+kZFANsuWFkJxJA2gdCE0X9itPaCt2Zs
	 fA3lKH+zAzKBHYDSECu5PnaPAVY4V8kNoKONuGBNWYOuufo61NuuWJFpnGe0TqRlWT
	 F5LlqKLOcIndQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E7FD65523;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
From: Jens Korinth via B4 Relay <devnull+jens.korinth.tuta.io@kernel.org>
Date: Tue, 26 Nov 2024 17:40:58 +0100
Subject: [PATCH v4 2/3] rust: print: Add pr_*_once macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pr_once_macros-v4-2-410b8ca9643e@tuta.io>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
In-Reply-To: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
 Jens Korinth <jens.korinth@tuta.io>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732639280; l=3758;
 i=jens.korinth@tuta.io; s=20241107; h=from:subject:message-id;
 bh=Pi+Tmcbnb+4nLebSMaz3h/2DQwX44dKuBXxl7dtHrxU=;
 b=tLIDXQVk9Ed81M09wh7vjimTiQV9TibbL4r8ubUEsTiDvfMDIR3+zmbvpDBUW5nYApxTwvgx+
 lAp9Y0e1OxID3HD/0ybydDYrzUf4/YxAqsN4Mz9axHo5itbq+777MOG
X-Developer-Key: i=jens.korinth@tuta.io; a=ed25519;
 pk=bG0q4Zyj3o4d/r326zKL7ym+/tXzyykcjh+U0M13iyc=
X-Endpoint-Received: by B4 Relay for jens.korinth@tuta.io/20241107 with
 auth_id=270
X-Original-From: Jens Korinth <jens.korinth@tuta.io>
Reply-To: jens.korinth@tuta.io

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

Add Rust version of pr_[emerg|alert|crit|err|warn|notic|info]_once
functions, which print a message only once.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Jens Korinth <jens.korinth@tuta.io>
---
 rust/kernel/print.rs | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index a28077a7cb301193dcca293befb096b2dd153202..f354b32684a2b3c6c5d9aca6ef9f68e52c870bcf 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -414,3 +414,129 @@ macro_rules! pr_cont (
         $crate::print_macro!($crate::print::format_strings::CONT, true, $($arg)*)
     )
 );
+
+/// Prints an emergency-level message (level 0) only once.
+///
+/// Equivalent to the kernel's [`pr_emerg_once`] macro.
+///
+/// [`pr_emerg_once`]: srctree/include/linux/printk.h
+///
+/// # Examples
+///
+/// ```
+/// kernel::pr_emerg_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_emerg_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_emerg!($($arg)*))
+    )
+);
+
+/// Prints an alert-level message (level 1) only once.
+///
+/// Equivalent to the kernel's [`pr_alert_once`] macro.
+///
+/// [`pr_alert_once`]: srctree/include/linux/printk.h
+///
+/// # Examples
+///
+/// ```
+/// kernel::pr_alert_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_alert_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_alert!($($arg)*))
+    )
+);
+
+/// Prints a critical-level message (level 2) only once.
+///
+/// Equivalent to the kernel's [`pr_crit_once`] macro.
+///
+/// [`pr_crit_once`]: srctree/include/linux/printk.h
+///
+/// # Examples
+///
+/// ```
+/// kernel::pr_crit_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_crit_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_crit!($($arg)*))
+    )
+);
+
+/// Prints an error-level message (level 3) only once.
+///
+/// Equivalent to the kernel's [`pr_err_once`] macro.
+///
+/// # Examples
+///
+/// [`pr_err_once`]: srctree/include/linux/printk.h
+///
+/// ```
+/// kernel::pr_err_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_err_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_err!($($arg)*))
+    )
+);
+
+/// Prints a warning-level message (level 4) only once.
+///
+/// Equivalent to the kernel's [`pr_warn_once`] macro.
+///
+/// [`pr_warn_once`]: srctree/include/linux/printk.h
+///
+/// # Examples
+///
+/// ```
+/// kernel::pr_warn_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_warn_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_warn!($($arg)*))
+    )
+);
+
+/// Prints a notice-level message (level 5) only once.
+///
+/// Equivalent to the kernel's [`pr_notice_once`] macro.
+///
+/// [`pr_notice_once`]: srctree/include/linux/printk.h
+///
+/// # Examples
+///
+/// ```
+/// kernel::pr_notice_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_notice_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_notice!($($arg)*))
+    )
+);
+
+/// Prints an info-level message (level 6) only once.
+///
+/// Equivalent to the kernel's [`pr_info_once`] macro.
+///
+/// [`pr_info_once`]: srctree/include/linux/printk.h
+///
+/// # Examples
+///
+/// ```
+/// kernel::pr_info_once!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_info_once (
+    ($($arg:tt)*) => (
+        $crate::do_once_lite!($crate::pr_info!($($arg)*))
+    )
+);

-- 
2.47.0



