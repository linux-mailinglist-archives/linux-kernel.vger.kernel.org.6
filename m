Return-Path: <linux-kernel+bounces-568982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C4A69D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351579819B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF92D023;
	Thu, 20 Mar 2025 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrcQHDqH"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B42746D;
	Thu, 20 Mar 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429251; cv=none; b=a8jCRAiGuRGvDUQJlVt+mjUJo12pYAM2K6h7TJALZZAtRsP6kYl+zmMcaJZyv8wzx/XeMnlKGejKo0Qqj3aWtlRVkW6Tu24p+m7AjoNsTwbA7LL075N9lSiTnGOle7WCRjqU4J+qrpv68geKNWIfC+04hTFKEwtNYjiyewcbzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429251; c=relaxed/simple;
	bh=FBxTtZFW3hnfmV1C2faDwaZce5xiCpM6iYPbXPLQVu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3aUcdPdq1z/52/V/7ptaJBSkmljOyPucShiFYnb8bGX/DbEBdS9ArKvnQ7UxCvIuaifcMi1Je7MHyYl3nYxY5FKY3UX4Ly/x/FC0lcaz+97vbGukbAe2RwdMlIiffnHk4aPT6vb8izSIKH5cvAweKiHiBSuVNjMyurthLbueuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrcQHDqH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be49f6b331so31294485a.1;
        Wed, 19 Mar 2025 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429249; x=1743034049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHldQUDM00I2wpKSXVz5wINhGZ3fVuD/p194QdoLPOc=;
        b=JrcQHDqHxvgcmSVkZxluKqHGBl1uZ+NGcwbPluvHIwQHSwKaxsPGIY9dl0fn3U3ZVN
         uOzzvlQdWks4DxBI5j8w4/ECg5UwSprWa9w/2yVLqMYFChJUfzZWYCBEWC0d6f/GY4Z0
         xx1zAomP9K41unMd+Nrz2FRxqune5M1+d7VSduOvulS7+kpeBgAQu6bJ7IERKqQzVKc1
         mT21S4rc9LUI63voth1RVQY5jbyFz6WPTaBX4JwWyQcTLLI5Lzb6/3MEGbY8F0GRNguI
         YCR5YmLxm1YAO3AdE4MRt1bp4VU9VJD4JEJEwgPc2EZw60f3uzcM5rr+ArdWLPRguuVr
         G+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429249; x=1743034049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHldQUDM00I2wpKSXVz5wINhGZ3fVuD/p194QdoLPOc=;
        b=f0anctSqL9sn6p+ZdUuHx427XvNv6ogCCLcwpYRx3PlfeUGrIPcNGMIYlVgCrz+Jfl
         pgo5GIf7uD08OiCcTFT+Agu0GO11jjkLiTJQov2AbfTIo9m64q4H7FMe0PxN047A7piL
         TndRAZddhCIFpRFly7ZOMDZUtJ0sgZC54kIaKDcxGHzWklR/Mf/GRrVp7K2/Tnj5vIWD
         NPGx89BaUOmOJgGu/2z6z1aeAc/Lk9RNDlSIQx296T5uuT+HWuo7fsnygckoAMklqQht
         H6wVQlu5OGDJc47Yq4EHoRLbdS3yfCw60HKHF/9BAAIg/MHqZc7c8O3npfmBo7a/IBym
         55YA==
X-Forwarded-Encrypted: i=1; AJvYcCUSOwRPECbADqLzdkybiizR4nPdIxPYlzIJv96JYW5YCH66iKPuUFBjszktUbi+Dx7s7Pj8vdEKo+P2cFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoE/PZs4MeSGoTwcL1LeeYuCGNoOt1umqy+Jh76ACUVPdulM5z
	blaZGDUMm3DS7vpkjP0r3Pk4CYemjTnFLZyAotHkB/q24kbis9yS
X-Gm-Gg: ASbGncuSkXZtm5oLByTZM+jZ1AB1LDSGs/+lPG/xUzGLd8uos/UJgHiY1V45noBDsYb
	CLmHuB+8QVUaQW1EguMicP3xXvv6vCR37IbfeOdKLXhN3ME6T7PbL01ZECqmzeyFcB1qpAa6msQ
	zoAu0voXWXnHEOozBNgYnwnY67N+5QeVEq1w8mYKPh6gXdW3NUdtOoWIQXo9sHVCtDrB4ThoeN5
	bJAKGtytia/8KB6Z2ABKmi9EfrTL9jHMPAhd1YAPVJW2wds1fkJYnqsoskrtP3QpON9hZ1EePzs
	paGKNZ6lC85oDefHa8rgKa+fg+LfLDgg2OvRu5m8cuyvuRgg/OoHXOd8LZDSXcReAgScDLUZb/c
	Eql15Yk8UIOR+qFrXq/KkwA==
X-Google-Smtp-Source: AGHT+IFXJgxWh9cBY0AAuS/tYGb7JJx7FEptDVvadgjj9OK5yszD7/oOSDn0VEWA3hPXNhxFh7nT0w==
X-Received: by 2002:a05:620a:2943:b0:7c5:3c0a:ab7a with SMTP id af79cd13be357-7c5a839812dmr580387385a.3.1742429248679;
        Wed, 19 Mar 2025 17:07:28 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:27 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:20 -0400
Subject: [PATCH v3 4/7] scripts: generate_rust_analyzer.py: add type hints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-4-311644ee23d2@gmail.com>
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

Python type hints allow static analysis tools like mypy to detect type
errors during development, improving the developer experience.

Python type hints have been present in the kernel since 2019 at the
latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers for
running KUnit tests").

Run `mypy --strict scripts/generate_rust_analyzer.py --python-version
3.8` to verify. Note that `mypy` no longer supports python < 3.8.

This removes `"is_proc_macro": false` from `rust-project.json` in
exchange for stricter types. This field is interpreted as false if
absent[1] so this doesn't change the behavior of rust-analyzer.

Link: https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49daa1f08404269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 165 ++++++++++++++++++++++++++++----------
 1 file changed, 121 insertions(+), 44 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index e997d923268d..c6f8ed9a5bdb 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -10,8 +10,10 @@ import os
 import pathlib
 import subprocess
 import sys
+from typing import Dict, Iterable, List, Literal, Optional, TypedDict
 
-def args_crates_cfgs(cfgs):
+
+def args_crates_cfgs(cfgs: Iterable[str]) -> Dict[str, List[str]]:
     crates_cfgs = {}
     for cfg in cfgs:
         crate, vals = cfg.split("=", 1)
@@ -19,7 +21,45 @@ def args_crates_cfgs(cfgs):
 
     return crates_cfgs
 
-def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
+
+class Dependency(TypedDict):
+    crate: int
+    name: str
+
+
+class Source(TypedDict):
+    include_dirs: List[str]
+    exclude_dirs: List[str]
+
+
+class Crate(TypedDict):
+    display_name: str
+    root_module: str
+    is_workspace_member: bool
+    deps: List[Dependency]
+    cfg: List[str]
+    edition: Literal["2021"]
+    env: Dict[str, str]
+
+
+# `NotRequired` fields on `Crate` would be better but `NotRequired` was added in 3.11.
+class ProcMacroCrate(Crate):
+    is_proc_macro: Literal[True]
+    proc_macro_dylib_path: Optional[str]  # `pathlib.Path` is not JSON serializable.
+
+
+# `NotRequired` fields on `Crate` would be better but `NotRequired` was added in 3.11.
+class CrateWithGenerated(Crate):
+    source: Optional[Source]
+
+
+def generate_crates(
+    srctree: pathlib.Path,
+    objtree: pathlib.Path,
+    sysroot_src: pathlib.Path,
+    external_src: pathlib.Path,
+    cfgs: List[str],
+) -> List[Crate]:
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -31,43 +71,75 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Now fill the crates list -- dependencies need to come first.
     #
     # Avoid O(n^2) iterations by keeping a map of indexes.
-    crates = []
-    crates_indexes = {}
+    crates: List[Crate] = []
+    crates_indexes: Dict[str, int] = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
-        crate = {
+    def register_crate(crate: Crate) -> None:
+        crates_indexes[crate["display_name"]] = len(crates)
+        crates.append(crate)
+
+    def build_crate(
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+        is_workspace_member: bool = True,
+    ) -> Crate:
+        return {
             "display_name": display_name,
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
-            "is_proc_macro": is_proc_macro,
             "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
             "cfg": cfg,
             "edition": "2021",
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
-            }
+            },
         }
-        if is_proc_macro:
-            proc_macro_dylib_name = subprocess.check_output(
-                [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
-                stdin=subprocess.DEVNULL,
-            ).decode('utf-8').strip()
-            crate["proc_macro_dylib_path"] = f"{objtree}/rust/{proc_macro_dylib_name}"
-        crates_indexes[display_name] = len(crates)
-        crates.append(crate)
+
+    def append_crate(
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+        is_workspace_member: bool = True,
+    ) -> None:
+        register_crate(
+            build_crate(display_name, root_module, deps, cfg, is_workspace_member)
+        )
+
+    def append_proc_macro_crate(
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+    ) -> None:
+        crate = build_crate(display_name, root_module, deps, cfg)
+        proc_macro_dylib_name = subprocess.check_output(
+            [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
+            stdin=subprocess.DEVNULL,
+        ).decode('utf-8').strip()
+        proc_macro_crate: ProcMacroCrate = {
+            **crate,
+            "is_proc_macro": True,
+            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
+        }
+        register_crate(proc_macro_crate)
 
     def append_sysroot_crate(
-        display_name,
-        deps,
-        cfg=[],
-    ):
-        append_crate(
-            display_name,
-            sysroot_src / display_name / "src" / "lib.rs",
-            deps,
-            cfg,
-            is_workspace_member=False,
+        display_name: str,
+        deps: List[str],
+        cfg: List[str] = [],
+    ) -> None:
+        register_crate(
+            build_crate(
+                display_name,
+                sysroot_src / display_name / "src" / "lib.rs",
+                deps,
+                cfg,
+                is_workspace_member=False,
+            )
         )
 
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
@@ -84,11 +156,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         [],
     )
 
-    append_crate(
+    append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
         ["std", "proc_macro"],
-        is_proc_macro=True,
     )
 
     append_crate(
@@ -97,12 +168,11 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         ["core", "compiler_builtins"],
     )
 
-    append_crate(
+    append_proc_macro_crate(
         "pin_init_internal",
         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
         [],
         cfg=["kernel"],
-        is_proc_macro=True,
     )
 
     append_crate(
@@ -113,29 +183,33 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     )
 
     def append_crate_with_generated(
-        display_name,
-        deps,
-    ):
-        append_crate(
+        display_name: str,
+        deps: List[str],
+    ) -> None:
+        crate = build_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
             deps,
             cfg=cfg,
         )
-        crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))
-        crates[-1]["source"] = {
-            "include_dirs": [
-                str(srctree / "rust" / display_name),
-                str(objtree / "rust")
-            ],
-            "exclude_dirs": [],
+        crate["env"]["OBJTREE"] = str(objtree.resolve(True))
+        crate_with_generate: CrateWithGenerated = {
+            **crate,
+            "source": {
+                "include_dirs": [
+                    str(srctree / "rust" / display_name),
+                    str(objtree / "rust")
+                ],
+                "exclude_dirs": [],
+            }
         }
+        register_crate(crate_with_generate)
 
     append_crate_with_generated("bindings", ["core"])
     append_crate_with_generated("uapi", ["core"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "pin_init", "uapi"])
 
-    def is_root_crate(build_file, target):
+    def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
             return f"{target}.o" in open(build_file).read()
         except FileNotFoundError:
@@ -144,7 +218,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs: Iterable[pathlib.Path] = map(
+        lambda dir: srctree / dir, ("samples", "drivers")
+    )
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:
@@ -167,7 +243,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
     return crates
 
-def main():
+
+def main() -> None:
     parser = argparse.ArgumentParser()
     parser.add_argument("--verbose", "-v", action="store_true")
     parser.add_argument("--cfgs", action="append", default=[])

-- 
2.48.1


