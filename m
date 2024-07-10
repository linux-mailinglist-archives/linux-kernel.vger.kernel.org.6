Return-Path: <linux-kernel+bounces-247877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112D92D5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE036B22B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79821197A7C;
	Wed, 10 Jul 2024 16:09:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DD194C7E;
	Wed, 10 Jul 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627789; cv=none; b=KVYXGiKjt+sgUQsDx9OBF2CHDNzsLGvHDdKfGxvVOHe57IAo/wTsKKQPvLBsRsbSOSeRrYdEehp2zpOsiIJrdJUmS2GZ+V5E+Ezhl0ERK5JKt3njf6LOa6pmyPLOi8+RbR19Fu/IsqIDW3LoUE7HaTtx5cb7zEY5MhdOXmtR0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627789; c=relaxed/simple;
	bh=/k3BZTILZPQfWSq8N8whojUGz/Qyk9P58hWymAT7c6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ut9G0/gKNMUx9xxagnJ/5HIsz0FmlXaB8JxekAGptqFvHEC2nDvnwwQ/LkPm5GvRrAAcsRDJZz8rYqOUeXnXzD77oNfWHynYPO5/y5gTh0ApDFBRLQXyYTpxG2bKARBKJXNc7lWr9CCqHz1ZdBAXi73hEIq8A/jiwB/KF2JAoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17EEB106F;
	Wed, 10 Jul 2024 09:10:10 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 022563F762;
	Wed, 10 Jul 2024 09:09:43 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings/perf: Add Arm NI-700 PMU
Date: Wed, 10 Jul 2024 17:09:33 +0100
Message-Id: <e60059b1f4683bd1863f08dd03482e5948c0afb1.1720625639.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1720625639.git.robin.murphy@arm.com>
References: <cover.1720625639.git.robin.murphy@arm.com>
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
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

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


