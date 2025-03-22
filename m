Return-Path: <linux-kernel+bounces-572440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0794A6CA51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2001B80149
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15F234979;
	Sat, 22 Mar 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2WCoVkX"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6623372A;
	Sat, 22 Mar 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649847; cv=none; b=fPKDWxvvGvzhgFz4ihEL4iUQ/qcylxeNVc++kKGllVaa9t5m5pmmA0WzqdhOo3rgCTU8fYZslqZOriJWWtQbMCAm141uCaOZxkgRpR1tIpwlh3yzd0lNyqZvVsLdTjQ2v41y5vX+vplBk0OfLZgzsWfgUVjpgmEqIW2I9nsAO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649847; c=relaxed/simple;
	bh=IPTSB4OvnU1hoRdORrppmbVKYLtwalY2qqhdTyQcnHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPMSjbKO4cLr1WGTn/GQ1tZvt/UartvpMmRzrW0bXqsStEer4vy4ei4F+ysp1PXmYnhnBAsEJgDu0vJSOatuEKdxXrJgek9vXi/kKOgCvGApe8xfbKSi+/JFJFGyxsX6yGK65B67o1NvOVhEmMPCnwcrIDCZ9N9mL/sFZ2ARXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2WCoVkX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f7019422so23568506d6.1;
        Sat, 22 Mar 2025 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649845; x=1743254645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHCm5BoCORq75wdsfvlh1XDtgqK0v+FXt3AyKKFQnEo=;
        b=L2WCoVkXd4cWYcB56Ikozuwtufj2l1J8UZGen4fi33VoDgcF4yuFiTVFl6+Ly7KbIe
         Njqasz7eNPqXJ9SvZpxRa/Aa9FucVHYolZ5+NCt3AKDAjari737b9oRNX1dZTOHeltIb
         PwKFlUFMsHkdoopbjwFlASBg0Dd7nkJK248hzOLocab4UYvsMdRUAha8v9zqbC/4f8yX
         /WC5G7pm8N4chx71cgUFKb2WWV/Abd1KGIEWtTuw5gTfPkXtQHZiIANC9EloVq1/n2Vw
         S1LsN5dMVAn6LSnlpuou/i5dwkbDbsSgNEMI1BRgCLuYy+wJ4DOCtPgCne0XjyiX/ZVU
         jd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649845; x=1743254645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHCm5BoCORq75wdsfvlh1XDtgqK0v+FXt3AyKKFQnEo=;
        b=VvIUOiiJLo6JAugWjkMdNQuUtAIlbenXOJA/MddezWsRkJi9zkDHCdnGH8ktAF2vyf
         UEo5dfVMtwpuux9kNqkcKc0Xeb22cdEQq4P24vZl5wpxIeUQcfkBfABhOG2xA2CvDrr2
         qGK3LioqDFzLPVLYAC3+CwyZNW+cn3Qahw82nE1nrLjXirv6JxcTt0yyim9uev50Ypti
         gAs9A3n0uNzQa1GqNbhoQ5VylKXk3eE3mWwUc5vpKiDC26G7D0UawjZrmCGpdlRNXdsk
         A2d+EDszc9/o0WkdDcX3nmQ3knWqvWWOLE3x9PfdDZPfhu2zSBUIfjF8H1ZSdpB8xNT6
         cOxg==
X-Forwarded-Encrypted: i=1; AJvYcCUcoadBnfFhALDWjzPebHG8m/sJo8xcFw8kWNuZQd+m54PtTN4J6uaY6NiUA+VxG7qrml1WNCKZHFjFe28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyU47H+Xa60pehPgp0Mv6U07LMM62MUvXpYvWUUML/zFf6I7PC
	7aNa5OlMMnkAtREjy6N/FbZcDgtkXYe3HtfYwcfuCy4M2CDyD6wR
X-Gm-Gg: ASbGncvFJar79K08xfkTZjS8JXE9BQ0hsaboTj0ZqaI8oi/dIF+lZvRPw3zwvRa6kZN
	OsjUpB987Ust88+aqzydryATALCA+haL8bJeQ7y/7tRjTU7E9yBt+q702IG03xRhPldRZkY4tc6
	snSrTvcbc9L3vAetcHHCMF1KyOKeAMMjHHJPwADGxoJ0pGIIxbNIvT/oRwHqicACNl6x57N++aJ
	fmE5aaeLBRkiMuijO9fKs5CepNbYR7x7tS4E9s3JJ5Pekmu8Xp1Wo5nfj6JP6dd9xi3iscWKd/m
	hZuFliwvNY+6JHhXJUORmG2kdxoX5C2k6KGq3jmRZbH67zPbHvhnVMTXG4YBCZTB5rUruF8fRyU
	kTxewbFPy/xgPpGDU/HSbUramluwQYmXct78e/vl+SMXood6nW0uu8o6aeb24TdPDmVBa+hw=
X-Google-Smtp-Source: AGHT+IG2zIvcfE6s507MjL/Kjoh5xGvKoDdEV4mA/pE4DAY/4AViZhlo0TuGIrHb0A8/mNRdW/nZJg==
X-Received: by 2002:a05:6214:2425:b0:6ea:d69c:a22e with SMTP id 6a1803df08f44-6eb3f3399e2mr111924456d6.30.1742649845276;
        Sat, 22 Mar 2025 06:24:05 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:24:04 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:45 -0400
Subject: [PATCH v4 10/11] scripts: generate_rust_analyzer.py: define
 scripts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-10-1f51f9c907eb@gmail.com>
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

Generate rust-project.json entries for scripts written in Rust. This is
possible now that we have a definition for `std` built for the host.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index ccb15aa66929..957b413fe0b6 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -209,6 +209,19 @@ def generate_crates(
     uapi = append_crate_with_generated("uapi", [core])
     kernel = append_crate_with_generated("kernel", [core, macros, build_error, bindings, pin_init, uapi])
 
+    scripts = srctree / "scripts"
+    with open(scripts / "Makefile") as f:
+        makefile = f.read()
+    for path in scripts.glob("*.rs"):
+        name = path.name.replace(".rs", "")
+        if f"{name}-rust" not in makefile:
+            continue
+        _script = append_crate(
+            name,
+            path,
+            [host_std],
+        )
+
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
             with open(build_file) as f:

-- 
2.48.1


