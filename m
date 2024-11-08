Return-Path: <linux-kernel+bounces-401791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FAF9C1F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAC81F2408F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B21F4703;
	Fri,  8 Nov 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zKVJlqnB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18E1E3DF5;
	Fri,  8 Nov 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076200; cv=none; b=IM654ntGYVC6sy4Sj2G3HBGpPLYbV3gATvn+KEqB1W6HZHFmrR5EtMJA+OU87N0cgpZdUrP7bb3Ndh9DHNWf5laoi1AaIEiqR0QF6Gspe2uqjt0UUnVnYTA1JzsP/RZgiyfijSgzuFvte3lzqhaYYdad2R/mu3+0wB8KI7M6ZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076200; c=relaxed/simple;
	bh=LYWXoodtFkgBf2feD1iUNVjzHesxz/RMiHTByWuJu/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiI2anQp2VX4z8Gfn2IyipwEiaBDmyA1GseeD4TzBSq4VoktlP678D6+F5qLXqVvH6L99HYMYCmeWooffezng0Ar2vWHw98bQZPtLZxNf/xS5XPUNi9WttFMeorxRF9olm4JQ4hBIlQfC63cVQy4kMxF+xqBVVOvVzenGZWfdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zKVJlqnB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A8ETp39086500;
	Fri, 8 Nov 2024 08:29:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731076191;
	bh=Gl8mKD3rLXgTWdw6OlZfKmkOf1hXAJ/ECQW4f5tY5vU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zKVJlqnB6PAp7qJYu3p3T++qpnDzU9MMlPKbRWb9JBiBLnqPIM2+l2DPbRk/aV9QH
	 4r6ribctNgzDF82fTBcYVi26UPSWXPtBeQhuY8Gn5bAiAlaZ2+1GI2BeC/bdpjS5rH
	 07jBnrmZoYgnWWI7zvF8KYJAHjenNNZ2T9gpV3Eg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A8ETpNi104243
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 08:29:51 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Nov 2024 08:29:51 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Nov 2024 08:29:51 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A8ETpEE040961;
	Fri, 8 Nov 2024 08:29:51 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A8EToLk032068;
	Fri, 8 Nov 2024 08:29:50 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <danishanwar@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
Date: Fri, 8 Nov 2024 19:59:45 +0530
Message-ID: <20241108142946.2286098-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108142946.2286098-1-danishanwar@ti.com>
References: <20241108142946.2286098-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add clocks, assigned-clocks and assigned-clock-parents for ICSSG

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 3cb1471cc6b6..12350409d154 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -92,6 +92,11 @@ properties:
     description: |
       This property is as per sci-pm-domain.txt.
 
+  clocks:
+    items:
+      - description: ICSSG_CORE Clock
+      - description: ICSSG_ICLK Clock
+
 patternProperties:
 
   memories@[a-f0-9]+$:
-- 
2.34.1


