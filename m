Return-Path: <linux-kernel+bounces-204488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC18FEFB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6771F23BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCA19D07B;
	Thu,  6 Jun 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agJQkNzP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD51974F3;
	Thu,  6 Jun 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684649; cv=none; b=oimHg8hAEU40JqtCfvyHgpHhNwwkmuGbc/DyRHgqzFTzLedahRVVosawHExLORkDbfqtVojLUHqOoVsHoAa2NPwSeeXb9+dSCsL6bwxxjueA67lN1iAe5cSau6SdAbuExbDBS9wHBHCm1QmXxsv9Uygpb2Rl4jJnvGl0WN1ki6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684649; c=relaxed/simple;
	bh=8mMm3AqayXzUESgTdJ1XdJ48K/H9kxzWYjTpfdB4MBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMQw4a0IjMOMRnsDt+e+JQ9tNA1WjvNAKd9OUUpQgMdqin2kvrMhZS1L7tnRRH2g7eBuF3E47onzqhXppKwcJWSlQdKwJ7zlnzfmB4on5ITy+sYZdcg2WRYCqEiDuXSIGMSkoqswVYI0Ynl0PX/fmcKZSLqZxzrBCu5BOvB8GHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agJQkNzP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a85cc2d96so1313636a12.2;
        Thu, 06 Jun 2024 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684646; x=1718289446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQPdfmgPChtjBlPSUXP3XdJ6QoXKWpgusRBHic1ZZbo=;
        b=agJQkNzPtGjTTFW7rAc9NSfNJcOhWUntCJrNOYx0kHbqv9hE3vjFbKQvvRYIi5pHJf
         6s4km+f0c/U6/SgopQiBfzgpZMNpNNjqQUGqyOf0TsmkMw8Pkhtd+JbgB5VPsBuO81n+
         mS2rL0Z6gw/CPdixN5CYe73wX0dMAui6gB+//+2qfSvzTh5WKHWcZzbScdSVFZTw8KJY
         bZGu/PDN9pMjYawaiTDqkv/U8unjRdui+DlHk3TEHu8+bKtOFRokPZgWIMjpi9yoPoKG
         dxZD7NCRnJreyOhUID981Hs4GRUTpeI7ym3pnSUaxvUuRDA0l3Z+uDWgUaOUbelQyivv
         uW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684646; x=1718289446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQPdfmgPChtjBlPSUXP3XdJ6QoXKWpgusRBHic1ZZbo=;
        b=b6ESNdAZ5wme4XvSxUAq3LslDiJWOJXBZ1joEwbx9PZ9Tz2pbla4+W2MN4sRkwIhnZ
         Q9A2plWaOtZlkHtVjXiQJxDnfHJIUqibbBu7Na/vx7EBnRGam5mwxx00u9IYuDvaiINk
         Z6I9MhPxkpQsGYp8gKpPdKHH474wFuBWAgZW6xVnDhXlNPoVnpNGDOyf2P9acnWWX/TT
         2xXZot9MwKKu178KA/NsXy+rn/VZZVfGso0wOQj3ZqzFEN1kyut1GS4Xy3hMRs/mD7ds
         0nPlyYHSigWcaKKrDVYdYc/JNq5zfe1V7TraV1j4tP3yDsqyENc4dC8fTi00ZIKbwsF8
         2faQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ch1qNy5AFFePSrIj6TIK2yg4b2lxZCNw0l7yhM5g7X3+Vm9wSfrRVeeIkzNDBxoMLXUeRcDSLSGeLMnl5DcAdti5DhFw6eTr23PI0cGjESFhGlsmCLShlplZhFLcukiZ1kEF2oPlql+U+of7Ry2IdGI9nJeI4v7p6rT+mGvBi4C7wg==
X-Gm-Message-State: AOJu0Yzp580XNJkTkIufIVZmzGt4xvQAvOVAVnuBeQrTRk7/PX5nTmbn
	Yala/uMpRNuXcbvpDr/lGx8ARmwj55le6LBcneSu+DkERoZfgOI=
X-Google-Smtp-Source: AGHT+IHNL5yo/Bdpu8nBzCloyRZW3BrEOgVM80xio31mispBtwt0CtqJWneNcLyY0SGGgTvqC7aD1A==
X-Received: by 2002:a50:f61d:0:b0:57a:2d01:13cc with SMTP id 4fb4d7f45d1cf-57a8bccb52fmr3586977a12.39.1717684646306;
        Thu, 06 Jun 2024 07:37:26 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1008adsm1190925a12.38.2024.06.06.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:37:25 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Add SFC support for RK3128
Date: Thu,  6 Jun 2024 16:33:57 +0200
Message-ID: <20240606143401.32454-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Serial Flash Controller (SFC) found in
RK3128 SoCs. The existing driver can be used as-is.

As without using some "id holes" we would run out clock ids when adding the
additional SFC AHB clock in the binding and would have to touch the ABI, I
added patches which remove the CLK_NR_CLKS macro and use the recently
introduced rockchip_clk_find_max_clk_id helper instead to find the highest
clock id.

changes since v1:
 - added patches to remove CLK_NR_CLKS (Conor)

Link to v1:
https://lore.kernel.org/all/20240605172154.193047-1-knaerzche@gmail.com/

changes since v2:
 - collect acks for the dt-bindings patches
 - fixed pinmux settings for chipselect pincontrols

Link to (the messed version of) v2:
https://lore.kernel.org/all/20240605205209.232005-1-knaerzche@gmail.com/

Alex Bee (5):
  clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
  dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
  dt-bindings: clock: rk3128: Add HCLK_SFC
  clk: rockchip: Add HCLK_SFC for RK3128
  ARM: dts: rockchip: Add SFC for RK3128

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 35 ++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c      | 21 +++++++++++++---
 include/dt-bindings/clock/rk3128-cru.h |  3 +--
 3 files changed, 53 insertions(+), 6 deletions(-)


base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
-- 
2.45.2


