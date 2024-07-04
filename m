Return-Path: <linux-kernel+bounces-241282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A578E92795B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78771C21707
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075E1B140B;
	Thu,  4 Jul 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBAsuh/Y"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D11B120A;
	Thu,  4 Jul 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105050; cv=none; b=QCOGZoDOzXTUPOHGEVsAWD8lBS1/qYHfLpmTei6ndyCWpQQ+CdzafbW8xUCkymoncEel6tr6ggb7OBjSVWvN6o1au/h9qcXSaJ+MzW2UtFRNX5ul2ktC0ku2BPVpdtPb84xdtObMnsVPWZHe/Mijw357KYpGoKxGjyu2rcmyXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105050; c=relaxed/simple;
	bh=Asb3OsmaU4xur7jTKhpefAUeM3PR7wjkzqbeEqFt1vk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7u0SKgHg65Gfjr3n2ibbXkTkxTyH5DM2CdACUG2f++A++nJKn+DPwCPnJLj3e4GyCgF8qIIMaOlhHIXN6y/updHPCEu8bxRaBNbBsoJzNnRRyTyrD/3jjVQwE0QHXhjhe9EDJjFN39zXEb72+HrPkqGij9VWRUo9gzD3BakuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBAsuh/Y; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so40382539f.0;
        Thu, 04 Jul 2024 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720105048; x=1720709848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS4FeN8/6jzuogXItnqNR+Y++d8T9MSODY7gDNOWrGo=;
        b=WBAsuh/YtWqF5OJUvPklrQnRyL9eDcmQg9eAGSefGLCJFA8SRmnOmDwyMgrBFSwhwe
         YkcAoN6rMvOaCY+VA3onqfTaUZvHLqNcSlXbMFEiPvuCZTOX8DnTpEZ8abBWOsAlrKwk
         K0RfJelbcphtiIhrf6TXtxjdLGeKUYk1ci4Gxp9P8GhvqQ1Ifs6ER7ML+Um5MsAdyduF
         0NUlBWysWT7aQgWemr4iCIJjKe2LNzu7fGNxZKoioUQMWArofUY0Mbz+z7gm+xAfQqpZ
         xRty3+4FOnYuF1jze88+DTDyPBHZoPlT1uxiLZmdYy3fVZsOG0Pl50OioyPi5GsGKmAu
         ITTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105048; x=1720709848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS4FeN8/6jzuogXItnqNR+Y++d8T9MSODY7gDNOWrGo=;
        b=dgRtLnYMNSobq/0YZOhZo8pCK9E20+hfY++54wqcUHcHJ9yDEDL90LZZgI+PdAeg6o
         lxTD13Bkro8u9kQQ3Z5jIK02bCk7ozVYna758cc/HHBk2xqfY5dVZC8/0acvktjiIyR5
         3Z3hdlU0N8FIwvesgmJFzfIYvf+cf6CNCNIZx8FuunMHgA0TTHCTm3RNfZw2BhGDo8JC
         SQB59/C1V0Xut+7XNiNiYlxhoTmpbg9wL3lGyxsTYKBu6Xfb0jQIW7X5lo7dBTboLc9w
         8VyHdoJFXpgi4NBo4+1IiITJijsU3hWDRUb272yv9MgZeSX81wv7/8NE9SjtbUrjJV6K
         4kVA==
X-Forwarded-Encrypted: i=1; AJvYcCUENB8NeaHuIhMAiVmNMYN3LXDwoZG4hgF8VhkKDzVJuHPEZtpXYY6G8QfyAGtiEu4kB0v0eSJLOEW8zZlhGR+xHB6lY1HWKL41vQet3jNym93a2Y7EqlOWXe1ypcjyci0nGOEN0bnDLeuvjFE=
X-Gm-Message-State: AOJu0Yy29FyTJbgIzPvNQnTlFzTofPDoz1hInlL0geajDk53xxcrNb57
	9mPlkeT3QPPQmkoZSA3VqkdYalOxsg2Lf53zvMHjoBp6p33R1xsa
X-Google-Smtp-Source: AGHT+IHmT4M+fJI4PcJf4RElkH9Xa6Im8XFst1pbdkA3tOoDRK2h+O7oGNWrVw2ZDlnqNaZ2H1FcIA==
X-Received: by 2002:a6b:7b4c:0:b0:7f6:522d:2714 with SMTP id ca18e2360f4ac-7f66def0274mr213062839f.16.1720105047999;
        Thu, 04 Jul 2024 07:57:27 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb388asm3940867173.5.2024.07.04.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:57:27 -0700 (PDT)
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	"Ethan D. Twardy" <ethan.twardy@gmail.com>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/4] rust: Enable test for macros::module
Date: Thu,  4 Jul 2024 09:55:43 -0500
Message-ID: <20240704145607.17732-3-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240704145607.17732-1-ethan.twardy@gmail.com>
References: <20240704145607.17732-1-ethan.twardy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, this test was ignored due to a missing necessary dependency
on the `kernel` crate. Enable the test, and update it to remove the use
of a kernel parameter mechanism that was never merged.

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

diff --git a/rust/Makefile b/rust/Makefile
index df389df4db9c..3ace8506ee8d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -256,6 +256,7 @@ rusttest-prepare: FORCE
 
 quiet_cmd_rustdoc_test_macros = RUSTDOC T $<
       cmd_rustdoc_test_macros = \
+	export RUST_MODFILE=test.rs; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_common_flags) \
 		@$(objtree)/include/generated/rustc_cfg \
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 520eae5fd792..1c4ae5789cfa 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -26,9 +26,13 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```rust
+/// # #[macro_use] extern crate macros;
+/// # #[macro_use] extern crate kernel;
 /// use kernel::prelude::*;
 ///
+/// struct MyModule(i32);
+///
 /// module!{
 ///     type: MyModule,
 ///     name: "my_kernel_module",
@@ -37,22 +41,14 @@
 ///     license: "GPL",
 /// }
 ///
-/// struct MyModule;
-///
 /// impl kernel::Module for MyModule {
-///     fn init() -> Result<Self> {
-///         // If the parameter is writeable, then the kparam lock must be
-///         // taken to read the parameter:
-///         {
-///             let lock = THIS_MODULE.kernel_param_lock();
-///             pr_info!("i32 param is:  {}\n", writeable_i32.read(&lock));
-///         }
-///         // If the parameter is read only, it can be read without locking
-///         // the kernel parameters:
-///         pr_info!("i32 param is:  {}\n", my_i32.read());
-///         Ok(Self)
+///     fn init(module: &'static ThisModule) -> Result<Self> {
+///         let foo: i32 = 42;
+///         pr_info!("I contain:  {}\n", foo);
+///         Ok(Self(foo))
 ///     }
 /// }
+/// # fn main() {}
 /// ```
 ///
 /// # Supported argument types
-- 
2.44.2


