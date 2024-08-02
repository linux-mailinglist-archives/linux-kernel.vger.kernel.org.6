Return-Path: <linux-kernel+bounces-272632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84199945F30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE4A1C212F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B91E486E;
	Fri,  2 Aug 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3qGZM3aW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC791134AB;
	Fri,  2 Aug 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608235; cv=none; b=HCGGlcBOmE7v+mXV9aW2aVPk8QZZIuKs9PjPuuqV9+pGpXw68vJiTKq1kU0SdFstfZQ+rxPh4fzfdSDRPKT/Eo1rGx8DjhL/PKs7SQQDjERAqDBnXfcjqStNJ3DwOx7whLfuyuJN8t8AOeo8x9gH6gQJLwGwg5KTPjz1ldE3azI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608235; c=relaxed/simple;
	bh=F27qf+/aidpVlH+J0uQc/en8+v4v4owFpY+E4ck8mds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/LhQLu9r+GjPblBtW7LB0PpvWXDvb2W428/oBGXNoDeEfRwYAxzApMgD0Q5/VyphkrDSwQa90hSY3//2raQ/cVkDBbikQhKBOjvyBXRd1HU4BpAady6hYNtCWYYLEhfVN/VMo9zNkXgA4JLFTI3l6MB1SkT0mP8skeb90f34O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3qGZM3aW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722608232;
	bh=F27qf+/aidpVlH+J0uQc/en8+v4v4owFpY+E4ck8mds=;
	h=From:To:Cc:Subject:Date:From;
	b=3qGZM3aWPZ5N58fnbh9lgA5I5ZHgSVCVbrZpBqpPhRdsYdwW+GsAg1oGIbHwX+Pdb
	 GEDR7B3sA93tddxkNjbSm8/hwR52texpQsu+r+Bq606G65ivzSDZzSJm50Q1DTheNd
	 emcRIUm4LfQuldkGHhoR6MerEvOS8kXFteM0PdHF9vLsQHkQFIEdzxFZE+o1oyGzFP
	 F4EalWayh6nrpAiBI51ztXdTyahr+VTmzK5OVt7opKUFKVgGCpR93+IS2b/1/O5Qzi
	 foe2J9lbiJYeRRqOaFWcOp5JrqqtL99afGTcf0yQf2TJ7mRFS4SuweJniAEE45OcPa
	 R/8TE3wopPdkQ==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 637D23782214;
	Fri,  2 Aug 2024 14:17:10 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/3] Add CRU support for rk3576 SoC
Date: Fri,  2 Aug 2024 10:12:47 -0400
Message-ID: <20240802141816.288337-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clocks and resets on the rk3576.
Patches from downstream have been squashed and rebased.

Detlev Casanova (1):
  dt-bindings: clock: add rk3576 cru bindings

Elaine Zhang (2):
  clk: rockchip: Add dt-binding header for rk3576
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   73 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rk3576.c             | 1818 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   52 +
 .../dt-bindings/clock/rockchip,rk3576-cru.h   | 1149 +++++++++++
 6 files changed, 3100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h

-- 
2.46.0


