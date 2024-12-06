Return-Path: <linux-kernel+bounces-435514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FE9E78DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935E1188717C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478B1FFC69;
	Fri,  6 Dec 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjnODlLV"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381842206AC;
	Fri,  6 Dec 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512978; cv=none; b=iROsmvUnqI5J52AJSvfBeQsq2TxFTc6Sg10Y2COs9dOXL6Cl4WvfGZ6yIqLCLC+HgFfQEN/Wu2spzU7eJmPzXY659T2HGV+CeGsjsjYJ5mVp+zZx3nllNJczgVhGWf7RRN8oz0Ay54Qcg6U0Z4lw/jYOd8BbJa0wzDJib73O95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512978; c=relaxed/simple;
	bh=ebPrHFVB3LsRQR1YXL7aeovncI3L/MNGFI6QBNUFgeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmQ22X2skgJ82riTXrjlPXwmsjNuN7yp3UnJWxoozHzASQUmZOh17DVgU/zuVnEtQ8id3jY0PqvdzBCrL6ssPMJZfSeK5ACSLtDXVm+nNHNhUGBlWvGbb/GgwF7aBoplHzMWmwVyPEjVHyNMDANJ3U6p3/BYiTiYwtSj2jx3djs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjnODlLV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc88476a02so2274409a12.2;
        Fri, 06 Dec 2024 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512976; x=1734117776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8idulI7k7enDyu+lEvRXSqg2AbC0967lekgmFvYpzpM=;
        b=JjnODlLVITHWqj36+8ROrIB460vBd7Fo4P5setiABAsaxip2un80f0kniSNBRIICX7
         Y39UQg45MWZ+19qjm2m+ukgDyfAhVMzRFEvF7U1hRrPMu2nilk0qmPD0nCfg5UsihfLz
         K5GUgsY+gxTfXWBKq9So6ktJEudIRpCSgbkOCP1m7HsSrPmtf+pX2b6IxIe6XnWXcOFY
         e9/ddsq/nosj4gZ6zEmHaAJa8OZOwE/MaBYUYTJemS2LNli6/jDFfBmEWa6192aD5UAK
         DWPkfdnAAGgzenAYWukZCeNqPadXa5hkpynZeW0qbg2dye/q9BKPxKYIvj25FvB8M78J
         QXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512976; x=1734117776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8idulI7k7enDyu+lEvRXSqg2AbC0967lekgmFvYpzpM=;
        b=hc2nog2fpbRg5tuERSpwPfE7bw1IWzw9HaDjYF0IEwif0ANYiNey2qyjKykK9jMQa9
         Urkfjggv5hfhm4ZhMcflTlx6gIA9fKTKM0JJNePjrPE5gi9ItMIbe65Ld6yY1Ju/XcCu
         AFjLbzgY7E/8E9HO+oPOstZqG7Ca5K8oRHmJCr227qcl9xH2yFr7RrhFzKbFm38M+IoP
         +N2cyr+0u8c9eAr8MGYOWwqPI0bzuQ9u0c9ugelIdj36SHT0kaiOtl+fcAGe/7t+eyo5
         PPRf7hMbuEngEGW5ypRZjeQ7q33cQDQ8GifFrPDRQX9PlU7LdwWfizeBvFKucv7Amvgp
         U1mw==
X-Forwarded-Encrypted: i=1; AJvYcCWBc5LCOtBR+yEaDH4d1NQxe23LWTym1mEm4wbq/V4vIrM1kQnzAeUzxpnaKMARrsxqQXAUZk16M2BzSPvYTzk=@vger.kernel.org, AJvYcCWjpuqYWIgEd0N1E9q+0KUfKf92ygmvc701sycaPXv4eR3Ty2MPkkPolrGECebH9xylWzmoFUfvLiXk1HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkkxWEWJz66IvwMgz1cJTBvz2rg7D/gjYFnWRWlAZ3cd9QFva
	c7VtthVPGN9gmfAuSEW/1j5hBdY4c+V3qGpx8wTrWI9UP3xRzY9B
X-Gm-Gg: ASbGncsJBYj8UJTvGslN4Gf0kDUm1Oqo8uok8D8HuntuaJP98o17pJku9A4YqwuH+w7
	1BtEbZQmrf9ekPZBeHhmiA6xHX+bppb6iffTw7q2XjSuG7CWS+6MzsTkd/Ur+x914xLElrZv2me
	y9464C4kJCq8sUO/6DHcdkDN7Jn6yHMdFXKKoU2mJMW9el4WVH3Q5Z4Agi64CmOjOwuTACyt380
	aVMAKZK9mqRz/NpttbHXW/jrLEAfhGDdbsnbtOH3t8WyRsMFFyO3wXG
X-Google-Smtp-Source: AGHT+IGEr9Q8CrKLOtiAnkHNOdh/DQVamnfvqZIvJ8UXxKzuAsa66jz6m3vsvWKI0u/G9smaLiJZEw==
X-Received: by 2002:a05:6a21:3284:b0:1db:f603:4f2a with SMTP id adf61e73a8af0-1e1870bca20mr5152489637.14.1733512975129;
        Fri, 06 Dec 2024 11:22:55 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156ee2b5sm3377712a12.36.2024.12.06.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:22:54 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	walmeida@microsoft.com,
	fujita.tomonori@gmail.com,
	tahbertschinger@gmail.com
Cc: guilherme giacomo simoes <trintaeoitogc@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] rust: macros: add authors
Date: Fri,  6 Dec 2024 16:22:44 -0300
Message-Id: <20241206192244.443486-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module is only accepted to have a single author. If the module needs
more than one author, you cannot define this in the module creating
flow.
Add another key in the module stream that accepts a string array with
authors.
Author and authors keys cannot coexist, so add a check that if the
module authors addss these two keys, throw a panic!

Signed-off-by: guilherme giacomo simoes <trintaeoitogc@gmail.com>
---
 rust/macros/module.rs | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 2587f41b0d39..a6965354824f 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -83,6 +83,12 @@ fn emit_only_loadable(&mut self, field: &str, content: &str) {
         self.emit_base(field, content, false)
     }
 
+    fn emit_arr_str(&mut self, field: &str, arr_content: &Vec<String>) {
+        for content in arr_content {
+            self.emit(field, content);
+        }
+    }
+
     fn emit(&mut self, field: &str, content: &str) {
         self.emit_only_builtin(field, content);
         self.emit_only_loadable(field, content);
@@ -95,12 +101,30 @@ struct ModuleInfo {
     license: String,
     name: String,
     author: Option<String>,
+    authors: Option<Vec<String>>,
     description: Option<String>,
     alias: Option<Vec<String>>,
     firmware: Option<Vec<String>>,
 }
 
 impl ModuleInfo {
+    fn coexist(arr: &mut Vec<String>, cannot_coexist: &[&str]) -> bool {
+        let mut found: bool = false;
+
+        for cc in cannot_coexist {
+
+            for key in &mut *arr {
+                if cc == key {
+                    if found {
+                        return true;
+                    }
+                    found = true;
+                }
+            }
+        }
+        return false;
+    }
+
     fn parse(it: &mut token_stream::IntoIter) -> Self {
         let mut info = ModuleInfo::default();
 
@@ -108,6 +132,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             "type",
             "name",
             "author",
+            "authors",
             "description",
             "license",
             "alias",
@@ -136,6 +161,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "type" => info.type_ = expect_ident(it),
                 "name" => info.name = expect_string_ascii(it),
                 "author" => info.author = Some(expect_string(it)),
+                "authors" => info.authors = Some(expect_string_array(it)),
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
@@ -153,6 +179,16 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
 
         expect_end(it);
 
+        const CANNOT_COEXIST: &[&[&str]] = &[
+            &["author", "authors"]
+        ];
+
+        for cannot_coexist in CANNOT_COEXIST {
+            if Self::coexist(&mut seen_keys, cannot_coexist) {
+                panic!("keys {:?} coexist", cannot_coexist);
+            }
+        }
+
         for key in REQUIRED_KEYS {
             if !seen_keys.iter().any(|e| e == key) {
                 panic!("Missing required key \"{}\".", key);
@@ -183,6 +219,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
     let info = ModuleInfo::parse(&mut it);
 
     let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
+    if let Some(authors) = info.authors {
+        modinfo.emit_arr_str("author", &authors);
+    }
     if let Some(author) = info.author {
         modinfo.emit("author", &author);
     }
@@ -191,9 +230,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
     }
     modinfo.emit("license", &info.license);
     if let Some(aliases) = info.alias {
-        for alias in aliases {
-            modinfo.emit("alias", &alias);
-        }
+        modinfo.emit_arr_str("alias", &aliases);
     }
     if let Some(firmware) = info.firmware {
         for fw in firmware {
-- 
2.34.1


