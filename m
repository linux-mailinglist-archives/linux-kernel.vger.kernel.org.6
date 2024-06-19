Return-Path: <linux-kernel+bounces-221875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8390F9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756E128459D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91A15ECFC;
	Wed, 19 Jun 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="X/6KfJ3e"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C015CD72
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841453; cv=none; b=fHXiQpTwScHZdVTeEgPgjwvXAlwb/2p4hPkRNnKkLWDwtUo2ZZucdyEtU3iI6F0qbsUXaQ45JfUxqZGkyaAbf3QceJmFFfgktFDL02FM8v+CQml6M25VDJH+RvX3m9bD9nVgCni8t/sgvSBlslg2tFGxDGmBQs6IpeQQxJJD7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841453; c=relaxed/simple;
	bh=AcYcvjjFWiKhiKAl88lWRz1HvD4LxurkZU44w/pWvNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwZh+WbnMEdiEqEfjGf+th4io0dW56orNmrVWpLcRlcsckhi8ISdxyZTqxEhb1fq2N+McWSb/w7P1feucDOmHqtOeIv0vXIKYtD5xDKwoBNcK8XuoTUhccY3e7JcPqE7bLxwGteyhkNYrFGcxZSh8O5+15H2+/M78HZaH2Pk140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=X/6KfJ3e; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so1008851a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718841450; x=1719446250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PelCoZIE6iF05n1jOzSStOEaV77ZcPwwfY9j6HR1NNo=;
        b=X/6KfJ3ehFhqRTL3+6Ls3D4ll1wdMg9XzbcocSsw3KcMOJVfD9vRz6+H8tTfb28KYi
         ZqOa1JIeZHV3NpN0iwTX6A12n43qIy7KVMuJK8n60xSDTe0qp9HAOfkWf/EaLSBmmqMU
         PMlq8JOkqybaLbuHQU5RO7EbYLJrR7fjx+W+xcu9Jxgky4jsy9m9dACJ1mOyGPFrh8jJ
         BlQ8wA8HWYkpA+anOxGO2gfpPKWcq23CqxJnrmU63ujblsRQ5OK33ua3nCiN/S5nb0X5
         ZeK9O6AGodywz5i1d0DLhe+gOIZP4hkqLu+hqE0c+kBXlu3iamWwsNNRNiEbgDuuIz70
         gM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841450; x=1719446250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PelCoZIE6iF05n1jOzSStOEaV77ZcPwwfY9j6HR1NNo=;
        b=NEf5IxBTtP7HSaa8r+JrpRYeBuIgN2itSIsxAPb5GVuZsE0yv0C98QDL5QNatL8ERA
         3kT3FToNgUgLVz/tLUjpxZN5JqaXvw7F25wQX2vacaaGn0qClO/viDfO2phHb78gk1n7
         iaAn1Zyyjbzm4GjO+g6xZI+GGLWfheK1r+4Bu6S1gP5JDhOhPt8bKHXCE+rYMBAmuwQR
         8Itg/FnMOtMpYrqGuVBImatetPkPu761fgOnkByLgU6ePz7aRHHm5kfrFNSqR9LsSkwO
         phz7qUkxcSrL+p/Ypte7XlRG1U/3mms2muTPGGePrUiTB08qTAi49FoeijdKPCX01SDr
         2avw==
X-Forwarded-Encrypted: i=1; AJvYcCWth2UYfzweXCecoBg0+uu7jUE8GPWgWYr+ImzQH0U4g41f3I/hsIHuXyo6weHBKPA7yGPhxTC8nqa6N6XkbJdSxwjh37Ci3EslpcY5
X-Gm-Message-State: AOJu0Yz6skIC5VVIGKdDPEW8g58jaPTzJGGMiWMOosHbansji2FnIvxa
	0PyDRfmsO/WCuUxEzeFqGyV/CsOAUSpLkMGKVK2lpTjtQDCqcwgfO7gSCuhkNCc=
X-Google-Smtp-Source: AGHT+IGKiOHqo/xkEw31TNBwetx6wfNgMA1oKjo5fAWCMWu+48/TKV0DOjQRPhYoUq0jsmdx6frb+A==
X-Received: by 2002:a17:903:8c6:b0:1f8:50df:548e with SMTP id d9443c01a7336-1f98b28eff9mr98856635ad.33.1718841450144;
        Wed, 19 Jun 2024 16:57:30 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70ae6sm123620745ad.71.2024.06.19.16.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:57:29 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Jun 2024 16:57:15 -0700
Subject: [PATCH v3 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-xtheadvector-v3-2-bff39eb9668e@rivosinc.com>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718841444; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AcYcvjjFWiKhiKAl88lWRz1HvD4LxurkZU44w/pWvNk=;
 b=A9QBmc/bNcCzD9U62u8M5LqntgqiVYoO6pMKw58e5Ka8p8moOEMLez3mAwOBcj9EOCElapzC7
 Eek8Z+Nk9vABMXPKzFBZzvHdV3ycLm/UMw8VYhvueinEAk91PEb9I0/
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

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
index d87dd50f1a4b..a6bbbf658977 100644
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
@@ -94,6 +106,13 @@ properties:
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


