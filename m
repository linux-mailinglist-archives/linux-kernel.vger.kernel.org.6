Return-Path: <linux-kernel+bounces-576108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95FA70B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF132179924
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E032676C4;
	Tue, 25 Mar 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS0R1lD9"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641126738A;
	Tue, 25 Mar 2025 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933213; cv=none; b=llY/7/eiHNpFCLkbzAGluYIfvQzgzsBxZcMir/OiXHzhE4iKVTvCaNd9RoDfKPPG2DdtcbBC52X09sogY+bkXaD5veAmKd5FLvKIUlsaFZlDCcuXMRNy8BeWWwq5JWqyN9boptXl8l2rLmCqvtIfshGCH9NBPGQF3Ik6kHJeGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933213; c=relaxed/simple;
	bh=ebtPHwZ+GVCfSptXcqyZkfz0nWoR/X3kCS25EiVslI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuGebZ0ITizikBK5w9MJegMzPT6T90fM1TvYA8PtrwrU1UsVS1XaV5h/en21ddgEa/SXsWpFe0jbyVZrgjXETqLKgEUsaKsrjg2ccXqqChIGyG3xhHPs5j9tz7pCBbV/lPJzZX+YV0OiYgd3gLtFooUtM5X/y1jbsBMVVUNvE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS0R1lD9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5675dec99so693060485a.0;
        Tue, 25 Mar 2025 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933210; x=1743538010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GILICf/GmGXC7cAOU27mwFzz7IQTBsBxwAJi6iuNlx8=;
        b=fS0R1lD9XoP1Q4plunQ7grVgiKDjh83NAwhdR0hCLtkspJB848vkhmb+v1Beoxwf1r
         4kN6i13ELCohkNF4uSb047Vi+H3/W3goC72bgKy61CC3sK+x4rZAnFh4hXS07Fn86bnn
         NGj2KBZoSDjPSdAEKxwk1SO9jdCL5T9CtjgJJhQePmkHLtcXoFM4S/5g2sivrv/9qaw2
         I/dtoFJDFVi2C3rsh8B5isIQORhz0STUOCegnLK8EF5K7DUiplZin3OJto7yzqA0pMnz
         zMImZK+ndw6pYE2wlvkg/THptC1dp0X7QLU6kIFn3nKHMImeQIHrQDidG9bu8IAaQdwg
         aS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933210; x=1743538010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GILICf/GmGXC7cAOU27mwFzz7IQTBsBxwAJi6iuNlx8=;
        b=uCYtMWdVQRdaKLOdZYSFdQNQ2qJRNc8m49E3xSor3/ZT+ooGp6kIm83bB2/NgpxY+C
         6ELjGED8GxgAA26Vvn2n8R2LGuksql2+9zoLIKFYbMmaMWefUf6UIZvuVd8WIbsKG0wX
         zsUd2RJz/S3fI68dmBMl41W8E/EEZiKbTanBIz/gHIjcVRMME5mnyEfQNruaLqYyeYK2
         YilIYw/E29K+YjqRVB5Za/SFypQl+ZRUhhj0K207fgBX5hBzBDBqi7vPFuureJqhZtuw
         1GlMHL0sWDScsFy0b2pJ7Kk+gQ2F4Xy8mvcx1EyN1DUKDGqKB40oW5xsIPwWz8Vcz7BS
         +ofw==
X-Forwarded-Encrypted: i=1; AJvYcCUjQtcSm/d+yiJsyNht3dMZMLUjqvX/FgFns3fIScvuTTDbFcuLJK7oNarw2+1kfIXyxnIC50KBTXB+AGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WntKmuGsEku6OUoL6AYMkpW58fLdmMoPDiPyDf3S9iEf+z7k
	MnJYQMEOK1pccRtmGySBRRUwIdW5i+JR1C4XPaqNr+o07hCdNtdP
X-Gm-Gg: ASbGncvYLNbhaA0jKAC3ATRs4f8i/rI1dgVFN2TY2u6tLr8zsHhEaN2F+i3o+t7vn0K
	Zrk5HFQGRPjlX7Jqx3HB5jDOc5bIfgnZ+xYe+ijxOWCRiDwSZhRx8ea5kSCQFIp+PNOVnQuG/Jg
	miN5FR830jmU1TlFTuRUR6JesU73FUdQ6MZ896Ih6Stl4C9zQkvKjnx+O7iE7DQynLUbHvqNW3Z
	nHefsbe234QgrjjzfhgDieIkFkvS6h5KotFFQMWhM3L5OJzrDEJlGL6ICb7NbiPot4y6AiYhr7Q
	AQ+T45lW+FB1FB3ipiKTktEMQ+J5/qjoigAYJ3GBKWLMYcRQrw42wE8vN5W7cpGmOzyrh7g4PaD
	ztpxSHZzV/9x1QEWAwp4gRhx3Xlb5eX3JRFrPnPjf7Ncz6MS2ILjXxQ==
X-Google-Smtp-Source: AGHT+IHjfvTefR2l1W3iYy9ROnMaHmBd7tbO/5+6xlWxULvpraeTg2vy8ZLDX9t+qVUFEE9xvQ8mGg==
X-Received: by 2002:a05:620a:3904:b0:7c5:3ca5:58fb with SMTP id af79cd13be357-7c5ba12dad6mr2430870785a.4.1742933210426;
        Tue, 25 Mar 2025 13:06:50 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:30 -0400
Subject: [PATCH v5 07/13] scripts: generate_rust_analyzer.py: avoid
 optional arguments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-7-385e7f1e1e23@gmail.com>
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
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Make all arguments required to reduce the probability of incorrect
implicit behavior. Use keyword arguments for clarity.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 90 +++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index b37d8345486a..badcef4126cf 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -69,9 +69,10 @@ def generate_crates(
     def build_crate(
         display_name: str,
         root_module: pathlib.Path,
+        *,
         deps: List[str],
-        cfg: List[str] = [],
-        is_workspace_member: bool = True,
+        cfg: List[str],
+        is_workspace_member: bool,
     ) -> Crate:
         return {
             "display_name": display_name,
@@ -92,21 +93,34 @@ def generate_crates(
     def append_crate(
         display_name: str,
         root_module: pathlib.Path,
+        *,
         deps: List[str],
-        cfg: List[str] = [],
-        is_workspace_member: bool = True,
+        cfg: List[str],
     ) -> None:
         register_crate(
-            build_crate(display_name, root_module, deps, cfg, is_workspace_member)
+            build_crate(
+                display_name,
+                root_module,
+                deps=deps,
+                cfg=cfg,
+                is_workspace_member=True,
+            )
         )
 
     def append_proc_macro_crate(
         display_name: str,
         root_module: pathlib.Path,
+        *,
         deps: List[str],
-        cfg: List[str] = [],
+        cfg: List[str],
     ) -> None:
-        crate = build_crate(display_name, root_module, deps, cfg)
+        crate = build_crate(
+            display_name,
+            root_module,
+            deps=deps,
+            cfg=cfg,
+            is_workspace_member=True,
+        )
         proc_macro_dylib_name = (
             subprocess.check_output(
                 [
@@ -133,66 +147,75 @@ def generate_crates(
 
     def append_sysroot_crate(
         display_name: str,
+        *,
         deps: List[str],
-        cfg: List[str] = [],
+        cfg: List[str],
     ) -> None:
-        append_crate(
-            display_name,
-            sysroot_src / display_name / "src" / "lib.rs",
-            deps,
-            cfg,
-            is_workspace_member=False,
+        register_crate(
+            build_crate(
+                display_name,
+                sysroot_src / display_name / "src" / "lib.rs",
+                deps=deps,
+                cfg=cfg,
+                is_workspace_member=False,
+            )
         )
 
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", [], cfg=crates_cfgs["core"])
-    append_sysroot_crate("alloc", ["core"])
-    append_sysroot_crate("std", ["alloc", "core"])
-    append_sysroot_crate("proc_macro", ["core", "std"])
+    append_sysroot_crate("core", deps=[], cfg=crates_cfgs["core"])
+    append_sysroot_crate("alloc", deps=["core"], cfg=[])
+    append_sysroot_crate("std", deps=["alloc", "core"], cfg=[])
+    append_sysroot_crate("proc_macro", deps=["core", "std"], cfg=[])
 
     append_crate(
         "compiler_builtins",
         srctree / "rust" / "compiler_builtins.rs",
-        [],
+        deps=[],
+        cfg=[],
     )
 
     append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        ["std", "proc_macro"],
+        deps=["std", "proc_macro"],
+        cfg=[],
     )
 
     append_crate(
         "build_error",
         srctree / "rust" / "build_error.rs",
-        ["core", "compiler_builtins"],
+        deps=["core", "compiler_builtins"],
+        cfg=[],
     )
 
     append_proc_macro_crate(
         "pin_init_internal",
         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
-        [],
+        deps=[],
         cfg=["kernel"],
     )
 
     append_crate(
         "pin_init",
         srctree / "rust" / "pin-init" / "src" / "lib.rs",
-        ["core", "pin_init_internal", "macros"],
+        deps=["core", "pin_init_internal", "macros"],
         cfg=["kernel"],
     )
 
     def append_crate_with_generated(
         display_name: str,
+        *,
         deps: List[str],
+        cfg: List[str],
     ) -> None:
         crate = build_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
-            deps,
+            deps=deps,
             cfg=cfg,
+            is_workspace_member=True,
         )
         crate["env"]["OBJTREE"] = str(objtree.resolve(True))
         crate_with_generated: CrateWithGenerated = {
@@ -207,9 +230,20 @@ def generate_crates(
         }
         register_crate(crate_with_generated)
 
-    append_crate_with_generated("bindings", ["core"])
-    append_crate_with_generated("uapi", ["core"])
-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "pin_init", "uapi"])
+    append_crate_with_generated("bindings", deps=["core"], cfg=[])
+    append_crate_with_generated("uapi", deps=["core"], cfg=[])
+    append_crate_with_generated(
+        "kernel",
+        deps=[
+            "core",
+            "macros",
+            "build_error",
+            "bindings",
+            "pin_init",
+            "uapi",
+        ],
+        cfg=[],
+    )
 
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
@@ -239,7 +273,7 @@ def generate_crates(
             append_crate(
                 name,
                 path,
-                ["core", "kernel"],
+                deps=["core", "kernel"],
                 cfg=cfg,
             )
 

-- 
2.49.0


