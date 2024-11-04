Return-Path: <linux-kernel+bounces-395564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBC9BBFE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6297E1F226B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144B1FDF8D;
	Mon,  4 Nov 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWM3IVnX"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96C1FCF65;
	Mon,  4 Nov 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755239; cv=none; b=GAyBLkFPimoCdwh7bVt+viXiCmSe+peI7e33YW+smxIbvbf3sggllYfam081ynIcTZJ3Nc32qfTz6/h6+ntk2LPm4eMRpSLBq4kT8o7vehL4elmfaWypokfARcoxak6jTVqGkuVeuy72LXmDHx4IhM+gaH2vE8FtnidaNZyGQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755239; c=relaxed/simple;
	bh=ZQJQKIX5ZQX5sWC8n0SlJ4WezNt3GyNXog192hsNxCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqO96rNb2kLQEM5D4ax7AcPmMSV+31BuQ5ua0sheQUnrtbL+JG+KcCuG9mgwEw5aZb+/Qh6lrUIPk7KyysEs1BB1LXft3MEaT+EuEMK3Ge7rcuXNZxxKRll3GAoUJ8mKqLvE4h5/NYb1STLUnjGUbYJc/Dq8xCqRKRAutGBEu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWM3IVnX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e35bf59cf6so53148457b3.0;
        Mon, 04 Nov 2024 13:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755236; x=1731360036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFaJ7SKjLkqumVjX6cB33YzQSDHI8oE6Bx++li6t+j0=;
        b=aWM3IVnXXCmoq2ZEsVt2REz9dRu3IoQsDZfWdSJxaMcQAKqyNQ3qlGB5nZdBAkSb+x
         A+gg9sVGtLA14Kg00V4mL8Ct9Q9hDp/cbzKO92xV5oVLj1Ypb6HNdMCLIAYMgKR6Uoio
         cuMdnaQbbPUWBiAWoac0JWvzxV1ZvWrn/Rzhq70SxJ0dic/KZK/S56oJ7wH7GWZI16Ao
         OCiWXdrpuM1QF/LrIV/i8LNzZrqDK7kET3ZVOZphW8uOWatzGV+2AlYzLjDPDvmiQKuw
         m3/aIOMUcVyaF0yfDYUJs8vIaf9lpq+1hZDeqEdQE3oOLsipNKB3ZUj+aTtF1pKgNVI1
         HsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755236; x=1731360036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFaJ7SKjLkqumVjX6cB33YzQSDHI8oE6Bx++li6t+j0=;
        b=Zvrt83ISQv0kIQn9MNMblAsA1w+Als1Umm08ixw/vbs7WNP4n+aHKKl5sLgvMOineI
         qj3aXHsBF5TvuADDdwqbuvmZ5/0t/4zA0FKUnBESxIcvY1BHjUH9DZhUFQPxpL0+t/tX
         J5xF0tBvQcgYs+ADWq3vE5TFXudQt2d1TUllzwh0SJ5W8gTAexRYuiLYCnmTpkRnlZtC
         DKnEDzN3A3M4ygWWavl4UzAzd8tsTHLXL1bEQO0/RrxSTy+A6bm37b5PJe7u06QLLaQv
         VdHZMeg+ESKbomCCu2ZVqGKsPxaQCn7McZKUzjlsromJoRIL7Re6he+5csrcdYITfNdn
         qS4A==
X-Forwarded-Encrypted: i=1; AJvYcCXsdhCj95FPLM9YHXkan4Oq8wv/6U7acaXtgWghx8qeSb4uKSo4HNJtoBHXyuXcz7HQPLto8IiK97F7M7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaF2zWmdxlzQwJvXnTKCsoLUEr5DcRdD60rkt+CiU+RT6GZXDt
	ZP+KN8E0K7BnqMupnV4MxDhLquDZ4/CE8cWznus+SStLFIwKeYsJ4701qckfR+Q=
X-Google-Smtp-Source: AGHT+IF0rTLgR8521D56bV4cJm4ZTduVQUejqQO4V6gD0ZxOhUod9UzSqkGikJpDHC2DbSBdhm0hpw==
X-Received: by 2002:a05:690c:62c8:b0:6e3:23d9:ccd4 with SMTP id 00721157ae682-6ea5591e4b4mr118234727b3.21.1730755236573;
        Mon, 04 Nov 2024 13:20:36 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:36 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:20:27 -0400
Subject: [PATCH v2 1/6] rust: arc: use `NonNull::new_unchecked`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-borrow-mut-v2-1-de650678648d@gmail.com>
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

There is no need to check (and panic on violations of) the safety
requirements on `ForeignOwnable` functions. Avoiding the check is
consistent with the implementation of `ForeignOwnable` for `Box`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index db9da352d588f65348aa7a5204abbb165b70197f..2c9b7d4a2554278ce8608f4f4c7f9cfe87b21492 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,9 +337,9 @@ fn into_foreign(self) -> *const core::ffi::c_void {
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
-        // By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -347,10 +347,14 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
         // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+        unsafe { Self::from_inner(inner) }
     }
 }
 

-- 
2.47.0


