Return-Path: <linux-kernel+bounces-572437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F382CA6CA4E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E5A1B67E30
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F19233150;
	Sat, 22 Mar 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghnQ7D7r"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDD230BF4;
	Sat, 22 Mar 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649842; cv=none; b=PZ1oyeS+ULSkT4BfPHohuFFECOvgp06pFREfp0vQOso3qzGdQp5E18j9H+7XmYw9iKsjUWBgo45KnTluEcP3D3aY438CIcwfCSQUXcWt5vl8PgvAgEpk2YvOofg6CDB0hghbwjcWLvE4blY40/ODwCcBiIMGUJ/AzHwF/5y4C+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649842; c=relaxed/simple;
	bh=ADTdsmOFhgyHO1tk2zECvOP6pfIpqI0asvGB+AikuB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsnHqZ5+/9GQNhyvnwRqg6wuD4DO/67xG2AufbPrsZ47Ifj/zeyhF19uTaIt30AxLSUJdqZO8FbdugV2zo+zR8oatAefIdwq9W4oVWS9OoOEyBl9+rTr6mVn07n9JOpKvBO6C68/wuxPRCKU1K6nMTK+oKLaJ7DiQbKis1JAtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghnQ7D7r; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so34965716d6.3;
        Sat, 22 Mar 2025 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649840; x=1743254640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwNUB2Iv45c+2C98gxJpalRM9YQsBnlBysaSnGUtvVw=;
        b=ghnQ7D7rBZI7pOyCbo/LE50qecGGKIEEFCPBtkuzWCDzF8qDBJJC/uU3F9VOK7Umic
         HYWAgG4hDHpLd07nh2sZfgJTmxWUrzqA31AnqedoZMHYT4m4OHWDM/Yx49bc9yzJTNm3
         GJzbF4i0hO+BHEDtL+RWt4cjl0me4qJTLrf9A7xQAr7F3J4XztfIYELy1N8sRAY16Drv
         3ZruUEN4v7IIeNPfcA4PH7dT2pEwtGYfzZgkxIW0OHcFaJ5mJPa/O3tV0T0x5RqjWxBJ
         6x+b5IPKZ2ula9f6InSyfgIH+wPZ9sUPuxjRFjnLk0vKVH/6aAJpkUSYLAHYUjzBB1+1
         Ws9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649840; x=1743254640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwNUB2Iv45c+2C98gxJpalRM9YQsBnlBysaSnGUtvVw=;
        b=nbs1Nv4gaM9/Mxdgw8fC+FqEVOJUYP5ZKnUkG5jelp4NFCjekI8128O7NWaVfY4CpN
         sus5zFRg6CbqHXJjR5o0hcQE58TnOHRtN3uNEBT171D8ODU0HqwZKz5b7p2Z9HIekDLn
         uVMe5PRzWKvFqiuG6Rrk5ZcWvVzSjzqIjSxGIVW9dJZEZOxwSYQ46NZouQuEWPNuXGhF
         ODU+U2nJaQcLra5lMJ/fsDPsWGWqu8f0h6SdX+LvNGl50AaXw0hjJ8mRssJJQPQVCDiu
         Euf2nwZm2cyxvcWBk/UiAwjFrdeKuQaYbP7h8wR4FPyuggreLY+Upw5AQweyN73fCzmN
         DK3A==
X-Forwarded-Encrypted: i=1; AJvYcCXnv40VO1wRWAmPjs4aO1H8BoxNo2UbMoISKvp6lY5ovMG2hivn/YLC5Dglujj8lmuGWJ7rYRaK82JT1Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXOpdBRkJP9+aiWzxnzmCHrpMg+qesixnXYMd2aloSTMgp1+H
	G3JK31yHTgOaBEDmjKmqIk2LE/eyVGx/sYu5GsBwr7o/xwCE8rcw
X-Gm-Gg: ASbGnctWWJxvTTV06phqiYqm8znk5afEml+mhFbw61ALB6vUeItYW4P90HQZj2igFhQ
	9HE3okDwIrG5oo4vLI1cqfzKGKlEL0VMI8vMRRtIIKEjIBuDRkRyX1Yz5wc3UYKRqJAkmg1xOkF
	su0uxVWIYd5OkJFyTJj4GDENUU7lo0ugPArzjzWt+RyXa+nld1eR/XqmapWTeScNfH9JOvo0bbu
	lBGsOi0oS74p4X/sVxhs4ZD0pZ44B/X0jSCj1J/3RBAaAGrgWFsPDeHb4RWYlgcZ0Vt4GgPwFpT
	R9cV728tGTw9UI9ukpAh8Jk+F93zda/cgmEanUP70whOZWLU1G5lcXL6tIAY8ha/Mc556/S/G19
	C0AqRiT+cWspuENQr6KxrpQVnGZBshHF69Dxx57RtRw8lQWP3kna7TCtJA7WeLym7gO7JUoU=
X-Google-Smtp-Source: AGHT+IHn87AyE+28Hc4mLYbdtQucf1nhGDe0S6tYhHU1s7gVUV18qF+S+pWwB2Rx82kOHslJI0UoGA==
X-Received: by 2002:a05:6214:194b:b0:6e8:f133:3795 with SMTP id 6a1803df08f44-6eb3f34b5b6mr104550006d6.32.1742649839934;
        Sat, 22 Mar 2025 06:23:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:42 -0400
Subject: [PATCH v4 07/11] scripts: generate_rust_analyzer.py: identify
 crates explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-7-1f51f9c907eb@gmail.com>
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

Use the return of `append_crate` to declare dependency on that crate.
This allows multiple crates with the same display_name be defined, which
we'll use to define host crates separately from target crates.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 70 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 1ee079c6d916..de1193117161 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -68,17 +68,14 @@ def generate_crates(
             line = line.replace("\n", "")
             cfg.append(line)
 
-    # Now fill the crates list -- dependencies need to come first.
-    #
-    # Avoid O(n^2) iterations by keeping a map of indexes.
+    # Now fill the crates list.
     crates: List[Crate] = []
-    crates_indexes: Dict[str, int] = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
     def build_crate(
         display_name: str,
         root_module: pathlib.Path,
-        deps: List[str],
+        deps: List[Dependency],
         cfg: List[str] = [],
         is_workspace_member: bool = True,
     ) -> Crate:
@@ -86,7 +83,7 @@ def generate_crates(
             "display_name": display_name,
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
-            "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
+            "deps": deps,
             "cfg": cfg,
             "edition": "2021",
             "env": {
@@ -94,27 +91,28 @@ def generate_crates(
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
-        register_crate(crate_with_generated)
+        return register_crate(crate_with_generated)
 
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


