Return-Path: <linux-kernel+bounces-555593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CDA5B9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBBD171961
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1422D7B3;
	Tue, 11 Mar 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="Jiw4x75G"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E2225760;
	Tue, 11 Mar 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678549; cv=none; b=mYolTNvY0VCZDrcPW5c3lOBnhkw8qowk+640Ku84sOZBjZF6nhQXUhmGGNqAJbgYc7bDSyLqZDfMJIPeZXTrY7NeXJ6TCJKybvs0BArdHAl7l8brrnek8HNqMvcpzEDBqQ9hmfyIpxEPtRC2/XziSgdLgzsDi2pPBeki6k18FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678549; c=relaxed/simple;
	bh=HI9Jx3eMM5SpoCOoPSVqpDRMyDdMck9kj9YOu3HUkkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUSOT9whZ8cdMGiK+Bs4GOPX0TF9kDfOhloTO/d6iw6kPa9WV4NEstuP4SmwhJmLmhjLXTCqwoP5z6IZ2Pi2IPtGqeCgrcOdZlYkKUPv1/bMOEbwYo1fCcbycU3uBkkr4xdhndeA+mKaZ4RFzl174w4vEasEr8Clgq5cRwsSLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=Jiw4x75G; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=1120; q=dns/txt;
  s=NAESA-Selector1; t=1741678547; x=1773214547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HI9Jx3eMM5SpoCOoPSVqpDRMyDdMck9kj9YOu3HUkkE=;
  b=Jiw4x75GYIYmFSC7ykdE4yATE70xcKqZ/YruPJWhe8CXEVcfmvjvolpB
   z0/CQY/LmYwjWzLkCQy2OMwu8cJ+DOHMPvXxtEII7LC+KQd75Ok3QwwrA
   vkHHxhAIFjWspOnNnP722cjWON69DMAm0cRbRGa5GGzn3OthxFixqvGFm
   eHzCAygzaxbwCiJBhxEsnyN3AWDg6AQ4uVujkedKyBYWJEfmXc/UcG6L/
   UQws4nKZtoKwl6qHAc0v43UqOUaSWyAzYHx3co++LE025FG1ZjpkevgFD
   VFcuohEZAWZa+Lh2RzwCV4ji2cwz+KJyHHImN8nOh0HKvWq4TXY2+S09d
   Q==;
X-CSE-ConnectionGUID: tSltUKJiSWKJr4cq6QEHSw==
X-CSE-MsgGUID: lth/x7ByR6OA93qN/zXVBg==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386378"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:37 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:32 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] dt-bindings: vendor-prefixes: add eswin
Date: Tue, 11 Mar 2025 13:04:25 +0530
Message-Id: <20250311073432.4068512-4-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:32.0805 (UTC) FILETIME=[0816C950:01DB9258]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add new vendor string to dt bindings.
This new vendor string is used by
- ESWIN EIC770X SoC
- HiFive Premier P550 board which uses EIC7700 SoC.

Link: https://www.eswin.com/en/
Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..07ff140e67dc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -490,6 +490,8 @@ patternProperties:
     description: Espressif Systems Co. Ltd.
   "^est,.*":
     description: ESTeem Wireless Modems
+  "^eswin,.*":
+    description: Beijing ESWIN Technology Group Co. Ltd.
   "^ettus,.*":
     description: NI Ettus Research
   "^eukrea,.*":
-- 
2.25.1


