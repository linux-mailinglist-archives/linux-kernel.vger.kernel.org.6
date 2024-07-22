Return-Path: <linux-kernel+bounces-258768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1258938C83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC481F247D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E3174EF8;
	Mon, 22 Jul 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="gZNymj64"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC416CD31
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641508; cv=none; b=ofNYkvWcgiBQ5SN44XGHUJhTXx1HsEtpyETnJ/V5MdZby9H2uR7nbL/UXuJHsNuPsxIHAqjNOexeJ2O87dtAnQDPRARmWKe8EB5jB2/fzszNY8wKKD8UI6ClUBosvcwwENO/ibQM4pTAdY6+rnkYf8GVxAlfwusf7hRwVKtUSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641508; c=relaxed/simple;
	bh=fwX+YsfJOl3mEYIawJDK2JgL5aB2rHwM+jyV/SOu7MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apvuCWv9H5XfJ7V81kkk45ICPtKWeIfCvGnf71yG92zpxQiVL/bSa3oIIUzlHBE6j3KpDlJgQ7bEML/zEih5ynJ+3MXpn0t3Ti074bmODvTLzTleIAv58jgkWjxt1jxXKOvYGe+x5+2ySWj5JX2J+LmbHHMACeDyXizP+9mhEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=gZNymj64; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 4DDBC322BAF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641399;
	bh=fwX+YsfJOl3mEYIawJDK2JgL5aB2rHwM+jyV/SOu7MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZNymj64zn/cuSOSHgNdOHTLIyOzU2ZyqmiG2mEoufnBe3KOOQjfkXLMKyyZzFAvz
	 NPOgjq1SBjj932NSJ+bVp+XAJqDxuzBhYpZm9Q8NMOIu9dPf60D4PlZNARiMIZ5BdP
	 V/hwt9zZQxttW/x5FMRhnNeIZ9GUHWZKkre7jlzQ=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 0C0C03228F2 for
 <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:19 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 6EA4B322462; Mon, 22 Jul
 2024 11:43:18 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 3538140317; Mon, 22 Jul
 2024 11:43:18 +0200 (CEST)
X-Secumail-id: <16976.669e29b6.6c7d0.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v3 08/37] dt-bindings: Add binding for
 kalray,coolidge-dsu-clock
Date: Mon, 22 Jul 2024 11:41:19 +0200
Message-ID: <20240722094226.21602-9-ysionneau@kalrayinc.com>
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

Add binding for Kalray Coolidge DSU (Debug System Unit) clock.

Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: New patch
---
 .../clock/kalray,coolidge-dsu-clock.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.yaml b/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.yaml
new file mode 100644
index 0000000000000..a7f6239b17c12
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/kalray,coolidge-dsu-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray Coolidge DSU Clock
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+description: |
+  DSU Clock is a free running counter that runs at Cluster clock frequency.
+
+properties:
+  compatible:
+    const: kalray,coolidge-dsu-clock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    dsu_clock@a44180 {
+        compatible = "kalray,coolidge-dsu-clock";
+        reg = <0x00 0xa44180 0x00 0x08>;
+        clocks = <&core_clk>;
+    };
-- 
2.45.2






