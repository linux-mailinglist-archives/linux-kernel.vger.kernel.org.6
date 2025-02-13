Return-Path: <linux-kernel+bounces-512108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E7A33420
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89E5167ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE54CB5B;
	Thu, 13 Feb 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFxbrUhc"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D1070810;
	Thu, 13 Feb 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407146; cv=none; b=cjD0Ga6XH0Zary68zCwQWlgVdnGJZDYFxudkrS2ysvsdzI275hXyxY9cQC3d7QoKhuEKP8N6PYPu0XhM/yqUw6YrM6P6sP7q5mfUbKU6ahXN0BE/ko8GEeQyhwoV/erSKDkZOjyHOxMTq/1mybyp1iFJFDUfCr9agjn/YMuvKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407146; c=relaxed/simple;
	bh=a8Z67QJdO5v3ffSQOMXQWEvL4DdnSxV/Mk2ayYeqQ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORF26z8VbRTsbaBOIsLPZcCU8Ajo+Xr19YoK/g40ph5Ye3eVAU4IA8Tg1O/kmVE08kL4CrOmkKuRn5/9B8fp0h+0aj/MoYgyxHXSH5DaibzequvexhHDVnGvN+BEeR4Ig9f933nkxLZqYsDYSX5sKy/JPC0YDpTT7j1HDNAHXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFxbrUhc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4719768caf7so2344991cf.3;
        Wed, 12 Feb 2025 16:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407144; x=1740011944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/dVS4QIgcS+IuNnmD54Uf/v25I+PAzsTeOUn9AzZIw=;
        b=eFxbrUhclQ6sAINrhjRaptpDoNKvvD361DNv401YpiC4QS+tbhmYrnZomEtWeB8ZME
         eZXIfxzt2ce7vOK1btrhKZx9975KMzhWAb8PRba0C3IlkwxFLdc32xt6nfZanwLkc0lI
         N4qbvY6oOtFAf64cKAGq5BI3baJ6urjJgZacE0RU5SVzOFc4fxnfSmjsC+fz5+I13lau
         cCw8SXPtS5EKISkNynLLa16+cNLbl95m4elMpxL/y+slybxXiPAi0ulh+7x75/1bheX3
         Vr6oZzNp61YiVbliguMPxNcO3QcG6Y4WMix2E4Na8Wcq0JniNk1xjqCIU/VgiZ9r1WMW
         X5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407144; x=1740011944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/dVS4QIgcS+IuNnmD54Uf/v25I+PAzsTeOUn9AzZIw=;
        b=K5W1e4siuX3sVFZiIyBjuQTWIeT7ToW562YQ7XVUcBC0wWt+XAK0eP99if51vBfFwU
         giSLU8LpCFcdiiog5ZsPfoIIdUeVrt5gRIXkyNqd5wsUonmY3+iDs4aTXHiKxtUxi84c
         xPvY9SSmkunUXuqK/tvyfOTHagRu5bNPZ30wINCLmTEf/a0DJas+RnonK5qYS5316I6t
         GPlYZwCJQ+fLPTJiGWON0rG9AP5DN69iuFa6umWn26HMMO2F7EB6oH5HyVutS+7XKD/5
         gh4AtMKdvSlB8T7R3o5naWzzyziZ37xZ+wlG/E9MgyQ1Vs9PjpB5Ij72j+2xpEChyE35
         Un2A==
X-Forwarded-Encrypted: i=1; AJvYcCUkBAeUPtZ45ADcmUeVxnBIbdb5Tw0WLwdlygqm5dQdzurENrBhcS3bZbOx5MsoeH/Gmd0d/BjThV3I@vger.kernel.org, AJvYcCVbQJ6anGObOfmJwoHIWdoMIZDT8R+6Qhj9QwC/mIPG6pspqrAA0qnMWmpHdznbJMGLpCzR2mNmPtL9hDU/@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuY74wqsWBfPyo6+EdHg/tIFV7pO8Z4OxzNjtKBs52hmNxlLU
	5nMU1lbrvFzIk3ZX3HRn0DYuyfwhNsK3/U1aVyCT5hA5scdP/Mis
X-Gm-Gg: ASbGncvqrwoOqLgsss5TKglBAO67Ec9MuseklbkPPrDUSLMm4HuCIKZ/+UtM9V7JJOw
	0li0CdBNGBl4Rw/QSPw3tFW72f+6iX0gcxEhbPp76yqaW1or2hkDL+l/yOd+TgcxuCW7pWJe0ZQ
	LH/yxLZhHJJAmSPvP/3XIrsrms3qrp62T7gh1zX0I7Gbfm83110gz5RWmYiSL7vTTKJ49+RMJIy
	9WRQbgfeuSGUBmX/cU3X/4/Gw/9KZGuIaB5zBTe+zbL/oxJgLp8pjAZO1eT8dXAcrw=
X-Google-Smtp-Source: AGHT+IHspWsE6z8rbANPu1J4EJHGR6YUyo3bjSrXk+tx6Wy/U/d08EMp+rHEHGe9CzvstZnDSmahbQ==
X-Received: by 2002:a05:622a:1a1c:b0:466:9d0e:1920 with SMTP id d75a77b69052e-471afe5fa85mr71820871cf.24.1739407143682;
        Wed, 12 Feb 2025 16:39:03 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c29e9261sm1302281cf.5.2025.02.12.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:39:02 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: riscv: add bfloat16 ISA extension description
Date: Thu, 13 Feb 2025 08:38:45 +0800
Message-ID: <20250213003849.147358-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213003849.147358-1-inochiama@gmail.com>
References: <20250213003849.147358-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the BFloat16 precision Floating-Point ISA extension,
(Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
("Added Chapter title to BF16") of the riscv-isa-manual.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a63b994e0763..f26997c3d34d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -329,6 +329,12 @@ properties:
             instructions, as ratified in commit 056b6ff ("Zfa is ratified") of
             riscv-isa-manual.
 
+        - const: zfbfmin
+          description:
+            The standard Zfbfmin extension which provides minimal support for
+            16-bit half-precision brain floating-point instructions, as ratified
+            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
+
         - const: zfh
           description:
             The standard Zfh extension for 16-bit half-precision binary
@@ -525,6 +531,18 @@ properties:
             in commit 6f702a2 ("Vector extensions are now ratified") of
             riscv-v-spec.
 
+        - const: zvfbfmin
+          description:
+            The standard Zvfbfmin extension for minimal support for vectored
+            16-bit half-precision brain floating-point instructions, as ratified
+            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
+
+        - const: zvfbfwma
+          description:
+            The standard Zvfbfwma extension for vectored half-precision brain
+            floating-point widening multiply-accumulate instructions, as ratified
+            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
+
         - const: zvfh
           description:
             The standard Zvfh extension for vectored half-precision
@@ -673,6 +691,33 @@ properties:
         then:
           contains:
             const: zca
+      # Zfbfmin depends on F
+      - if:
+          contains:
+            const: zfbfmin
+        then:
+          contains:
+            const: f
+      # Zvfbfmin depends on V or Zve32f
+      - if:
+          contains:
+            const: zvfbfmin
+        then:
+          oneOf:
+            - contains:
+                const: v
+            - contains:
+                const: zve32f
+      # Zvfbfwma depends on Zfbfmin and Zvfbfmin
+      - if:
+          contains:
+            const: zvfbfwma
+        then:
+          allOf:
+            - contains:
+                const: zfbfmin
+            - contains:
+                const: zvfbfmin
 
 allOf:
   # Zcf extension does not exist on rv64
-- 
2.48.1


