Return-Path: <linux-kernel+bounces-569064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06578A69E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E1319C3E11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229EA1E5B69;
	Thu, 20 Mar 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="mSfCmUSq"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748D1E5201
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436553; cv=none; b=rWTO9auDr2yCn4zu9VPfBic+5ewfhWa4VnPLkFmMOIT5fpLGUmxi2NEe75uVWEts1Ld082FSiU2AzHD0AmxEsTyA7jwdgWVP66dRTIs7V+I5t6K98WRM19dPMWMULbwKDXB59f8Tj41QtejXyCQA7xNjtDqBdO+VFPDrXJn+Ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436553; c=relaxed/simple;
	bh=Or6Oia0V60k1legDs9xJo9SzVaQNUCuV82n0fmSpftI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGdqKpH2hgCdVLVhIOposC7HxR8Vt2nrMNCpBUBnxQJuc6VI2MFQ3Kyz1kYuiuAb4Pl/y1Xd5FcnkG+jqCKJC0LmKYWcDztzGHsRhDWGXQN2SDNXg1PJZae7CwsCCD3ATEnyQ7ud3RUzG+NBD5udZ3/VLSGkBNzUCBuilQlC3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=mSfCmUSq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e53c9035003so188308276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436551; x=1743041351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ty32uzhHiEBtLktT6ubZPRwrYT53NX4ATvYCjW9fL0=;
        b=mSfCmUSqGpex0CePfV1exkOUcxe8oggZL4B+bEjXBhT5R60WcWyQqKABWEf9rdJJY8
         NAQRbGBby9nf3mVZ3pHe0gCniCWnVyEYHWNOQ2PprsBHH54phwB1frtaNAA3QY20x0qB
         /HdhKrMmX4TenOP/AfxyXLbnDqR2KdQAgkxhNJMQPK2cDpM88UgVa5rLN32bP6UCdPId
         MlBlxCmuhil6tUke8aXiWNgrUsG77jnp3UKdeM3Fet/DZRScWW+90xmp9xhRrvx0y1uc
         4eQCqzDSv5bCPCQfH9Xx1V3vSy7667TFIlF8I5dklS0lFx/QeNT+5kI3u/GZLEulOj6x
         deBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436551; x=1743041351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ty32uzhHiEBtLktT6ubZPRwrYT53NX4ATvYCjW9fL0=;
        b=T9RP65O+U3KWrjmG3CTbj84i7Pr5Re38p8Jv91UM42A9nB2XsCgaZTFDBR8r8Q1xcX
         MaRylmRLyV5AHMbSvUw+CDZsYPhBHD5AfWeCSxQeNmmaOeNI1z2BBU4+zn7WJgvPkAZQ
         S24iR5wAPIOwVe93PVkmPa6F8KAB/3cqdjTjp/gjm0H1mYojpgQcTEGqj0SNZdsXtaH0
         mqR2TAsaFDQTRIvcY7PGeaHCdbu323AONRb4FYWLYf+DiM++qThuVuQOy1TvkRBTvd3C
         ETGC+r0SKYCuLCBHq2xda1gYp+HnFcPi1ALo4G6K8FNtyzhXmQCsXenANskQ3b8zxaLU
         1C3g==
X-Forwarded-Encrypted: i=1; AJvYcCXD0U0qySMm5Acd9hnz0pwTcjhplv2d6Cn/4uvoRTilWELhnL6oK4/YbTs+pBFjJwkSYMsnfboZSBhwfew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMOlSv26yeedZ/5BND2KbailyMr2PAWaeL03ZM8xKg4OT8UaP
	VQm7etdDoj8QRUbtoWiyDWmwyOOTWuBO0V4itQJ7WsTdI1J90AV8800qDip7V4I=
X-Gm-Gg: ASbGnctH6v4Pfq6UfbK5lssoekvA4F7P3fo69BFHDl4LNO6eArZUsukw4sqbnIchcNv
	jlS7cYCwOwYy0z3XZivkLjOTEehQboMox3TqMTOHuI3vntJ5MFhZEBHDigOv+RnlKWQCwIF/xvg
	i3cwIYlmuGtzUIoB/vmCEXwyKFE8v4+xzws6yK+ElP3tqv3eSH3tYlzWJqUE6dn6FLzq2yccfKf
	7S21CyMpkxy7Dkbc1YBX4WNAYNABjnmcnrJ7EN3fmbWL0z8dIx7t9Lms9PJIwLcuFFXelLyzAOP
	5UzNYscEUDin+p0hvTwMRpGyjw2dujHAcyB+F3S3uKlhx7dP/0mzcuSDx53JrM7LX5sO4AHHjd0
	cdxzL+4DyDmzBC3SSL9anQvtegri3vA==
X-Google-Smtp-Source: AGHT+IGr6ekwGvrKq0PfUiPlCZm9disnjUfBs3tMkHfcJsGG/xk58LhvIK57Tr2cgBQ49oejUbUucQ==
X-Received: by 2002:a05:690c:4988:b0:6fb:9663:a5f with SMTP id 00721157ae682-7009c15b36fmr68845797b3.38.1742436551176;
        Wed, 19 Mar 2025 19:09:11 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:09:10 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v5 13/17] rust: sync: arc: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:32 -0400
Message-ID: <20250320020740.1631171-14-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` with
`&raw const place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const` is similar to `&` making
it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/sync/arc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3cefda7a4372..81d8b0f84957 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -243,7 +243,7 @@ pub fn into_raw(self) -> *const T {
         let ptr = self.ptr.as_ptr();
         core::mem::forget(self);
         // SAFETY: The pointer is valid.
-        unsafe { core::ptr::addr_of!((*ptr).data) }
+        unsafe { &raw const (*ptr).data }
     }
 
     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].


