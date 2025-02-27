Return-Path: <linux-kernel+bounces-536087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B8A47B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F25A167D40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF11229B00;
	Thu, 27 Feb 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="R8kC9d33"
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B121324D;
	Thu, 27 Feb 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654284; cv=none; b=mUOM99Se/mmrnCZZ6v9dMsZP7S4JakqoVyIg1346bOIHHBYRhrwvw38QbLUItcBPB+mjZiQ9+0Z4qsIlPVTwB1oeKF/RGl4bJcxBWetK6l9NfqjfGP3kW5IKsIJPKrViLmfPpeKPKqPyvYWEpt3I75ReKvLxg6ahVGKa/pKUoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654284; c=relaxed/simple;
	bh=dfH6GSnNHaqbYIEQaNaTLyZpVSbGojCv77PSGmE0IOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlW6BxUL6nKvzADBVijd2WULAmEqfMtitdqb8sjiiACMxhVMGCLWNmQAvYfWlxvXPKx9Euh+RG2c3eaINarsrPtCyrYwqHDTxNPGIKYuaH8RxNk3CrVx0/YauuoXOMwsdhJKh2X7Ogh4aLnYvP06LW8XfzM50SnRNJXQL8dioNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=R8kC9d33; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id c6596a3c;
	Thu, 27 Feb 2025 18:59:24 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] rockchip: Add rk3562 clock support
Date: Thu, 27 Feb 2025 18:59:13 +0800
Message-Id: <20250227105916.2340856-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxoeVkxCHR4YTEtCSEtNH1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a95470fab6903afkunmc6596a3c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6Pio6KzIOQg0uAhpOOhc5
	LzcKCTpVSlVKTE9LTU5IQk1OQk1DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpITk83Bg++
DKIM-Signature:a=rsa-sha256;
	b=R8kC9d33Z9g4FYnESeaM5DTtFcaYpcAcra30dOEJFu4VTNO5NqvT0oPGH/4dvNmMoT0B9GLdB8Rhrvu6Op6MEU+5stY0nOLVGHwGM+lg9oYCoWTFmuD4JbdXBa/Fes+0PSlRoCTeQ2uUu4Br9H6H+q9hUNwvmKW2acI+s9gMnEk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VFwR9bSonAWb+2pGDDc10fYLnCw/mDANOeUPNgJEuBE=;
	h=date:mime-version:subject:message-id:from;


This patch set add cru driver for a new SoC rk3562, the SoC DT will be sent as
a separate patch set and the new compatible will be used in the DT.

Changes in v3:
- remove rk3562_cru_base and MODULE_ALIAS

Changes in v2:
- remove rockchip,grf info
- Update file license
- Update the reset ID with rst-rk3562.c
- remove CLK_NR_CLKS

Finley Xiao (1):
  clk: rockchip: Add clock controller for the RK3562

Kever Yang (1):
  dt-bindings: clock: Add RK3562 cru

 .../bindings/clock/rockchip,rk3562-cru.yaml   |   55 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rk3562.c             | 1108 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   40 +
 drivers/clk/rockchip/rst-rk3562.c             |  429 +++++++
 .../dt-bindings/clock/rockchip,rk3562-cru.h   |  379 ++++++
 .../dt-bindings/reset/rockchip,rk3562-cru.h   |  358 ++++++
 8 files changed, 2377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3562-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3562.c
 create mode 100644 drivers/clk/rockchip/rst-rk3562.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3562-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3562-cru.h

-- 
2.25.1


