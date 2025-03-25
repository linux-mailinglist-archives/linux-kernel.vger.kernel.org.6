Return-Path: <linux-kernel+bounces-576106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86932A70B09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2EB7A0483
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF7266B76;
	Tue, 25 Mar 2025 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFUGUgnd"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63738266B49;
	Tue, 25 Mar 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933210; cv=none; b=n/zqamQyGep1TQaVSFvpA8WOBjm1WlTRLpmkS7XyQqp6E+ZEILwN/W5UfV3YeKvzqUnH5a0lnJxUIHkBMDkh86QTDnWua6DP4mfCZ/7rQMnMC7G6WnyodIMbMOCuaOffRA6N5c7MFrJR4E7BhmCOUr9oII1fs35cTihjJnMYtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933210; c=relaxed/simple;
	bh=d5U5m2Ur34HKau07DTPcG+kG4+vxp9psxyvi1fFnbJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6vBtJ9Fpq/edgkpXSWLNPoe/mgKAmX/e4gYuQQpDP6INHv3Y8kxGc/F0z/QL8fSfp1rDdiIpBrb9xu8VWE9UrckvBm+vJXS8D31F/W8YdDjRcHPg8Xq3qVjn8y9jbO8dyuiV0Oeb80NwlJjgu6FWBZRN5FeFaxg5PwGUvcseow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFUGUgnd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c592764e54so690952985a.3;
        Tue, 25 Mar 2025 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933207; x=1743538007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c01FiyRv89Lnlr52BvaxGb7RjeGv+Bg7fV/drPh6Vxk=;
        b=UFUGUgndRgU39GrSygXkYLMxMpUUu8oTnLnsFk9TjSfxaLkG8CcyvZxWWsOUcfyU8N
         4tGJ9MpAQ2QjWPTrdUmb13CH6sNe1fyR2oeUlmNROXRWxsScIeRYFJuTS+3u1x30x77S
         DtWnWgumSaKlDcl8YD+HqcyJlwV/zNmUtiehNTd0T+yZflxJNV04ejVYsNSlrmo0Ie5z
         uCj/+il8o7fZCWFOxYmbA2SlKUAhMZLVo09z3zjISRHKYt/7BtIgKzGZKAJaTyCC7olE
         tXprcELxTH5B6LjCOlIkdJLFKYLQHuQiGC0xVOf0mzPeq+V/PJZaLPrJzMFkZNLVJH2f
         qyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933207; x=1743538007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c01FiyRv89Lnlr52BvaxGb7RjeGv+Bg7fV/drPh6Vxk=;
        b=Gq4WfEvaRKKiknlhZ3N6qhnhNJHPK8c+iCMFFaTwZcP2e8DIZUp3plfhRTM38hAeIU
         5UcyluFQUCxjG2EdK+RvUdQrsxZFW6aILn0IE8K44nWNmtIcPCWvFUuVEmlYlNyfW9P1
         fG9YDn1UB5Z4rM3/SXHqYpOrd1+3e2I32Ky2qyRkitFd6rMX33Nk8Y0+uSvy29L98HtW
         yIZuks08F4gWlx87sr7iWy9CpDA8GP1t3fHvUwURuHbW+3dV42/03BMDNb6NKIv0gSTV
         7VDa/WneqRnOVXmryQ3ok0JgwkMdi09j40FbHFmrsBZR+LTMnR+Pt9/4pra1L8JhEoT2
         icKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkTC1B8h8NhF5cDIwcJZBSpM4B679M+bXin4I3QN5kJulhHET8hGF+EONMg6KRqZlpgG0C+2r77JqSoDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJh9FvZv1v1Gt/J8ZGftAKAlDhOfRLwstffq8XeLF5h/zNzGD
	iyTITbb+M2+fwJP3hZbkAhCKyyvT/0fNSciJcbhJ57GEg4aAFarriNn4XsjH41I=
X-Gm-Gg: ASbGncvIXUpmvOrtJSUlFC3tLl2NYufkXlw6Ua7mwqicCTDUoC6WO2xDV/oHu9CAIDJ
	sQgDKk0aNdVpFdcXrpaSSetcZ6BOTglobopW0WMsU2AgvpuO2juJCOQ2SY8GxOFamAJGAsR6YTx
	iGNgD0wDjfUwdYaJ/0nUUtPkF2zB6lkTZ9YiCR0uJ6yLmfcCBitVCUWOJKakqTot4MDJ3T+Cln9
	KbHiRlbNeE6Fn/aSl2Cn3cccYdniF6c45SfWErhp0F1Fqo4YrqILekonN0/Q9iq/36vtS4MHKTh
	igMx9Ek5B88WIKXyf67YC9jyoy3ON0VxwehSe8D1ej8Z9ojatz5hNeE73e8BHCIoxWxPNjiLBSL
	rzvVsJI0SMQycO2AcshLQmoH+FQ/LLUZ9T9xvEZl93bLOzytGQIqS8g==
X-Google-Smtp-Source: AGHT+IHNsk+yb+i/v7b9n0nOqPK/qsQnynjmKzYJoxEZgwVGZJ02DwMWWSM3GM/IvYc55+/M6BEweQ==
X-Received: by 2002:a05:620a:191a:b0:7c5:4eee:5405 with SMTP id af79cd13be357-7c5ba1e4119mr2491064785a.35.1742933207000;
        Tue, 25 Mar 2025 13:06:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:28 -0400
Subject: [PATCH v5 05/13] scripts: generate_rust_analyzer.py: drop
 `"is_proc_macro": false`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-5-385e7f1e1e23@gmail.com>
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

Add a dedicated `append_proc_macro_crate` function to reduce overloading
in `append_crate`. This has the effect of removing `"is_proc_macro":
false` from the output; this field is interpreted as false if absent[1]
so this doesn't change the behavior of rust-analyzer.

Link: https://github.com/rust-lang/rust-analyzer/blob/8d01570b5e812a49daa1f08404269f6ea5dd73a1/crates/project-model/src/project_json.rs#L372-L373 [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 55 +++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 71e6038964f6..80eb21c0d082 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -41,13 +41,11 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         deps,
         cfg=[],
         is_workspace_member=True,
-        is_proc_macro=False,
     ):
-        crate = {
+        return {
             "display_name": display_name,
             "root_module": str(root_module),
             "is_workspace_member": is_workspace_member,
-            "is_proc_macro": is_proc_macro,
             "deps": [{"crate": crates_indexes[dep], "name": dep} for dep in deps],
             "cfg": cfg,
             "edition": "2021",
@@ -55,13 +53,6 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
                 "RUST_MODFILE": "This is only for rust-analyzer"
             }
         }
-        if is_proc_macro:
-            proc_macro_dylib_name = subprocess.check_output(
-                [os.environ["RUSTC"], "--print", "file-names", "--crate-name", display_name, "--crate-type", "proc-macro", "-"],
-                stdin=subprocess.DEVNULL,
-            ).decode('utf-8').strip()
-            crate["proc_macro_dylib_path"] = f"{objtree}/rust/{proc_macro_dylib_name}"
-        return crate
 
     def register_crate(crate):
         crates_indexes[crate["display_name"]] = len(crates)
@@ -73,14 +64,48 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         deps,
         cfg=[],
         is_workspace_member=True,
-        is_proc_macro=False,
     ):
         register_crate(
             build_crate(
-                display_name, root_module, deps, cfg, is_workspace_member, is_proc_macro
+                display_name,
+                root_module,
+                deps,
+                cfg,
+                is_workspace_member,
             )
         )
 
+    def append_proc_macro_crate(
+        display_name,
+        root_module,
+        deps,
+        cfg=[],
+    ):
+        crate = build_crate(display_name, root_module, deps, cfg)
+        proc_macro_dylib_name = (
+            subprocess.check_output(
+                [
+                    os.environ["RUSTC"],
+                    "--print",
+                    "file-names",
+                    "--crate-name",
+                    display_name,
+                    "--crate-type",
+                    "proc-macro",
+                    "-",
+                ],
+                stdin=subprocess.DEVNULL,
+            )
+            .decode("utf-8")
+            .strip()
+        )
+        proc_macro_crate = {
+            **crate,
+            "is_proc_macro": True,
+            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
+        }
+        register_crate(proc_macro_crate)
+
     def append_sysroot_crate(
         display_name,
         deps,
@@ -108,11 +133,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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
@@ -121,12 +145,11 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
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

-- 
2.49.0


