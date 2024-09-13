Return-Path: <linux-kernel+bounces-327485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C581897769F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0491B1C2434C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D68479;
	Fri, 13 Sep 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="cS2v6l40"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CFBA2D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192516; cv=none; b=TIuvQ0qjx0/BbCwqRMgTag5cQqw6uwD/uVRmlpCrikcF0TD6+LGr0CsrKDg2g7ZAyoQWEDYmEQrh8VQ0g6xWgRpyfS8YPLLyGiRtWmlKrbCCTdEyD4gQExrbVqSv6K9rj83HM6UwXbSiI0OyT5oJjlJFLmT8H4AHMNadnfDZizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192516; c=relaxed/simple;
	bh=UgE1yGDUQ+CbC/t2QIGqv5v6C/QuQxR7umJ8vrHCvJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HmlrizUu5+0pstEPQdZo7SF6h/u8d4H078kBg3/AQQViqWtndMa1f81eIK5JQ/CNwbZx+ZKkmz4r1+qLJr54oWqcN93n8GMSrMyHjgYD4XTLEMgh3XskWCzk0/62ybmhrvcYa6DV8OgKpXPZpLQxTX7AHKvBeOVzbI55Y/7Gmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=cS2v6l40; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206b9455460so13276375ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1726192514; x=1726797314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMxkeNdrxiqikuKLTukYhJ/j/5AL+Bs96CDGSxnXGSg=;
        b=cS2v6l408n0xmb7VmScOarcYLsea4mC9mlg6g4eXsOyJtPI55R35A+qdvhW20uzK1C
         IX5BE6XAxFoVlBGD3Wmydln4f8Oj1fNgTinoNSDw+IRIFvnU16WTdFhKBKXED2F4b1z7
         Lf48A4kOZcQ2FUsO6eKzjJDNeJootBYAvlnBlhorgRRyxQ3PmvKFiSINe4IXKMskF9Hg
         eck4yQb/IXA9u2xijvqJvQRqDOAukFIEP1+0ulrVtgu+N0VH8c5GjPu2fAqM4TppBdkz
         aUoTs2bBrOG9XIoex0HhWkQ2z8wNQfXwbsf87X8+rtnKT07+w7/AclUXpfK91m8//rc+
         p/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192514; x=1726797314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMxkeNdrxiqikuKLTukYhJ/j/5AL+Bs96CDGSxnXGSg=;
        b=f7I0t/+H0bAGs4TMjdOeffKO5mC62TaO5+rRy7kEqapCywyPfEE/Tv2kx86iEhv2P+
         k27ilJs4Q2MoUIs/o3h6mwub1o+LwuE7wUIL9Sx4aFiwB5LdOernphG2jR7M8vvxCu3Z
         NxWtdTsIXBFC6ANff33T5VWOSwnhRFo+X0nbpZz85XXqdJcMQqHuuj1ZizsUrPTir9PR
         tGfk95LOPBd3WvIhtq6Y4VoeRqgb3P1g+VUSp2KBDlc9NNrwokZYLm8/YdmfTuy16VX4
         N4EIVO6Gp9mHzaSo/cQn/WyyzpxOcCtasRmPwZ9Crar/yPLJ2ZQVNxsfkr9IA1jUitaB
         e00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgXfmk/JATeAbfTUAjD82b7hQ21zTtcaBMp3l9TrckbZFRitC8EAz6HZxQwnYQHAac6nFjjM8xgHreWew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrtuQYQspazLGvyU5G12VxKV38KXBUP2SMNJBc6rSezO2BWTz
	dhEWt/0OWu1/1LMHB33litPLg5/OCCaswUzkLajRQMPMorPSuEi5qx4zaZ7ol+s=
X-Google-Smtp-Source: AGHT+IGxrtDK2oxIlkCa8nrZNGoU6o2v1wR+o7ZOWg02JmyUm3+u/KgHhFUU6pBBIaZ4YEIAqXAk3Q==
X-Received: by 2002:a17:903:32ce:b0:205:6121:1b2d with SMTP id d9443c01a7336-2074c5d24aamr135964765ad.3.1726192513808;
        Thu, 12 Sep 2024 18:55:13 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af49210sm19896605ad.99.2024.09.12.18.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:55:13 -0700 (PDT)
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
Subject: [PATCH v6 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Date: Fri, 13 Sep 2024 09:55:01 +0800
Message-Id: <20240913015503.4192806-1-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v6 of the MT8186 Chromebook device tree series.
---
Changes in v6:
- PATCH 2/2: Remove prototype sku.
- PATCH 2/2: Disable the other trackpad to enable one of them.
- Link to v5:https://lore.kernel.org/all/20240909023148.1677936-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v5:
- PATCH 1/2: Remove sku2147483647.
- PATCH 2/2: Remove sku2147483647.
- Link to v4:https://lore.kernel.org/all/20240906085739.1322676-1-cengjianeng@huaqin.corp-partner.google.com/

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

 .../devicetree/bindings/arm/mediatek.yaml     | 10 +++++
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 23 ++++++++++
 .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
 .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
 5 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi

-- 
2.34.1


