Return-Path: <linux-kernel+bounces-241281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1592795A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5A91C214F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D31B11F5;
	Thu,  4 Jul 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Q0lpmc"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981E1A0721;
	Thu,  4 Jul 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105043; cv=none; b=PFpIE9ZTgrSNirCKv9zTbwT0vy26g9rwr6K2+7/XuWv5tt0afzKw08uNUTywJkNIpuXooy3UkGm0y8wH8Y8aaxA1gSvxKOFBSY6LUeO42RkKNDrPGAp6flveE0bRONH1KIospCzL/JYqKxYHQu4qNLaU8WJgWlUxkKngAGMKu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105043; c=relaxed/simple;
	bh=LT1u95/fiPf6qBJThFV+qOYRYj5VyAeLQh9sOwz40tI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9zua8aa7JF4Ef68oHOXa96B5mP/fUSaJgb342q0OGw4VOHSgA9dlJD8kR2As33NjCHFNkjDd+LP8IoQ3csUtnDNzaogx++QioGziL19KQOuo5hUNYVAHCfzFgtglQuC9n2Xs9lFyj3n+cUIleFsLiBRQaSnVMNMVQJWVfwIo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3Q0lpmc; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ebde93bf79so32175939f.1;
        Thu, 04 Jul 2024 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720105040; x=1720709840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxB0HCmHdrPChIVkH+RJRLuJmgHYPb3NqnatSG36g50=;
        b=h3Q0lpmcV6kplaJzTCkWMsevey4Usjl332aXozFY9cIreYzXPaiCBH9c+xBGQWtCHL
         wbJYRMiqv2wQxsAV2mG5kF7NWB3CpuWnUkSvUKyQ6R3M7xRexR3FG4avusnHzbOZOUkH
         Ix2tAgKeevgC0GgvNyrHJ542yzJww7C+h4afMLfJjAGHu1zAsqKBsREF4OWg1YqJ8bj+
         4ZEBT6hX3ezfJ7pb+GCDEh0E30oT1UViK/NdEBbeaxipneJYEhmQHkI1gQH2pjGOZ8+o
         ADM8+KmbzXYk8sO66qy/TqTwIpAdkT9RQFZYObuSLKF0Va37QdRCQtGIXUFJNZPSSyq3
         FRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105040; x=1720709840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxB0HCmHdrPChIVkH+RJRLuJmgHYPb3NqnatSG36g50=;
        b=a7YQrRRG8FBjDKFUfCeAvsmGSxEjvVhTTkvQ8f6UAwIeSguF8d+idr5sJ9zX6APWnn
         k9drIWmbwFc6OtCPLMn/QJzO4Q3fR/1UxHMVBRpiSyNEFeGDvOyrK0D7hn/XWp/q9nRL
         nRFXywdmHkvgMbw3gG8uNiMiUZOHND8pJ5RIz7rXWUedPaDlS3NNwl15+MF3u1GIroOw
         Rb0vsMDDhxxmU16JOT/Fzq+6I0ecZaPcFz2WFnXd35XLszChIgfqW6TkU+VqgUdTeEtj
         K0f5ciQaGxVWs4/EVS9oXyEErJmNni6F9av0Vqgnwd727eDR2BJpxeY1Bx5M/rHrzH9n
         xD/A==
X-Forwarded-Encrypted: i=1; AJvYcCUT5TT5l1JESGJy7b8CrmApHpxDscdK2gNvudcM9jdyEITw96H6riS/tVrlZeuhDf2ClF2q3bmkNZfBSqCpgOLrtnsBevR0pqfKCvcd1u0Bsum+BqtDqSvxJpbOzJOdASA9ERnlOm6ToZMlEus=
X-Gm-Message-State: AOJu0YzVodX6++QlLnIDspVQHmzxVwLvBhVq1zp/wkkrcMEEAoyQCPRt
	DLZqxDUnZ4Xr7q0RyfJuSZuKb5ZxRbNn3YS1z3+ljGHvHyQsXWEy
X-Google-Smtp-Source: AGHT+IGuhFwdMfUuo2moIks7z3toCz9jwt/WRl+4jyA/pzWWMVxhWrHG67fXVypdQuTOugdo3VJd4g==
X-Received: by 2002:a6b:7848:0:b0:7f6:1ea5:de97 with SMTP id ca18e2360f4ac-7f66de9994bmr228523939f.3.1720105040514;
        Thu, 04 Jul 2024 07:57:20 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb388asm3940867173.5.2024.07.04.07.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:57:20 -0700 (PDT)
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
Subject: [PATCH v3 1/4] kbuild: rust: Expand rusttest target for macros
Date: Thu,  4 Jul 2024 09:55:42 -0500
Message-ID: <20240704145607.17732-2-ethan.twardy@gmail.com>
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

Previously, the rusttest target for the macros crate did not specify
the dependencies necessary to run the rustdoc tests. These test rely on
the kernel crate, so add a specialized rustdoc tests command for this
particular crate.

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

diff --git a/rust/Makefile b/rust/Makefile
index f70d5e244fee..df389df4db9c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -147,6 +147,15 @@ rusttestlib-macros: private rustc_test_library_proc = yes
 rusttestlib-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
 	+$(call if_changed,rustc_test_library)
 
+rusttestlib-kernel: private rustc_target_flags = --extern alloc \
+    --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
+    --extern bindings --extern uapi
+rusttestlib-kernel: $(src)/kernel/lib.rs rustdoc-compiler_builtins \
+    rustdoc-alloc rusttestlib-bindings rusttestlib-uapi rusttestlib-build_error \
+    $(obj)/libmacros.so \
+    $(obj)/bindings.o FORCE
+	+$(call if_changed,rustc_test_library)
+
 rusttestlib-bindings: $(src)/bindings/lib.rs rusttest-prepare FORCE
 	+$(call if_changed,rustc_test_library)
 
@@ -245,11 +254,24 @@ quiet_cmd_rustsysroot = RUSTSYSROOT
 rusttest-prepare: FORCE
 	+$(call if_changed,rustsysroot)
 
-rusttest-macros: private rustc_target_flags = --extern proc_macro
+quiet_cmd_rustdoc_test_macros = RUSTDOC T $<
+      cmd_rustdoc_test_macros = \
+	OBJTREE=$(abspath $(objtree)) \
+	$(RUSTDOC) --test $(rust_common_flags) \
+		@$(objtree)/include/generated/rustc_cfg \
+		$(rustc_target_flags) $(rustdoc_test_target_flags) \
+		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
+		-L$(objtree)/$(obj)/test --output $(rustdoc_output) \
+		-Zproc-macro-backtrace \
+		--crate-name $(subst rusttest-,,$@) $<
+
+rusttest-macros: private rustc_target_flags = --extern proc_macro \
+	--extern macros=$(objtree)/$(obj)/libmacros.so --extern kernel
 rusttest-macros: private rustdoc_test_target_flags = --crate-type proc-macro
-rusttest-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
+rusttest-macros: $(src)/macros/lib.rs rusttest-prepare \
+    rusttestlib-macros rusttestlib-kernel FORCE
 	+$(call if_changed,rustc_test)
-	+$(call if_changed,rustdoc_test)
+	+$(call if_changed,rustdoc_test_macros)
 
 rusttest-kernel: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi
-- 
2.44.2


