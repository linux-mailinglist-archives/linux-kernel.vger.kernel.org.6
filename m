Return-Path: <linux-kernel+bounces-236132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5D91DDD3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BD31C22568
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B801422CE;
	Mon,  1 Jul 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKfqPF7f"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672D13D53D;
	Mon,  1 Jul 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833262; cv=none; b=GMZhtGMqJOGp4RbeKayNfFwQRJGikSZ5RfxXIFSot46f6MmcwNzKMZDg6r509KicwzRU2DVTFzgIOqaA5EK2LiOtXw6/6hKMKqyBkTHuTh8JLypMN2zBkwacm4+ER2TQbXWVidwQAMfDlditq0TIRxSNa4W3B8VIyu9xekCXLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833262; c=relaxed/simple;
	bh=LT1u95/fiPf6qBJThFV+qOYRYj5VyAeLQh9sOwz40tI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riruZLvBVI7G/6tG2od4u1CGjGvmPL1h0whbhhzyLPJaQ9I7ZLlGwrS5nD8ST6WCZZJ9XENRifNq4c0iNOzf9SQZyeyhzr4/SOQVzSNfPpab47fnUhtvv+TLNIRfxr8B7mJ8uVD48mfOxeP2s9bpjgYIbjiH/OIe7qS9m2YTtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKfqPF7f; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f61549406eso109405439f.1;
        Mon, 01 Jul 2024 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719833260; x=1720438060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxB0HCmHdrPChIVkH+RJRLuJmgHYPb3NqnatSG36g50=;
        b=FKfqPF7f81kKt7bVt547+1Wzc8USvGDAvClsIA92Z35zx4POzI+iRhw26noN9w8asr
         2+LFjV5ybeesk8+OxV5zFxrkONWBg+JW8Z8UiGaHEkcypYIer7ATPRSmRJKGiivCM/9w
         1IqXaTOIv5IrUzXvFiGb6dLnhounMK9KU8tGrqoMJGDrrARDeZxi3GPzJNRoTGN6uu0R
         38EIj3sULvosNXCkcHprKl8tgCZBM6ukq7tupvX+h3yt3SmfwaDE9zxW9RAmI2SgqVTz
         LlUS9Jy5hBKSg0NZpZliF1NgQRn/cbfvoPU2BfcpwbfdTOejU14gWGrJeGfcEWMGUbC9
         dGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833260; x=1720438060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxB0HCmHdrPChIVkH+RJRLuJmgHYPb3NqnatSG36g50=;
        b=kR9XlYo0F2wWmCmvAZFMBpVZhjQoKmF5D263BWKgoPavgW9DUsiEM72TQl21+yge0w
         B5fyYNjJM9H8JPHIxybWVERDst0UZkmQqbE2O1B3hzWHWRC9/LmmkvBZZjEGGeF8KOl3
         EnzhHdtgE4kbV+wKyBKNvtPRO4+gRfGD7zAcBCCxkgHxK9VdjU6XEfsh5uZ44c/r1HA2
         8d2Vn6W5njJyY3/4pfkbuD9wsMHAaHCCIf4HGMko1F+XUyB8y2CRi+hIls+BG7M5pVXY
         b1AhM6kM3MY1b/swf3wrJEQAo8lTwkl0e6hHxs2IdcAIjxH8FTv2ru6HYw51v6ZzJMD4
         XRog==
X-Forwarded-Encrypted: i=1; AJvYcCXKYFESI8J9H4QI+ztity+7jW32Liq8nwBYVq5pNqvasIdtToPQlsjhduDbHMLayN3LSHZ2SwNpX1hmHS9LFH+2iDiHyUuKIwZIOferDXJrGvPKwyYVRQ+Q0rOfX17X96tWGBsVTwkVa3cV1r4=
X-Gm-Message-State: AOJu0YyZE1t9LtRJvjpu9aNU8QyGjMiTKcVEB5KYdA5Ovs4lUcasMNOe
	eb39W/WQ5ePPfyKy2cBXj7P7+kyi01yihieLntwT9QLtw7nmATBc
X-Google-Smtp-Source: AGHT+IENE80DsqSoWfhvfS7EdqsxdmAyKL5cAx1Z9TfyvmmK3kbFMkQnkBJgXBt1aB31WVOPqgz/Ag==
X-Received: by 2002:a6b:5a0e:0:b0:7f6:210c:61b0 with SMTP id ca18e2360f4ac-7f62ee853a4mr584018439f.20.1719833260094;
        Mon, 01 Jul 2024 04:27:40 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e062e3sm2087317173.75.2024.07.01.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:27:39 -0700 (PDT)
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
Subject: [PATCH v2 1/4] kbuild: rust: Expand rusttest target for macros
Date: Mon,  1 Jul 2024 06:24:23 -0500
Message-ID: <20240701112448.28638-2-ethan.twardy@gmail.com>
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


