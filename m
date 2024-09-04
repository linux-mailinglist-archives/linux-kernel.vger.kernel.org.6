Return-Path: <linux-kernel+bounces-314512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A796B455
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741402896DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24018859E;
	Wed,  4 Sep 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="oKaymwrX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE4154BEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437715; cv=none; b=KwtLQoaZLEsPdyop4pPFu2D276qrybqLr0wATkUNumlcg9wmRj+ImE/EoNVgpLZzfqzZalol4sEIh7IF1ggHlmx+zsF4vAQhmggi/BBzuwcBBDoDXyqVpHX8PQj/frg05axhzEgrlsD6rRcrmttorOn7avhxacPbAZbdSL9Tkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437715; c=relaxed/simple;
	bh=Nj45w+G+TO1Z6Higf3RO95zlGzd8ecq4uKKPC6pMGDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DixdZFo19t5u8iHaFeFPfER3ctHmWEBlDF0HU7sNaCwheBPXZTaKSGCDZRRY3sVIlq3Xc6awVA5Ptl5DalrmZRfxHMyQPhhWTON9VKjkLMKXEFrAz3/5NYqREy7PSgYhSrxd6wtkB/YOSgR2t22jSV+wLK0E9A8bGqZzXziKs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=oKaymwrX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-717594b4ce7so481023b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725437713; x=1726042513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vg5PX8kGrMXGtA5vCBEf0DJJleopQ7dF/auLyYJl/E=;
        b=oKaymwrXa0DSBFJ7DjiOm7WlWYpTszF0z+HvNzAizaBFNW7yr7tgD3qflMxX+6VxoS
         wCXf297C74EvGt68DsFO+WZuYQ8h7Ybc0CRNiP7Si/ihrbQN7qIjONSw744Ec1YBB4zV
         2l1fIQPs7aquLwXR6DSkXjP+BhYTvmmbuWjXeI1cbCegXRyz1RFCx2kfswjZX3umJ8oY
         80LvK+3Kh/WrKHuQkrgXJrhL4gcf3B2rchIu4bCNvUR5YhXjaCgD6iZPbohFj+L67NpR
         finLel+t4NgyZjhndnx4/PlFo6InehscB7bK/KUhDf+3EUjbIpQhgT7hOosbls1lr492
         9D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725437713; x=1726042513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vg5PX8kGrMXGtA5vCBEf0DJJleopQ7dF/auLyYJl/E=;
        b=dNoo3fRuE/60gDYs87fzgcTHgChn0sMa9pfHU9J/SagYkQsJjdB6MoFpW0N9mAQ/YI
         JGQxH2e08gAvIomFhlpi407j2+eZ8eQARP+8WbrxwoSK4HSYU/hoamxaW+Yuw7lacRgg
         wU+dWEbNsFeX3vzXjWGUq5sA+F2T9X9Pwxccdob56RdXBg57+euIKC+BmJdRVnVzaE6k
         nxSUOA3y48+0tKCV+b7SFSItXigsdrLfZRylHXbx6vMt1IP2Gxz3ozRnX0JcSQuRwkqg
         HGUzoO2CM/r3nFocBRNMUWr9rKbhgzOcazGmEKIceukR4v4FVVaHV8hcDJu8Wme3pumV
         2cuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCzNW2HA+HACZ8orFqagvxgpH/xEskcbRB0mtpFfg20AQ4fnSO/fo/PdVVSOfdjf8SoEIglJAE5BKNLAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2ilr1u2XhnX8pBG0iW06HneOne1mbyq6oTNqKBi4cUupYKix
	mRyR7w79f33Nqay+1PRxj0nI05D7cJr2GMVYtAfr59yVyuVQvkiyZgT6VWmtH37+uF+hq7Twc7P
	6b8c=
X-Google-Smtp-Source: AGHT+IGQTuy3EdutFWgRY9ekGLsHfjdaIPiMHwuEXBmtWuFhcvhHmp0JqdGpR/97ULY3I9kGwoQ9PA==
X-Received: by 2002:a05:6a21:78b:b0:1c4:7d53:bf76 with SMTP id adf61e73a8af0-1cce10aafe2mr19982244637.38.1725437713297;
        Wed, 04 Sep 2024 01:15:13 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae94980esm9024145ad.84.2024.09.04.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:15:12 -0700 (PDT)
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
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Date: Wed,  4 Sep 2024 16:14:59 +0800
Message-Id: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the MT8186 Chromebook device tree series.
---
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


