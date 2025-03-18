Return-Path: <linux-kernel+bounces-566018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB5A67233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C7419A2D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E8209F38;
	Tue, 18 Mar 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="bWmatuh9"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C50207E04;
	Tue, 18 Mar 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295988; cv=none; b=WrEy9hUfKyBvlUV4Bjp73MhY40zHRzrKjKnYnkva5BaQP4ydYEgRuH5QdU4V8TjHguNmiFLF/AD075Ls2YV7K7SDQ/6PHumrFyr282WsvfZ6SrGy9OTRd1hm9bsFGZ+fmBy4w3yg/FPTEwOVmo2+gHoEMRbMF/3VQ3qUxEjPF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295988; c=relaxed/simple;
	bh=p/wJM++rnKbyJ+KDss0HSFDyytOb+7G1yX3wp186xpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc7rRjjKqOK4f8crD99IbZVKXHQp16ZUZQt39oTdc1sY23DyMyDW6q9hSfHk3VuL4EGgW5RSMqnzcMHJExmQUpo/S3UwVEuLZHzNhv6tWZBUGsiB1S1yjkpMqg8nMAKkQKkPUWZFKUvkeG0zM8JQ0QycsklaQGtV7AiJlkYO1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=bWmatuh9; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742295977;
	bh=fti+MM4y+TkOKnBHk3Iw4mnkGS3G5TYk9xWiMm0o71Q=; l=1084;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bWmatuh9ISg+h2tpf07OBuk6rN1c7HDc0kp+s7QimYkPEwUEL20lzCRqQHUD8VAbG
	 dhORncGqYyX3+lcoCwGjjrGal7TFv6nELBvql8vYVvGYYd9yWCt+mOMpaydTUzgBSM
	 82YwHFc3NBL+IuVnC3DKX89PNF9q1Y5YoRHWSU94lQEGjBbTA4gLdM8kfcK1ScBb5m
	 BE+p0ncJXUfHM71MH45HXqsl6xlzF2kbOjXJNpmfIPY9QPwdoJ2XxsJs4AumHbjBr7
	 L4p+AfnRNEV3v+oeEb5hkyvXAvlhEQaWB6v6toIGxwHKu1QkNzrBPV844Ovl6znkVS
	 vOSU3zqbh0S5w==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810298:0:AUTH_RELAY)
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
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as deprecated
Date: Tue, 18 Mar 2025 19:07:04 +0800
Message-ID: <f813c7b49c152193f24198c4baf2c3f04cb0a74d.1742295647.git.cy_huang@richtek.com>
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

Since the check for fixed LDO VOUT can be identified by the HW register,
mark the unnecessary property as deprecated.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
V3
- Separate trailing white removal into another commit

v2
- Mark the property as deprecated
---
 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 87accc6f13b8..a584ce54012c 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -77,6 +77,7 @@ properties:
 
         properties:
           richtek,fixed-microvolt:
+            deprecated: true
             description: |
               This property can be used to set a fixed operating voltage that lies outside
               the range of the regulator's adjustable mode.
-- 
2.34.1


