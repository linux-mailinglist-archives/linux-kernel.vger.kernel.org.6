Return-Path: <linux-kernel+bounces-318488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34EB96EEA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F008B213CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3715B10C;
	Fri,  6 Sep 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Iu3dpdk7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA9158D80
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613077; cv=none; b=VQiXi8Of3etazYFnDiYcD7BjR7xmmNzEehNYtWCtEZ9Ut8h+zCWKIBXybheJbUg0EKJEKi76BBnmVp37wbtbmfq4oOFkDE1tSdTKHCE7gW/BQcjKsK/5HcQzbVq1QILX0zn2E3PFafse8nH+7hRCslHLsDxPEq+jzlFX7xrOBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613077; c=relaxed/simple;
	bh=EiMc6AKuBTOVH0XOVNo9dyuRDAsqloEKN4IWcRO5bwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZOANm0KP4Vf2GZ7upt779soaNB5XZIqMxAHAD1nT8nMJerYjsF0gQGbnBPIXVG6dVGnqmSvHBt0CKN6yeqBLTbr9hVNG4sE1GM9YO5it64KVolLCBQL9QijV0Z1dYp8AtzBVMAtCBtj+Y3nj+pl+vpROfaQau51zDtU4ndIp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Iu3dpdk7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717914d6c95so1067618b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725613075; x=1726217875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfPCPDyI1RrKAFi5i8oSogBSmIZBHNxCV6AppJiq/Hs=;
        b=Iu3dpdk7UcjgMgJilDhi8eoEVzFoPIj+t7GVXhXxzu0vmvizQs4A6uHx82QD7ZGvUj
         6MQAgc4aMJml2nWzG6rwxaF3hnuftIvEsfNC51cE4sLEsrlTrzLHK1X2Y0xSstwMU61M
         8mD2LU/f7RmTfQm757RLXLq4BQU89UAlYZVs9XOscam55DHhjA8XZabekhe7k3sTFtbm
         mAvpuYVPhjmo1ElDJbLEITeTJNd0z+/jKHyG8VSUGR1aWXOt9yKh39NpdEXn1tcIRBKW
         saoiCo7W1ecHmVW6Emc5FbUlVnyuJAL8J/EfFiy91AwEfVAtB6RmwJJHJGut8uydsUsW
         1jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613075; x=1726217875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfPCPDyI1RrKAFi5i8oSogBSmIZBHNxCV6AppJiq/Hs=;
        b=i3Fh7v/bvX3NwGc7Ha40LK9MzVJLwoLku6P3fzlho7W7wFiYWsxadFNJlrx+lgq0Wv
         Li2Nnh4sckvu1/OGqUpWqCcMzzMl/R5wQO96lZllTEDc39eCxTvlqQYrHurFeXyucVSF
         C3dZOkh1zG+oTjChR0mjKS21vL9d2ulSbOB1uJvooO/MmX40goxBVrc5KjEcuVrHeMcV
         ZD5gUhmJ6m8gY3YKYjt5oCeC39FcpaWdgfuzaqasONGe/Q4Y69FNDGbbueMxnsqrYGN7
         Y/ST2xWbqYvNdWyRUK+OXh2hJSzOurPP7VXTwnGkBg7doLj6zJ+NWyCfX5aI5jbzGkOp
         kE8A==
X-Forwarded-Encrypted: i=1; AJvYcCX/3vDf1mvyLIorL1k84UtT6p8ZR3PuwWADfB2LMqiZ4/hd2mwFW3K7m9+QyXKZKPHH8SbKPjutdH2UXLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafIabFzTO9/BY8LV5UfasMLhV48vJsicKamTTLc9zd/Ed3+7S
	RnnqRjd/GfTE9daP+GyQCCByMv+3stwMlFuG+I4W9s05VZDTEjQWB4VHcicxgXk=
X-Google-Smtp-Source: AGHT+IEQknbzHq8Vt5pY2Z0mPW8VsXzjXllMF+wnb/G0zbnfo/dO7wl0slgZX4oz+k9PIl8B5XeZGg==
X-Received: by 2002:a05:6a00:ac6:b0:717:9462:8bda with SMTP id d2e1a72fcca58-718d5e16866mr2039277b3a.12.1725613075015;
        Fri, 06 Sep 2024 01:57:55 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71798286219sm1439166b3a.57.2024.09.06.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:57:54 -0700 (PDT)
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
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
Date: Fri,  6 Sep 2024 16:57:38 +0800
Message-Id: <20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906085739.1322676-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240906085739.1322676-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ponyta is a custom label Chromebook based on MT8186. It is a
self-developed project of Huaqin and has no fixed OEM.

Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
---
Changes in v4:
- PATCH 1/2: Add more info for Ponyta custom label in commit.
- Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Modify lable to label.
- Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/

Chage since V2:
- No change.

---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..4bc1777b9ea6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -257,6 +257,17 @@ properties:
           - const: google,steelix-sku393218
           - const: google,steelix
           - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku0
+          - const: google,ponyta-sku2147483647
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


