Return-Path: <linux-kernel+bounces-302222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0316195FB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367B51C22847
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53F13B58F;
	Mon, 26 Aug 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTgtA75S"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CA881E;
	Mon, 26 Aug 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706672; cv=none; b=bSiFXWr0r5LvHtOklyXu+cr/SfHIciNgJtXtMOtyHFVQNrXfurvKH4T9LwVONS+TpWbfodWC8SBrMhG4C3IQ2yCzJw6AmnN5T9rx2ey1nD3nz7AEnI5ljDQaGol8dnj6G+Su0XoZQY5EhHxU8v8osCGYbrAdJBt9Iwmeop1SZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706672; c=relaxed/simple;
	bh=mvpg7Vi+JNpebj/+2S4OHlr93xR1UlWOA7zBPYvkp+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BcbKVjiG93BqDn016gtf+l0supMx1qlqV4niGU3e+kdxFPLj74/iepklqGcRtB3Ect3aTRDq2DlAer9vhCSCPD/myA87P8CxXl/71IV5QHbCftfW9oQYt5nFPYf1T6j0oKJ8ij4auMe+D8EWCuLbadoD3S8MuNCjpzgXGm2CPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTgtA75S; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-498e1fea1a7so1332384137.3;
        Mon, 26 Aug 2024 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724706670; x=1725311470; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTot/2/JNzH7OE6ElQQ5reor//jnO3hoThV2tPzBlEQ=;
        b=hTgtA75S2VzM+n5cu2A0wVydn1cVMyJMYjPKSseiNGjUU+h1pMljA/lzsJSfowfnMI
         Y+RU5EwcWbVkyL9GfxXXs4NbGhbdHNzSQvVNAkAg9ZBRxYDJjmLmrGSq5mB7gd77y9rF
         qcaQpHhxmC7m52DA15HcOy3rTHOXESoJTr+gZPlvqcdWS2/l8nq3mQuaz+gmmGXW5SLz
         daSTW7c+EfajS8To8gOH+XqLiv1UQTKSwsQ2W0kHEZ1y1E8PRyklJtql1Do4/NdA04ol
         9+36GDaz7h7bz8CdZ4uZ/ql3Sb3VN+w6OQsK31UrQhSXrFK5M79NO8mMdDBxvq/QA6gk
         RsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706670; x=1725311470;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTot/2/JNzH7OE6ElQQ5reor//jnO3hoThV2tPzBlEQ=;
        b=ns4eHYKJ1iF4bxq9UnhLeyT1ATCQGQCfmoImocHWo2nq0B8Vbs42ICCyzNHQgBd+c7
         KYGA1K90VuJmpNqVOoEfEE6fBc7D664my4ZWaCW3+7QzVNPa2Q/vj2a8w94BIloULQ+D
         yB+0mE4J4HCVr2t9bekqpyLw7aEHNJw1dRt7mGgCxJJv3ZAU1XWRVoNihNYZVQ5AbZYN
         ulKRgv6Gny4jRH1eIsZV386ZKXzeIFFEgb5UvI3QMNRIni/h8a4FzITlhYPagIPzmdMy
         ZzgPe5OMJA7HtoBXHqG50dJ41cy67ZVBdLkYLvSD4pr5s/Oo3Auv5YzyGwnOlvEXEc8a
         wrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4aegCN9/w2p4GDMCsTt8tC//a6A7F1lKaOSC4xJDtfkX9f9ikJLZdCrW8bODGAvUHGeyqRKULxbI=@vger.kernel.org, AJvYcCW77Om/TiQiPVTHSb/utLc6M9fYXDQQvzRamWovk1MnKVYa4RYi5kYCAgXGRUm1wmOgwIBsdBFeV6gIMGFN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72ePBr7aybKfaHaSmu8XMpi6HYXcTa/cWCesW9LUpzyZA4daD
	fOOzrJtej4lKajUPl+KshuNyvVqchxwQhu54vZbWRhNhIwqwHMdf
X-Google-Smtp-Source: AGHT+IHKO/lO1SiTa6i7Im7UcRHwKNHK4pMih2QKoNyKRgvIeV7FrsmBOPgfpC7MjQJS71WclowBuQ==
X-Received: by 2002:a05:6102:3051:b0:498:ca87:ba49 with SMTP id ada2fe7eead31-498f47008ecmr8671119137.19.1724706669511;
        Mon, 26 Aug 2024 14:11:09 -0700 (PDT)
Received: from localhost ([2600:4040:9ce9:9c00:a449:bcf7:4497:9791])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7a67f319221sm492831885a.13.2024.08.26.14.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 14:11:09 -0700 (PDT)
From: Jon Mulder <jon.e.mulder@gmail.com>
Date: Mon, 26 Aug 2024 17:10:32 -0400
Subject: [PATCH] docs: rust: fix formatting of Hacking quick-start list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-pr-docs-rust-remove-quickstart-blockquote-v1-1-c51317d8d71a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEfvzGYC/x3NwQqDMAyA4VeRnBewxQ23Vxk7xBq34GY1aWUgv
 rvF43f5/w2MVdjgUW2gvIpJnArcpYLwoenNKH0x+No3detvOCv2MRhqtoTKv7gyLlnCaIk0Yfe
 NYVxyTIzXOw3OUdsER1B6s/Ig//P1fO37Ae+Npzt7AAAA
To: Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Jon Mulder <jon.e.mulder@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724706668; l=1636;
 i=jon.e.mulder@gmail.com; s=20240826; h=from:subject:message-id;
 bh=mvpg7Vi+JNpebj/+2S4OHlr93xR1UlWOA7zBPYvkp+M=;
 b=I9hTNfsZhXcPu3h/7sImBW1+GeYan8nbFblxoii1h+Vp3fpb5hwlu4IzTq0QFba/rYqDTg3Um
 0pA/J15wMp0DNHCD2cAqPs0os5NKmD/ripkDJb+Yb5hlN1HkS5wL3OO
X-Developer-Key: i=jon.e.mulder@gmail.com; a=ed25519;
 pk=TBp30jl6pgKrBPlChwtN5wDRdl4hhtaVyW+oLu4YXMo=

Patch to remove indentation within the "hacking" section of the Rust
quick-start guide. This removes a `<blockquote>` HTML element from the
rendered documentation.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1103
Signed-off-by: Jon Mulder <jon.e.mulder@gmail.com>
---
Patch to remove indentation within the "hacking" section of the Rust
quick-start guide. This removes a `<blockquote>` HTML element from the
rendered documentation.
---
 Documentation/rust/quick-start.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index ed5af2b5339a..2d107982c87b 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -305,7 +305,7 @@ If GDB/Binutils is used and Rust symbols are not getting demangled, the reason
 is the toolchain does not support Rust's new v0 mangling scheme yet.
 There are a few ways out:
 
-  - Install a newer release (GDB >= 10.2, Binutils >= 2.36).
+- Install a newer release (GDB >= 10.2, Binutils >= 2.36).
 
-  - Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
-    the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).
+- Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
+  the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).

---
base-commit: 6e6efc5fef4a1cdcccca3cffd5b73fd25d093352
change-id: 20240826-pr-docs-rust-remove-quickstart-blockquote-59af11a84c1a

Best regards,
-- 
Jon Mulder <jon.e.mulder@gmail.com>


