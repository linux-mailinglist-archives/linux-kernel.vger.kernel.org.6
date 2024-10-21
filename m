Return-Path: <linux-kernel+bounces-373798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E99A5CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548CA1C217A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853B1D27A8;
	Mon, 21 Oct 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="jikVwEz3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40DE1D1735
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495642; cv=none; b=pta5OGzqw5v6MXpR/+5OxApMdyXfyUcmskPZdTmGe0KQF5gX/nhNNY1HlfOT60dpHwF905hcHbFe6TvZbLgSR0mQBMTaAsj4WD50smWUxN+8mg3A9cIB8A6uytZbvPmHRjrT/AUKdd1SCbEddopMV1UsPMfmVdxvxA0s+RVWPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495642; c=relaxed/simple;
	bh=7d387XbGv+JuPxcJAyDfP2Ybl78d5z+BX2IzPCKXLUg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TjY2cT/bSrjgyqlCAfTYfYevK2HfLmYJitpEGB+abOcuJYdltG4CHq/mYHm5E8yexJMk8fJmzl7nUwMWV5IrSegwVvd74EBMx7JuiFANRPtf1+Hlnu1TLnFyFupTl/Lw0e4dli9ebmX9JzSWre9gP2jkyfLHuMCNewtqnrEL6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=jikVwEz3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e5b1aaad96so220008a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729495638; x=1730100438; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RuLV+gJE30OXtNyG+M95n2ScV6KSGMzKjcPSGYqH7I=;
        b=jikVwEz3GCL4HBohozgPcWVb3oLbbL54/TPfkIQCPkicJK6VYXZhFmWFWxYuy+xekB
         fdAJ0mKaCrup20OxKLWDRX2tuvTnkMGi2MtIZM3Dq94ws5xpOnGoEh1zqTZd7NCorYTt
         iMc+lvfkTCl7Kqs9uN/teLJY25ey7ElP1vhe34BFSgX+kJAtSkgJjP9cn9opYf8cmvIA
         7p8UTW7mj0X71Ef+tMb9T2P5DDuEabHtxrW7gE54tTWB/akuZ/cDdWof9f4o+UoMndqC
         F6Kadsik8TsKq04dp57UCK2AEsWUmRNvAnImdBaaa0I65G/KfRSMMb0DvfOE6UYo9byE
         rgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495638; x=1730100438;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RuLV+gJE30OXtNyG+M95n2ScV6KSGMzKjcPSGYqH7I=;
        b=t4PCfSxYqvHYX4yZGDQfZBLEFZH9753DELXdcD25Ppnf1WhY85/OcEgmkhjLlosDw5
         HXRYb70XBIDIPKLHxCisG4dTJEbMh51jbKJmM10ybbmqDcMRlTsNVEK5lqPGcFe93wyV
         v51UbAs5E56mUTLbOQYCD0Pn0Gba+Ub8/VvpT85hasgXLEFwl9xSd26KSh41WKw8XUtF
         X8e/F0mlGpCEFWyOlfK34lgq5fJvCJ1ooASWiX37oT9etr4C1aXzY1h1MapegIuQmkdY
         VXr3H2RLRw1wJCQb36xpxU0SVdOtpJYpPGhXTVvxGxki8EocDd1RyCSr+XEbWO0rf2ul
         81qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYs9JRZwQdOqlzq1docvXcAzz8qXIxgA8cPZ/zWj1L4aCICX5QGonC6clo8DaK/Hg4H5mRZP+uW2kN4o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4g1apWOkh6M1hF7DX+DFLt9X1XFEhQ59nVjULZpslFZoMkjRP
	gNdk9al4GHBksGqAFOqe2Nytz3atlYhr1BiY+tiZX+vRenC3vPgSxBbzHQfCAog=
X-Google-Smtp-Source: AGHT+IFpx0iTKEAwT3WlvkO5e1PC1FRTIM+OU/OYf9CVrGfExwAKk4Zt8qzMrBocxp4f1FZgpGEoUQ==
X-Received: by 2002:a17:902:da8f:b0:20c:9285:e951 with SMTP id d9443c01a7336-20e5a71b46dmr62711105ad.3.1729495637905;
        Mon, 21 Oct 2024 00:27:17 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db2desm19749595ad.203.2024.10.21.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:27:17 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 RESEND 0/4] arm64: dts: mediatek: Add MT8186 Chinchou
Date: Mon, 21 Oct 2024 15:26:22 +0800
Message-Id: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is v3 of the MT8186 Chromebook device tree series to support
MT8186 chinchou platform. It is based on the "corsola" design.
It includes chinchou and chinchou360, including LTE, stylus,
touchscreen combinations.

Changes in v3:
- Add a patch to change codec in pmic (in mt8186-corsola.dtsi) to audio-codec
- Link to v2: https://lore.kernel.org/all/20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com/

Changes in v2:
- Modify location of "const: google,chinchou-sku17" in mediatek.yaml
- rename "pin-report" to "pin-report-pins"
- add "vcc33-supply" and "vcc33-supply" 
- rename "cbj-sleeve-gpio" to "cbj-sleeve-gpios"
- modify subnode of sound 
- Link to v1: https://lore.kernel.org/all/172900161180.733089.8963543745385219831.robh@kernel.org/

Zhengqiao Xia (4):
  dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
  arm64: dts: mediatek: Add MT8186 Chinchou Chromebooks
  arm64: dts: mediatek: Add exton node for DP bridge
  arm64: dts: mediatek: Modify audio codec name for pmic

 .../devicetree/bindings/arm/mediatek.yaml     |  28 ++
 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
 .../mediatek/mt8186-corsola-chinchou-sku1.dts |  35 ++
 .../mt8186-corsola-chinchou-sku16.dts         |  29 ++
 .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 321 ++++++++++++++++++
 .../boot/dts/mediatek/mt8186-corsola.dtsi     |   8 +-
 7 files changed, 441 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi

-- 
2.17.1


