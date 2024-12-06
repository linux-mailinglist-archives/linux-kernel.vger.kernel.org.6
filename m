Return-Path: <linux-kernel+bounces-434455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19849E671A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4624B282EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3F1B6D06;
	Fri,  6 Dec 2024 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFwGtEbv"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06E1CEE8D;
	Fri,  6 Dec 2024 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464759; cv=none; b=B4kdM0ycPLKD1Fw2z7/42GG73/ri7tGyW/jKKsQ0Jru5cEkAGwqjUyQeUWXYWJ3M9POGxRYhvn6bwmX0bZAg09SSv0Ipmim1Md4Y0tSOXYTZy7FttUpmDRbxP8SzoKy0+fGx8u7yqOl9gX1nAdmh6QgOgm7wjNOvysfrlJ4H/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464759; c=relaxed/simple;
	bh=2dEbaBxqpR80Ebd9pNkN+bXtNMd42veqfFq3u+pKSyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvG5SEYii+otdvzGC1iVooHbp8uHs5nGEWxnYCG+2Zs52HKOy4MVfLoqJ+xxQuIQkCtI6wGB4YTXIKkbpQp4/V6fqjUpB6pXx2mB0TcJprmdAjmA7sqXvX2ti54wPFVsO+1aqQuiD5m+LpjEWXTBDOrhlPVka6I35yKcPHO9RCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFwGtEbv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-466a0ac9211so18083311cf.0;
        Thu, 05 Dec 2024 21:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464757; x=1734069557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8BiXrdu8AjyVxaZxHVQZLdp0cv6/V99Kwq2ArWLgVQ=;
        b=NFwGtEbv2cOTr9x+J6Y/klNPEil3bspXe7DJX9HVahYRL4/toDUt3qK+0sh4vxkERm
         KfCzgIn1ghW594/4oYhSyp+rXl1TshLGh46YR2QpEPlyTylQMvWH4GC0xTA0YWrZUvlI
         yTSu4WD7V7Y5kFGcv/VgF0ReQ7uaufb4KrReQc9nHQRDVVoSxKi0Y+B5LFuPdj/QbMde
         pbCxBckYItrp34RH66Rsy8p46Cr/Dl53okPqX0aUrFEHmUyrJhEl6dpBdzJ8wsDRb9Wl
         nH4/KRjkmeMtxiTTXTtAzu/DeYcuGvOxeUT2GlvsQvgyPWuq4kjRkQQ8MMzISCekgBsE
         FkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464757; x=1734069557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8BiXrdu8AjyVxaZxHVQZLdp0cv6/V99Kwq2ArWLgVQ=;
        b=FSJ6rqg8VkGFyVV4ed9+Vr5uZVmZ1eOxb1ppvig4GA8k6ILBVSPrqbtqyiKIU+DFIM
         K5Z9gEb0fx+vHMBg53BYWEsm3MxALU5xK9iIb5g0CvwdwaoD83p5F2Cc5b7MXVIlphPr
         dl9ASywPZnpM/5bDss9cquBSQtZIU4FchW7fDhBbr7ILrMurLVq2y6rhQNj9syega8+l
         JC7fDch2XP7n10CqwASGwKYYMKN4mBx25nsdZexajrzYD3XwdgscTVVDv2r4zbgtANiw
         sP5Onyi3vEWWUBp/1WmiHVKvJOz5kgkX7zKBBatqAh5NXy9PtvJ22KfsIEYCF9eCvsyl
         ZnvA==
X-Forwarded-Encrypted: i=1; AJvYcCUds2Gm3oEYpFtp0KeRoYcv4nSY1kMdbEpj7SfnPKTQaN2cRE6yNPkLff8EkTfgfBd/v8QG0Isxu/i2@vger.kernel.org, AJvYcCXiZimlFQgQCy0k2ugYGFT3lLhFe/28CJimpOthkXGYPnVgxGAaCpTVtIkE7zLnHCnEl8oYnF7m0gyAh/Jh@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCGM4DCiIWgm2e8oHBrdQDJV/7PoQWlWX34FCQey6k53LE7yF
	ZUh+5nND3P1tuXySi2HrfMUug437xVOqWj2nry/iD1JF9Lf4L5ob
X-Gm-Gg: ASbGncshgJCg9Dl76cclKJ0pkA4qZ3DA4E8IMGCv06veS6zja44gx2qiqthF0OJGqTy
	JieL8/258Ig67J7pGEbXCg6d78yGbCrjfmuphI5AyC5CuVrxnHngI+7uf6r5cAWdLRY1oUJFSpv
	91bmQCP1809boa3sCkCGbwoDjjmYshXcHOtoQltmvXCYFBM6XSfMQw5umcFNN8NOqyLm6CbCM6J
	asXbVDYqVUW92M5HUUf82t/dQ==
X-Google-Smtp-Source: AGHT+IGr4f0bbdkY7GxypZLey3m/davrnr3G1VH5MnjbXb79c+bf+NeCMvcxLFALb91XgqHliaybZQ==
X-Received: by 2002:a05:6214:f26:b0:6d8:9d1d:3a7 with SMTP id 6a1803df08f44-6d8e7168da6mr20671156d6.17.1733464757010;
        Thu, 05 Dec 2024 21:59:17 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dac016bfsm15381436d6.116.2024.12.05.21.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 21:59:16 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: riscv: add bfloat16 ISA extension description
Date: Fri,  6 Dec 2024 13:58:27 +0800
Message-ID: <20241206055829.1059293-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206055829.1059293-1-inochiama@gmail.com>
References: <20241206055829.1059293-1-inochiama@gmail.com>
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
index 9c7dd7e75e0c..0a1f1a76d129 100644
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
@@ -663,6 +681,33 @@ properties:
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
2.47.1


