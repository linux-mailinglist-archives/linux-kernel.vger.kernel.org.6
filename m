Return-Path: <linux-kernel+bounces-371319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696B9A3998
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10EAB2552E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FE1922DB;
	Fri, 18 Oct 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="rhcH6GpO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B021922E2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242713; cv=none; b=jR0tm42qJeaMFgbn3P2QT2iTNIBMc/vYYsqnUVdX/HsdjNtYWg8d016wpiUZrCSZPqgHen8a++ByhNJOB71oDA8D606ki+vXNfqls9TP1Zcv43KrE8hUOTLL97gG0O5dDYz6iiqwdDRJueELaUw6oS1tZx8kP/kG8AX6tVBoh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242713; c=relaxed/simple;
	bh=tG6YhzlTGIreNbErkabD4IDbbTrsSViWd67RLxSnw0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pszgxYf3r3s8duRHb+xpRstobs0iTVCaiFrMd+X/pw8M6eOJ5x3Y+TCdyQhu2UBwHPi3VbAOHpLY5SzZFPaH51MXWV047R3sVkup0AgNq3fbbHVkkPqBpqqoJs63BvGzaaj7fRc6ayvRrro8qnqCqRfvv/wtSORvLLD+7R4/EgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=rhcH6GpO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c78a10eb3so2050925ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729242711; x=1729847511; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEsUo4lrwpljoR0FPBQuFvw1WkkxvZeqCHqf7QaSpZM=;
        b=rhcH6GpO9GvlERGGyT8uVUHhFMn6jUa9Kcrm0mmAuB51YXzb2lN1+ux/zT8PYUZNje
         z3KZW9OrpBXrqNApM729fj/MPTadmzJE/XwBg4XCwGo+xRkG0Fo/HWZRIvua2Ra7+qwn
         os48/kpzypgTixg1zj6jJMYSCVElmBhhZwzkex7I3G644u6q5e6gkCTtdmbnpbGxmE4A
         8zBIhIC9ShZkgSHvO1joWmrDtG5jQ1AvLazQz3IdDwIx5E2WRXOLvahlJJ3yySBCVAhW
         nm1C+Gpjbb3Ro5zaDTL1f2+jawEOoAUeuru1/94Tw9r+nAmnt1ji7FyRzTXI32jhwRw3
         oRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242711; x=1729847511;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEsUo4lrwpljoR0FPBQuFvw1WkkxvZeqCHqf7QaSpZM=;
        b=eFrVpOq9I1QG5fVJRUAjjKmxXnLic2FlvSRblC+rzamgCcYIYZzn5LQNFKXVnQHhqf
         bG1DQ3dHOpxMrGZjXxPaBsMf8ThMh/G1d9D7JNpn/780XjtKg7l+kZp4xFfyryiDokQA
         xLaf2VI7i/9zJD9LMFnzqrkVKXlzeCWCIqSSN3YYBxAu1wZCAEKoWqbMEG7XbVD/CzC4
         I767C6rUr+COG6ueEfXqJQ0mQlO+QzZbHill8cYn1GbtQXteptbqXmZZablIkwVn68PR
         om/Yr+3K/1My8AUZEK1AgumZXVqgUoQLyoKtdeJVxnXIXkUWnXPFySMGkl+41wAmOFF0
         7TiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwNfEnov59XEVTCWkKy1+kqRsGHt9+R/1gomVX+cB9dXeK/w98gWJLT0qWfyWeabzIXUiIu3rx6j27EG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXlFaGdlGglfSn4L2+G1fHhhw9KRe5TEXC0aV4uZL4/O6mJDeB
	aZvM2A3dnHoOymjozb/NXWFhP3MxLm6rRgl8RXi8l8RdDNvfDMSOdo704/1YlSY=
X-Google-Smtp-Source: AGHT+IHCJSXnH2e/abEV/Wv8/vRj6XKID20CEDw3D0Xf9MusYELPDkoXIFjOA/U2OAaCR0QCKEtFIw==
X-Received: by 2002:a17:902:e807:b0:20b:a2b8:1863 with SMTP id d9443c01a7336-20e5a7a3339mr9956855ad.3.1729242710981;
        Fri, 18 Oct 2024 02:11:50 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a747925sm8659115ad.71.2024.10.18.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:11:50 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
Date: Fri, 18 Oct 2024 17:11:33 +0800
Message-Id: <20241018091135.17075-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
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


