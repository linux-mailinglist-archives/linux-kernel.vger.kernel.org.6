Return-Path: <linux-kernel+bounces-442608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A59EDF54
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F054E16766E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C841187325;
	Thu, 12 Dec 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="RlvB8ifW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7EA17BB24
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984455; cv=none; b=V/4+gcaIG11qZZSToM43kX0xBkUsHh5y1Y35yaARmJQBy3NZUGzOuOnNonKrjUM5yspwdqx3/biXFuJzSSBHQvqtLyWzO7gsUKFI3YlSQfZa9cNbN20aSPx6uokz50aDZONTfvMwueocirAIFx3eGVlWeVb8b+91HRGQQZRV1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984455; c=relaxed/simple;
	bh=DURjK8IyCOH/TUjiFMC5zs9Ikrm4F/wbwKEn58IIwM0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YZ6QRIFnY9qtN6CqGEGPfwJPILrpVyZTh5L9jpC3w9VmnlS0QQgTBqHVtklffzgJ7n3cwBcVS2zNH/dJdCIjcSZzpTZok23AX0UJY4kmgiJ4Pk5pA8LjJ3M1Q3AVOkliKlmF8D6dfvs6KDcif7Yz3J2zdF82F6oYD3DM0jdaXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=RlvB8ifW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215e2f17dfcso471465ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1733984453; x=1734589253; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sOU/zN1rnDAJHK7mSCpddQhh7N81+Tto3qj5XwbKbU=;
        b=RlvB8ifWSVPCzBnK7kkxPVYYJJge39K2aYGYv3JG9ORBDNaEzbY4UYjUyaU6wYSRtb
         A2euV3C9JNR+MEDBS8vscg1Rxi80S+NCL0m0tuamYNSSfmrLv8AQC8otAb4/a3X1s0+Y
         4QQ8aPUePSUsO2FbvtjduaiEtOhOUfthVHEytl+fTkDdo7EEF3zJSJCQkjT7svPfIShK
         2E0PNtRbvEfR5vK4XxiZTEIOyO0LcBFcIz11EhDpL5APBOGtpOab9AN0vM7RDweUeWI3
         h1RDk4AoyA2KedfYJBDBpP+uNclUEC3Fmnpdo5nz8BHX/sEieTJ1IFhUknnwAvQtIWZi
         gdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733984453; x=1734589253;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sOU/zN1rnDAJHK7mSCpddQhh7N81+Tto3qj5XwbKbU=;
        b=XMai1N5P0RD3JOVund67sWdHjrC8IOP7LzC1Y4AX7E1NFG0kFCqhKYFQXxgvNbv/wt
         KFWqhkwJqUILuM0Xtks3PQCe7hC2Ay+VCu39/DW7uTt0IY4xDgD/7tDSY6AANV0yhbVw
         H3hLTdBsYxirVkdKpgjWWqQkufgFhYz5sO+cw/xIyBvwOrQyYHHg+wegV4sFZ5iF/tSa
         hzU1dekQ9nEVf+eKeI7kZxTl0bSdqucO7yxdlL71VqadiLPPs2QQRltSzCyUzAdbuDmC
         o9JBo/7VKUKHoKpeQuveCynQ+nf7s2reKvS8V41kOmYgCdk1pOSPjq/G1MdTPOrfRw/F
         MxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8TK8VyW0AFSaPC0CCVTpEdBGJ1tqeiIwT/qMC7Or03KLWvbZ74F3dHqaEU7CkpowOjVPLofv16zuXxeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwE4oTyZHh0hQJNIe+eiBYvYktVJQY25wv2JQ7lkckMKXcT+t
	xQr7QoKDy2EOIkaLwQ8Vv02HvKiy5tG+e25oMqUDcGr3W5ac9uoQtJsx6+Lhe2c=
X-Gm-Gg: ASbGncvCadPyJ52UH48YdPSUMEbs/QhRCU1kvU16TsnGpb04uZr8BRrXDZDfgz1iVVk
	kfkIKTirBgX0stifUOvtVu3mwtMNqIOa7zkYFl7xIs9pyiTsfhIw+ivi2Ej76jqaUIE9uxvzipr
	ELB78K2/eCG97HJIZz/TORVF65Pk2XOEodiHvAqNVVVhDjvwyCai8vk1W6rzDzT5LBUfjyLJ1n1
	CD9zsA06OTb8QudOyNJla/ntexi+nLRi9Vz6KA5PJNCem3Gy+UmxESyvOrycU/2duK3ZQYyZ2UG
	oWaoZqT2c+8AzzuKsYli
X-Google-Smtp-Source: AGHT+IHLQqfTE6S33rXaKex6v5/nL8RuEZqh0jZ1l97VEOxPKBfxg+FVj8Clw/rAjJE+bNggu1IJ0w==
X-Received: by 2002:a17:902:dacb:b0:216:6590:d477 with SMTP id d9443c01a7336-21778397962mr36786945ad.2.1733984453430;
        Wed, 11 Dec 2024 22:20:53 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c278668sm83579165ad.81.2024.12.11.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:20:53 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	dianders@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v5 0/4] arm64: dts: mediatek: Add MT8186 Chinchou
Date: Thu, 12 Dec 2024 14:20:42 +0800
Message-Id: <20241212062046.22509-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is v5 of the MT8186 Chromebook device tree series to support
MT8186 chinchou platform. It is based on the "corsola" design.
It includes chinchou and chinchou360, including LTE, stylus,
touchscreen combinations.

Changes in v5:
- move sku17 here to keep alphabetical order.
- do not use the MTK_DRIVE_xxx definitions.
- Modify exton to extcon
- Link to v4: https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com/

Changes in v4:
- modify 'rt1019p_pins_default' to 'speaker_codec_pins_default'
- Move usbc_extcon out of typec
- Link to v3: https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com/

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
  arm64: dts: mediatek: Add extcon node for DP bridge
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


