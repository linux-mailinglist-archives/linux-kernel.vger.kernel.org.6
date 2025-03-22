Return-Path: <linux-kernel+bounces-572434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506ADA6CA49
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5430C88482A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952622FDEE;
	Sat, 22 Mar 2025 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtZMM3tx"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C122E3F1;
	Sat, 22 Mar 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649838; cv=none; b=BSsjO7StqpWqZwiDkA3T3L0uLJXV14IuE3Lvm7VMcsZ+1a+GOFRidwuMmlVn9dJEtLkBsGSdLnlB6BM+em7etvwEG7Ln9GTvhYczD8ml904A8GQz+6x4h8BegrPT+/Vm8Dp7KI42rgt1y0H7BsBbw/FxkYLKMSZVbQUcz1Zb4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649838; c=relaxed/simple;
	bh=djrUy+lC9j8mFxFjW4qk+wIrUq17nKe+rtJndN/2J+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7U+OF2ddICOOxeV4JnXojxebZWSlZ19lhMpMZjP02EyCXU2X3aSV2vy7Z8LOlLEcA2JbwN9CKS2PkUFMVj1fwPYkNWfPPW22AaccZfL7cR5b8jj+LuWjvX1fEFQ2xRHDaK475ZY/AVIyvd7sxMRrUfLr5VaX/LJYaFiosHHiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtZMM3tx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so34964946d6.3;
        Sat, 22 Mar 2025 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649835; x=1743254635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZsPLeSDyqG7YHj6JdCwGQczPC/vRf4ULCY/DWZr5NA=;
        b=GtZMM3txyhvQr7+dm7kkNY2XzigxTt9yBiVh+kG9O3qJ2j3UqGNVdJv4cQkxlTQ4Kb
         6QgBn5N1oHwYbCUQGH/Sc8f4RmVZM7OBF2VQjxcLwjDLsmjhdEJvB9OMZhvZemNpyOsb
         hYYNhwqO+iX4FIHKM1HKorvT3T+bzwv20jpcdVNI8cfeiUtLkQTy9pJ+ra0WooZmu8Ab
         VkBZ6yuuduzjdswXU3gjbvq1ecqAVkddPvM2gxP7NyGnqVzTuV5e8gzKdHHS7oGJ4EkH
         qzhMDT2kKDcYWHnscycJDr7SMefVkFpNLaKKhi4bHHUxZDM+xIM26PWgrUJVg/hg9l1M
         qWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649835; x=1743254635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZsPLeSDyqG7YHj6JdCwGQczPC/vRf4ULCY/DWZr5NA=;
        b=PK8E+lLBIiPHB1CYDmjgh3+Jlf46tzJM4xqzKBkvtl/5ARAHEoc7H3akXpzacAv3zy
         U6awg9CPIra0c42+6xTkFGW+ovBrb1CPGOai1fgwvSWgXHwJL9N+iGPuZkWsuW71M1Zt
         C5qzwLrjZGcp9AXpxssqZyAS0k/UoO87X6DNf7rZihMcEXfQgqzvV0ab7WUvuMgbBjpK
         edtp2AP0iS8V46Usq5WE4Q/i1NlGPi4WxLoyl5wnvHqPUewvfLLPOcA58/SDovXp2eqG
         NEfadlMiQb+ACszU3RvCktTjqbIDaaXmriUyRUezDkYumUk31HmCkgbEPxxU0vQ90Dqj
         SXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRGhhv0v0ve3muIR/ugankp4/jGyJLmU8rGZu4ScEJQjcUUlumkAOmsU1wDK0IbNdzCE/AEIm6IpI170c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ahApqtd2LEV5Xz86JCi87mC4Ll2UzsnVDpjVpPhNUJuh0+jN
	3rXRt0s/YFS52pJTcBf63a8k4YW8XZ1yBgj6TsOSodCpDcfYsxxB
X-Gm-Gg: ASbGncuoseJn/Nl3/fsJHOIQGscghBD+Zh3iqh8kIc+ecDySV355SJjYc76AJdN4gyb
	dBLbyf71qNgn4qP0EUiRTQMbmGBrplNkdosiWECVJw6ZMEvRyy1TVaZQegXP65q0hfeK40gGh9C
	rQMGd7auNPi7v5/XVnZdDPn3xvMCw1spSkKKMu61B4hUzrj1C/3wxwjvM1iqW5+bgG3AXA38Ogk
	131m4kqcvXHK5d4ENYwYf3oFjecc+1xXnitpMBQ1Nfe9m+b/MY+uBRkgmbYj54sJ8JJg4l2V1Lm
	E5xg71RGNPAtZ6f8ZOgePZIRhuGuee7Qhy64nARJoxF17/lIyR7G6CGjLu1on2z8naYXtbijg5p
	tNwsLO+OjlVc/yIH8PS21ZcjMeU+DJbsmOJ3OaMlDEWdaGeUBpJ6Wdv87S+rkJtWpZtPSq8c=
X-Google-Smtp-Source: AGHT+IFvch39AAQorZs69szfD19pLA2pR4PWVZTKKi8pVZ9dbhPEDdjvuhtD4BF+4nsyt77953Ftkw==
X-Received: by 2002:ad4:5d6e:0:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6eb3f2f5960mr123534236d6.25.1742649834570;
        Sat, 22 Mar 2025 06:23:54 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:39 -0400
Subject: [PATCH v4 04/11] scripts: generate_rust_analyzer.py: extract
 `{build,register}_crate`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-4-1f51f9c907eb@gmail.com>
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

Extract helpers from `append_crate` to avoid the need to peek into
`crates[-1]`. This improves readability.

Suggested-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index e997d923268d..03f55cce673c 100755
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
2.48.1


