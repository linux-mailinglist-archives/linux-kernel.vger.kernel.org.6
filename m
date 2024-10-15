Return-Path: <linux-kernel+bounces-365771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED799E9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E58282DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B41EBFF7;
	Tue, 15 Oct 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Ap59tYzc"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030631EF0A8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995187; cv=none; b=hxjZP5dhVpcejFBQQsXO3WsgzvGjq91s8iLDWB/dggpNOQ2wX3mq2N+K6y5f50vkKSaSb4PERTw4yC9zTNhsalB9kF+4EcP83qO0DwPeuJ9Pn4YDZuV9XFx52YF967c5FRAfAoM9uiaU19vhsV8WgA0irpGhoSrtBIIPXHTkkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995187; c=relaxed/simple;
	bh=0AY2TC29X7yxtqWiOTsrhOYUMhzE71GiLaoDT0cA86M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AXAlOLFEYSQpt1eU2y76CeT0/2+gmBxM74Q07/ACyRFpF1SFOiAQwAdPIkFTQmrPWRmNvBUMUViLMUPZwtY7poKMVWdW7uH6gcem230gRCFz+CCc/EhmhipdzFQEkP0Cw9aJw3jjKEgzVlpLBlOgNh6pN2fqOBMm+8iw97sg3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Ap59tYzc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so940205a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1728995185; x=1729599985; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/XoNt4i5O7OlASnZwCet38LjSamye4aKCWat9uJ6wnA=;
        b=Ap59tYzcc1HGmkVriNqv5EDVoVaMxR59RWWC7NkuYnbX9cVjRGswK6TBIpxnmgP8NM
         QF6lt/zLdpdlHndzFBKtiBJDMFPVgaIbzn8AFT27HBn0vXwQPD23LctT/JYyPrMF0UfL
         /q//ZwdGWfp5+egAbrZX6i39eaUhcMOs0qR75dOgBIccjPzZy9NuNPt1xxTYSI7/5/nm
         bYYckNdLxml5Vw1zpWA8sjW9g/U8Sd4oDlb0K0qPmFK6Et1LDBS61mqA6uYKSkDmJ8/9
         qixjeA6JciV/tTrgmG/jKvN++J9bFESQk/+FvBwQcoXFdQFcCyhli1VnrQRInRO6Bnxh
         qVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995185; x=1729599985;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XoNt4i5O7OlASnZwCet38LjSamye4aKCWat9uJ6wnA=;
        b=AHQ75RyCV6UpOxOhzU94ZmVMCRo5Ag2qO+tLbWhsfPU31fUQcGNWgE3dLaV8Z1HQ2b
         UBHs34F8CbFNcOKbpCgSZT+eq/M+gzMCuWLdzYsUxRRphn7bi+AKOLZdEyVmhS3IfJvX
         fiX8GiDfjDjo+XyA09t7FCgi8F1L4itXSeW2dMMr82OHKevYwg+qsUveryHCtVNl3+aX
         NPQylA3hQTebrU6Ko98vUxdqhIp6VRIY+V0pM63eyb/E71NdKndz1B+nbN6EotIajy3C
         oC7YzuYYl4W+MuLRNZVeeSbXCrXHgqnggES3e7dN+GuRW/bgdgLZ6N2ZMD7wtONmNk8M
         tt+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdb8/9bzrT1ePsTdVRTHICpcyhe5ngrI7DvXSM16k0PlrjVDz/K4zaZicaRhyzexKlpEdW56jvqhutgVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjxAbLlvIsZ6PHiYZ01UBtcmx8rikOV2qblVsIgeelJrcQEOq
	TX9wTPz3cfzQCJjQ4DGVIuHP1RFaELxp4+P3D10p2/v9uYUrCytW4kM5Pf7LlzQ=
X-Google-Smtp-Source: AGHT+IFv7jUf52x1OapZhDKbF4Wm6PZ7vVJ7+vAWep9+WGnlVyBu3Fs9zTM29tVuAjlxWV3cuJMiLg==
X-Received: by 2002:a17:90b:295:b0:2d8:be3b:4785 with SMTP id 98e67ed59e1d1-2e2f0d92341mr7180386a91.6.1728995185323;
        Tue, 15 Oct 2024 05:26:25 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8cdc7sm1592844a91.10.2024.10.15.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:26:24 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	rafal@milecki.pl,
	macpaul.lin@mediatek.com,
	sean.wang@mediatek.com,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/3] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
Date: Tue, 15 Oct 2024 20:26:06 +0800
Message-Id: <20241015122608.24569-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241015122608.24569-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241015122608.24569-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the MT8186 based Chinchou Chromebook, also known as the
ASUS Chromebook CZ12 Flip (CZ1204F).

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..49188382f6c0 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,32 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Chinchou (ASUS Chromebook CZ12 Flip (CZ1204F))
+        items:
+          - const: google,chinchou-sku0
+          - const: google,chinchou-sku2
+          - const: google,chinchou-sku4
+          - const: google,chinchou-sku5
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou (ASUS Chromebook CZ12 Flip (CZ1204F))
+        items:
+          - const: google,chinchou-sku1
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku17
+          - const: google,chinchou-sku20
+          - const: google,chinchou-sku22
+          - const: google,chinchou-sku23
+          - const: mediatek,mt8186
+      - description: Google Chinchou (ASUS Chromebook CZ12 Flip (CZ1204F))
+        items:
+          - const: google,chinchou-sku16
+          - const: google,chinchou-sku18
+          - const: google,chinchou-sku19
+          - const: google,chinchou-sku21
+          - const: mediatek,mt8186
       - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
         items:
           - const: google,steelix-sku393219
-- 
2.17.1


