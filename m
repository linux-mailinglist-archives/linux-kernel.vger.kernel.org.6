Return-Path: <linux-kernel+bounces-445165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F217D9F123F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91C2162A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046A1E47A8;
	Fri, 13 Dec 2024 16:32:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D16357C9F;
	Fri, 13 Dec 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107550; cv=none; b=sR3WMABhHCwVABGgvgXHC6Qpc0zizR0U3nEXanEVMTj4wYQ84WEu17t5CVx/tqtXKx2KEb+MBq7a5saE15ZTm85aJJ9hcBaw3G3b/oVqJIfdQ1jyJRARtytcJCQ8+W/JricTt8SbBMCRk3OIfGblX67fvrTjPqEsyg67M0xCq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107550; c=relaxed/simple;
	bh=WbsNP70aNF5f1pxp/R9IZQ5P8ZpM4ExN4gGdyhavBmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTMtSZ9GasS6WROalf45xdZ0PhGDMzbKZfJDpNhdEqpLInb+3pbiX3ZLcHRTE7D+hgtRnofS3kCv9sMffmj4l42gXrfd9ipxj8Xxtr7WSA4CI/ku4kjDsMh3wjaJTji9kLrSsZ11ucFoYAM1dmYPjEtuw6+oYmIxC/GjNSI45oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70E0169C;
	Fri, 13 Dec 2024 08:32:56 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96AE13F5A1;
	Fri, 13 Dec 2024 08:32:27 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/8] dt-bindings: mailbox: arm,mhu: Add missing properties
Date: Fri, 13 Dec 2024 16:32:15 +0000
Message-ID: <20241213163221.3626261-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
References: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for "interrupt-names" and "mbox-name" optional properties.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
index d9a4f4a02d7c..65a4f66a7273 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -63,6 +63,16 @@ properties:
       - description: high-priority non-secure
       - description: Secure
 
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: mhu-lpri-rx
+      - const: mhu-hpri-rx
+      - const: mhu-si-rx
+
+  mbox-name:
+    maxItems: 1
+
   clocks:
     maxItems: 1
 
-- 
2.43.0


