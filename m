Return-Path: <linux-kernel+bounces-371210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27849A3802
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2DF1F23DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57A18CBFC;
	Fri, 18 Oct 2024 08:07:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9E18C333;
	Fri, 18 Oct 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238820; cv=none; b=hI3sp7WouhlcgAUqcp5O1GktTdXE3qbBHzMes5zeQ7P2rcSXSCeoJy1mViwpLpDplAZR7osBWEHbM/hMS84Yf6pEI1ANJVW2mMgs0XSEYalzqLAPC0VvulKTwrvwyn7qnUEVEnK7l3o09fmGRZYfGl4jCTQzO/QfI3bfgUMc868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238820; c=relaxed/simple;
	bh=SPQJvb1e80OdNaSlCchtYD1D5qT8HpZVME6GtJqZZLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZgEc2irIqT0wkspbVzgGHP44P4p1xw9DEZAwNq42fCakhjK7tiPOQvRuP8FiNDDSkLL+ZvGVUvBRC9FYNDVakcXNdiFiHXSSxyJDPWtUKrBLw+MB+/QM75MmcqZD5uRVzS1CAmNnX492BFhAQKrjZSAmbIzIAQXc3Aa8qYNomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95A115DB;
	Fri, 18 Oct 2024 01:07:27 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8E8E3F528;
	Fri, 18 Oct 2024 01:06:55 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	dan.carpenter@linaro.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] dt-bindings: firmware: arm,scmi: Introduce more transport properties
Date: Fri, 18 Oct 2024 09:06:00 +0100
Message-ID: <20241018080602.3952869-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241018080602.3952869-1-cristian.marussi@arm.com>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on specific hardware and firmware design choices, it may be
possible for different platforms to end up having different requirements
regarding the same transport characteristics.

Introduce max-msg-size and max-msg properties to describe such platform
specific transport constraints, since they cannot be discovered otherwise.

Cc: devicetree@vger.kernel.org
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 54d7d11bfed4..42852ed887f2 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -131,6 +131,22 @@ properties:
       be a non-zero value if set.
     minimum: 1
 
+  max-msg-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional value, expressed in bytes, representing the maximum size
+      allowed for the payload of messages transmitted on this transport.
+      If set it is recommended to be greater or equal than the minimum size
+      required to support all the messages defined by the set of protocols
+      implemented on this platform.
+
+  max-msg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional value representing the maximum number of concurrent in-flight
+      messages allowed by this transport. If set, the value should be non-zero.
+    minimum: 1
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.46.1


