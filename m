Return-Path: <linux-kernel+bounces-315661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9696C582
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A63D1C21E49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A701E1A09;
	Wed,  4 Sep 2024 17:34:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052315EE8D;
	Wed,  4 Sep 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471297; cv=none; b=C1wNn0o1pHEijDP7Aa6hoefpdaCGg+uXszrmHLo7rmLMzSSHcuMqfPDMMbrSZfVvGbaNxlGYdEen28m3EkAsmqEjoi8Od3S5sbKIpRWmH/20pAEBiRjyxC/MZhObvaVA6hZCUUgKpnAE1/ETam+8L/hyfp0CkmhijLCX8dcf11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471297; c=relaxed/simple;
	bh=RRXS+CMRVgV4wZdJhHA5ZS1hpb8sGKAALcTPRxdsah8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDM4iKGR8LsdYKg2LVe+XnIZG6hJhkWUakUgKrGfnWKwKlbmkn2xBWOI1SCBOn1DHe0Lxkov8IaiBS4kvGEaTmy3964jzxhvkPNNUixVPKWx3DBmT974+Xq6LGAAQEETwlyxCRLLmOiiTpZApWmADZrTlJGyAwlBsfURCQ+vh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87DC0FEC;
	Wed,  4 Sep 2024 10:35:20 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2762E3F73B;
	Wed,  4 Sep 2024 10:34:53 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings/perf: Add Arm NI-700 PMU
Date: Wed,  4 Sep 2024 18:34:02 +0100
Message-Id: <5f86237580219116de37e5e54d8b7eb0c9ed580d.1725470837.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725470837.git.robin.murphy@arm.com>
References: <cover.1725470837.git.robin.murphy@arm.com>
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

v4: No change

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


