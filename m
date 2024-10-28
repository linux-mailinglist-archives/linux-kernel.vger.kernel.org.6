Return-Path: <linux-kernel+bounces-384232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43719B28A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BBF1F21B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D19191473;
	Mon, 28 Oct 2024 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k39pI4Re"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35710190052;
	Mon, 28 Oct 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099897; cv=none; b=o/mScMPse6dCujV3sWcQJg3W5DqHHCKng2lUy2U3av10i2O77kDDLpdM0mMiVhbIaXsnXXLnxHdgxUxX8tXNCcRkKndsofPmpSlSjIX0vTa6AHf66kiGRFUkOIc0kiBXQLklsS5XlpEvnS2AFzukHs6XWvMGXNgucQJ4DTTPncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099897; c=relaxed/simple;
	bh=TebZqSPKVqyKP7bCiCs3wWrC0grssWV2aeOt4sHyoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owpFD6isqQSWGFfrnkp8fIxiahMPftjN/B/TtkE14MAYW2RyjNK5SB4hZBb0qFp6epRwuydQuf3grLwHZ8KdiFe+dtNbcjYyUlqeojlJ5IbJpFUilb7CZ/okE5OTMcY0CpCYgCtz6sgEiK7L8YS8tvNxEE8l80Rk8fuRcDR83fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k39pI4Re; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e7086c231so2963372b3a.0;
        Mon, 28 Oct 2024 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730099894; x=1730704694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHcOCAQRVF6wDwCpz/Ofc5RAAihYPSYxf02RxaoduNk=;
        b=k39pI4ReOtD9CZk5lWcReKfZF9u1dmpvc2PTs5c1aBKOhzXY9HwyABnCUg/4WJUwcr
         UGKcEM5TmlGI+UGDO4tdc4YhOyOgouRsBM5oNVOeYIgaiLD1iIqT3O9MQ47yc1ZLybhX
         6LvVZlMaknBgHk2q/CqFu16vROp2pKeJ1+rp1TXVzyxwv0qljtTTkJvjl57W75wT38Bi
         LnRynsaQXwhGiMLkKtEN15GcfBgwbxumS708+mwmSmfaIkzZlUu7rXQv6XrqgyUGzUwG
         Nf2ZNtT1Axi7OMIzmkwUl1AKnWdmfHo6w+DOVodzaILBmFVv90dEn4yp3JDhOe2jSnty
         81vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099894; x=1730704694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHcOCAQRVF6wDwCpz/Ofc5RAAihYPSYxf02RxaoduNk=;
        b=vdfF4qgHbRv5Rm2siMhOAr9bcPU2/CNvJzuV5Lb9/J6FgYtLtpsshLhU+YeoS+OSHj
         3ue2+/jpupeqPDAg4pLZXy/cj1ag2XOTXjYuxoryk50SWRpryfblA+EzmkplUoeHEEJ3
         LJp87doh+GjclEWepzAmQfEcbRFlohNQiXDKMxc2NNEpZ62xetU4TFxad8NSZj4O9r7D
         47+jzATfW++nj84p/JkMZ9wpWBpBDXmNWuReWqCeRFHYPEMtfgdvZuizuJeOA7zpoXes
         vgC+Z3g1pXda7Y9KVOn856L567wWJpO0hSxGUlX3k3LaqcnOBebPQT824pzzzGlLJS8B
         o90A==
X-Forwarded-Encrypted: i=1; AJvYcCUPWSRoCBZZAgI36V3IA9yfiLUrzp7WVRgs1LUjZcxzbcrwNLR91t50GoO0HrMlTNNYPA6Wv+HtrTA+n1P4@vger.kernel.org, AJvYcCXkLgrcV8vrESczzN4fvbahNJ4lls0bM8dUr3/zx+nfh2SG8jD5qRAIngVi0EOdB8GmupUTr7s+qCdX@vger.kernel.org
X-Gm-Message-State: AOJu0Yygcb2lOw1btaC9aI9B5uAMZtTDnVdkzOdZUWUiElMtkB15QPOI
	Y5Xs70xRGDfUD6cbb4Hi/AMBlFKBoIpgajqwfVfl6OTBjNxKKya4
X-Google-Smtp-Source: AGHT+IGxScLweOV74hsHY8ybM05gxHwS+UEjeyeywhEqzfUmk+ssuwJt1d5kawmlBhnicXPFtNf0HQ==
X-Received: by 2002:a05:6a00:845:b0:71e:6e4a:507a with SMTP id d2e1a72fcca58-72062f4f6c2mr9457615b3a.3.1730099894293;
        Mon, 28 Oct 2024 00:18:14 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a21933sm5266089b3a.173.2024.10.28.00.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:18:14 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: riscv: add bfloat16 ISA extension description
Date: Mon, 28 Oct 2024 15:17:41 +0800
Message-ID: <20241028071746.869740-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028071746.869740-1-inochiama@gmail.com>
References: <20241028071746.869740-1-inochiama@gmail.com>
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
---
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2cf2026cff57..99d8b70fa321 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -277,6 +277,12 @@ properties:
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
@@ -467,6 +473,18 @@ properties:
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
@@ -605,6 +623,33 @@ properties:
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
2.47.0


