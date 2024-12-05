Return-Path: <linux-kernel+bounces-433164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D79E54A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B44280DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1120214A6B;
	Thu,  5 Dec 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="lvcX9czy"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB17214A66;
	Thu,  5 Dec 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399697; cv=none; b=IKFQ6JMskKI9Z/yqvD0bhocYE4JvcAl33pltCifH9GeI4a2BThxrd2dfp75KT0az7JM9kE60QEiqNUXdFk71jwo/wcxLHurPaGtxueciSwlQGeqx7XRE9QLifzhxcBM3i8FkeYEwLDS49JmHvFRc81qmjvZby3L9L9gjLXei/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399697; c=relaxed/simple;
	bh=KMCyE9ZJAMDAtajI/0HnPjFXXAaDm7gGd9JBbnwHi1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnXQ72rdzKh9jyfb000igcUqK9njvq4OHLz2Pw5/7Op3fRITJm+97GLmYPhOh5pVXcvko+OKUH5p1WcWCmUABxW0saICPMEvfKdd5XnGlSTwaF0jegMdYZMFUxOaumXO6alT4ODp2P+XrZVBgl6QbmB6fh6rTlwQnT75KeuA+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=lvcX9czy; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1733399689; bh=mkOrmXx5DpCU18D4nh+JipCWuV+F7TBWM+/XgGowy6I=;
	h=From:To:Cc:Subject:Date;
	b=lvcX9czyaxx/WYvwH1DTFyhdGOHLKHGFtJ/WbfkI9O/OlERgMc3LDbRbAYTbOBXyM
	 kN3BI4oP46+QySdAFDvgkQzXoQyAyEjGqNbt9cT7WVuMrPV3PYpsNwoOFXuiNh6FIk
	 ocxBQmnroMnnobrsmrRBtlBQEOHVSh9Q06wAazqY=
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Fiona Behrens <me@kloenk.dev>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: rust-analyzer: add proc_macro for macros crate
Date: Thu,  5 Dec 2024 12:54:36 +0100
Message-ID: <20241205115438.234221-1-me@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the proc_macro crate from the rust sysroot to the
rust-project.json file used by rust-analyzer. This allows
rust-analyzer to autocomplete items from the proc_macro crate inside
the macros crate.

This also adds std and alloc only to be used by proc_macro and
macros. This does not add the dependencies of those crates as this is
sufficent for rust-analyzer to have a basic autocompletion support
without having to worry about all the dependencies std usually needs.
alloc is added, as e.g. std::vec just reexports from alloc, so that
macros can use autocompletion for Vec and similar.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
---
 scripts/generate_rust_analyzer.py | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 09e1d166d8d2..747b5ed6c857 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -64,10 +64,34 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
         [],
     )
 
+    # alloc only for std/proc_macros/macros
+    append_crate(
+        "alloc",
+        sysroot_src / "alloc" / "src" / "lib.rs",
+        ["core"],
+        is_workspace_member=False,
+    )
+
+    # std only for proc_macros/macros
+    append_crate(
+        "std",
+        sysroot_src / "std" / "src" / "lib.rs",
+        ["core", "alloc"],
+        is_workspace_member=False,
+    )
+
+    # proc_macro for macros crate
+    append_crate(
+        "proc_macro",
+        sysroot_src / "proc_macro" / "src" / "lib.rs",
+        ["std", "core"],
+        is_workspace_member=False,
+    )
+
     append_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        [],
+        ["std", "proc_macro"],
         is_proc_macro=True,
     )
     crates[-1]["proc_macro_dylib_path"] = f"{objtree}/rust/libmacros.so"
-- 
2.47.0


