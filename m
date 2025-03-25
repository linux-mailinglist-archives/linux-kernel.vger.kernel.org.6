Return-Path: <linux-kernel+bounces-576111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC7DA70B13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AE97A71D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F326773C;
	Tue, 25 Mar 2025 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkaE6OuW"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943202676EE;
	Tue, 25 Mar 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933218; cv=none; b=MIW5kCG8r/FneKKSamgys/98Z2+A3WnwbLnearSSFgWw4/IuzOeU0pTOy74c8nW6vPTNnv32sOJ5DsDyEk8SgsHFZidVglHpnC8wXgaA+U/cW4T0fC1uf+a2K1Wot/6h5fR2QY3ZRICRtNpjMQAkM1P3DtHoSs+3aGZ/CrXMfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933218; c=relaxed/simple;
	bh=RBzWSstENQi6Bfk1urvAf45w1RzXiLBP/nSsn0BYsHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIS7pdhAMmb3yoj2yVOrnfhSaBJ7iMApn8/dzuYes6qqq+ZKrJaMRYnQL2voNY1ZvHAh+KARyqpTG59PPKpbB/oWCqxf5QjmmorsAJsNtlt6d+1PjOObRtJUpixnAgOt7guu+zWQXkkrO1YMYwcC7/ehvIw+rsi9mJ3tBrtfKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkaE6OuW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c54a9d3fcaso617181185a.2;
        Tue, 25 Mar 2025 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933215; x=1743538015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYAZ1xJdNGcy0sQryY8wDgfJTKU5qHeO7HWy+ZSRTko=;
        b=EkaE6OuWC/mh4Yh4JdUxX0C0QdcddHHYsjqG8rq6Vv4bXL5UVJ969pDT55IrGLZ2EZ
         UKFjfHM/R/HmfnADKso5+8YFkoA5c9/T06UFAkRbdM4UorJ2lBJuzrqoOkfnXwBGrw7R
         bSWk34X57h7I2xNXiTs1Zv07ojSiA417dT+9f8ArCNgix1tNh4Ho1grbmd1du2PSZzOw
         1XEoxvzZXIaRGQA4gWUytn24d2Z268CkhFVBM7x9rVOpVT5KRndTozYvDwrHokbznQCA
         nRx25ng9dwVJdiqUb+iNA/6AZkHrPhCmFiHLyMGT7ZGAHI3+hiLoEgXRU9qGyVhEvWK/
         dKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933215; x=1743538015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYAZ1xJdNGcy0sQryY8wDgfJTKU5qHeO7HWy+ZSRTko=;
        b=uW3eMYlfPZkAaS7HezdmxY8SNH4NDWyG0oW7aiesk3gKKjfSOUpbFb/HbGCexXM9eI
         aR298+7XCMdQaFfvmZUIXuHz63Fm0DQo71NflQLbl9jufgy7o4I6DwuKngx1W8Iv8Omb
         ffQ3Mi3vROnDA6tss7e1pqiro31sQa8IpK1kooOL5h5nYhS9Ox0NBtTCRm+PYRVkXaKG
         o/hIJqkoi6VLByxuuu4oWf9p1xCnIvEzUoUGEhyIf6ZTmeV3j6tED0DoGHBbCvwnTsNr
         iR0/DGpT8JYsahSzrj/bs0QZn9qfNLXNR5yCzmMQP3VRj1VPAd8wOCOhM7tfjVnkruwA
         v1KA==
X-Forwarded-Encrypted: i=1; AJvYcCVNqbr4IDB1OQMfiwju5g6xMFQ65mtfD1VXdn8q9OGKy2E4UVozyBv4PJdXVBVVKyfYwCuhJowbnR2Y+SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEA3zGntJfI2d6QWZ4l8VOwuriVQoCPCQPGJcf9D1xoMj/SQiB
	UXM+BcETVLeeHQ23oYJqFvZk2GWmONcNVXWCEAhlMCRvdUwoHRjl
X-Gm-Gg: ASbGncs70KYRv1M+d46LSOWyA3szsuBEuO9TjCFyiAZA6gw31xGVU1CEq7uS985zfkg
	1d1/lXJFYNY2eGvcQwXitT/UEbqVZ4xz3APGzjPZ/XEhQD3r36IlJeAuuAp2vva9bkhp+M1bRmi
	F8PfuQs9V3aKlnzqLjhwYA2sqBfYckOnBtZE0qrQDVPHrzo3xRS1jX+waEkppcMeNg/DZijWx59
	5ylII/wkwSQJAqqCxtEyUKqULT9LKAUmxlJdjL+ltLxwvZqPgTSoLWG1W5JJXKwCdDm9UCa6jrp
	j/bWprSyZsGp6bV6FrL/lL1e6at2yRPzIghjVmlcj2FiB3amihmpg0SSGUbN1vBWMRFp21x0SyC
	3/EpBr9di59xKveYExOu5VjskB1bMp39RwuFzsWVaVFytanvR6JPmk1vrhOKPUSft
X-Google-Smtp-Source: AGHT+IH443+8WqT8ReUchRKCpxkuSmYpQyPofizIBWr5Iy5qze0m/jT0WeB79UCEV+bDDs+dij5qlA==
X-Received: by 2002:a05:620a:170d:b0:7c5:6410:3a6 with SMTP id af79cd13be357-7c5ba17d196mr2740909585a.27.1742933215236;
        Tue, 25 Mar 2025 13:06:55 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:54 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:33 -0400
Subject: [PATCH v5 10/13] scripts: generate_rust_analyzer.py: define host
 crates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-10-385e7f1e1e23@gmail.com>
References: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
In-Reply-To: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
 Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Wirth <lukas.wirth@ferrous-systems.com>, 
 Tamir Duberstein <tamird@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev

Define host crates used by the `macros` crate separately from target
crates, now that we can uniquely identify crates with the same name.

This avoids rust-analyzer thinking the host `core` crate has our target
configs applied to it.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/all/CANiq72mw83RmLYeFFoJW6mUUygoyiA_f1ievSC2pmBESsQew+w@mail.gmail.com/
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 09f5f40d689a..ea4dd68d0dd9 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -162,10 +162,16 @@ def generate_crates(
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
+    host_core = append_sysroot_crate("core", deps=[], cfg=[])
+    host_alloc = append_sysroot_crate("alloc", deps=[host_core], cfg=[])
+    host_std = append_sysroot_crate("std", deps=[host_alloc, host_core], cfg=[])
+    host_proc_macro = append_sysroot_crate(
+        "proc_macro",
+        deps=[host_core, host_std],
+        cfg=[],
+    )
+
     core = append_sysroot_crate("core", deps=[], cfg=crates_cfgs["core"])
-    alloc = append_sysroot_crate("alloc", deps=[core], cfg=[])
-    std = append_sysroot_crate("std", deps=[alloc, core], cfg=[])
-    proc_macro = append_sysroot_crate("proc_macro", deps=[core, std], cfg=[])
 
     compiler_builtins = append_crate(
         "compiler_builtins",
@@ -177,7 +183,7 @@ def generate_crates(
     macros = append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        deps=[std, proc_macro],
+        deps=[host_std, host_proc_macro],
         cfg=[],
     )
 

-- 
2.49.0


