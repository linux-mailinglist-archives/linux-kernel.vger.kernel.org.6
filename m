Return-Path: <linux-kernel+bounces-325438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A91A9759A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10BBB21A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966231B531E;
	Wed, 11 Sep 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDg9HVjM"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4F1B14E9;
	Wed, 11 Sep 2024 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076703; cv=none; b=mzQCobNoHOk7Jg+L9FOcfmEJf2p2rtCneeNHmCq3ohAi2LA4nuFPEDzbKNbIItoA02moiN4l3tG36v/L1E0xg8B5MGG2pRCHIu6ggXzOLyYIRkZpzah+jrurYZy5Y0qjruBkZ5/m9sgd9FavVsmzQCzQh8bjYz2Xgwe0tyg6eN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076703; c=relaxed/simple;
	bh=TbW8BA3pPZWFNwR/X0Dv4nBrxgv1Q6MIxvreUyGeHug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TH3NwYJhDBCpoqw10JOnG9FM2rJkjwZac7HjINvY0viGRZg0v8AusTS+oI9SN44voh7mFsqOYOqlda7EYm31mJtmEZzddHa79VTb7Ffhg3hULxx4X7z8/bV0Wto7TH2zZyeftNjjkuFrGN+pr4SIfNIcrIVOm2sL7QHXFLl3HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDg9HVjM; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277c861d9f6so23003fac.2;
        Wed, 11 Sep 2024 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076700; x=1726681500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCDlqprQU1MXDrIEDsYYK+QCUoEJu4FljwareiIlSZ4=;
        b=VDg9HVjMg33L/yjMFWmN4zZECMKf2+UzfmVh+OGsHTPPKFFecKHJ+mAQPYH6308dRm
         mSi+KI2KIDFhrcktXyz9F2nFfkmH/HG+tX9bjA23O0oSYjVuiCCBsJB/iAdbzs+QIENT
         BeZiWyvQhKCcsaZDM9A1SmCuMNhs9IJ0nFSGlwdxPBQedxlAn47q7TNxWiTjNqr6IAKA
         uUKdipkSUYRZJ+b7ZirDGHpIYtUS9UA5qV4KTUM9yOoCCYpLfgvqKF8gqHM6m9ozVfyl
         5MmElsgdPq/msKEwkkMw3er2srAJ3D8mgRrca8TOKZSdrFTzu5s6KZRMf/cMTApPKfph
         RPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076700; x=1726681500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCDlqprQU1MXDrIEDsYYK+QCUoEJu4FljwareiIlSZ4=;
        b=NoabWhY5hShmvhriePlTwojZkz2AfCbb5ScSGS6BAJ0wVtsCktHKmt5faSRCWOOFYx
         4G3CDCCOVPVwvT6eGpAJxtJzrpD3KMZXgqNqWV8WQ2/d5ZTk03V2vHvf9rCTNEhvnb5h
         lylSTOGO0kvXVxZJ9Z4o//sJr+rmW/F9wD6h/FWQ6BfFt55391oV5aHALc/3x4rUE7EW
         lJ7odE0+UeyuYKBdVkyj+yyfhTQNF8CHhBseH5hU+Vjh6X+6zwVppyqmh6KU5HvQ0cAe
         MMHRuAUFsvgBszSW2r16HYzP/7uO9cGEe4pQM/uJ0EjJx9lKMjPlIbIHom/YqI/ZoG5n
         rh3A==
X-Forwarded-Encrypted: i=1; AJvYcCX1woSK7OtXSyYm8r+6NblV4OVezOW//Wz2LaAQDOeFw3DH8V5daaVyMWcKh1SDLVzCqXPMkc8fNe28e3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuIq0POJHnE7qD6C8Kvsf5kZC5tiBastdqW3Loew8EBOvwgY3
	z/TLcC280Od5/PXOsHXLkRn5poMioPGVXRXTS/KWfPWK/TWg7N5C6FiS1Klt9kA=
X-Google-Smtp-Source: AGHT+IHnR43nZDnDuNOU/I1dhqIbSL8hLO+jx8yGzchjbPaZoMlsLSe2znUuNJMS4ukg2V45bEYuHw==
X-Received: by 2002:a05:6870:fbac:b0:261:86d:89e2 with SMTP id 586e51a60fabf-27c3f639028mr19654fac.36.1726076700305;
        Wed, 11 Sep 2024 10:45:00 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b0347sm3351588b3a.149.2024.09.11.10.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:44:59 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hridesh <hridesh699@gmail.com>,
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
Subject: [PATCH v2 1/2] rust: kernel: clean up empty `///` lines
Date: Wed, 11 Sep 2024 23:14:34 +0530
Message-ID: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: hridesh <hridesh699@gmail.com>

Remove unnecessary empty `///` lines in the rust docs.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1109
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
Changes in v2:
- Fixed typo in commit title and description
- Removed backslashes in kernel::block::mq::Request
- Link to v1: https://lore.kernel.org/rust-for-linux/20240909161749.147076-1-hridesh699@gmail.com/

Huge thanks to Benno Lossin and Miguel Ojeda for taking the time to
review my first patch
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


