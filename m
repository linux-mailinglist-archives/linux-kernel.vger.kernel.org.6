Return-Path: <linux-kernel+bounces-576113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E08A70B15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847BF7A8178
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E170C267B6F;
	Tue, 25 Mar 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/p7fweh"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CC267738;
	Tue, 25 Mar 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933221; cv=none; b=GMMCeVx+vIZehuD1qxUoQ2L3eQ43S/kJG1QRi6DJx1caZdS3TPll9VrgGT9bqfJFYfpHFAy20nDQ/IvAy365mWVLRg6rvWnGYMcJdMMvY7YJ6wMzovEQfsqBn+IMDS0xKMoR/BjxN80I9Tpdk4DqBzfcXRaveaEvfg9OJl3CmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933221; c=relaxed/simple;
	bh=BHB6Vy9d7NxjCKjq3gR1UE9YFnZTGlh4Yeoqryhywic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agpmdMHD2BhEBhukGPTiF3K83S8HZZyTtfPDH5qs2J9BpC6S1VcNSum3PV3tAeXXRn4Gpnb7Yes7wXbyYR7ob6H4MPVYCPbvyVTTIJVyrPxIy0b2n8Ltt05tjheDKSy3EsxEwL1kULtjha3GRgOBGWjfkCmgrsCieQxiSa3LkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/p7fweh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c547932d2eso361403985a.0;
        Tue, 25 Mar 2025 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933218; x=1743538018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEN7PB6kZDExUuTgOn6RpUdfZ7yLfXh3+d7K0qcH+/E=;
        b=g/p7fweh4RXmLOcIIuB98U590Ct6Fc0NK/2inbY4YoC7u530hP2rcytS/R7ufPI3DO
         Op+BvHGLKGycxfol1WjFHW1d4WAlTG/brP2JBdvBqU2oy0PpFEtv/ldapfHjNFVGgzjm
         BZvsgv12mQPPvstX/zOQ4pQK7NLkQEpATY63oB6EOyyyqVxsjaGmYMIROtwvjjhKMQuO
         33FuxQX6Wvl/PYi0/XPzu3TEgw3J1zschQubDVbDScf1RQtqKmC0ldHb061JHJUudFpo
         di8vymxELeVGxIyBkYAPvdenUpEpfhmZnEQdVr6rYE3sxb7kb93T4etT9g4VBNq/VbQx
         mJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933218; x=1743538018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEN7PB6kZDExUuTgOn6RpUdfZ7yLfXh3+d7K0qcH+/E=;
        b=Xfqp0OZ06pFMPoGzFPv+60mbjcMVOPncGuckQcu8VdXu91rXACkHgXp4fwDqNvWoa/
         3CCPz7gER8FvIdf4b0oqTB/8KBdkBiAY6LGUk+fbpdBMGNN7RhfMvV5eQf8UqHaq+8yT
         T10QIihWP+GxMZRscbFeyNTRCitlzFqkgVJ3sGBxVTdCkY+rTjA97ivGiirl3VEKX7K4
         m3Y2TA6KJLLgf/mesJEnXpKpFK5wX8PTF9FTJwWoCkdjUPPnNV8QrQadis5Q853nV4M/
         15PcpT4vfvSaBg8klSz0CWRYjgYbNp15at1/C/JVY9ls+r0FxKZTl8tBVhw6aOF4TWqo
         lI5A==
X-Forwarded-Encrypted: i=1; AJvYcCW+LcMLD2pIO/5jsUx1cj/pSGPL749SscMhDtPmJ9y3uo+EYZ+LpCbcOZtsdY6QK0w+2tDhrM7SR2CC1Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/MTFu1mFGzIgBPRxKodqSTdfVDXifRT7SqGZ2q5MVsdTaWoJ
	8ZDbgykW/RXSsMd/UxYXANUpIn3Mj/FKPA8xW3rUNhTKY0b5NtaD
X-Gm-Gg: ASbGnctq4Ppqo6YJ273cpkdiniP8x48Ze4Grc0QPTid8wyQO6tKULKdW4L8gIZyNb16
	Um/bTZsu1ITzKT/OU5FVSQdrhmyEONsBjqVxlDBeIN7HD1PWFAX//xBihPvE6Fm1i7YCWrFKMjS
	LSzTm+lVAKHkOUnY2CuzG5OVyNfy42o5AtSJSMbFN/Kay9VS5qOxfOrX/iQmT/Oep0vSi4DxsuF
	C7pinYaL0HgI3Yl49iDFL5g623Kznt2dkf0JQN41pggmF+upJVVLex6gaxDKbF9e9wyRN/3asE5
	BXZoTgMYN8QZ+xfkxFvtQpGUSSxCAjhQ0FamWocnRqQbRBwt17077loPlbp77dTT21FWszxKWHb
	cxUCGdfQs0Y24pHtN3wecKQI0hlKpBYnxZ+GpOR+hUdDkG7HDbsni5A==
X-Google-Smtp-Source: AGHT+IF7vZx9UcR8te7aISj1/g1fYSXlc2GYAFCIsBWp8ozlUyt/Uo/TGyiZyFHzwJ770vE4x/LxRg==
X-Received: by 2002:a05:620a:24d4:b0:7c5:50ab:de04 with SMTP id af79cd13be357-7c5ba190b77mr2479071685a.32.1742933217696;
        Tue, 25 Mar 2025 13:06:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:35 -0400
Subject: [PATCH v5 12/13] scripts: generate_rust_analyzer.py: define
 scripts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-12-385e7f1e1e23@gmail.com>
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

Generate rust-project.json entries for scripts written in Rust. This is
possible now that we have a definition for `std` built for the host.

Use `str::rstrip` for consistency.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index e3f1ec856ecf..5c0056c265bb 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -249,6 +249,20 @@ def generate_crates(
         cfg=[],
     )
 
+    scripts = srctree / "scripts"
+    with open(scripts / "Makefile") as f:
+        makefile = f.read()
+    for path in scripts.glob("*.rs"):
+        name = path.name.rstrip(".rs")
+        if f"{name}-rust" not in makefile:
+            continue
+        _script = append_crate(
+            name,
+            path,
+            deps=[host_std],
+            cfg=[],
+        )
+
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
             with open(build_file) as f:
@@ -267,7 +281,7 @@ def generate_crates(
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.name.rstrip(".rs")
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \

-- 
2.49.0


