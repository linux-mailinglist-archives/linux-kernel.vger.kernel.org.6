Return-Path: <linux-kernel+bounces-226593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC909140BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117DB283C09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944AE56C;
	Mon, 24 Jun 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXERLS7j"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E2D53F;
	Mon, 24 Jun 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198256; cv=none; b=t9U64fubEZwfXqmpASKoMK1kU65h+wr7IARxVsBO663veLHkJ0rGZC3H8yn4SML+eq7gnz8QHQeD0zgNeKv1dI90tYSINuKSXBfroQ42wfh8j6FZa16q1Cq4ZOxxAMsNKXZNIwoyLUdP0IYhygfeHfcGLK4opONOxY/gFNsvkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198256; c=relaxed/simple;
	bh=Xvy39LBf0WnvL0pZD8JpkXNPg41X7rN80n3vjZN/Cgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHTDRmx/8hhy1eOZEF1CLPwuL7USKqSG2arQxOGt5pMqdWltgSg9I2bmJ9LimaM2Qn23EuQD5R6bKUr0GapSLyay3Akn/9kjITO7SFCamUE16toH8T3EgrK3dk/2QXzx+Rufr+0WVBY2XhxeF17tONrqtoAuAi9z/WZyVgfRCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXERLS7j; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ec01b79de6so128255639f.3;
        Sun, 23 Jun 2024 20:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719198254; x=1719803054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtBmzf0zsgTxIoUetvU80XXP5CdtBfX9zBQ+TAGQs8w=;
        b=lXERLS7jRZUKTZXOm+sfpfJ02CCZXQ4yecfwE62aJepnQc5p8he5MCZ21hOZW5htcp
         13GCm8+EwD7gz+GJrzfRgpGe/drxIItw6emDR1yEULOYNOI9Bns7I5P9Tf96RDKC0NJQ
         3/DMYc3IhtUharutBd3iyOe4E0VdCiKTSKNT3mLBXpyTtoJ6OSFkptZu8Fxx1+CMLiK5
         jLQ/7tW5n2KpMvDPHmW4P5lbFxjkTkNQyU0lqXWkw3YH5Qh+2Oxwnmlh1QXYWWZMimFi
         T4qcS61PlHX67n9+aV41syu2C3m3/fZ4+KR/WfRHMSeZ5ZaZ5B3W4tyQ6wcCu+8KqwSt
         iyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719198254; x=1719803054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtBmzf0zsgTxIoUetvU80XXP5CdtBfX9zBQ+TAGQs8w=;
        b=EI3kZr+qsaw3KRv1bcbzRisXRO+yoG3Iezeb0tlaAtDxvRpKcoI5LiykF6KD/rlJfl
         iqwn21e55sf7oR7AoucJRPSUiYOUbZc4wyZc0aVZuwmx4tccqZYRTbztFy6Qf0GbWsxB
         OTPFeevEDjd+lErsfKO4wG1K5yITRv3MHxppiVDpxXO9iR4zM35wOO6crFGQHoFGUTkJ
         f5xAgZpGMLpLv2O8q3W0yVdtgvJWDsPsrqTcbih2RW3cX0L6RbzQ7QMOj6r0xTR0Ivkq
         s2anw7OAKCzlmmkPPBtScsVmHLRUiCtz7vgqpdjjxTSFoZDmzFMGnzUs13T9rgMx5j99
         KI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyTUprt3OCXFfVnAkRYcgHpz/uIz3Nr1iolc1OR27mVCjykiTtFf0YOqIZkwCXL8S6jqjcKudhiK36kak9d9ioMNwTOETPZHjga2v0zRM6LHQjn0SYpnOsjwM4UINL8wafk5c+0+iFdPeDGyg=
X-Gm-Message-State: AOJu0Yw68L9+6ie1f8ICg3xrnlUXS7G+YUoW10ksqaI4ii8kLEXGPhQl
	OOcATcVPItNcse3W8mxHSvl1kSaXKo3KKc4YKmaprUIsLJ8ilMDC
X-Google-Smtp-Source: AGHT+IGDXLOf6i1mgYJKv4jAN1Lq7U4A9khX3fOWtSQcSDWIHzn+wge5jQBC1QAqShH6lgqrONABHw==
X-Received: by 2002:a05:6602:341d:b0:7ec:4c1:14fb with SMTP id ca18e2360f4ac-7f3a7470f43mr409991939f.3.1719198254456;
        Sun, 23 Jun 2024 20:04:14 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9ea0957c0sm1045476173.131.2024.06.23.20.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:04:14 -0700 (PDT)
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
Subject: [PATCH 1/4] kbuild: rust: Expand rusttest target for macros
Date: Sun, 23 Jun 2024 22:03:03 -0500
Message-ID: <20240624030327.90301-2-ethan.twardy@gmail.com>
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

Previously, the rusttest target for the macros crate did not specify
the dependencies necessary to run the rustdoc tests. These test rely on
the kernel crate, so add a specialized rustdoc tests command for this
particular crate.

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

diff --git a/rust/Makefile b/rust/Makefile
index f70d5e244fee..de58f0cae23b 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -147,6 +147,23 @@ rusttestlib-macros: private rustc_test_library_proc = yes
 rusttestlib-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
 	+$(call if_changed,rustc_test_library)
 
+rusttestlib-build_error: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
+	+$(call if_changed,rustc_test_library)
+
+rusttestlib-uapi: $(src)/uapi/lib.rs \
+    $(obj)/compiler_builtins.o \
+    $(obj)/uapi/uapi_generated.rs FORCE
+	+$(call if_changed,rustc_test_library)
+
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
 
@@ -245,11 +262,24 @@ quiet_cmd_rustsysroot = RUSTSYSROOT
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


