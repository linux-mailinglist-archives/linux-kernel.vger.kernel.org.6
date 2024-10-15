Return-Path: <linux-kernel+bounces-366191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21399F200
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC828271A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861581E7653;
	Tue, 15 Oct 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm/cpHjS"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755ED1D5144;
	Tue, 15 Oct 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007537; cv=none; b=dJQdvh1mwiXriZQWyCRXUU+nEO3qb3ArcVHTa8O+EC6j2DHlhK3yIfmzXzsVlPnDx6C1U6JYz8d/U5lXJ8tIHPIYDpj8ZqGbCPJ4cTDKupLcK3Ty63ZQ+C7SAwMZK+2HryHmuuT46rB/z/m9AaQItR/hHKQ0MdJm68dNbRx1Z4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007537; c=relaxed/simple;
	bh=xM3QmGPYOaP0UHcuOOhwp6Lr5ugRT16Ld7IeqHdYrpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gar5JE2jj9OVfPz0nEdWBsFfvJLA7EWWVJ1eqiEwTDL0K1hkRd2W0ABk8J/ujySEJNhs1t9zc9glexSvEFS3/vxa7FFehacDceG1osLRHelwn309iKjIfYoQ5mw3LkW4WKTmHiqdqzjZ5Xi+Fb9elQcfg7pLJXKsdHapG6AY5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm/cpHjS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1125414a12.0;
        Tue, 15 Oct 2024 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729007535; x=1729612335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg8eaAXWXzuM+DpadepOogSQbjhJV0Lyf//6lAln8tk=;
        b=fm/cpHjSDLXg+BokDe9wm3Z32qwlH3+hR2FDI3N/D8NeMAoX8c3IEW8EAEzrzR/qAQ
         bjn8PLghXIpuFEOsf1gzG+AVr0kHOJ/ilN5GOQlExWjQd2mhGez6c448Hg9u03FrvyDd
         d3uWe5y+8gyMZH4hyf2q792v5T5NKsLYrfsuFhRBwbmELt2dmgRBOt8eHPlIDtEGRI8f
         OenmTaANGyZn7V2CWBbIVX7g4xe5hI6EVbczbi/QRxU5V1dHUA5aLPTVAWCESR9zaGgL
         +9kKY14jPOtHzlVrOs4Km7FWwNpP1cD3ccP+giJErr8UUoKfC7Uy9QT8oMhtTIAUsZO2
         AnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007535; x=1729612335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg8eaAXWXzuM+DpadepOogSQbjhJV0Lyf//6lAln8tk=;
        b=hkF3Xt0aqhd8TBQIhbd+G/gba4G/m6KB6VxW5eTPqmYa19NLCaSJ3F2nBzXCoxOAFv
         fhwJp/t23Fk6CM5FNGmeVFViqxfGSmF7W+ZkLEXhTomGWseYGG26/Kq72bvDmB02I7GT
         g8AuR6eE6BnpnWSn5Fd5gWRf977Mj/2v9G08QJHN8NTOlefQWt1BQB36zEVN4eHkT6Vk
         2/vwHdmYzWof3N7j4yHfijdTPKLIwE3BCiTGMcXayAUaNwB/tBdfOqDR9lUdyp63EOsQ
         oeH/kKRjbIKmULNE4+9GCYJTe63JO+fV6WXBHnLwFyq3KM/CbUQvEreRqbw5+C0dbA1w
         DChA==
X-Forwarded-Encrypted: i=1; AJvYcCXTIYJOnoCtaot3Xpl9W/u2M8IlLByybU0HmOxl44+3f/+MLtmc0z2gOtk+JusHkcsk9ayJ7ZhWmIAsM0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWlBc7IpmukKzS3KjrdiMYPWfXdrlCcwckONUZ6TbQc7naP+S
	RmrEK3oqhBHYQ7TSf+xnA242DX+gbTuzoH/c5VW1LYMrqvUPfUlA5kXxRwB2kE4=
X-Google-Smtp-Source: AGHT+IFWuhRjKxvrrrxnTxB+PGHsgL6hk1OCr6VM2byohhsaEbwvaCicOUwbTwKEOs+nCqgndiR7uw==
X-Received: by 2002:a05:6a21:3a83:b0:1d8:f4d9:790c with SMTP id adf61e73a8af0-1d905ecb8demr858673637.15.1729007535436;
        Tue, 15 Oct 2024 08:52:15 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2561sm1461753b3a.97.2024.10.15.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:52:14 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Hridesh MG <hridesh699@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Patrick Miller <paddymills@proton.me>,
	Alex Mantel <alexmantel93@mailbox.org>,
	Matt Gilbride <mattgilbride@google.com>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v6 1/4] rust: make section names plural
Date: Tue, 15 Oct 2024 21:21:36 +0530
Message-ID: <e25a1758fdac497b64cb2bb3534894142b6f4569.1728818976.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728818976.git.hridesh699@gmail.com>
References: <cover.1728818976.git.hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Miller <paddymills@proton.me>

Update existing rust documentation section headers to use plural names.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1110
Signed-off-by: Patrick Miller <paddymills@proton.me>
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
 rust/kernel/init.rs     | 2 +-
 rust/kernel/list/arc.rs | 2 +-
 rust/kernel/sync/arc.rs | 2 +-
 rust/macros/lib.rs      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 25057cbed40b..2036846fc579 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -744,7 +744,7 @@ macro_rules! try_init {
 /// Asserts that a field on a struct using `#[pin_data]` is marked with `#[pin]` ie. that it is
 /// structurally pinned.
 ///
-/// # Example
+/// # Examples
 ///
 /// This will succeed:
 /// ```
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index 3483d8c232c4..e85d026ace4b 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -461,7 +461,7 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
 
 /// A utility for tracking whether a [`ListArc`] exists using an atomic.
 ///
-/// # Invariant
+/// # Invariants
 ///
 /// If the boolean is `false`, then there is no [`ListArc`] for this value.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 9325cc5a16a4..d814032e0ccb 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -433,7 +433,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 /// There are no mutable references to the underlying [`Arc`], and it remains valid for the
 /// lifetime of the [`ArcBorrow`] instance.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```
 /// use kernel::sync::{Arc, ArcBorrow};
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index a626b1145e5c..3879e1162866 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -307,7 +307,7 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
 /// literals (lifetimes and documentation strings are not supported). There is a difference in
 /// supported modifiers as well.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```ignore
 /// use kernel::macro::paste;
-- 
2.46.1


