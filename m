Return-Path: <linux-kernel+bounces-301972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7EE95F826
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CE41C223D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E431991B8;
	Mon, 26 Aug 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="msJAr3GR"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64C4D8BB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693484; cv=none; b=IXLXxQ3TEEPY3yHtmAI299tiU8Hrg98bdpAu5+C+ilObFSL7tcnLP5oyN9c+OceH2sxISyJpnQiqFlqVqmzdUmFU+taRt/SzQQgJhEWibaZYEzTbDlqx4QH2onSn3KUpu+EgAMR/V5AD2XOCWNftoiwQiGNwb/jHDwdhCcnIv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693484; c=relaxed/simple;
	bh=6EPFMstT17CvrhQmN+sTCcfEDbYVO1ZcIZ5xV/q7u8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h6V7KBGgT+n6E+ADeAKPMu6QJ6vZgJWdGRwCwCPIQJrQvlm3oXfNRbdOamK7+AEcQvbBWJWnY6kDV9jELoQl3OCado5ucHiTS7HuNOTrpxwK2TW8kLbYLo946ZSi5l0sea+kKpj0ykJFVgiRu1ByVfY6bF5ZlUTysqzzV+ihYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=msJAr3GR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86a0b5513aso355972366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724693480; x=1725298280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdCwGFBcrT49Pisvj9J9Vzn1hnXxwd5sYiWDmNdzZNY=;
        b=msJAr3GRGYUMaWcgdjt5pyn+MMulnA1u8Zx1aFI0cjigMc6jppHun9oIeB1M72FxA3
         7Vqm3xz3AV0lQNqvW+AyyTxgrV6waJF4/Vc1VLD7+mgrRDsagHfesh3hINNMVBFmQE11
         gdYEPUbqcCDXsuQ/3a0hSJVxhZeHOT2N0a3RI6kuP43CV8AHS7oUkPeg7lb7wlhqk+3i
         MpYGJ8ppUD2VJQWRrZC6C1yDee6LcsQupAI1u6cGAqk7CPRKUdVdaReyttXqFL3USSmH
         iOxo8Cz+XDGzPunbyE1yIHdHssCn1BlJ3xyqnJnHHcAfaR8FXxqdYJ8bXYnpx15JwGja
         We+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693480; x=1725298280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdCwGFBcrT49Pisvj9J9Vzn1hnXxwd5sYiWDmNdzZNY=;
        b=czsol9UolS3I96Pmf4MoyBZY3/geJ7HGVw1wZrOVFrF/GeG6jPsT3tFU05owTD64Cf
         dUQlUcxe+lIkHWJU7bxgFANwJZKcJR3dfWLAV9sr8spR7xgMPxLD4/jMgbMrjDaTOcz9
         A3RXxkb8NGVl0fZgPxNoyqO3CXAz2L9wE0geyVHah698mhmOK6vjc3AAVeXzAmlyYTJA
         8y9DvsqhWcMK7pQKQ+KjvpV0jCW2WM97tyczcjxxsYIKjB4/QKKcK3oDIXT/A09jcbj0
         lqSPgOSSOm+iK71VEREM5pZFhnJN65s2Cng9y6QLxlxMKljNjDOSnUbA5hYP3Ts5+hOX
         0czg==
X-Forwarded-Encrypted: i=1; AJvYcCWnQfA/zVIF++eJTl0t3GgyNQQr1CjuSt0GVypKSt6H21E89aXB+wQ3AdwPP8QaIoU+mGS8DVH+bU950mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzifjez8JjUGe5Qzaj10xpkWh0xVYbMggR0S2q6gfJ9lofdEb0H
	DYdzeqBQkKOpc4lzn90HitsHA6hwXB9XLgLrJAk6Lu9apyIKNqTMiD6nWLtXMFY=
X-Google-Smtp-Source: AGHT+IERD9TGRmX/KhvrCUArHMw9rId0+3mqlQ6S+/Jy+Jl7phDihtOezbZJke0mH4gTsLm+tymTWw==
X-Received: by 2002:a17:907:1c0a:b0:a86:a90f:3025 with SMTP id a640c23a62f3a-a86a90f3de8mr781015166b.59.1724693480118;
        Mon, 26 Aug 2024 10:31:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548781csm446566b.28.2024.08.26.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:31:19 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 0/3] clk: at91: sckc: Add macros for the slow clock
Date: Mon, 26 Aug 2024 20:31:13 +0300
Message-Id: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Previously raw numbers were used for the clocks generated by the slow
clock controller. This generated confusion and wrong IDs were used on
device tree. To make it simpler and less error-prone series add IDs.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  dt-bindings: clk: at91: Add clock IDs for the slow clock controller
  clk: at91: sckc: Use SCKC_{TD, MD}_SLCK IDs for clk32k clocks
  ARM: dts: microchip: Use SCKC_{TD, MD}_SLCK IDs for clk32k clocks

 arch/arm/boot/dts/microchip/sam9x60.dtsi | 18 +++++++++---------
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 ++++++++--------
 drivers/clk/at91/sckc.c                  | 24 +++++++++++++-----------
 include/dt-bindings/clock/at91.h         |  4 ++++
 4 files changed, 34 insertions(+), 28 deletions(-)

-- 
2.39.2


