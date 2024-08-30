Return-Path: <linux-kernel+bounces-309028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76896656B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B861C21D28
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7E1B5316;
	Fri, 30 Aug 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC/hL0QG"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3B192D98;
	Fri, 30 Aug 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031720; cv=none; b=YfBRiBEwyVa/b7+1PxeVN7i6+wK9kyWOckOYacFi7uQ+AdWNm34QsZZjs7ZXQXJO4aPqYj0ytmtN16Abk8W32giIki6vrsAqXiJ4ee5qwEhq03aFEj4qRXmd1UdR+fjjQuIY1NsL93Du67VP9fGVUMm/90QAq5c3oLxoGwubPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031720; c=relaxed/simple;
	bh=AA6yHhNwFoIzhgB8deEEzS7dTPgwOUltcjodR2b6y7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jvv8u14ozJNwgjs7SHaMSEzsa8fWFESCGwCVrd3IaA+IDPpiDJDYrrymCnD6rVcfKdkRpOK19tjwaidqhYqjUkFF2c/dO2+qN4iuhXNauROY09FAkbJcLUceVtkkslFUiF7/YoLWo75HW+G6MRgVRfh1sxP+bpo65PA8A0Of+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC/hL0QG; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a29c11e1cso27640939f.0;
        Fri, 30 Aug 2024 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031718; x=1725636518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqHvmoCIARVNpToj+eYuwj+OmsqaSf4MJ85C1291WbE=;
        b=bC/hL0QGd0FwPoLzUQSylYVFBzS+4PnaUkhkwUV+fw9H5Yq/p/uXBaMAlJcq36jH4u
         5xsRd87fQnT4Ey2snLq/eq6borMFJSAyBjEa1MLKB7iayojbEaEzuPfTrcruabkQ1did
         2DhKnUCFmtorX82ftxdqekFK6wCC66vD8lcJWPaKhaN3lALwHgH7P93biZT4U0HyAAAn
         i7YJzz+/SlgO6H84GqRW8aNOdyYZUVGqNRawa0tVGu0fwqo3iec4t9+syON5aR84yyh9
         EWBj1rGMxPzWSAOCZi3EXMZMYAYUF8106oqcjLKXbMAjaxt1HPgmEl6aOrM46aAzDBKj
         OlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031718; x=1725636518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqHvmoCIARVNpToj+eYuwj+OmsqaSf4MJ85C1291WbE=;
        b=nHAvd7gg0JbX6WsoLkEyWXRudzj37IhuDDqOzcDQMOFGhAqdLUCpzyzpK19LWkJxxD
         7gTYmhiH42sSnwKqdasG+ALNtGViiXCxx/7/2bGRCtXDwi2MZ6bsSyCVFX2ucQPGBtgw
         /MoGzwg0us+BErT+LJ0D1rXvNY5WaC2DtBL85DCyKlxt5EuW2MYAdeglkmyflWBNaG15
         cvwwtdO67vBq8V41LFmkzb9i6tLafCoFfCUrThtpv6K7KUXwxcOsXIui+8cG1O0jcjGQ
         novKvy/ONjk+rRcCjQe8QaiZB8kn5M4VZv4nx4LgJBwgmUGlVyHmS/DxoRkAoe8EQx8S
         4hjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbUUBjS0V03cU1JZVuasBTRsMZ526oCctKERcS4Bwt6jD0skKRsF3AOyr+X3/LCf6C4wd5LRYTmOu85xc@vger.kernel.org, AJvYcCVaJvCPGSb1XJAdOzyuVpxN7yMyzZ4H9+7zmfUNkxosq6HGxvR8rH7r9G66qHV9RzaqJdp31ie0kF2r@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqI31VvEAPoNw9mmHFTTkcXSAOmW+t4ERA6ouHXftYUsUCI+c
	EDM02ZDfWdUA5uDL+gOBxBHK3M9H2aLp0ydtvQ/SgGlDlBw7TH3e
X-Google-Smtp-Source: AGHT+IEVzWuJALU6+1aSVs6qiSwfELdZVdFHqAGu2Xy58PmOhzNnpMgp8wbA0kkenx3QfFsUSRnUGg==
X-Received: by 2002:a05:6e02:1d04:b0:39d:286c:5b72 with SMTP id e9e14a558f8ab-39f378acb8emr64917755ab.28.1725031718371;
        Fri, 30 Aug 2024 08:28:38 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b05940asm8853415ab.77.2024.08.30.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:28:37 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	algea.cao@rock-chips.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	tzimmermann@suse.de
Subject: [PATCH v5? 3/6] dt-bindings: display: bridge: Add schema for Synopsys DW HDMI QP TX IP
Date: Fri, 30 Aug 2024 10:28:24 -0500
Message-ID: <20240830152825.9053-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830152132.8894-1-shimrrashai@gmail.com>
References: <20240830152132.8894-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml
new file mode 100644
index 000000000..141899ba2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Synopsys DesignWare HDMI QP TX Controller IP
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+  - Shimrra Shai <shimrrashai@gmail.com>
+
+description: |
+  The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX Controller IP core
+  supports the following features, among others:
+
+  * Fixed Rate Link (FRL)
+  * Display Stream Compression (DSC)
+  * 4K@120Hz and 8K@60Hz video modes
+  * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
+  * Fast Vactive (FVA)
+  * SCDC I2C DDC access
+  * Multi-stream audio
+  * Enhanced Audio Return Channel (EARC)
+
+  Note this is not a full dt-binding specification, but is meant to be
+  referenced by platform-specific bindings for this IP core.
+
+properties:
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+    maxItems: 6
+    items:
+      - description: Peripheral/APB bus clock
+      - description: EARC RX biphase clock
+      - description: Reference clock
+      - description: Audio interface clock
+    additionalItems: true
+
+  clock-names:
+    minItems: 4
+    maxItems: 6
+    items:
+      - const: pclk
+      - const: earc
+      - const: ref
+      - const: aud
+    additionalItems: true
+
+  interrupts:
+    minItems: 4
+    maxItems: 5
+    items:
+      - description: AVP Unit interrupt
+      - description: CEC interrupt
+      - description: eARC RX interrupt
+      - description: Main Unit interrupt
+    additionalItems: true
+
+  interrupt-names:
+    minItems: 4
+    maxItems: 5
+    items:
+      - const: avp
+      - const: cec
+      - const: earc
+      - const: main
+    additionalItems: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for RGB/YUV input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for HDMI/eDP output.
+
+    required:
+      - port@0
+      - port@1
+
+additionalProperties: true

