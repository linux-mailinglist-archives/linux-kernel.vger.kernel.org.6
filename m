Return-Path: <linux-kernel+bounces-576110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BAAA70B14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1755416B59E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265926771B;
	Tue, 25 Mar 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fazSW0rp"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C02676CD;
	Tue, 25 Mar 2025 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933217; cv=none; b=PLgGQV2r9LlwSWuuIVBl0H+5l4zzLtP4IFNJMagcPjwWhC2mue/9A+IQUrMYYJFIJ9avGCsLX0QeQfz/YM4gyt8dYbAlMTmyCOrAqiXPB4WiPBe6mfTkq8/5A7dxFC8HDvFZVvusweTmbbLt/Te15UN68tkQEa5qgykAWt/NaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933217; c=relaxed/simple;
	bh=YmEbadE53ReAEuEXh1/yk+JAUrNyRmVHbVXOaydk3do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+ss1olAwLrcKKfF8YP/T8ison7t4snOZ4mT0ClEMuyBcAuHC5z2CdPMuwOSXDeq7N7Y2BK+DhJgwqfbTkYzWzUr6Jguaz9Ww7pc3gOicMBoO3n4TQJbgzqAAM56WLqiJaWzKQkE1Sb0Zj7UGhn5ZOjFROCMEWzs8vszyBW8X/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fazSW0rp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be49f6b331so639657585a.1;
        Tue, 25 Mar 2025 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933214; x=1743538014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iHo+OkdI8fs/jzP2iLx1d3vgSX05pc7a0bPZVGbUd4=;
        b=fazSW0rpRd9SjsKRHHX64iOjJV1n/82pS5cqOj/0alGIL0D+EiKRt6y7gek26cZ+UX
         TF5PMtQvx8MaC8ShWR0CROtcsTeJDpRJS07InrHb7vrfRMAzPbxQQTQvTkm4IvrTmNvf
         cunX7kizc3/YwoYbK/9EI1mM/xW3reBoW6dCfce4vcKCTV8P0k6t9lP7C3+AlEQJ2mjt
         GKxrxGDmS46YJsTuN+reqvvp8QiXjhcwhvZ9yTRjon5v8utEULkEgx173Fzf0EcEL+ZO
         V3yj2mX1o/8b31MKIv3Atx6/U//7Wp7PsYJMYInze2TeXRjB65EvAi/AC6Ul2yMjOv7g
         3HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933214; x=1743538014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iHo+OkdI8fs/jzP2iLx1d3vgSX05pc7a0bPZVGbUd4=;
        b=c8JTgvZftuVVdjlsLkM08IeZP/wIcIsdv9ufGSr8gGckq+yQpge5XFGbZi5bjyDG+2
         aDAOjU2KgUtHell9khEHR2ygah/Lqacm2FBHJCBntv7zomMIGb2JxfA0AHxewITvzkUN
         Pq+Dw11kJQbrD/+PlKL0r15I5n8hDtIVdEUSoJccucruyREcZbBO1shnYtP7stzsllVT
         1R0bgGaXLhSTc21mfwj5a3w0JTbVUdCSYsZ/w4DGw1xm9v+fMC4vb1Qr76TWF3fzusgv
         +lzBrPtpLW4FLkMhFGJrJljhoZrTO54Z7dxWXxetU/Ebc/0C09zTDhK9Erw3Qa0zOE2s
         WNww==
X-Forwarded-Encrypted: i=1; AJvYcCVh/DKyMdBSAKU02l0lNSVUDuvjaGo0uDN86Q75l/fuLuWy6rNCJzpZt2Qr9JFYk1zsfpdR14sSbNwYgP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+gFtDitMvosujZ7+zm5oR2W8rXJC/6dSG9uVBY4j8IQa0fUr
	Dd1zcLcNdKfI1PZ7HuBs0dMxBWI59RcuaHrOL44Mg5vZpzkL6VG7
X-Gm-Gg: ASbGncvCzZqKPkWjkimBnpZKgogYrFouEClD1WHUkonQ7MjIm8AjxVQ+30qx9+kgZmR
	+GEi9e01u1y6XHG0YigiHaoGqYSXS4eSxvPb7/xgJImBYjOs/0PX9fMxqtOt3daCZu3g716kkxn
	qtZ51WQk76YF6HI9xQvAmOFh3uNslGblzm/5MhIPUXGTOFEspDNp1kN8CYgrip85SYCRHRxUM+5
	OSJeKQ7cZva20DFcfCpWziHNjNW3KQwMyO/ScreDWexkgqQY+b7u7ZqLN+4/ocZ2sjx+nZMRjOa
	Gm85nbMuiT3Vul1YuCkqjypREomBOpR9sl6E2xGw26nKKwpuRKcvPDCnfies3nxXje9tvG/yDV0
	sZtIds4wkjaT+dv5PWN/qd5bybfKT/FDWEAD1zkQwK8qPdDT8QF+dhQ==
X-Google-Smtp-Source: AGHT+IE4yOHKa1umQRwrz6yze/V10itte4cij43CyRjrCWX1aOQcHN53zHH4CvJCW6v2JaGk4wwPjw==
X-Received: by 2002:a05:620a:8328:b0:7c5:d959:b97 with SMTP id af79cd13be357-7c5d9590bd3mr648329685a.55.1742933213972;
        Tue, 25 Mar 2025 13:06:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:32 -0400
Subject: [PATCH v5 09/13] scripts: generate_rust_analyzer.py: identify
 crates explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-9-385e7f1e1e23@gmail.com>
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

Use the return of `append_crate` to declare dependency on that crate.
This allows multiple crates with the same display_name be defined, which
we'll use to define host crates separately from target crates.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 82 +++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 5370563688eb..09f5f40d689a 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -60,17 +60,14 @@ def generate_crates(
             line = line.replace("\n", "")
             cfg.append(line)
 
-    # Now fill the crates list -- dependencies need to come first.
-    #
-    # Avoid O(n^2) iterations by keeping a map of indexes.
+    # Now fill the crates list.
     crates: List[Crate] = []
-    crates_indexes: Dict[str, int] = {}
 
     def build_crate(
         display_name: str,
         root_module: pathlib.Path,
         *,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str],
         is_workspace_member: bool,
     ) -> Crate:
@@ -78,7 +75,7 @@ def generate_crates(
             "display_name": display_name,
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
-            "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
+            "deps": deps,
             "cfg": cfg,
             "edition": "2021",
             "env": {
@@ -86,18 +83,19 @@ def generate_crates(
             },
         }
 
-    def register_crate(crate: Crate) -> None:
-        crates_indexes[crate["display_name"]] = len(crates)
+    def register_crate(crate: Crate) -> Dependency:
+        index = len(crates)
         crates.append(crate)
+        return {"crate": index, "name": crate["display_name"]}
 
     def append_crate(
         display_name: str,
         root_module: pathlib.Path,
         *,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str],
-    ) -> None:
-        register_crate(
+    ) -> Dependency:
+        return register_crate(
             build_crate(
                 display_name,
                 root_module,
@@ -111,9 +109,9 @@ def generate_crates(
         display_name: str,
         root_module: pathlib.Path,
         *,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str],
-    ) -> None:
+    ) -> Dependency:
         crate = build_crate(
             display_name,
             root_module,
@@ -143,15 +141,15 @@ def generate_crates(
             "is_proc_macro": True,
             "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
         }
-        register_crate(proc_macro_crate)
+        return register_crate(proc_macro_crate)
 
     def append_sysroot_crate(
         display_name: str,
         *,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str],
-    ) -> None:
-        register_crate(
+    ) -> Dependency:
+        return register_crate(
             build_crate(
                 display_name,
                 sysroot_src / display_name / "src" / "lib.rs",
@@ -164,52 +162,52 @@ def generate_crates(
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
-    append_sysroot_crate("core", deps=[], cfg=crates_cfgs["core"])
-    append_sysroot_crate("alloc", deps=["core"], cfg=[])
-    append_sysroot_crate("std", deps=["alloc", "core"], cfg=[])
-    append_sysroot_crate("proc_macro", deps=["core", "std"], cfg=[])
+    core = append_sysroot_crate("core", deps=[], cfg=crates_cfgs["core"])
+    alloc = append_sysroot_crate("alloc", deps=[core], cfg=[])
+    std = append_sysroot_crate("std", deps=[alloc, core], cfg=[])
+    proc_macro = append_sysroot_crate("proc_macro", deps=[core, std], cfg=[])
 
-    append_crate(
+    compiler_builtins = append_crate(
         "compiler_builtins",
         srctree / "rust" / "compiler_builtins.rs",
         deps=[],
         cfg=[],
     )
 
-    append_proc_macro_crate(
+    macros = append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        deps=["std", "proc_macro"],
+        deps=[std, proc_macro],
         cfg=[],
     )
 
-    append_crate(
+    build_error = append_crate(
         "build_error",
         srctree / "rust" / "build_error.rs",
-        deps=["core", "compiler_builtins"],
+        deps=[core, compiler_builtins],
         cfg=[],
     )
 
-    append_proc_macro_crate(
+    pin_init_internal = append_proc_macro_crate(
         "pin_init_internal",
         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
         deps=[],
         cfg=["kernel"],
     )
 
-    append_crate(
+    pin_init = append_crate(
         "pin_init",
         srctree / "rust" / "pin-init" / "src" / "lib.rs",
-        deps=["core", "pin_init_internal", "macros"],
+        deps=[core, pin_init_internal, macros],
         cfg=["kernel"],
     )
 
     def append_crate_with_generated(
         display_name: str,
         *,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str],
-    ) -> None:
+    ) -> Dependency:
         crate = build_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
@@ -228,19 +226,19 @@ def generate_crates(
                 "exclude_dirs": [],
             }
         }
-        register_crate(crate_with_generated)
+        return register_crate(crate_with_generated)
 
-    append_crate_with_generated("bindings", deps=["core"], cfg=[])
-    append_crate_with_generated("uapi", deps=["core"], cfg=[])
-    append_crate_with_generated(
+    bindings = append_crate_with_generated("bindings", deps=[core], cfg=[])
+    uapi = append_crate_with_generated("uapi", deps=[core], cfg=[])
+    kernel = append_crate_with_generated(
         "kernel",
         deps=[
-            "core",
-            "macros",
-            "build_error",
-            "bindings",
-            "pin_init",
-            "uapi",
+            core,
+            macros,
+            build_error,
+            bindings,
+            pin_init,
+            uapi,
         ],
         cfg=[],
     )
@@ -273,7 +271,7 @@ def generate_crates(
             append_crate(
                 name,
                 path,
-                deps=["core", "kernel"],
+                deps=[core, kernel],
                 cfg=cfg,
             )
 

-- 
2.49.0


