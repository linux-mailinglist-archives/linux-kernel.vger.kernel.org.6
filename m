Return-Path: <linux-kernel+bounces-226594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA79140BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E9C283C35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610238BE5;
	Mon, 24 Jun 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez2qFlUb"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B310A1F;
	Mon, 24 Jun 2024 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198262; cv=none; b=BXsV8ytiE58tWHTXqey3+Umm/Ejk3adBcRVgaPiP1MzMgCxYLL6YgLCUqMF2TC7cvIgG2btOpnotqUWAMUDeiyQXmxlunSzfGjvR1d704PQuC7w/gg2E/MJRsumHFZ0T0R7a01cACMD2DYVvP1X7LrkdU+lalRLEjnuDPaoK1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198262; c=relaxed/simple;
	bh=8946RKbWvVK34fcGypIqdtBOAHqUp7wD4UIPgWaIoR0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AB51txR4J5kjKipD9+BJNQ+vyg+NmBrfGahRZE9EULZG0H5RM2plTk7fNgK0hVgfIj91qFOYjpN9V91YSuiFi4BT5oIx9ZXK22TD/NlyYHIeaXoKzALDMc4anGW76u2PivTztYg1XC3igeQY/8NnmKxT5/315JerxPHLELWePM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez2qFlUb; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eee734a668so173071939f.3;
        Sun, 23 Jun 2024 20:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719198260; x=1719803060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmh5Jdcs1vkUsY1YmWKD/Kf7MsgGAo6MtXt52rq5Ywc=;
        b=ez2qFlUb7ycU334xt81gVuHo3+fxev8yHjo1WPOkr4MmiEEb+gzkjFiFgDzzCC6Y20
         uvisU4XL/eC76VCpjeNXyrJ6o9bjspeAXhFRtziP4FHOGbLbjMuM4sXYdOF7Vl1ALtka
         td+WG71VNi4Sci2F6PQX4wzUEOknajULUclfQ9LaXoXhQXiyt8R5iZMTI+ytBNDIX7Lj
         KOFZokbQAlCvgTxM99x+3ds3iIWzxRmmrmW+Yo8fH5FGH9B5RAn9xFWVF7zwjtpcopx6
         22Vb2Ri5k0CUbBBfXIv6iouC5TlQ79tqLAx3jqFExNCcMgy2w0Sxsq60keu3VmMHLvq1
         HnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719198260; x=1719803060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmh5Jdcs1vkUsY1YmWKD/Kf7MsgGAo6MtXt52rq5Ywc=;
        b=QGDVlDXWNgLbvkhejDiPgNA9qWinEElVoRNaHqt/9G6+iSlYKVV5pJCR/JnZTlEBm+
         40uL0NH1Dne2oAqsexNOmcMZvdAx8siBC10QtniRQk/qeIgkxG6a1uNBVjzbtVyldr4+
         GVDXElyHrUNvyfJxwS1trkfo0PaHiJ6uNdhG9y10wtUcVQVakT8uo2jK0vBtYjFUFyES
         rCurZ0y1dOULg4OiRd5QiLuFs/mA+d06vT7zDJf2zOnjTEu+CQ7VpPpq/Pexp99qKQYs
         eNSaf5DN/1/Ozsl215wDhYyC8uIAfoHOWMCKVTx7uM+ylolKzOYihx53+ZHBTTJ++xsQ
         UB2A==
X-Forwarded-Encrypted: i=1; AJvYcCX48XxlQEs5h5TfemPyPXbLjRfhG20PsFcX5gAdGoycK3yk+AYvqY5ZJZkNIiG1RWdjAQoh9LEd7RDuZJWA89qq71QyiDEM18u8uwa3b9DpshZ28f9gZftiFFCquI8zozR8gksioGi5Oe6Bvm0=
X-Gm-Message-State: AOJu0YyK6klL9rfOvX/FuniJXMDxmc92k6mE7cXH7RFZpQkgdnSgwGpF
	J0V6nIzNMULnCTcNrMVjkMbqbcattcGx5AGthCJ6TXnMhrSvjvpK
X-Google-Smtp-Source: AGHT+IHYWrf1jlsR2+uuv8SI6YO//NX+DmWcKo2Z62Th2e/nH2ROMKMWvT/6SeozZVPiz70Ut12CLQ==
X-Received: by 2002:a05:6602:6c15:b0:7eb:7e53:6e0d with SMTP id ca18e2360f4ac-7f3a1539ddamr492183739f.13.1719198260397;
        Sun, 23 Jun 2024 20:04:20 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9ea0957c0sm1045476173.131.2024.06.23.20.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:04:20 -0700 (PDT)
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
	Trevor Gross <tmgross@umich.edu>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] rust: Enable test for macros::module
Date: Sun, 23 Jun 2024 22:03:04 -0500
Message-ID: <20240624030327.90301-3-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624030327.90301-1-ethan.twardy@gmail.com>
References: <20240624030327.90301-1-ethan.twardy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, this test was ignored due to a missing necessary dependency
on the `kernel` crate.

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

diff --git a/rust/Makefile b/rust/Makefile
index de58f0cae23b..16abb8175494 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -264,6 +264,7 @@ rusttest-prepare: FORCE
 
 quiet_cmd_rustdoc_test_macros = RUSTDOC T $<
       cmd_rustdoc_test_macros = \
+	export RUST_MODFILE=test.rs; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_common_flags) \
 		@$(objtree)/include/generated/rustc_cfg \
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 520eae5fd792..d8bd34c0ba89 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -26,9 +26,13 @@
 ///
 /// # Examples
 ///
-/// ```ignore
+/// ```rust
+/// #[macro_use] extern crate macros;
+/// #[macro_use] extern crate kernel;
 /// use kernel::prelude::*;
 ///
+/// struct MyModule(i32);
+///
 /// module!{
 ///     type: MyModule,
 ///     name: "my_kernel_module",
@@ -37,22 +41,15 @@
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
+///
+/// # fn main() {}
 /// ```
 ///
 /// # Supported argument types
-- 
2.44.2


