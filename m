Return-Path: <linux-kernel+bounces-568984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EAA69D11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53998982FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA813C9B3;
	Thu, 20 Mar 2025 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjipW01U"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165E38F80;
	Thu, 20 Mar 2025 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429255; cv=none; b=drlTXMD2qrYOj6omesPqxD6upwe5iTM0fNSmAly+wn7/G1qyH/DbaaUfLgEDyk1EozMIxTxs+MxLkg5QTq7wyMxZYvtLb2b9QknikYnoM0wvqCcxucZ/EMrv6IGg2W4SYwZiILe9SnNzhHQwM85rKt3o53od5nNgBMnp2LFFJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429255; c=relaxed/simple;
	bh=oGN8Wk0QSuzUvZLSX0ZjlCX/BPvzEYW/2ZyIDTVBcJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJ70vC9qjKWuFA5wilOvFDTes54De98yRCvk/1SXZUldiuzgL9OumTUG5lr8JuSSj6CSTBrT6SJZrd32qiK9kKxV2d1jAjMjH+zoNvXM3JcRdtybwEKmLA+X8djNmoQo72aXCtZ1NCjUIF27g0vHrzk1WZLOPTKYxRr+wcj6aJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjipW01U; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0155af484so42177785a.0;
        Wed, 19 Mar 2025 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429253; x=1743034053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYCnNFx/hoZ+b1U+8ptSo75YBpCJbvb0hAUJiSersVw=;
        b=gjipW01Ux5Rk3Pz40GfqTyyREDbsgiQw7yHMcuYBIUBcoo4qRXNmM6jAYtmYmIypLz
         5BPOsthg1xkoA9ha7WxCl05430C0sQtTOu0DHF7KzmYuA04f73RWRfFqEpkyExdRsokD
         3cDtAnvoIKfJYVrHxMiDdpdvqcNomkgKfWj5JO02nIGrYV6b40ioaqOC4MpZk2uD/2lw
         Tc4KVXEuLv3Ni58LGJ0mg8bJ/sy7fArMNWI8vgWyZlQQCAP7JJdTTzMr5qqBkSyBlyVr
         31xIU7Oa5A/2hVdPMC3QQXm2CuOosF4TXZeWfm/a6jQEQYYoS6UZBo3ifnEqJlyUVKBA
         Hmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429253; x=1743034053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYCnNFx/hoZ+b1U+8ptSo75YBpCJbvb0hAUJiSersVw=;
        b=SOc0pcZJKGT6wPYIsAKI8lNACeCvdQBs/RvWxe+8JyRxxONLS6K1nRq6zl/kQKZorg
         KX4kgEEgMj2cvDhtvHTpk5hP7nTPJYKFLehQv+zyZaFnJyPs+3oYEa6Er4tk3AfqARBn
         qlCmQH9Xulu8aNxkrdCiGwq+inGL3mhek44oQ/8z/vxUyuWPsMISO4r5DkeehpVdChl+
         yMZi2Y49N8etaeI/GSzdhP/o5y4L5mDZqID//v9qB6v26+UYHGeOg1KqMXTEo1IpyR57
         JyPiGGAj7soxsxz4v0n5TB1W5kF1soZnVk/84t5bRvobV6HnXktzsmcBoJEU1mEpDXEz
         cM0w==
X-Forwarded-Encrypted: i=1; AJvYcCXVnre4Jt5FLjMJiUkhCJ+J5rm9CLT+NzjktHbmi8wLvt+oYSfiWmYs+2MgSBRDpUDNg7C4wtstA5H78Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FxskwoqZ4sjOkHsLXbbqKHmMKi3AEhwDm5bLhy+XJ2FITzCk
	eGIHpcXmDCikkG5xfdNFQwcKJHf1Z9w6786K04N0cf8CTmYHLQUQ
X-Gm-Gg: ASbGncvNeJee9unzZhbWFwWP8RsBEpfkhEtLxnqnjk5p1/MViB/5MaVwiLQswcegRFr
	EInK/XgR2IBwIFnt5jcz0Qkm/ctHudShYz9q4dR2kpfIjCHCfur0/+IgmSePi7mPwn19xtMYOTC
	80tgT1Lk0/c6WWny6e8xqfuzdfHPDsJbPDHQoeSNEGo/gdJ2GWuP4XDOcfLoSMOOF3BR9KmbXMv
	HHZPoPYnGmYu2sONbmxR0SFUhnwx3pZiNv/K/PddpiurwZ1iQhEO4moYRCUV6DeQCph/P74ASGl
	aky4WtE4nMUPpEklMv4ZAKytnk/vAxm4dd8RQgH6PdZvyhwWSL/1cb9L/7yGLz5TKjz3rnUgBah
	DfOVI6yMRU7k=
X-Google-Smtp-Source: AGHT+IEU+pULH927uGSZUmpYynbi9yxev0DNyzuiY17Zeia4qFbvLVX2Fg7EQmzz5BGRhFWnjEk2aA==
X-Received: by 2002:a05:620a:24c2:b0:7c5:7a03:8467 with SMTP id af79cd13be357-7c5a84ba7c9mr720824685a.55.1742429252636;
        Wed, 19 Mar 2025 17:07:32 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:31 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:22 -0400
Subject: [PATCH v3 6/7] scripts: generate_rust_analyzer.py: identify crates
 explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-6-311644ee23d2@gmail.com>
References: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
In-Reply-To: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
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

Use the return of `append_crate` to declare dependency on that crate.
This allows multiple crates with the same display_name be defined, which
we'll use to define host crates separately from target crates.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 70 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 21224fc9be8f..adba72eb1910 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -68,21 +68,19 @@ def generate_crates(
             line = line.replace("\n", "")
             cfg.append(line)
 
-    # Now fill the crates list -- dependencies need to come first.
-    #
-    # Avoid O(n^2) iterations by keeping a map of indexes.
+    # Now fill the crates list.
     crates: List[Crate] = []
-    crates_indexes: Dict[str, int] = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def register_crate(crate: Crate) -> None:
-        crates_indexes[crate["display_name"]] = len(crates)
+    def register_crate(crate: Crate) -> Dependency:
+        index = len(crates)
         crates.append(crate)
+        return {"crate": index, "name": crate["display_name"]}
 
     def build_crate(
         display_name: str,
         root_module: pathlib.Path,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str] = [],
         is_workspace_member: bool = True,
     ) -> Crate:
@@ -90,7 +88,7 @@ def generate_crates(
             "display_name": display_name,
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
-            "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
+            "deps": deps,
             "cfg": cfg,
             "edition": "2021",
             "env": {
@@ -101,20 +99,20 @@ def generate_crates(
     def append_crate(
         display_name: str,
         root_module: pathlib.Path,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str] = [],
         is_workspace_member: bool = True,
-    ) -> None:
-        register_crate(
+    ) -> Dependency:
+        return register_crate(
             build_crate(display_name, root_module, deps, cfg, is_workspace_member)
         )
 
     def append_proc_macro_crate(
         display_name: str,
         root_module: pathlib.Path,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str] = [],
-    ) -> None:
+    ) -> Dependency:
         crate = build_crate(display_name, root_module, deps, cfg)
         proc_macro_dylib_name = subprocess.check_output(
             [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
@@ -125,14 +123,14 @@ def generate_crates(
             "is_proc_macro": True,
             "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
         }
-        register_crate(proc_macro_crate)
+        return register_crate(proc_macro_crate)
 
     def append_sysroot_crate(
         display_name: str,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str] = [],
-    ) -> None:
-        register_crate(
+    ) -> Dependency:
+        return register_crate(
             build_crate(
                 display_name,
                 sysroot_src / display_name / "src" / "lib.rs",
@@ -145,47 +143,47 @@ def generate_crates(
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
-    append_sysroot_crate("alloc", ["core"])
-    append_sysroot_crate("std", ["alloc", "core"])
-    append_sysroot_crate("proc_macro", ["core", "std"])
+    core = append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
+    alloc = append_sysroot_crate("alloc", [core])
+    std = append_sysroot_crate("std", [alloc, core])
+    proc_macro = append_sysroot_crate("proc_macro", [core, std])
 
-    append_crate(
+    compiler_builtins = append_crate(
         "compiler_builtins",
         srctree / "rust" / "compiler_builtins.rs",
         [],
     )
 
-    append_proc_macro_crate(
+    macros = append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        ["std", "proc_macro"],
+        [std, proc_macro],
     )
 
-    append_crate(
+    build_error = append_crate(
         "build_error",
         srctree / "rust" / "build_error.rs",
-        ["core", "compiler_builtins"],
+        [core, compiler_builtins],
     )
 
-    append_proc_macro_crate(
+    pin_init_internal = append_proc_macro_crate(
         "pin_init_internal",
         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
         [],
         cfg=["kernel"],
     )
 
-    append_crate(
+    pin_init = append_crate(
         "pin_init",
         srctree / "rust" / "pin-init" / "src" / "lib.rs",
-        ["core", "pin_init_internal", "macros"],
+        [core, pin_init_internal, macros],
         cfg=["kernel"],
     )
 
     def append_crate_with_generated(
         display_name: str,
-        deps: List[str],
-    ) -> None:
+        deps: List[Dependency],
+    ) -> Dependency:
         crate = build_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
@@ -203,11 +201,11 @@ def generate_crates(
                 "exclude_dirs": [],
             }
         }
-        register_crate(crate_with_generate)
+        return register_crate(crate_with_generate)
 
-    append_crate_with_generated("bindings", ["core"])
-    append_crate_with_generated("uapi", ["core"])
-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "pin_init", "uapi"])
+    bindings = append_crate_with_generated("bindings", [core])
+    uapi = append_crate_with_generated("uapi", [core])
+    kernel = append_crate_with_generated("kernel", [core, macros, build_error, bindings, pin_init, uapi])
 
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
@@ -237,7 +235,7 @@ def generate_crates(
             append_crate(
                 name,
                 path,
-                ["core", "kernel"],
+                [core, kernel],
                 cfg=cfg,
             )
 

-- 
2.48.1


