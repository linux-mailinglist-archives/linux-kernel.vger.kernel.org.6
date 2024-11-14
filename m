Return-Path: <linux-kernel+bounces-408575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8A9C80A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C97281FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC71F7565;
	Thu, 14 Nov 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jQG/azRQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D671F7544
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550915; cv=none; b=eOjwXrdeBUi87lu+c49yr/HSuLrQfar/3MykIGFKxfAbodW/i3FZv9UBasvcrAyNWis5Lecvl4KfJH+uEOmdsvgNXm5azj0oCmYZGUy36kk5WXsgxGrZy94Y9h5BU6qlQkk7AlAAckOMG73ZKpOv9q2cibKEezqPO4AcMd/hHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550915; c=relaxed/simple;
	bh=TcqhLbjZS94rab3lMFuoSS5guT4Dq12UlcROgKWQAqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYVpMvtg9Uv8FAJBl+Q7H5IGbcxci1+q1IMslPeN/1L3MBJrTRrgr0n6xcRvFNh49u8lsbwMC5rDCCJHV5AFrOixakEHj45FPGTAXEAZE7r78SAFacNY4rFUSRSD8IUw9p8xyHPUnW2+qVG+kao15uXXBarMAgPqawjYD56o/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jQG/azRQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c805a0753so792855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550913; x=1732155713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqDTg1KZkB7odLaldwlsY3X0o5v8+LahAUJDMrZrWAI=;
        b=jQG/azRQxuZGSRUfuUThkCHrJERMaAGIyzXT1AXg/0VwpsvgVABrQIF90fACZhudVA
         Fu/uYx7TrwbAF0Hx1xVlvoTfp6ghSUJExEJfZiiHj0uq0pgzIgj8Vjj7P9NN7d4WWX50
         8QyF2mOtb0ApUGomgBMfQyR6CwVsAg3ikTR8utcZ/K+Mmdx7ltJ3rMBT0U86/qBahnjS
         vFnQBQKZE5eh5HZxp2NCYKVPLWZ0HWuvs4X2ARZZ/b48voq0wPEE6vy3EOLOqdh1Jd7Z
         5PazF13y37xE8/uCnOT59RInuwFfoyytyXB5s2j9UGTnO72KFpjVncDImGqcsxVjc4Jp
         eeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550913; x=1732155713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqDTg1KZkB7odLaldwlsY3X0o5v8+LahAUJDMrZrWAI=;
        b=J8/7nCZRJ+tjI8kkos3n77igQrQ6Nkv8NsD3cIhmuUKupSMGETgnhDMXDX2+QPO75a
         m9qMYSc+2tfLpGvByf2s3MIY+fJLbqw3WSOBcR1Nd+X2hN7+ZDMUvTDxvPg35iDujXgo
         cTlS2qnNzYH22GhfoXnOCEEdql+0daYr7su+R39x2oZlpJW14JBXRKPYzsSfRvN6MTeC
         xp7U04gcWMi1ooHVRzuwEa/BlIBu/7kISwNnf22fzK1g41FAV697CqecKdOGS6sKQZk5
         bFPN9LjrkcREbEktZX78Zqt7FzLB9cjJJT2MoOsP5o0eYCvnHhcIkbeth0EeSyzEszR2
         SxXg==
X-Forwarded-Encrypted: i=1; AJvYcCWlC9f8dUXo6zGH3ORAdF/LM74Q4sb1SjW/p12LOeaUeCaUzy0Ebh6VvukiUftYWmQoElp5KJeevrTarHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykU53v9bjrOzWgLfKac+xdBmLpjySgqyHFmyMNfuT/2bzdYGcB
	ePajzUonV+N/UAUCHOueEcdACamw+peYsGKr5GlxQ1gKAd4JXivDHHR7sbZkPR0=
X-Google-Smtp-Source: AGHT+IFm8P5gQRIsex2aGKwaijclDQhZLDLqCUSJxuaYbddepl2T/jxyWcTLByELALqocZS7LjJ4oA==
X-Received: by 2002:a17:903:110c:b0:211:6b37:7e66 with SMTP id d9443c01a7336-21183d1b72cmr310091305ad.17.1731550913319;
        Wed, 13 Nov 2024 18:21:53 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:17 -0800
Subject: [PATCH v11 11/14] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-11-236c22791ef9@rivosinc.com>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=TcqhLbjZS94rab3lMFuoSS5guT4Dq12UlcROgKWQAqk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3KITMZ+Y2BS2evyNn8SgyPJ1Zmmh9dmf1hKpPhu53
 xi9fl7ZUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwERW1DL8D7da3SP/YNHbBu/j
 Qr7l2tvN3ObHr/lro6v4JDB066ba64wMW/XWiTLlHKswqle0vF2z/Fx5NIu7nkOZm+EW2cNaHxe
 wAQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 955fbcd19ce9..f273ea15a8e8 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -293,3 +293,13 @@ The following keys are defined:
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED`: Misaligned vector accesses are
     not supported at all and will generate a misaligned address fault.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.34.1


