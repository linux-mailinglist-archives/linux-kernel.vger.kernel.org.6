Return-Path: <linux-kernel+bounces-384866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953A89B2F98
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D2C1C22149
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3342F1DACB4;
	Mon, 28 Oct 2024 12:02:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35581DA0E0;
	Mon, 28 Oct 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116935; cv=none; b=K3jm1US3XxpaQPfOz0gE6QoYdLIMphjzrDrz/Z7oP8txuxJWBCjKrXfPTTrYbbBsnbBnFJRzZ0CxBZ2Xiwb5ifLn7ZZ/bhs92dGIFvjHtttUCwZ7DpnRp+2g8MtMUgajU2/Ofwtsjwqv6Q84XibPJYq7imiLIMJhVtTaTCwgNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116935; c=relaxed/simple;
	bh=H8xDAOMKrpAJvrKiMXiQPJzeOxCEpqKKUU2Hu9rg+zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLtJhfs1gPseph1YBeo1iGS73+Mu+W25V3JNvIiUZWyD/oV+9BsfUAkQPp5a7mUq11P1Q+5ae80ySzl7QSINo+3b/E7AJziJKxAKlG4lOSN5cgG4tndHwWey0hYiGAT5EjbwYuCULH2VG85L3V46ioRvlB6vy9alBvDp2gWJYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 137ED497;
	Mon, 28 Oct 2024 05:02:43 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 499FA3F73B;
	Mon, 28 Oct 2024 05:02:11 -0700 (PDT)
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
	"Rob Herring (Arm)" <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 3/7] dt-bindings: firmware: arm,scmi: Introduce more transport properties
Date: Mon, 28 Oct 2024 12:01:47 +0000
Message-ID: <20241028120151.1301177-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028120151.1301177-1-cristian.marussi@arm.com>
References: <20241028120151.1301177-1-cristian.marussi@arm.com>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
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
2.47.0


