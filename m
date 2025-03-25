Return-Path: <linux-kernel+bounces-575441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1BA702E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8561D880B55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1F25A2DD;
	Tue, 25 Mar 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mna8tJEN"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6E25A2C7;
	Tue, 25 Mar 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909684; cv=none; b=YfyQ82eJOl8CP8Qp7zAah1PVfUceyC/Qu4vuCHcazrI9wOFVxJlKcv3QNTrX9GYpWEKoYs+UqdYo7m8WysBB07i0lEckUa5AoTaPhefpEN7362mjy4idgUdyKz0TxdX+hxsIjN/UzdRUesNXFrMPWFAegCQ1S+XWvsbT69mSXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909684; c=relaxed/simple;
	bh=VsBADUsApZ2KApYoNHx21UZbUH6TXtjgJRtQeoyrx3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8iSgkOrLMAcLNmn+VtWoPsbpcf7Fy/eaCLouhwA9sMos6Qg3C/BzlLyWh/OYnixqmV75rGrxp1hTeBVp1SbW0gmc7wbTF5Ux/y6FuDaLACmtmlBqgVpwF58MSFBZYIRMSEiRF1fRajb/mfg835hzHGdoc6wy3O0KtnHewHlkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mna8tJEN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso3026558fac.0;
        Tue, 25 Mar 2025 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742909681; x=1743514481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibfTEBaGoj6OxYYiBqziE5v81+mYjOWPi3IfiSv7Z2M=;
        b=Mna8tJENe23bu10NehqZZcos+2QWZc9CVsfAgdnqBYbCi7Rqr3KKPi6O14rrJ92aWH
         pesvJOYLls8coAcGzb4UkE/CpoOI/R8Fc4NIL38hvzlX+w9IBZsOdielnNHTvlr2st+d
         iAUapLbmkgtz48iPSsFCFsLIyCU+o01G3Ik7cVsTGIPW4R29MOfNqyUlJ/dCu3NUSbs7
         y96JMbn15pJVrM0a/1ashsPcSrdMKWZ4zPvXe0y1sJsNZw/5ST196ECM9PNdN8PXvlzy
         86KBHTYXlln5t9dLvyRXGZ2AjSHHKRC1Yh19D3xpjM8DgZ1plpjBi7roEY3xiSIr65pO
         Fc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909681; x=1743514481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibfTEBaGoj6OxYYiBqziE5v81+mYjOWPi3IfiSv7Z2M=;
        b=dZpqahjWvPd/q01AtvnnzHEDd7P9lkcZChwZFy+SgbcXbCJEEacYFfwj1b/Vx/cqZJ
         94UfvIsPj31Y+LW/XRuH/OFyKHrkP+e/9OPjqpiiiUO2LizqUp41UPoCjABpUjBnXcL9
         JOK7zNiPVJCSeSH1uECcos6miBo2XP27otYnndxXQLcLZTrZwGS06Y6ec6TJWzBRRD5p
         dLNlsyeE/YSQJeSOtb3q8okD+iBsOQ74jlOhIVg32eBGA5yDZAwP/CGXFkYYOdENBlfD
         FgWYPcupNnou3moWcz5QSeV2JuGOr+/y6WldXWcu/3t/zxWEQly9g8D3rQfBbFdvpD5+
         bzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6gqjZCNCAnWjj+46jZQSpbYC4sZNoFSy1oOLOoRw8jOkOuzIKS8scLUHF4+WQ1N6Prp15q4qO1x7XQJ0ZuXk=@vger.kernel.org, AJvYcCWiJgJ1UwvIJtcKtZ6co+7tZs2WS2kwzJiIker27O9iHzSwZqcQyc5QbkvJQBECa/AeKhgrUndEyufFOsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybgrSyt2xRS9yLYzm181UYRYFeTCQoZH8oDqE+j5F2on5lgiKN
	5gG/4vynZCla9luRoNyTXcZUpC3P8QNigANhL8fzh1974CtGDBFG
X-Gm-Gg: ASbGncv6cdA4H7pkG4oTZ1bNoL/tBmpIPoDSpVd9ZQihHyF+Gzah4FIVOTGui89fiRB
	305cq81kewrsr/u5kmAZbneryDihCDrfN+hCtJFAoaRRBAIdWphr0No8Iw2RKNUmqex3x8GVs72
	mEtRVOhgxdUEX/8C2zQ8jwITYkG+DfZIEce/SJL9ErQojb9BIi59jz1VUxvIdekr0vXXDvTEMTA
	OVqOhsNl9KcRSkQQDDefvYRhpTZC8DwKAR/Z+DSgOs6tm6JfFj0W+36iXNvtulcmEgO+d+f0cCu
	76DQy2rBz1zfb1yM31RZ8gin4jQ20xZHMayXA2vxsKUwb6omc7+SGDMjAK1OkpK8J8opU2+Y91h
	x25MwVAEhNVIGhryk
X-Google-Smtp-Source: AGHT+IG74qaD7Mo8N1k2Ob/uOcrqx0C3Tw/8nG8Beyk01bpvrEAWjVDFPq1eEPSVvRpxdz3nx/8QTA==
X-Received: by 2002:a05:6871:68a:b0:29e:69a9:8311 with SMTP id 586e51a60fabf-2c78051a58dmr11361643fac.36.1742909680978;
        Tue, 25 Mar 2025 06:34:40 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72c0ac6c76esm1895354a34.49.2025.03.25.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:34:40 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
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
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	jubalh@iodoru.org
Subject: [PATCH v2] rust: docs: replace rustdoc refrences to alloc::format
Date: Tue, 25 Mar 2025 08:33:52 -0500
Message-ID: <20250325133352.441425-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replaces alloc::format[1] in the pr_* and dev_* macros' doc comments
with std::format[2] because they are identical but less likely to get
confused with the kernel's alloc crate. and adds a url link
for the std::format! macro

Link: https://doc.rust-lang.org/alloc/macro.format.html [1]
Link: https://doc.rust-lang.org/std/macro.format.html [2]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---

changes since v1:
 - rewrote commit message
 - added rust/kernel/device.rs to this patch (thanks Benno)
 - link to v1: https://lore.kernel.org/rust-for-linux/20250323055948.89865-1-andrewjballance@gmail.com/

 rust/kernel/device.rs | 24 ++++++++++++++++--------
 rust/kernel/print.rs  | 27 ++++++++++++++++++---------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..3717f4cc10df 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -226,9 +226,10 @@ macro_rules! dev_printk {
 /// Equivalent to the kernel's `dev_emerg` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -251,9 +252,10 @@ macro_rules! dev_emerg {
 /// Equivalent to the kernel's `dev_alert` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -276,9 +278,10 @@ macro_rules! dev_alert {
 /// Equivalent to the kernel's `dev_crit` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -301,9 +304,10 @@ macro_rules! dev_crit {
 /// Equivalent to the kernel's `dev_err` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -326,9 +330,10 @@ macro_rules! dev_err {
 /// Equivalent to the kernel's `dev_warn` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -351,9 +356,10 @@ macro_rules! dev_warn {
 /// Equivalent to the kernel's `dev_notice` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -376,9 +382,10 @@ macro_rules! dev_notice {
 /// Equivalent to the kernel's `dev_info` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
@@ -401,9 +408,10 @@ macro_rules! dev_info {
 /// Equivalent to the kernel's `dev_dbg` macro, except that it doesn't support dynamic debug yet.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
-/// [`core::fmt`] and `alloc::format!`.
+/// [`core::fmt`] and [`std::format!`].
 ///
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+/// [`std::format!`]: https://doc.rust-lang.org/std/macro.format.html
 ///
 /// # Examples
 ///
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


