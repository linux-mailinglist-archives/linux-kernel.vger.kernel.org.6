Return-Path: <linux-kernel+bounces-562897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624CA63448
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF31896283
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB819F40A;
	Sun, 16 Mar 2025 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="Ghri5oND"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DF19D8B2
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106054; cv=none; b=QZDsjLNBBsiJwLl06Xl7BGp75QaRLLkO7lJcUwyywFs+QHRg0Tkx0oO7sC96jJHx0ip9Khcepe9X8uSY7k9nDdD+4K8WKql6o9j/foY4dlZU7YmULQG67IRBXPo2g08jWvUeGIOjvNJgb/42ZsGlYPSNMb1qQhDl3e5rohAtphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106054; c=relaxed/simple;
	bh=KX3jPb+KdnhH7zSY4q+3YOyo/PiTXXKWO80j/bq2BPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIutmdhnAUVqZNbvK2dbTDm43Xii0VbmuQfUZbDa2QKlhlVzoCUyomwjULvvaxFllLbQPuK2IzhcS/NO1elWaGK9FO27aUo70xbWcBDc/sgy6/OawrQMzvmm5kvU5AN7gYxbJvbSdN+6KKH9B1BJiI6icN6v+GmCRDtYXrMhS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=Ghri5oND; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso987958276.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106052; x=1742710852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoSNx//L0CoaxkVlW3LsLIXWFgY8SicS6A0ILg7Zsv8=;
        b=Ghri5oNDcCXP0EHFcst+lK5Um5Yzb28c6U91m7gaOb0SxYhqhDiOAnwugJWS8IBoej
         Gvo8rQ4ntv1hMJb+svoJ4fWN9Uqyo1B+U/iBpDt+hVlCA5fQht+5AEHvO6SyNXHdLz6t
         sYTQWdU4DA/NyHSowQpR0Q76wtSPxPg/hPai0HlVA2G0HBywSdB5d7L7MEZmOFKajZ2b
         t2OSsI3dOvPf62RWAy9WoW1QzLD55hxPQEXmR2EiYn9OOrNh0GVogDp59groGpJ3vJHJ
         GDJEYkAeadKVUp9MJY38ORlI76wJn/wJaxWcTTtI6QZDiAQhyaLKFpmRzF61I7176uHY
         EB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106052; x=1742710852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoSNx//L0CoaxkVlW3LsLIXWFgY8SicS6A0ILg7Zsv8=;
        b=Oa+cx4VF4F5qF7+kskyYS4BBl8Yk0Cs1jfHMz4VqbR7y7hkDK6ECYVEe/ymTWnVF/b
         sRx316EWxmHAuNgw4MfnI26YiBpUmmG1z7oecgE8yHjZ9enRv5AzKVYf3HH4O7YQEsVy
         aWmQ3CkDQn/NYOv1VtQ8CZJNIJ/mhhBrSN9f3TOwQ5m5k5qjX2hCBxPTVD1W5mCs4jKV
         y1kP9jGoiUIO02X6TSRfxjm1r95fp4kBPwuocSi/v0qHMQsJFlbGIw60meUNCrYvt9w2
         +/GOCy+yb5gjnPD8iy3FfJz/Kx+kkaH4++lYkVAHA3w8pTfxYD7z2TR5Uh9QxjLsCo6x
         OwYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbstJJA9+9EFiU3eq21TVzAN9mFm0ap0zrAH0nSffXFiEVKOKtjL7LfFf2qcKXuQM9hwLXEaA5Di9px6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdkrGv4WhFDUb9Cct3u8wn7lKsmZuY9tM8wvrE4BW4ThUk+GI
	EKvT5cChU0+jmYPHdQ7oa5p8cZPd8OYaTQbkWeGVnYfR1XmFwWfbKlwRg20SYlw=
X-Gm-Gg: ASbGncv1KQFcXtMA51i+EE1I9DYBO+irCU0q8+UyAjbdmOCgE6ar+VAASmbAdqnWewO
	J6qap+Ln7JVZ1HWfyUps6c5mMo+UJrNSP2aMKoaJO9qcy1EiLn8kCBGhTNLIns8Yrikefneq9Zs
	ZfgbU+vqFxg/yVcLiEmHGhw4H/dyCPOqjnKJ0wkAaARSPjB5DwBjxdielnaOvquBd3a9YBk/6V5
	JpJLtaOVrwss0QtHGFsbH/oWeKo7tXBOnH9Fcgkv3AoR9LhgCG4ggo5rHqwDsq7UxS8zYkRaMwh
	Uv4IlLYVBlkV0lUlGSpG4IvKYzM+Gm54v3V2Gae+mL2I+WEVQEn5UxdyfHljXf0ScwZ5lLVU78a
	gvu3VGqDlrJyHhMWMk/XTbZ+9TrSYhQ==
X-Google-Smtp-Source: AGHT+IFSIjA+P2B+BI21ghjlbCWIPcaxEXwFyOsBLfnkUoZXHa8ieEB+f05Rm6wSnN3mOs2lKgytsQ==
X-Received: by 2002:a05:6902:490f:b0:e5d:cc35:3e2d with SMTP id 3f1490d57ef6-e63e39c6b3cmr16371780276.4.1742106051819;
        Sat, 15 Mar 2025 23:20:51 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:51 -0700 (PDT)
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
Subject: [PATCH v4 14/16] rust: fs: file: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:23 -0400
Message-ID: <20250316061429.817126-15-contact@antoniohickey.com>
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
 rust/kernel/fs/file.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index ed57e0137cdb..7ee4830b67f3 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -331,7 +331,7 @@ pub fn flags(&self) -> u32 {
         // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
         //
         // FIXME(read_once): Replace with `read_once` when available on the Rust side.
-        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+        unsafe { (&raw const (*self.as_ptr()).f_flags).read_volatile() }
     }
 }
 
-- 
2.48.1


