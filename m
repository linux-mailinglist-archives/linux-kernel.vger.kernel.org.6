Return-Path: <linux-kernel+bounces-569020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42662A69DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8484673DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867551CAA7F;
	Thu, 20 Mar 2025 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+e8E4us"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0B78F5B;
	Thu, 20 Mar 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434549; cv=none; b=jSx80l8bIyOSl2yaAw3699AmyFwmAKm46BJsgMB+8sfoAT9nI1s8oPpnmhZtpQS6y0M43MZeMj3+qhKoXuz+YolHutNinJBqxZivuDGOhesREH2p2Jcbv3NeDfMoOb4VmB5FmfziS6/EL/hAQFu9YAu/qL7iycjg3+0kkbT/kN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434549; c=relaxed/simple;
	bh=7525e3eoJqomtoRV1Bt7D7RRP9j7P7vy9wIAyE+BzUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sVdJcsXhFyXBrlYHowVxGFyNDpV/9ON3NVkFKYGebJUp5dQKAmA6P6XiC81OI5FVbqvzVVdfWWbwP5a2jhnl8jaE2OGtf7GkrYZbOODpvrp4ffKDOHBaGa30aX9aeMAvxQPxry7POgym7+t17Zz7qZ6CXP7nr+RfTEbWgScP+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+e8E4us; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c547932d2eso18812585a.0;
        Wed, 19 Mar 2025 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742434546; x=1743039346; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNec/KkMxzLVOdqdkkrMoSw+e6khofSKMCyFDQBT/V4=;
        b=S+e8E4us7FTZHLVVQa1vd2Us+204Xhy2colWH0ZZtM/ieMmKWqiEkgzfIofMrbl+QC
         YjOo5tHpkb9cYkvEOKm318okN+074isxpI2RkIblbzMGoVG7yWimCm26cUEg1gGE4+vn
         Wa7ig9BTEk4dv7rBLphYQ1kR+eqkR+acZBc1/X44eVjMG/LK9whB84vGN+p/5JG5vHd0
         U6q6kEh4KdZQ3ascDWJ1hQI1Kl4KGSn96xbWGDjuo5uib2cU3pCiytbTI8/ubMSub6c4
         CMJQw98POU8wWbnSPHKGTJ6ZHUxzh4Kg47ktUAkjCGxbEu+PsEjeJDdmgoprcRKsR8/8
         Xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434546; x=1743039346;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNec/KkMxzLVOdqdkkrMoSw+e6khofSKMCyFDQBT/V4=;
        b=BUT0igEgF+vav1GOXcHC3ifwCQNzD8LWeB9MD52wqstkTCIVYyn87yzWnS76HwSyDP
         pgFjXFiaVUsUABpEzsm8PrFtbiZQNe8S1+C6h2VK/1/piIRdo76yksMWnASnCt5uui7b
         4Eo3EKSgpFFfaCCO7C64SIkHbAhCIvPe2sKG6HRny0iBM+Oqiw9NzFNPt6wff+amf9t1
         ZZO740Vr+QRJfO8ALw8OM4Wuj+jrGGEjZmVbbc5SSmJnrtzkbQWX2gcCJny4g4DVGBEG
         2P05eHBkmcL5ERAT2VA/5ZKP3XmN5OK8x0sJ+9+3qDiulHStP9j2q0UbZw79mw3L8DW7
         suGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHVfcSpPVBIBCD7Zmt53rfb0K5SbXcv4K7IxX/bZLkSswIZTWxHx+y93fNCG8iORmJhKQ1H8Si0qJkiR0vJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLY5UmATFgeTdRK03Uh+Uq+lqU1FJXeKAwbu8tSU1rMTyVS0K
	WncVGPzeplCV4ZClEcqLwZBCW8vfAGk4ZZoW4buCcvxMk/ubMqh+
X-Gm-Gg: ASbGncsJDcCwOMZ0YXyLzcs7sSPYO+U66QRtszxlWRmHFXbNkC43DQijLgzyn1MH03Z
	uNfkDVt7cPnIZoCpeEC+eDM6g2enlscfCKm2K3R8fPBksHWwyQWJ029vR5yXjhrUI9L0qgXNV+P
	1q4EehYFzGRsvyE/R93kjGnX5QcOQ4DTSx5D0Y+Dius51n2iZOXhCn5rEwKnPr2LvUzb79UGld6
	XST2nraFO+NlRIhrUla4tHR/ID211FbTW602yXTbQdc52b2q7+XWwX4owxyyCKyLqmBixaM5S5x
	32GZF8VCkCh55Mux0N0NAhEurqLjtQnK1rpn3w9X3IL2ab/ZOXsf/uMP4ivwI4t5K8ChYmH4YzK
	ySfiop+FsS97oF+q39L3qR52y09ZB1SEeKNQGtIofYkjbznxskPzBS4cTUUUfbu3MwSVGzxiz
X-Google-Smtp-Source: AGHT+IFUSS7Rm2X6okaNyD1UjCKmxvAwc7AOgLWUZ6RrB/MGid6lFLZ7AxsAdMnscA8ujtr8VmirLg==
X-Received: by 2002:a05:620a:25d1:b0:7c5:3b8d:9f37 with SMTP id af79cd13be357-7c5b0c9401bmr185292485a.30.1742434545623;
        Wed, 19 Mar 2025 18:35:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d72b94sm938468385a.77.2025.03.19.18.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 18:35:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 21:35:40 -0400
Subject: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOtw22cC/x2MzQqDMBAGX0X23AWTIP68SulB7VddkNUmsQgh7
 27oZWAOM4kCvCDQUCXy+EmQXYuYR0XzOuoClndxsrVtamd6PkRZVGJBhNdx4++5R/DUwjTo0Vn
 nqNSHx0eu//n5yvkG1HiyP2kAAAA=
X-Change-ID: 20250319-pin-init-internal-quote-b7e15e9e8233
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Replace the `#[path]` attribute with a symlink to work around a
limitation in rust-analyzer that requires all modules to belong to the
same "source root". This allows code navigation from `pin_init_internal`
to `quote` to work properly.

Link: https://github.com/rust-lang/rust-analyzer/issues/3898
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/pin-init/internal/src/lib.rs   | 1 -
 rust/pin-init/internal/src/quote.rs | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src/lib.rs
index babe5e878550..fdd95afe3864 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -20,7 +20,6 @@
 use proc_macro::TokenStream;
 
 #[cfg(kernel)]
-#[path = "../../../macros/quote.rs"]
 #[macro_use]
 mod quote;
 #[cfg(not(kernel))]
diff --git a/rust/pin-init/internal/src/quote.rs b/rust/pin-init/internal/src/quote.rs
new file mode 120000
index 000000000000..27a213d1a6ba
--- /dev/null
+++ b/rust/pin-init/internal/src/quote.rs
@@ -0,0 +1 @@
+../../../macros/quote.rs
\ No newline at end of file

---
base-commit: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
change-id: 20250319-pin-init-internal-quote-b7e15e9e8233

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


