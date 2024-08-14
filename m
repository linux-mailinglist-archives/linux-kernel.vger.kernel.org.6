Return-Path: <linux-kernel+bounces-286085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D526B951655
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2DE283E09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CB142911;
	Wed, 14 Aug 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LiVEdjqX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4651411C7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623284; cv=none; b=eXS2mlOfsrIjVz1/XsK+Vuib2C7x0nzX8Cms5StfCJJUWmYYZsgNrA0lA24g7KaWuwYoKDOJ98C8lzEzVnZa2pPiSn2EXJsrr00+3a3fD7zMubmqQSJape70B+ap7fHsbZhdFN2gF20D+rr1+xFuauUjF1dZ2Pws+aMcIJAwPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623284; c=relaxed/simple;
	bh=uaXpZ8T6fuFcxXdhqz/JMbIh/uBMat6GBVL1nnkcRS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMX+BV+e7v9WpKeKu6wwzYfR+/ddCc70B7vuoPsg5q68mpeQXdkABaC53bEj49iF2fgALrpDeH+j8J1hXy6ykYgROzxMWhg3JHWnkvrA91I07uYErSb+QDW4Mw9hLa38pr5nF6grdTJE6F+A9GxoIW93i7sJipWYaXmYATk/5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LiVEdjqX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fec34f94abso55171495ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723623281; x=1724228081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C80mIDHR/SSEQvshL+evnKrl0xyN36hJKjVYwlCZpxo=;
        b=LiVEdjqXl+JVvSel27rzjPvSYvG4AGcWS/cO7mTvPNAiQLZ1DE8E0bU2N2B4WGX45p
         HjsqGZYz3lSMzDY38kb5wjWelZ49YQ+Nu7T3HU5NKlhssHzMh9jMcoYyMSsRP2t9iJ6t
         vrmwnqhkF16fx5/peQMa4CpNNFkH/CIzrRUGN3bv+k4y8XYdmqVxFwI3Bl0M+ATba/hG
         HCwW8Z4oqy5qzZM9H48v+lnBL4SEIhEind43v+ZdECFL7JdIzzlLn1hjA+Lu25C5cnRv
         KyNrQhqb1yID6da7kj7hzBR3LympsG9zrhi3Zbyd6epvVrtfpZUZkkxqkF3tYf3VUYJB
         Um6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623281; x=1724228081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C80mIDHR/SSEQvshL+evnKrl0xyN36hJKjVYwlCZpxo=;
        b=useSP4Cunl7a7m1Okwuw2Hl6MTlGr7cuBm1BB0IB4jNYzQR+O9p4Js/BACNxfYFcsv
         ehbaidzrS0pvnPpNx5rwu7XHV4YP5xxTIeAsXJ4f+oZqSogpe56ZHOk1+AOTCj+8K7tY
         UXMFn9k1EERQY7kznb/+hC0yHpndM2Iwl9s8gbTTa2E8WvXF5mi7y+VvOBR3FhUXX+jW
         mi59y5Da9iIk1PVUFL8JbTr4cBGncp5PDyABvwSkYzB3d0rKjpeYvlX05TwURz7d3BK7
         qZZwy7NvHEe/RSb/VngRL/Epqbd1TI5N0SDQQtI10RmUD9WV3S9o25X57SD5vU4rYqZF
         sz1g==
X-Forwarded-Encrypted: i=1; AJvYcCUELxWBs1qdrJCZZCfSV6AzKmYxHNFS6wMlEzCLzyH+PWeBk40uCsGoOB66E/+iE4gRLa8OfPMzMESfJgprhgElFeSMo+lMqv+MaSqN
X-Gm-Message-State: AOJu0YwLO+5illDWqqnDMqo7JBMWKhI3EYOfFiXxss6lo5qmXmElHRXz
	UrbkTzO7a3FFw7BELlEij5h7zJGzrwGSRVqPplQA1Yesceku5jZAlpw9AMDY+pA=
X-Google-Smtp-Source: AGHT+IGWd5aALk9iRQYfLQnu0uXb0Y/OpPlLQY90AVj4YNjDUrUlwY/SjzwpqXSSLSWsurvD0nsz1A==
X-Received: by 2002:a17:902:ec8a:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-201d64b1542mr20521085ad.46.1723623280985;
        Wed, 14 Aug 2024 01:14:40 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd147ec4sm24868335ad.85.2024.08.14.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:14:40 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 01/10] dt-bindings: riscv: Add pointer masking ISA extensions
Date: Wed, 14 Aug 2024 01:13:28 -0700
Message-ID: <20240814081437.956855-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814081437.956855-1-samuel.holland@sifive.com>
References: <20240814081437.956855-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Document the behavior of these extensions as
following the current draft of the specification, which is frozen at
version 1.0.0-rc2.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Note in the commit message that the ISA extension spec is frozen

Changes in v2:
 - Update pointer masking specification version reference

 .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..a6d685791221 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,18 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smmpm
+          description: |
+            The standard Smmpm extension for M-mode pointer masking as defined
+            at commit 654a5c4a7725 ("Update PDF and version number.") of
+            riscv-j-extension.
+
+        - const: smnpm
+          description: |
+            The standard Smnpm extension for next-mode pointer masking as defined
+            at commit 654a5c4a7725 ("Update PDF and version number.") of
+            riscv-j-extension.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
@@ -147,6 +159,12 @@ properties:
             and mode-based filtering as ratified at commit 01d1df0 ("Add ability
             to manually trigger workflow. (#2)") of riscv-count-overflow.
 
+        - const: ssnpm
+          description: |
+            The standard Ssnpm extension for next-mode pointer masking as defined
+            at commit 654a5c4a7725 ("Update PDF and version number.") of
+            riscv-j-extension.
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as
-- 
2.45.1


