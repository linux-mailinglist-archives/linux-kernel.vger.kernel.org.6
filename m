Return-Path: <linux-kernel+bounces-408233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0619C7C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51F02873AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1D2071E9;
	Wed, 13 Nov 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d27nZaZt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B12064EF;
	Wed, 13 Nov 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527605; cv=none; b=sJfNKgs44Kziup0iWXW9w/xrXXP2Cuu7POJ8ERSI/vIrb+Lmn9eszRHa/D/R7hq1g9BPJi9K8RtzGw6bBNgC/zNo87O6uKuzdpj7zT9vqa+oj1epcBV/NzKIoEsFWze1NRLLkNwo/4F+nR/EoQ0OELfbe+nvvm3psx6uBqMMbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527605; c=relaxed/simple;
	bh=Sv6D/+y3scZijLS9PVRlVeMuXulXudQKBAtm4AEdBT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCxwBR1jQwzSnqLlc4IP/POVZZ2ZmnWnzC/whArW/7I27iKa21Nf6brgn4RF+a/NHBwhPUt74Yywsq6JeygP8ai5gHjvxxQYQfQa6jwBBlhnwKxntAKPzD435dc4+8yy4GGj31pSHNaLCC4ucB15I7hDtaDHld0mUqYR07L4SyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d27nZaZt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so69279445e9.1;
        Wed, 13 Nov 2024 11:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527602; x=1732132402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lQpVT555kI9HxWkbuw1QfCobvJUnpBBYDf2BdIAaRY=;
        b=d27nZaZtM57nxV5jaR1K0TCXBS41Yji/C63xtsWFMjO8zfkJ2+x3gKvaHfwvMDVl/D
         xA4e5jAYwH62sKHA2fGo7c/4G+fjasF3nLwPgubFIEzfjoDftAAkhDcaNpADas9n2bce
         HZOGqMZajWHDY510YFedOZxHi5QsQy27us2qUhXj5LuTjtKyiB0yVfcVWL3/IDVvvkqA
         LaiRgmr9/cduOhqXe8olI2wFAz3Gho4ndKjE/K7erN5g6NISjWmXMH6hjBspzO+z/rDF
         mgxcE9LFUflqzwfm/e6xzQ41Xf1oUUABqkTVW4DbX24KP3qBx3kyNe0uiUSR4zBgMPTk
         iZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527602; x=1732132402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lQpVT555kI9HxWkbuw1QfCobvJUnpBBYDf2BdIAaRY=;
        b=olhHXhihu5Azez1FhTmtTaeiIazNmCG3FTaC80MzU2bYPDCWbOA5YSwLhxqzkC9qXt
         JzsCKZax9FV1+IwZadLdMAK0qHdmihSLxIiRrfDVzhKEJs71Cvik7cUd7FWtwaNsQryf
         ijZc6jJ+iqg5043/Z7JqOoInun1R6JddYRlaf1ceLdblaC63U2xC7g5k3bgCvjLomwTS
         JcKUthUXNzkS5FKwiwHp5ajP53/krG2r5lSgddHh7eO8guE89g8udijRl7T+gHCJZwrv
         NPGB5Wh/Hl2lO2On0W/uuhOHlmEG4bCYd4tDlbz4xgfwnskNsv/KMIOWWqf8bkzcJ9Gf
         480A==
X-Forwarded-Encrypted: i=1; AJvYcCVVoHeXFYgm0K9J6x8GdegVQM0eudWrBTvVWHJ2dgeMlz5N2bARS1w4+pDS75iOt0kz06wydNsXPnJbd/Q=@vger.kernel.org, AJvYcCWR5KqWO7dIh4EPje7Tca1MUjGXPSN3WVe4J6tSeaXxxYRp7mXRFFt2QM6jspJNUq2nswqglANiqT/J@vger.kernel.org, AJvYcCXkxhT1ZMzQyrfO/rcenhhieS0W3vg/97sukoGa7DIR3Xnaci6MMAEKQeLumH4YvDiDiNlBlKk5wEkD3jNw@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbXwATO5QKpv4RRETt1Ulpj0ft+zscQqA0dIxwm2wXZWIXdQf
	hjHAlPo5nZ0F303ZuT6fZsuFfka89LyYnghNLCKXKWGhUPdjQvyk
X-Google-Smtp-Source: AGHT+IH2Z2a0/rS9v7IeDir+dpM0VmMRaelsOvWV9gMqaYXP9EFNgflc7dj7yYlfrWcH5bgnnm7i0Q==
X-Received: by 2002:a05:600c:3b9e:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-432b74fcb02mr189488175e9.2.1731527602016;
        Wed, 13 Nov 2024 11:53:22 -0800 (PST)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c58sm34633065e9.22.2024.11.13.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:53:21 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ASoC: dt-bindings: add binding for imx95's CM7 core
Date: Wed, 13 Nov 2024 14:52:37 -0500
Message-Id: <20241113195240.3699-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add binding for imx95's CM7 core.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
new file mode 100644
index 000000000000..f11e03bbcaba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,imx95-cm7-sof.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP imx95 CM7 core
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: NXP imx95 CM7 core used for audio processing
+
+allOf:
+  - $ref: fsl,sof-cpu.yaml#
+
+properties:
+  compatible:
+    const: fsl,imx95-cm7-sof
+
+  port:
+    description: SAI3 port
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    cm7-cpu@80000000 {
+      compatible = "fsl,imx95-cm7-sof";
+      reg = <0x80000000 0x6100000>;
+      mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
+      mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+      memory-region = <&adma_res>;
+      cpu: port {
+        /* SAI3-WM8962 link */
+        cpu_ep: endpoint { remote-endpoint = <&wm8962_ep>; };
+      };
+    };
-- 
2.34.1


