Return-Path: <linux-kernel+bounces-304734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01796241F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B5B211D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D732C167D83;
	Wed, 28 Aug 2024 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrMiHS4w"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FF166312
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839005; cv=none; b=YVW45okgxYV/b+8HCnWwv2LvkiWRRizMojDv+OrLceg0HKByjxZ+JjqQIElDpWyXjQS1+gdylvySEYmJpnwq1819x3/FnKvn6Wr2e0Z8BUb9PwS9vmY1i4vA8qB3qSWmLOdJWJUv7jNxC/8QvDpCL9tOiib//8tSwdzPelgA5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839005; c=relaxed/simple;
	bh=/q8OT1FWSBwzCT//B0br1m39zEk9o8WylV6bm/hG5oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Insj0BjTIoZT3QNLwiTBcRLGIY9LImdA3bLg2Rcg7rZdNQRH+Pu0NeO+DjgFzePWja+V06ASKGx53RW4Do8QulAQhO3onnqO6Lj4WhKs+h5VQfAD4UvA1uKxzfXaWVJF/l6nbBzA0wZ+e0O8uaIPDzmnYwyLgR3wizF37tvWNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrMiHS4w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280772333eso9283135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724839002; x=1725443802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WSp6pvJuIICtYedmtvSJ2tIfRwNKUKk1n83ZQ3MQfA=;
        b=CrMiHS4w/8VZuXEyr41zRfequUJhkHFWVhqMMQEEBWcS9Jm2XMHR6LK4LroupvGCEA
         LMXYVmuKV32dNc/sxclW7nJu8aWx+8uHU79cdE1M3TJ5uNzZWY5h4JNX9GsY96A5kdaW
         ng/9mSiqdsSODASyZPTGjTSbNThn3SGR+lLeShENJH9rap2qQ5EDqRSdQiTWmmqINIuu
         yaseX99cu/47F3M7aya3vNBYkzpEElr5C/MrG9HyFMK90MYmr83ToQ0+8lXEe7Nnel/V
         vjZId53Wr46G01Dt/OyT4aT3Xarmh6D3Z53RdxMACdm4LrwLpKxQ89UiGEFpq1FYJ7zU
         dkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839002; x=1725443802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WSp6pvJuIICtYedmtvSJ2tIfRwNKUKk1n83ZQ3MQfA=;
        b=vtFTbt+vJXINMMKj5HkKf8XtVY2wh8TyLWs0om++KjzINyxVAbgOthE4BZLQNvPn+o
         v/iaIlpAA+5VNKGA7I9nSAK5ibinyb07mMloF4WAe67UdFPIbXPP2QcT2PVOmbOifcXP
         gi77eWR2kDT3tJPpip4envwXAVpY55tY9mv8Zz/phPxzwVHivP0AWEiJR/NxQ3Ujd3CM
         DVzc2bO4mRCkqaM6WKkWztRMUuwDYdC5oV5YJgTCwXVq8gwqQ9D+OnojAxnUmB9FMr0n
         RdPEPHhYXlTs+9UBJ6tOyTi2QxpWa/nc8XbFst+StdvHFG5lkfZvELmbIRuhQeLM68lP
         y2XA==
X-Forwarded-Encrypted: i=1; AJvYcCUb1G7yu5XihRUaDoAevLJOOud8wy75QldHQdx1mSVO1RPAAGX4UHhRX4pkXwmIiHr6Aj5Q2HMW921vEw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuv/0xz4a8PIcA09IrovpuPkx9pnADb+1mIyxiE82amVShkWY
	WjBjLW3hCyQKZc8twbEwCfFKdpeoCoNvd2cOwotPcJsVm59ZcLgNkOCLJ3bk1cY=
X-Google-Smtp-Source: AGHT+IF+144nf5k6UKXIDPS3oYva4FiN2THGmZe68YwifvRzugslieNG8gx/OXdLJ66KxDFPkZTvgg==
X-Received: by 2002:a05:600c:4445:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42acc8a55f3mr70266565e9.0.1724839001611;
        Wed, 28 Aug 2024 02:56:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb33sm15067077f8f.13.2024.08.28.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:56:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] ARM: dts: imx7: minor cleanups
Date: Wed, 28 Aug 2024 11:56:35 +0200
Message-ID: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Few simple cleanups. I will follow up with imx6 and others a bit later.

BR,
Krzysztof

Krzysztof Kozlowski (3):
  ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
  ARM: dts: imx7: align pin config nodes with bindings
  ARM: dts: imx7d-sdb: align pin config nodes with bindings

 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi   |   2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts |   4 +-
 arch/arm/boot/dts/nxp/imx/imx7d-pico.dtsi     |  20 +-
 .../boot/dts/nxp/imx/imx7d-remarkable2.dts    |   8 +-
 arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dts  |  30 +-
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       | 608 +++++++++---------
 arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts  |   2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts      |   4 +-
 8 files changed, 337 insertions(+), 341 deletions(-)

-- 
2.43.0


