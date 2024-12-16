Return-Path: <linux-kernel+bounces-447522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA19F33BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7267164325
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCC206F19;
	Mon, 16 Dec 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHX6x5tE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A42066E4;
	Mon, 16 Dec 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360680; cv=none; b=DZj+efxA4ItMuMPbHcfBr92on/2Q9LsMsAtVyQhjD4EnnteJpPUnrURXMiTYe5t/HpXWqzkXTPBC46tubsMzC/yh0tCcUd6fbrmphBG3T+SMbsPZhjyNm6iL+edZ4RA8IT/et0PNfcaOhOx1TQ3W6RdQdRbHDykLNzG6ReQd8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360680; c=relaxed/simple;
	bh=C7U+gX2HAtTNvw4HTYyQ8sKcsL6nRwW9xlRDEvE3Fus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJIvGZcktqYCRa6ZBUr+lk5ZO9ChiUu7WPV5XyxdUilrBomQM95ZuOQlWmbj3eoaCfQEWolazqtZGbrfyciwMUPys0UPuBn7DV+/b6/RwNKeYHvFmkZ9BQ19NeJooYDuaw81Xb/g/7wnaLUmpA3Ms0ytOArxNLigQA6Q99sEDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHX6x5tE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-432d86a3085so27449605e9.2;
        Mon, 16 Dec 2024 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360677; x=1734965477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhaNNKCxtrPXfELgw/KHgSRSl1aX9JDfH4/Rbi26Vsk=;
        b=WHX6x5tE7g/bbs+9AwKeF2gCs+/yDlExSWn4ZOpSLwKL04e891yZm3uYKuf27eMpDi
         frK2+CPZ99rZM/arvzokrmtJGqKL/KLYQzK1b5jAhm5BWV9Ra3cV8ZMG3R7o9Fle8wvu
         yUkuqQPVgFNz3ky2FjDPdw27bxvok5Iuyf7tAc963HtgRBIc0xkzZBywwiZtWIUA45CJ
         SnzmSrCXZlY8PKcoo9Orluq7ZFotMbTRak2/5IGgT3jdDuaLiopUKz96uvFnMnBkxrwi
         RbUIX7a16v4hreQjA6X3CWXySe+HtODW3RFxMftYKkHum7o9zC3PSRhxl8QjPCYgCpEU
         DcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360677; x=1734965477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhaNNKCxtrPXfELgw/KHgSRSl1aX9JDfH4/Rbi26Vsk=;
        b=Z3O8IDhJAwBNVNImxEXrCVDV0EdSbTgk9C3k3noXinEmqYy/x0lzcsjg7DCmpgYbWA
         mV32SCVz9vL4fKYtCGP24xOqu4DgQmEvCYJGhxlRLk+pma2AXizL+ild0eQ4eWiN6UTX
         YW4C7fJtAxmpfzUkNcq4/EOM02SJD0iB8Q2mo2PC9AYnZwZIxtbpCAFV0Kwx984QChS1
         G0O9q4rmyf/1NX5VVFKmfKS6Wtea3Br5Ae3JSGZifC0XSRLc6GXW9lfNbCxs9kZXyp29
         f++QlyXrAQjVhyje0nCM9cqWdYwzfRAsThYvQe6lc0daTle83JslFnKiry90FKRYbbdp
         8qog==
X-Forwarded-Encrypted: i=1; AJvYcCU1bq7X/zko+E01bXHyZZWUVHxgs2sQe+WtHHgFhOpuaSaGS9l+k3Dhdqn1NzeShoUIRtZuYF6me9XgNCA=@vger.kernel.org, AJvYcCUmp3TTVbK+xJYz3rpcb0STWNj/O2O/iJuLGblP0tby9Vuwh3ytlUkf5F3OqC3K1cdw9PvjlHgB8lrR@vger.kernel.org, AJvYcCXdT7sQay/YppBGZymXAhvhhsY/tG6+nDX+YDmx8PS/s0EN48m3EQ9Ywcm1czETIV3rf2pzabicYtvbX3ek@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgYUHextLtS2sG0tNfn/sg7BUxVFDIrbFTG/HSMpOOTplirGN
	Oqsrd+AbUNbttCGqe/sWlT8Pj7WoeDkPuDEJHG7fgPu4mtmiSiZK
X-Gm-Gg: ASbGncteQuxPA/7sEkZoP6yDIqTq/JtXsy5NrUB8BERQOw9YTim2sEbZ3TjHahJovgo
	gMOkBpiY4Tql1Nyzx7sKfRonQeCeh2cU7WfZECxbqcH/MZKFG6RNKQlVKmoVXymnMgrIET7Ll8z
	Z1XTSMaXHzAfpfRxXFV28BEwXm0svywfPrAfijdIHP1/QGndtgtUY6afvKe6oJwyhHnQq9R4Fti
	aa/tiYDFqV5sYqqA46ojvA9iRrOeVkGUyPGEL4frhc+1RFdu+DucdZ2FtufXJoECl4vAdJy4ZKo
	ZnavaDWosdYQQ+PZ
X-Google-Smtp-Source: AGHT+IHp+aRH9ApI2wBs86oXmAT5Zyw16hcSyU7ofzYQJ6VdNQwOe2b+SoQNW7hpWBoCfEejVt7Ieg==
X-Received: by 2002:a05:600c:1da7:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-4362aa9dd6dmr112072165e9.21.1734360677203;
        Mon, 16 Dec 2024 06:51:17 -0800 (PST)
Received: from playground.localdomain ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed6csm141616455e9.24.2024.12.16.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:51:16 -0800 (PST)
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
Subject: [PATCH v3 2/5] ASoC: dt-bindings: support imx95's CM7 core
Date: Mon, 16 Dec 2024 09:50:36 -0500
Message-Id: <20241216145039.3074-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add binding for imx95's CM7 core, used for audio processing.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
new file mode 100644
index 000000000000..cc1eb358f288
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
+        compatible = "fsl,imx95-cm7-sof";
+        reg = <0x80000000 0x6100000>;
+        mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
+        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+        memory-region = <&adma_res>;
+        port {
+          /* SAI3-WM8962 link */
+          endpoint { remote-endpoint = <&wm8962_ep>; };
+        };
+    };
-- 
2.34.1


