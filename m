Return-Path: <linux-kernel+bounces-408232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE01F9C7C69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25391F24AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E5206959;
	Wed, 13 Nov 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLTMpMG1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19E20512C;
	Wed, 13 Nov 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527604; cv=none; b=qL2t3gFrKmGIUsI6I4636BlulPbr5YNe6vCehtnerYDjEDreoCz3BP/ZFeA0ZIIECri9g0M0jf+jH5vqp2Vv5JDGOmQw5eP58vJiBkCF0eTSETAbVumsg8FeAkpRrMUtPXHGO4PqrzV74OTbYmyF2G88HjZ+upfSMrPTjUImG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527604; c=relaxed/simple;
	bh=f+l1fy3tazjS2bz5zfkmHyR8xJEa4A4ptXrXxoXVSoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGqzxN5wpYDAknRw0a790JrFqz7X7dl2k1AFjPBSzuUz6TPuKz1alkw/KYG7DWFu8sSavl0SmWWwkOLC3biEazxm5gIlK+s+fkbX4nEUtRB5nV2a28o3mLkmWcxerm2lK6PYS2yTVd+PE42zg5YC4A8aVTLlcFIA0LX9/h1zRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLTMpMG1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43152b79d25so61333885e9.1;
        Wed, 13 Nov 2024 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527600; x=1732132400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJohuSDhLv+Ez941jeY7j+hZPem1AM5+WSMU5a11wcU=;
        b=QLTMpMG1mdFgc8pK9IZQEZFesNgjZO6kfAMIg0Tmk4wBWkKaQuyChGu8UxyMg/0vTe
         vmKyoylEAuDcs+E+h18Buw5tYK9eg4yy72KX8grVtplEmUvqzdKjVJg3R3MM+eOIyv+p
         IdWGi5Rdr2U+GMGqasvQafB247IyC+1QOalzLhZiWchqu5n8KJQG0WTH5SgFB7Hhzlch
         W5b5QrN9+opqb2wGZRatl8bzKfXoiGXFYIfY3DZ286BOxGnob7YBdQGIXxgN1yzs4P5y
         LCC9rgniV5fAhQDeADwATetNpPgXj2kMmK6BMRzru9MyiWjTpupJaE6M0HV0drZl++Z1
         RpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527600; x=1732132400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJohuSDhLv+Ez941jeY7j+hZPem1AM5+WSMU5a11wcU=;
        b=ocWhq3RMNBct7oO3GMdHcWP7x7UkRR14UcFbKSXi+SJ5Co9xBBDqTMLoyf5wi145om
         tpA2U5IzQZDWl6eam1YQ5Cyhcihv9LRnMuPXjky5JOmjyafN0+HVvknGm4gyHmmuTwRJ
         EItTw/m486qvBIYlY+GeCQb/w3QO1QqwW00FJFRUvJAVGnYifglbkVrhyCUgJiPYIVDz
         qf76qsiu2BzqR3M2MiTlsYW3p1lWTxQCkkQQhygJKuZxyAyCgUgB77ODyF9rQeXZ3Mhy
         I1HfzuzXBHuNiPzCsfIw1wKqntDKcPpV8u0PqXw7k+yqc1pQBGokyCvDB6msYGFl0uNk
         pQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIVF5nnLuUB7BokfilYNn5NsJAN6vTT9kQ07oJRQ1N+8KM1dvLGRmR+xz16uVtSCfqUzMLVOSGG9ts5og=@vger.kernel.org, AJvYcCVfkBr7PqY4ft+RXeR86xsx9sae1cQ7ABkmsqbkpbRP0sS1xu0PbzCFUteOoDJeSKXTdvpLY8gymfgd@vger.kernel.org, AJvYcCWc+u0Q7Ovrh8Pzc6hYKEkveLc+58q1vJaxbyioWkKEU8Y/pvdu+h0U7erfHlVl4GgOQSpJ9NRteEHJ22Cm@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUCLsJrJ56G1vpSAb5eNY48fpUkQTFKp+K9i/Lgea72+Qjc+6
	P5XKYFFkNryFVHGz4ilhHzuy6eUd2uPVn1JEp6JFaVJHYXw7Cpm8
X-Google-Smtp-Source: AGHT+IHwi2toH/v6RTvp83UH7M2Jmxcw9HOhI3L1kjcyknLKktTX9f30Gh639+d+i9hlq9WYg//Eow==
X-Received: by 2002:a05:600c:5006:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-432d4aae640mr37829535e9.11.1731527600012;
        Wed, 13 Nov 2024 11:53:20 -0800 (PST)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c58sm34633065e9.22.2024.11.13.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:53:18 -0800 (PST)
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
Subject: [PATCH v2 1/5] ASoC: dt-bindings: add common binding for NXP CPUs
Date: Wed, 13 Nov 2024 14:52:36 -0500
Message-Id: <20241113195240.3699-2-laurentiumihalcea111@gmail.com>
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

Add common binding for NXP CPUs sharing the same programming
model (i.e: audio processing with SOF).

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/sound/fsl,sof-cpu.yaml           | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
new file mode 100644
index 000000000000..6d63fcd71154
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,sof-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP audio CPU common properties
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+properties:
+  reg:
+    maxItems: 1
+
+  mboxes:
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: txdb0
+      - const: txdb1
+      - const: rxdb0
+      - const: rxdb1
+
+  memory-region:
+    maxItems: 1
+
+required:
+  - reg
+  - mboxes
+  - mbox-names
+  - memory-region
+
+additionalProperties: true
-- 
2.34.1


