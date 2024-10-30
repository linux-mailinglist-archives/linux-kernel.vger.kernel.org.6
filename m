Return-Path: <linux-kernel+bounces-389632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F419B6F22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21C31C220A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA401D0BAD;
	Wed, 30 Oct 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UWhXvd86"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF2219496
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324074; cv=none; b=tRYUw1qDGypimPd0SjSmGeAaxGTXjbhW2POKV9TisCpF54KQ3vxIGotEO6EsaVEsNYYfkrE96djFt7GQjaaciD0Ag4a7BbhgA3QqpXiwEK6Vat9KEU+Zhw8vcIstdyaJ/YTFa8OIB62p38OtJSZKY97Xhy/qQha1w8pTAF1hX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324074; c=relaxed/simple;
	bh=uIj9bxjJ+UW3J2+LRlRVni9rzPoTuE/3qRjSbZzsgs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN9hyev5dH6b3fZxjk/DmzQuDClwTUJW3MDv6ecKky+ixn2NX50WFe+wrfuBDVEuRWOwga5xHklpL+Jc9yQVJnMqvrYFNq7sb+ylJBLIwKrgAscHMY7CxQvQHHY2l0U92p6BXlG/uITStBy0xvCc69wPLnqMpC3yAqFRlARsATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UWhXvd86; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7206304f93aso241604b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730324072; x=1730928872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miG/1HK0adKG95UFlClqKo0MqYdFiIcf0KaOP4hdkuk=;
        b=UWhXvd86RxG5wYWz3wjWeo53kXYpw2qGUQx2nVUYlsON+RFAwrKykvldvnsyQ6Dlxs
         VBF1Hx7livRkTegAYpuXk82/7TlfVEceQjvu2WTEefALM0yEE/7aYVmss2r5ffkC6YEj
         fDH9vHXbTE58MCj+62cY3MmZM4uaPiojcjXiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324072; x=1730928872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miG/1HK0adKG95UFlClqKo0MqYdFiIcf0KaOP4hdkuk=;
        b=n+lM9fx2Ul3hmjS9t7OUy+OKHTH2O9dazKmxP9aZcye4H3MYkGrTemmUter8j2aohd
         59sAaxupGT6ZdpS8gGZdgy2d/Eeaf0eIxl9au3JKPC8nhWbB00nwzoYHEMAnuV5czTtE
         bFSrM8Cj/hiPu8Lis0H0ZK4SKDRtqi/NvqdvkLnyvC3Kjqa1MYpkNMAPWpAj9HJes33H
         fEKCuNlEX0pqQ2+yIUSqAiGPaFaTI/DUVZ32fPxmcHZEelgcWA+IPwnhfxtkQ/faLuht
         ztSElFE4BdtLOVMa9WsId16BYmiqrpsuLbXLh4rNfyEjtWk7XSIq3WbjyCZXeaKEwTt5
         Ixhg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+Rr7+qk5bNlBIbGUJJRUJLvyI5jqdI8uISnQ4dlE0cWjbSvszRK0DKtiQSeYMksvH6oVszFH3nX9WtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKAbm6DfsZk0kOs4sYeS2iFblNsNvFozp0z29P8FpNY/DcQ23
	pdKkl1nsnmnA2aQ7LfXh3RUVh0JDjufdIDFQfysTjBHllPd6noQ6YcTbTqR8TA==
X-Google-Smtp-Source: AGHT+IEVlkxrvwpC6QCQmAunwAgGVoMYo+UQq+OVf0zsxgZEasH0PzCqxEDNUFZ/6ZGQgbWvwMF0aQ==
X-Received: by 2002:a05:6a00:9296:b0:71e:b8:1930 with SMTP id d2e1a72fcca58-72062fd980fmr24280742b3a.16.1730324071522;
        Wed, 30 Oct 2024 14:34:31 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b892bsm95417b3a.13.2024.10.30.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:34:31 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
	id 481BE888; Wed, 30 Oct 2024 14:34:30 -0700 (PDT)
From: Markus Mayer <mmayer@broadcom.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Device Tree Mailing List <devicetree@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: rng: add binding for BCM74110 RNG
Date: Wed, 30 Oct 2024 14:33:54 -0700
Message-ID: <20241030213400.802264-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241030213400.802264-1-mmayer@broadcom.com>
References: <20241030213400.802264-1-mmayer@broadcom.com>
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
 .../bindings/rng/brcm,bcm74110.yaml           | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml

diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml b/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
new file mode 100644
index 000000000000..acd0856cee72
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/brcm,bcm74110.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM74110 Random number generator
+
+description: |
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
+    rng: rng@83ba000 {
+        compatible = "brcm,bcm74110-trng";
+        reg = <0x83ba000 0x14>;
+    };
-- 
2.46.0


