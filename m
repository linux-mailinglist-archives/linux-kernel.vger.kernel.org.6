Return-Path: <linux-kernel+bounces-285314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C07950BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0C3281B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B821A38E3;
	Tue, 13 Aug 2024 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YOabHKjs"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A01A2C1E;
	Tue, 13 Aug 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572478; cv=none; b=NIvR2J/c1pbLfZDIeJgdt6cN60NvP7vHKVsSk09BpV9cKWn3wiWP3GQV8SW++iPax4iqNvZNAUpXP37N5RV2s8qznMyV7H/zhI0raQ7enwsJrVkfTwSJLUy2+aPdKkB5X0iNdx9ffLielqDAVCqnGDwPlrZH+YAwW/iArXazSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572478; c=relaxed/simple;
	bh=9BIdf0YiiFMdtFV3lo9SS3avpdpx6tLGyTXuFzlePBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcqqFWZ57looGkN8dppS89ZzUyjaIiZykxg5UgMO9rb4Yy9oXTInVMFa3BlUMeuhXmXkO7l3B1F73snUPKFoTCMjk7eUW9OCFSbYoIujdrpYPJ3LIzfKkOM6mBDCVm5aF8TZTWpdBUfxb7XZUOyro9+gZqVxKr+P1O3VBpB87i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YOabHKjs; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 616FBC0005DD;
	Tue, 13 Aug 2024 11:07:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 616FBC0005DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723572469;
	bh=9BIdf0YiiFMdtFV3lo9SS3avpdpx6tLGyTXuFzlePBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOabHKjs4rpnUovqW7RNUmp7sXOYYK1hrVcBVqUvyt6C7E450j8Axfqi+rzOC9U0G
	 8LFYkf9OoNijkVbBXxIjzaM2v4gDRrTsUwapYzgTSckD9c1MPlBZ8CKXCVrnIFznyd
	 AdLCDNbsQq2UUQs3AxPJGdrYn2Be+7p9lbApZA4o=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8C17E18041CAC6;
	Tue, 13 Aug 2024 11:07:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 1/2] dt-bindings: sram: Document reg-io-width property
Date: Tue, 13 Aug 2024 11:07:46 -0700
Message-Id: <20240813180747.1439034-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
References: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
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
index 0922d1f71ba8..48257e1b5be9 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -101,6 +101,12 @@ patternProperties:
           IO mem address range, relative to the SRAM range.
         maxItems: 1
 
+      reg-io-width:
+        description:
+           The size (in bytes) of the IO accesses that should be performed on the
+           SRAM.
+        enum: [1, 2, 4, 8]
+
       pool:
         description:
           Indicates that the particular reserved SRAM area is addressable
-- 
2.34.1


