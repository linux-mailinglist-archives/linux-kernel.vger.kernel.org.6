Return-Path: <linux-kernel+bounces-373581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301A29A5911
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99A4B22278
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14C1CDFC2;
	Mon, 21 Oct 2024 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="dBnfnGvM"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53A1CDFA6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479715; cv=none; b=ZrB+t71O7i1duuZ/hFFJ7/jw+aAZ9LObCS7eD0sieBYDW7k+nHWULuBIDW4MQ9lfDNP/BN47EUTLtLKbRNykSwyefo3pxn316aJj7tyb1hGwSRHqpeaTSebLADoVK6UKjhcz82lkxcO7cS2IvFbmzDB38OICRe/estFYjoYERkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479715; c=relaxed/simple;
	bh=tG6YhzlTGIreNbErkabD4IDbbTrsSViWd67RLxSnw0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=vCW/gxDXceVHzyx//cR+fwGiZjjnGc3J0V/NW5rsLM9QFCfCMpse9Pd3leC62HyWf59MjDLidZ0mE9408ENCY6gZuJIvc9+ROAx1t6GAkqnfGu7ue+MccFycOKd2diVK1yl3mR10JxspIiFMQ6FxGybXKN3Ohg980aI647H6JMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=dBnfnGvM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e710c5d0dso92215b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729479712; x=1730084512; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEsUo4lrwpljoR0FPBQuFvw1WkkxvZeqCHqf7QaSpZM=;
        b=dBnfnGvMFDICqvAIMpN712YBS/GiIu3Ds4lABOjH2xbdsr2VE3N2dRb8gV3wNbNf2V
         7GiPbMmdSZe08vrwDOGIP/vpdICOVbuZc1aPYKSJtzX+SOvbMjBrqgJJaQ1U2DIqDCU4
         HsWjhvyYA0JcD4YrD5XFDNHX4l0Ogklmi2KkHzCzqraSP3lTMOahkauvr2IlG3RTfnik
         Mma8fkTi6CxJh4k0v9KTA+Cp/nS5lQ7ciaCHo5kCE+yP72eorAtwG8JAVnytu9wEN5qm
         S761gVPTYMqhQXAszISZErMQBWmDduXn36Sg/NYXRihOFcdgh4qCK+w4hbIXnlSqogAK
         lMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729479712; x=1730084512;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEsUo4lrwpljoR0FPBQuFvw1WkkxvZeqCHqf7QaSpZM=;
        b=xJQHTwnHOReH/jYMTPeVh+1wZ1Pg3rC6MaK4Nv5FC9HflScIely4pwKoOD1MUNDxZF
         YdXpVhCh58J6FEey4Y156QFlDClTEMyxIGpimgHNP9MXTyy8GZfaAhRto5UJhL2qfAoo
         P6l5Rr7WPqplARyLSiQGIISrJK12maC72UxQ/KOb2M573K/1pi6cXybILavCPmygV51d
         VsrqL9EK1nIeZ5nqFWkskiQ143BTIEAxgEPbMcyQu50K6+V8UXur/TFcziok/P5uvX3T
         aF/3VZ/Ff1Z2ZeSdP5xc4yapgFprOyo+AOD1PVv8IfORibYZ1a2XxMwYg/2dNop704v8
         1ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUZelouEOp/MN0XKzvgs0wXjHRiSi24oLNdgOIm4FucfUeGWxPJ/kesI24S31AaWRcaHGigOSgSAOZge34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSSSjoYeEkqQm6EbEyjRr+d7CrL/49WPSwYMlXrqiuI6AN2Mh
	P9wx59ssi5ThpdEaAKX0x2TpnGzFOKZlqXw+gNM/prXrIlU9r0AyRYmQRc7fPSc=
X-Google-Smtp-Source: AGHT+IGDe3DRRdpAyKVZRtaEWeATYT7/taYp+e9vwdg8Vef8+J128rMKxDPUIbFSJXh1jcZ7xUMuRQ==
X-Received: by 2002:aa7:88c2:0:b0:71e:4ec7:aece with SMTP id d2e1a72fcca58-71ea3267be7mr6165936b3a.7.1729479712451;
        Sun, 20 Oct 2024 20:01:52 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313fb5sm1815601b3a.7.2024.10.20.20.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 20:01:52 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: devicetree@vger.kernel.or,
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
	sean.wang@mediatek.com,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/4] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
Date: Mon, 21 Oct 2024 10:59:35 +0800
Message-Id: <20241021025938.676-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the MT8186 based Chinchou Chromebook, also known as the
ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..3efab59b8a73 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,34 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Chinchou (Asus Chromebook CZ1104CM2A/CZ1204CM2A)
+        items:
+          - const: google,chinchou-sku0
+          - const: google,chinchou-sku2
+          - const: google,chinchou-sku4
+          - const: google,chinchou-sku5
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou (Asus Chromebook CZ1104FM2A/CZ1204FM2A/CZ1104CM2A/CZ1204CM2A)
+        items:
+          - const: google,chinchou-sku1
+          - const: google,chinchou-sku17
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku20
+          - const: google,chinchou-sku22
+          - const: google,chinchou-sku23
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou360 (Asus Chromebook CZ1104FM2A/CZ1204FM2A Flip)
+        items:
+          - const: google,chinchou-sku16
+          - const: google,chinchou-sku18
+          - const: google,chinchou-sku19
+          - const: google,chinchou-sku21
+          - const: google,chinchou
+          - const: mediatek,mt8186
       - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
         items:
           - const: google,steelix-sku393219
-- 
2.17.1


