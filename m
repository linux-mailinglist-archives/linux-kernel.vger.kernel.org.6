Return-Path: <linux-kernel+bounces-408566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DEC9C8080
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8E1F21F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC51E9097;
	Thu, 14 Nov 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3IYtLwwr"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CA1E8854
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550893; cv=none; b=Bf1kW/FHS1kbkoe2qkptEEO3JGo1oR4+Mc7FresBsPAUR95Li3GmZDoOLZOs/wFk2gxuCGTutGmzT53NbiJUaRRnjGqQEHLlgYFDPY7RsUQcHeTBZYuAtfX98ogUBao3i/eFWjTFoLiqjWzApTu4s0314E9UFuBYKnrnvn8KpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550893; c=relaxed/simple;
	bh=l49h5IQ0t73S/rc0W+6cvo1w2TTL6hTuKcG/fPLfsyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ur32VaKwtI21ooPJy/rN7/aXqFiianLxnWmxHe5+dsWBJuhDJ/MMYjbnBfHCDLjR+cqjaz7l8HbJG6MvhNu+3/nPhBuwySzCIewX35Hci5m2mg0z5cAWgyDzXzvijT83mFKySZ4lfR8Xp52WQ/2ssEFupyhfH4MEnSFJyFSlvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3IYtLwwr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c6f492d2dso959395ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550891; x=1732155691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA/s1VPnUH1BvCKkgOpgEavwwud/waK2bOJX2I7dv3M=;
        b=3IYtLwwrCK+RdeVeAAK/h27cCWH1HbPJbOSywyiZRmzARwNKtNZ2TxFl4pWnlIJdP9
         2BnPCI3CBrNvTLAHUQLROaPWFXn1AI3KbDvAnNe6vpRm95K5YGkz6OOR0KhtibJQNzHo
         GsYT1yqOoMDf6loWYhuBoIhe9DAhJKbKDbuo0Rf1CYHVyp3TeDWcN0Yh8B7RTgtV1pNv
         4kh5ESfZwRUyTUqWokf8s0CiUlbPnVI7uYEfhqWb6wXKyBmBT3Rdu8rD3pGV2mECp2Aw
         cMH2jiiyzbZHUzE6O7VMHv/sMQBYUWJglxLKWMQCI46e6v1MaCqQMxVypuDT8IeViZbr
         JlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550891; x=1732155691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA/s1VPnUH1BvCKkgOpgEavwwud/waK2bOJX2I7dv3M=;
        b=ZUJ90yQ8sCies+ixZZhlUTTsX5n/SUN/0NV8+VJkj1emV7Rc5snx1l/KXCR7Y6AiWc
         zylepD701EpS474ppBqH5ocahqbgE04HIWG0OYKIVFurh4taFy4BlN9FVgYrax7R/0UY
         caRQ9BzlYLJ733I0m/42/h5xHvKAVuTmZuciSGqdK6pHMdgrCZPp9djSTMgoKghhzgP6
         tVehJCiTbozjQpL9myWHSNsmEtmFKtCJIdkwlWIJVk5BttG4U+z3tEn+U4s28BUalBGa
         Mp8AhxfeY+XfsFosvSWUiTklqp313GY1fv4jrgVre8KZ5QrBhaEvjW9ZQM6ry3n/hl0C
         9ZAA==
X-Forwarded-Encrypted: i=1; AJvYcCUlDOE00J5GIQFwe68dPNzHZJRi67ZdPCgBU5UHydYleA7o8vLCAMcNJdpZlPaKTkKRPoJC5Mnb7eXA24E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g09JeTbpr43mw5Nzt3D0HKSEVYDwO6w8QaKivve++n/JzjhK
	e23akyTI4+OtAQ3smcfkvM6QhSUPDvU9nH9ODwwxNY7X5GwaEZevfItI7pG0YJs=
X-Google-Smtp-Source: AGHT+IEU6HI6i1xSU7kMiEnEP/A+EtO2rlfElUvguwus0woSmNASZDvVnaYZJ6C9Py5xrtSyABZYoQ==
X-Received: by 2002:a17:902:c406:b0:211:aa9e:b808 with SMTP id d9443c01a7336-211c4f9ac66mr6827425ad.6.1731550891627;
        Wed, 13 Nov 2024 18:21:31 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:30 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:08 -0800
Subject: [PATCH v11 02/14] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-2-236c22791ef9@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=l49h5IQ0t73S/rc0W+6cvo1w2TTL6hTuKcG/fPLfsyU=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3Pzti92kDtRf3HyY7+DsU7rpFdd6Hscsz11VJP21q
 fYOz2WHjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACbyeSLDP0O+RfP2M9e5Jm2T
 XiaRZW/3U0B5xj/RzAeNcz/t2ulyTIWR4b6M/tGJ7My7OwzTS7etNZPImdT35NufxG+b/PtW7Hu
 4kA8A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 8edc8261241a..c0cf6cf56749 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -26,6 +26,18 @@ description: |
 allOf:
   - $ref: /schemas/cpu.yaml#
   - $ref: extensions.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - thead,c906
+                - thead,c910
+                - thead,c920
+    then:
+      properties:
+        thead,vlenb: false
 
 properties:
   compatible:
@@ -95,6 +107,13 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  thead,vlenb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VLEN/8, the vector register length in bytes. This property is required on
+      thead systems where the vector register length is not identical on all harts, or
+      the vlenb CSR is not available.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.34.1


