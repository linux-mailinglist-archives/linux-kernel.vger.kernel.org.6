Return-Path: <linux-kernel+bounces-239618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B392631D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8490228C9B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B15F1822D8;
	Wed,  3 Jul 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G5Pr7DVY"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521617B50E;
	Wed,  3 Jul 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015869; cv=none; b=U18K797bEbdDSSLjdBMR1dDyWYR3euauskXC+/IShW6USBu+5JzvMJN/ubLu+uOG99dDMChdnkgjkTpSX16wg44kCLq99dKfQIUW6m90f+HoQNjZNpqpEYSUeQAkwbnI4YNquXrxOQeYgVtEsQEhJW5vpyMzbKt89zJfKyzyqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015869; c=relaxed/simple;
	bh=4TBs1HYdxNJuW0Zql1GbvVoJVx4d9v9lP7I/XqjzvQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TS9Wjb/E2xutqL5HsRfgsR1qvW38tu7hL2ixvUaBUe/ftchsvEjADs91UoRGn2YMYiOIjZX5kEzXf/ppJIe2aQ+K6Uuf1IWSm01y6aJ9olQHDIcp84Ak/1qcfuoGMghZ9X9Fg+1okts/Sw84dMKE+GGracsUrEM7OreHFu5DF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G5Pr7DVY; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6B2DBC6D1A;
	Wed,  3 Jul 2024 13:46:14 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8FDA24000A;
	Wed,  3 Jul 2024 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720014372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2PU9k3tCN4PaXJMVba3eK06E41fBInVkusLse/OBtI=;
	b=G5Pr7DVYmFHYMr9KujeYQuxjGCHa8bwDURGwDZlvr7m24M9OFxoQYyT5FK0XO7dREvTj7/
	rvgqUfsne8HzUgLbQc+xJOrO7E4XllUpIrj2qoezMsjqSUkyEgc5fsvbbuGoM44DAbP1fN
	mTASflfmnmVsZ2HHP/xGOSodJTrWtEpuMlwBgx7ICfw2LjPu0MLaK7I3wEnPVgtC9gP/S1
	kg2atphTSuC6MVGPhzR1tEk+wZQh9qbTRXhQ2GRmMu/ValsT09ju4VriZNn8LXg0u1O1PM
	LkM/01Th3Vr2RIAFwzi9qEjSUiZfriU7cH+ZMrHEy6QXVyzem1Gej5kEIAALZw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 03 Jul 2024 15:46:05 +0200
Subject: [PATCH v2 1/4] Revert "dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240703-mbly-clk-v2-1-fe8c6199a579@bootlin.com>
References: <20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com>
In-Reply-To: <20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev-13183
X-GND-Sasl: theo.lebrun@bootlin.com

Switch from one sub-node per functionality in the system-controller to a
single node representing the entire OLB instance. This is the
recommended approach for controllers handling many different
functionalities; it is a single controller and should be represented by
a single devicetree node.

The clock bindings is removed and all properties will be described by:
soc/mobileye/mobileye,eyeq5-olb.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 51 ----------------------
 1 file changed, 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
deleted file mode 100644
index 2d4f2cde1e58..000000000000
--- a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
+++ /dev/null
@@ -1,51 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mobileye EyeQ5 clock controller
-
-description:
-  The EyeQ5 clock controller handles 10 read-only PLLs derived from the main
-  crystal clock. It also exposes one divider clock, a child of one of the PLLs.
-  Its registers live in a shared region called OLB.
-
-maintainers:
-  - Grégory Clement <gregory.clement@bootlin.com>
-  - Théo Lebrun <theo.lebrun@bootlin.com>
-  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
-
-properties:
-  compatible:
-    const: mobileye,eyeq5-clk
-
-  reg:
-    maxItems: 2
-
-  reg-names:
-    items:
-      - const: plls
-      - const: ospi
-
-  "#clock-cells":
-    const: 1
-
-  clocks:
-    maxItems: 1
-    description:
-      Input parent clock to all PLLs. Expected to be the main crystal.
-
-  clock-names:
-    items:
-      - const: ref
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - "#clock-cells"
-  - clocks
-  - clock-names
-
-additionalProperties: false

-- 
2.45.2


