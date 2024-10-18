Return-Path: <linux-kernel+bounces-371318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D59A3997
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F11F26BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7041917FF;
	Fri, 18 Oct 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="guZOq5vv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72683190074
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242707; cv=none; b=mVLyP7n6DiGFzH5dqWVz3T7cENxV3bzcT7hHl4yhXJM7q04yr4l+pIq2ZHAMatnzMksI4l2tD0Zsg5wdBO/0DRBd4623xEcvHSCN6WHZBuQCv6Qm46tLMWqGMikTdxHZEKQGMU6pRWY1duIqwvEpaiwvIMzCRLNwzOL9F/DyHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242707; c=relaxed/simple;
	bh=7ML9BaFxjqR2leVtcsveqlMn8bmwB6L8/O354LNigg8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q47Vjt45uvwI8H/zFkVMD/zhUFooYBTBImDIuSXJAkgVxnH4bqRdqQKWIIMg1ZJHeGAFxU8jzLyZ2a+i06x91HYwKkIVibKV9+ArAoabBX1NzhjUEUS4stjt1tFqYQr70/ARzxFDjkRBxtb7nmhDapuMS9FvhCMUz9SVJoOroug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=guZOq5vv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb14ed25fso1688645ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729242706; x=1729847506; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaoO+565mGfry0W6j+qf2c7QIoIrwJPR2hf3bZTL/ho=;
        b=guZOq5vvXeT4Xp6GL43w0JEQ8W4I8mT7gJhjDmvnTi3MgvOE5ot1RrtJ8NEpMahDI5
         2hfa4fK9PEjEE/uvaFI8dhRmhLN+M/fnz2dvuFGxF6B/ha7VNntd029aTSrOsCdfVFIv
         ODajrQnGMIyCawtvSZT/sAovaAvMw4riwVc5yyhHQZqF0GK6gJRMgmmFouEw0xa45aJW
         p8UUlL0gXj2BLyK/97rX1081yyOINaufLkIbSeDbRAH0Fe4Nu/57VzFf5M7km75y6gwB
         kzr0E1NanNEu6GDIHgihFvRRK8HEbqkIyugvjTKJL6+STebhWluxhsxrUz7tglfWq+LJ
         og9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242706; x=1729847506;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaoO+565mGfry0W6j+qf2c7QIoIrwJPR2hf3bZTL/ho=;
        b=th9DWo4z/j5L0NL8UyWvxOJai2B/ql7ZGupdo7s42u/63fcN9X7xHoPjIVmglptLe3
         +p080FmFpYXckssoe+SK5kIJooj+nKJL/aXzxhLUaU/GDl3TI+5FB3zM4+xtFvyhjna0
         3HX+maZzEaztmci2EWVL1oFVsctMnBfPmjdF0zwKHpQqsA4iGmz6ISXKjpvwQvTmfmEG
         UusuFNg6ovVPevapRGX/XnJFecHcpaPFotNTu5seqQOeYEI5NOGBRix0w73z8jdJFmjo
         +jDgvjGZrKPc8WLV/o927pXUi6EjHpYWzova2f2MCRmBGibeFM2yzLd4nzwiEyKPV/YD
         vrWw==
X-Forwarded-Encrypted: i=1; AJvYcCVAQ3B8dp/2SLt9s8inK/ZOkwAM0CUh2RUmWWrc41DA1PAeSdKKQ4XVN8uSlTK3cAv65eqrqxroQnZa+FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2suDCl9ndTCDI8fasO3ksAC0nGUmZyLSPrndWnWkBOt5TDtr
	Ftwy0XxlYBa6JS1UJM4nHS6t3cShGz1pO/1KsDUgMRRWN4UKXGk219ew+jCqVpo=
X-Google-Smtp-Source: AGHT+IF4YykFYrR5hyelgDHgiOYPw6kniN2qGv1Wi7cPdUoPh/WVQaQWN7J08p1ObfnrZx4Oshvnsg==
X-Received: by 2002:a17:902:f551:b0:20c:6bff:fcbf with SMTP id d9443c01a7336-20e5a8ec091mr11252295ad.10.1729242705804;
        Fri, 18 Oct 2024 02:11:45 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a747925sm8659115ad.71.2024.10.18.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:11:45 -0700 (PDT)
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
Subject: [PATCH v2 0/3] arm64: dts: mediatek: Add MT8186 Chinchou
Date: Fri, 18 Oct 2024 17:11:32 +0800
Message-Id: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is v2 of the MT8186 Chromebook device tree series to support
MT8186 chinchou platform. It is based on the "corsola" design.
It includes chinchou and chinchou360, including LTE, stylus,
touchscreen combinations.

Changes in v2:
- Modify location of "const: google,chinchou-sku17" in mediatek.yaml
- rename "pin-report" to "pin-report-pins"
- add "vcc33-supply" and "vcc33-supply" 
- rename "cbj-sleeve-gpio" to "cbj-sleeve-gpios"
- modify subnode of sound 
- Link to v1: https://lore.kernel.org/all/172900161180.733089.8963543745385219831.robh@kernel.org/

Zhengqiao Xia (3):
  dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
  arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
  arm64: dts: mediatek: Add exton node for DP bridge

 .../devicetree/bindings/arm/mediatek.yaml     |  29 ++
 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
 .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
 .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
 .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
 .../boot/dts/mediatek/mt8186-corsola.dtsi     |   6 +
 7 files changed, 441 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi

-- 
2.17.1


