Return-Path: <linux-kernel+bounces-277118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2F949CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F7B281219
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA917BA1;
	Wed,  7 Aug 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1x2gswqe"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFE168D0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990711; cv=none; b=qaVEg1D2MA7ixjX0n1wlGVealCLJWe9UD4DX/uzyISnvhKt3/om6zHf8PDN6xwkQRnnzKFnpmRCj/9txQVE6w/HgtEv0EcG8ws2Sk+7doNEblvzOc62a0QJi7f4zRUrH7pg1Gl30+ZtqMmF8FJFouJznJgYchWa1pfp5IMNvqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990711; c=relaxed/simple;
	bh=g0Gsy+5TQh3RSmd39xewdNDSsmzEd+HtR+40T1Y+noY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAWg5Gg8deSrg0IWHjT08yUHHULWBRSUmrFblE+oOeBVMbkJnAJJFRb4HoJ/BnFsQ+T1vzxj7VFgKpqUH92jGm3taU0LvUu9yu50FLb4zRoFH9atfjN+ZIF3Z9QDnD79XXQoZGsGitGn2EEqAizM/nrbQa0nICVTp79NYcHHKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1x2gswqe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7104f939aa7so942499b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722990708; x=1723595508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8a31h58dvirjjptvxje9y9Mqcx9iPDZwg1ciuyTglV0=;
        b=1x2gswqeodw6o4/35Qjn9dT7qHbeo7+8psiM7BQ+Aq7LFmWus0gq2ApRgG2E5wczSh
         S9czMbQCUi96ptLy6k6rSnugIgvQUM8G1Spl12WhDxsu7LUZtSIdigzxELUcT/dvLfmv
         wuMDWYETJCbRzvcnUAzLwhh9hKy5Xba7TgC9sMLkN81QMQ4pGb3sx7IVkfw8WGkhLHDO
         nkbIxkmC0u24dloYykwSLkqL4YANi/27yYq3RlsR9ymH5H6/Yd5IW8+feFzoIEFxQJRj
         KMWcEW1nK6VxJfz1SP6Dncn6cNhlsWAQWqVuSodBuJok9HQ0jKPEXNccT+/xj+dusUNE
         s8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990708; x=1723595508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a31h58dvirjjptvxje9y9Mqcx9iPDZwg1ciuyTglV0=;
        b=XKc6nfF/p9PqTeCBd0cs+XFtBmiTkqXECYbnnSafUqpkCio+KDcW4otqoseUmjfNZA
         iNnJ1RoYc0wP2h9n+9RCMQMXbGT+uVQMdY+XRihUc/uNHarFesUf8Nwh+366iHGYW80E
         jwo0iKFeh558BTWydbWvKMji6VCyqmTNc7WrZq4grFbN8qQbdoa5QBCdHRkcFEw79Ek0
         Fmy0zy9mi7pnMojd9zqpr06Idax6NnJH5qZC1Zi3VrjPvZTZbjiFJPkz0oWVUvgHBwOl
         S8DpUURoCrjderO+vsZEzMi8+FdYrjq1dz0in9uKXQ1ps8BhXZ3wwaBAE03llQ/q63Ah
         USQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbfGk+XRJqULTVuJi/yl5jHF0JXhIgYYGxZhuhwABj3OXCrB7dVsE32gmnu5GSA8Wu0+MgJBDZIRQHcT+78e+NX1Lo3NqfOLhWCUjx
X-Gm-Message-State: AOJu0YywKYybFyxvqbmouVN3AID9O+EdciVJd/JHGBxccA/waeOm4qFZ
	0+deZmjRarIEgN+43Afo3MJKxh9JYZBj1/oPcxLqzEe2YZWsO7mLWUW4F8jAbvA=
X-Google-Smtp-Source: AGHT+IFlZgOw01pjcMoUd+dM92axczabu39jYLZiTwPJF7kvu/LR+bRd7eVCTv14rSm6HVWFrxdAGA==
X-Received: by 2002:a05:6a00:140b:b0:70e:8dfd:412e with SMTP id d2e1a72fcca58-7106cfd9d29mr20899556b3a.18.1722990707845;
        Tue, 06 Aug 2024 17:31:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm7476174a12.6.2024.08.06.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:31:47 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 17:31:38 -0700
Subject: [PATCH v9 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-xtheadvector-v9-2-62a56d2da5d0@rivosinc.com>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
In-Reply-To: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722990701; l=1911;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=g0Gsy+5TQh3RSmd39xewdNDSsmzEd+HtR+40T1Y+noY=;
 b=N+0Xga663TzEPFBOSLMhnRrEEwkQ/6SLmoDaPhoQWHjLrgqgonGuO5TdqDaKrTXvQOAb1J3CO
 rYW8rc78xHSAy4uY9OvfHUczaGdel8ciuSTRy72vsYUO4dE58ItO39R
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
2.45.0


