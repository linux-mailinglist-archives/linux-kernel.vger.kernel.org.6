Return-Path: <linux-kernel+bounces-433072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CC9E539C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00271881642
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA92066DD;
	Thu,  5 Dec 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l/vgVJpc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C12202C4B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397593; cv=none; b=nY0zCaHyNNe/cMGa+UcIpVGAWb4df2nABuQslQ3ZIhvWo4FSqA7HlnBmugEP8zNhzzjo9rSDfGySL1eWQP8m44YPziYjaFuCjDqa3k5U+02Q4atBRZTTYiTzgGgul78Pvi7mRW1o4EbzPSjueGpistJm4oh5pLewB7Bz9JZiYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397593; c=relaxed/simple;
	bh=tD42VlJ7PTzIYUr1JF29OIvvFzjhry4keUPg+5EL/88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2E0fVg7roiTJ6LnzEHPU2OZeTtoEXOoPd6vO3RY50HkjYxW4v3Qt+kihty02GhQX7Db99kEWSztbn5xPaJTZl2i2K5+FflRp1/Zk7swQl1mmE7BdFkgUpFvrDvyEOr05UdU9IlZ1wWAEgJfBvNMnig32jHc5uk8pbK224r6Igs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=l/vgVJpc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0d4a2da4dso1186184a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397590; x=1734002390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiY/U6wqtKU6IpvnYGmb6LinIE6E3Eav1zsujKOZRDc=;
        b=l/vgVJpcmaGKzzZJ0nBEJAQCV0BIx4/t04W3TnZqrqUQPQhU25sA0dNxhRkjk0oJzS
         +y/MEtSKEwJirqiQULSwCC+PEP6sBOvPtp1eRXrN/qQk6ANE++l1jNK3qg0FVL7Z5U86
         qHpOdlAKR2H9HR1crswi1EcaifirUaWT4R4JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397590; x=1734002390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiY/U6wqtKU6IpvnYGmb6LinIE6E3Eav1zsujKOZRDc=;
        b=cH/9ByF1T+5O1StNo3IzLw74Zc67UiqAIfCOER0V7GMqG1PzIen/UGMlh9HRPNo8JX
         iK7uwLkOBkXlUCOTcsxgsjNVd/hPh0PAYq7lscILTOs/f3OzKpNMrEpj7kTxFrnyRxpP
         XkfmHMhS7SnkcE+ceHjY4YXRVfrowjGIFiLwxRUy2Ggb2EkQl8gbum/aJhCeX4zKxCll
         5WxwC7gdzLHQXAc5He4MQ12RyF0Wl2FJSdx0EbqSBzBBHMdX8FAqiGQCV7JkB7uMBnYV
         YEqJOWqSM2gSrXxbonXXWIcCS/NRgFkva7NO3SvCqjqqfxdtaBzsTOgan1kC666lt0xq
         ZqZA==
X-Gm-Message-State: AOJu0Yz4CHcmw7ZJn5PATosKglCTIg1ZD6Sbbm6uEo9CfNbYD8Sx6DJe
	MVVjU05LrRt4clDYVHH7hzG/JBpT/XodPKbRCbdlb3sfCHm3pYHXSlKFOFutAt6bfBvj4/ILHuC
	J
X-Gm-Gg: ASbGncvXWPySZhLZLIzTyg4t9T0yfu2Nuuq8VRa+r3qyxg6jdFXAGYi5yEdGu2fCDik
	tVusiSJnJotgU9CPwF6lxZMm9v+By9tPeVtviVQhDNacJfuDgwzGxcxgJsjqZsWkcK/YtP1LdUj
	AW6opVAEAFTq6b2iGwV/fggbLg4/jmSuQCSkh60j1N/g4oTm1HiPsjbCmhvAE5qKY6adZ8jfaQ5
	5tkqJlR76QObQBWwlCWPewmG3039Rot0uFFXNmHq1RXZ16sH86/brqQg8B7URMwZj3qSXuYFBDz
	Woc+ilSxvIpVkBesdof8ORgfTaufteu37NuapkE3b8OaTw==
X-Google-Smtp-Source: AGHT+IGIry/HdfnXsGul2UAgCCUzoUgqWIlhMfl2Bt3RhnIZpkxjsd0JhMpVzy2Qc3h9grs6M8D/Og==
X-Received: by 2002:a17:906:328d:b0:aa5:46e7:4baa with SMTP id a640c23a62f3a-aa5f7cc1bb2mr781689466b.7.1733397590083;
        Thu, 05 Dec 2024 03:19:50 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v5 05/20] dt-bindings: clock: imx8m-anatop: define clocks/clock-names
Date: Thu,  5 Dec 2024 12:17:40 +0100
Message-ID: <20241205111939.1796244-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define clocks and clock-names properties of the anatop device node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
index bbd22e95b319..f439b0a94ce2 100644
--- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -30,22 +30,73 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
   '#clock-cells':
     const: 1
 
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - '#clock-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-anatop
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 32k osc
+            - description: 25m osc
+            - description: 27m osc
+        clock-names:
+          items:
+            - const: ckil
+            - const: osc_25m
+            - const: osc_27m
+    else:
+      properties:
+        clocks:
+          items:
+            - description: 32k osc
+            - description: 24m osc
+
+        clock-names:
+          items:
+            - const: osc_32k
+            - const: osc_24m
+
 additionalProperties: false
 
 examples:
   - |
-    anatop: clock-controller@30360000 {
+    clock-controller@30360000 {
         compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
         reg = <0x30360000 0x10000>;
         #clock-cells = <1>;
+        clocks = <&osc_32k>, <&osc_24m>;
+        clock-names = "osc_32k", "osc_24m";
+    };
+
+  - |
+    clock-controller@30360000 {
+        compatible = "fsl,imx8mq-anatop";
+        reg = <0x30360000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&ckil>, <&osc_25m>, <&osc_27m>;
+        clock-names = "ckil", "osc_25m", "osc_27m";
     };
 
 ...
-- 
2.43.0


