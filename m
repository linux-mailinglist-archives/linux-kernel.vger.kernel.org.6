Return-Path: <linux-kernel+bounces-576105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C981FA70B12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA23B83B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23F266EE3;
	Tue, 25 Mar 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Fw8gWg"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C509266B4F;
	Tue, 25 Mar 2025 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933209; cv=none; b=u9htc5zd61DoJ42CX8HMO6dwSDJhhF4w3AnOdxC7nNhk57okhxuTGtU6s7UMtEU68w7IvdBZ6kkkxGT9heb5sWqK4H3sMoOxtY9rGlqx1+jcbdJrd9LHfcbivpvPiaPdjIzKaxYs0BWfaOafQQ6GRrQ/jPz8AN13c1Yk+xrruh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933209; c=relaxed/simple;
	bh=G9wYOii+pzuahecAN6w/nzRJrKIQP+UrcdtJv1Fk33o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=df+UkkTqOn18sAqkxTM9F9shRzRgEgW/5cIaU4aDHoyD6+/en9d5fstGuov0b7OxNZG74NL2a/hLmbP6+mgkMulOQ9eXr/28LJRhvw4hDt9cf4/1bfe0uFRhCarrL1PIci8wmYX6PSkoXamDCxomFn3gjXTY0oQEpW2kOq0gfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+Fw8gWg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c081915cf3so784379685a.1;
        Tue, 25 Mar 2025 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933206; x=1743538006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkikmV4mQd/UrMvEIEtyuBKAuxKKRpLr24TUYvBSilk=;
        b=D+Fw8gWgzqRTC71MyFnX+duDePTeDKMIe9v/BjDxF5Z5R1NKOUMqSO4dKF83d+BGsY
         d1s0+8gmRbGw6ieHEPaKq0kxcbCjZtQreRQvdA4jtcLLuxqaEa5hS43YxtCqIZPPeWxF
         dLkxJ1S+/S4hqF8PoGBjAhJX+QLCsElGutpMyCN07qMm0BQ4KU+BVCet7y6YYBUE1bk9
         UYpYdEFIjadQxzo3u2lXcV20fqeoQznOHqjXetKgrF+eo9QyrWtc+IXGLfYnv4PpxW33
         AwZ7FzPZ51vKiJKh85Y8oVKMlgTzRDT7EYRdwZchIoTi8iVbiH+6zEI2+Z/I1DhmUZlW
         elKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933206; x=1743538006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkikmV4mQd/UrMvEIEtyuBKAuxKKRpLr24TUYvBSilk=;
        b=oIavIC3DvSFhr8oMyPAbNlSxN5bK40uPl+4SCutPm2LI7W7WMemk6FOwdnxBGatR76
         Vk13gm2vzKd8Z24TI/gSLxehsrK2ld/lcSE9q88n7vUeiwpNz0gsvlhTY+TPfUIF5TCJ
         naOXJhAhOOj7vMywHbgCkJ9dvDy8d5eFWIm/WMvvN/pVwKCLd8brgR2RJuXqhef8378/
         MFIGDYZLOxr3gSKkcxSQmb5Znj5rlMLoaoOs5AIpxd89ZtZYwI9nGTeX0MRWRPnQt/+k
         uxyUnFDJMHw7U3GLRcFiDfy9Nk09+O+UVhKIngn/tYdtTOWqc0mY4Lxqq2R5XBSyy6FF
         SWtw==
X-Forwarded-Encrypted: i=1; AJvYcCUu8A9bZGDHhGUViZsvwh4iPJcyWtq1hVKbQ2ZH2BE7Zti+P0Pf7x+43ut2T82u13RObFUD4/fRmhmr59E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAchfeZiSllOLIg8QV4Ka35WRKW2fGgSwHYNiI05Iu6iYxU0F3
	3/+xZgfsD9irk3u7CIgxqgiQfE5ghR++BO8x8z/T2glPSa3AM8hc
X-Gm-Gg: ASbGncvao7Gu9KfAPBvxqz7VFxPAHZF1s6I8HaAPOhB396eImjhmGmjJAoHBl7NH2kr
	G50QdgJxEGw66DoqoPbLCHTtexmEmJ8A37MPtXGPUKyvJywNmN8nN0ijDttTW/RvfTDdoYSYvrH
	yk/c1a9RBRhFUUSCJYVonCDJpCR6yItd/4uVQs+/eja1Uj0OxSCSGzBnwWZc8p+d3yBLTxpdSQN
	FSy4aE9yLXMbcXSl9suQqCy4B0JlCojQeYWXXTtaWfIbpVEu1HxN/hj+ai1L4Mx2hV5ScUY1Ba1
	6XpIXm9iacgrlc4Rm8r52jluHwaD0KqkDmFws0o6w/l3Q8YzvpbXwoENXQfGwImm8PtkfgJVt1y
	jSodUXMYWfcZQVq2bgjZT/V8nhyZ/OFGPs/Grda/qIwF662LtdW/MHdh16MdH7MhF
X-Google-Smtp-Source: AGHT+IHffcFGs39/7YBTydLynP7o//w5dFrLD8EEtsUB2iveBG41J1PQmHEfWIhk03xHOzyBfF465A==
X-Received: by 2002:a05:620a:d82:b0:7c5:49e8:993b with SMTP id af79cd13be357-7c5ba1f1504mr2552897385a.56.1742933205748;
        Tue, 25 Mar 2025 13:06:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:27 -0400
Subject: [PATCH v5 04/13] scripts: generate_rust_analyzer.py: extract
 `{build,register}_crate`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-4-385e7f1e1e23@gmail.com>
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

Extract helpers from `append_crate` to avoid the need to peek into
`crates[-1]`. This improves readability.

Suggested-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 1b6b69501131..71e6038964f6 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -35,7 +35,14 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     crates_indexes = {}
     crates_cfgs = args_crates_cfgs(cfgs)
 
-    def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
+    def build_crate(
+        display_name,
+        root_module,
+        deps,
+        cfg=[],
+        is_workspace_member=True,
+        is_proc_macro=False,
+    ):
         crate = {
             "display_name": display_name,
             "root_module": str(root_module),
@@ -54,9 +61,26 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
                 stdin=subprocess.DEVNULL,
             ).decode('utf-8').strip()
             crate["proc_macro_dylib_path"] = f"{objtree}/rust/{proc_macro_dylib_name}"
-        crates_indexes[display_name] = len(crates)
+        return crate
+
+    def register_crate(crate):
+        crates_indexes[crate["display_name"]] = len(crates)
         crates.append(crate)
 
+    def append_crate(
+        display_name,
+        root_module,
+        deps,
+        cfg=[],
+        is_workspace_member=True,
+        is_proc_macro=False,
+    ):
+        register_crate(
+            build_crate(
+                display_name, root_module, deps, cfg, is_workspace_member, is_proc_macro
+            )
+        )
+
     def append_sysroot_crate(
         display_name,
         deps,
@@ -116,20 +140,21 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         display_name,
         deps,
     ):
-        append_crate(
+        crate = build_crate(
             display_name,
             srctree / "rust" / display_name / "lib.rs",
             deps,
             cfg=cfg,
         )
-        crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))
-        crates[-1]["source"] = {
+        crate["env"]["OBJTREE"] = str(objtree.resolve(True))
+        crate["source"] = {
             "include_dirs": [
                 str(srctree / "rust" / display_name),
                 str(objtree / "rust")
             ],
             "exclude_dirs": [],
         }
+        register_crate(crate)
 
     append_crate_with_generated("bindings", ["core"])
     append_crate_with_generated("uapi", ["core"])

-- 
2.49.0


