Return-Path: <linux-kernel+bounces-557127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CAA5D3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF817AF16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CBD13AD38;
	Wed, 12 Mar 2025 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3/ZMoZt"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D318D620;
	Wed, 12 Mar 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742273; cv=none; b=XduTagHrVzlzBqObUFNyv/0amOhp/5fH4+NLO8xG909IDa3NI0Z/NWyMiAo1TNTThgc4IQknG36XflAp988SlQrSQeLjiM5Qq8pVj+O7RNwPEd8wdBHXq6ulhlhYnz0qdMLF4UDZtBn38icZ0/KGl5qRvcmUzzx6DEhkZKwoNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742273; c=relaxed/simple;
	bh=5dDQA5D/gR2vmA0gkSFwao6lTiRWguhvgjQ73yi0p+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVltZXbxNG1gS8HVpHEKN7Dv5GXifGhDBGE6k1mPh95auT6Zy7NhG+JTY49+3VUG8pcHtkitxmRN775TZaFeOqF6fnhiOv4+//Ijf7ru3zmOc+v4HtNzNU86Sl9TqJmObVd7YUXq82An8AIyr2ph9LL+VBMAXxymt7Lc1zPTLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3/ZMoZt; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e1b11859a7so25057546d6.1;
        Tue, 11 Mar 2025 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742271; x=1742347071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2itTq1SSlF79a/hGU5ocuI4Vhx+F2V+KNp8dEd6SR0=;
        b=g3/ZMoZtvsrq6KK36/fWo3LHls0h/NoHGWNuB7sCZusOxvUKZA1tRQOvbM5/tAYykF
         rLhSkWJ8yLyhvTZ3iv4dWVSZEydR+l4XH8f9+vXxowi0EeaymSNgwODrwoVV0MIy8bJx
         qCqwOnZMKszQJ2nnGZ1yfwnxtXd/GCRaUOPBUZ+SsV2Jwc2HaImQTUwDzKLjPI6QMtDm
         yVWxx8pU54aTZvTtL9VMiR+o/2T7V7ysL3y8p9Jgh6AepSN7RAnC3FFNba93ddnA/Zr4
         ZJC0zyN/7uNXDX3gy5AV6lDOtV4uQ/0fcor3dOiQp5UvLLrIGKrdnUTocsRXZoey+A7G
         pVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742271; x=1742347071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2itTq1SSlF79a/hGU5ocuI4Vhx+F2V+KNp8dEd6SR0=;
        b=ons5TRFBvJmvcZNmJUQNiuKjnjhg3w92imBjuib/kA+Y+jZ74DBC+SrV/XQH9v94sp
         Dpx+mMLP81o3Ukzn7NHi7QctmFM40EQ3o1G3cYL5ebkrMBMoWTltWQVJSfuU26wuk3md
         gkegy/SpLVd/8ovNB+PvzxQBgytPdvswDfYql/rGT5UjGN7Vp4WWE8jDl2rJx7DN03KA
         KU9nBPfT8kiiJJIugDwEaIvYd7yjQAO5rNpNZcHKh27Ev5s+GNcW5Q7pMHck6RRCUBtj
         u0iayIJExtOMXlBe2M+W0WOhcz94AwvtrOUrc5jxyk0jIXGk+B55Cf6DC967rUL49uUy
         pUgA==
X-Forwarded-Encrypted: i=1; AJvYcCUtQPOJ4IGXW0Xrc7EQwnskh/VdByRKoABvbw5ihU2Lr6SV51MO/c2olaYx6RgZpb5ay3M/Igs3YmdaQE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjV9WiadRaEXNSR24f1SuKEqDB8LGQh200+xzzJEuGx5JiHiXl
	4FrCDvavObXePxHBkeh2o4q96eXSo58vqDzs28RnwmvuqNSO6csh
X-Gm-Gg: ASbGncs9Y8ROGF6o7a+ewCMJCV73RDTx+xWFNSXGQFs17iAAl9vJU0wzGzh04P3VVwV
	+FZjb/aCCyY3mc0ARY1Q8qG8kkj/WOrVpDprF5ykn130mztrIM0ejCxla3vPGhqjpNHFpTkooDX
	nfmWHP/+5fVOS4yRY7DkW9jUj/JF4U1rumf/FVduBQLx9J7plyk8NyVXUhOvjcpVjPE/7wXhlQ5
	i7Ewzg7Vs3mdisFRKcno3zKBLTygrF6+zvksUO6UwII1LbIRkI5Wy0SHX7coPB+84zD3WXBN5qF
	JLHVVyz1RRROvrib6kYr+GyMcUjNuX+tXA6Mu3DN0+I6/3eK7cyrTqXEOYfn5bycpMdH
X-Google-Smtp-Source: AGHT+IHrAU88zv7Ui2gPgx5uNuZPtI72/BbweNltdl5+vyguKtR6MZtvMg18shtbOcta+Y2wIAC5Zg==
X-Received: by 2002:a05:6214:250e:b0:6e8:f88f:b96b with SMTP id 6a1803df08f44-6e90060157cmr255208806d6.9.1741742270592;
        Tue, 11 Mar 2025 18:17:50 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:25 -0400
Subject: [PATCH v2 4/7] scripts: generate_rust_analyzer.py: add type hints
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-4-30220e116511@gmail.com>
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
In-Reply-To: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
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

Run `uv tool run mypy --strict scripts/generate_rust_analyzer.py` to
verify.

This removes `"is_proc_macro": false` from `rust-project.json` in
exchange for stricter types. This field is interpreted as false if
absent[1] so this doesn't change the behavior of rust-analyzer.

Link: https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49daa1f08404269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 130 ++++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 34 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7e78b926e61f..c73ea8d116a4 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -10,8 +10,10 @@ import os
 import pathlib
 import subprocess
 import sys
+import typing as T
 
-def args_crates_cfgs(cfgs):
+
+def args_crates_cfgs(cfgs: T.Iterable[str]) -> dict[str, list[str]]:
     crates_cfgs = {}
     for cfg in cfgs:
         crate, vals = cfg.split("=", 1)
@@ -19,7 +21,45 @@ def args_crates_cfgs(cfgs):
 
     return crates_cfgs
 
-def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
+
+class Dependency(T.TypedDict):
+    crate: int
+    name: str
+
+
+class Source(T.TypedDict):
+    include_dirs: list[str]
+    exclude_dirs: list[str]
+
+
+class Crate(T.TypedDict):
+    display_name: str
+    root_module: str
+    is_workspace_member: bool
+    deps: list[Dependency]
+    cfg: list[str]
+    edition: T.Literal["2021"]
+    env: dict[str, str]
+
+
+# `T.NotRequired` fields on `Crate` would be better but `T.NotRequired` was added in 3.11.
+class ProcMacroCrate(Crate):
+    is_proc_macro: T.Literal[True]
+    proc_macro_dylib_path: T.Optional[str]  # `pathlib.Path` is not JSON serializable.
+
+
+# `T.NotRequired` fields on `Crate` would be better but `T.NotRequired` was added in 3.11.
+class CrateWithGenerated(Crate):
+    source: T.Optional[Source]
+
+
+def generate_crates(
+    srctree: pathlib.Path,
+    objtree: pathlib.Path,
+    sysroot_src: pathlib.Path,
+    external_src: pathlib.Path,
+    cfgs: list[str],
+) -> list[Crate]:
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -31,37 +71,53 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Now fill the crates list -- dependencies need to come first.
     #
     # Avoid O(n^2) iterations by keeping a map of indexes.
-    crates = []
-    crates_indexes = {}
+    crates: list[Crate] = []
+    crates_indexes: dict[str, int] = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
-        crate = {
+    def append_crate(
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: list[str],
+        cfg: list[str] = [],
+        is_workspace_member: bool = True,
+    ) -> None:
+        crates_indexes[display_name] = len(crates)
+        crates.append({
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
+        })
+
+    def append_proc_macro_crate(
+        display_name: str,
+        root_module: pathlib.Path,
+        deps: list[str],
+        cfg: list[str] = [],
+    ) -> None:
+        append_crate(display_name, root_module, deps, cfg)
+        proc_macro_dylib_name = subprocess.check_output(
+            [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
+            stdin=subprocess.DEVNULL,
+        ).decode('utf-8').strip()
+        crate: ProcMacroCrate = {
+            **crates[-1],
+            "is_proc_macro": True,
+            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
         }
-        if is_proc_macro:
-            proc_macro_dylib_name = subprocess.check_output(
-                [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
-                stdin=subprocess.DEVNULL,
-            ).decode('utf-8').strip()
-            crate["proc_macro_dylib_path"] = f"{objtree}/rust/{proc_macro_dylib_name}"
-        crates_indexes[display_name] = len(crates)
-        crates.append(crate)
+        crates[-1] = crate
 
     def append_sysroot_crate(
-        display_name,
-        deps,
-        cfg=[],
-    ):
+        display_name: str,
+        deps: list[str],
+        cfg: list[str] = [],
+    ) -> None:
         append_crate(
             display_name,
             sysroot_src / display_name / "src" / "lib.rs",
@@ -84,11 +140,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -98,9 +153,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     )
 
     def append_crate_with_generated(
-        display_name,
-        deps,
-    ):
+        display_name: str,
+        deps: list[str],
+    ) -> None:
         append_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
@@ -108,19 +163,23 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
             cfg=cfg,
         )
         crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))
-        crates[-1]["source"] = {
-            "include_dirs": [
-                str(srctree / "rust" / display_name),
-                str(objtree / "rust")
-            ],
-            "exclude_dirs": [],
+        crate: CrateWithGenerated = {
+            **crates[-1],
+            "source": {
+                "include_dirs": [
+                    str(srctree / "rust" / display_name),
+                    str(objtree / "rust")
+                ],
+                "exclude_dirs": [],
+            }
         }
+        crates[-1] = crate
 
     append_crate_with_generated("bindings", ["core"])
     append_crate_with_generated("uapi", ["core"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "uapi"])
 
-    def is_root_crate(build_file, target):
+    def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
             return f"{target}.o" in open(build_file).read()
         except FileNotFoundError:
@@ -129,7 +188,9 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs: T.Iterable[pathlib.Path] = map(
+        lambda dir: srctree / dir, ("samples", "drivers")
+    )
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:
@@ -152,7 +213,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
     return crates
 
-def main():
+
+def main() -> None:
     parser = argparse.ArgumentParser()
     parser.add_argument("--verbose", "-v", action="store_true")
     parser.add_argument("--cfgs", action="append", default=[])

-- 
2.48.1


