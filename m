Return-Path: <linux-kernel+bounces-258767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C395938C82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5571C230FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB3174EF4;
	Mon, 22 Jul 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="DzFqlru+"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA116CD30
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641508; cv=none; b=hL1hE23b/GKSL4bCCNNAD8PAsx2qM1li/AP17nAORYPHn0MqYsbpEnj0mlfYsFje+9pVF3xfugTrTNrne9Csyqwd89AXqfr3yala6i6QWBoTsXh4K3DTm2cFtH+i3HfXTNJX4iVcr9s3u3FouXj1jUxQbjq+FnwI3FEYaORxzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641508; c=relaxed/simple;
	bh=JVTV4LpXfQIy/ruik+P0dnGNR2Q9xIw1w/eCRtiVszk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV7U0hNnae3dHo+auHSrhAcYAjFjJDWX7rgyQj+FEN42pWTWryxNZ4PKosUzz3qxB4WaXu5azyY2GV2hQzH5bMcbwWtItMl8+EMF34rCeO7tQbqrPs9KOj7XdNahksQMfQ7pKQwarMxrDb9mheBFwb5ODpUNmHkEysnAnAMtSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=DzFqlru+; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 5BC7D322AF7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641396;
	bh=JVTV4LpXfQIy/ruik+P0dnGNR2Q9xIw1w/eCRtiVszk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DzFqlru+palasZXJ8/xABG3iAUzC6au73kHJyjwr9Vwtdwd9l+lxbTdQ7ZH5A/Wbq
	 1vu16IEep7t1/lUjW2L0B9qOnPIwBtldZH9BwJvBhMbRqU2ZSKdp1ljWuBcsI3DhCu
	 F22bT+dop2TusFA4da1j9WePNu3hDhUaOOiiUhh8=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 3333B3228F2; Mon, 22 Jul
 2024 11:43:16 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 9BDB9322636; Mon, 22 Jul
 2024 11:43:15 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 68E7140317; Mon, 22 Jul
 2024 11:43:15 +0200 (CEST)
X-Quarantine-ID: <ezh67vRpH4vQ>
X-Secumail-id: <9f9d.669e29b3.9a2a6.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan
 Borne <jborne@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>, Yann
 Sionneau <ysionneau@kalrayinc.com>
Cc: devicetree@vger.kernel.org
Subject: [RFC PATCH v3 02/37] dt-bindings: soc: kvx: Add binding for
 kalray,coolidge-pwr-ctrl
Date: Mon, 22 Jul 2024 11:41:13 +0200
Message-ID: <20240722094226.21602-3-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add binding for Kalray Coolidge SoC cluster power controller.

Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: New patch
---
 .../soc/kvx/kalray,coolidge-pwr-ctrl.yaml     | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml b/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
new file mode 100644
index 0000000000000..e0363a080ac11
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kalray/kalray,coolidge-pwr-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray Coolidge cluster Power Controller (pwr-ctrl)
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+description: |
+  The Power Controller (pwr-ctrl) control cores reset and wake-up procedure.
+
+properties:
+  compatible:
+    const: kalray,coolidge-pwr-ctrl
+
+  reg:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    pwr_ctrl: pwr-ctrl@a40000 {
+        compatible = "kalray,coolidge-pwr-ctrl";
+        reg = <0x00 0xa40000 0x00 0x4158>;
+    };
+
+...
-- 
2.45.2






