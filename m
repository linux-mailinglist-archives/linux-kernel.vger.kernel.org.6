Return-Path: <linux-kernel+bounces-271365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063F944D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25681F2195E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB451A486A;
	Thu,  1 Aug 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xd4KyOPw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826A19E822
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519348; cv=none; b=RVI6s7DiUGFZmomKyIZpy0KHinX0k1aKFcxIAF1bfrpzK/7tALA5z/6AllP4tfn5m+qtkAagWO5saLL7MJiHtmp01CLIttBWr58HgCs6ddSByqMSPoKLF2CQ3mbpcskYA3WuHjHGkbfHxmn9BKx2S2V7kRR3SCawZpHQFvbehMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519348; c=relaxed/simple;
	bh=9KJRJCmOWuRfdbZrnq/poLUu8bU4GlJiW3tPxynPLbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnSdHyMsKmR5IjuxKUI78du0IcNDq8dYlZYzKBRS4RPa8P7UDro6SRu9ksnuffz0RgMDGEvI2yls1b5SpQl+uuIy5jSkn5x/A/6geSv8bg2QUSaZFAGca1pHOUZcQ2V1rJBDXyXMH5vpOXh24yTq8Z/R3hMFwp7Zs7NzmVIGCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xd4KyOPw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so9613305276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722519344; x=1723124144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUq/S4/wDF6le5lpRBRt1bMVOTfqzg9tYxeqkmN+oyE=;
        b=xd4KyOPwWqlstBNPiQdTTq5+fnpzpn7AQU9F2lGfs3YoJe1B/7uL6eWSGrUIB3e0Yg
         PNDOkPu444HZKjxeUKyMKj9tVXqCJzN3PSZU23TiLXpKUqPHBYoWJYG10Xpv3p4TRY5D
         h+vW54IH+MODV7whzVYl9laKpvmVMmfiyRqJubNZ6qCjzjCOncwQdCneIJpt9MqdUA72
         /S8hYktlJ8f3IQ88xui4JGMr8MUxn+coYjwbQUlTDgduF7PEZITHUVxtJ44Dbv87uwkl
         Izs2jRxH8qo1aZ9XsM9fNpuongk4rMjj72SIYYK9A6jogb077HdBZ+0TLgT/jKERID8V
         DPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519344; x=1723124144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUq/S4/wDF6le5lpRBRt1bMVOTfqzg9tYxeqkmN+oyE=;
        b=l6eO2rXAhZYLH4qQJlakUhBePXfVkHAuvlmvrUCsmaCY2lnMyGzA35ZwNlPtoSYdDI
         r9NyaQKLkrdS70v0wQrAT/OArstME0Pv6fUBjbB+0XAXO5KonHeh2KPScghiAjy9B3GZ
         XUjBcTFHn6zWLdRPwfchUndx4jN1SuswsOK3GkMVVSonmKWukcEV4C86rc8LWu+CvkrO
         QHjCYlTRJY1UVQ0e4/LdASnyW8+G2n0wNrViIEgrinOvVuV7X0TzJRXcpHG+WujPBQ54
         5BmUeqgJMHK5NDTOV2zDbkLmG0KdKCPOyVYE8R250N7EvgxEEnaNsdnd3zEf2LB67EeR
         a1IA==
X-Forwarded-Encrypted: i=1; AJvYcCXqKlL6XIiGorzLdxYcrRwLUU/6xblOM0nz6qQBMnUPIJkmbN9JnkipAzC8Dh9bBfbLNtNs9JgKttTL4TxMX+DzQPXgXkWcXxsO5iku
X-Gm-Message-State: AOJu0YzEYBVTe+QTzd34td0xlikTdjCHAqgTyP4mwI+xk5Kj49ZHZNxE
	dGmLUJHVoczq1hzU+gQt83Ak4p2mAOp7QUGASyRDSndyY39CmAYCRL12gYQmbsK0x+65XCtfjcS
	QryMWPtOA+ms4Qw==
X-Google-Smtp-Source: AGHT+IGOulhKqtomG6+nQDZBOeOqQJ5BWk8oYgiic6zU4MGXtAG1WleW6kXftv8Uix8Iszrj2ormqe1kpJCpJ1k=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1004:b0:e05:9a19:cc3c with SMTP
 id 3f1490d57ef6-e0bde421448mr135276.9.1722519344272; Thu, 01 Aug 2024
 06:35:44 -0700 (PDT)
Date: Thu, 01 Aug 2024 13:35:17 +0000
In-Reply-To: <20240801-kcfi-v2-0-c93caed3d121@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801-kcfi-v2-0-c93caed3d121@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=9KJRJCmOWuRfdbZrnq/poLUu8bU4GlJiW3tPxynPLbU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmq48qREXq217LC2vxsyrziCCz5TQrh0XV2LkeY
 eYY5oHdVA+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZquPKgAKCRAEWL7uWMY5
 RvD/D/9hquQktFOsmVioJ1b7Ke3cyQFPFf5cGRdBYu31HVKKRForWtjcnVYHkhzkB/ho3FjnMMb
 RdBOYJsnOmbn8v4zRhLmsGt4cgXm6MUe4pPjALZIZrCBpqzsjTYp9zVd4GuMY690kIMvVMkPoLx
 FRJDJ4aAiSfoPKoSJSTXoN7VV+XA+39BT0izA9Butfb6xECntAINrmprDjfY5kHlP4aKJlGuvcR
 xJ5oMQEFpKGigqxOZfTjsEsygRaGGedn7/ExhieLbROaicbcuNTjgatiYKUTO4hUHduP0Iaax6J
 uX5aAtqCRvLBZmf8drE9wgpSRhOtPh8VwU3gb2YsfOFqTAhV9QCGwyJE7tI6BRrqwtIndR9lFgQ
 UG0/UNbpRNT9s3GRz7T9mqeA6eToxyclJNYTcD8x0jGFlKM+zOznZvsbBlBf9ZIN/g5d2TY/7mo
 ziWrT6B02wlHHyzrR9mYsNzNxUmD7VfduQkGFFEAo7GDpiZV+tKuUnLONtadxUVp+dGC6WpENjg
 k9YOAU7N8/8Hq9Vu6auu1ITmynKF3npWUSHss8mW5A6BvaXvHebjUU9+bp+0S8UevQtc4z3w/Is
 r7bhivw/fLMkBoJ6yxcx2xrdyzuACldRc7ddweQCDOlpoWCYw2dGp17Vdkn9Bs882WWyZlW+Q1v gOoqQiRPifA0NaA==
X-Mailer: b4 0.13.0
Message-ID: <20240801-kcfi-v2-1-c93caed3d121@google.com>
Subject: [PATCH v2 1/2] cfi: add CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
From: Alice Ryhl <aliceryhl@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Maurer <mmaurer@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Introduce a Kconfig option for enabling the experimental option to
normalize integer types. This ensures that integer types of the same
size and signedness are considered compatible by the Control Flow
Integrity sanitizer.

The security impact of this flag is minimal. When Sami Tolvanen looked
into it, he found that integer normalization reduced the number of
unique type hashes in the kernel by ~1%, which is acceptable.

This option exists for compatibility with Rust, as C and Rust do not
have the same set of integer types. There are cases where C has two
different integer types of the same size and signedness, but Rust only
has one integer type of that size and signedness. When Rust calls into
C functions using such types in their signature, this results in CFI
failures. One example is 'unsigned long long' and 'unsigned long' which
are both 64-bit on LP64 targets, so on those targets this flag will give
both types the same CFI tag.

This flag changes the ABI heavily. It is not applied automatically when
CONFIG_RUST is turned on to make sure that the CONFIG_RUST option does
not change the ABI of C code. For example, some build may need to make
other changes atomically with toggling this flag. Having it be a
separate option makes it possible to first turn on normalized integer
tags, and then later turn on CONFIG_RUST.

Similarly, when turning on CONFIG_RUST in a build, you may need a few
attempts where the RUST=y commit gets reverted a few times. It is
inconvenient if reverting RUST=y also requires reverting the changes you
made to support normalized integer tags.

To avoid having this flag impact builds that don't care about this, the
next patch in this series will make CONFIG_RUST turn on this option
using `select` rather than `depends on`.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 Makefile     |  3 +++
 arch/Kconfig | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 2b5f9f098b6f..484c6900337e 100644
--- a/Makefile
+++ b/Makefile
@@ -952,6 +952,9 @@ endif
 
 ifdef CONFIG_CFI_CLANG
 CC_FLAGS_CFI	:= -fsanitize=kcfi
+ifdef CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
+	CC_FLAGS_CFI	+= -fsanitize-cfi-icall-experimental-normalize-integers
+endif
 KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..ee58df8b1080 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -826,6 +826,22 @@ config CFI_CLANG
 
 	    https://clang.llvm.org/docs/ControlFlowIntegrity.html
 
+config CFI_ICALL_NORMALIZE_INTEGERS
+	bool "Normalize CFI tags for integers"
+	depends on CFI_CLANG
+	depends on $(cc-option,-fsanitize=kcfi -fsanitize-cfi-icall-experimental-normalize-integers)
+	help
+	  This option normalizes the CFI tags for integer types so that all
+	  integer types of the same size and signedness receive the same CFI
+	  tag.
+
+	  The option is separate from CONFIG_RUST because it affects the ABI.
+	  When working with build systems that care about the ABI, it is
+	  convenient to be able to turn on this flag first, before Rust is
+	  turned on.
+
+	  This option is necessary for using CFI with Rust. If unsure, say N.
+
 config CFI_PERMISSIVE
 	bool "Use CFI in permissive mode"
 	depends on CFI_CLANG

-- 
2.46.0.rc1.232.g9752f9e123-goog


