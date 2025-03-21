Return-Path: <linux-kernel+bounces-570908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAFA6B61A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9677219C0543
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB301EFFA4;
	Fri, 21 Mar 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mMMvcy9n"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F81E991D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546121; cv=none; b=pY7NDHxRImnqSVLiK9neRwOx22M4/OrIAxGOzVq+/oNq+ViA7C8ykqzzwETtN9sJqmJptMmSRVj0OOcUVuTfj3ruryU/2TqLxoOVyP6uBEv0dOvzia8lfbR++gB+xjCMR7ICQ1UQex8zeua+Pf7O3GunI7fxJ+o2yHXm3ZyD6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546121; c=relaxed/simple;
	bh=SHEPQMA7zsG0pcW3VUHnjFMKPkC+BT7CZDZhG145VOk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iawWMKzMQrnmII9NiwPbOXsb8DD6oKCtP/w9f7wMhO0IPRPETn+eDF7A4tuViRqG8Hyo3pl5JpvXvEBytH6JC3+ERl4LxgL3JvZ4UFRi+TMJBmUNDx7cqM35Atp+qkxG6FgsE08hKM1720WodhLEnhFaP2OroNDw8HVLqMl1dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mMMvcy9n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22401f4d35aso35115275ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742546119; x=1743150919; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNIYAxNTxrJgvNOeOr0z0lxXWvmJniaTC55sev3rziA=;
        b=mMMvcy9nCG2qLE2Ll3jGTh4Eh2xfPFvaI9MUK0Rio+/iR3Cm5ev5SynZ9GrNdO+WPO
         +cUFuCBN8WYoLxSsUTvSo8WzPL3ivYez0UKQUNsOqJm1J8mF4K/rFf93XvWNTQ0OTN1O
         lHPSRo4o6xm8SuJ1pLGjtwyKfxNYyFBRyCCXlFCe56wI7aQA76dxuWUyTkbUI29+pKZm
         I4ql+lprYOb0YeULbjCBM44GvUHalSpVo9K0B0CVLahAaumLYLXCW/Q1/uixazwcO/rU
         /FqBE8NGYgE0lPEFwR4UPAbmJkIlLrA5B7bKak95L0XE7ZJnVGWlxljCsyOTNGofWU9B
         hJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742546119; x=1743150919;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNIYAxNTxrJgvNOeOr0z0lxXWvmJniaTC55sev3rziA=;
        b=HMTsgKFT/J7IXbqhUFbisI3ap54dq5FdOkXtX46QHF5VdcCDxXL+ZdlwjSfsdMHtpS
         pJsmP4FmesRPifeSp7cwBfP2KU47LQTphXqaX7ZR2HQf/+2i2WAy7xJrfGxS09E/ZMk3
         K2VmOwj8+rCujtFpo5JU0+CYvzNdLrLJCqw/LsiiW4qOP4niETYTLfzAA/6PilVk6JvQ
         Sl476azt5lZFwZ+mP0OKlSG1JZcVC0wAasjSKct7Mvu9dfNc48HownXbOjDHQ01qDJct
         xe7vgqwym5SYAKLbW9dYBvXlpylLB/t5bcLEg4Mzj2CnBu5QddHwTsiFb7AT/I0YwxfD
         S9cg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5cm3vKAmm+Bl2NfZ8s9+F5+rTeYOUU/QeAj9zl6mnzk8iCKI8+s/Cgw48eSqThbTLOqTFzyzweCcoyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIB7xhabfJ/OUqZ5aSk4YUUzZfzdm4DAVtDtAQ52+FgAPb0wU
	0mFat2K/M2NE9W9GswbOSXGzeOYOVcYDQkzz7mjdkfSKOg9UFAokFycNEqWYzMU=
X-Gm-Gg: ASbGncuhCl4dvdKSoxJc6ywIgmiyUKZ6FAECy124+ETnFR5uMTWu49uZVZcsNq3Wzyj
	V2DEhjcPpASr6PF/lRxSsUxC3jmR1KhIAZ+wlbFBmzaA8BR5RACD+D0yFakx6oZgI/qjCMoXvju
	aWumNSdiqyz+TSiY7q0mD2MOlAEo2/V+S0byg26O4RxLYb963x48VqflSYuXEYhy11z2UmVV+NX
	DM/rDQ2VP/YK4vbsImTxyj74tbdlRwjdIsm/b4E1WNh7IffvUsfEYavsueXBPeOpJhkx85UsSoV
	hT56J1h4bvqnad3fHd6DBYL3bFsQgtB6gI/u+AlYArNlsfXPb3J7Fmoj7pI1TANtguxYRaAEPDw
	ngw==
X-Google-Smtp-Source: AGHT+IGXFGLuEoU/vQJUliqJjmPIq4zF6xy634F564ds+E0ZTlK8S163nLM7MaGqqNkry0aYcIfGgQ==
X-Received: by 2002:a17:902:ebc9:b0:220:c63b:d93c with SMTP id d9443c01a7336-22780e234c5mr34978645ad.44.1742546119383;
        Fri, 21 Mar 2025 01:35:19 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f1462sm10857625ad.210.2025.03.21.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:35:19 -0700 (PDT)
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
Subject: [PATCH v3] dt-bindings: timer: Add SiFive CLINT2
Date: Fri, 21 Mar 2025 16:35:06 +0800
Message-Id: <20250321083507.25298-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add compatible string and property for the SiFive CLINT v2. The SiFive
CLINT v2 is incompatible with the SiFive CLINT v0 due to differences
in their control methods.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
- v3 changes:
  - Add the reason for the incompatibility between sifive,clint2 and
    sifive,clint0.
- v2 changes:
  - Don't allow sifive,clint2 by itself. Add '-{}' to the first entry
  - Mark the sifive,fine-ctr-bits as the required property when
    the compatible includes the sifive,clint2

 .../bindings/timer/sifive,clint.yaml          | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 76d83aea4e2b..34684cda8b15 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -36,6 +36,12 @@ properties:
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
+      - items:
+          - {}
+          - const: sifive,clint2        # SiFive CLINT v2 IP block
+        description:
+          SiFive CLINT v2 is the HRT that supports the Zicntr. The control of sifive,clint2
+          differs from that of sifive,clint0, making them incompatible.
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
@@ -62,6 +68,22 @@ properties:
     minItems: 1
     maxItems: 4095
 
+  sifive,fine-ctr-bits:
+    maximum: 15
+    description: The width in bits of the fine counter.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: sifive,clint2
+then:
+  required:
+    - sifive,fine-ctr-bits
+else:
+  properties:
+    sifive,fine-ctr-bits: false
+
 additionalProperties: false
 
 required:
-- 
2.17.1


