Return-Path: <linux-kernel+bounces-327486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FF9776A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335F028215D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DF6F303;
	Fri, 13 Sep 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="QCR593cq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA1B672
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192521; cv=none; b=gJoHFAkPzGg2IeIpoh+ZvDTpVy+NiGQTYx+U8tHmwwe3x2P0eYMQH9S1xtYbi2wZiblfBmzT0hgCfeV1HS8/HXv6XewTJg99hR1QjbS05HFwrmBzpKSwkWoAqtx95C2z70+Obvx2gM0rvsUMX2DHhC8xwx9v7mGDBUEyJ4GqL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192521; c=relaxed/simple;
	bh=BkjmMiEMl45J300GYJj80NKNWiGSISsVAkkvPlbb0is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KecYe6trsuuAosEtrPoVMiBE7sBWR+XAQ/fJpwdm0wQOl2RfpfoeKKW5QdH+2l1L/q0Fh4Bh26rkw3oiP1LW5NzszTr8pzU8piybN3QGg7+yXQzQCL7kNPNZwgelyLQhKeQQ56tFs/dvCoZd7RrEyDKZyvlLLpT10F3UfXwr51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=QCR593cq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068bee21d8so18192765ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1726192519; x=1726797319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/tJ6K2p2TuSkkGXCsuIhipqtb2yllodeabGTYDSu2M=;
        b=QCR593cqv4LdeyfHd2kznZFefclw1F/rXvrtw4wIM8f04Hx/bWKIpQ0cePEPL9kBjx
         DThashxdjrE9nfwJvkoodDav46Y454VqS5O/8qwgmBvyC0SyCYGlv7od38b7bYhxKJfc
         VTmg0fqYfVKDybpWTJXO4PzP9YwPW3Wb6bj9xJul9bWLDGCxTfyARGV2GfoE6H/pN89l
         cpBH0Ro8vQ5dnMNx22rmDP3Nbp44Xux13qYg5EpxfRlPeHhF7lcFbjDadKu5iFxRoOZR
         Lej2iKhbNgTb+Fu9GbgxMTpi9WH7NVpKi/jYGhfM+woDvX+g19wvXjVBnv4blbq9pL2h
         +92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192519; x=1726797319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/tJ6K2p2TuSkkGXCsuIhipqtb2yllodeabGTYDSu2M=;
        b=dWYtal5V7lsA78uAoZuS4oADbD8jQqC01U4OVGk1K57liZcy5qKaFWxEhdcb30vS6l
         Lhy0VEBXsmZAsj30CRZGxP5TiHybKGyR0wTKB0DWjTbbZjABk8v2VRCsP7DVyeo9JdJM
         HB1HGgD464sh7H/Q+/1BFBsWse914oaUUNzetLwDHGhg3RrfIORFUwrRVSGTmYxqSN3J
         chm+ZD1EC6kqEw22fXqXqu/hy3tf7KCspiLRsOBUGqnix6x+vwxI0sK9IvIGr3Ejk/4h
         LQoBtUbg4nRpaSaPhx3hBNMyHERK7zFe2dXkSfsZzsrzmEaU7wZVVIDVTOE0r/uDz/MX
         6Bxg==
X-Forwarded-Encrypted: i=1; AJvYcCVjxHyyKmIhnVZO+pkzPWJY+wh2h6+7MpMoFD4J3J0PkTf0MICRNkKC5SRfGxyhOzsNoUun+mxDF+4C2zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/G3Ow2Z48jEIoMbaR1p2JFLjFlhzvRiSULGliHLIEhx/JQOp
	ebJUmuolEI738zUMx/MReRpdvt7LYXLRA7cOqZ3j07+3gA754LqlThUKPlJ7bss=
X-Google-Smtp-Source: AGHT+IFSSYOJX031nMRvpIoTRVNj8X237R7lNtTDrvk+f/3CXcwctvLBX6in5w2tExnnjfh7zFzcOQ==
X-Received: by 2002:a17:902:cf41:b0:200:abb6:4daf with SMTP id d9443c01a7336-2076e41299bmr62421005ad.39.1726192519391;
        Thu, 12 Sep 2024 18:55:19 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af49210sm19896605ad.99.2024.09.12.18.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:55:19 -0700 (PDT)
From: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
To: angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	knoxchiou@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
Date: Fri, 13 Sep 2024 09:55:02 +0800
Message-Id: <20240913015503.4192806-2-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913015503.4192806-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240913015503.4192806-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ponyta is a custom label Chromebook based on MT8186. It is a
self-developed project of Huaqin and has no fixed OEM.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
---
Changes in v5:
- PATCH 1/2: Remove sku2147483647.
- Link to v4:https://lore.kernel.org/all/20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com/

Changes in v4:
- PATCH 1/2: Add more info for Ponyta custom label in commit.
- Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Modify lable to label.
- Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/

Chage since V2:
- No change.

---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..43a824bee1b6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -257,6 +257,16 @@ properties:
           - const: google,steelix-sku393218
           - const: google,steelix
           - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku0
+          - const: google,ponyta
+          - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku1
+          - const: google,ponyta
+          - const: mediatek,mt8186
       - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
         items:
           - const: google,steelix-sku196609
-- 
2.34.1


