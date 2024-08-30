Return-Path: <linux-kernel+bounces-308159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73908965804
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993821C226F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A2165EED;
	Fri, 30 Aug 2024 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5JV0Z2B"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DC15C141
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001485; cv=none; b=DTGyEPr85Shesy1KsCO7w6BgLPTr8gcTWdNsRq1bCr8dKlvCwL5OX4cnaZmMBBsEZWk2lERJXvaz6BPbrY7Su5farRw9oLWYXZHg6ndRTaZRp1g2zb+g7M0j/V6qImI9zXlFbJuu7cHqhrVrDgqxZSQB5ydAdWD6TOfdI6eMZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001485; c=relaxed/simple;
	bh=Ds/p/QFF05sAfiQkLU7WUEFq731HQlapY7eFUuPiT1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D57IAp92gLTJxrZeXNiT4QAzyPmMOq80W22OffPC7qgVctNRwmunhROYyQwWs8YY2x67yDxjyRhFwoBf2ISzBTpoOtgB/zp+30k3pnAHH+Lrr/114Rg58WFybgL7p6U2LvdCImAYaU4mzM+6kg8rOw/A8TUspIYIcFWhc1kOAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5JV0Z2B; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a867a564911so179272266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725001481; x=1725606281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfKg3et82GR8Ut+Mah5KVc5YDnZncDhvNa0IoupXc1A=;
        b=g5JV0Z2Bp7xrqloOddFPC4aQyt66eAcYjODTp5zrihHQisSIFxkBms28HER0F0t8ee
         B3QcDwOL5vhnMxvvZcy8kVtynfmaSZZsk1RFlyK+UJnYdf6SnQVbp38+KetnrvG6W7o2
         c5K8tSmMC5yhggUh6hPHd743TkDQ5zlsUiIVOw1HkcX5KUPWB2QFusekVfTZRPpI7wuJ
         cjm8ugHg0mm3dj2Kw60yVtHJbUpOKkgiDNc1XL2eu4W6WjrzzK3OwLGQQbu3m5gKfhzu
         hBnxea9+brn4N/DjBGCDrsg9xY7IMy8ju2/FZ+HivLhQDhQnr/BY0iUk2PGgc0ZKn7Yg
         zlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725001481; x=1725606281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfKg3et82GR8Ut+Mah5KVc5YDnZncDhvNa0IoupXc1A=;
        b=KTYdPReUdKF3mHLTMsAkx7a/6wc1q7z5APVF7PfVkY72qi5OUzLe6xxi3fqaJUOCMM
         NlS1riHz7FIAI7jFKM0eg5ckNSmjNTzZrY2qcPMoLmqIMjHBXKdl+ZxHlXs8fxSLq+p9
         oSUyklL6V01nMPrOczTj0g3CWmnSPxn7RhOfw1dTaqe2osmP2T45V/TK8gc4AtwSLe7c
         hnPwyxE1fI2xCgEHYkKxA00ZWyTOrsk1xRVF19zORzZ5MPrvxceRwxJYj3zL+6q55EOo
         4hsPAS3YPCQgOiIOs62IjwkWe96/57YF5cdUGwjGgqda7zS2rAQNJmqkRvU0EXXJMn35
         nJUA==
X-Gm-Message-State: AOJu0YxNqRU2vMyC7uRPIKqkBOvsWbteh8wl7qeM+Jn6YF+mw1852x7K
	HrRpmjrnt9rISopfuunCQXyMHUX2vQdgE9XXm3LCXJ4Vb2Oby/y+p34ti1I6qQ7BhrLhehdMNYr
	PVABrdg==
X-Google-Smtp-Source: AGHT+IECnqDtOxbvfOy9sPbk0lCyiNAqNWYzneroZfijzEEU+LtepnDur/LFnUatGwBb6xPr3tERGg==
X-Received: by 2002:a17:907:6d0a:b0:a86:7f6a:8779 with SMTP id a640c23a62f3a-a897fad4d42mr418259566b.57.1725001481050;
        Fri, 30 Aug 2024 00:04:41 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892232c7sm178026866b.222.2024.08.30.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:04:40 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH 3/4] dt-bindings: reserved-memory: add linaro,restricted-heap
Date: Fri, 30 Aug 2024 09:03:50 +0200
Message-Id: <20240830070351.2855919-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830070351.2855919-1-jens.wiklander@linaro.org>
References: <20240830070351.2855919-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olivier Masse <olivier.masse@nxp.com>

DMABUF reserved memory definition for OP-TEE secure data path feature.

Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../linaro,restricted-heap.yaml               | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/linaro,restricted-heap.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/linaro,restricted-heap.yaml b/Documentation/devicetree/bindings/reserved-memory/linaro,restricted-heap.yaml
new file mode 100644
index 000000000000..0ab87cf02775
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/linaro,restricted-heap.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/linaro,restricted-heap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linaro Secure DMABUF Heap
+
+maintainers:
+  - Olivier Masse <olivier.masse@nxp.com>
+
+description:
+  Linaro OP-TEE firmware needs a reserved memory for the
+  Secure Data Path feature (aka SDP).
+  The purpose is to provide a restricted memory heap which allow
+  the normal world OS (REE) to allocate/free restricted buffers.
+  The TEE is reponsible for protecting the SDP memory buffers.
+  TEE Trusted Application can access restricted memory references
+  provided as parameters (DMABUF file descriptor).
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: linaro,restricted-heap
+
+  reg:
+    description:
+      Region of memory reserved for OP-TEE SDP feature
+
+  no-map:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Avoid creating a virtual mapping of the region as part of the OS'
+      standard mapping of system memory.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+examples:
+  - |
+  reserved-memory {
+    #address-cells = <2>;
+    #size-cells = <2>;
+
+    sdp@3e800000 {
+      compatible = "linaro,restricted-heap";
+      no-map;
+      reg = <0 0x3E800000 0 0x00400000>;
+    };
+  };
-- 
2.34.1


