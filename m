Return-Path: <linux-kernel+bounces-565421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3DA667D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BDA1897990
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D91A8F98;
	Tue, 18 Mar 2025 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="jaiW/mY1"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E245155A59;
	Tue, 18 Mar 2025 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269981; cv=none; b=HhEaZEtkWxLQcMRjY35c9+5KfM9EVUoD9NLYgfpDCWYWxYFWwDQn+YhQgg9e4nA0uhGEiVDDq+svKtH7r3gaI+PC/o+XjM9yTKgzqILG49vLGv9A7bLDWU52b0AQKMzpb09P5GC5fnqHcHfjwfUB8eMbGYWluFNgsV56FNLeILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269981; c=relaxed/simple;
	bh=+KEhWZC4oSV595m9mm0VBIcLW/F+09v7yRUFIi4A2WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkukUao3FtMOdHbbFTntGr00LUVznMgZ4saKxVbHyK7VN+QUUD6/cG/nGBdvYJzKi8Lp+jhRt4X96f8sP6fEYajDO6c4g3m+ubGARzD+EkNhUxPuZDWhZ2uZGaEnzY5Ux6OiGqgbtPDtz/Bh8x66CEo2ctTj+9W5e8/kCj6Tkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=jaiW/mY1; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742269975;
	bh=7b63ZqjxrsqlWgkA2RGF2zfuwmfY16pddr+rTHGxcuM=; l=1187;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jaiW/mY1DOVljOf+taB0so2r0YAHyuI/+KoiehNZSX2TBtJARZGgGeewxF263znSN
	 Smq7Wae1RF6+PHKbJCUgP0zpyq14NsHD1z28YjW8yLq/CoRsoPPM461rTFRStOQFjP
	 /UOoXkAl+xbtyOac4S5vPmwciPwdjEhOzWcr9ZMhw6Xunv2BLw/W00P/9xK47lO3pk
	 hdYvtqSbF6o8oQ+FsUvnWqW+DCMHhAJJbWlJiP3F//hyMt89UcI8P0zAFRr9OGfE/e
	 O88q2M/GNoaxlqZiiCnfQuI9zn822w5phBMTNUrnOwqrAwJrbY8iIhG8xQR2fEIU2c
	 2IpXHwJgu6enA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810299:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 18 Mar 2025 11:52:50 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 11:52:49 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 18 Mar 2025 11:52:49 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/1] regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as deprecated
Date: Tue, 18 Mar 2025 11:53:54 +0800
Message-ID: <8400088f3b68842ee63b6fa768fe2c545c473acf.1742269337.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1742269337.git.cy_huang@richtek.com>
References: <cover.1742269337.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Since the check for fixed LDO VOUT can be identified by the HW register,
mark the unnecessary property as deprecated.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

By Mark's comment, not to affect the old DT buggy, so mark this property as
deprecated. It's better than to directly remove it.
---
 .../devicetree/bindings/regulator/richtek,rtq2208.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 87accc6f13b8..022c1f197364 100644
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
@@ -77,6 +77,7 @@ properties:
 
         properties:
           richtek,fixed-microvolt:
+            deprecated: true
             description: |
               This property can be used to set a fixed operating voltage that lies outside
               the range of the regulator's adjustable mode.
-- 
2.34.1


