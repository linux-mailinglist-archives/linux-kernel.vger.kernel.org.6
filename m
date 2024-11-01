Return-Path: <linux-kernel+bounces-392945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A99B99F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFCE282A47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0D1E8847;
	Fri,  1 Nov 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bq4OAVe2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894E1E47A0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495627; cv=none; b=jf4iG5VYOVOGaeu13u7k8p6M/xQsVxbX47IY7oSmlix8pctBKVvAstakYqXbeMopZFmK81124PZWGP4neU5FVaKWz4rFhlc62/6I2Gz1KrEHZwitd7QkOPpOw0MP5X0/roegeQhZIx2uhGn3y8EtjmmCuJ6e/ms6HGZ2w8+snvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495627; c=relaxed/simple;
	bh=j7iW1feqAWso+Tat91tAHo+FMkx1wlBjbAqAJjmwQzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eghr+1No3kyXq5pTI/JBFY+aPmp/EdD2EJvQ7rHCdHIrqVsbUYxszWNUErhyiQfB9P+wUR3IPljInyMF6aNzOWxR8/G+7fiybp5FCy24UVfumgVaLAJIj1HzYBVzO8eLo4AEjE4L7kPiAgDdgJksooBsojf7Az6y6Tdz8taIS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bq4OAVe2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so2033605b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730495623; x=1731100423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gmaslziIHUfTRq5OT9nnJb5IIrBuXYj22iGCA2p1Vw=;
        b=bq4OAVe2CcyY8Fz3NqUZ/Slhb2Tb1KQKZzuPuj339Kq4z/TmpFCUmx9xq5brm94bO3
         in9evA3ATgn/4YteOw6GL1sm12igoFoYyvlwN5kyqNGv/qjwHUZPDAh0E0Iiq3BukwzX
         wfnrRHizTvXvfrFyU3WoT1UiNvkOPQnpQDxjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495623; x=1731100423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gmaslziIHUfTRq5OT9nnJb5IIrBuXYj22iGCA2p1Vw=;
        b=h0sWQOKss34xuVmF2iU4IUlBQf1EqFLjOmw9qPaZf0/8ZEK9C0xJUnMEbSU2FH1/id
         Da5CsTn9h3orDzu/pn0j0Ikh9UztobsqvsEVETQB9VExiv12P2cMFGVeY9iBZ4IqJaZ+
         IADN+tvM8/XKazfTam4y/HIfw0KxeqvPxSLPNbi7l2xlpEqwEfmZj+zvhtB8jJB0FDWL
         2G2Z/vicBLxa8vs7XI7FvjofrsRRyPpTkZy1jD6KVgSaEiFecUpEPgd32YkR4OELks8j
         T7xcFVkywtQFjYRJt3mFKPKDHxJjpK8ccVknFun+BjlySpNFrAZXyxgYBl7YfvCZHogJ
         6UCA==
X-Forwarded-Encrypted: i=1; AJvYcCUbyLDtLMzN8qDDm4cvxAS+TdP4sSMz5FJOFhl6xXSYhhBEoNfo0+uoE0o1W2L5h/D4QDPLt5q8Vfs6tFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzUqzpCl7IfM1a+8AJMkYtl6MzaxfzEtNr0eyJhOfQAp8TAaN
	/OPGEKUvFGGlJsV9nNa8AmdAOGclEwj9kkE9UKprtmYrMtmpuicor0CzTpHqcw==
X-Google-Smtp-Source: AGHT+IEAOefh63wQIqfkUJOl5klZYVKP7yCEGttqmKZtHp1y5vUat4ZKI34uorr+hfkqicJydf5fHA==
X-Received: by 2002:a05:6a20:cd91:b0:1cf:3c60:b8d3 with SMTP id adf61e73a8af0-1d9a83cf404mr30917513637.19.1730495623421;
        Fri, 01 Nov 2024 14:13:43 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a995bsm2898250a12.21.2024.11.01.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:13:42 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
	id 029D06FE; Fri,  1 Nov 2024 14:13:42 -0700 (PDT)
From: Markus Mayer <mmayer@broadcom.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Device Tree Mailing List <devicetree@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: rng: add binding for BCM74110 RNG
Date: Fri,  1 Nov 2024 14:13:14 -0700
Message-ID: <20241101211316.91345-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101211316.91345-1-mmayer@broadcom.com>
References: <20241101211316.91345-1-mmayer@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for the random number generator used on the BCM74110.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../bindings/rng/brcm,bcm74110-rng.yaml       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm74110-rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm74110-rng.yaml b/Documentation/devicetree/bindings/rng/brcm,bcm74110-rng.yaml
new file mode 100644
index 000000000000..8e89d4a70b53
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/brcm,bcm74110-rng.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/brcm,bcm74110-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM74110 Random number generator
+
+description:
+  Random number generator used on the BCM74110.
+
+maintainers:
+  - Markus Mayer <mmayer@broadcom.com>
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm74110-rng
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rng@83ba000 {
+        compatible = "brcm,bcm74110-rng";
+        reg = <0x83ba000 0x14>;
+    };
-- 
2.47.0


