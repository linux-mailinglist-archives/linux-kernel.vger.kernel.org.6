Return-Path: <linux-kernel+bounces-576109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC34A70B10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85C0172A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F42676D2;
	Tue, 25 Mar 2025 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx3m1ZsG"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617892673A5;
	Tue, 25 Mar 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933214; cv=none; b=A64KYtgx8mLjbRORBQJee+DJXC6RaXj0gyaskwdyaATKfzkBmfcnmm5OBbv4C/F4ZhHgiHnUaPSrZ5yOuIni2lZfK1LdcbmEpTsyFCGRpGJUuMusfZZllsooM6PGh32xdMFk95jpGsDlKL+b2uuFSkuSnChqDZnkcaZ/ZdStlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933214; c=relaxed/simple;
	bh=lUgi9s1wn0BEr9OjwyTJ1dJRBMR/y4zXaKJIKJEUw7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GltT5Ot0DV4mzn2+isBVr8XKL3YgzPaDGY04M3qsqn1It3hFHLczcIZ9E+GrKqugC7vwLpttAhfRbLrhzwgUqWewOC+gOfYRHHeMaS6nxbDDpbVpqA+vS2ATTYccbv1+UHXvA6a96jArA6pMXbQV/q5E/AEbMkxHbHe0WZ2qlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx3m1ZsG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5ba363f1aso679932985a.0;
        Tue, 25 Mar 2025 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933212; x=1743538012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROaKR9/TMWfQvq9QdXBwJgI4igcEQQH9s4dJNOQcxYo=;
        b=Gx3m1ZsGNv52SmDehJTNHgbgDXFz4jSWEykG+jXBtUdJ/+KSsfXWHhfoz2+b6rSA02
         2JH0Vkntbdzh0n4EHySgXzu/pFFLep7N8ZYf0HJOocpTk3BLrMckwMAV5iELfIDadpcn
         VhmGK6CIBV7m0ftoQUlsmRLZlDclTFbH79W1NE4HHrV1KImh8j0iVw5un+Sh6DlyCHaU
         F/VR3o1hczloPX8HiJ1rC6cqaHLacMOUMkmTf2SUo7Pbuf1AXoUr2Fx9UthkiJ19KYu3
         cOa8EMI1fv4qcJmZLHyKVlA9VH0XreD/EDXMDNlgiXgc2uM9MqmscpRUebQeLBvHbfY9
         6E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933212; x=1743538012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROaKR9/TMWfQvq9QdXBwJgI4igcEQQH9s4dJNOQcxYo=;
        b=KtmjXkw0VPK1UF+6afk7GOpHgVnnmGkyfncWuqxuLvmbjT7JlMsFq0pPHdn74Xibtf
         o1H6hqMU5dhtsJra8mpgAgpkx0TxVdN0sbkxB+YTJRmdtvk27txVpdnTE6u4TYspkldo
         XrOPJMaPTDZmL4v6RFLZV7/9KZ4j4rMfiq4dzb3mp3GFSBXPS7CCykYJdW36Ds5ZXkls
         5dZE8tUxwBoMW+hj8SWJqSD863BGt9lpNIbZBCvMtSCE4BXzOk83irKBhXh6USB37Kdv
         IFQB9sbfcnnP10pm1vnJHa8uLOvLjwmE7GVx51bv5L3pmO0OnptOufKG12gbE45VVthC
         r1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJWjbKFx9LC+pUZFUCizBtxNeKMTAVZ4Zb7AMuTw/pN3nIIHwzlQ71rlmcOdQ3IYxV1HBpGlf+r8N/BX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+btDybg6e9BJza3ob/1TRCD3pWM1iG5Lzld+atWf62ICu2XKo
	5BHc5CXnRCvQ1yX1piYqWg4YJYO/6GfyfH81czKp0XHugFJ02uZU
X-Gm-Gg: ASbGnct7UaRkfkSF+bM6DBSqK7Iqc7GOqcX8knS446ca3MkWZKpjiEByKM7GqcBW7OY
	SJBB2H7/VD/3xYSKaS5vgXvQa7jsjk8mLk0YaZAZNPab4yu8fJ7TRirYYsGkrwJ2KlHsMdkbaat
	nlvydQCJUGAanRXZ8NfMaWCkxEyC0AhENEVM19fOQNOsP77aordP+zGcnBDh+Gz1tlh6deklm4M
	dBZM0HVuyR7Uf1E5tmsPKGSTlvZ+u6Y8gmrfy92e6gdcd+tm9HX2g8RVYnO/8FwGk5uu2AqrEQX
	p6QBr//XtQcZ/jYdIi9aiWnZHDDFq6446d3LChwbSzUnF5xdlFRibDnsfgNUFEkV5JotPBV4r4S
	b92S3zPNGb0Fm6bwgK0M1Z+sNVpoZz9YXAL/pUC43fxLO7juzDzh1zmSLwV2eSYyB
X-Google-Smtp-Source: AGHT+IFB2RWbKXLY0qqR/l2xlYQFNwhk+NX3JHUEeUsyz/yX67nDi1p1emNNlwNAyf3voj/UpVHzLw==
X-Received: by 2002:a05:620a:17a8:b0:7c5:674c:eecc with SMTP id af79cd13be357-7c5ba190086mr2710628885a.32.1742933212078;
        Tue, 25 Mar 2025 13:06:52 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:51 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:31 -0400
Subject: [PATCH v5 08/13] scripts: generate_rust_analyzer.py: use
 str(pathlib.Path)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-8-385e7f1e1e23@gmail.com>
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

Use the `/` operator on `pathlib.Path` rather than directly crafting a
string. This is consistent with all other path manipulation in this
script.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index badcef4126cf..5370563688eb 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -141,7 +141,7 @@ def generate_crates(
         proc_macro_crate: ProcMacroCrate = {
             **crate,
             "is_proc_macro": True,
-            "proc_macro_dylib_path": f"{objtree}/rust/{proc_macro_dylib_name}",
+            "proc_macro_dylib_path": str(objtree / "rust" / proc_macro_dylib_name),
         }
         register_crate(proc_macro_crate)
 

-- 
2.49.0


