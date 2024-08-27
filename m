Return-Path: <linux-kernel+bounces-303927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A6D961704
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FCE1C22F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063631D27BA;
	Tue, 27 Aug 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SuQKo+BS"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86484D34;
	Tue, 27 Aug 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783543; cv=none; b=kd1y+3HIx/Kw6DnB7NDt+FQD0IkIxhdn0kz43B7Ulmt1H8c1VAoHi7aus3MBjmt8yDKFv9mCR8/NuFyMyns39VlH3+wERpFQIpLND52gXByznYfZ6G0mTDTbEFq+oKnlLNv+d0VDjmxTIvabWO5eCaBf+qH4MACBlRQcEMdyS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783543; c=relaxed/simple;
	bh=1e7cJvrOimTp0/ijOBAcUos/8l8iChyToknCyUUuYrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXGynVfWHZhdLOY+35hl6HdTZTvzPIeoYHrV1gvZ/tkV71cqTPfOqGb6/XsbaHTo/1LREvgTTVEIVIHP4zOHLwonUjhpSAu4dZFW8kf2Y3ibA3AZBIgXZq8qTRQuTB7JLuVmkoiWUkoiG+gn03HHh8/G/4XYLIBFMlo6y9BIOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SuQKo+BS; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6A1B2C0042F6;
	Tue, 27 Aug 2024 11:24:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6A1B2C0042F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1724783094;
	bh=1e7cJvrOimTp0/ijOBAcUos/8l8iChyToknCyUUuYrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuQKo+BSGey1v+Xbvh6OgFnX6mlBrwyWAHjqHXm5GhfgxZOe2WD2SH3FgaJndvlgX
	 K5aPELc0DVKmksaNACC6Sdn4kK9mxTcR8K3e7ESlk868tnC7C/Q88U1l9/hkpiRfEr
	 +nySpvzEDvoWUGnmcCntbFca79CCsMMdMW/D+wEs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 07E7918045EB5C;
	Tue, 27 Aug 2024 11:24:54 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/2] dt-bindings: sram: Document reg-io-width property
Date: Tue, 27 Aug 2024 11:24:49 -0700
Message-Id: <20240827182450.3608307-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
References: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SRAMs need to be accessed with a specific access width, define
the 'reg-io-width' property specifying such access sizes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 0922d1f71ba8..7c1337e159f2 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -101,6 +101,12 @@ patternProperties:
           IO mem address range, relative to the SRAM range.
         maxItems: 1
 
+      reg-io-width:
+        description:
+          The size (in bytes) of the IO accesses that should be performed on the
+          SRAM.
+        enum: [1, 2, 4, 8]
+
       pool:
         description:
           Indicates that the particular reserved SRAM area is addressable
-- 
2.34.1


