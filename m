Return-Path: <linux-kernel+bounces-263153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D78693D1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2361E1F22B61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2A17A5A0;
	Fri, 26 Jul 2024 11:09:10 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36879179647;
	Fri, 26 Jul 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992149; cv=none; b=Oj0j4Vt2AJc9JUBtqXYP85R9aJDd9pL3QAX3P72YYaW5lyKlXPFN//38kUK0tqAOFCxTdAciAY5GeIF+mAyuYKQrrnA5bpSjwfEKvz++ARm4SYAvZoMOW5t+2cB7O9p4Ia0ONWULUCs2eao8tjgbxoObAatUD1iAnAn/G0ajJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992149; c=relaxed/simple;
	bh=TQsX3C2W8JdFOcT3lIXM42iCecHRznh1rHFfc3JmJPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+b/CoSuOUfRhEePTE+G4916KT3LOuBrd0rpEwX4WWKUxdFKXRL8FUX/r0Ou4q7noynKCoSI9fkW5o5hrcR8EEQpmV2THMm7uumea31IqazCQyVa+aWsqZFpjd9ri2sXVv05jTcezCz7IJkV+Pj/vN5ME8O1n/mk+4Ae40EAPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 26 Jul
 2024 19:03:59 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 26 Jul 2024 19:03:59 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700 SCU
Date: Fri, 26 Jul 2024 19:03:46 +0800
Message-ID: <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 86ee69c0f45b..3fc991e4514d 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -13,6 +13,7 @@ description:
 maintainers:
   - Joel Stanley <joel@jms.id.au>
   - Andrew Jeffery <andrew@aj.id.au>
+  - Kevin Chen <kevin_chen@aspeedtech.com>
 
 properties:
   compatible:
@@ -21,6 +22,7 @@ properties:
           - aspeed,ast2400-scu
           - aspeed,ast2500-scu
           - aspeed,ast2600-scu
+          - aspeed,ast2700-scu
       - const: syscon
       - const: simple-mfd
 
@@ -76,6 +78,7 @@ patternProperties:
               - aspeed,ast2400-silicon-id
               - aspeed,ast2500-silicon-id
               - aspeed,ast2600-silicon-id
+              - aspeed,ast2700-silicon-id
           - const: aspeed,silicon-id
 
       reg:
-- 
2.34.1


