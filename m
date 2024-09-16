Return-Path: <linux-kernel+bounces-330458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D909979ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFB282C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64614B967;
	Mon, 16 Sep 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayKAH3Pe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B414900B;
	Mon, 16 Sep 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480474; cv=none; b=W12ujQkHY2xeE6bFJ5pC7SiXNJHZZ2DlhJMusPrQsuJ2Eq++sun99j4+iol19Cs0KI6WGysO8LMsGHw83xSQn/YZCiLlotn6PJakQ5W2gK+ekiu3Ad6Yx73cdA0GolaPiH3oAYizyH+ZGFVv+DoUB/swb502CB/tLTbutxHAbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480474; c=relaxed/simple;
	bh=O32QPsP5MzyTM8u62T8NKbaDAwFBwNQfNtNHG1gjfgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRALpCrb06/PkC95OgebjZMJYrETMkpOrqC3gD/zDr8qwoYV+x6jqUZJaVdaTwkkgg25p5fFFaBw2LBmiDeVgQatpGMINi3nG7RxP85LUxaUoESc/S9qgiB+MOe5n9QJgWvedhWJJEtoMCQI39jE4kH6MI/hVzRNKFBD41woHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayKAH3Pe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20573eb852aso34159955ad.1;
        Mon, 16 Sep 2024 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726480471; x=1727085271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O5sS2BSYOStx5RNImbwHRfjWe3sDQftoV4pR+7Qz1Ww=;
        b=ayKAH3Pe/XQDneSJKyDmxlUieYUOt1wmZcQ1IDpm4qYsBJe86WS6XwnsCA2FLbBon1
         ARRJpt2e4JGwxR/8IUR8cxjyYRJ2oeRSqPwD5tkCNHWjk6mY2zXFkFsh2YSQT8pnq9UW
         BGJhS/vMQ037+zSDkReG+fokTsC46dccyzswct5CSwLPj/WFTQHjGYQsS2aml21yxOL6
         B7ZE8E4gO2ilUDtjcLgvFR2UR/6EwU8duIZHIpSgddID2IbrYIC0UAh8vOlGOLDqVHM1
         Kws2z0PmjH4iP1mBe22FelJgdkfFGPjiGOheoR9UR0O6X55Xhk4b0FZOMcGmKi7fxR2X
         uhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726480471; x=1727085271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5sS2BSYOStx5RNImbwHRfjWe3sDQftoV4pR+7Qz1Ww=;
        b=IiasHpWV+1QwK+Q1K2fyNcxvlfRkkjEAfMYbtCYJMAX46Do1FZc/vBmZtE9L0EXuQO
         7yp6JwtVznNF8Pxz7XJBAvp1MvKG3FdwuQdat1FyaYD5gh61kxU0iidwhb6woeWBx0W/
         PS9VdbGhpBHmWiJOaW8jfa7FfYI05yGsEkJHC79qQOnrSyRaoccLh7iXjJMXEkwYmLTC
         ZJd3ix4Snp4MBZjB+D6i4lHBo74iWhVSC2Q7rmedZMDqsw/c2gaoBVHnJ4JXy6ENI7yB
         neUGiThS2OP5Qf86rpoNgsnLLq6H48F13VM0TDifIYcNxDNN1J7NQTUX4B4P0xxixxaq
         3KTA==
X-Forwarded-Encrypted: i=1; AJvYcCVPkIBJtl2HmoTxKUhhlI04fbN4z3JtpgB5f6hPtrHQ2ge+H9/CLDYqM4KFhVY5RTh2berHH7RvnVcNm/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRc9LvNb1MPy3UIt6PLKbgRMkniLTfCU7RiptxuVlUeRVX+tx
	Q0yJvu3bE4nT3q8gcrZOdnUvGEZ8A39caVDcIyEhGl0QSNCbpNuB36U7N/5Psbg=
X-Google-Smtp-Source: AGHT+IFj8ImfMPhNSv9EEs/yJTUuM1DWY2QrbI6FBXkkDFb4p797cs0DIA6ld7KbquKZ+djH8ooIQA==
X-Received: by 2002:a17:903:2282:b0:205:5284:e510 with SMTP id d9443c01a7336-2076e551ea0mr261032805ad.1.1726480471230;
        Mon, 16 Sep 2024 02:54:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:32f5:9b56:32d4:8d34:c09a:f2f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc51esm33033895ad.52.2024.09.16.02.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:54:30 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>,
	Matt Gilbride <mattgilbride@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 1/2] rust: kernel: clean up empty `///` lines
Date: Mon, 16 Sep 2024 15:23:39 +0530
Message-ID: <320d4bbc9d6f60964366406c4d9903906f5ab0b7.1726479606.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary empty `///` lines in the rust docs.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1109
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
This is a resubmit because i messed up the message ID's of my previous
submission

Changelog:
v1->v2:
- Fixed typo in commit title and description
- Removed backslashes in kernel::block::mq::Request
- Link to v1: https://lore.kernel.org/rust-for-linux/20240909161749.147076-1-hridesh699@gmail.com/

v2->v3
- Fixed From: tag in patch header
- Link to v2: https://lore.kernel.org/rust-for-linux/aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com/
---
 rust/kernel/block/mq/request.rs | 1 -
 rust/kernel/rbtree.rs           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..313334b1bf18 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -30,7 +30,6 @@
 /// D) Request is owned by driver with more than one `ARef` in existence
 ///    (refcount > 2)
 ///
-///
 /// We need to track A and B to ensure we fail tag to request conversions for
 /// requests that are not owned by the driver.
 ///
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 25eb36fd1cdc..006f6e03aba5 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -1031,7 +1031,6 @@ fn next(&mut self) -> Option<Self::Item> {
 
 /// A memory reservation for a red-black tree node.
 ///
-///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
 /// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
 pub struct RBTreeNodeReservation<K, V> {
-- 
2.46.0


