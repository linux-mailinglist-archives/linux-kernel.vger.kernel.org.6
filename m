Return-Path: <linux-kernel+bounces-329473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF09791CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198721F2265C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028611D0162;
	Sat, 14 Sep 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kexdtymY"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA11179BF;
	Sat, 14 Sep 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726327483; cv=none; b=G9nQhrv7N6ZbyopBd38R3yHnqrGrwfIr+DbQmhtC8fN9HQfS6b/hAVjKh6OupoUTCzpLqgYvwBv3O57aAMYNXleGHASsMso/y31phKZLkC1TNvU5PH9R0eaPlYsY6ukjHMbmArg/SY5Sk1iAeGKfokN4KzEMp5GUdqc4XaGA02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726327483; c=relaxed/simple;
	bh=XH4wATtWKF0ZYff8d0I087AsZeb7jWX73vCvHPrfJeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLJVacnhmoEiqCDketi+OIhTjr1lmdBvlZursWj9keUw1yW74otz39zkTjq7u6VlXxLicESdXAn/ZpvvTDQLJEZU1nuiiLU+ckJzaz4blagvxHndeo7TvhvRm9beNj36BSdZVO0SPLy7qeSj8UKIYMxpbMGajLTa7onhSMDlVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kexdtymY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7194cca5811so136057b3a.2;
        Sat, 14 Sep 2024 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726327480; x=1726932280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAMIU1m6LPxllGBza1C1k0JH1NzgetJ/PWI5pWinO6k=;
        b=kexdtymYwjJU5hbjLE5mdhEl6hMxHwrSmqnUi7p225NqjCIjByFKvgOFU6q90O+685
         or6H3XgzYq+tlcKvCKyqgZAsFMrBjCE945SwL84rPQq7mSU5X3eHf6pdIt1aPNjrnEjy
         svApWrlcFUHxdW4j6CmTFqQR4UDDlYzI/6Hl4A71teFmEelxOOU19+8yljEp3IPBMvSv
         taYP5s7GVk5n5Rmd6cwgJfFpxkz+hrtj4Ja6Xl5c1ScaWvr8r1l4EEfKs1rDn9ZdS08i
         KrdzajTxdZ1EE8yBzhmnae2C7uGXgYuH9i73y5LcEb0e/6mgjAkezOj5S5iHHGlaeJql
         JmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726327480; x=1726932280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAMIU1m6LPxllGBza1C1k0JH1NzgetJ/PWI5pWinO6k=;
        b=MySZ9U6OFUgL4FM6zEZ/gDDPhH+OOW4ziQvxvSWdTVBdGkC0zDcns2k9AZM8wxX6D/
         yhUBDxU+gIiNJRkd3MZ9einvrm1e/KnfRquvggCzrIGftXX2hKZ3mgi1x15VLcPjnK6+
         +Di3spoU5radFhYMbH/rYo5I2jfy85y3F9gi0GgAwGWzTW96Gk3gt7lTpPbiN+MflpHa
         MoXQMDy0v4zp17+zwQ/AYHJZF6eSn1dW61fMYHZlT0ucDTxnesBhWPCyuKb9fkBL5dkF
         6F2xmb791xAt8M7mzB7uKZlO0uZakRUwXZ/anEyePi7eInHrfohYRTWI4Tp1fqco2Q1I
         oaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVigspzi537roQOGA+D1kF+yV265dLr0vnn6F43i7WTuHiFGUhZRnB9X6Dpyq5A9zvomf6TlLs6mzRfg+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYucFjFxEdEgyedeJAZn9352nSB/TOO9ZrdYRJmC9uQGSOCeXH
	n36qPsoDEPZydgPXCSezT8pYq8Z/2pxaknbaMb3mItNGPLu3XSQcJsMe4UoSAzQ=
X-Google-Smtp-Source: AGHT+IGWOby1/ejDWcpNM8xIE2IO//05pxY6HBLgjMUJy9wj8F3S3O7vR3ty1jzGZP87h1yrg6bRlQ==
X-Received: by 2002:a05:6a00:2382:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-71936b1d2edmr10233602b3a.24.1726327480282;
        Sat, 14 Sep 2024 08:24:40 -0700 (PDT)
Received: from Hridesh-ArchLinux.domain.name ([117.193.94.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b301sm1103898b3a.107.2024.09.14.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 08:24:39 -0700 (PDT)
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
Date: Sat, 14 Sep 2024 20:54:28 +0530
Message-ID: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
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
Changes in v2:
- Fixed typo in commit title and description
- Removed backslashes in kernel::block::mq::Request
- Link to v1: https://lore.kernel.org/rust-for-linux/20240909161749.147076-1-hridesh699@gmail.com/

Changes in v3:
- Fixed From: tag in patch header
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


