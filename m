Return-Path: <linux-kernel+bounces-207316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F002190157C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DECC1C20F61
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480622F1C;
	Sun,  9 Jun 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyRiM9Qg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B3208B8;
	Sun,  9 Jun 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717927671; cv=none; b=fy6IIpNi29whcJWJmhO2qNnOc+ITT1Yl/OfzW4tyRh/k9slHeRLeFIVIwO74bb+06ZlakjOk9R9cel9IJptfv1tTjBf3y9toxlHmyFZRILCT++Xg/zTOFC0ElArLnZzxmyVZAiZPDkV7eBCNDBuW6uOvlav8ggWwoFHY46RbOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717927671; c=relaxed/simple;
	bh=fW4OnfxSC1huAXibwjVO49aWwP6kwWsg9vuNq1cMjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdExNxX0IINNgTJOwu5scRRkWqQNtWwLSGVT1l5BGN40MBTcaSxoloEJBLWbki+h3GZXaPalcN4yT/xwNPurlHbORxB+5XtkjBdsd/3DagIKZkWuTnAUEKJ2rSLQyMlY+m+KSSBkdi6SYhF+Vq/c+F+PQq6C70VJHWeQSjNKdUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyRiM9Qg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-702555eb23bso2760959b3a.1;
        Sun, 09 Jun 2024 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717927669; x=1718532469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8cWoOmqxKfRTYz+fqWWX+hQL/rBm7CI/FqFLj5thyk=;
        b=eyRiM9QgEKR26YuAmj3xzurUVNHs8Na2y8ifSanf0IOXHiq+oyKb22aQFUIxx6Pj16
         GOZM01jjOzQKepQ4wbLNZwBg7dWvu8KtLJcSSQ9/OWhZWkcsG5cnbLgCU56ItjE5oF5q
         Rz4XGv9EMwaC4necoJP08Eh419g5SRE4Yn3aDBe3MbUOgnOe5qR1CfEhe3Ko4gq8jPTN
         Fx72gZM+nbO7Q6znZSaJw06tJX9L09wuGuKeCPmIHz3luAjy290po8QzgQtc+gP3ghZz
         L6OGgDENjCFOHbGO4zINTAm/uU1h/Z9z8e3kya2wnahcCwrvTFnsT5NkK97+RorgKTXP
         cXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717927669; x=1718532469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8cWoOmqxKfRTYz+fqWWX+hQL/rBm7CI/FqFLj5thyk=;
        b=pe82yjEAQirhILVet0f755DyRkOTxz8SdbLmeAee/bqLmyCuoUk9nWzSgH7H10k41B
         s7U3q+vfEcRdYnIXXFB0cDRKCervgzG5PejIJUG95+9XAydk6/rbjR7fph76IYd3LDtq
         2wrt2p5Fl+7C5hWCrFL4gdzzbvQGdmn1meytvvSC2fw7VOZUOtHpSMLcdzgJyTnXgEWu
         s0LVr28gT9ZjUtFHS0ybgJmghAKi1VxFag0rE2cqJsjSD3dbGPJDe/PpsOB4vbaq/TEg
         SMtyEWHcfmjrCrPzJgl7VmNvICl42AIX8Z6hZtgAaXRQVc9qwMtTdueo2/aQsjwkP6hz
         7bBg==
X-Forwarded-Encrypted: i=1; AJvYcCUoAQmwpl5FKEyg8EHk4wQnbDI2g+5OgzvrdT9cKLXHz3l/l1kshTUyhxdhseyH5Flun3NZam/MxoJVLotkqAw7N/CaWkqh+vBjgR7W+G59qFWpaDM0+H0+2ACzxeILAy8AjG1xLfK51w==
X-Gm-Message-State: AOJu0Yxua7lgkitUvJTtQIHCsRl6Azf4OKo9NdMpUFgw5Mx/4Mw4bL9X
	usarjjZG2RbjUjVFFcm27kFP+0fBboAFX0e1fKe9y+iNkSwXR8Zn
X-Google-Smtp-Source: AGHT+IGUOwdS4rXbpKPl2f/O6CYkYK6yfhL3sIsZMAuc7WIZ8+BQleh6SCurcGAE85uB/kTJeBCzGQ==
X-Received: by 2002:a05:6a20:7487:b0:1af:fa18:76f7 with SMTP id adf61e73a8af0-1b2f9dc2e94mr7273875637.39.1717927668863;
        Sun, 09 Jun 2024 03:07:48 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1cc9:92b2:ce0f:ca96:5cb0:62e5])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7041c78ac20sm2817534b3a.154.2024.06.09.03.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:07:48 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
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
Subject: [PATCH v4 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
Date: Sun,  9 Jun 2024 15:37:08 +0530
Message-ID: <20240609100710.85055-3-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609100710.85055-1-kanakshilledar@gmail.com>
References: <20240609100710.85055-1-kanakshilledar@gmail.com>
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
Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v4:
- Change DCO email to @gmail.com
Changes in v3:
- No change.
- Rolling out as RESEND.
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
2.45.2


