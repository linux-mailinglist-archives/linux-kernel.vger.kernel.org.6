Return-Path: <linux-kernel+bounces-569066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C187A69E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629B2982C13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB411EDA3D;
	Thu, 20 Mar 2025 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="2zMOl+Jw"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD51E5B9C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436559; cv=none; b=KiVZR2Z1XYKoKasymMNeyv2BBGiP1lBWJZcc8DYKIu+OlwLkJAuYwyUgx6If+X6xML4/06y+WLgU3c0s7It+ljEQ3siNwKAJt+SM6AtWtWCB+JpUANVqmZSxpgMLEnX+ZEVnu7o6A/UdyhWB2cbHvdTLjOqm/1n5jNQsSQum4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436559; c=relaxed/simple;
	bh=N2IPwfKEmczTfi5K1HviqmmyLKm6mFRpGXyDRw95sEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSlRznTVjF1TkC+bIvy4LnN7J08F2lxUDGoY9JPgDL8aiAjvCrShPY07VHRjcF/nPBbsPy5neAIvUxa1ITr6BRQVHJd+fk57i+6LJeUxFSgo1RU7XtKZV7s5pYkgq8M0EqcqvFPb3wi4cOeBC5rgyb5R6avGTeIc3JQ3IUF/ynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=2zMOl+Jw; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f768e9be1aso14397927b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436557; x=1743041357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imGKC3gmhbIWa37wZJHFU8on3cBZLgF+oTJoS5NZccw=;
        b=2zMOl+Jw9JVBT5tN1dwGMQtJm7GCT+gLE3Z5IMhQz7uTrr9SwziHjPVAqg6j5qNPqb
         MOnzPTW8BV5fHHPzONBAmxEYm8IFTag85hBx96tyVdArTTrPkhvKs0TJlKcCgTzheMgW
         QvuHH2qHmb/6alDWFffl7a21FIsMyvmQAiPqVevkVQF2NpToXbafLRUoR1Jxf9+IKZHI
         SWXqT3Hr60CIGgSo9hJpFJfwINZsWK5j8hB18B8qxikn7LW8rTZvRCqyVfftS4cJUE3N
         GbGrM2F729lU/2UFDMdnsqMY+2Amnnbewf1a/rMtcdCD05hhaSO+FMNktW/+OEcF2EJI
         VsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436557; x=1743041357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imGKC3gmhbIWa37wZJHFU8on3cBZLgF+oTJoS5NZccw=;
        b=nqGsv4KIWy8FgVhwy9OCFwBKpmeur1w6gLkwWlbwz4sC50Iws1XcantmHrtUsiIH7a
         R+cLS8W1I45pJjZyy1etGEsBqbkigj4W3X7FETUYGGSERCo6TAGh/oEM4Ujqr56YyUEA
         bqtj4z1pHA1QHbaiJuy5tRl+CmwLKU9vBkkxxBwOuEIYBxPgMs5PwYYkiUyCYIoSGrUx
         U9Yxub47PwIE/xmga8610CGyWATdVa7wXqV2XnpSPqlEFVy1H8q6mJrpYzJFXVjWR+/W
         3sttR2xit0HbuY2xpbAg2+UX9c9m4kXIuc0PiuDC+OwLJcJfIDqxiLMNVDZlRKQWSs+z
         +cZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Q3Z4iiBLoUwvBR6fFlc604L1jbXDdES6otakpwenM0ZtRZmw9TJgup+x/RDniDUhAVEg7uC9g98ny/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx20dm0H+JytCpmqSQnZKdtz82LfHNe12RTjLdIx7kT1iUUcl0k
	rFjJ05etmE+k5NcA0laKLT6oUj949gvg9kcklhozcSeCExLY5b3Ldw6fQAb4QNI=
X-Gm-Gg: ASbGncs7Fx15rUushcrkgCR2HKBqdhX3p6y4fLGEqVVUV08LCfxCc0eIDd37F6dcS9B
	h+xrqLEUSpanE5wqZuhKLHEjCBwZJxhdPStEyvc8Jauxs+GdLba6HDj+fkg24V963/odwRmCBdZ
	zfxWdUN2+JW4kjOM8RmYdP9KlyuJGgWvlMDBaOmxNSkFy/cF6FTybZB6ibFNowpxaqQ+LFhkn9j
	JrquNGerAz+u0m1icOe4EZFVqVAagIecSleJZA4zAcn5QNfaZVwqfcbjPi6g2DsFbGoyWSEgx7/
	f2YCGyKEtSckpiYhsskirsklTmRDVqZ+FH/ZPcKPdRraJqP3lTOpfbeVm03T3ntCck8f3wcn6Em
	6jip4QMhMAArkjq4OFfwWFaQZgcUPmCtiqXSSCV+U
X-Google-Smtp-Source: AGHT+IGmA7SYSqNRfrXhwB3bZbarYdhqU5yTBQFpygD+N6x3XxMAhUoyGeQU29karx6EifJyn2wOQQ==
X-Received: by 2002:a05:690c:62c6:b0:6fd:a1dc:b409 with SMTP id 00721157ae682-700ab28c861mr26232997b3.5.1742436557351;
        Wed, 19 Mar 2025 19:09:17 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:09:17 -0700 (PDT)
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
Subject: [PATCH v5 15/17] rust: fs: file: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:34 -0400
Message-ID: <20250320020740.1631171-16-contact@antoniohickey.com>
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
 


