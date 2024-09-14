Return-Path: <linux-kernel+bounces-329181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A14978E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A691F2132E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FD15914C;
	Sat, 14 Sep 2024 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="A8Qjl72H"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E11BDDF
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726295494; cv=none; b=e/sNwgo06yTrWVjTyAkjhsDvOt++qdpCSy5qSSOwdbmv9MkN+dRbaHWTMqFa7pMNX/afSUsH3aUlLX/LK5TXg1N48gSL5z5B8DWJPDcr2sIkplhfZZmymKaEcBQVBVk9FIft6vJW8OXmT855fJQ7LduMWsCKdS6zy/liWJxCTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726295494; c=relaxed/simple;
	bh=V0dYaUxOR22WkG37Wt448oiq8c5ulPda+OgqmSUfHVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPuWnQk4TcUfqY2ajOCy/2eQUdDHcrRRXluhoGx6GSQ8QWTiBOFzuwCWJY6sxFjHB8j2phA1eX9mLz9DZolUlXEYKPFcW7mllD8X1cE9NBacjmw516QivGM8+eZLwj7YlkfOJuFcJApucqAqaL+24X6/1BTnxaNbC2fACiwD3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=A8Qjl72H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2057835395aso32978375ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1726295492; x=1726900292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3F8RL5B/IqI+2pfLBP9VWUihTDASIHOdqEg57DLsQ=;
        b=A8Qjl72H3HrwfrU+ljcSgJerRg7JTYGqQje4lmfcr0wND43wQJ46kRRJ9CTgxYbeV4
         fzFTBSySSvfZ246m5CBhHwFmwwvhUC131OXA5xcP5ECv+8FcESZmu+oBhK/3eraiu/xp
         USXLmFh2l+k1ZQUXTp+Ot02gauoP3VYFaoBaoKRg2h3eiqSjEuGJTegxjYWaZMbCqVh6
         +tc4kXM3D0bR/EN69Sua1aKHh4CY1ovvoOKOpOqjOnUwgXQj+ECitBa1B6ggXGtFekp6
         vsWCkDeDGxl8lCY0NchWv/j1RaWcBOv1JKBGWxXPlqHkGqZpJlvp4bOaqZP6DPPyeYth
         XEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726295492; x=1726900292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YA3F8RL5B/IqI+2pfLBP9VWUihTDASIHOdqEg57DLsQ=;
        b=bGt67WwqkGGwykSj2zFBxnABKR4KQ/H2XplEQYJ5BMMCnTWNY2eTEGlNW8l1Ltq3iQ
         Idlo6NYtISOKcix+6NKQsVB4/UejLVgEJZldVFfRtq+OeuAPX3XhUpUrctDDSAV6x8Vf
         przxfdpyBD7A++Z0Whwemkl3PnJQxPeEsHh0lPJtqQxKHy9oghZvGwvT38mcGoYLsNiE
         XlJd2QBqfi3RyyULWkT9f0zaXfj0AU8v667LBmj/+TZ783DB0McGCi9Gmy3OCQlnEuxv
         YuVJNElXWlZdV2e4Elf6sCNFq35ciyo0zpgOy31psgbOpG7RU4xezQ34runDYa0mqn1R
         mDbA==
X-Forwarded-Encrypted: i=1; AJvYcCUMO9da1NVhTBD/dFb7vzs3WLJEVgLo09kYVapURcZD6ZuIC2H+DGjJP+8OG0AHZa0Yme/ibT/U6q8vYSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9QDvJITCREGxgPC9as1kGq2XuRhrVRgH0iJ22bXx5uBY/b34
	lxSfuetjPbR7cgV3sKzcJ+ymuAYmUWCTSxFd2d3mr61gfvYRw4Lw5hK+J9yGKi4=
X-Google-Smtp-Source: AGHT+IGtfxxOGIugbIiDlOc5Jtw9CTrvz5uv5il2P9BcO9JycK8o2ZIE40DV90rpSTLnoassY7JfoA==
X-Received: by 2002:a17:902:da8d:b0:205:3525:81bd with SMTP id d9443c01a7336-2076e36a660mr150026835ad.29.1726295491870;
        Fri, 13 Sep 2024 23:31:31 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4990cebbsm599216a12.37.2024.09.13.23.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 23:31:31 -0700 (PDT)
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
Subject: [PATCH v8 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Date: Sat, 14 Sep 2024 14:31:20 +0800
Message-Id: <20240914063122.1622196-1-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v8 of the MT8186 Chromebook device tree series.
---
Changes in v8:
- PATCH 1/2: Remove custom label.
- PATCH 2/2: Change the commit about ponyta.
- Link to v7:https://lore.kernel.org/all/20240913031505.372868-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v7:
- PATCH 2/2: Remove prototype sku.
- PATCH 2/2: Disable the other trackpad to enable one of them.
- Link to v5:https://lore.kernel.org/all/20240913015503.4192806-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v6:
- No change.

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
 .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 18 ++++++++
 .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 22 ++++++++++
 .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
 5 files changed, 96 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi

-- 
2.34.1


