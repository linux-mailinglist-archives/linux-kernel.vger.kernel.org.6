Return-Path: <linux-kernel+bounces-572438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15DA6CA4D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB5A885100
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B407B23371E;
	Sat, 22 Mar 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs7NiwNn"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A568233140;
	Sat, 22 Mar 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649845; cv=none; b=UPuPiv3R+4vRvW/oF5in1vZm64gab0iSiqchok4v3/ZlfubWeVGKN56aqGK96T/pFJerJm/IuLiobPZyC2M+IgWNv5MIRKS+x2HRWXgZm1M+zv4ejy/RPcx1SyPF4a02YrSywJ7dF0NHMq4tsXuFb5zVyrUYz6Vnk4/qLqhAz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649845; c=relaxed/simple;
	bh=3wODLeimCnVrXqzl231ExCWdx3tgpUea5+rF631858U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvQTjRkizybpBoCRoSOjS1tLbCtJ3RyQptjY839jxEc2Rlx03Ilo3icAri29yG5Kn6ipg07zeacir6dNkiBxf9+y/pSE1QK7PkuT/qIz5Md0rs587vWPZxi4v+gAlgH+FtYUiZoshv0SbxmhSPVx9mahNC4bVztnMC8G3FHoE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs7NiwNn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6df83fd01cbso13660496d6.2;
        Sat, 22 Mar 2025 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649842; x=1743254642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmbmoDyAJuXoP+x5sg6d5NNeKkveq0WeCsyYBEVobE4=;
        b=gs7NiwNnPee45n790BZaWwwChefDKR3M/V7qnYWVt52tNwINVE0USkah7PKT24c4BW
         2ZndurcdtlTeOyxXlDbJIlMzfoDKk0mx/tj1IUcfR23kiahDyKAjDj7KvWQ4XOkjK3Zp
         mpGwcqiJmMLxeYpSrstQYxGAKhnQGg5xp5A+E/yXjdR6W9WccPd3J8AwqFvIwTSQHiiD
         7n2OVGMtuObCJuLMod6kvsA/DMxN+OGSh2EEFg1APde1GRBrwGCZfKUsnPgf2Iz+edua
         +BNLBK5s2To6IR04t/7qQdWDiXNN6S0XtI+0dWjnMIYa4g0wTLHR0MR8+/CTJUmOsjg2
         TE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649842; x=1743254642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmbmoDyAJuXoP+x5sg6d5NNeKkveq0WeCsyYBEVobE4=;
        b=QkvN1AsAF8gJcAjUnmpPiouOcZQwJZXjxaETd80jQKoVya3v177DKKVzQvaacScq95
         GzFxkkDi8SxJZQLtz1b5c8heqkS/u44bkIGQ0hbdx7wDFd09xntrYFUtc4fbtJ0Iw53h
         tMsmXuB+jGkzy1cWKJb0oyBmg0J2TNll/mRRAccaFJAbJ6MHUvA+9WH+dB2wieOIX4sL
         SzcMcWBfhr7QlJvzrzITd2p+VHNBJHCAXFUyyW8KXXD0NXUzLZxLH/+TF39DxMnUGpNy
         3Jjy6NePEMGp3CjIisvoM/uSZk9r1O6U0TFrA2tZiMwggVvC7uqtFZ0NYqnbtoCAhYbF
         vE+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOlH4rb9Em9gM7JI+an4QMGmB/+RdLAQeAI2yEVd65GquYnvrimXuLKtL8EhEXw+f0MWaxWaqDnFQdFlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbzgtTXEYgPHpDm36MZ0UlsYtfNwg7sr/5MtsZZqBox3/djgB
	Cv/EzhjAvp4rbjTFpYfL0e+kBNw6nyvg0o4pfWXfxjy4thZ/22rW
X-Gm-Gg: ASbGncsLFtqbxQ/YqpvSOCtZnSdw4VzppBNWEcM5ZqvUGvXs1wGDM9uW4N5FN8N0MCl
	Fr/o3Ym6mFRgwkjQXDOYiRf8arQ+1ir3+KcKhW9nVsJxcbBvWLUA+OBfMJVVAF0J0pEjCwvm2to
	2q10Cv4MoMvuk8dM5/DSL62K34xtcEy2fGSdfXzFTsQhbZ264nRy1q3zOex89jMRdN2I6HeGyXg
	M4Vl+kQvvqDRoiRW3rf4jv2QGzMlaixIMTSsMHl0Hbdf1b1I+op69CuILl2+tvNTkPkxcqvcWie
	/L4knJrxJXEKW7jDUszFtfXkTd6nglBAki8RA1gagJJZ6UTX8NuvNfUD/u6u+4EJ7+/P2lN4ob3
	V7o3zSOzOnbmU0+rcXuNcGRgiCvn+j0p3G4fHG/P+jmkbh/IB6NrV9oDpG2OBjsaq2vZrn0o=
X-Google-Smtp-Source: AGHT+IHminbwPJfdIVUI1jqdSq7TVcJ4gkj2F07fQgPbyTKfEmaGAlJkb37hv4VcSuNOpS1Qthgzfw==
X-Received: by 2002:a05:6214:f0e:b0:6e8:ff46:b33e with SMTP id 6a1803df08f44-6eb3f3543eemr88229956d6.37.1742649842047;
        Sat, 22 Mar 2025 06:24:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:24:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:43 -0400
Subject: [PATCH v4 08/11] scripts: generate_rust_analyzer.py: define host
 crates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-8-1f51f9c907eb@gmail.com>
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
index de1193117161..bd6e321a6aa5 100755
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


