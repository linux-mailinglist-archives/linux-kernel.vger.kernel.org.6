Return-Path: <linux-kernel+bounces-443345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D238E9EEDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB30161CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42792253FC;
	Thu, 12 Dec 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jM/yX69W"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6C221DAA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018402; cv=none; b=CJCc+UjQxm6/invpxYvnWURNNgGjWRSKhbeI31eRbNTYzZcPLe7uFBqqN2SU3qvX86blfNHf+PRJP/dpCXMNeEYLU1qo9Gqdec3brdxkmHJpBP6PzhpvW91xP2q2NA9L/MZ+G+XZG5RcZCCJo2hLAhk3Jwo529Wg27W/Jqkl/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018402; c=relaxed/simple;
	bh=cEhVpbbgbLN/il4wFzhz4s4fTLiguDqzZ1YIvysOh58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHdxq6VFowXjosAqu5v2IXikIWXOlj7mzMMM7VhWIe2xMtXMr6P7rCnXuHD7M3uEisuheqiNCQL7YHyBJFmmuqXCiQv52gWamGaMFIDWb/CST8oKfCA+PrtVNZiqJeJFduwUUls7vE79CFCAbe/CuUAPjquHhs8y62SEqfcnU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jM/yX69W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so8375625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734018398; x=1734623198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WsKt5owuBinbsPCptNpyMgMvfYh26FsI8OPPdtiDjI=;
        b=jM/yX69WnUxdeATG9KSatiEipPa688iZZZXHJ1uJXb4wkOi/QGv4MToklQ+Iq2+51o
         xO95vtL5H9V7369W6rzSn1r+E8aIXT9wYapMxSX8sjIRhINus2gafivHf+eL4CZLheGE
         rGym02ZfYYzCs7n69jjxLEdLo+IsG+9fO1w/i/cd2FAl+ScEfC6i5aVFbjr64i/breX3
         XIeW7FBJH+WPyvQALgrAmBNwUdrrh/Qsp4FlbhIwW4jb7YooubKjcEc4e8AC5pGqWnkQ
         j1Kax+VRwLtsVXmT+5sfeFNGjzbI+aBQ4W+IN79g0UV6W523BPiLl8ti3eJ2hMvFNxxL
         GkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018398; x=1734623198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WsKt5owuBinbsPCptNpyMgMvfYh26FsI8OPPdtiDjI=;
        b=azgxDxpBsagBAfZy1Uimu0ROXeeNTYLLdNMzqqHzJDrXrE+jAQZbfCWk6IXYJZFE2P
         q86wikphcZFG4x/Fu5WGGPCjOZRFnlq/7Z838HlZJZFmDoZrL7tZidbXRF2yZdO03gqC
         VVvJ9ZTRUutjoy8PyTxkMzrIjefnfPgAGFp0AYk+q1Hm2RD/8UtvKhJZuUGrPY0y4Kdo
         7N12cXnIUz+oLEyFKQrqCkqC9Z0WEae/9hzWAbu+AUejfm7fZ907jQxpXtwtefqCN5aY
         YNbQ4EQnnUIf7h4J6efUl6aKj01LlUzzjr4F8HSE7FeESg+FrglFR0i7NI+TZmGMipIp
         rO4Q==
X-Gm-Message-State: AOJu0YxFDAb7SFliXTcQtsyNeBeKnA4Oa8Byck216NN8vvFFGbRiGL7z
	z5/R2sRNARv7z8FVeC1E1i7w10Pqgb58EEj/xW3v7mjMVlDGR6hejcUGNjqvEhw=
X-Gm-Gg: ASbGncvcBJwMQcZZCwXjT3dAt7U9XDj4nCm4mb5LT3U95E1kO2KAtBht668nz52CO6c
	hbNT7uIlzVsZ9F44IIls0rWRIzxKpv/jtI+7q71o9GtSKKNeZSM3yoM2FdY4EMCGM2pWJe289Pn
	mj29lcO0L2opGqm8SROIPmhxKcBN5LUFc10MNRSUURXp2GC+14nEP7obkbiN0aml6DY9dxBto5G
	j45p0qmO7lcbuovL2gM2IuxkDQ+9fMdf7WC+ZuoTG0n/tmCAG1+82uaqiTesGE8c3gPUUFkxJF4
	zCS1HmVz+GTUmOLQcZ7Le9dSbgy6J50AqQ==
X-Google-Smtp-Source: AGHT+IF+tOoHGDUkaMxeL60yLvDUBO3/VwAE5mhjxt8LHc7fox7yQSRqiqimmqwzGsm44iXWePis/w==
X-Received: by 2002:a05:600c:3b13:b0:434:f335:849 with SMTP id 5b1f17b1804b1-4362288371emr32131815e9.29.1734018398498;
        Thu, 12 Dec 2024 07:46:38 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550518sm20273075e9.5.2024.12.12.07.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:46:37 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 12 Dec 2024 15:46:22 +0000
Subject: [PATCH v4 1/3] dt-bindings: firmware: add google,gs101-acpm-ipc
 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-b4-acpm-v4-upstream-firmware-v4-1-3f18ca64f1b9@linaro.org>
References: <20241212-b4-acpm-v4-upstream-firmware-v4-0-3f18ca64f1b9@linaro.org>
In-Reply-To: <20241212-b4-acpm-v4-upstream-firmware-v4-0-3f18ca64f1b9@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734018396; l=2060;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=cEhVpbbgbLN/il4wFzhz4s4fTLiguDqzZ1YIvysOh58=;
 b=f3YksKtopgrGy7H1vyqUY3Bvrfn8RopvwpVOYs7QLQL2eDN0NV5jbThSpAYnDZ2tlFX/T6GHl
 MoFgi5ZKF9tBAEBt4ttVy/MtpHnDX/2vBgwMrpoi6YEl6TWcwjUxwOL
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add bindings for the Samsung Exynos ACPM mailbox protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/firmware/google,gs101-acpm-ipc.yaml   | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
new file mode 100644
index 000000000000..8821325abcef
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/google,gs101-acpm-ipc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos ACPM mailbox protocol
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description: |
+  ACPM (Alive Clock and Power Manager) is a firmware that operates on the
+  APM (Active Power Management) module that handles overall power management
+  activities. ACPM and masters regard each other as independent hardware
+  component and communicate with each other using mailbox messages and
+  shared memory.
+
+  This binding is intended to define the interface the firmware implementing
+  ACPM provides for OSPM in the device tree.
+
+properties:
+  compatible:
+    const: google,gs101-acpm-ipc
+
+  mboxes:
+    maxItems: 1
+
+  shmem:
+    description:
+      List of phandle pointing to the shared memory (SHM) area. The memory
+      contains channels configuration data and the TX/RX ring buffers that
+      are used for passing messages to/from the ACPM firmware.
+    maxItems: 1
+
+
+required:
+  - compatible
+  - mboxes
+  - shmem
+
+additionalProperties: false
+
+examples:
+  - |
+    power-management {
+        compatible = "google,gs101-acpm-ipc";
+        mboxes = <&ap2apm_mailbox 0>;
+        shmem = <&apm_sram>;
+    };

-- 
2.47.0.338.g60cca15819-goog


