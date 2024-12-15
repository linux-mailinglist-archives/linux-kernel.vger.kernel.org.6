Return-Path: <linux-kernel+bounces-446302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839FF9F224E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9A91660E7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8B18AE2;
	Sun, 15 Dec 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUB50UrG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80217BA2;
	Sun, 15 Dec 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734241019; cv=none; b=WWk8BT5Gfz6nEiz3MDPTeVfdACkIHeTaPw3FxP4hg8Kh8bri2kePv/UrXaM0BoelR7cFOBd2vglyZPlP3xLp0LxxoMrcgSma9d17nJ/1wstM38747MPFRzmb6Ri5b5fvK+9zxQp/cXPVdpDVhuCe2JgKl5oounBtSFWrQwUsLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734241019; c=relaxed/simple;
	bh=tm2ZBhzuEFEoW3o28d+5TOHGvceka3GHwCO5JinxcNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=So/E+kZVuQFlhUxQjdy0x7hctnN57WP/nnIStyz10DN3Zqde7RDiFg/fb1O3Q7jyOc9Zfs7+Ngl2mXY+sr/+9FkhJbkT6ErV0UBqzx5fiSqSbzqpL9pWWTG/6bn9axEN4TucUjV7nNxCeu7RYI2yiHeTvuQVF14mWMRYU9/S+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUB50UrG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso20274855ad.2;
        Sat, 14 Dec 2024 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734241017; x=1734845817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5T7Xps2U+Xbtct6WpNh1Ms/jHQH/Zy0/yiacfJI6eY8=;
        b=bUB50UrGv2NKbTPlNElauaAA6+CWNPtSkE+pjC8hoM77ttaldi1kTYyFdV1nEFmbYr
         v/LStV28ymKc1+pbV12E13MpIdgSc5YNkqwxprFzDfw7GVh3DGYYWZGelbx4kPIgHgVR
         zuRPxPYZXuEMIVA92P5EkMKD826jBX3J9i+P+58M/Go4sY2q3owJGVESs71ELF+8cuSz
         BQPV5HTkHxelHKJfQnmAgYghT1tAmKhFwILcoYnOS9RFRoH6gWBXyxQw+fNSsdE6QoAA
         160A4pT2nS/DK3A9P6tLuHSD4ZVPie/9o/5VkauBts5BjGPYZJL6+ee4yTmA0xPiRcQ8
         uCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734241017; x=1734845817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5T7Xps2U+Xbtct6WpNh1Ms/jHQH/Zy0/yiacfJI6eY8=;
        b=PBwVivwnzTSkLQzmlfSi2G23Suk8sO/FkIn/+v8TwLHILWDDZsFAIiV7/zKRNRXxON
         8iKT1VipftcX0Mi0HYYtK2gN0zoDawyF5igCrZxDmfKAjnD/2ULoKsWhevZBVm3iS9K7
         BSZlYhrsF4ea7WdB4IJJhWilFgQDeO/+Di+yI+4z4nRKsmL2eXwiso0iBOkZdtcdcFm6
         iW4R2uGPft3kjYcKzIK5yRc4Ug52jqjP5L2ci/jenK8ZeoeSpayvFZ4/dv+lp/tHZIUO
         2O6MQlkPgJMnvYL69cdEsJpwR16dDBcrYb7DfOHtU3u+9d+QLAgXSh0ZmsljXcDZBgCX
         yrSg==
X-Forwarded-Encrypted: i=1; AJvYcCW34Y7GutyuklAwsmf3aOuxX5g4pU63tUHrgCJN076I3VE2tKtfkPmLF+bDXYcTNISEvAZ54339A67s@vger.kernel.org, AJvYcCX6fRfb3dZypPygZHY8UpWYQxwt+mDDR0+RF9ixOV8I3NkQ57U3zm5iyCpMQ0oEo2oQVkuAJpcbD61E@vger.kernel.org, AJvYcCXAYlaaVWTh5jJytvKpqXSsmA2iLMi1xktmy+G6DN9DDnGs4nXg4OoxlgV1hjeSzuquWeSfIId0a1fupMfm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6o6U+/leHQ++lmLnh3w8yEKzJZEU+OETM1bUf6Nei+p1d6tNk
	6JNt61VHRMQhUclticUaN6zRdewFY8Og2Iybl7Q4cCJ9EVAUEj80
X-Gm-Gg: ASbGncu3m1pgoRNbCvUUBOVQyQp+21Cs3Muh3CVzWnm6IOFurXwXbNdje2KDLEIOb+h
	cqa0ZLdfVNVquxiDPqWkNApOwPmBxgi5jtv/Q91ygZMe3jncOheZ4C+sWg/YU25uidvAJ4dCKVb
	/2ZpeNvygdXNKkGQ+FihQzJBWnw9eD2wQtTFU71dfQhVt5EVemVAT3opyBHvr2XBmkSfLWMt1P8
	ocFxCOiHFFD3Z5VkygU9sw/PP4zLhWhwPsJV8EYofr54d3PGw==
X-Google-Smtp-Source: AGHT+IFi1PPQSUOrCioA0Ut+2J5jgMJCNCDNT6STQp0qD6xWCc08BjaoFiUHYwBhtNmNrzFypeNIzA==
X-Received: by 2002:a17:902:e806:b0:20f:aee9:d8b8 with SMTP id d9443c01a7336-218929a248fmr95477575ad.20.1734241016960;
        Sat, 14 Dec 2024 21:36:56 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1cf8sm5729803a91.38.2024.12.14.21.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 21:36:56 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Roman Beranek <me@crly.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 0/3] arm64: allwinner: a64: fix video output on Pinebook
Date: Sat, 14 Dec 2024 21:34:56 -0800
Message-ID: <20241215053639.738890-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux"),
TCON0 clock parent is always set to PLL_MIPI, but unfortunately it breaks
video output on Pinebook.

I did an experiment: I manually configured PLL_MIPI and PLL_VIDEO0_2X
to the same clock rate and flipped the switch with devmem. Experiment clearly
showed that whenever PLL_MIPI is selected as TCON0 clock parent, the video
output stops working.

To fix the issue, I partially reverted mentioned commit and added explicit
TCON0 clock parent assignment to device tree. By default, it will be
PLL_MIPI, and the only users with RGB output - Pinebook and Teres-I will
override it in their dts.

Vasily Khoruzhick (3):
  dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
  arm64: dts: allwinner: a64: explicitly assign clock parent for TCON0
  clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as TCON0 parent

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts |  2 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  |  2 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         |  2 ++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c                 | 11 -----------
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h                 |  2 --
 include/dt-bindings/clock/sun50i-a64-ccu.h            |  2 ++
 6 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.47.1


