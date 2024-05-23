Return-Path: <linux-kernel+bounces-187741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E58CD7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2461F22505
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412C1803D;
	Thu, 23 May 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpRjojbx"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B8125C1;
	Thu, 23 May 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479344; cv=none; b=aI/oO9e2zsdpCcnnoJxjIMVXnVUB/WKOsONkQf4RY5GrKAj2O/Bl+F1hXjKfr2yFXtusRo8FWWtBUZmoZzM0by6bOm3OHdJfNLJuK3ys8r8UZZ0PPxziaSndZbRelUgV1dgqw1sum5AVaHIjsuW0OsMsgMEqkUgr/vii14uth2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479344; c=relaxed/simple;
	bh=ioYR1DhOVcXP0QlbNkVL+dsRPFTAWxaAIPYaf7pAaos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COjHsaFS2wmf6qBUKf4ZXlX2y6wbcNEseMF+HrAz6NfBuKskaGapXAXVUkmKbHqHrjpmMEs0/MSVzh1LLNkng4IQVwpv29GzMy4Cdt8HUGIcq1DftHRVU0VGyRzTc77AMKpQFKVv+wOAW571CxESTAQHmCueYgErJa1BsqonmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpRjojbx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee7963db64so55855675ad.1;
        Thu, 23 May 2024 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479342; x=1717084142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYf12GLSAWFqtkB4/l4ObCrY/lFiR1gNXubtFx1aYgs=;
        b=DpRjojbxyX7XYRPmgo1DniRtBBZ8MMx7GbyLtwc5XX8e2Tln3memp7ys31yhhpTHvp
         kvDb1qn3NegE4Rh1B3fddZimvKUavaaVGfJizmptb/Nys3knpGsHOFTK/JjixQ3uGC1H
         Y6siN79iTed/PGzPa3OkAxUjymHNO+KEf9oVW5gBv6DiF2ctasW0yJHDvcleYkLMfy56
         N/bqyFoZqrNe0foLwydWLWUjYStM+8kNHaAUDQPGcEZL6i6ZRKKEgPH83NBDIQNo3XwP
         iUv6RcRabCgJfBiSh2Xcau0dhU7jI/Pd60H0ZTH+TLX3s/fi1cbEnHqpIY4GeGd50Qnr
         4QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479342; x=1717084142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYf12GLSAWFqtkB4/l4ObCrY/lFiR1gNXubtFx1aYgs=;
        b=Krxyw8H7sRQwY0Ve6nuxr3hiMwnEHIBQy1qBuMtawJRukovaqibsCKvTfsQ0U/QxI6
         YbSNAdoYiOlO/N5as7p+P3ntcQ5KcIoFNUsN+/poc23uIjImx0c6mYkGBAcX7ek54kVj
         2eANKgrUAwbvccmEjuedLpKpLp32HzNF/r73Y5TasJ+e3g0hK89f29jkYPSpGxteGyH3
         qzgCBjwcsFqa6Ge3PvU0BVeMdZBVBRBO0UGRKQKwKh/OU8eno3D1USqjRafEEzFgLqCS
         ow/K4bYVTezOzTAsdtVfxqbq82iJieuNW0f2W+Vw4s5kljUxquqe55TavTQgTnzlnv7J
         N3dA==
X-Forwarded-Encrypted: i=1; AJvYcCUCc1A5Q2GDUY7AlsZiNWRGA4Fh6V2OFlkEEFQJUUyRe0uDVfQYiLwUdp8W7dXzwGBmaYQ5UCfgOlu7eIfFgQsJMoqzy4M2TDupaXbkV7h5ayJSQ93t4393sWO5TV2crG6eAI6r2EJd1A==
X-Gm-Message-State: AOJu0Yxr6RbwTG8vLoQEJ5VV33Vc4yaFrxmzpcW0fVcF/Y4VF8O9IS80
	86RCg34j5ArLE7GDQvhDooyt0tuPf+adZc3H7mxfK+PmMrZJ8zV/
X-Google-Smtp-Source: AGHT+IFp+EFEz2Up+5smpmBNDpXiFMYzk1R5BzaQXFEbAzaQyIkugWlEEJZN3Xd8zPy8Q4OJF/nAiA==
X-Received: by 2002:a17:903:1247:b0:1f2:f3dc:43ee with SMTP id d9443c01a7336-1f31c967139mr61423015ad.3.1716479341924;
        Thu, 23 May 2024 08:49:01 -0700 (PDT)
Received: from localhost.localdomain ([223.178.81.93])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f3361a6678sm18321085ad.178.2024.05.23.08.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:49:01 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND v3 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
Date: Thu, 23 May 2024 21:17:50 +0530
Message-Id: <20240523154748.22670-3-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523154748.22670-1-kanakshilledar111@protonmail.com>
References: <20240523154748.22670-1-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

removed the redundant properties for interrupt-controller
and provide reference to the riscv,cpu-intc.yaml which defines
the interrupt-controller. making the properties for riscv
interrupt-controller at a central place.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
Changes in v3:
- No change.
- Rolling out as RESEND.
Changes in v2:
- Fix warning of `type` is a required property during `make
dt_bindings_check`.
---
 .../interrupt-controller/riscv,cpu-intc.yaml  |  2 +-
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
index c9c79e0870ff..6c229f3c6735 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
@@ -61,7 +61,7 @@ required:
   - compatible
   - '#interrupt-cells'
   - interrupt-controller
-  
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..f1241e5e8753 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -102,26 +102,7 @@ properties:
 
   interrupt-controller:
     type: object
-    additionalProperties: false
-    description: Describes the CPU's local interrupt controller
-
-    properties:
-      '#interrupt-cells':
-        const: 1
-
-      compatible:
-        oneOf:
-          - items:
-              - const: andestech,cpu-intc
-              - const: riscv,cpu-intc
-          - const: riscv,cpu-intc
-
-      interrupt-controller: true
-
-    required:
-      - '#interrupt-cells'
-      - compatible
-      - interrupt-controller
+    $ref: /schemas/interrupt-controller/riscv,cpu-intc.yaml#
 
   cpu-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.34.1


