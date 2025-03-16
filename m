Return-Path: <linux-kernel+bounces-562891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048EA63440
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74C41894368
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C49D192D63;
	Sun, 16 Mar 2025 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="Idlh1j9U"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DB1917D9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106042; cv=none; b=FxCZ/4kiQ6nnF4VKN70AHLjEGM5h8nJ4NbCICmHt39pNImOJCHRJV40TAD3n0OhW1OY92w4xpn1sjXb+94rnGV8xcrMsMBz4kTEgQ/A33lCb5HnM1qqFGlImmtZzGGMCBygPsHUkE2D40JAAtGbCkmnc5wHGuAzvSI0UxLS4EWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106042; c=relaxed/simple;
	bh=YC0aFKOl5srVCaDj9HbucZ/4B5f/InwUtG32FScc5k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihjjSRc2KbgBxpp7jjZ3KgFQrLBKTkR+FmmhFuVjaBK3OUuuFmUQU8ZV+6gpgjck6moCdbBRvpq0EiXtEfPqY92INxiNM/D8tLFFfCw/cFx+EK4/vJg8JYog2VqXXMWqM9wzryut66RF9in0x/XmaGgFfpol8xuh6sW145CjEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=Idlh1j9U; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e63fd2b482fso1350951276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106040; x=1742710840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI9KVcwdadVIoPwUOMUiJkuxM0R26yz4AdH6Inso0Ms=;
        b=Idlh1j9UM2XFdknrrX9CJyCGNPmZDFjHoEvystlHzOJiE9N8vVqu9y1RQ+bgyWtYDE
         h4O4KDp7ltAPDxN6GIzatSOppsK7q9SuURvzfrY8MOhjh3D8XCmRT5dBWlgkvHiYy1gm
         4pjlyZMRfpvDZ08yNgZlIsqlNKboiOvEgFFG4UqLqK61AADtFQj7slzqCNWJWCVxO+ad
         ko7sntgy5yjIKmWbusoGzC6eI8NfhOne3GBTp8oCsKaPAs6DrbQ8fVXahj0wCyrj7keB
         WCC8KzAi7EkxH1VFhOsiAUvn7Ujm75w+2AwlQLOKnMUaOnjj6RxyYtj8MGinfvlWFjsy
         2mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106040; x=1742710840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI9KVcwdadVIoPwUOMUiJkuxM0R26yz4AdH6Inso0Ms=;
        b=gH1r+4oD3BWPqdQPjb65P1mIPG7F2Grc+bja4wiNPsD23ze6oICsTDFVjNc8fXR/7V
         TekDOhZ+ytX5BCaeP2fA3/++tAHBediZkFQynVQg2UfEVACCFxr0xcfe6YHVjBr0diAk
         vfkkxK7heq83AJuJk1d37RGSkU3aTe0YMZqvhFNWI7ByEVqEuVWhoLsbyS2rH1yzZzD3
         aROoqDxud1RUW1XE36+75duL0P7j2YzoNIN7N3DdAme7eAGL0gNpM49HeF3NKWjL43ys
         KXvXeZ4viUL8GFmkEVdSXhWvDaWpnSX65cCQ6xJ+wx3UUHz1hZVChLJ5nCBJZXg79QQ6
         0w6w==
X-Forwarded-Encrypted: i=1; AJvYcCUTTlRQOMEd+xr5R89ipJrsBUgcsW+MdO7tSB2ccWRiLbNYVJKxe/9OrmL/U3Sq+y/NWXgqBJUXbKEuqz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OaCLD6jg2AURRuBFq4tbpBPmEbQ2UUFX8UhWaimJCHL76c9g
	sLfRXQw4Bw5IC/zrAQYZBpY8obOfrDCBUENzFFJqs5EYSalqcO7vH5ji0kzh9AM=
X-Gm-Gg: ASbGncscCj/fKTjr/32ur9DozCxiLttL1XksbpBb47Pa0yRUM8N11iqE/U1ClEj5U3G
	AYG6fKypz1yPJx2CTLE+Qa46kgGZTdoK9o0SXHwuiP2J/I1zOR6uUqimNm3MYOH52yFp2+84tek
	4yUptkz2GVsp8GrN6dZ6FDQaAVNeQY103KIhY7AZPSME/J8IoYYA2gPcENvWqr7ZvyiFFjmiSuf
	jTI72uDspG4cR99riv5uqsgasoJq5lna+7OrZynPJ83UaWD1ZeB8rJN8gofetnkKDnbJZYbllYm
	qtiN6LUZ0lKfWmgpAP1niUAYuM8Orx7JXQPBpsDBtNfw+Rlh7VN+6U81/uA+tJYXA5CyG7s86jV
	hQaeEfDrCm5xfQEp/cyxGQYoGwZ0G9EcIu6w5hWHL
X-Google-Smtp-Source: AGHT+IFAFL4Jrh9Si4Gax3r4dtRoG0FBSmnCiBh0EFTCVqOTSuBu2GcZmIpzrGnEwTgp1XUPTU94PQ==
X-Received: by 2002:a05:6902:2186:b0:e60:9b80:1f82 with SMTP id 3f1490d57ef6-e63f64d1799mr10862158276.8.1742106039894;
        Sat, 15 Mar 2025 23:20:39 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:39 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:17 -0400
Message-ID: <20250316061429.817126-9-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/kunit.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..a17ef3b2e860 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -128,9 +128,9 @@ unsafe impl Sync for UnaryAssert {}
             unsafe {
                 $crate::bindings::__kunit_do_failed_assertion(
                     kunit_test,
-                    core::ptr::addr_of!(LOCATION.0),
+                    &raw const LOCATION.0,
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
-                    core::ptr::addr_of!(ASSERTION.0.assert),
+                    &raw const ASSERTION.0.assert,
                     Some($crate::bindings::kunit_unary_assert_format),
                     core::ptr::null(),
                 );
-- 
2.48.1


