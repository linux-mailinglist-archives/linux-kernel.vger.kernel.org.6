Return-Path: <linux-kernel+bounces-374275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBD59A67C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17861F21D04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640471F4716;
	Mon, 21 Oct 2024 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/uodws2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EB1E201F;
	Mon, 21 Oct 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512996; cv=none; b=BVC441SLCZw1J1iRuPEquZHXc3IFOI4tL4n/TiPt9XHHdX5oDmt1UPW2Bmd6v1A25y4pb4wcOTJjbnMHz5Ed8Fv4VUaQZvP6KHbEiGjy4Tlw08M4wYcXiulAQTzCA1PE7dWFa0HTqf64JDfQVETVtPFfiMfft/R8hEMJp8fJ2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512996; c=relaxed/simple;
	bh=4UQQzST5pmQb67GxTCh7C60YCaXxUS/3ehBdrNjhohg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkqYMD2nGnCfNO1Pu/Cyfa545ukbU8sOlZjixN77ogPGvM4ida2bXyljrA+vzsOA8baUv0WikpoHpWZdRPLE4Q+KYYod0r2hd4M9ZVtQIz63CyM/qnkAbIIJ8yZgq7NUEjrOfX/ZXEjANr2VM5iPaJTfpmez7KoaIde+HGlSvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/uodws2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so60380541fa.0;
        Mon, 21 Oct 2024 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512992; x=1730117792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTVtbHUUOZj0Fo+dP6D7qhW4pSqQbmSUEEadn5eVpyk=;
        b=O/uodws26ovR9nvVa3Rwis5P+rv3OrSIifGYd2fqTh8z6klgQzNOL66GUbNs6McO+K
         FxZOAQ7zBtUPShlPvVKi6LkGxAimhSVRsEAvkT/+JE8gOHTGygCCv+nPRiLWj4+sJgHW
         kvHidIu6bUdxiqxiT0H2bk48zPm+Nv77tnGlx0AHvqiPitliexgwpJvifrcRCV4CHhWX
         zHBz7bn302v9TGNZXSOmM7DleyxeRQZPMEYLMecOpd5aeyxT5Zbfc8uRhQUvaJaga5Qs
         eR7H+oPxo1Ioi7PxWIoWpqOopQcGUKLy1VWQAOkUu/OgnvgtcFtrdRrWkWkDMRD0medP
         JEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512992; x=1730117792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTVtbHUUOZj0Fo+dP6D7qhW4pSqQbmSUEEadn5eVpyk=;
        b=Fu1bXFZ5boOHGHcvS7RchiZg/3FelLLREXWBGxARpBb718yS3ox/bwZRZSIUjOj0Tb
         pvd15ussIkMHnaagx9YK0MHNo07154rZLLhxqtdgAAFWFjS7NdF4WQnbxSGJJIMHSM4N
         xpCETP3Dzl1uEOCNfn78iVMf5n5WgjEaM0v+Hbg00y0Tj8td/4FOhvgDysYU0igCJHgv
         +BfS65Z9g0NDCnUOvHLTfa8Vb3fktj6czAPctsUfNqCb2ad6QbTao59CqWFJ/FjLEYhk
         WlUSPxBRyjcqSBiWGz2mP7IIv7kR9L10ujH+Va82FbanwONEAwar0hMa5XpOjfIWSOHC
         GLVw==
X-Forwarded-Encrypted: i=1; AJvYcCU3MOxt6pP4Kyq3dES0efMROm0lqDOrdt4eHr3gg7A5JWQK2U4kJTug+u+qK66NmJ78pgcjgs95vOXW@vger.kernel.org, AJvYcCUILcMQ/HDnLxA38Pu8ndqxVYsOZcLDxy/aGWK5KRvUBuybPxuzoFd46l6CIVNqUKzOTXlsbo/VeqwObgnl@vger.kernel.org, AJvYcCVVC9X2gJz1P0DDbYiiRcufbkGo9coO6qNE6/p72exFB5HPiRebWA/T11jd8Z0zul0Ra68tZPfagv3T@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmcG7nK8xNIa28w4y9L7IJb6JEc8MeQL3jMh6kaCl/x6Nd91b
	jTvGOsKcpSBpj+2kc2arnIA12B0mD3zHG4F97OF91sqESRHjEigw
X-Google-Smtp-Source: AGHT+IEm0Ja1MxSFcWf7f2KGhUWcvjXbHvNe9J2o5guzSmTzD587KByO1eC9ACbJeOYsW3chN/7xMw==
X-Received: by 2002:a05:6512:3b89:b0:52c:cd77:fe03 with SMTP id 2adb3069b0e04-53a1544481emr9066938e87.14.1729512992115;
        Mon, 21 Oct 2024 05:16:32 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6ee6sm197068966b.4.2024.10.21.05.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:16:31 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: clock: mediatek: Add bindings for MT6735 syscon clock and reset controllers
Date: Mon, 21 Oct 2024 15:16:15 +0300
Message-ID: <20241021121618.151079-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021121618.151079-1-y.oudjana@protonmail.com>
References: <20241021121618.151079-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add device tree bindings for syscon clock and reset controllers (IMGSYS,
MFGCFG, VDECSYS and VENCSYS).

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/clock/mediatek,syscon.yaml           |  4 ++++
 MAINTAINERS                                       |  6 ++++++
 .../dt-bindings/clock/mediatek,mt6735-imgsys.h    | 15 +++++++++++++++
 .../dt-bindings/clock/mediatek,mt6735-mfgcfg.h    |  8 ++++++++
 .../dt-bindings/clock/mediatek,mt6735-vdecsys.h   |  9 +++++++++
 .../dt-bindings/clock/mediatek,mt6735-vencsys.h   | 11 +++++++++++
 .../dt-bindings/reset/mediatek,mt6735-mfgcfg.h    |  9 +++++++++
 .../dt-bindings/reset/mediatek,mt6735-vdecsys.h   | 10 ++++++++++
 8 files changed, 72 insertions(+)
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h

diff --git a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
index 10483e26878fb..a86a64893c675 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
@@ -28,6 +28,10 @@ properties:
               - mediatek,mt2712-mfgcfg
               - mediatek,mt2712-vdecsys
               - mediatek,mt2712-vencsys
+              - mediatek,mt6735-imgsys
+              - mediatek,mt6735-mfgcfg
+              - mediatek,mt6735-vdecsys
+              - mediatek,mt6735-vencsys
               - mediatek,mt6765-camsys
               - mediatek,mt6765-imgsys
               - mediatek,mt6765-mipi0a
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ce38c6c0e6ff..25484783f6a0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14537,11 +14537,17 @@ F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
 F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
 F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
+F:	include/dt-bindings/clock/mediatek,mt6735-imgsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
+F:	include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
+F:	include/dt-bindings/clock/mediatek,mt6735-vencsys.h
 F:	include/dt-bindings/reset/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
 F:	include/dt-bindings/reset/mediatek,mt6735-pericfg.h
+F:	include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
diff --git a/include/dt-bindings/clock/mediatek,mt6735-imgsys.h b/include/dt-bindings/clock/mediatek,mt6735-imgsys.h
new file mode 100644
index 0000000000000..f250c26c5eb4d
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-imgsys.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_IMGSYS_H
+#define _DT_BINDINGS_CLK_MT6735_IMGSYS_H
+
+#define CLK_IMG_SMI_LARB2		0
+#define CLK_IMG_CAM_SMI			1
+#define CLK_IMG_CAM_CAM			2
+#define CLK_IMG_SEN_TG			3
+#define CLK_IMG_SEN_CAM			4
+#define CLK_IMG_CAM_SV			5
+#define CLK_IMG_SUFOD			6
+#define CLK_IMG_FD			7
+
+#endif /* _DT_BINDINGS_CLK_MT6735_IMGSYS_H */
diff --git a/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h b/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
new file mode 100644
index 0000000000000..d2d99a48348a0
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_MFGCFG_H
+#define _DT_BINDINGS_CLK_MT6735_MFGCFG_H
+
+#define CLK_MFG_BG3D			0
+
+#endif /* _DT_BINDINGS_CLK_MT6735_MFGCFG_H */
diff --git a/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h b/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
new file mode 100644
index 0000000000000..f94cec10c89ff
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_VDECSYS_H
+#define _DT_BINDINGS_CLK_MT6735_VDECSYS_H
+
+#define CLK_VDEC_VDEC			0
+#define CLK_VDEC_SMI_LARB1		1
+
+#endif /* _DT_BINDINGS_CLK_MT6735_VDECSYS_H */
diff --git a/include/dt-bindings/clock/mediatek,mt6735-vencsys.h b/include/dt-bindings/clock/mediatek,mt6735-vencsys.h
new file mode 100644
index 0000000000000..e5a9cb4f269ff
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-vencsys.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_VENCSYS_H
+#define _DT_BINDINGS_CLK_MT6735_VENCSYS_H
+
+#define CLK_VENC_SMI_LARB3			0
+#define CLK_VENC_VENC			1
+#define CLK_VENC_JPGENC			2
+#define CLK_VENC_JPGDEC			3
+
+#endif /* _DT_BINDINGS_CLK_MT6735_VENCSYS_H */
diff --git a/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h b/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
new file mode 100644
index 0000000000000..c489242b226e2
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MT6735_MFGCFG_H
+#define _DT_BINDINGS_RESET_MT6735_MFGCFG_H
+
+#define MT6735_MFG_RST0_AXI		0
+#define MT6735_MFG_RST0_G3D		1
+
+#endif /* _DT_BINDINGS_RESET_MT6735_MFGCFG_H */
diff --git a/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
new file mode 100644
index 0000000000000..90ad73af50a3f
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MT6735_VDECSYS_H
+#define _DT_BINDINGS_RESET_MT6735_VDECSYS_H
+
+#define MT6735_VDEC_RST0_VDEC			0
+
+#define MT6735_VDEC_RST1_SMI_LARB1		1
+
+#endif /* _DT_BINDINGS_RESET_MT6735_VDECSYS_H */
-- 
2.47.0


