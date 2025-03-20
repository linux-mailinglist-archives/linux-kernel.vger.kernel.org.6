Return-Path: <linux-kernel+bounces-568985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD17A69D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092144668B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A61624C0;
	Thu, 20 Mar 2025 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0/fJkpI"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29947DA9C;
	Thu, 20 Mar 2025 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429258; cv=none; b=twSninw3TTx/IJWjveWfQdhdmbOlPOnetN47XlkahXv6ruTGo7bHLoZQcaKeX3QwXK4Wql8+HKEJ6NIu6/buV/RbEVmVOeY0WY47AsIx3Q0BnfkmkZ1DI5VbyBtMoGO0Zu6y3AuD/4CLz8P7HsjQxXB2fG3prTzc8qxWvriQgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429258; c=relaxed/simple;
	bh=o1R9x3QMk/wDuIEAb0AJIGhPZxLXDaP86E1pH3Nr10c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoUbINqByOEUBOIOOqfHHliPp+cXAFqmh69iHbrjDFtarEhQrmUAX70BrMJ+Ee1ZQB718GsFfh4k64XjcgEHzblbZg1wE17SvaWTe4qZli5RnNExhtfsv+16udzagzfrykr261Fi1mwGUfR19i6FsAkWfd87YDg+Hf1ES04Abjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0/fJkpI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c560c55bc1so28955285a.1;
        Wed, 19 Mar 2025 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429255; x=1743034055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StwfLO6V6fR/4iUwFxYPT3GcngycWvEYAuA5krqyRGM=;
        b=j0/fJkpI8R7hVKQiRbLzw/YqFm+NH1TJAVi4JxevMgr+qxbB2Kjjqllq0rkxQaQ8Gd
         5GKN2RbAILpcJBISto35gQxDl8VZdoQUOGRIgjGIseeRBEri3Wpz6frjH9TCGVNqoSM5
         LSgjkkL8cDGvlF+hvy2Dex7RBWePsvwPNZsuLadt4sxoaVvGjkPAw8gZMF/Q4GtzxunW
         dFnD5NmlpT5Xct88B2M5IqXy2Zn/TtT6g3ituiOijaNus5X8UovTY6GHDVtzwkpbiN3q
         y/qJVaXoCOAuBnc89uzL4iNq+SfYjXTfUYO+FlXQxBm+9apEAXoqH4zD5hxFjesm53t+
         6NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429255; x=1743034055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StwfLO6V6fR/4iUwFxYPT3GcngycWvEYAuA5krqyRGM=;
        b=HYP3rBK10Z4WkgcgSy9JFRtuz2FuIJnAE3+/yHBKDMd57hVtHQCVXqUsqShAqPOpRa
         Vt0lJyVijITs8+USIk+NTcDfTgrMmWiUabCULkIiGxkszVT2qB90lE/ePKEJ9u84cUwJ
         HmFuiUADtJO/DNKiFlur5X1AjwfcIrTij2xdW8lBWgXo8V/3VdaawhevoAJylqkpvmsW
         UEkFuGAkUd3JoiyCAYv+TRMCYP9g4JgEDolCc2lRfLbTWJaPopT+I5GvTQxnE4pPglJz
         GedGX7RT69/xLhUFk9XIXsd968hZYqFjnJmHOEuck8FhphCjmobW95bwuHnrtqF+a6M1
         qpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpl/y7LNjuib8CxMrugqS4IJJfQh6rYpju9rcGEdPopkIvo6tk3S5AP5/uP2MJMlSd+paxPAuV/8l6GVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPz/W84lq0GpiNRqAbAFvh7YwDiAa34zLaFR2TlGs9zT1P0jx4
	CsfjUrI1bqWIgW+8BqhQnKdFrXVr4OzWAXS19NGk49cFNLi5eD3F
X-Gm-Gg: ASbGnctHpSDFSrsuwtZmV+mJmYX0PPmQILoMSefqaWkmNKmpEfaJMV4NcGMmjJ6Ogas
	DPETRbY4M0B73Nh/OmTyA7I5JOoKM9gHwSZTV7ECKjRKswD8RZUJ+pSN04AJ57o+Fwg8GFQc9+T
	M5M+M04HyRXtPwteMf+nOelh3tD7X1FiMBf1q3gHcbOXiuwMfErNodP1eTjdoDKFkSafe2C4T0g
	dU9Lv7MX5nLMIwq5JTXh4qwf7484mWd+8t+l9MouTbhdUFeqYbH3AnpE4trXMLjSfS2GFYKWGft
	gQowJtUhcJwVJ5gybqkyQMS/IQMmaZTi8TN53o7b4G80hbJpWSFiCmzzuIa9EOckE8CPrtWCImu
	IqShc9xt0Fio=
X-Google-Smtp-Source: AGHT+IFe5jXVaOq5A7qshDXQb30KLJDnmtdvw/Z9NoaffU1jIA5lfRAV4kz0uOsRNfSUCjAqWgJdNg==
X-Received: by 2002:a05:620a:1918:b0:7c5:464b:671a with SMTP id af79cd13be357-7c5a8461c70mr716904485a.42.1742429255477;
        Wed, 19 Mar 2025 17:07:35 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:34 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:23 -0400
Subject: [PATCH v3 7/7] scripts: generate_rust_analyzer.py: define host
 crates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-7-311644ee23d2@gmail.com>
References: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
In-Reply-To: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
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

Define host crates used by the `macros` crate separately from target
crates, now that we can uniquely identify crates with the same name.

This avoids rust-analyzer thinking the host `core` crate has our target
configs applied to it.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/all/CANiq72mw83RmLYeFFoJW6mUUygoyiA_f1ievSC2pmBESsQew+w@mail.gmail.com/
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index adba72eb1910..cb497a492155 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -143,10 +143,12 @@ def generate_crates(
     # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
     # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
     # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
+    host_core = append_sysroot_crate("core", [])
+    host_alloc = append_sysroot_crate("alloc", [host_core])
+    host_std = append_sysroot_crate("std", [host_alloc, host_core])
+    host_proc_macro = append_sysroot_crate("proc_macro", [host_core, host_std])
+
     core = append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
-    alloc = append_sysroot_crate("alloc", [core])
-    std = append_sysroot_crate("std", [alloc, core])
-    proc_macro = append_sysroot_crate("proc_macro", [core, std])
 
     compiler_builtins = append_crate(
         "compiler_builtins",
@@ -157,7 +159,7 @@ def generate_crates(
     macros = append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        [std, proc_macro],
+        [host_std, host_proc_macro],
     )
 
     build_error = append_crate(

-- 
2.48.1


