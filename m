Return-Path: <linux-kernel+bounces-349658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D759798F9BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D12B22162
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE61CB53A;
	Thu,  3 Oct 2024 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V97lcLm4"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4460824BD;
	Thu,  3 Oct 2024 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993858; cv=none; b=t2tE4dCQIMkttYq3sZVjWOC6EV6RK1p4jkXeQvEWBKN8N56gbY9TijeK2OXCNVEn1co1uIQiD4HcaPMr8Gy3cmwfo6lFzS3fBH7RIa1vItGf5vhYvI34oA+yTqKBze57LBvwbDzWhcTM7ZvZyqYFOMzgqO9DiGMAg6Boexf4/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993858; c=relaxed/simple;
	bh=Ymh2tpS1JI2NHOim1p+BjzOidAveJc2fGryZHKnRDpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZURI/IA423miIyhnCQakXpaMVZxlmnO/fqmE7Nrk5ZeD92ekoWLurrxYArtO3RFxDfc1FOuLcnsosKzkNr9rjDzvuUADNeetQTcDjpB57GHBzrCADvqarLuMUQY6qmbVTRRpt2168Vqs/8vlzClzNOYsleJcOjCHSf8vI8he5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V97lcLm4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso16474491fa.0;
        Thu, 03 Oct 2024 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993855; x=1728598655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo03yBFFODZstMfsdWLSOlbjB57/RWRNzFo3/1cKqnQ=;
        b=V97lcLm4l35g8Az8mujQLDGHO83/8/JlZgMm2r/Qc4tn16peyN3T7PgR0/PwYWl2no
         r1x9g/SKX7Hu0xO3tDcZ/RSCIZ8YeAXEjiWd4lUPRvTP2dVBImFYWlrHdzqaAu6ila0w
         AE8fJ5YWWIwJGIH/TnG+zxinnI4MUTX92UeyvPsyHUcR13veaCrUny9EhuwwO09zukNW
         KZJQ+Bsmbz0KntHYGxRW62dHnzHEqdmx+PeOVsev4H0s82Rq0M84PIcql9K1Rvyoif/c
         WO4QsMHvlgr6LwJ7jWfyFmnrPycn4lsCxyN1ehhYwdZTqny/NacGNQCuN/HeOyH4EziQ
         kCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993855; x=1728598655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lo03yBFFODZstMfsdWLSOlbjB57/RWRNzFo3/1cKqnQ=;
        b=M6iRstHk7MIv6rxyAer6oq4I0Zbk8Kff0jp2JaDBL6ee49VAeIlF2ZF6c45mvgUL3T
         8qI4TAplTgToekLc/e3txcBzDiN+8tnaivLtlNBjuyCstbbSJno+mjvZoQHHTHuP1Zbn
         fkxGCdIii/hRvUYyI8ZQK5fowhqBtwg6RW8yAPPXmrM7XAJiys0dovJ9CMsnZJXQLEgP
         pKFOLSQYAL8ilGHGszOTuQn4jozrXOOGNc0j167UVxSYqIT6SdOfKEyN5INZi58+wHUA
         sIu84kPW4Jb+MttnejRQuNI95rpievKBl5TNDFd+FeJmDIUbTj/lrUiJ8df8dHY60G32
         oGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUSK/o0/g7+aJYxVIU1AveHIWhpCRsFgBydAzEG08R+EaT6pP9PXf6TFKYzOUQYmcOuezoIc4UZ6jEGweA=@vger.kernel.org, AJvYcCWAFXYyUETz63CiIfs6CUNTYCop3R+C4Zr/eV5aHqtMOzuXYcAxg+g40mrzQNASFKNg/Lg79M5wfIyTJL6Uuy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOtopHUaCFa/YcBN1nCaJDrTJw5tbNAjcnJLiR+qWbjI1Jfjf
	txIJ7Fph++HiOLyFy8i4mhxRNDaAKjZtCcSLEBgfvAkXiRjYjItN
X-Google-Smtp-Source: AGHT+IG12SpHijBRGXnrLLIsP9edGAXbq0kxeeG2mPlpZc4fneT6+0Ohi0oAfNbIPRCboytuYOt7fw==
X-Received: by 2002:a05:6512:12d1:b0:539:94df:38e9 with SMTP id 2adb3069b0e04-539ab88af26mr456917e87.31.1727993854565;
        Thu, 03 Oct 2024 15:17:34 -0700 (PDT)
Received: from mbp-deepak.lan (89-69-93-57.dynamic.chello.pl. [89.69.93.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910473160sm137958966b.167.2024.10.03.15.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:17:33 -0700 (PDT)
From: Deepak Thukral <iapain@gmail.com>
To: 
Cc: Deepak Thukral <iapain@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: update dbg macro outputs in docs
Date: Fri,  4 Oct 2024 00:15:37 +0200
Message-Id: <20241003221536.34826-1-iapain@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch updates outdated examples for `dbg!` macro.

Signed-off-by: Deepak Thukral <iapain@gmail.com>
---
 rust/kernel/std_vendor.rs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
index 67bf9d37d..464b2c4b5 100644
--- a/rust/kernel/std_vendor.rs
+++ b/rust/kernel/std_vendor.rs
@@ -16,7 +16,7 @@
 /// let a = 2;
 /// # #[allow(clippy::dbg_macro)]
 /// let b = dbg!(a * 2) + 1;
-/// //      ^-- prints: [src/main.rs:2] a * 2 = 4
+/// //      ^-- prints: [src/main.rs:2:9] a * 2 = 4
 /// assert_eq!(b, 5);
 /// ```
 ///
@@ -65,7 +65,7 @@
 /// This prints to the kernel log:
 ///
 /// ```text,ignore
-/// [src/main.rs:4] n.checked_sub(4) = None
+/// [src/main.rs:4:8] n.checked_sub(4) = None
 /// ```
 ///
 /// Naive factorial implementation:
@@ -88,15 +88,15 @@
 /// This prints to the kernel log:
 ///
 /// ```text,ignore
-/// [src/main.rs:3] n <= 1 = false
-/// [src/main.rs:3] n <= 1 = false
-/// [src/main.rs:3] n <= 1 = false
-/// [src/main.rs:3] n <= 1 = true
-/// [src/main.rs:4] 1 = 1
-/// [src/main.rs:5] n * factorial(n - 1) = 2
-/// [src/main.rs:5] n * factorial(n - 1) = 6
-/// [src/main.rs:5] n * factorial(n - 1) = 24
-/// [src/main.rs:11] factorial(4) = 24
+/// [src/main.rs:3:8] n <= 1 = false
+/// [src/main.rs:3:8] n <= 1 = false
+/// [src/main.rs:3:8] n <= 1 = false
+/// [src/main.rs:3:8] n <= 1 = true
+/// [src/main.rs:4:9] 1 = 1
+/// [src/main.rs:5:9] n * factorial(n - 1) = 2
+/// [src/main.rs:5:9] n * factorial(n - 1) = 6
+/// [src/main.rs:5:9] n * factorial(n - 1) = 24
+/// [src/main.rs:11:1] factorial(4) = 24
 /// ```
 ///
 /// The `dbg!(..)` macro moves the input:
-- 
2.39.3


