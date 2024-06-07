Return-Path: <linux-kernel+bounces-205432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3548FFB83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9FA285FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D204414F123;
	Fri,  7 Jun 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2ChpyZO"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0529428;
	Fri,  7 Jun 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739869; cv=none; b=Mjpq47mu2+D/8kC+SDJOS17DDA7ni5iZYWFniq+Pprx6DqeY7Q4mtXf1J9RIRPGZ/TfwyptB1+/40Rg8ZzriGdiQDVw7jG0S7+1pnNN6s60/EpzTaO6KxM3h/3sfuN/r5u0A47eFnx4uonlEj8nztEGUXReu01JPegitU7jb1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739869; c=relaxed/simple;
	bh=vv35pFUwHkf/uwLXB4LbhDkeu+0zSuEviY8q+E2Jwik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CP7CCoUYfvv88ToxQkuaAJaKnczmrGthkLFRelK7tSvXn7QrPuM16kS3ETEicQp53IO4HV8DtXFsq9IYQLSv37V5wcv8ovf5X/5AKphDkAvaTRi3XzidAs97/s5aL88KdlFXCF4WHV2+/CC+fOogxrEh1PIXIofB0l9xD2l+B4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2ChpyZO; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b96a781b63so555787eaf.1;
        Thu, 06 Jun 2024 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717739867; x=1718344667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1q3fNV14A981xBed0EkKUFuHUmGLLdEdMBsAvyaRYM=;
        b=W2ChpyZOEx5MsINOT8mHclCvz2hPFqtxsEQON3N/DX/x2mIqN5bNvzOYjwkl7uQH9e
         3X4r878prUi54TIocpldEoEP7Z0LXeNtU/X8924fcjqAff7shOSoCt8UV/C3D2Df76eO
         pBbTNYC1z61GNnMpp/bLyfb3odfJw6z3qKKaFLqt+9Lmi1Zyn0HfjTco0IJ/BsOqCrJd
         xHYa40oAKKiO83D3Z+y4655ADC/8psnTtG7DXEFJ5YRIVodDqgP1lrmZOGTzTzaIp5QZ
         VOJA5Qi88yWC8PdwYgLGrn8KtiZGSe9OS6ij6XXjOjhDHPk833BkkxaNl7SRFyGUJ+Wi
         U0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717739867; x=1718344667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1q3fNV14A981xBed0EkKUFuHUmGLLdEdMBsAvyaRYM=;
        b=CszVq6dUt0A2BeZyBGeiheM8Q9GtHsHnYvaQnMNzLPS0SqqBADlwt9hDA8DRo7LXJ5
         dPIbeRc3DUDAxwgLRphpv3BdhrnXJmG4DLSJlYWEXvo1RGkRMlrDNQguTnZJ7cAAo04m
         nOhS1mZHO5bEhVs9oydYmUmr6M0d/9g13EYhMghIGkBnsWPVj6/xcQpzxpU71LslsK/4
         GmuLwTwXBe9yNbJ1iitUVnRV1d4rSAtH3x0mYevpIBtwkbiHuB4ywKKunkVFupj/KekL
         ngfyYP4V05eNvaEWHFnNzrezoeDw5ioHgDSm4U2wKSyWJ2WqUiUkyXWx7chtQhhBfPFR
         4tNA==
X-Forwarded-Encrypted: i=1; AJvYcCVdgotoCX9El+KyNAoJ7JXOnFRNOKzfcRvh0NbA+d8ucCGgxljSYWzBq3Ab+n1t9aRxkFmtRmFtxPRWlfZ3eShmUnk2CeVZuzq/MlZ4HAyWI6ZhEXfSAbuQkM4WGl3GaCUbwJgaP5fkY5NHHxmy70qwTAB2+Js7cmiVjXlETIlU0Q+VR4lF
X-Gm-Message-State: AOJu0YwKulJmjk3hrxEdK9hoxzjJHrgb4a4NPgxcvzzcZq3m/AitKQDa
	81k4Te4Jl5ztEvxI9a6FNJ3IpAf2bXkX4SrJTAvzchSU8/darwrr
X-Google-Smtp-Source: AGHT+IFuYlytLtkiwC+niC9wfga8J2VeoGKBrZAOX+K24mX4osdkHg1dzL3l0bEgyKte5xfPuyI9Mg==
X-Received: by 2002:a05:6218:260c:b0:19c:467b:13b6 with SMTP id e5c5f4694b2df-19f1fe51028mr189058555d.12.1717739866517;
        Thu, 06 Jun 2024 22:57:46 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de264ae03csm1965629a12.68.2024.06.06.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 22:57:46 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: ak4554: Convert to dtschema
Date: Fri,  7 Jun 2024 11:27:20 +0530
Message-ID: <20240607055725.38057-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the AK4554 sound codec bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/sound/ak4554.txt      | 11 --------
 .../bindings/sound/asahi-kasei,ak4554.yaml    | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4554.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4554.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4554.txt b/Documentation/devicetree/bindings/sound/ak4554.txt
deleted file mode 100644
index 934fa02754b3..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4554.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-AK4554 ADC/DAC
-
-Required properties:
-
-  - compatible : "asahi-kasei,ak4554"
-
-Example:
-
-ak4554-adc-dac {
-	compatible = "asahi-kasei,ak4554";
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4554.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4554.yaml
new file mode 100644
index 000000000000..c77d85df239e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4554.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4554.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4554 sound codec
+
+maintainers:
+  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: asahi-kasei,ak4554
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    codec {
+        compatible = "asahi-kasei,ak4554";
+    };
-- 
2.45.1


