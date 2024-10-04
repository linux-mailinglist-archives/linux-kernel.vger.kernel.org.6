Return-Path: <linux-kernel+bounces-350334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676799039B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28F51F23AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54521212EE5;
	Fri,  4 Oct 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASL8XIJ8"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FEF210193;
	Fri,  4 Oct 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047339; cv=none; b=r12xdydWzB/ZYYH/kQImAwp4hk0Uk8Uh9o1Jc+SBESIEu4tLzwC/7k37+esuHIF5T7JKV7nUug2DgGMDf/5V/mPvUSOF2gsX+GQo97dV/vKDr4u7yv8xgyDaUqGEmPfxqabT2hfve8upvqwlAdR+AZIIy2cMS2BNxoyAwO3hBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047339; c=relaxed/simple;
	bh=jKeMftI0t24Y3FyOjhvfPzai/IDr3bRuUly9gQ/dVBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZN6Gz2mZyPBEHlMk0EqSqeyG5GqKud0DLVGXbMl8B/iOi4CHjQAm0RnnkAMWL9/6MHYpFiIfGYW1nMWy4nj0/fhhOPUEl2IQjid2Nzt4YSnIzdt757Kt4af4KYD0nTRHtFfL7VmI6eR4U+XWwwj+Arll5e7vQpCuAUmcgcp5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASL8XIJ8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso2566273a12.1;
        Fri, 04 Oct 2024 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728047336; x=1728652136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPtXqlbK/VkxukpQETyuGIq0PzYdYHFs7b27gg7Hb1k=;
        b=ASL8XIJ8uwPQFZ3sq3KjACsrW6R8LvhKgelnRWfbuhFVFXfGWGUwvXv0yyRq3QqWda
         KW+7RGW2nImiIm0hQJnMKjK+hSLr/2X3nvH/o8f1W+8yroTfdColIAlLyBw4yOIc/80g
         44l1ExpXjI0mTeqKspK51EM19PXBbeKPT28orFYjUrh+met1bYjqNiV/B3qZk01nO1C2
         kOo5O0onk2q/Jo1tGpaJuwDe6NWciH46rhJ9nAent50Gy6SB4p2AWVyURylaId+54Soc
         pwQsm49kuVLoseLKeXcfBYV6wbnrfMUIRt+hotNxsxfOilKCa1FBNEoj8jchX9GwTQaK
         5AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047336; x=1728652136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPtXqlbK/VkxukpQETyuGIq0PzYdYHFs7b27gg7Hb1k=;
        b=LVEum8goCroJ40jtezZWVCfu2mePJwoXfVaoYYe7o389TSUggNsE9QLVsmSsIKZSDC
         2na/xtlDmApLgGjJJAZ5cEDrVpZ+8X30ORTxUdRY/nzUvu4IgJeWpxHWNKNsSZqkCTyw
         oocq272skrHfd7BdtaFUMWxFMDPcj422NgUyB26NFr8Wo5ONmdut7w2kwHJP+mFSC5BE
         /LVlHT6VRVYE06vJId7LqAw8m7cmmsLpzI/6FH/G7nfb2KgbQj/MGq6R20WE4FsXOE3T
         /fLQZAccz6DUqQSeo5yS6UYTHKA7LHeunrMYXGE1bW9vQ9CP8OLTRINX1AggV6VJ5WwL
         hGwg==
X-Forwarded-Encrypted: i=1; AJvYcCWIp68eijB4EH8s+13CBCAadlNDCZQELEFjaXeOQbzuQizAZNACXc4Y5uetNbL7btg8JuTeWpNcTUQ66R0=@vger.kernel.org, AJvYcCWcNOUG9AOGt37H7Mc3RC+tV0Pza9LY3ndERk37rzHx5yVk3zCwwjUFhrAy1Ljk6Ozd3g0x3BTZvg6Tc9fFclU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssF1wS/0lcU+aql2wocXeH2Du3M9Ru+wNmJ2QGB/DSf/Sn8ec
	EDQ3A5pnzv2revdQl/3fNmfCvOtaQwsh3R6DpalqnYUGqCmBOc8+
X-Google-Smtp-Source: AGHT+IHI7D0jFQ+ERLu2vKRSh5+LJi5qG7FlTHM2oG7fSOODAKvyOJAebYJVzcz9cSCWPW4zbZPUng==
X-Received: by 2002:a17:907:f7a2:b0:a8a:8c4c:3e2a with SMTP id a640c23a62f3a-a991bd40b99mr221430866b.23.1728047335959;
        Fri, 04 Oct 2024 06:08:55 -0700 (PDT)
Received: from mbp-deepak.lan (89-69-93-57.dynamic.chello.pl. [89.69.93.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b376csm222210166b.104.2024.10.04.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:08:55 -0700 (PDT)
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
	Filipe Xavier <felipe_life@live.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: std_vendor: update dbg macro from rust upstream
Date: Fri,  4 Oct 2024 14:56:16 +0200
Message-Id: <20241004125616.49886-1-iapain@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`dbg!` contain adapted code from rust upstream.
Compare code with rust upstream and update missing column
numbers in `dbg!` outputs. Column numbers are not copied
but adjusted for examples in docstring.

Thus update the docstring only.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1124
Signed-off-by: Deepak Thukral <iapain@gmail.com>
---
Changelog:
v1->v2
- Adjusted line numbers which were affected by changes to macro.
- Recompare `dbg!` macro with rust upstream. No other changes required.
- Better commit message.
- Link to v1: https://lore.kernel.org/rust-for-linux/20241003221536.34826-1-iapain@gmail.com/
---
 rust/kernel/std_vendor.rs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
index 8f27d447a..279bd3536 100644
--- a/rust/kernel/std_vendor.rs
+++ b/rust/kernel/std_vendor.rs
@@ -18,7 +18,7 @@
 /// let a = 2;
 /// # #[expect(clippy::disallowed_macros)]
 /// let b = dbg!(a * 2) + 1;
-/// //      ^-- prints: [src/main.rs:2] a * 2 = 4
+/// //      ^-- prints: [src/main.rs:3:9] a * 2 = 4
 /// assert_eq!(b, 5);
 /// ```
 ///
@@ -67,7 +67,7 @@
 /// This prints to the kernel log:
 ///
 /// ```text,ignore
-/// [src/main.rs:4] n.checked_sub(4) = None
+/// [src/main.rs:3:8] n.checked_sub(4) = None
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


