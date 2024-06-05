Return-Path: <linux-kernel+bounces-202970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5DE8FD3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89BE1C2333C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2213A3EE;
	Wed,  5 Jun 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/6/i43G"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E7137C37;
	Wed,  5 Jun 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608119; cv=none; b=VpV4iabz6tFaSCnDn4mH+TsgewRDKMWhVpjgKTSDZt09HWh9RAPkdRn+S1NJ045/sp56Ipx5QCeZfUNGAfuByiK51WKKaCpGJPDmUR6Mu23DNyTEOh8Bjmzv0HTV06Xo/UwNbIlNpl6s6ZUovXX7jaxi0AmaEiPm8h9S5t/PMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608119; c=relaxed/simple;
	bh=VHEWvNpiMJUJgsAQ5e3aM/zfUCwh4EHcQgGAZaWwRl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPpSXdeGpbIftIheWOsumJYt1SbEJtHuu4sUguUdjsani1u94Kz43xHD4S0G1LV2hrdAiKfGVRkjzvhB58mA3Wdn5yZ2k6vYhDIQQB5a6giZW9fL0Zsue4ZXa350T8cadmQoQ6Nt2e/+myew8ND8JNE2emRoHHkecHrxZFuaErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/6/i43G; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaccc0979cso554511fa.3;
        Wed, 05 Jun 2024 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608116; x=1718212916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8glBAflWGPxyQzSe6ZrKekZDJ1XPYC0j6Piv/TsYko=;
        b=S/6/i43GJO1RlUQK70VPxo9Ffx/Q8Amw9QhkAkhdhz1hVWjncuvtYN+2QCZe4QUeNx
         Cz/e2f/1QcSMR9ac3parUK+ZQgY2EwhmRcoWw8s3RawtBk7J/nUpJPEbgo2zzPKxwaMe
         fb202XnAW0K5TrMkhcMUCVCyty8REHNCDYzRY9kqBHexefQkaxrYwRpe/aBuYo1mm9LL
         KP5SFDh4q8A5JRSfpNDuV1aQcXtb1gEoYmijA5YCVmhLay4a82pm3fuVkcDw9MHFeZnN
         WdItrS/iOZQE004FgUGxaXQLnrx87Lo1qzIt9G6qk56XQCPtZJxS8KgHKVMM8xdJZCWQ
         khtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608116; x=1718212916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8glBAflWGPxyQzSe6ZrKekZDJ1XPYC0j6Piv/TsYko=;
        b=q+909UM6MPtqk+08Gy2oCvsXGexQv5+vaMShgdAsV9lNleZDdb2CGV3VOXrHaKb6Mq
         TfUoxPVZaHyvz1x+sKTEvSAUNg/MEFUW+vJazV57Yv3lzhtHa5z8mJj1LuDfPMM1Pa3p
         YCvKbH+Zgl8Ab+4TX9lsO2wck0vhz/pxm/KvXtXWvTSKdvvBW8YfR4wCujCAX47OBQp/
         Y9rYPOKf7lrQuGJGgE2MF8wBiZs97aGMP1C4eZg1QksvlSDuXP/G/jCp6zq7X5X3Vl62
         6mb+BEWn+ofhbhiKUrc0LEbP8KhgrfTzypVfbBlcoCCzqJN+2kI9KlKykQk1xEFcgsjE
         l5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVw+hq0tTU2eRY2rimpW7zMhRgjRAn+aP0LlJcODkyMA+BEz4neIAQbAkqrO3jw8uKQ6x3oHp4DE4qC2EvdIk7LTs53WpJWVXaYXkkJQbzFOyhNiAUdqlh+gQzy3PdroriwP38Ix3Oi5OZmxiwvZZNhyO4sjNgDFK27CV2TvQpmvXI0ow==
X-Gm-Message-State: AOJu0YxYI2HAxIm4HKGrQurtEo6wqXBkDYb/O9zGxo2FsxSEGE0+QuE3
	goH3btrVoJ4cnCrZOCytecjd/uPtbT9kS7mkpVGKHRROx4ShhaI=
X-Google-Smtp-Source: AGHT+IG6Yr4exGBFMy0IEqN7rexShi+4lRW6cG85bsBwhPAXk4YCTWoySewvAl8hcezOj1tu9mIW6Q==
X-Received: by 2002:a05:6512:224c:b0:52a:9db1:9d7a with SMTP id 2adb3069b0e04-52bab50944emr2612149e87.58.1717608116135;
        Wed, 05 Jun 2024 10:21:56 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:34f:df25:1c86:f2e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d594sm9666663a12.69.2024.06.05.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:21:55 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 0/3] Add SFC support for RK3128
Date: Wed,  5 Jun 2024 19:21:51 +0200
Message-ID: <20240605172154.193047-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Serial Flash Controller (SFC) found in
RK3128 SoCs.

The existing driver can be used as-is.

Alex Bee (3):
  dt-bindings: clock: rk3128: Add HCLK_SFC
  clk: rockchip: Add HCLK_SFC for RK3128
  ARM: dts: rockchip: Add SFC for RK3128

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 35 ++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c      |  1 +
 include/dt-bindings/clock/rk3128-cru.h |  1 +
 3 files changed, 37 insertions(+)


base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
-- 
2.45.2


