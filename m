Return-Path: <linux-kernel+bounces-433833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3ED9E5DB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F055B283ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056021CA1F;
	Thu,  5 Dec 2024 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWt3CZVl"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CE224AF6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421232; cv=none; b=CuW8u5ilG5nKNA5JMIAPDRudWiLq3nRYDlgIHgs9LwPdlsSskZCnUTBN8pQao2bPD8LP3fCjTN7KY9CiOYm8aHQrmLNfCYyXM9JOd2gZVhkoDlcVvYiH0QPmgOX3YuiF8YFeQEwu7U+Qatkeak3IfuDpgubAKiJElg9EODHuvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421232; c=relaxed/simple;
	bh=BjPBsTXSUJhOZ07W5tsbKN6EJfyDsDv5Mkm/n+Qnf7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQsg6Vr9YX/GODo9EfRYpayExbqwW4Y7wPnd1UHh7nHULA15Vv3QVPK/my1IEVYbAhz6sR/k+X8ny9IjuKRqsgrG2cUegAlPu6Mwq6doYGFKtLCcLjfAhr8H6ugNUkQQj8V1eT+SpDUlzKu47MrIevZpIFZ47WOI9CtoRCHT0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWt3CZVl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so8622135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421229; x=1734026029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR2xJ5Z9SsCGNBcYWItEbZKibtJD439Z5G3+KUVhGYw=;
        b=nWt3CZVl1YtjAofaSKC8UUvj4W4CSZ5TBxSfH7rYefKpLvtF/xCJcptFyvUFPGHRR8
         Qujd1olIpAxyNlm9rNwq9mndcpltD0fZwea6IPPOZ2J446yiu/DtF2JzQCL5RNmSYI36
         fZ2Piaj4eoPzPXWxRXNPISnot+XaEWAYv8b1kKrLlXchGl2xs9GN5uYvnskQTLDQDEiZ
         3tz26rdQvgqagq0lodDthWh0N+ItkgSedF83W4dIR8YcZwmyqKfPZETCjrI8SotDRXDW
         Tr+9ehRDs4DZJL6zJ2ebJ5mxvAOS21PyP9qnA6tEhBVxbyBs8viE0hLHdQGVMEWEwhzt
         ZWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421229; x=1734026029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR2xJ5Z9SsCGNBcYWItEbZKibtJD439Z5G3+KUVhGYw=;
        b=AiE2tFrZg8U2y11Pl4W/jTm80/h4IjaJG5E3XIeOegNukKKiHlK1JW+VEVHv6Ylgv6
         hETisQxqTALaPVs6ZKqr0fcS/If0QVd8jNiknDlLgChjuT9h6pmvExeVyj5iFgrdXV54
         of5tqS6SLBPq7hU7d9uy2mLRtrixWxlGZF+4okDr+MrabBO3KzrJH9/0PCOSpCBmy5Sr
         fEk3Rgwo9Bxh/kGrq76JfqnGi2lqFT4/O9aAffrCFUZ1Cn0jBaBBJFMpLGfG/Y7U3NMQ
         NdceT+0Toy3BN87fROE3jVFdv3nLruNx+GTk9a7GItsGYdshgmkGG9NaTgHTh5ychVnR
         +jmA==
X-Gm-Message-State: AOJu0YwA5GV5JyKBUGo+VUHGaAKcqT5RLRbD6VCIiGJffsOCbxahFrrP
	G5ukg/lBDX//rlo0rwQFpYRGcbjSHf+mVsrotcrMVkWTU7+WWq/h03D/J1LD4sA=
X-Gm-Gg: ASbGncsrTcExSm5YVTeTgw7HDFhd8RSoN1xNbLWFapGonpbGx2J4ZSIWQXkTnhCBlcz
	8DF1AcT6GDE+eTOX1+rw7UhGqeDsk9VLiGQ5GLPkQZa0SLsYV6ydeUknfUugdN9I3wvF3iT0Ttj
	CmPqr4ERG3Zyqml+Z9v/9eO7Xofah5eXYZ5K8uW/3SXRQnAxIDAQmMt3SFUMHOfvDDjJAhuUu2h
	KYOP/gdXjkt/cczwQL09DM9HmJesfISvZehDlkUgH08XLTT7eDjXD0YMsjQ3WS2eCzSstLN86dX
	P25tPGcp+SznuRicQgBYee/5mDOc7n7o
X-Google-Smtp-Source: AGHT+IGglrekvKKTqqsY8LE2N+RmZaoeHCt9yP48Sso0w5nnfmLh8mPNzUHKoOLK/L5/37jluV81wQ==
X-Received: by 2002:a05:600c:1d21:b0:434:9cc4:5139 with SMTP id 5b1f17b1804b1-434ddeb0492mr2236875e9.17.1733421229341;
        Thu, 05 Dec 2024 09:53:49 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm67882835e9.24.2024.12.05.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:53:48 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	javierm@redhat.com,
	tzimmermann@suse.de,
	daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org,
	ulf.hansson@linaro.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: firmware: add samsung,exynos-acpm-ipc bindings
Date: Thu,  5 Dec 2024 17:53:43 +0000
Message-ID: <20241205175345.201595-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205175345.201595-1-tudor.ambarus@linaro.org>
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the samsung exynos ACPM mailbox protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../firmware/samsung,exynos-acpm-ipc.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/samsung,exynos-acpm-ipc.yaml

diff --git a/Documentation/devicetree/bindings/firmware/samsung,exynos-acpm-ipc.yaml b/Documentation/devicetree/bindings/firmware/samsung,exynos-acpm-ipc.yaml
new file mode 100644
index 000000000000..bfc9b4af9ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/samsung,exynos-acpm-ipc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/samsung,exynos-acpm-ipc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung exynos ACPM mailbox protocol
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
+  $nodename:
+    const: acpm_ipc
+
+  compatible:
+    const: google,gs101-acpm-ipc
+
+  mboxes:
+    description:
+      List of phandle and mailbox channel specifiers.
+    maxItems: 1
+
+  shmem:
+    description:
+      List of phandle pointing to the shared memory (SHM) area. The memory
+      contains channels configuration data and the TX/RX ring buffers that
+      are used for passing messages to/from the ACPM firmware.
+    maxItems: 1
+
+  initdata-base:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Base address of the configuration data in the shared memory.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mboxes
+  - shmem
+  - initdata-base
+
+examples:
+  - |
+    firmware {
+        acpm_ipc: acpm_ipc {
+            compatible = "google,gs101-acpm-ipc";
+            mboxes = <&ap2apm_mailbox 0>;
+            shmem = <&apm_sram>;
+            initdata-base = <0xa000>;
+        };
+    };
-- 
2.47.0.338.g60cca15819-goog


