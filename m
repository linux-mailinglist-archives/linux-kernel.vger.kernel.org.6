Return-Path: <linux-kernel+bounces-290411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8E955376
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E774AB21B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC01465B4;
	Fri, 16 Aug 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CBMqO63a"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88DBA33;
	Fri, 16 Aug 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848153; cv=none; b=DIZ6Lc8xbG6y0FeP+XfvhJy3TmI/HIq/g2sISQjrVRUKgaUQtIij7fqr0sg6LMMAv7NqKM5xSY8c5FYpBGxW5LawggW1qgIIbrBc2r9wHxXbDCLJcmUWbV+olNd/YVh8MdNVuU3OSdYV4ntrlj02qFFdG4oQM0+IV30aUdA+G/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848153; c=relaxed/simple;
	bh=1e7cJvrOimTp0/ijOBAcUos/8l8iChyToknCyUUuYrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqKrgtEXFRsX05zw19r5lCFJhx3+jC+g8aDn8ctJExCraKiyEu7e4IgDadxky6nhhTTF8UIWCIzQkLEBRnaccPjTvpPpKzn+Me6xT74YpEa4uRkaPG0Vbz2ob1DvhL3oIni3lrV2gufHrh3D8sQwgxaL0ZLue96IY06vUCx1EDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CBMqO63a; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A0B83C005D63;
	Fri, 16 Aug 2024 15:42:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A0B83C005D63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723848143;
	bh=1e7cJvrOimTp0/ijOBAcUos/8l8iChyToknCyUUuYrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBMqO63agbtmUyhfhnWxONZEB+N0gbtuxnOhjpwKsJG328j3aJGINeYolp2Jy7bxf
	 poAaUv6pbvG+cwCL8U3kF3l4hDtSzzO+L3Jv+xfUrZcO6cUrzSsXbwxMhUeHZ5J74E
	 kFEZSfVSxzxXA48RPFAfBWTtp0Mz8aPjVAuhdw70=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id CD5FE18041CAD5;
	Fri, 16 Aug 2024 15:42:20 -0700 (PDT)
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
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v3 1/2] dt-bindings: sram: Document reg-io-width property
Date: Fri, 16 Aug 2024 15:42:20 -0700
Message-Id: <20240816224221.3256455-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
References: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
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


