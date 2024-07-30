Return-Path: <linux-kernel+bounces-267724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0249414C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4BEB24815
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE91A3BA6;
	Tue, 30 Jul 2024 14:48:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB11A2C1D;
	Tue, 30 Jul 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350888; cv=none; b=EhzyEWe3q9qkbFCyXLt8L5i3Pv0WoCrhehzjWOwe43/ImLfPfej1xc3l9M02cyoCA0C9JU8KbepRUYOyYamg7ohov6Sk9NH2OJtFsOOCg12kD+jzoeHtSYpkGy2KGPjnUMkQ7L3rdfR+61oBz+GGiyqCzmgP3+7DQa/4Yl4gVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350888; c=relaxed/simple;
	bh=YhATQi0Nq1bF8X1z89kQr3gf7o9r391kgyrhAZEwTJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nst/2Xy0/l1YaDsEki9cBKKKXyP2pLPR+LbZAnY7qszeqnLvlAQWYTuw4+xIj9eqa9zSGAIrKD8ngChmWlb+r0uFwDn5YAjuprEQtTaMxl1LhN00lHeSf4FELON1wIbY14irjkZQ4zFNt2DQmy//oOxLEHuRQREF/VbwVjCVgcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7BD106F;
	Tue, 30 Jul 2024 07:48:31 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0783F766;
	Tue, 30 Jul 2024 07:48:03 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org
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
	souvik.chakravarty@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v1 4/6] dt-bindings: firmware: arm,scmi: Introduce more transport properties
Date: Tue, 30 Jul 2024 15:47:05 +0100
Message-ID: <20240730144707.1647025-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on hardware and firmware design choices different platforms can
end-up having different requirements around transport features.

Introduce max-msg-size and max-msg properties to describe platform specific
transport constraints.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 7c9fa07e2ff2..998fde321d82 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -128,6 +128,21 @@ properties:
       be a non-zero value if set.
     minimum: 1
 
+  max-msg-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional value, expressed in bytes, representing the transport maximum
+      message size. The value should at least allow for the 4-bytes SCMI message
+      header to be transmitted if set.
+    minimum: 4
+
+  max-msg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional value representing the transport maximum number of concurrent
+      in-flight messages. The value should be a non-zero value if set.
+    minimum: 1
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.45.2


