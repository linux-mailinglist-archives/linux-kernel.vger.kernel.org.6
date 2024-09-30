Return-Path: <linux-kernel+bounces-343264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359409898C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD00C1F218D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24705684;
	Mon, 30 Sep 2024 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipWowmfK"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C8383;
	Mon, 30 Sep 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727658676; cv=none; b=RqBddz4Qo3eaoRACbn/x+lDoO3Kq+23UG9O/LAmur8bPGGKRDvgXefJOCjbtMmQsyBATzqkWWxIaFOBdEzMi9Jk7Gqgn+UGS3lO7ckxzqX49HG0jDZvDMRwolAgIYGsajCTkA9IOeHmJrg0dNpp+TEuJOMSsGVivL/Rdrc01siI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727658676; c=relaxed/simple;
	bh=KCmptHGyLnCzPpQNXWEcq7JMgjBKFRG+QCCVWwICfSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vp625KGxuGahiw7qpiw9SnUr/dWfYJHJAHtFw8LxrQJyKO6qdjjOMLZbePAY00goT+libFeOu6H5EeYvoN4NiTUZGCeQ7YDri1K62/F4DjC5mAG+h4crM1ibtzPTniRjNvoMtQ/gL4iXAYo/gdCmoQr5iB3+N7ygRP8YnF5mAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipWowmfK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so4977219a12.3;
        Sun, 29 Sep 2024 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727658673; x=1728263473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BeYuF7N8M1F/C8P4GndUFn3y/clkOx7utFNr66Yhz+g=;
        b=ipWowmfKPNYipVNlDevF7gOywNsqyrzV5AaJ/nfXEXgvD83I5qDYvwuszQNjI87dNp
         6dvtMO5icqhZNSx5NeHC1jJbcUT1sa4kK7Fpmnee59jgmGzCuOvyDm3HaBM3O/RbtB+/
         bEZ7YV3fT9zjMAh0xKMT1W+hlvj40sAHXM2mnYLMjiH/dw5qJM0V3bQVqrfCBCKjmTjr
         Dp5EinpIfzWrpvVl85VOdM4QvmdtUbFu/v7wapOaG0xcDNsnucKQi3eCXMVaoA+TmwyA
         3oTm8RtVpww0HTVsxq7KHLfNFU+mbUTwNRGhVeGzMTTi4IK0X7BIR62E4WwBO3MEjHKI
         k8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727658673; x=1728263473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeYuF7N8M1F/C8P4GndUFn3y/clkOx7utFNr66Yhz+g=;
        b=jayWCzeQVZs4MeGeptxgw7FERN3YzV1TXjJO3xEwW7w0D0pPd9xFnRw4PXFpNs6sXk
         zPgMRgcQwTK9B24M/uVlRk0pELo3xZ829eQoDgmVVwgntRiMlOD+hZ5sJHvuXNQr014O
         di3KuVHFuVK/KeREzOuWK710aLaiQtVfb3zJcwFHwDrrZ5e1FSVDdodLBO7YR+jCQw2g
         92ScjqNS6EmqD8I4Hxv9OliDO1wFkdBHW+3jely2JVrDFMtnUIbrE8uoJ0IUbWvOAucf
         kS3DHL2GFWj7FLKSbYVG3vNDn04XKB4q9Ext9qz0xeY6Y9vXdqcSJ98D6J/hJh5pQY2F
         IFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfJFjW5sXsnLOLSTN3o5Fv33fJbrviwo6LgvOR6pZ4jvo6I1Pku0AZnabPxDQ1+Y0Trlr663LFIsAzQ70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY45weyOUuWVc9MM8LrWvdQJdvcNmwG/7xoMJlKVoZ1XMyr4DX
	FlPkbc9JcSNV3t4/nBBYGQvMm7ALjtD6eA9plREsx5kV33e17ZLh
X-Google-Smtp-Source: AGHT+IFcbq0CXgyfkJAWl9hmlux6QUXtX5tuZuWXb/a3wj0evg151ROUunlppn1WUge0p4Bqxb6voQ==
X-Received: by 2002:a05:6402:3813:b0:5c5:c0ef:282c with SMTP id 4fb4d7f45d1cf-5c8824d5f37mr10345997a12.11.1727658672785;
        Sun, 29 Sep 2024 18:11:12 -0700 (PDT)
Received: from localhost.localdomain ([79.115.63.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a38asm3827414a12.22.2024.09.29.18.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 18:11:12 -0700 (PDT)
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tudor Gheorghiu <tudor.reda@gmail.com>
Subject: [PATCH] rust: re-order exports to fix rustfmt
Date: Mon, 30 Sep 2024 04:09:32 +0300
Message-ID: <20240930010931.64080-2-tudor.reda@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent rust-6.12 tag merge at 570172569238, the rbtree export was
added after the sizes export, thus breaking rustfmt's alphabetical
export ordering rules.

Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
---
 rust/kernel/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..b5f4b3ce6b48 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,8 +44,8 @@
 pub mod page;
 pub mod prelude;
 pub mod print;
-pub mod sizes;
 pub mod rbtree;
+pub mod sizes;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
-- 
2.43.0


