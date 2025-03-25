Return-Path: <linux-kernel+bounces-576107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65820A70B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74507A36AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA9266B4F;
	Tue, 25 Mar 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiAza2ll"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF3266EEA;
	Tue, 25 Mar 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933211; cv=none; b=X4CXio0/lOhfqVZTtvMgp3r9/Io8VXC63qhWTJfsNgmNZpX9AnChmXP4rJXbP/UtlTuMqvTZRpnKFVc0bGZik2laHZLbDhiigJ6pmra7OyUXpJaY8gKiB780KIZl9IMG12rwDKbeiRz3stkscbBBFnAZiJq/3eGDYoCGBHO9txQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933211; c=relaxed/simple;
	bh=lXmqA9anHKTSoe1zlD8Xwv6drrykSkTGnniucaRciUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+djlsGR87kWy2bKSHEp6q4o01AKuZ4E6m+wRjsvD92q2TvRjzdayiDeW1jsrPWCxIyG6H+laH3Izmlqv6jGgDb3ZMfdItxsq4hF90/cgyqUJ/4lkmfNXaKlZ763mkS0M7fbYnHI4d4Tag/7wjj5wIT+qqyAUX5CX2OeKiBBwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiAza2ll; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5e2fe5f17so62129685a.3;
        Tue, 25 Mar 2025 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933209; x=1743538009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEQMSjdAkTIZsUdv1kJ2QW49ePUr1CWJlJbYkFudVcM=;
        b=ZiAza2llm4hpAygxnfllRCtGnJ2PPtNVUKxJDMipoTFfC1M1ciaB+IFP4bHXW227Us
         EPNRMU9mteSR3wmyOx7qA9RV+Hk3tcXtM1JOX1xtBRFYgNgczBX8iW3JPoHGuUwt25M9
         8SPibiEWlZ0fWQXTwWS7HTqv/KgDoRpdrWqDrWBq9NHOnDyaRIdSyKWNeUPLGwq9G1Vc
         rRnjm7h6WI8a1joZDmy5alrfJG3Az39cDwTZlApW1IQ6G88mZahmfNFaUzLmia2K7JLj
         RqaL2OAITK2wblqnQVFrfVmdW97m4XQYOKDBWBXzXWSRrwBddNRu1MZ1hcGlzVRkdw8h
         wIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933209; x=1743538009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEQMSjdAkTIZsUdv1kJ2QW49ePUr1CWJlJbYkFudVcM=;
        b=aBT94WTHfd1WNMRm1qhENUmu8ZbOMjXPpHPfDBJXrNCojZl6Y/3tPQ400yv9N599IZ
         ySOImHMoq+ONF0dGfavIipRDtm3e/hO1M3cs2AF48cuQKiOVEw+4rX907/Htbao65YKS
         BCYH4HeEHbOBv2KwuhP/ZyfvnPJ19biCBXiULRQ1MppItQft1+yN/5lYYgj7rWT/DTgU
         mgSXt1HcbEOfLKgSKiwq3j9ztTfwoFGMngioRBcD2pY/n+M0giJe+qkCcc/EgxnF6PBW
         TVm+6pOyhwPqH4KU+rYtqLDMhidg9xQip/LjAvXUjD1oYDeVXdMIZ8/XSnLE8ZZgnsLy
         10Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUen13XY7andrJokfENGW3q5xDjEdqn3ap5LEalMv1KeM81Z6iwozQUfiKPN1sIA5AKO6gTderl6aNu3gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQymQzziQgm53LTfrXIE7alGUER/ZgbJ2PuhKby+DIQvpNLx6V
	odSNhGpA67aDKKSkCX+v4vmK/3RVAH3pztpt3QEAE0aItFkSgF8A
X-Gm-Gg: ASbGncumv8faVOLZJfD6N640lJtQW9G/FE5VBthDOx20N1JNzWwkUCEmx5S55pRcP1f
	qSCAJOB2jIPbiUK4Y6th8gbY3h47kpHs7bK38eukFLugdeSILIisNGEA4+Z6qIrdlzuI5Sh+w0n
	W0XZD5MgnjE+RUXhEtrfVLzS40VEwMtCzhCGi+Nw/4WfshaxypEr+7MgwWeC/Vc5lzu6Z0Oq0dQ
	JHogaHP6mPg4QcBOZ/Hg6oKRwiGWug09iqsC0NbuqX0/A3R/sXgYCoLGNbqETTalOZ7BIExAOCf
	BZKyiYb40lMYTq6NOVAhVdoSwIIALBdn19pa4XXHXHnGFyavtiGbl0E7+GzLmA2/sH4jnfXAerF
	6rOFuBFGMSg3Tcka5OoE7B2+tD+QBvrLXq7Qjj4vTMMexBc4l7CEwTw==
X-Google-Smtp-Source: AGHT+IEFrbdGak8/7rQkPHipEN8c6DlSzJtZtT+ott4qAtk0Z+awOg49u+jmZjSzWgCVDOZr7YS3WA==
X-Received: by 2002:a05:620a:3711:b0:7c5:5cc4:ca5b with SMTP id af79cd13be357-7c5ba13a67emr2257081885a.12.1742933208677;
        Tue, 25 Mar 2025 13:06:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:29 -0400
Subject: [PATCH v5 06/13] scripts: generate_rust_analyzer.py: add type
 hints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-6-385e7f1e1e23@gmail.com>
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

Python type hints allow static analysis tools like mypy to detect type
errors during development, improving the developer experience.

Python type hints have been present in the kernel since 2019 at the
latest; see commit 6ebf5866f2e8 ("kunit: tool: add Python wrappers for
running KUnit tests").

Add a subclass of `argparse.Namespace` to get type checking on the CLI
arguments. Move parsing of `cfg` out of `generate_crates` to reduce the
number of variables in scope with `cfg` in their name. Use a defaultdict
to avoid `.get("key", [])`.

Run `mypy --strict scripts/generate_rust_analyzer.py --python-version
3.8` to verify. Note that `mypy` no longer supports python < 3.8.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 166 +++++++++++++++++++++++++-------------
 1 file changed, 109 insertions(+), 57 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 80eb21c0d082..b37d8345486a 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -10,16 +10,48 @@ import os
 import pathlib
 import subprocess
 import sys
+from collections import defaultdict
+from typing import DefaultDict, Dict, Iterable, List, Literal, Optional, TypedDict
 
-def args_crates_cfgs(cfgs):
-    crates_cfgs = {}
-    for cfg in cfgs:
-        crate, vals = cfg.split("=", 1)
-        crates_cfgs[crate] = vals.replace("--cfg", "").split()
 
-    return crates_cfgs
+class Dependency(TypedDict):
+    crate: int
+    name: str
 
-def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
+    crates_cfgs: DefaultDict[str, List[str]],
+) -> List[Crate]:
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -31,17 +63,16 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Now fill the crates list -- dependencies need to come first.
     #
     # Avoid O(n^2) iterations by keeping a map of indexes.
-    crates = []
-    crates_indexes = {}
-    crates_cfgs = args_crates_cfgs(cfgs)
+    crates: List[Crate] = []
+    crates_indexes: Dict[str, int] = {}
 
     def build_crate(
-        display_name,
-        root_module,
-        deps,
-        cfg=[],
-        is_workspace_member=True,
-    ):
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+        is_workspace_member: bool = True,
+    ) -> Crate:
         return {
             "display_name": display_name,
             "root_module": str(root_module),
@@ -51,36 +82,30 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             "edition": "2021",
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
-            }
+            },
         }
 
-    def register_crate(crate):
+    def register_crate(crate: Crate) -> None:
         crates_indexes[crate["display_name"]] = len(crates)
         crates.append(crate)
 
     def append_crate(
-        display_name,
-        root_module,
-        deps,
-        cfg=[],
-        is_workspace_member=True,
-    ):
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+        is_workspace_member: bool = True,
+    ) -> None:
         register_crate(
-            build_crate(
-                display_name,
-                root_module,
-                deps,
-                cfg,
-                is_workspace_member,
-            )
+            build_crate(display_name, root_module, deps, cfg, is_workspace_member)
         )
 
     def append_proc_macro_crate(
-        display_name,
-        root_module,
-        deps,
-        cfg=[],
-    ):
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: List[str],
+        cfg: List[str] = [],
+    ) -> None:
         crate = build_crate(display_name, root_module, deps, cfg)
         proc_macro_dylib_name = (
             subprocess.check_output(
@@ -99,7 +124,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             .decode("utf-8")
             .strip()
         )
-        proc_macro_crate = {
+        proc_macro_crate: ProcMacroCrate = {
             **crate,
             "is_proc_macro": True,
             "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
@@ -107,10 +132,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         register_crate(proc_macro_crate)
 
     def append_sysroot_crate(
-        display_name,
-        deps,
-        cfg=[],
-    ):
+        display_name: str,
+        deps: List[str],
+        cfg: List[str] = [],
+    ) -> None:
         append_crate(
             display_name,
             sysroot_src / display_name / "src" / "lib.rs",
@@ -122,7 +147,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
+    append_sysroot_crate("core", [], cfg=crates_cfgs["core"])
     append_sysroot_crate("alloc", ["core"])
     append_sysroot_crate("std", ["alloc", "core"])
     append_sysroot_crate("proc_macro", ["core", "std"])
@@ -160,9 +185,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -170,20 +195,23 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -192,7 +220,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -216,7 +246,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     return crates
 
 
-def main():
+def main() -> None:
     parser = argparse.ArgumentParser()
     parser.add_argument("--verbose", "-v", action="store_true")
     parser.add_argument("--cfgs", action="append", default=[])
@@ -225,7 +255,17 @@ def main():
     parser.add_argument("sysroot", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
     parser.add_argument("exttree", type=pathlib.Path, nargs="?")
-    args = parser.parse_args()
+
+    class Args(argparse.Namespace):
+        verbose: bool
+        cfgs: List[str]
+        srctree: pathlib.Path
+        objtree: pathlib.Path
+        sysroot: pathlib.Path
+        sysroot_src: pathlib.Path
+        exttree: pathlib.Path
+
+    args = parser.parse_args(namespace=Args())
 
     logging.basicConfig(
         format="[%(asctime)s] [%(levelname)s] %(message)s",
@@ -236,7 +276,19 @@ def main():
     assert args.sysroot in args.sysroot_src.parents
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
+        "crates": generate_crates(
+            args.srctree,
+            args.objtree,
+            args.sysroot_src,
+            args.exttree,
+            defaultdict(
+                list,
+                {
+                    crate: vals.lstrip("--cfg").split()
+                    for crate, vals in map(lambda cfg: cfg.split("=", 1), args.cfgs)
+                },
+            ),
+        ),
         "sysroot": str(args.sysroot),
     }
 

-- 
2.49.0


