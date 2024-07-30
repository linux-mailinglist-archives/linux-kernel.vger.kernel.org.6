Return-Path: <linux-kernel+bounces-267181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BA940DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDEE1C20CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7F2195FE0;
	Tue, 30 Jul 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9trdFsy"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435919580C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332448; cv=none; b=ZUaMQr83iw073B71714TzMQsbelMkJaQ171QR7pUBYzTcWUEfYCXQnPiziZgqhAusDmI+2GBcnhLUt/9vUcR/yiwE7OO8V90wL/hmlZXhYlNO7dhgFdo+wq11sD3YIAGh/6isjIlZGTAhUey+nLsFQHPIHw4KbK7PPus5mDsvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332448; c=relaxed/simple;
	bh=7YHmb9jGZmvIWu1aRF5iNNN4rEzoWDuNyyrN1IKoRpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrAuE9l97jwOkens7bpUEB5BN2M93JWOmHz4qJRXx5gXNTdYxbDdYrmOv33n4ECeFInYZ8Q/fEgkEUer+XCBOHPbJtoltkYEVpyrb9AeQK3K/odZkzOcyOMQoax2B0OUX3gSfKlu9TScX6rSAje5xSSMq7B5vW+/A3GXX+mJFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9trdFsy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035f7b5976so8905448276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722332446; x=1722937246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Td6HujSfnTR7+C9G8g6IKWq+fs5qnV821bV3RrEPE=;
        b=t9trdFsygKyuIWxCOMovOAqUm23secgOmnYTM6tN/OhNNXzTQlVlmA3FbOlWDS/kR8
         c8afFesMcxfsVXFGEgA2HfUwx+igTRwSPwvntWKFVaEOPI/xWcHvnOlmeyBwvPL0dVSS
         glivTR/FNevvp2OxdiUDgoBJM5hl/YCinclX9rC7rn0xvbpp6mZ8IspxXCmJgkaMishK
         TwyFliEriCdQpzegm67zajUePtb3s2kU9yvxri36BBehuPnwaGgN1AE4a7uJs4rfV6oz
         6E1d8AAPtSpGTM0dss24AlB994fILP07Nqc58WtQ4V0e0yJHZgv3mvXyD+aHjzNJlaED
         H8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332446; x=1722937246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8Td6HujSfnTR7+C9G8g6IKWq+fs5qnV821bV3RrEPE=;
        b=izC7FDyMwjnNupqNr7aeGB4pTIK73qxEWt5fsY8QDGEd5PyAFpIZjn39M7Lyl24+0c
         tZVFaEq2G2PZ8Ljmn6Wl/07K9ICdUNVMrvQzp6+CcpOruaIKyKcJ62QM9JDIrB0qtiii
         dHduzs8bNoveBDTD9TV+CMvpDjySdIt5xZj4Q6JVBhk7ONYOuJeQq+Co/vc9GDc/xaZc
         oO1+dR1j0YZ1dbzvjvBvUM/cY9Vudxk83FtFljlm5dWlqagChL5qANgCykKS3LRPOqVv
         ww9rWlk0UkUg55En5JBA/WkVgNk8wZ2QlO/bJxvHZgLfjAz3WPdm1IqT7tyngI7+SFU2
         K61Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4xZuUe0tJNdWXSFdfNMN8D2w1coO25tz1Ao2GtqdpHmfizlmoVl9JMld7lmd5BB6oiGM+vZ/VdwTGVn5fZefgtseO/xT8zRWaxqfM
X-Gm-Message-State: AOJu0Yy7cNTSjKv7uqZwEdqUvXtuIe+4RBhn8A3I9Vv3EjW0huVOFIP0
	pNXnjXbvfgaYVKXPkq9KmUVk+e5uvV7KVZax7WQHTM9srh5aBfxQ8EaFy9oY73ob0rwYgcFVhDk
	4i3kNm4NFUA8lBQ==
X-Google-Smtp-Source: AGHT+IE6jg07sVWkqr6Qt1V4IXfH/ANYM7osvTs52atrqfRQdA5lHoIeNZhgbp6S4L8dsFH6cFO+sMRP/GmNY08=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:4a88:0:b0:e0b:2dfe:d74b with SMTP id
 3f1490d57ef6-e0b9dc506bemr9864276.0.1722332445615; Tue, 30 Jul 2024 02:40:45
 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:40:11 +0000
In-Reply-To: <20240730-kcfi-v1-0-bbb948752a30@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730-kcfi-v1-0-bbb948752a30@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7YHmb9jGZmvIWu1aRF5iNNN4rEzoWDuNyyrN1IKoRpM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmqLUWrBNe4B7klgMLcy4x93JJVPbaiQ4DefqYn
 7+rSpMXge+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqi1FgAKCRAEWL7uWMY5
 RvFZD/9nX0/syePOspS0BC42PIuc8PiXeSLJZ+0oRdk4I4EUiKXF9zoeCP4JNr3TRfITt8pD4va
 cW5U8khsht7ik+YLZLh4I4Y0i2dcAK8qMQsfEqa4j4vp/+CTBvkISRznaiEbjJAyf1dpbNLdc/U
 4KAOlMDO5yhpX2If0MrToDVolt9j3pjnJ2iPKEdrwUGjep7RLiX5HDn66vR1ErhSRBPRUArmC0t
 OasWlqEhkbWodtlGXKRqtbAq4R1baO8Fm/farzfIXT91sSqiImalL1qBb7gweMIru5/jkTeTcbt
 cl7Slkt0an6/FRTTpP5o4QAUly4EEfXe7HMYwsZIlzyzMwBgwF+cTW99LSV+ce2xPXYC9Zmvv7A
 LuxUZtzzLxodVDn+TKet5BL05c4WqtJEG0dv9J0MQYRyVahdN9D0fl5IDtauGKIm71Z7posej4n
 gjQAlXjD2v7KjdxeM0zBzGtmkIqNoJKczMBRySkG9zIl7dBVq6C9tV7B8xlf3EHrIdRbd3A5tOO
 rWpz3JXr9GOQFe0tdsZNocnyOlBjjXSOMtM5IBScISJiXZ1LOfORS04S7hTCoEoSLXe+4Pl2FKp
 mEVXRg4sp5T8pH7uklezW4tI6uUBorPExDxR5Kk/hhUvdDe1H54PsHBjpUQPT9rsbVP1TdWWuO9 2AVbut6tNZWCzOQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240730-kcfi-v1-1-bbb948752a30@google.com>
Subject: [PATCH 1/2] cfi: add CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
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

This option exists for compatibility with Rust, as C and Rust do not
have the same set of integer types. There are cases where C has two
different integer types of the same size and alignment, but Rust only
has one integer type of that size and alignment. When Rust calls into
C functions using such types in their signature, this results in CFI
failures.

This patch introduces a dedicated option for this because it is
undesirable to have CONFIG_RUST affect CC_FLAGS in this way.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 Makefile     |  3 +++
 arch/Kconfig | 11 +++++++++++
 2 files changed, 14 insertions(+)

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
index 975dd22a2dbd..f6ecb15cb8ba 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -826,6 +826,17 @@ config CFI_CLANG
 
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
+	  This option is necessary for using CFI with Rust. If unsure, say N.
+
 config CFI_PERMISSIVE
 	bool "Use CFI in permissive mode"
 	depends on CFI_CLANG

-- 
2.46.0.rc1.232.g9752f9e123-goog


