Return-Path: <linux-kernel+bounces-261737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863F93BB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC47E1C23850
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96C23749;
	Thu, 25 Jul 2024 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gtfNUgXp"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF631C694
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881001; cv=none; b=iTvOY4m96oKgBCVGxGOxi6sbf9Xca1+FzlpwFP0n9OU4aF/Qt5l7/JeOCOBft5CGT+XM+E8o+CplPez6C+zVheM0UQ03h7MTvvaipbmJayThW5i/C/SqsA4R4+yZi/ezUR9k4aUM89QQ742yj1N5MyGO+qxAVwURhM4dTzQSYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881001; c=relaxed/simple;
	bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tj3djuX+ryvxD/k1/DTf1brtvys43ERTgaI1U/OIYUc6EQI3ZDtnzR9k7S3p3ibWbJLNwkzckZDclE3NEERRJpSPp4a0fGD1natg+8PDVPkE9s91qBcoy4HMxt3zEEwsc+/gJAfCKSMyq4YbQKtXRXc9YnvFR4yq/IzeuZQz1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gtfNUgXp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so392966a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721880999; x=1722485799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=gtfNUgXpuCDsl6TpxoJUxuHdMffOlb253QMMlUZucHiTX9iGvfrwNV13GPxfaLli9h
         QiD8BkzAUskjs6M94Af3es/LIQbn8X52+N5TLU2/g+NYekh3IiGPYKz7PzLGxz54/Y7Y
         yF5JAxbXgm+TNVF2oerHPQ4nUHO7NXTy06+Aj42oInRcZPxtRYH4LtSWuTOgk6Ftm7o5
         vWuKFAxwvEZuFsTBe3xzJuChe4ue3gquXpOcWFGmj+Oag8/33o5tkZj1OdEVlNOCkvLy
         /eKmPoMo3mk7LTgtE8QLptouDShnrXFIeQh8LIo6POa9xgBLIOXZrlE1xv7a7XtLraTP
         OvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721880999; x=1722485799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RiVgzby/fIL0Kxxx3Y50ysZFHbsEJYdDMqDhTheyzc=;
        b=iuIkBneJmC/jYKwtPQckgeZaGeatcmDiZeEDD+JJQtR9T4r/Bb+0imRZjj7wZ7uGGA
         zEO1OuOcXrGfWb/WKY3FK7qtXyBFJA7b0VRo9Cxslz7VIee6My8w90bEjvMHjvwr9D3g
         Y1yZ1MYAT7TeljYn9Gh4v2VIngr00gfeiK0kCMDaqbLs1LpNABOLY87EKSbu5E/eERRk
         iMltx93AMQxUiQAhDxU/fJg86for9u1cINebhHR44wAMgPVbfqKaxCqd1KN2tEF++5ZD
         lKAwi70EIrBBcXpUjYJJhS5Ydx5kdnmchpeDFQ1jYRJhc566SVpzOibCM95UdBPqsE3V
         tyFg==
X-Forwarded-Encrypted: i=1; AJvYcCUaNURsz1pBKysSXSxad5eUWjn6GADFSO/tEZd1hdBDA6nBcmTw/nIgHEzubDTSNcGmsMecQxsxTD1kNolj8xJt4unUVYgNnIOMbI9j
X-Gm-Message-State: AOJu0YwrCq3B88Sd9+qTbMuJVAMmuD9G3ZEy7Gb4fjzkkoD3yi1afG+Y
	UuJfbsvYsTxWOa+D5m+V9K19EB6r0LvAn1OWjnN8NA7YYxEDMO7CYrmlL5mCn1Y=
X-Google-Smtp-Source: AGHT+IHBqouUd60StUuFY3y20z9rotElPmPvr8np0xp/cOd/5D5tZBs9q3oV3mBGdN2o0+1sfhUmuQ==
X-Received: by 2002:a05:6a21:99a1:b0:1c4:231e:8ee5 with SMTP id adf61e73a8af0-1c47b229b19mr919358637.29.1721880999516;
        Wed, 24 Jul 2024 21:16:39 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm3781825ad.205.2024.07.24.21.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:16:38 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 21:16:19 -0700
Subject: [PATCH v8 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v8-2-cf043168e137@rivosinc.com>
References: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721880992; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=lK25kSvuXBbjCsm1KOScKY69sa4rMHinL5Ye8aockR0=;
 b=U6hkM0vK7Fw/IQIGJFsZnHJIDTo03z/90pw0ylmD8Hl1YapQisvOP8xIEUjrga2P3in7QNuEq
 K4vTINX6W0gBsmwtfDrGgJt9ujpdnjnf1swACzykXFrMVEH2Gorza/1
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
2.44.0


