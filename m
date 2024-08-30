Return-Path: <linux-kernel+bounces-309231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C59667D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CA21C240C7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CF1BB6B8;
	Fri, 30 Aug 2024 17:19:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96361BA860;
	Fri, 30 Aug 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038391; cv=none; b=DnVCp7iH0XFph2ojebaz/A3iCBV4NKjlORHTY+6YtQmuULi+VV1oDka3q49mgJka6HEVb1jhqSFCxIBSFbDfcyqkbhsMS0COR7oecBmKWPF2ODOWs4kpEadHEvkMLlB2hbUoWqvhpsxW7oDbd7SJtNAsHPWA1R596ZX7uOlI+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038391; c=relaxed/simple;
	bh=lIgLln/zPB1RpPJPx0whGSqDqOO4FG9Xn0vMf5BK8Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXn7PSl8KxD6h92A1a/B54RA4aH1E/5f7fQdz2Zht3uMGb1b3vYjyL4A5sLu4Kc4fuDNwndWjUdg4SZJsbtdxVZf/okJseyLz7lZMfeJ1DFJoWjRk22lVhyFF4E9I2wEQYz7pWQA70+SMi7/4/ojLOws2fO363/oqIoNvZnIcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D1D1477;
	Fri, 30 Aug 2024 10:20:15 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FD993F66E;
	Fri, 30 Aug 2024 10:19:48 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings/perf: Add Arm NI-700 PMU
Date: Fri, 30 Aug 2024 18:19:33 +0100
Message-Id: <5f86237580219116de37e5e54d8b7eb0c9ed580d.1725037424.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725037424.git.robin.murphy@arm.com>
References: <cover.1725037424.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an initial binding for the Arm NI-700 interconnect PMU. As with the
Arm CMN family, there are already future NI products on the roadmap, so
the overall binding is named generically just in case any
non-discoverable incompatibility between generations crops up.

Cc: <devicetree@vger.kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change

 .../devicetree/bindings/perf/arm,ni.yaml      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml

diff --git a/Documentation/devicetree/bindings/perf/arm,ni.yaml b/Documentation/devicetree/bindings/perf/arm,ni.yaml
new file mode 100644
index 000000000000..d66fffa256d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/arm,ni.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/arm,ni.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm NI (Network-on-Chip Interconnect) Performance Monitors
+
+maintainers:
+  - Robin Murphy <robin.murphy@arm.com>
+
+properties:
+  compatible:
+    const: arm,ni-700
+
+  reg:
+    items:
+      - description: Complete configuration register space
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
+    description: Overflow interrupts, one per clock domain, in order of domain ID
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
-- 
2.39.2.101.g768bb238c484.dirty


