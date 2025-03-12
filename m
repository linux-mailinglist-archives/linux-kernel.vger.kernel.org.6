Return-Path: <linux-kernel+bounces-557129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF663A5D3F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A29165E26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCA1C860E;
	Wed, 12 Mar 2025 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE1zuuqQ"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3861C5D76;
	Wed, 12 Mar 2025 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742279; cv=none; b=p493MszVKWBo2EtjTt3KIgSpi1rJ6BEgKpD6Y3Co2Y8He9M3DPP41324x8UzFuGnmsfPRUrqyVrcNoZWsbq6un7u1cnovbmAHYNuyJff+klK2WAFDXh8iRsWSuv4QSKnlSaJrHlt1VNVoVQvCA5hBpcoQ+lxRGrHWs0Zm6kp7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742279; c=relaxed/simple;
	bh=ym0uAM3173NwIdccsvRUaTQeHfi8HeK6xwWWzGXaISs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0950ECdH3jcV7cEUih391dQnM5bBmT55t8lpZlUKcgeOhs5cBuJMKBZVd59BsjVMjnPGGvH5m1p+23SmWcCrZEM9x1GwGBk2vKSKBIMCkuEG6lHyQIOWi0vXDHo7NtJqGUsHOJgL9u82SS7qJcx08c/ulU4Q21c1ShjWMw2GX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE1zuuqQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4769f3e19a9so8696291cf.0;
        Tue, 11 Mar 2025 18:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742275; x=1742347075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuT/y5FKHmoEEzYb5QENOtK4YXwQR2+9pGyPJGYhzrk=;
        b=XE1zuuqQvKqfdltd3GWO3UAW3nBO5c5SWldXK2rq2KZrm/9+2b4mbtNXHCKE2JH4ls
         ls4X2Fx+6LMTlC9PEbjoPySssAScoL0ePZAgux660UCZKnsnhM/3AkPsC4/KEauJD+VI
         JQppNXudrbmIR6i2kiwWckg9NO8AEoDSoryNOikT3YYOvKFvOGAClKPZba5ZosI/MYz3
         knY0i1dg238AEPBH4EbiNfFMH9+vqsZ+xt1psUh25OXNdmBLsIikAsYXNn/38ec+44KS
         0qdYXQ3PdC2xO++a9PtV4D2xdUw8yRJMjPM+GfiaVfp+LH4w1Q21tP2KhQhNeB76J0Cv
         /Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742275; x=1742347075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuT/y5FKHmoEEzYb5QENOtK4YXwQR2+9pGyPJGYhzrk=;
        b=HsNDaCc87jGhXtsbcHoDNkd/WKXJ391qjP0vkZCgFlrRpe+6DUSZZZW1tfAZUbYyHK
         9vH2Kr8VZYGo4E9pRXlJFraLotke5AEcDN7ENgbGpYrT4MSamoi6xnMHWTQ/dC5F1FvS
         CtRE9NzzxDMnXdvb7Y6pkeD2ymOuWGUbsp1zIB/UBC/Ts7DSgRdlTSU/fQ31Gx6If3Hs
         VwjBaisJDI+ipHz/CsIxJNaHlQSu5WADs48HCPuQNM0MIhJCxR35h94Usrt0FhQ/A4cH
         4OVoZVOlXxqVSsLR4dwtlcfCflMBDcEHtXp6pzKgftn/a4cNBMcrc854ESMlNXmaTipg
         PKag==
X-Forwarded-Encrypted: i=1; AJvYcCU3/h2A2TpLei6HR/m/0399jddRBlFmJCxq6EU5MkAuf+rA4IxjS8suIowkGyMboaCxrjMirdAj/lHCz7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygaTVSPxz1MhBKO5IWOd6Oam/dz8sAckkNVXAk7Skjd3r/1HtJ
	QZQsEe0WBY0eRijzb+oYUYxvk1dBk26Wz03pyQaixfU+sobV3f8y
X-Gm-Gg: ASbGnctVJCjUosFuQTjeP1ucexBTiXDTPMN2x2IemUFJPb1I47MYrqvlJJWLRpfv45N
	Z1OUl3XR/1rTnAu+9aXT1mMdWvoYvSDoWSw+GjTuQ9DxKscze5e/Ve6avwEmC9LqpGPvqQSOAQs
	cy6sjAwGtAGS7fog7ZtcPmnj/cZmmEa9+XfdSwn1fyDAOg91PTlCMXkbKAZdCuJk3uKGArgXkrA
	A1UOwTi8hALwwh03FVXCDGWpXvbsmib/PfwsmDrs+YPG18O5Nq2mgCGciW+bQNNGVTzaz4awoOQ
	U2NPGXTA0QkvLSFIde17QVuQTj+EuiVH35/nGpD7Zb+I4fyTehxAZvlfum6gstTRlKgA
X-Google-Smtp-Source: AGHT+IEIoOnXopKN0MF1B/3JIUyExCdONXIMAt+tn3yriPRLRlhcuPXT2fKYNdhEQR4lggfTpTocJA==
X-Received: by 2002:a05:6214:e49:b0:6e8:f5db:d78d with SMTP id 6a1803df08f44-6e90067700amr233796776d6.23.1741742275373;
        Tue, 11 Mar 2025 18:17:55 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:54 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:27 -0400
Subject: [PATCH v2 6/7] scripts: generate_rust_analyzer.py: identify crates
 explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-6-30220e116511@gmail.com>
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

Use the return of `append_crate` to declare dependency on that crate.
This allows multiple crates with the same display_name be defined, which
we'll use to define host crates separately from target crates.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 1bb185ae2e87..e1002867735b 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -68,40 +68,38 @@ def generate_crates(
             line = line.replace("\n", "")
             cfg.append(line)
 
-    # Now fill the crates list -- dependencies need to come first.
-    #
-    # Avoid O(n^2) iterations by keeping a map of indexes.
+    # Now fill the crates list.
     crates: list[Crate] = []
-    crates_indexes: dict[str, int] = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
     def append_crate(
         display_name: str,
         root_module: pathlib.Path,
-        deps: list[str],
+        deps: list[Dependency],
         cfg: list[str] = [],
         is_workspace_member: bool = True,
-    ) -> None:
-        crates_indexes[display_name] = len(crates)
+    ) -> Dependency:
+        index = len(crates)
         crates.append({
             "display_name": display_name,
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
-            "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
+            "deps": deps,
             "cfg": cfg,
             "edition": "2021",
             "env": {
                 "RUST_MODFILE": "This is only for rust-analyzer"
             },
         })
+        return {"crate": index, "name": display_name}
 
     def append_proc_macro_crate(
         display_name: str,
         root_module: pathlib.Path,
-        deps: list[str],
+        deps: list[Dependency],
         cfg: list[str] = [],
-    ) -> None:
-        append_crate(display_name, root_module, deps, cfg)
+    ) -> Dependency:
+        dep = append_crate(display_name, root_module, deps, cfg)
         proc_macro_dylib_name = subprocess.check_output(
             [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
             stdin=subprocess.DEVNULL,
@@ -112,13 +110,14 @@ def generate_crates(
             "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
         }
         crates[-1] = crate
+        return dep
 
     def append_sysroot_crate(
         display_name: str,
-        deps: list[str],
+        deps: list[Dependency],
         cfg: list[str] = [],
-    ) -> None:
-        append_crate(
+    ) -> Dependency:
+        return append_crate(
             display_name,
             sysroot_src / display_name / "src" / "lib.rs",
             deps,
@@ -129,34 +128,34 @@ def generate_crates(
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
 
     def append_crate_with_generated(
         display_name: str,
-        deps: list[str],
-    ) -> None:
-        append_crate(
+        deps: list[Dependency],
+    ) -> Dependency:
+        dep = append_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
             deps,
@@ -174,10 +173,11 @@ def generate_crates(
             }
         }
         crates[-1] = crate
+        return dep
 
-    append_crate_with_generated("bindings", ["core"])
-    append_crate_with_generated("uapi", ["core"])
-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "uapi"])
+    bindings = append_crate_with_generated("bindings", [core])
+    uapi = append_crate_with_generated("uapi", [core])
+    kernel = append_crate_with_generated("kernel", [bindings, build_error, core, macros, uapi])
 
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
@@ -207,7 +207,7 @@ def generate_crates(
             append_crate(
                 name,
                 path,
-                ["core", "kernel"],
+                [core, kernel],
                 cfg=cfg,
             )
 

-- 
2.48.1


