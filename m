Return-Path: <linux-kernel+bounces-373580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A432D9A5910
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13F61C20C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC493C488;
	Mon, 21 Oct 2024 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="0wVUI1GW"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549B17C98
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479593; cv=none; b=cnkVnC8u4Ua7cEe3Al9fMK7T+4ujMLM74XNE+RTQlPKG3cUenqBjdWOKq6gC0bc8ypbvIgs4RjJF7WymKcNOWKQwGiWyALnZnz7XjCb6IR2aAofk1fYoPGqGA0GkEKV2z5uda0QbnZ7P6/PqC2qobhVmb/J2DhVkz6Jqq2lXZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479593; c=relaxed/simple;
	bh=7d387XbGv+JuPxcJAyDfP2Ybl78d5z+BX2IzPCKXLUg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tA9Rmc0lVm7omP88Dg0BbmA+ADg9PxzFP5VkYiEQBv1AyYGOsZOJ40sAqEMuWhgz2mXrxNk10798CITvqCtvDAdkHNhO5YxziHLBvTWuE2hUhg7IQI7CvX0D1rf6NfMVLve5/ZfFaRm1gyKqRcCQRSb7tumxLKUdWMFeKoYUARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=0wVUI1GW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso598614a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729479590; x=1730084390; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RuLV+gJE30OXtNyG+M95n2ScV6KSGMzKjcPSGYqH7I=;
        b=0wVUI1GWWBmTz68NhoZy3rzDN9BhUG/lpEy2bRdGaWqrM8H5DZYbH0BjadODgYof83
         JAsuliWeNYummx20HjZUNYX856QYlcfC6h4uqmTfMYjA4TZRWRlbOGwve37isPxHZ633
         JHmC6FrR38cwNkkAj+ou605wqma16NYnIGXpswIsTCKu8OJt1vExt/khguRFha6silEs
         1aqZW9meDK/Rq5AYaWkdHa4bge0SzkeJnhoJZRGX1HMETdbdBJeXgJg5aA65bf0xdK1h
         303/dp3pRSjVr7v3irPrEOyKzjRL1H/oAQDyeXR84bhkLPezujtOtrFMnjhu3B/V5Qlv
         tjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729479590; x=1730084390;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RuLV+gJE30OXtNyG+M95n2ScV6KSGMzKjcPSGYqH7I=;
        b=pzjx/Msf1a1FlZ8UeVgubwthbICUV68D4EB3tWDM8UUOWT3/MFkGlwNcSRQBUUBrGr
         S8O0paPsFF7fx4SvzRvNaCBObaP0AC6lgjM/z1j9OBZEKDsMA+Emy0v6X2f+MH72OS9N
         YXSJTkJ0uYKf1t1Y+REZewmWkM6+opiOMijusYZCSpS2hyQcwScueTtVxodpWefk4oLV
         pdN94kK9NWN6wsofP3O5jo1XQTcFMbt1W7hpqF35b4rS92dgPlQutwqd3CF8NjrjlDmk
         xabtCk5Xh3hPSQYOm+NsWinlKMCMvef74kcqG8ZSbFQP9lTvY5rYlCEBpIfHazgN0qpf
         g3kA==
X-Forwarded-Encrypted: i=1; AJvYcCXmHFZ74H/F+adpLxUFzvh8JCI3dGHHCMWtR+atvLqpFmDV21xnVQI80oLu9JNMXXwz7ZlDLPx2SrW2FyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40R/UbzCP/viBQ4ohJXFgtq60nA2nuJuEskV/VRAE0nlHn+38
	LwB4HDJcbNIBC24VsUGCVtfpHBYvQiVkEaIxSZlXChb6kzSw9Mab7jOhnlD+epM=
X-Google-Smtp-Source: AGHT+IEeMhO6fUKVIbKTf4VnCOrvoZB22wDG7bl6QGgOlpgFEmq4KFG93SWLtdJkWZFjghfjiEZPNg==
X-Received: by 2002:a05:6a21:33aa:b0:1cf:2be2:668c with SMTP id adf61e73a8af0-1d92c58dc9amr6387836637.12.1729479590211;
        Sun, 20 Oct 2024 19:59:50 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313fb5sm1815601b3a.7.2024.10.20.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 19:59:50 -0700 (PDT)
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
Subject: [PATCH v3 0/4] arm64: dts: mediatek: Add MT8186 Chinchou
Date: Mon, 21 Oct 2024 10:59:34 +0800
Message-Id: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
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


