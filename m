Return-Path: <linux-kernel+bounces-187506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACC8CD2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4752849DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73014E2EF;
	Thu, 23 May 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AI1t66AU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99C14D28C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468577; cv=none; b=Hz42zeRF5WCnEXaC6yr82Waqjym+uSPRx4KXFod6r2zBocCArcJbPSYLS+KwZL5noZYco1wHp7RlOanZ0hWxlEoeIjdvzLV9088RYB2l9m6bKznPy8HNDBMCdtT46k6BDGjs3lHXW2tk7nHq5QZbVtLWXcCoI5MV2QrRqef4fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468577; c=relaxed/simple;
	bh=0cnQOz/tz7Pics990q/oyQxmXh06ChAnldS7fhkLwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZr/ZE6oq2UaHMgFusnKsF7Gpfw2W9X6lw0Fh9KX4pIQ7hsupNskajK6XXNvG2WVqXvo7IeaxXU+jtW2ffPXBn+rKTeczdi5ssdzHl983FUoj7jCNzX5SiuRpEZShGQ3j9/L6lSVkvDkktbYKidwT7MEhyEP5cbnQxsUQS7T7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AI1t66AU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354be94c874so1501599f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468574; x=1717073374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xenplDX50PgsFz2Mhp85GrWLaCXcLNdChHM7TGUmR30=;
        b=AI1t66AU+BZchrd/EqsT4JVBS0iCUeiSmcy7OOhd2oFsZ0WHF6hoXpnVw7RCdjcJg+
         QsxuhfcW29+VI4iEb9BxdMOJIkEUgZwzcU5s3TvPV6tjKTlTmR3zrxucO0PqIN+SeOPg
         MY1MXEvGY3cX2G25JrIARZDNIxIcFmZ+sWeZmIBUeh3nB6/ZC7z5Oy6gZsoOwErDi6qe
         /njZjGRv8zV4DlAlNQwb7PwVZowsZUMHsSgU8SJ/z30HxzXKWg520ao4nObkbUySZISh
         fp6pPGNvm9JRcjmNrnsil/X+k5ecZo5ZAN+S7hTsWPRFXd/dPx6gAh8DljR/li4w3G0h
         pyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468574; x=1717073374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xenplDX50PgsFz2Mhp85GrWLaCXcLNdChHM7TGUmR30=;
        b=rOWTEV720UCU65nWoEu1sxoN/1WxOOZGaduySQWao+YsqB5p+6XWlRqdyMzNtXmNZ+
         /6tzVx58tqJy4XTawFh+KPRbjwiDN9IAtjeoAwzR9zf8rwr39i1mLor7bL57TvGyQCc9
         mCgReVqqvxci+918K4Mdwg4No4jMzZ+hqDtusrIjIpVqvagQ3pmTaqfKnP2an4laYOns
         8iTPIRb9BiHVinoQhPuteo3VrsV0EYJ6ZkpCcyDAGHVIZPbX4+1Uds+oCxQu5f9W9ojA
         HTplL4Vfxunoe7uCRujl5TowZx3WU4+aBbNuVtkMLlCYuuJgsKMcNaEWTRD60bldH0yS
         7LQA==
X-Forwarded-Encrypted: i=1; AJvYcCVMtc7Tmkhga6wSpbUYJagXA8TaMhpWOc2YJWwKKjhy1HkirE4rB4N80EROuYOHSDTWOUcaJWkpb1qVYj4CTtoMhCp/stZr3zbnTOQ2
X-Gm-Message-State: AOJu0Yy1FMhYFtXszfbi5Y1pJ6rGTZHw9g4BjnakFDcJSIRLm99i4Bxj
	Jw6k6Mi8IpX9nGCH7z48vyYvTIKQFAtdkUWRXBnYF6IVtZmzjKZrg9/h+vSzxl0=
X-Google-Smtp-Source: AGHT+IHKcCo5SkmMzoymqkjybudh+EkK1WbZuK5jxJV/cF01Mbd4x198B5LKwj085upJo1QzzuY8WQ==
X-Received: by 2002:adf:f192:0:b0:355:21f:be25 with SMTP id ffacd0b85a97d-355021fc4ecmr507776f8f.7.1716468574168;
        Thu, 23 May 2024 05:49:34 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:33 -0700 (PDT)
From: amergnat@baylibre.com
Date: Thu, 23 May 2024 14:49:19 +0200
Subject: [PATCH v4 06/15] dt-bindings: display: mediatek: dpi: add
 power-domains property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-6-ed82eb168fb1@baylibre.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Fabien Parent <fparent@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=XahM8CveSVHt1oE74u7zHenJKYAxVWcUJtTL9lMvR8E=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTZLC6mHLbIv5Vn+HyPUhla4L7qCjuTNx0/N51
 3iYjrqaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURSOqD/
 9tudSYcwhpHYqdJVEwSxMTGCUhcD7VJyYs89HVB8ojqKBOzu1ofAiFlw30gn/v/yupim6rnrAZ1qhB
 98esztDXhRsMRf6axAX+D5VrcV3RLdtk68I0mNujM8nTlgUptXYAdc6AcZDmrqpcWbjF5tf4YwOAuQ
 OciVXFTCK+HbpFXvw+aYmy6C1spxfUDh5GiKP/rQG6mM6JRCV+o75CXmCIbeb3eJ5JVfPMWeufW5LE
 VTEw2tslXtD/PmkQ5OmH/YWGjyz/+UZxEzvZtAemr/5YJqh+xcS0D6V154dM0NXNWb5KJPX9BdjDdm
 uw9IkambKs2Kh3FJBZzT4XtELKZ6ssLtKDm2oy18rqr8nw8QnlMZW5QtgCO/KZfFezYgQP4FcX46Oh
 vl9+BXSXq/e7FCQXF52hMvvUC4h7Xa9ACilPVf2rGVFrIKoSNEUc3C0zumDnkJ7fJlYFDcfyyUrQDR
 eJ1dwwFmpCGA8llnZaK8YXDp165TWVmW7YIKvsXhWySIL8cz5rXLzr6vsatBOkAsGNx8Fd2gRssmoG
 tXSVmult4N9W2IdAbmVFxlt2HFoyQVX1uOcF+yYy/pON2sypo79Fttge5+qTDdXWatTZQ2cFlNYCkN
 sM8LFjNajmruxjPmgQIRYaAwvOM2GuGhnaZPX2NSc6xF9jb08HTnAH62ajuA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

DPI is part of the display / multimedia block in MediaTek SoCs, and
always have a power-domain (at least in the upstream device-trees).
Add the power-domains property to the binding documentation.

Fixes: 9273cf7d3942 ("dt-bindings: display: mediatek: convert the dpi bindings to yaml")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 6607cb1c6e0a..169d054d81ff 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -80,6 +80,9 @@ properties:
       - port@0
       - port@1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -99,11 +102,13 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     dpi: dpi@1401d000 {
         compatible = "mediatek,mt8173-dpi";
         reg = <0x1401d000 0x1000>;
         interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
         clocks = <&mmsys CLK_MM_DPI_PIXEL>,
              <&mmsys CLK_MM_DPI_ENGINE>,
              <&apmixedsys CLK_APMIXED_TVDPLL>;

-- 
2.25.1


