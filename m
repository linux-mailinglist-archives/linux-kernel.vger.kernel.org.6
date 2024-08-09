Return-Path: <linux-kernel+bounces-280896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FAF94D096
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961F61F21948
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10E1194A53;
	Fri,  9 Aug 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="GOf9UHAI"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB51078F;
	Fri,  9 Aug 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208102; cv=pass; b=VlEQDzK1Iyg4u6tT0NAuq8OPMNTvkxfEwGjQ9GB9ZgvtLXbiMJyqbxRf8SNR3yGVrXqsCfBhvwJ1td2+88N2m0rwHUYiLW3c85McgI7aee2yXzWE4FLXYsPQkpn5crMXagQCxGwV8yN45qLXQBxL/xOJ8CwsOs+CMNZ3WuLmiLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208102; c=relaxed/simple;
	bh=vuK/wSTt4Tj6+STEkvSeOcZXI2f89msg+oGAU/iKNDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKKdesZIdpS3LPWpLE3MuvET+Mi8z+jmCnqEG1+vI5XleBWkvEbfVWmP3kSd7YYRxdk0ZWN0i4gpbbiE/9NmX1DKeLsLA9T+Bkn0xNo8eZ7BGcqvKmNzr57Ivz+hjoMmVcrn4JOl2+NGFLm4G4NM2rkILpopLRsIrdpj/JgfUMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=GOf9UHAI; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723208078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hzcr4twoVfrqvrlrD2GBTEFtuQdmL1ORTouXRssrH0k4v6ZWDr+TrY1WeRp0IJkd1klltjPF7r06oUzBZ9j6h2IEzwWusoOxkEbYmbmpOpAcH4Z9PRONdVA2Eopfi2o81+UiJFUSA6ikieV6/Cz19MRCi1OtyDEmwWaBylZXKHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723208078; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IVUh8m58sKRjRQsv42jlfzZauybp5FzG0mLkT/rScCU=; 
	b=a+9KIWU9Rj3nabk8FTYWVNA9RucvMHthSyO697gZh2IKu/NG2zST1dzrSoS3nqrmS693cvLmYcBn6jgSkj0k2Fqj/H8NWNnK7caKTgE6RzysF/44RGjIZH3qseewWprAjrsEXa7VZ922G9Rt98MVqUjWwrsVOvrsL0awkRQio0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723208078;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IVUh8m58sKRjRQsv42jlfzZauybp5FzG0mLkT/rScCU=;
	b=GOf9UHAIBQtxmkV810oYDqzrLY8+FYijBrCpxKOFER/Deget7xtmCqDT51xFFexc
	hTQvKjlG2GB7SNZalKbhGWGxV83nxBNpucKT47lSvuHQZqhdYLO8r+DWeKQHwlTGRYP
	lAB8BlZsdk434OYHWfjrHI6R8w5cuVPnMLgTHhx4=
Received: by mx.zohomail.com with SMTPS id 1723208075915710.5668583394234;
	Fri, 9 Aug 2024 05:54:35 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 0/3] Add CRU support for rk3576 SoC
Date: Fri,  9 Aug 2024 08:54:51 -0400
Message-ID: <20240809125553.3889-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for clocks and resets on the rk3576.
Patches from downstream have been squashed and rebased.

The resets have been renumbered without gaps and their actual register/bit
information is set in rst-rk3576.c as it has been done for rk3588.

Changes since v3
- Add missing include in bindings

Changes since v2:
- Renumber IDs from 0
- Commit clock header with clock bindings
- Add missing resets on sub-cores
- Add redundant fields in bindings

Changes since v1:
- Remove reset defines that are probably out of the main core
- Separate resets and clocks bindings
- Renumber the resets without gaps

Detlev.

Detlev Casanova (2):
  dt-bindings: reset: Add rk3576 reset definitions
  dt-bindings: clock: Add rk3576 clock definitions and documentation

Elaine Zhang (1):
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   84 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rk3576.c             | 1819 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   53 +
 drivers/clk/rockchip/rst-rk3576.c             |  652 ++++++
 .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 +++++
 8 files changed, 3772 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

-- 
2.46.0


