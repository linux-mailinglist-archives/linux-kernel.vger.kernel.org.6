Return-Path: <linux-kernel+bounces-403943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F899C3CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC0282DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118C7189BBF;
	Mon, 11 Nov 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmcGw1wK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AD18990D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323994; cv=none; b=I4z9OuUGSiB84e47Jyw2j5R0nLpr9kZ68xwTQeGSLCYZFfOk345SXtVDHpu3Rrsf6lcy0MwIWEhoLrfrvftAIjlVaA91yF2rd6COJBwSGhMJfQ18EPPbwVV1LEjPNQaKN7l7EAb1p9/skRgqarRM4SpFAwficLbtkRyC0knd58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323994; c=relaxed/simple;
	bh=yR0gR1vAjLhs0FBNDgPv2TANgg/seBwdhhtk/Rr/WUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejpV8vQD2tjnrW+ODC3TgTa+IgQzhNHPLX+7eBTcBPvKcLj1WBKRpileN9lHH3iOKQKvzKNI52GiNHIg8B0QWb7digH5jFSZy5oBKiWIUd9iJM1t82QjM+6qENfkNo+0K8EwgrtpNSGQAnKIDALMTEtby8wbhfAc5PyRxpeyWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmcGw1wK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a4031f69fso740641666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731323991; x=1731928791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMrSmta7fHOUctB/5AJidvIZnIncGO2UNey3bSwk2a4=;
        b=ZmcGw1wKE444veothWeskSeb2CjaP9Pnm9KR6cbdc4MNrG1i72aCIj4TLhnwX5aXO+
         s6zR05hCtBQOajgu9AV9S6jqEgIvnlgAfy5nrKBPib7phzCYMO729kNvMb2974Vfn5cO
         4GWYWe1x6OpAqw9REXdVLGkyMOImgXx3Tx47KFeecHoFGu2rEesBqlX5UEZTWq+SYHXM
         Zk7wZuCQzCxS/iwmryY8qIE/cZ+iJT+yyun3qRKEUJBCQouRF4OxTgwo0G0zFwMqxrJk
         oxfl9p+qP6zPtZKUnr8Zx9NpA7oo3TpoE3XnXJB6c4CAwTHn7+5KJbHNHMWx63q74v6A
         gAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323991; x=1731928791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMrSmta7fHOUctB/5AJidvIZnIncGO2UNey3bSwk2a4=;
        b=PeuyAB6cmXXF6cHFtOM91g2oS/UK9AwtmmA+wNT9F4bBugaevGHle00OxaIH0Zd9f4
         sUP/plF5VaMcIqsTKR/Sx5wUuesrFOYWXkvlmelPi3NI0KJT5qhmtVSuOxkayoMSQMvj
         70OBYRIETuMBS71u1co7FHGTpgpN6mUrTdemlqC9Zyz/NbatH4XYAVMnfLM15+Z8bFkp
         5+ouJsX4wMMBgGQ5K0oyHUvdc/mE5uc1tVY+cAALVgP/31uhPvI6nKUTxo63FgYsTw09
         arJcFgV3bFKUf7lLdVA/Jf/Fedl0MMi9X0i3nVHl37HMj0MeCHYvx87ERKWL3NyLpSE2
         U5vg==
X-Forwarded-Encrypted: i=1; AJvYcCVV3oguN13dhJ4FbQ9k/8lXG3II3vrzf6HmlxnQUzWrnxYcfPr9BDOUuxj1IRvG4f2JnQBNagfNg1nVVyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOveigmQJLoXAKhpjAy5UnPTRB+ZVNF/WI+RxqRcd5rcgbulR
	YUM7Pv5L14B+Ei4tlGoVMBSPml6CBYLtsICpFJ1Lte83BD2AhOHqzphYwowGeGc=
X-Google-Smtp-Source: AGHT+IHOXkjlkrDrtvlnPceOnN5si90LVUaiVILWy4AO1guCrPxVvXLDLxRd0s7RMfvfwDzqJwxOIw==
X-Received: by 2002:a17:907:3f13:b0:a9a:b9d:bd93 with SMTP id a640c23a62f3a-a9eefebd119mr1154918666b.4.1731323991120;
        Mon, 11 Nov 2024 03:19:51 -0800 (PST)
Received: from 1.. ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e922sm582530866b.193.2024.11.11.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:19:50 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peng.fan@oss.nxp.com,
	m.felsch@pengutronix.de
Cc: pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: mtd: jedec,spi-nor: add optional vcc-supply
Date: Mon, 11 Nov 2024 13:19:44 +0200
Message-Id: <20241111111946.9048-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=tudor.ambarus@linaro.org; h=from:subject; bh=/+Hab6B4EJ5Dh9SCHmRGYARDt8d1ozFiUUdntiL5/lk=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnMehSLAOWEq2QisQo/KwTNHCKeQe1lOWHd82ps 5T1iSUMhUKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZzHoUgAKCRBLVU9HpY0U 6RatCAC4xwOyECtAGIseOOgysDe7h7v7SgsjEr0sfn28ZspNaS/95AIqQMCfPSy2qy0reu67pKZ pCg8oRQQfb3u2HfTFOANgCtFAvUU7byNiliCO09Xw/vU9C9LdcuY8F6L/FvGyghiMvel2oXw9Ht jm506UJHfuIDMw1XINeUG68aULrEnhlGPJQfJIVn2XMCxiAq3u8l/3KN7r+bNbltYTHoiXnHXSA hKoSjlCj2GvfWO1ADnETrU7j9ckN4gikrHQvgxc2MSXGg6MDrI5p5PZJcsKjq+PjslQVcnEro6j sz+KTxRqSUMXxVLeIuVuiSw6EVHibHzUNsjqTuJGpAfOBm7O
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

Introduce optional vcc-supply property, SPI NOR flashes needs power supply
to work properly. The power supply maybe software controlable per board
design.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v4, v5: no changes

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..335f8204aa1e 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -96,6 +96,10 @@ properties:
       If "broken-flash-reset" is present then having this property does not
       make any difference.
 
+  vcc-supply:
+    description:
+      Supply for the SPI NOR power.
+
   spi-cpol: true
   spi-cpha: true
 
-- 
2.34.1


