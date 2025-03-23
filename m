Return-Path: <linux-kernel+bounces-572740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337DA6CDF3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 07:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90084189A377
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D5201002;
	Sun, 23 Mar 2025 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTRi3Ka2"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E72E339B;
	Sun, 23 Mar 2025 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742709680; cv=none; b=DAMkEsyerDD2IjD9rzk1o9RBtaWmSOqKL3MVzyo04CbNz9oXKPjcadRRX806XI/sr6qIcZBtrafRi7yz/H3MDLPKi5DeWuLeDKs2XKqCJcDl2m7Fz8jKUvoM78OhAesCeVDebCbZQOPFkfhxMX5LWH7YaadgBV+3KhzA6rBiBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742709680; c=relaxed/simple;
	bh=z3/5WxPgAhSoDkrOAwoE4Xd+tmuGu+cePxUBNw9hJzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXvJmd1Tje253Bse3xnlHkM3YDqw7FEGpQMxqq3UIrbFF8o2HO03Wt2YogGEP4ekfru9YvkjYgQM+0Nm4IFRCpLdCIkRyJhXmwm6FbTRY3XRJmFdDVfSPWYfB/QVqTc9sKTEmdAQAAv5K6HwmAc64OWcBIJ0LE5oRaQUM320/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTRi3Ka2; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c173211feso344122a34.1;
        Sat, 22 Mar 2025 23:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742709677; x=1743314477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiWN5RFuNIJQaekn208Gr5Okm2UpO1Tc0Q4yhp2iLZ0=;
        b=RTRi3Ka2tR4zZoBBMwr0++rszOq0FOQHMZ2qoiNhUaxy43zvQM2re528HAADQ7g65y
         KrtyWlx72Di7p1FhFY6rwQlikgMogIpkuqkURbLeoldGm0eWoXrgl7C3cwgQXLPEjzYB
         R5vFhXihGgNe9Vfv8ucAEuaEemAgVgOZA6P+WCg4gwUcCWpM9u4wGFrbOaHZ9kuVpvTV
         IFJgjlyCuoU/lM1q1+qke+KOR/Pm3AL9LBSfUB2/fogZ4PzPfqt3x2aihNfKB7OBPibM
         YDaMi8nja9mOKwYocUWUUZAuA1/PnMy6l0EhEolNvUJr7CPcgnyAJ1GSMUu0Ksk5wUiA
         Nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742709677; x=1743314477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiWN5RFuNIJQaekn208Gr5Okm2UpO1Tc0Q4yhp2iLZ0=;
        b=DPB4DyZ5ssYXLXSdHye5Xq10DrnzavylCMExHvQKarw4pf/1V/yTDRlLz+MmLsv212
         xJOxcwGPgdCxdLLIUjf8+/UFLTuh5ELwPkBoxSpseDzOU4X+vbG689EET9EAoTD+JT+g
         tBxTUkZK08nhMKCySbbkOnnftaRE3aHKA5GmeQCQRPpIq2bW7FZZNecg4syOWPkhDbgB
         WiedKKnWbWNNKpsKlHolvfKpbVcGz/OhK9fz5hG/D3iiuTX9XgnRKkEzs7y8A3PFxF13
         9+L0Ex6l3pfBOi1iISkq1meKc4gcaIByO3ctyUqh5NZhZyeC9nO26ApRDA4mWx2bYdmp
         GO7g==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZZtHnviR2DSSC650vGjxV5uFsO6inua8DyqudMi7b6c7T3Lbcr7kE9VxRd+k+HZ1KKeq/efW8lw4u4IxhAE=@vger.kernel.org, AJvYcCW5JfQMy/BGtg2fouWTYeWWsOFjYpQJROP2e01yWFYbvgXh5tqjdGvIrD4YBCAtSJQBPMlyaPjs4Fo6vxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdbVA4JC0OXtHenIAm0UDBiL7ycdlVAdhGxbqPryNYlo4wwTo
	xAKGcrW3VgEhOBDCIKrFUDNv/30wNJxL2gjggDklqIebp8QmbyPO
X-Gm-Gg: ASbGncu8OIBCCaL6W+KNrA+IffRilRrZjiP5TwirdopH8gCwPCi+15576zB3/5d9E8F
	s6IHpzxZN3z+6Xh+4miVl/XDLhMGwyrIQVcLm8ae3o2wtlf4M+nSezTKnpggP4ptcRJFvbSatkq
	AgooSp1BooTwqpKHXnL8qTBAuScaxhBQmbnOMrTVR7/qgIYw479l9kspXAOliRJEtrsuKKMH5Xy
	0lW2xT+JZYUXV/d6FTup9iCKmAT8a4crGC8Ig9/tN1cpFPn8vG1ofPKlF1RRjZ1XeJ+vVu5/IHt
	gc/kKYJAOogwTeiN84KKwvQuI5r6U+ycAO9xvEBvUVdkc2Qk1wJzaXkt6LJ8wNpWT5MN5AjZs1k
	uiifHHTNQd+Z5zXNO
X-Google-Smtp-Source: AGHT+IGB77AbW73BgjEFTlM2+kNiFKfYseF4vUZ3s1T/oza74XuqY/pAgusrpZ8JvTCQS4dPza+dzQ==
X-Received: by 2002:a05:6830:6401:b0:72b:89ca:5120 with SMTP id 46e09a7af769-72c0ae594f2mr7148277a34.8.1742709676588;
        Sat, 22 Mar 2025 23:01:16 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72c0ac7b8aasm1090431a34.62.2025.03.22.23.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 23:01:16 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: ojeda@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	jubalh@iodoru.org
Subject: [PATCH] rust: print: add rustdoc link to std::format
Date: Sun, 23 Mar 2025 00:59:48 -0500
Message-ID: <20250323055948.89865-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a url link to the rust std's format! to the pr_* macro docs.

Additionally replaces refrences to alloc::format[1] with std::format[2]
because they are identical but less likely to cause confusion with the
kernel's alloc crate.

Link: https://doc.rust-lang.org/alloc/macro.format.html [1]
Link: https://doc.rust-lang.org/std/macro.format.html [2]
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/print.rs | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index b19ee490be58..0f0a447bf5aa 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -198,10 +198,11 @@ macro_rules! print_macro (
 /// Equivalent to the kernel's [`pr_emerg`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_emerg`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_emerg
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -222,10 +223,11 @@ macro_rules! pr_emerg (
 /// Equivalent to the kernel's [`pr_alert`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_alert`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_alert
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -246,10 +248,11 @@ macro_rules! pr_alert (
 /// Equivalent to the kernel's [`pr_crit`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_crit`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_crit
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -270,10 +273,11 @@ macro_rules! pr_crit (
 /// Equivalent to the kernel's [`pr_err`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_err`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_err
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -294,10 +298,11 @@ macro_rules! pr_err (
 /// Equivalent to the kernel's [`pr_warn`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_warn`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_warn
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -318,10 +323,11 @@ macro_rules! pr_warn (
 /// Equivalent to the kernel's [`pr_notice`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_notice`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_notice
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -342,10 +348,11 @@ macro_rules! pr_notice (
 /// Equivalent to the kernel's [`pr_info`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_info`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_info
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -368,10 +375,11 @@ macro_rules! pr_info (
 /// yet.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_debug`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_debug
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -395,11 +403,12 @@ macro_rules! pr_debug (
 /// Equivalent to the kernel's [`pr_cont`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
-/// `alloc::format!` for information about the formatting syntax.
+/// [`std::format!`] for information about the formatting syntax.
 ///
 /// [`pr_info!`]: crate::pr_info!
 /// [`pr_cont`]: https://docs.kernel.org/core-api/printk-basics.html#c.pr_cont
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
-- 
2.49.0


