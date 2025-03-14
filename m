Return-Path: <linux-kernel+bounces-560914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB93A60AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF516AC40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B95194137;
	Fri, 14 Mar 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JgJckKZm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1219408C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939993; cv=none; b=dM/UthvQxPQ2kR7CKWIjTkXTBdxuwCxOmMccj2fcMJFlE/HwYBToc630c/Hjt4YavbsReoYgUXTC/qvuFnWYCR9hYjZNhysD0r0CC/3QmkTty2evYWX4pT3Cc/beMapZ/EkUuFWUJCOh2RdpsmOrkX7mWOQDyJMyic7bgRFNaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939993; c=relaxed/simple;
	bh=aBoaIA8pL5dPRNJ/NbTzYxXHLL9HdGISKk2JuLHQGXI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bawJ5g1AznYwevIxw997azfOvotdvTPuttZREdzKwwDgHIuNo7hJu7YKgrnm0sEgwKuHUJycYheEzUEbXapL0z3K0S3e3IsY0Bp6sTeOcB/XZan0sTpNgratP9YDZ+4YrpXosQyUshzD88UyXXdmy1NL4iBoH5Fzpy4Q523LimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JgJckKZm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225d66a4839so18738865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741939992; x=1742544792; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIaypJwWB+9Cndggia9exzQ6t2dGjEXmye283vVYlI0=;
        b=JgJckKZmSp2AP6KqwvTSkWxomm/g8Ffk/KsLG27YD+8UwrApDIo0lX6Q6dFNRdNOXf
         2Jk4tlGPaBqeJlamdzvvAdYDXjQobXRBQojHAcet0whmJd+IdOwXInPjMO11CFveN6Ub
         md54E/rPe884+II3J9ZI47FIqFXYUHT9KA5vhMQn7btqE/UN5P+bRgtrv+7Gm4JfNgjE
         3V0sTIUA0sPKFsmWSUV4LvROY/4btpX/s6S0W7S8BLBCTLjdFyP9rdn7QCAjcrTPMj+l
         bu6WTG/YUXCdGTa/WceijqlxcfN4mk+5lKLCzuRz3m8sTVMW8UbiEKuYatIKWv5lXF28
         QDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939992; x=1742544792;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIaypJwWB+9Cndggia9exzQ6t2dGjEXmye283vVYlI0=;
        b=oV+W8CbLjYU+h1r5KZ9H3nq95nBNFifx3FRT3ijlndS2a9PRe0iZh+K4xS0GjKBudu
         eoj2Hq/xUjWu89eAqGAyBd+swQiTrdOElP6K6U40cpGyTquSNZ9q3Fhm9yry5JNfnkZE
         c5N5VwP/k906gsWtfEFZ/X+lx2Xu+4+Q1iOhgl+wcM7VE3WYlnWwtPvpVTkscYLb2Lq1
         4qqygf9e0eGdqSkAgCGQI2BN+1R+JeYcFac6J26FbW7/Bt8a3IixvsfwoPwgEcLv41Bu
         we/2t6Es/fMRPwAM2cZAOesGm6SYY8h+BmLc2+Ow8Tlm+vypW9uJAKeriRqHZvZLXYf8
         mgbw==
X-Forwarded-Encrypted: i=1; AJvYcCXWBSFNgVot356Tv9nUmNPKcCtPPsTiSbOFEOVJYKTD7kqZHAYw38bNSF2/Cxs3rIu/KbA98OJuAr7R2Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQK5O7nBR4Cyw/ndrYbPzBo/UkXVLn82QTBl6zvS9hJ81QGRPB
	udpBZ8kkXD1RkpkuypaL2NGW2EYbyPqYV0g/OpwDFGbekKg9NqfjGvQkT9VBdyQ=
X-Gm-Gg: ASbGncss9/WwZVJyZx4DrCLRoOxnZeCjaqODJ6dd6PB3nZqxko2T95g7pwpEzalGfS6
	MVeb8CDTTDnhxmGltnbO+XuTNcQfHGAI+igOH3BQgKwEXA7gt9e2mVT1FSkQmfmrpbTpvdhMgxM
	uJQ8xGgcg2S1WIVPNy6Uc9SCH2ikqXt7kshB2AOlsWkRePOQtHyLsP6c5oynsT3fF4d3HshKZOc
	HAezwkRvz547UNo9wTNOV9iGo6Dbkjt4AwuWjTUrPhletHF79UCuF1mE1hLgbV3uBcUze7McSAa
	ObtTxc/UI+aM8w+CznG6oY07dZlMA8GmKp7K8owN0TqZrkkcG/l12ESVdRBDn/2gjN4=
X-Google-Smtp-Source: AGHT+IEU8f9gJD9fpGi0dkqDON/MFDwlzwvX7/+G8p0jqw7GozR3XpJHe76R/qoNe2N8VD05r7VjlQ==
X-Received: by 2002:a17:90a:d003:b0:2ff:53d6:2b82 with SMTP id 98e67ed59e1d1-30135f4e5f5mr7721021a91.11.1741939991712;
        Fri, 14 Mar 2025 01:13:11 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015364ec2bsm611920a91.46.2025.03.14.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:13:11 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: timer: Add SiFive CLINT2
Date: Fri, 14 Mar 2025 16:12:54 +0800
Message-Id: <20250314081255.3718-1-nick.hu@sifive.com>
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
- v2 changes:
  - Don't allow sifive,clint2 by itself. Add '-{}' to the first entry
  - Mark the sifive,fine-ctr-bits as the required property when
    the compatible includes the sifive,clint2

 .../bindings/timer/sifive,clint.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 76d83aea4e2b..4b9dad11c1e9 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -36,6 +36,10 @@ properties:
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
+      - items:
+          - {}
+          - const: sifive,clint2        # SiFive CLINT v2 IP block
+        description: SiFive CLINT v2 is the HRT that supports the Zicntr
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
@@ -62,6 +66,22 @@ properties:
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


