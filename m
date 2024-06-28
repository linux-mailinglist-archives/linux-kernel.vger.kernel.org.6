Return-Path: <linux-kernel+bounces-234657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2C91C923
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23F61C22FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E68383CDE;
	Fri, 28 Jun 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5FEurIC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142582499
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614112; cv=none; b=JgfH2JeE24pimkOiWvcAoHkl5XbdhLlHruWOsi+dwwU43a+RGcfrrJQUfw0ZeAqhzl/HN8MyX9Y32LnuuhWgipfQksE46QD9xt6/bNpKGa3VcNh8TcDfz2YM9gkvdFa5yeixDgomlhl7SxOYuvWMvtfTHSMOBunjNnTQOp58uaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614112; c=relaxed/simple;
	bh=5z39nspdCFa1waOp1np3+7VoVXwA4cwuinPBbzvRnSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7xQnPjJAGrQ0uVoH0Td+gKbViWlnnZRQ16ORxbAE5AvZoCP3IZslnTLA5UIOkLr7nPoEgobx3b/ua9xXUrgOwZAWldAPGFr89R2VcF8OzHDw2q94n49rlKnDkrXu5WrFByANzpM7+08mpfGBudtR1i9g4z3EzNuaexSREDJFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5FEurIC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42574064b16so5081305e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719614109; x=1720218909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1FJMdQVhtsVTBsP1IuwFsjq71hMcyI7HyXkWpIvov0=;
        b=E5FEurICSpySN4RvIt21tdZEwOtLgGPfoEjmxqHd3uDEqsYrp1yQim7hS5V8QBrSVh
         /nheAvZ5T6LL1jx+EtuByb7QNnVek3hamlw3S7mDjP12t5lkzGF9qSrsJOaI2dspRadL
         9m/7LL2lp34mYqe04Fm+v5e6tyXWHbUrFQ6aClAxSiZaVFEL9rqUsP75T6mHJLAA6ZBo
         gqObSkMn9Q8AAxzkZvF2yQ+K8pjnYZKrxQfbhsXMqiDR72jkCBo28vMAm/yzWSgLCZc1
         mMpRiRNGr45A4sq8MJ6w+Y2YZldTJjTcocozMHLmAaylKemvBmX0tJfvx84NMTzvcZE6
         +I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719614109; x=1720218909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1FJMdQVhtsVTBsP1IuwFsjq71hMcyI7HyXkWpIvov0=;
        b=Zq/B1Emnd9F3mREk2UGVyx4xLZ3wk+qrCvQO6IK/n0fgUrsdmy7mDXmfRJ7bU6nRdv
         0N+pH3LiRaLBLLApP2amLwMbxNNv9DsLy42LvTeTaBv4VumlNW/1iVkdiHNxnW53lgjC
         vu0e9EJydWT7KtKsms4lEPuC3gAaEBvk7HDXIuUF49tgbgy7dnmoeHzQCYNLpLZ4MmYV
         4jGP8gcFBVqtt/w4PvNeLC8zy+fC/M0N/ARW032CFQdhQR4QhyGOvU5cVlvuO8ev23Nb
         7U1kJvweHLJMdIAJ62TAop63+BWPGWJ/kNgcuwq0+1jgfN4ptcNgz6Mcwa7l11aWunNT
         VmeA==
X-Forwarded-Encrypted: i=1; AJvYcCXymV0oxpFTg/ObPNDSgc3eXW7p+I45asYiBjRe4TDVRRCwHgpMkDfU3WWPLg17V+RiVQriGgCpPatJMTezeuyJaR0hCGn3IhuZ7lxA
X-Gm-Message-State: AOJu0YwKO93v8MfC6s+gGjMi9R7/OM7qwgPM/3+5sv9hYtbia6OxQiCi
	imhWQe/bl1yKpiRpLvMk1TI6r2zJqDFY+uKvWGkIk+sXe5oFy9VKHGZO+UxebmY=
X-Google-Smtp-Source: AGHT+IGSqJzC8Dv0ZKSrTzp5xhhumx6Iv2B0brr3AvE+VbFcW5m/di04oRuZDZW7DCMVkBqggSlS2Q==
X-Received: by 2002:a05:6000:1448:b0:367:4e17:3ed0 with SMTP id ffacd0b85a97d-3674e17400bmr4705520f8f.64.1719614109349;
        Fri, 28 Jun 2024 15:35:09 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm3496711f8f.0.2024.06.28.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:35:08 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/3] Add syscon-reboot and syscon-poweroff support for gs101/Pixel 6
Date: Fri, 28 Jun 2024 23:35:02 +0100
Message-ID: <20240628223506.1237523-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

This series adds support for syscon-reboot and syscon-poweroff to gs101/Oriole.
It has been tested with reboot and poweroff commands respectively.

Note the syscon-reboot/poweroff has *runtime* dependencies on the exynos-pmu
and clk-gs101 patches in this series, as well as [1] which was just queued by
Lee. As you are the maintainer for exynos-pmu and samsung clock drivers I've
included those patches in this series.

For the moment I have left out syscon-reboot-mode dt node as whilst it uses the
same SYSIP_DAT0 register as exynosautov9, and setting this the reboot mode is
correctly reported in the Pixel bootloader. The bootloader is also checking a
scratch register in max77779 chip that isn't currently enabled upstream, and
thus the bootloader doesn't actually enter fastboot.

Kind regards,

Peter

[1] https://lore.kernel.org/linux-arm-kernel/20240621115544.1655458-1-peter.griffin@linaro.org/

Changes in v2:
 - Move PMUALIVE_MASK check into tensor_is_atomic() (William)
 - Collect up tags
 - rebase onto next-20240628

Peter Griffin (3):
  arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot nodes
  soc: samsung: exynos-pmu: add support for PMU_ALIVE non atomic
    registers
  clk: samsung: gs101: mark gout_hsi2_ufs_embd_i_clk_unipro as critical

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 15 +++++++++++++++
 drivers/clk/samsung/clk-gs101.c              |  2 +-
 drivers/soc/samsung/exynos-pmu.c             | 16 ++++++++++++++--
 include/linux/soc/samsung/exynos-regs-pmu.h  |  4 ++++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


