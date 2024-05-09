Return-Path: <linux-kernel+bounces-174564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400748C10CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D13B21E82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445715D5B3;
	Thu,  9 May 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBnmRBeg"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7012E1F6;
	Thu,  9 May 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263492; cv=none; b=IOnhzh+GYOuuugjFVu5NWK1SEKJ89IAcf9JNTL69iZIRTomHl8saHXqcAqiXGCGOD0s9RnQWW+/Uu12qLZ9RQ0k3GS33OI7wcGyqZCRM464c4dFczDGdjp/QrZJ+TVRY5W8qIUwPPYtdxP9tnO6mRxcPmiYplKhKjrz4R9Bi/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263492; c=relaxed/simple;
	bh=cOoaeffNqgYSpa66yVAcVPa2PM0favsqNw+tl7uH6GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flBXfVzbq06iOhtLOvhHH04H8bDc/ozgk/wXD1PgEv0FX+BAmyNGOR8oSraou9Sg5sKFrE+ss/+az+bYebFmqNjCdJsBttE10zQLZ//JGVbNi287Ly1TLnR8VoeZuk5bW59EqTyC/9IplI5DfjKnE/zUYGGcFXNyi8kuHqybKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBnmRBeg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34f52fc2191so529422f8f.1;
        Thu, 09 May 2024 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263489; x=1715868289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygKOaLULm9Ty8/azGUq2u8NIEd5rcobuUSoqUbVVSBY=;
        b=nBnmRBegxuJEtxUjkbR8RZJ5HqFZo/E756GMakCdylRJnYgsFrCUp8+xIpk0rV0mtO
         IgFkLar9itDDAmr4/EQfXrwrzR4TRBmx6whxK89/dSh8DPE1Vp/WmDmi91P44pr24hJ4
         a565vNgvkoutxX1YQ9i6XfnUCxDnSs48qxwQ7rQxmGPtia70qpBDv0pj1ZMo10iDsMgJ
         vv0JfJg4H263wK0AWxjI/PDJg2ZfuDJ3xGrgrq7j+CMxMVgl4mV6cHFuHS4zO9tFH9U8
         8avOiv9rkk47Xsjqg7IEgZ2XajyOm7Kfq/ocU7jXAL24QmV1Saz/w3Cqv8qe4le7yVNi
         WQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263489; x=1715868289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygKOaLULm9Ty8/azGUq2u8NIEd5rcobuUSoqUbVVSBY=;
        b=ozUK82hVLjoY7zQLgm5OeIPuhzGgQNjm0hA4QqYh5dx7YzP+UeZ2kEEV5URGYRDLNZ
         ukl2qypa9BrTCr4mFvJS6WX6OVIxBNUrJSFsRu/H3NRasRvhbOVXeOmZaZTIl4enn3wA
         Eb0xcKNi+f9sYTJRv8xh7OzV4ghIE9OBY2Xb9T/xkEMdwi+1xse3OmoClg6zTYUtso1Q
         5vvOom6yqd17drAxbwHX/Y3qcJsAdOUADYhUhtoPhNTHc6LMThgnUKyBfSaX9qCxHL9S
         Sm2C6TJxrFgJJ3wsQpzCOgdvm6R3Yr9IJfTXziKcbsqX4xkSv176piSAWh0yY5Y2cjca
         kh1w==
X-Forwarded-Encrypted: i=1; AJvYcCWgbTs+0ZmDKYp/SKcP+HCuVwgT0YAnUtSsY0ikbGvu/iDiMOvLsYypS4fBQUhJQ5015vVjRy8im5tNVj6IFK3Mmgtuc5pFMHI8B97lAvOsE+tlFjpJFxSgNY5whnn/9kRlKRvBJndYv48ciAb0HHPzKe/lCyCk/8xrQb2ERhycJQk5bg==
X-Gm-Message-State: AOJu0YwZsFveudyGdXYaqYWNXC5FwM+yTruhWkyzxBt4tXQvMHjpkQjB
	HtDvYS262IUqyQLbks31QRG6uNReGu3geEkIh+wD1ixyqq6daPw=
X-Google-Smtp-Source: AGHT+IGJQUoq4KBpZVLF1jIA/JtqfJbPLkQQBLMgSeQVY1xajdJgFURlR2LWCEqpPMRCfEMg1QA8dQ==
X-Received: by 2002:a5d:6e55:0:b0:34a:3f3d:bb14 with SMTP id ffacd0b85a97d-34fca242709mr3566295f8f.27.1715263489393;
        Thu, 09 May 2024 07:04:49 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a29sm1788467f8f.43.2024.05.09.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:04:48 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 0/7] Add DSI support for RK3128
Date: Thu,  9 May 2024 16:04:32 +0200
Message-ID: <20240509140438.168429-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for the DesignWare MIPI DSI controller and
the Innoslicon D-PHY found in RK3128 SoCs. The code additions are rather
tiny: It only need some code in the Rockchip dw-mipi-dsi glue layer for
this SoC and do some changes in the SoC's clock driver. Support for the phy
was already added when the Innosilicon D-PHY driver was initially
submitted. I tested it with a 800x1280 DSI panel where all 4 lanes that are
supported are used.

changes in v2:
  To improve power-efficiency when the DSI controller is not in use, I
  dropped the patch which made hclk_vio_h2p a critical clock and instead
  added support for an AHB clock to the DSI controller driver and updated
  the bindings and the addition to the SoC DT accordingly.

Link to v1:
https://lore.kernel.org/linux-kernel/20240506194343.282119-1-knaerzche@gmail.com/

changes in v3:
 Dropped the changes for the additional AHB clock for the DSI controller,
 as it's not part of the IP block. (Heiko)

Link to v2:
https://lore.kernel.org/linux-kernel/20240509120715.86694-1-knaerzche@gmail.com/

Please see individual patches for details about the changes.

Alex Bee (7):
  dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3128 DSI
  dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
  clk: rockchip: rk3128: Export PCLK_MIPIPHY
  clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
  drm/rockchip: dsi: Add support for RK3128
  ARM: dts: rockchip: Add D-PHY for RK3128
  ARM: dts: rockchip: Add DSI for RK3128

 .../rockchip/rockchip,dw-mipi-dsi.yaml        |  2 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi        | 50 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c             |  3 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 ++++++++
 include/dt-bindings/clock/rk3128-cru.h        |  1 +
 5 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.43.2


