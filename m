Return-Path: <linux-kernel+bounces-374819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D3A9A70A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5A6282457
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D91F7082;
	Mon, 21 Oct 2024 17:08:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A241F1310;
	Mon, 21 Oct 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530482; cv=none; b=jMV3gGKSPt5VyA73pHOLKA79PpsyrhtFOeGJwJ/JRYnzGSZ84B0XLEHFWn0cL29CBv1m4yQqamB4UiX63KlhD2zYyxHRiIagzyMo/eYRSgFtl6KB/w9Ty53833Stf3GhVuIScKMFNSZeZcPQvARY9mJ6F9bNxE+vGJgENolUeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530482; c=relaxed/simple;
	bh=9dKyPExNoPyiGpPH+0pxIHNd+YLjiotVIJaYoDAhCCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2JqnZDE871fiKEFc5DvjVWCRMXx3gzQtIl7a0UYXqe69FCMNVxd91Vla9Dm+1bDHKJUm5Ma4+dWmWdIIGt5ZfFJ4WaP6losYjoRyUpEWe9tST3NKmgpcGNZpU/paunqEq58Y2gGOMZ/oKdLh0v8FDMtXrNPUfFP9ezgVE5IwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69076DA7;
	Mon, 21 Oct 2024 10:08:29 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519933F528;
	Mon, 21 Oct 2024 10:07:57 -0700 (PDT)
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
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: firmware: arm,scmi: Introduce more transport properties
Date: Mon, 21 Oct 2024 18:07:24 +0100
Message-ID: <20241021170726.2564329-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021170726.2564329-1-cristian.marussi@arm.com>
References: <20241021170726.2564329-1-cristian.marussi@arm.com>
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

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
v1 --> v2
- added vendor prefix
- dropped warnings about resonable minimum max-msg-size
- clarified the intended usage of max-msg
- fixed Cc to include all maintainers and using correct e-mails
---
 .../devicetree/bindings/firmware/arm,scmi.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 54d7d11bfed4..9d6e1147f9e9 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -131,6 +131,21 @@ properties:
       be a non-zero value if set.
     minimum: 1
 
+  arm,max-msg-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional value, expressed in bytes, representing the maximum size
+      allowed for the payload of messages transmitted on this transport.
+
+  arm,max-msg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      An optional value representing the maximum number of concurrent in-flight
+      messages allowed by this transport; this number represents the maximum
+      number of concurrently outstanding messages that the server can handle on
+      this platform. If set, the value should be non-zero.
+    minimum: 1
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.46.1


