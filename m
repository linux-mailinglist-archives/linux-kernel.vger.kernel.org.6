Return-Path: <linux-kernel+bounces-186444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0EB8CC441
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E82D1F233E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B981204;
	Wed, 22 May 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M25bdmuK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA667D08F;
	Wed, 22 May 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392375; cv=none; b=t48NA8R2jteZU0FnSzyTMgJ6TbR+Mwb8L9CE00IHSmWWimR9H/xPwtQBLDp2hsAeMTIualpfRwRnW3UMT/2Mw/6PNTnQ6MXJe5Qvr+0GKTi3r2HNXwE6EdV6877jvItgKaBDpb7r6zuRHpH/MR633mMrA+vyiqvahsNV+OcX5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392375; c=relaxed/simple;
	bh=llwxsV6MdWU8g+0kKVxnq7Bbcc5fXyWJzVTZ0a6TsQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1cIWSDVmFR5q3OOaPH+acx4+oXIjjk/i94uo0CnvjL+O5n8HkymznGjPW3WQ53jZ90VGxpIBhkzICeEmu80mfGB0+QGPP+R+onz8qWk2DE/VUODdPN5xE1BaOq/l1k3iQAaWKZznm/yj9krar3YODb8HZJFI5i91jAp2LGqaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M25bdmuK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee954e0aa6so12055675ad.3;
        Wed, 22 May 2024 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716392373; x=1716997173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvxfqkh+gSZbJyfshoQXFXdD3Y8gaC/pv6t5Ay+4a2U=;
        b=M25bdmuKGmFhR51zJJZCEkO/BPJv1aS65JvpCAwyTW2PG31Ryh+Y7toiLndH3ASWI6
         AQDDATvjUiVtLPfRHKZeUVFhWE52A4X0sn96sN90aqohnO5j/Q/OEcP9vLkB6by12mVM
         Tw/RRbQU6pZrljX5PA/MuaFUXjwD9Ur49OTKohVS57j9iYLjEMDkCu2BUSO6eR4jbOMT
         PGfMm7vZ2mIoRUMGEsXU2dSeTm0CNuNr+6o7xMIbLKgixIvxgog2/ORF+Ing/j/ezHgT
         bErRkk/o2KOKiigIkibaj65H0GDJtBZeC7v5xnYgLU0V4r+zQ8/mGI/Rmd+nPOew88Iv
         VBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392373; x=1716997173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvxfqkh+gSZbJyfshoQXFXdD3Y8gaC/pv6t5Ay+4a2U=;
        b=e9GQ4UqgQ3EpMLu+lyfIhUnWhoH9qrE7k5IGFmhtkwdt346N2B8idgn3KBgbvyRlZ/
         sIG/Bxu+rMqUZQiiVpULYzKWhz1jRL8yzAhvOrfD/AIogzlHQ1auM38dXmfbiKXK6cA7
         QyWIKneARhn8OSj1MtpcLAPtK103ga5c4Kwca9NXhHbLIV15Na5zA/Ft0tKqh2Cegko5
         M1tBysnMCl0wU35Q+sdmJo8UK1tnJx9BOdh+hOorVB62glaw4VBEkX+WxLlmdc5sMyJm
         siDOO3AR5DSNKDEnrA9JkdbMaXroyqAujx15atnqhOL6caUwzKLpZOXd83ah8KgK64/A
         AEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTyoycdZ1OgUlG7sSxMm29NEwSCFP6uUqqIhMp0rD44IiVxfhdQ5FOq9KdTlk3jYFRKPy3yAite1p6EPBo0/lJBCB3032oav2NY+/BD6+gX7/nw8urYFg/admHjrHOnepyq/Or9He5qw==
X-Gm-Message-State: AOJu0YyTxuAaujEnR2XqZIROGFjAObcEH7vhrVtXxfdcAGJJCeeMhVj7
	AIgcqVMNSKmgEpQi9J6unqhcH/rSQ145ZFkkVASDNocu5n+fNteS
X-Google-Smtp-Source: AGHT+IEvl2jl89Ll5aU5bNVUfIG87vrt2cUkmGN76Ttw5yLV7y7OkQZbEcTGoE9Ry6NS8Vd6Ho5icQ==
X-Received: by 2002:a17:90a:5982:b0:2bd:8aed:740a with SMTP id 98e67ed59e1d1-2bd9f483e65mr2313191a91.23.1716392373545;
        Wed, 22 May 2024 08:39:33 -0700 (PDT)
Received: from localhost.localdomain ([223.178.84.74])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b628ea59absm25574077a91.47.2024.05.22.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:39:33 -0700 (PDT)
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
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
Date: Wed, 22 May 2024 21:08:38 +0530
Message-Id: <20240522153835.22712-3-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522153835.22712-1-kanakshilledar111@protonmail.com>
References: <20240522153835.22712-1-kanakshilledar111@protonmail.com>
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

Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
Changes in v2:
- Fix warning of `type` is a required property during `make
dt_bindings_check`.
---
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

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


