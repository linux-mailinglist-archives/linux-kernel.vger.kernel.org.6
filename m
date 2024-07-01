Return-Path: <linux-kernel+bounces-236133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDC91DDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB681C2258F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CEF14A098;
	Mon,  1 Jul 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwLScmdo"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFA13D53D;
	Mon,  1 Jul 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833269; cv=none; b=XvNroPI30Pmhs7u14aeaNBoUbj6b5HkmUKZEqWMv4xPTmfZebq8POdFBWFBrpLzygP2blMnS23XJvYO60zPsOyEuKhbP/d68VO1Y2PbuepGhYBNBx1tvfOx7ZGE6tIJ+DvYBAxpYVp4sM5J6nGvi5eafJVInQtBOXMZth0IwgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833269; c=relaxed/simple;
	bh=Asb3OsmaU4xur7jTKhpefAUeM3PR7wjkzqbeEqFt1vk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNOxdtRMaO+bNDe7LPPJlT/V6SoFIE4TK6Ipi47s7WRANu14jmUc/uM/oRZupOWPjCWyhA/Oe0fcWhWs6bho4UIg4OevMvcc8BlYBOlUjNDtXno0/u2w2vsxjtP70DDf1vm0P173Nwu+aCeh8dsq5s4mjmjnAkL/Xr8ewv+IHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwLScmdo; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f6309e9f29so74457339f.0;
        Mon, 01 Jul 2024 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719833267; x=1720438067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS4FeN8/6jzuogXItnqNR+Y++d8T9MSODY7gDNOWrGo=;
        b=fwLScmdo60n7BlURhu1Gcjf4eB/cszJE1pAMlwtQhbTnivIl2vB6m4G2Y77rX3PEiv
         FK4E9s89ksWLg+EuAHD7UmCwiBkdXxgVuKCwjNo24UO2MNx32hcaRVQ3JQDY+oKcuD+x
         tu2YXnKQ31/ALzltyQjKC13J+VGh1VTKPqPXe2T7S9rz68RgzbRfLp/26xSui3cfv55u
         ASJiJ+d7ATWEc9nCZQYUq9HjWHmo6b0RDba+XBVVsnyyY1uWpbN/15bSufPO5RbWrCF7
         G0cV4iGN8Lpex2sWSYK/7Sm9Pil+V8iVTFzPSXbD7uN7nBbB6GywlXer1MThhtojFQ+m
         eVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833267; x=1720438067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS4FeN8/6jzuogXItnqNR+Y++d8T9MSODY7gDNOWrGo=;
        b=aKaSU5crf8/MFxZDZfqcbloZFi2FiAJZSxVl353es3p6Xgi6BBdoD9i1I6MPQpAF5V
         6V9zAy9weS/ZdDXQnOprQk222Zop96jB+sWsWU1YZ6KzOHriHHsXsfcODc+rfzTmJgpG
         JC8JT14SXAS8HJGcIHA+tYR1eobChffIEt1la0Tm76iJEfVi7kqYzWFTMaMBXMQ+c1ag
         bockupgxUSV8jRFSgxrHWPP3kfiBOg77VkFWh8dhzfPIFB70HadNa6mKRgSuR90nM3oT
         tHakI/LLjZkN7lpbFNkcUFHWE7oVHvTaQH/jeQKMM5DQKybp5YxwC7W3hp7XldRXPW5I
         GxXw==
X-Forwarded-Encrypted: i=1; AJvYcCV//tCW0lkFCpNtnZ8wngIVcnZbP6yPiv+K7LkCvMGUSqA3ySNrbyhxuymPyHl7RiARgJZrmE6K5UzsIlP9+CnOqmTxBnIvJvgqrOb5wpFBM1/HS9swm20kCyeKvmVlXD8C0ldcofuoFFg9r3E=
X-Gm-Message-State: AOJu0Yw3r9h9fwOOkSDefXFkGpHwyux0NLLAAuNUL95JV7+x13UjnC/4
	07N0jR/D568+dB7AiYri5Tcwm9uj0Os0vGHi7cIx0zZo/YModilR
X-Google-Smtp-Source: AGHT+IFvMSPdkH3YP8tnEr6DjA9x9FnhaZFl8FpJiy3WJLuU1UvfgVNh/zVHTlAiG/bj5DYZAa2A+w==
X-Received: by 2002:a6b:d00a:0:b0:7f6:1bb4:1557 with SMTP id ca18e2360f4ac-7f62ee1b6cdmr588323939f.12.1719833267213;
        Mon, 01 Jul 2024 04:27:47 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e062e3sm2087317173.75.2024.07.01.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:27:46 -0700 (PDT)
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
Subject: [PATCH v2 2/4] rust: Enable test for macros::module
Date: Mon,  1 Jul 2024 06:24:24 -0500
Message-ID: <20240701112448.28638-3-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240701112448.28638-1-ethan.twardy@gmail.com>
References: <20240701112448.28638-1-ethan.twardy@gmail.com>
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


