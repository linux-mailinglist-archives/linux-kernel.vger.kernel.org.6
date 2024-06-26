Return-Path: <linux-kernel+bounces-230479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7B917D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EB21C2258D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EB17E450;
	Wed, 26 Jun 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJnthlNW"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CF17D8B2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396620; cv=none; b=ogwzVZ3FzGrtBn9fJ+NJVdkfSQNP4fkDLXwB7xPGpMm2Am5kC5e3/POGH/u1t6UxUFxnMMPjCTsxdMW86iC0lz7Kc6ZFzqoziTkKPSeKnRD740odAu7Xg2aBimSB/zRljwlygOV7y7n8e+dAAVnBRPBIjvpZxvjFIPY767Zru/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396620; c=relaxed/simple;
	bh=lJ28Y3M24JoUrkT0kfRU9mVaVheUptQt841EFO3wEWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6qEvVswgXwgUpcxxLb5qsdNoruuvDq1oQC+A8oxmgnS2hv0FDUA1T8Ek5DyBMQZnJS8m3L+X7ZC/od/XHqEJEJNeNBP+ctMPB+nXbQrSrlm/Env9gjVDA6iASpDtFzUogQBN2Sq3Vqlonay/RbekT762+gAwe+XdVQ6o4scCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJnthlNW; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f3ca6869e8so40158239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719396618; x=1720001418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59XlO8N85CHKMZTE14dutfLqTOocIO6QaYNJIqLDR0E=;
        b=oJnthlNWd7xKEZIv5vv9PBCPJpCEjW0QJ8tzOQucNEHZTCq6mD7uXRmfWK6WkhxKEz
         lJanv1QGLYl8bpYvrz5klqyHTWQ7qgW7IFQm4aZoxEpF8ClPBenv047hnYOxODGfdk0E
         TY/PDVkNZM7huHvWlhKod3GAsZvUxIcA5E56A4jkJB0DpfXba5DRhu6Fe0yekHT6zw8+
         hxyr3h1hbUMg+P5Tx5pmVCUDU+9St54UAnUZuqNBHa7kK2aDimIGlbTk6UQaV50UCQKM
         rc82CRukdsVG6KOryNJcS5nMvGfxicepgKhmRBlm5Tuj/6uEKULCGR9IF95W3NOV+UoA
         0u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396618; x=1720001418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59XlO8N85CHKMZTE14dutfLqTOocIO6QaYNJIqLDR0E=;
        b=R8oyscCFzy8S7hu1cu3B7MbEnwyI5pcL5BCvuZuQsxrn4oVLsSERU98CmVerdziYeY
         euge+oDLpQ5+Kl7aI65bdAib3J6ZDIwef7a78dB1j5cD/eG5yubenkQnJ8GNWFd/nyEs
         SJ0AfdidA3clE0QlGP9eeI2+JM3OSStoNxDjIyP0muK0Z4shDdi10ux97KpFhIHmnbh6
         x5cHB9AzHzOPvrBN594QLJjaxiK17fClW/Ja7KaWnckZp/84cccp0x95h6qzN29LrE7F
         uiMQjD7V9au8UQwYAoByJd9Fxs/UqHwiM4bQYNpmWVIqiukcZuBMw/TLLWZm6nv9VkDY
         fVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPDxxdboLjIdeFsfSHAMLuKaIv9k6Ojq3YyQNrj/E79K+ptQ00v7SZNaChGiR+JelIcE/f/IGbBSlyq40r/o3jXAyoZIlJQCp5BKso
X-Gm-Message-State: AOJu0YxfO10eF6Cjdn5tqzncxtEyTLk9IgX8sHlIRQLhPvFyBs07F9Pl
	mneNI8FUNKzuJVwvz75Yr/tTZwn9ambk1ey1fQSx3xy4fHHgJt1hZdhaAmSJs1w=
X-Google-Smtp-Source: AGHT+IH5jBZh+2gfhC53GuIZJ8jCOVDi3reMK55I7AmQ0e+4wBYPfNvgxYCPjk0H5YJl3LjlcD09vQ==
X-Received: by 2002:a05:6602:1549:b0:7eb:776f:d970 with SMTP id ca18e2360f4ac-7f3a75d95e8mr1114379739f.14.1719396617514;
        Wed, 26 Jun 2024 03:10:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d121859csm3079108173.137.2024.06.26.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:10:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 26 Jun 2024 12:09:16 +0200
Subject: [PATCH v3 7/7] dt-bindings: mfd: syscon: Add APM poweroff mailbox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-dt-bindings-mfd-syscon-split-v3-7-3409903bb99b@linaro.org>
References: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
In-Reply-To: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lJ28Y3M24JoUrkT0kfRU9mVaVheUptQt841EFO3wEWg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme+jTtrYuM01hjhHqNdEtBumYFIQAj1hCW6QmI
 qkgn/4bVjuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnvo0wAKCRDBN2bmhouD
 13oED/4w11Sz6XcfEYcb7aCh448tvr/mT1uzJWylaAQ7h0adW5pLvYy6V8VNcH50TcOFSNz8pKb
 mP+/8qYde/sPaCx26zuPBwf9DyMvVP20grTsTmieBrx8cBd7TaJxf8ZNnl8XOzIcdrqmhaPU+Pv
 MKiUdtVS6Vnj1c8jAj33lufxbePDWl8Ec2kE6cgwtSAj5f9p6cEgfVqA9LnXMpT3VLwt8hluNJ3
 ji1uiFDP2y0D4g6B6arahRnZw+GbNbx8LnjhOs8MIx5OEHYjifdnUCmLL+vs8BQc8NmXNvFUR9a
 O+HUnsCoVL7GMidD69z8RjZ6whWaLHuAp39caMXOLCrE5lopNm5bW+QPpQA2RjVEPPV4waQvzvu
 pnnLbom9fpB8aHVH7zTTqw6AEKFK/uphsxA+9X9MkHAQrsIKPBlali7VxEMAxImoWa7ysFU3Js0
 AsqI8MYxIjz1O5N8PugktWFU6vpSaRy8BvLkt9xlcux2+ln3EQHLzhBysHYX2vejfxON9tZVp/f
 SRV3pAPTp0rNPsfS0McAkplHYhkuDsiQJpL61gURK6MI7mMJCWFVMz7Kcrvk6/DhOH75asCYxdv
 WV8AqbpzacSECz3Vvdf2gb3rIEabhrJZVkJnCko5Qbl0IGYl0XiqRk/i2h1ubOh86X4ofL9PB9C
 Jy0rzXiiGk3H+HQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add compatible for an already used syscon poweroff/mailbox block in APM.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index d4e9533cf3fe..70e3a4465b4f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -41,6 +41,8 @@ select:
           - amlogic,meson8b-analog-top
           - amlogic,meson8-pmu
           - amlogic,meson8b-pmu
+          - apm,merlin-poweroff-mailbox
+          - apm,mustang-poweroff-mailbox
           - apm,xgene-csw
           - apm,xgene-efuse
           - apm,xgene-mcb
@@ -133,6 +135,8 @@ properties:
           - amlogic,meson8b-analog-top
           - amlogic,meson8-pmu
           - amlogic,meson8b-pmu
+          - apm,merlin-poweroff-mailbox
+          - apm,mustang-poweroff-mailbox
           - apm,xgene-csw
           - apm,xgene-efuse
           - apm,xgene-mcb

-- 
2.43.0


