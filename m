Return-Path: <linux-kernel+bounces-562884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F466A63436
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469293B07C2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978B185924;
	Sun, 16 Mar 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="whsRheTK"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748D16631C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742105894; cv=none; b=G5u1Aak9rQTpkaSRqeCYQ9jv/546sgXap37nKSw7y85uzpD6HiGcru6STHMXeUsddZf0Rc9iXaksAuja9rJBDWMT4qR9pkDLC6o4naGDDTrLtZC+xm2mz03ReR80dscs6wYpRRU2crkKx9mutSwt4uJrztTSAT4OU1wStoMSua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742105894; c=relaxed/simple;
	bh=ygAyP+s1qEkz3upA+KGMVgJXbgXIUyv8naNBvaYnPSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFVsef0U3VRLtIgeUhanrbjlMzxiE8VIF6YfAcLDhW5EIzlnMzFLdW/0nN0J+bd6XmU8iiU7drysPmn5pPOzBj86wdqGV7j4R6UPSJ1EV5xwVToTJCEO92W+XOdtHDvwekuZJLD/ERS8bXM/JL5/yc1RMd3cRD4yHo6uBUGOQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=whsRheTK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e63c3a53a4cso2774378276.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742105891; x=1742710691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AeJq6u99xXx3TpzT08tgvG0/0VOgzCx3B7iFUdLBeI=;
        b=whsRheTKNduQgFdPA1AOGw8dc7PsbC0f/h46aCOQto1jWlQDl+A9seVdywGqNZYhFP
         cBm/dpEIZHjjjWMItZcqmFxTZkRaN88XLEFZumtz1qvy/4taLzKwy9dntNlXbbvo5D6Z
         tXiWfTk5BgJWorZeNywr8CZc2thirrNW3317slJlMeK+Ovhp4KeRoXN6Z1fk/2NBJADp
         Z0/dWx+PN5UaLq6h9EkxV7XNxnouU+yit1D5ffR6Kjt/plIn/TU6RzYGSLT2royOCSkl
         VP317LNZax/nWjoCHWqMSQuo59VJFEIEgvJi9T9+RNwyYtlELC32PbMziBaKg3AQK5R9
         YBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742105891; x=1742710691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AeJq6u99xXx3TpzT08tgvG0/0VOgzCx3B7iFUdLBeI=;
        b=f4K5OJxlxklqu2NDdPRJ7VqurierI6P6QSL0oRk6ertaikSjqXmswo5jQrZiuMIkc5
         KT4v0SvJGRX4wHss+wtDyGdmFUK3IM/nk90qROnfr26FKsdFvH+E1aafBeSJnbai4mT5
         VSs1eu2/9GsFv8FWiWu5XJKeIGLaJEHHfEWs9VBU0Kj4g1DKTBfSHeb8H/JO2YIEKIHL
         16PrNjLQy6CiNwWvTSWFFjPqsbGeQgAUf0Dm56UC+yurKYFfBShY3cWrfrV03Mp1siSP
         pYBkdIu2XQ/aHMUt7bbkSnCQ2vG5LuxFPkM938b8FfRYnvi+2LXs7+WIcNB010JV1k2O
         Lfuw==
X-Forwarded-Encrypted: i=1; AJvYcCUebWM+NOg+7Xw1noamZ4ptEck2GncLb9X1+fPbzFWQbb8coIoJyjyk+VQuRetkdT5I0Zi5nDJngxlZeEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjfsq7CjqWJBvQIZIMVqR75Mb3LYehfP4M76xfeodklyK+bwIH
	OgcrqZX7XI2WljIk83wQ3r1w3fxPM6XduYhNAPh1xSBv+kZdNmF9NbgvJFxoghk=
X-Gm-Gg: ASbGnctwzE9QtThjKjtBbAdc8pxTKQtJMEH+qkVf+MR5nIaVO2rTqs5L/oo0d1uiKtb
	ae6Pq9eAlduZdseJsqYsiKjlZv4jwo7Z007ERqF/srMQ+LvSU9PRzFw9OAooy87lFwdBe5eX08d
	8kC3RTi8sjeVg/naubuSZDtNKS6b6cwBeS+PykqS06Z2OnDJU8JmqQGEd3gHGM2JZL1d67xPoc9
	Tg8vt7FqIi3JOx7yQNxfXtlhWwpU8cHsP6nZHySlUX7M3k0JpORgcOEfTNW5v/tjXHcA62n6ItN
	lX1+dCJADtNhumHeu3IVrC8KX1yqy+RTztUl1VXrkIg+kfWdtuVS5XByMi1GvkuAl729n6scuRs
	gQEt70Zs+URx2vf+g6veOlrDxq+NFZ73qx4GV5Rrb
X-Google-Smtp-Source: AGHT+IEcncqvevbDmCCrd/JhLPLX+no2+vZx3eS5Nrp4fNGD5yeQ8uqH17YQ21ouuFMhomI/PXf+Cw==
X-Received: by 2002:a05:6902:248c:b0:e5d:fecf:9acb with SMTP id 3f1490d57ef6-e63f64f854dmr9881904276.12.1742105891172;
        Sat, 15 Mar 2025 23:18:11 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:18:10 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] rust: enable `raw_ref_op` feature
Date: Sun, 16 Mar 2025 02:14:10 -0400
Message-ID: <20250316061429.817126-2-contact@antoniohickey.com>
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

Since Rust 1.82.0 the `raw_ref_op` feature is stable.

By enabling this feature we can use `&raw place` and `&raw mut place`
instead of using `addr_of!(place)` and `addr_of_mut!(place)` macros.

Allowing us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/lib.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..1d078f69bb19 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -19,6 +19,8 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
 #![feature(inline_const)]
 #![feature(lint_reasons)]
+// Stable in Rust 1.82
+#![feature(raw_ref_op)]
 // Stable in Rust 1.83
 #![feature(const_maybe_uninit_as_mut_ptr)]
 #![feature(const_mut_refs)]
-- 
2.48.1


