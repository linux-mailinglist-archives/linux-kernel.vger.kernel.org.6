Return-Path: <linux-kernel+bounces-572435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD43A6CA4B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD291484258
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCEF230264;
	Sat, 22 Mar 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcZVCrno"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403A22E405;
	Sat, 22 Mar 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649839; cv=none; b=sLeZuZMtK+QVbvC39Pkhv+R7VU8ji4RuAcyJZycpHuxPvTsWL7jUrg9x18EBSG9hxHwY5RulYhohOrMV0yPjuthKKEazUh2Lx6HPugNDsyLBeIEoT5kx+Qp8sADh88a1OJ1T10QEmAK3nLbQUA9Pn6Jba7fRnOirODXLvOiri3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649839; c=relaxed/simple;
	bh=GzN1O1OZVxkS6J5KKKrp50uOqLklPj2D6hXqktxCzdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vA69txteNyfpXg5hCwgZbjHlTmz2bJF7zbx13gt5XZw8me4c10XdSgBXB4i0BgrYriIU82xuxGRV5s1sr1ZTC8ZTMwlOJ7ScRXsi48BNl9MrPAJEhwUluIVjTstqHqq0eXgSY1eMqEb+1c2nbPsOg60eiA+GcwPp0JcX15PQVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcZVCrno; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e91d323346so30164546d6.1;
        Sat, 22 Mar 2025 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649837; x=1743254637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVR1ZFr+6EziU4ZSyNLPZRf/7K5j6b8LM6+DIZzsEQY=;
        b=GcZVCrnoTvIK3ZcfRFUrkdQya/Es1Rt6xqHu4wI8cx4qyz+yAR6zmsSuBXxDUuH0CK
         GNGCyFDbCycacHkxLjP7oKvgAcjJNDxCu9ZA4Pp21mDWdpXMaLSUnHKp2Pbp5rXDDlCn
         u4wTn75bTDKtiKRWaTusWAxhROcPenRLiev9JmifIODj/+yJbwWhOwB6ZnCLLYKwUXyS
         uUPZtxU7Z/epvifCeWuW+uUTpMmKLyMyDQq9PYqF3yHz9cAAaTuT4lulTv9aj5n65sAX
         lhC0fYJ7D17qNcpiIkwafdTKo5oFDi2ggbgHbmmbxsaS48LPkHkQwd/giDydFVj2cA88
         X00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649837; x=1743254637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVR1ZFr+6EziU4ZSyNLPZRf/7K5j6b8LM6+DIZzsEQY=;
        b=COPaeh/jb69t7qEat35vVHndz+9a31+ygX2U+SgPS7KIieBIwxNn4gfol3T6b+VfHs
         r8PueYGP61oQxKCV3MNnBXcMvSRj0cRhop+3p0p1+dzh8NytZsSTKtCFDUuybCmY+xl0
         a720vNkA4s7kVpKJLgYipAR23IjuBsC+52OtdL993yafuL1EAUyQx/FsfWYj6PM/GNej
         UhzVuTNXKlONiVJc2wxbWlSClXyJ43zmF+zMCp4XBIDz3eT6GKIZCU3dXgzRBH9FyVER
         E/v4q2CmoSNWRb4YUIiSOboyDQ7rJRqRq0wUOEZDKElge+Nr2Ey+Ma2i+YAdmYMNU/H2
         bZFg==
X-Forwarded-Encrypted: i=1; AJvYcCXj4SniCpm51O37RDWt7bIh2wkeIOLLnm8K5vv2Q9hfT5SxllgSlbYTXsp7MBJ0SJS707DsR2BnhOOuVqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWj7ajqJxKELQwTsnjB5gQEdKu4iehx3COjzUeVS9WvH8SacP
	DzYUgBpOOYGWJqfLWX3wdNQLEnQKxD5nJNK4umR2p3VBMDqZqmUa
X-Gm-Gg: ASbGncugrfjJrbAuWWm/PGl6zKmfMjT21r46lGOQfy16P2qibBliJtTEWwM61Mqc+Tt
	bjP/QGDqcvFbpSHzPVZDc1H8f2GPI3gPkjs5EFa02x9lwoaE/NfbZCpVla0y86kVF1FPn/L8OVS
	Na7h437u5rXfURb1ZpuDXUXMFkoF2ILArfnJGmy3v/PVGJ8QxS+rELpvfkZrZecFVOR3Y4jk5BB
	ViFIxw4r86hdWwQVyhGr1lLyRDFU7IwRAOdNWztik45skXTRVUdLwBGkeHXfbu0a6j0lPP/xSZV
	HZXysNVQ2v1mRfOtdjLeWgzhtZ7bJKRDC85xc33h40QuLm20Dz6i3OIGNUQbGkoEaze+KM+Cr9x
	qYjBhelKBIxxztwDwvNBkEWhmQp4tAS12MkT2vgLZm1YIS5ntX3SZK8tRXeF/muADcw5XepM=
X-Google-Smtp-Source: AGHT+IFwDw9IEPqxJI2hfi1NlJNGawjCUXyq5p/jAa3ydOZJXkIeMr0zGuzIMDXV//Ruy5IQ9ksO1w==
X-Received: by 2002:a05:6214:21c6:b0:6e2:3761:71b0 with SMTP id 6a1803df08f44-6eb3f090126mr142836556d6.5.1742649836683;
        Sat, 22 Mar 2025 06:23:56 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:40 -0400
Subject: [PATCH v4 05/11] scripts: generate_rust_analyzer.py: add type
 hints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-5-1f51f9c907eb@gmail.com>
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
 scripts/generate_rust_analyzer.py | 172 +++++++++++++++++++++++++-------------
 1 file changed, 112 insertions(+), 60 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 03f55cce673c..0772ea309f94 100755
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
@@ -31,67 +71,75 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Now fill the crates list -- dependencies need to come first.
     #
     # Avoid O(n^2) iterations by keeping a map of indexes.
-    crates = []
-    crates_indexes = {}
+    crates: List[Crate] = []
+    crates_indexes: Dict[str, int] = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
     def build_crate(
-        display_name,
-        root_module,
-        deps,
-        cfg=[],
-        is_workspace_member=True,
-        is_proc_macro=False,
-    ):
-        crate = {
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
-        return crate
-
-    def register_crate(crate):
+
+    def register_crate(crate: Crate) -> None:
         crates_indexes[crate["display_name"]] = len(crates)
         crates.append(crate)
 
     def append_crate(
-        display_name,
-        root_module,
-        deps,
-        cfg=[],
-        is_workspace_member=True,
-        is_proc_macro=False,
-    ):
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+        is_workspace_member: bool = True,
+    ) -> None:
         register_crate(
-            build_crate(
-                display_name, root_module, deps, cfg, is_workspace_member, is_proc_macro
-            )
+            build_crate(display_name, root_module, deps, cfg, is_workspace_member)
         )
 
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
+
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
@@ -108,11 +156,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -121,12 +168,11 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -137,9 +183,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     )
 
     def append_crate_with_generated(
-        display_name,
-        deps,
-    ):
+        display_name: str,
+        deps: List[str],
+    ) -> None:
         crate = build_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
@@ -147,20 +193,23 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             cfg=cfg,
         )
         crate["env"]["OBJTREE"] = str(objtree.resolve(True))
-        crate["source"] = {
-            "include_dirs": [
-                str(srctree / "rust" / display_name),
-                str(objtree / "rust")
-            ],
-            "exclude_dirs": [],
+        crate_with_generated: CrateWithGenerated = {
+            **crate,
+            "source": {
+                "include_dirs": [
+                    str(srctree / "rust" / display_name),
+                    str(objtree / "rust")
+                ],
+                "exclude_dirs": [],
+            }
         }
-        register_crate(crate)
+        register_crate(crate_with_generated)
 
     append_crate_with_generated("bindings", ["core"])
     append_crate_with_generated("uapi", ["core"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "pin_init", "uapi"])
 
-    def is_root_crate(build_file, target):
+    def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
             return f"{target}.o" in open(build_file).read()
         except FileNotFoundError:
@@ -169,7 +218,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -192,7 +243,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
     return crates
 
-def main():
+
+def main() -> None:
     parser = argparse.ArgumentParser()
     parser.add_argument("--verbose", "-v", action="store_true")
     parser.add_argument("--cfgs", action="append", default=[])

-- 
2.48.1


