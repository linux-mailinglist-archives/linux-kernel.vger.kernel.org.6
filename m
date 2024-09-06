Return-Path: <linux-kernel+bounces-318487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6A96EEA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A96428711D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F491586F6;
	Fri,  6 Sep 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="u1Dy4FgC"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED715853A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613074; cv=none; b=B0Naq+y7J3GNwEG8kkzLzkh95101opBXJg/SmHmKG+3u+2jKE6jcaMPrIfyc2VhFEAaR2+N5HnncDiwRQMzQ9++QZL63oCL3IXcLUvvQ5A9W+9oKeVpr7kLhQPO+6iaHM0i2ArqSNZ8B5ev6FjW60wP5KGodVR41NvUjDdg5GJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613074; c=relaxed/simple;
	bh=F+RwEAES7l1bbdWXS7Y9yutczby/1++9KHgAU9AUAYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JffkNqiOjSidSYhdtjf95EeSTyxwCgLfpzdLWqso4DYmmf3ol+wI6JB1jhKRMECAuQqkenRVyczgciKYtI02TQ3R/TYK3hQGECD3lzFgsRpliY5N5FAzbWhWQuzvxdRAgt9GsdG+lOX1Exy71DbXKF+2kZIsxCncCmYnrmQz7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=u1Dy4FgC; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5dfaccba946so1089008eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725613071; x=1726217871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGUemR1VhN2nMqLUgi9zXLGIZPomuw+no6hZxV3BaX0=;
        b=u1Dy4FgCuiwZuJEmJqg3WHUAO6BWQiEda7yRlGnlwbp0NVzs5P1M0UBcjoiJW5DhuC
         PgcV2tcmXEweBUy6IN+gYdQJ+osFu1x/g2ZSOboL42iiUtJVDzb2WnNeKlxQGl1xSdvK
         xIPUxsdzW3VEbl93Cw4DxLfSXYNZLYbRxU372/lpQZernVKw7dAF5UyuWa30G8PpEAoq
         9dyCOqtjyD9gcJQ7N5gCC441Wa5xn73NhPGf21WxVrCf5W524yPnkGSZgz7Fn/PpeEQd
         gMOS/Uow9aXgtlpZ1xt+GOwj2kFeCBsLXD5EVeR5GR3YimJbDxPwipyCC5BacdgkCzHP
         dE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613071; x=1726217871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGUemR1VhN2nMqLUgi9zXLGIZPomuw+no6hZxV3BaX0=;
        b=iklyTZeHI86oYdo3J91fNeFxztB1WH2Byt6AfVoKEjoMZrtKmDRrYpVKTuOmE+KbnC
         3pgzrF7F7aOHHpsdD34z2y8SKeFrFQTJGAQB+gY1q2lQK5j0rmMLTuz/HPaJHzOT/cYa
         zAZwX/GmfifSoHsrPgOubVyi4ll179auLDFEmG7g0YWE/8xlxewH7Gnyb7+qzpMCbG16
         /X24/ES/fF4zNtWbn/tHXonr9WDDdBlDPRhzJ0iq4TMg6jq2JbCAb1NjHCAh7WQJArsL
         PVhpUpiYUQZBeBh9Qh0ffvFWlm+rk1F9GPgsipnZKzo57JiyAeGqx6MseyvQayMiCNuI
         Vv1A==
X-Forwarded-Encrypted: i=1; AJvYcCVM9LNRCZh1O0sb4jz3FwjKGn1ywJhcFhQYzQtZEZQlK1+aLDqJKdixnJIrDzYWtykCIIsXHVNrmMrbKXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjYlpjFDUsmc/tQ5O2bE6CJs+A+bMn5nC6WuPw6b+kIikZJZ/
	Cg4RNadVbP3v0PvJTLoqGXePxejZokU2DEUwbJgPZHMlFDN4li8wb3MUo6AZHUA=
X-Google-Smtp-Source: AGHT+IFk6WA0QFBBPEfr+oxwj7x0SWhji/tk64+zlRIENA9+hoq0FUcNrJY4D3BBYjbPQUuMA8Ocbw==
X-Received: by 2002:a05:6870:8289:b0:260:f43e:7d89 with SMTP id 586e51a60fabf-27b82db9750mr1951434fac.2.1725613071057;
        Fri, 06 Sep 2024 01:57:51 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71798286219sm1439166b3a.57.2024.09.06.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:57:50 -0700 (PDT)
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
Subject: [PATCH v4 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Date: Fri,  6 Sep 2024 16:57:37 +0800
Message-Id: <20240906085739.1322676-1-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the MT8186 Chromebook device tree series.
---
Changes in v4:
- PATCH 1/2: Add more info for Ponyta custom label in commit.
- Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 0/2: Add the modify records.
- PATCH 1/2: Modify lable to label.
- Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 2/2: Modify the dtb name without rev2.
- Link to v1:https://lore.kernel.org/all/20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com/

Jianeng Ceng (2):
  dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
  arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks

 .../devicetree/bindings/arm/mediatek.yaml     | 11 +++++
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
 .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
 .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi

-- 
2.34.1


