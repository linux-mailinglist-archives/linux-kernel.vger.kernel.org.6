Return-Path: <linux-kernel+bounces-297920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF695BF20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D523D1C2311D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665C1D0DD4;
	Thu, 22 Aug 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="eTpeRTTz"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6617588;
	Thu, 22 Aug 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356256; cv=pass; b=d0gpkdf2bHsmFSvUTPu/Vb5ptZIqW0pdFRw9zumijCGtpm7G5UusRQiLXyQNZlcWSy1gii+7Jh8ArMcWzXcrwRgH9r1ThjjcPpaFLrm/as7bWe5uTz8ec+HhlK5cQKFekpyLAKaYCg3NyOlUv77KfGHe2GZTl8gsNAiOn4pgGBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356256; c=relaxed/simple;
	bh=z71gBKiCb5HNwrr7nqwryFAYX1D1UkbjJF9w3qhEPsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiRFPHRf5KlbuEaUVM6FeJRx5DerRa+NyNwmh6L+cHLyT8n89EYFXMeWungJo7aC8E1T6oq72l3VZj72/PtERJKEPHP6w/b27rdaAP4JsBjKAfEV+UOG1kgntzoKgR2J7mRwGC+WOfNMkxT/2FzKkQgGzdu+h2FnII6jnjPLlSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=eTpeRTTz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724356228; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E41yLdpZ+X5SnFdkNfrcl7f8jySEoAsAfCRDiNbZbVbNyMrNT+volmD1StncEwRskKETGn0QuPb3bqwJXgJJdqRszmxdLELOneG7QFH0fJzOjn5vdrxiyCznIO9mG9q6AD6wOaI0L5LWiXb6GG0fCvlnRm7M5EV/Rk8IqGRNzm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724356228; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mb1fbrEw+bwWMVwy9MvhckXYVriHPI7yDfsI9liML/w=; 
	b=YYwqR67K/sinkUlIMzVPVUTrV4RmsaRu72ZxTb1CP6TLn3WqgTfTxaTFTbO5txV1QXjRJNdaMrmfmzT82Wmd6BVxFc5Cpgu1sI/clb4Dk0MZcv/T3zJln9s8CEfuuU9UKmMZEreFtrSAnho+9NwElqPSmz22UVVFd7TCT4TLCgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724356228;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Mb1fbrEw+bwWMVwy9MvhckXYVriHPI7yDfsI9liML/w=;
	b=eTpeRTTzrVfAcr60NE2GH5TAMPg1PgTFrlQopLiyTkawNcwZXLnx+f4dUd9D8pxW
	pLrkguv3hoqistyXH3aAbgryboFtMhebeHVYpIafivX4/NqkKf3d89Ec/4qYc48ry85
	kBlT/P5BvbsCqw9hy3MmWbRKTnAFklvlRL8AKvgA=
Received: by mx.zohomail.com with SMTPS id 1724356227134647.7294909083045;
	Thu, 22 Aug 2024 12:50:27 -0700 (PDT)
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
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v6 0/3] Add CRU support for rk3576 SoC
Date: Thu, 22 Aug 2024 15:49:31 -0400
Message-ID: <20240822194956.918527-1-detlev.casanova@collabora.com>
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

Also add the pll_rk3588_ddr pll type that is used by the ppll clock.

Changes since v5:
- Use mandatory syscon lookup instead of optional grf phandle
- Add pll_rk3588_ddr type to always have correct rate values

Changes since v4:
- Fix commit message with idx starting at 0
- Stash all bindings commits
- Cleanup example and add me as maintainer

Changes since v3:
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


Detlev Casanova (1):
  dt-bindings: clock, reset: Add support for rk3576

Elaine Zhang (2):
  clk: rockchip: Add new pll type pll_rk3588_ddr
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   56 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-pll.c                |    6 +-
 drivers/clk/rockchip/clk-rk3576.c             | 1829 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   54 +
 drivers/clk/rockchip/rst-rk3576.c             |  652 ++++++
 .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 +++++
 9 files changed, 3760 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

-- 
2.46.0


