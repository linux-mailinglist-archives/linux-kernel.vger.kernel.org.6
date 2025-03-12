Return-Path: <linux-kernel+bounces-557130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213CAA5D3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148E23B90C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8861D514C;
	Wed, 12 Mar 2025 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+tlLYmk"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390D13774D;
	Wed, 12 Mar 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742280; cv=none; b=ioIoKZkN8r6ZpectdmY635R3PdbPP40VWMAABHqvmRTZ0BKf6bslP11HnoGWVUA9GZvcH2ia2ZJqdOKAugpSTgACvkpDFP+qI/etE8DRAKg/N32uz5/hh509c+Mkkzzz9Crp18Zi90JmMPwE5gC9lY3mkdWJEYAbgopv91KajUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742280; c=relaxed/simple;
	bh=oFLZb+2f3dEKqc3Dj426FJzCsxLtRW2V3ml2C8sU7JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2fErlE+v+p/r7ydVzdq8JVAFpX9bIDynKISft5aPvOmCOufNT3Zqf9d5RjuoiCk+0YVDLXO34QWE6tnNdhPZanCatbrRKMqfi3m3Ihn7zkArg+nSrVVmpY5UM+PFO3SR1xY6etW2rgtEarnNDeQKx+zpw3YoOhgUwlKFxDAAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+tlLYmk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0892e4b19so619787585a.3;
        Tue, 11 Mar 2025 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742277; x=1742347077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLcgzo5xr/0iG5n3K7ZIKYHwTAs6P/saBSWm6jDBLCw=;
        b=R+tlLYmkfZ8HvEQSGYinJnaHbj/fQvALto27bzaXSvd1lyDrbbMslr3dpaQx00GPfW
         uRs5c+IiaQV6grsQ2t7gx87QwNNUpx2wKynwSkx2Thep5uPqZX9FA++L8cLAvvooc+Ht
         guDt5XwN4g5+UBglYQqIeKoi6+/x1/x2fPzY++z9kHERQ5lrnBD8ELkRaU0eF9Y3Zt9a
         7BoAcvB46FC5Ho2ZeUF77lMSBRegYO2CIrM9qOpodQA0+HQNlyT2OTuFb5tNT0fsyngP
         pfQ5IHoZiFpK4lOUbgohsKA1LpQMHsdGSMoKOg29j/CwlUgKv2kVeJ/kEbpHl2S8KyQv
         2H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742277; x=1742347077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLcgzo5xr/0iG5n3K7ZIKYHwTAs6P/saBSWm6jDBLCw=;
        b=v9h3af8fflVOQrIAWhq+4MRTmlVayGwgz4/eWtq3AkbpoEuX4FGBpZaek36cL8BFDn
         +XzZNRm8FoHLp/pwFYmS8p2K6kd/8VqfxWQIv+9LnMYlfiVpRmcKauVb68UryZna58Jr
         n+3SQvL/9GqmIWiDtpdreFuTKrFXAW+2CWuQqLY7b+PmBsqgXDW01JMnH/8CKjDFSueE
         WFaDXGLzPhgzEwSRqIEJ85wRQoeLJf4e599JlQTiruk9VGWMGuBMSnp5AgIMZzX/DLqF
         PPWwozi2uBcU82gdtpR5oX7cuucp8rfCWxVYzGBi1pgheu1WNKIjVLkJQaSaMFUSxU+H
         oEug==
X-Forwarded-Encrypted: i=1; AJvYcCXAzniarLVva1tj8b4T3sa0oKSCgyfIYtIPRC9rtfATpMPYmiyUZ+kDEfHUigzu854PhcKarPxRkIm+mvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyzt+WRmP4Mg/McjHcqpTqbPs1K3PTncZy6GZgJThRoB9PCibC
	JJz64WDR7Avr87SJP4B3tHR8042AmmCLDe9vX0qnEWhid7BEMSUp
X-Gm-Gg: ASbGncsXesF4ChF58dNBI8wKQwkZjGRU2ZE7ke/06vQl44Q7USmRvBI4OfK9kUo/Mvu
	8ejq7givtpOe8OiSmQz2QMumE6KVo32XwoM7E3mID2hkNPFmRpDFHFL0Ph9CcjV5zlURrZNy6M5
	9/SeLx3N+rgLvpUjAUhDM9/P9wmpLh1RM4Lsite991lyL0jEmPZx1ZCH+vWuidyPAQ8R2PgWiEi
	kPZ6cW44D5c8iu8zBavYe7wft3I0XG32H/wEi7hX7Xro7OexMvacos9XVoN9+cWKTA+f/TIjs09
	wQTqzpGpMYBSCqZDwedHG6GmyM213o99da/WvDQXCSMWgFiKTQvreWgvJJRE4dhU5J/K
X-Google-Smtp-Source: AGHT+IELfR2KgODTKut+cF9OaKi/VD7QJ0DCl+UiguwJeYOxo4OQjvdKvFS5kKpmgA9CKnTebm0SfQ==
X-Received: by 2002:ad4:458c:0:b0:6ea:d393:962c with SMTP id 6a1803df08f44-6ead3939845mr213926d6.30.1741742277490;
        Tue, 11 Mar 2025 18:17:57 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:56 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:28 -0400
Subject: [PATCH v2 7/7] scripts: generate_rust_analyzer.py: define host
 crates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-7-30220e116511@gmail.com>
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

Define host crates used by the `macros` crate separately from target
crates, now that we can uniquely identify crates with the same name.

This avoids rust-analyzer thinking the host `core` crate has our target
configs applied to it.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/all/CANiq72mw83RmLYeFFoJW6mUUygoyiA_f1ievSC2pmBESsQew+w@mail.gmail.com/
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index e1002867735b..4832a4901c94 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -128,10 +128,12 @@ def generate_crates(
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
@@ -142,7 +144,7 @@ def generate_crates(
     macros = append_proc_macro_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        [std, proc_macro],
+        [host_std, host_proc_macro],
     )
 
     build_error = append_crate(

-- 
2.48.1


