Return-Path: <linux-kernel+bounces-572441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1BCA6CA52
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299C54833D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC3235364;
	Sat, 22 Mar 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZjoPbY1"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E93233D9C;
	Sat, 22 Mar 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649849; cv=none; b=AzuE6G8VXHotxsFxQA1kN/KFtXCdT1+vwGRmNKqymeSQnqCtinzQ2BLOt3ly34/rG/P9Ad8tQx8oMrO824cHwhtnITbWKHH6jG/VF14Ssc2wq+pQP5H5TOyslZkOlExPTXSSNt18Ir2T6P0kbZZBpTXxe0y+BjSAz04Xo3LB6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649849; c=relaxed/simple;
	bh=IsZISYkXaWsxWzZj1rMLpmr6Td8PuMuiqOORtOd1umw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Is9NK7o9xavQfNmbW2O1hfA4sqkVugOUGh3n1jsRrvpp9aOTKAn1/XjDiNp1AKIKg2laYxhej64f9M+fAHuz0N3LVsKHiLMXH8FnCUXFHcxNyK4iykh0jP1+O4C8r59bytzDvYuyIj4YBL3670Kl/Ge7IOrerspZZgepD3wxAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZjoPbY1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd01781b56so37755396d6.0;
        Sat, 22 Mar 2025 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649847; x=1743254647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mr6D2UA7pCoLImjVcUbfEdn2wzR9cS/0FKL2QlWd99M=;
        b=RZjoPbY1QdKMYVyxi5arF5KdiYxYV+wTDoUpsBEwwUfqxIn+MnqvxTti0YlqF8bZ2+
         IU7U40u2YOc4RXNkJk6FPUWgimj0vNig2oNdmhcuxxc9N0FT9jMClv8C75gfUFoUNkEr
         Db5t/vmLfF/kVH4uauU3+gloGAFg/WAQiZned5OS/0nU9JLbQWAtK4BTV3Eh8OoGKuVf
         YVrXGOmagxAea4IdnZ8WXH4h2ei1A1EKgg+2RmOF5KGgVsF+JaH4m2DwI+QufL1RDh0S
         BBmZ2tmwfi1dmXu41fkRCShkA4QJ/Nkonr33UZFkCLODEZREIOieq2l3cl3MOVMWaCXf
         nN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649847; x=1743254647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr6D2UA7pCoLImjVcUbfEdn2wzR9cS/0FKL2QlWd99M=;
        b=RVFCJZUQEXarELOmtJuv6QyA1JK7p7Io2OYnKIE6T0sHFOio4jp3/qk2Q6HTqSFykK
         x3pFC1wNK1akorJYK1uoBLJUEoF0WVFPz1kxq/CkRf5mMCm7or0dGhHmt6TXD201wRZR
         Go1ffqVgsCTdXesnIibV/UfJPKgxZIenadH5rJcya/j1dhQKfY+NFQ1DcvIqD3meB1pJ
         mVLLVRBFoQMW8KHuHveeGIlS6KsqbvF48jWvKAeQX8fFMWiaAAMlH7mmvKN9pufG08Lm
         6YzkluBvXZrdS54Pt8M1F0Y8zUItNLwL9Eeg01Cmw94xrqjterWbeGRxCR8HJEHYmZCr
         PZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/+28LsKW+iMMgRXcW6Wqb2l5Vdc2U8Y+6Qfsf62NwSOR/Jp27Jqyg3uU0JPd5QzQJF0PdVEjYSygyK9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwI78grUyn2b6teyfz0fFn5q3gtzCuSK6dQCqHj1iRvlyW6tIF
	GgLvknzGK4/kUSpFoiAVcC22PxkmCiH6qbFrYEIMaHJx/x9M8AfU
X-Gm-Gg: ASbGncuH5Zmc85Be81FBTt0aKX8JeNNs/Ogr3CdLzdHASM9VTFCR98ozs4nABP1yrS3
	tjkrkxxK11LK0HxXvgnXr2oBqW6F28a2oEL/N5Cj4K5i8aPJfudl2EggEn0TrzuEMaEVcNOI1mP
	JW1vu1erwwKmKwrMa2bcWa6gtcC7mYM+PBuytkPN0pz+wbI+6zGdnDbxWdHWW/BPyOmASvWljdr
	UyxnyBq611b7Pl9U0wB9ia3AwgpHIs1kBVplM+2zx6jjOg+I/hTdj6qg0pP2jjsP/jR69hlnnra
	0S07VYB77tjhHaRI0H68knzD+5Xkqxvyf2wWY7o6iberXtyG27HvzMvYYtI8rQ8XaMzJx+2mnt1
	31v6rNk1UqbaywA+Ha+EHjmHLCZ8JzqhH46N4jgnUP8K78aM2Un2OiYHCf8oDtokInueaVwc=
X-Google-Smtp-Source: AGHT+IEQ1JeEO89dAWOuRCIXLuR1S5LG8FJ/6hXCBbGClTRDzxD4H9ykPjmdiWjRS/hD6npa9yFmPw==
X-Received: by 2002:a05:6214:5190:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6eb3f34b715mr82568376d6.34.1742649846515;
        Sat, 22 Mar 2025 06:24:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:24:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:46 -0400
Subject: [PATCH v4 11/11] scripts: generate_rust_analyzer.py: use
 `cfg_groups`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-11-1f51f9c907eb@gmail.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
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

Declare common `cfg`s just once to reduce the size of rust-analyzer.json
from 30619 to 2624 lines.

Link: https://github.com/rust-lang/rust-analyzer/commit/2607c09fddef36da0d6f0a84625db5e20a5ebde3
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 957b413fe0b6..3d89c0198db4 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -37,6 +37,7 @@ class Crate(TypedDict):
     root_module: str
     is_workspace_member: bool
     deps: List[Dependency]
+    cfg_groups: List[str]
     cfg: List[str]
     edition: Literal["2021"]
     env: Dict[str, str]
@@ -59,15 +60,8 @@ def generate_crates(
     sysroot_src: pathlib.Path,
     external_src: pathlib.Path,
     cfgs: List[str],
+    cfg_groups: List[str],
 ) -> List[Crate]:
-    # Generate the configuration list.
-    cfg = []
-    with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
-        for line in fd:
-            line = line.replace("--cfg=", "")
-            line = line.replace("\n", "")
-            cfg.append(line)
-
     # Now fill the crates list.
     crates: List[Crate] = []
     crates_cfgs = args_crates_cfgs(cfgs)
@@ -77,6 +71,7 @@ def generate_crates(
         root_module: pathlib.Path,
         deps: List[Dependency],
         cfg: List[str] = [],
+        cfg_groups: List[str] = [],
         is_workspace_member: bool = True,
     ) -> Crate:
         return {
@@ -85,6 +80,7 @@ def generate_crates(
             "is_workspace_member": is_workspace_member,
             "deps": deps,
             "cfg": cfg,
+            "cfg_groups": cfg_groups,
             "edition": "2021",
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
@@ -101,10 +97,13 @@ def generate_crates(
         root_module: pathlib.Path,
         deps: List[Dependency],
         cfg: List[str] = [],
+        cfg_groups: List[str] = [],
         is_workspace_member: bool = True,
     ) -> Dependency:
         return register_crate(
-            build_crate(display_name, root_module, deps, cfg, is_workspace_member)
+            build_crate(
+                display_name, root_module, deps, cfg, cfg_groups, is_workspace_member
+            )
         )
 
     def append_proc_macro_crate(
@@ -190,7 +189,7 @@ def generate_crates(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
             deps,
-            cfg=cfg,
+            cfg_groups=cfg_groups,
         )
         crate["env"]["OBJTREE"] = str(objtree.resolve(True))
         crate_with_generated: CrateWithGenerated = {
@@ -252,7 +251,7 @@ def generate_crates(
                 name,
                 path,
                 [core, kernel],
-                cfg=cfg,
+                cfg_groups=cfg_groups,
             )
 
     return crates
@@ -277,9 +276,21 @@ def main() -> None:
     # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.
     assert args.sysroot in args.sysroot_src.parents
 
+    # Generate the configuration list.
+    with open(args.objtree / "include" / "generated" / "rustc_cfg") as fd:
+        cfg_groups = {"rustc_cfg": [line.lstrip("--cfg=").rstrip("\n") for line in fd]}
+
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
+        "crates": generate_crates(
+            args.srctree,
+            args.objtree,
+            args.sysroot_src,
+            args.exttree,
+            args.cfgs,
+            list(cfg_groups.keys()),
+        ),
         "sysroot": str(args.sysroot),
+        "cfg_groups": cfg_groups,
     }
 
     json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)

-- 
2.48.1


