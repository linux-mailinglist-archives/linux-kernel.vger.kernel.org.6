Return-Path: <linux-kernel+bounces-555484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE639A5B851
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD83189011E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9581EB5F4;
	Tue, 11 Mar 2025 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rp5ZlQZX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429429A1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670375; cv=none; b=t77JxCxEw5fnfL9XUgLe9SPcd0fzPAvU28Y9OU1eN/k+NNtc/2BhgQeKjUp8SBMJunJtBwENxi3OOcdvQB4gcuPPY8r6TG6ThZxEa9vACsBSgE7Vx/rVm6yXvt21fzxIZAU6Se3X0RNyIA/fvbKTTmEsqlj5FiGj1yk+GMNdpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670375; c=relaxed/simple;
	bh=Qf1HYt/4XQv3aVYt3Mn1+083Ac+3uBskW9Fb1amUZKM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MhqmkcRW/1h/mt0AhHzQIfzZJfphXTnOmrhUNefowu9ZzPOmqbqh5MO3ZJfvRyxQolQy+A+vuPSvZB2zAD3MHHUxs7Uxwu6fkVLhYGTMwyjrds1yYmCzKs+g4u2Yk34O8+TEDf71qdSP+icS3P5UMjX/DGEsBaHLx7HEWqm5okA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Rp5ZlQZX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so1268195ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741670373; x=1742275173; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i/dt0ZX89cRHtWHaB/kc777cnfXfjLxAIjIrBqsq1Y=;
        b=Rp5ZlQZXV5A8osFeyA+W0v/Aayaf2FxGNRItJeRTLpOM1WjlwgN/H429+B0mrY/tfv
         oyXk+4IOZ2v1DIV8X86T4qLe5BbAIzWzXLKoYDWF2gb6nrSI6948fJo70Yh7aCiEYyf/
         EkN10HWEatLCH7mxt2LUWSrk3pL4LE+Go7bKS/2DUxYc4L3YX2y4MRDUUtYi3P5qT5li
         0RyHlpiKH081tWcPUmwW0XL1bvDkEQv9jGSnsLHk1b30/VxWeltMaSLKTp59ZnjNEmpB
         Vg4WMZiRX0IYQTzlGREJAP66I8b8dXLYIFCgxnZdn351hUHhd7xC37GxqbYYmHHtN24o
         8QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741670373; x=1742275173;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i/dt0ZX89cRHtWHaB/kc777cnfXfjLxAIjIrBqsq1Y=;
        b=m7hXNUk9oXPvaO9u+tDlNjow18PQcqmzL8ygEP7BRycDZONdiFqd3wDnLKE2mAx0In
         a+Ph+eDzphAkfNchfI93ZUoAzXzbO5mem0X87D+r5HP1hgKd4JkgTM6BpRN4LFqStIFG
         /VGK6S5bVzGz+56LPVuRfpEaA3goY0uYluwXYUw4TXKTlivsRMkuqWmw95ikWJn7pnMf
         5nn1H0WDc8FT3ZnEthGLu+SVLDhzx+v3PXBCdH2DoWDRqK8l0p8ZyDd3bkETzRrGfbQv
         6pfWxH97+gE2U91/OG02nOerSIZ+OFP0fIs8rjt1fqOwyY5aqiheueunRtFRpe9CX35v
         Jzcg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0Iy1qaxa5L2XvnpgbWVgqlL0xSXacvtesxxXamApVdzGQm+hKrMAZT2ooSjvEY+MkJrS5aILaUERYcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1ZCVnqno6FjdRtDDcjwyWkohL2v2jsphiL0szEk6Kd4r4Bi+
	ymOL+igcrGlqNMVhmxwSQB2/u696a+sda6ixbWmfxbbwMgNwTmsQ+N5AfYcBv00=
X-Gm-Gg: ASbGncvWykvLPNgTg3KYU/+b7OLHBPxac99WW9Z+VVidIiClSVnbzww5tI9JxDPBcGq
	p1kAg0qgoqUExDdMh//zqfdshg1RBs62TJ/85Cqg4yYww/7Vwb4KeUfxr6bmnUonpAFVgGFSkV/
	Q5l6do4N7qaiZChcdszlxVwMNDAXC2NRBUIyOntZJA8KBtkZTOWJm/wFGtpeb7FYbzVfGVvfyJO
	Rpv8ieQwTLheUjYQIi0kvHbJvizAgrtvjxzVMV0BgF6KY4cbeieY4GIcpJGWGpiQlOJvvSe6lB2
	ve0Y4c+rJWYItZo6wgrRVSEf/avmkaKgvFmiqQ5Ayf6dM863b4kLTrP6qE+5fuzs9YU=
X-Google-Smtp-Source: AGHT+IEntr734nFZJCJi9wFIrZS3LNF88PAO3SBZe3Z3mk94wDz9J7xsCrG6KvNbYGMyW21bfvgtPw==
X-Received: by 2002:a17:902:d48f:b0:224:1219:934b with SMTP id d9443c01a7336-22428c099abmr227046695ad.50.1741670372831;
        Mon, 10 Mar 2025 22:19:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e9fbfsm88597995ad.92.2025.03.10.22.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:19:32 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>
Cc: Nick Hu <nick.hu@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] dt-bindings: timer: Add SiFive CLINT2
Date: Tue, 11 Mar 2025 13:19:03 +0800
Message-Id: <20250311051903.3825-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add compatible string and property for the SiFive CLINT v2.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 76d83aea4e2b..93d74c504b5f 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -36,6 +36,9 @@ properties:
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
+      - items:
+          - const: sifive,clint2        # SiFive CLINT v2 IP block
+        description: SiFive CLINT v2 is the HRT that supports the Zicntr
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
@@ -62,6 +65,22 @@ properties:
     minItems: 1
     maxItems: 4095
 
+  sifive,fine-ctr-bits:
+    description: The width in bits of the fine counter.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: sifive,clint2
+then:
+  properties:
+    sifive,fine-ctr-bits:
+      maximum: 15
+else:
+  properties:
+    sifive,fine-ctr-bits: false
+
 additionalProperties: false
 
 required:
-- 
2.17.1


