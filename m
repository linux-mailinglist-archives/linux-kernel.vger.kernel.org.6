Return-Path: <linux-kernel+bounces-567069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E81A680A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ED8189DF08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6619E207A2C;
	Tue, 18 Mar 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVinB+Tv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C21DED62
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339902; cv=none; b=ZakJStGYqNkhMrnYxmAmm29AINUgGvzG7xdaob5euB2fvnrrXxbZBHsjUyYMTxzOy1uPuqpDA5cb1akPntNGLHo9boMCPb5FclxpvWQbMKKIustNaXGth89fEjOEhrJdvfpbgw1VX0YRGQ2ySa0OfrzN5CtlnRsxth6xv8L5eYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339902; c=relaxed/simple;
	bh=iVy3KaQcdoKMOIhykUTdZW6xpEXbbIbDjNSvxjr5gOU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kp+hZvhyftVB05egM8kLalJ/jfPupQa4Ye8ssPqbNw4o/Hmv9yMY59w1Rz9fRB1BtGmRVuFgFk6OsDTanBnmoh6RETXAw/GihLyqzBHy3Bd+SicWeJimO9+2jBVtQ8DrAjrLjQrPmTS5aOkTVyI3COWgEV69Y6VEuVmFkhkxEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVinB+Tv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so5984632a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742339900; x=1742944700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KXJJNZ/SsGbxD4tKsw6RwQJvmwsliXsJWoESYYVXQr8=;
        b=wVinB+TvpuHfZK9BmZ29WF0DjUBBBaJwZSNBcYIqA5PfZpfpnsQcF4tahuSIgXxyiy
         uuPvrDoAbUcbpxeO/7gV90wrId/Ac94pVUNbJFXHXB6att1gDs/FB7EqUyd06ufQipRF
         INA+LhPMheT8Ao5ULIfk4o852/wKhyjBIHzzzGoKh7shBH2DvoOiMEZea80CVDK1V6zV
         t8w0D54AVLDA37ZFmLUOWe2DGxB+URu8sA7eIV4ewJiSDkTWRcO4VEXskqWmZCIKXpqp
         NJTK2N7+X4JkFMhean62WcBWpo+/fQvCbJFvkdudlfZW3QGkUtUWV1eaavSWAHff5biZ
         FGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339900; x=1742944700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXJJNZ/SsGbxD4tKsw6RwQJvmwsliXsJWoESYYVXQr8=;
        b=oljk6iVCNtU6KnY7zjMkE3mDHrhBnaD1gilk+Q5tIVDQSCus9WtKEkqkNiwbuWHTxE
         Qdexja1iyc7DqX4kWYad///Z/saTqclLyao2ltdII0c3penOALj5QAn6Vhbtpb6ULG/7
         3YbzbKAxaCsN3Em7lghYQBr99wNPnK1S0gyzPHOtDHiyRxePcIey6NP6XTqy6YpwxFPU
         mEh2zf7Gq7z7TlbR5UmbfjysYJdOS0z97wdjGQZG6kqLw6PRIk8qB2qydSZwpX9w3jCI
         +XAhrRK8NM1aKFkNihvlGnHz/rac7INi3rrvFFW1pEpwCIqShZW29lHo0pC8Wmd0PTUt
         qeew==
X-Forwarded-Encrypted: i=1; AJvYcCWQIYy0ez2ZXHxbZ8ZVZZ3fwByW/iXr5ZBTxKXjqchx75MVm14PZczKME08JH+aVnUIn/J+pjlRQe6QTrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QjNn9NjT1+SOmDiSCSTMDafBWkp1ncPJKgli2qEMaBeezx9g
	m88cnkXF8sXjVG1545Q/E0ZZ5FTJuvEqrCA5Mk1sAvXglcqaWCxrmrfcpg7POwdMKuHsrxQaBNH
	OqooV171Awpc+qibuOLompvox5Q==
X-Google-Smtp-Source: AGHT+IFBdlwQchK4+FK9YV7gJ97fUHlHu1RufvH6zywOClvEOKpciZvdnSuk6HsOdKB4D9HM0v6Nw4swv1isqNS7COE=
X-Received: from pgbdn2.prod.google.com ([2002:a05:6a02:e02:b0:af5:5afe:79f9])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a6:b0:1f5:8de8:3b1a with SMTP id adf61e73a8af0-1fbeb7a2072mr822186637.13.1742339899651;
 Tue, 18 Mar 2025 16:18:19 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:18:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=samitolvanen@google.com;
 h=from:subject; bh=iVy3KaQcdoKMOIhykUTdZW6xpEXbbIbDjNSvxjr5gOU=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOk3/1t0fswvNypfEroj6v3n5Ie/uEosTm8xKnE6erHuy
 wflomNTOkpZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBENoozMly47aW7YekU8y1b
 ruUZ3j542PZ5ZuZM5Wwbu4bDMwTFHacz/A8q4pLzePX56F3+B+8unA6/HDaz07i32PDDb7FK9oS sGl4A
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318231815.917621-2-samitolvanen@google.com>
Subject: [PATCH] rust: kbuild: Don't export __pfx symbols
From: Sami Tolvanen <samitolvanen@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With CONFIG_PREFIX_SYMBOLS, objtool adds __pfx prefix symbols
to claim the compiler emitted call padding bytes. When
CONFIG_X86_KERNEL_IBT is not selected, the symbols are added to
individual object files and for Rust objects, they end up being
exported, resulting in warnings with CONFIG_GENDWARFKSYMS as the
symbols have no debugging information:

warning: gendwarfksyms: symbol_print_versions: no information for symbol __pfx_rust_helper_put_task_struct
warning: gendwarfksyms: symbol_print_versions: no information for symbol __pfx_rust_helper_task_euid
warning: gendwarfksyms: symbol_print_versions: no information for symbol __pfx_rust_helper_readq_relaxed
...

Filter out the __pfx prefix from exported symbols similarly to
the existing __cfi and __odr_asan prefixes.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index ea3849eb78f6..eb18b59d4f39 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -332,7 +332,7 @@ $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ;
 $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers/helpers.c FORCE
 	$(call if_changed_dep,bindgen)
 
-rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ && $$3!~/__odr_asan/ { printf $(2),$$3 }'
+rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__(pfx|cfi|odr_asan)/ { printf $(2),$$3 }'
 
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-- 
2.49.0.rc1.451.g8f38331e32-goog


