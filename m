Return-Path: <linux-kernel+bounces-566017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB01A67232
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA83189CE25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D795F207677;
	Tue, 18 Mar 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="0roQg/PX"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B07208983;
	Tue, 18 Mar 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295987; cv=none; b=foKn4yPcFdg/SQE86YqiYarVzr8sSgCRvPuT2wqJKbDSEID9Tcdapa0dkVApW5P328YaVlm/ODBz41ZmkStjPgZszfS+nvy+b/05MhbQbpa4gVUJytc+6h/b7YMFHF0C+H8eQizTPJjgwQ1orc9yWn8zzKwCNwVcuHoh2JKjgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295987; c=relaxed/simple;
	bh=F1UZ/YrYsDrTCQ+++m0TV0cHaltzKuXjWrjaPaaMaAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXZla0CO1g0otctX7+TgUn72/J2MWEcUW4y4/LySHj29QZIIsXZqOql7udYBfHLS04f6ArRW4E18OGaULZpUF0lUEgqNn/qn90Pbf/a+dt1bjpa1dOHtlTDgOKe2Q/r+dLhA/C62yQh+5XmaN903uF+x6k3VEwHL+/9LaBALXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=0roQg/PX; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742295976;
	bh=SsYDAqIJF4e1SGWlCE2lwHiwgRluaNsAMjvw4x5MuKI=; l=732;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=0roQg/PXrVxSYVlp5xft/20EbBZAsW/KLBbvCLHtnOEXJr+nrW2fZ1Ca7sNP3oNKP
	 xGZh5JIxOY2q4mR4GEA+uEDgVOaeKgUhZ4C02KlQej6TdvIwheZDPO/YOI3e/ZhTtT
	 qklYfplg/CTChmlAOuc6aSJATk1z+bfqWHnNKVpU07rmvDOT6IbQIHqgLm3lgisc+C
	 nIxDBczCX+Vpa6QLCuMYLNb/NaJ2tDe3JwyM144lKBKj67uCqLORijMYew9prVp5PX
	 Uws1CHNmnZ4y+PDPB9O6QoYZfMbhh7l3HrybRgAsIovmboMFf49sSwurCn+k5PVQHQ
	 J+OjcLL7gHM4Q==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810278:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 18 Mar 2025 19:06:01 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 19:06:00 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 18 Mar 2025 19:06:00 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, Rob Herring <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/2] regulator: dt-bindings: rtq2208: Cleanup whitespace
Date: Tue, 18 Mar 2025 19:07:05 +0800
Message-ID: <9faa2e3aaa0fca0e66e478df4f59c6ec4bfc8def.1742295647.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1742295647.git.cy_huang@richtek.com>
References: <cover.1742295647.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Remove the whitespace that checkpatch scaned.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/regulator/richtek,rtq2208.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index a584ce54012c..022c1f197364 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -39,7 +39,7 @@ properties:
 
   interrupts:
     maxItems: 1
-    
+
   richtek,mtp-sel-high:
     type: boolean
     description:
-- 
2.34.1


