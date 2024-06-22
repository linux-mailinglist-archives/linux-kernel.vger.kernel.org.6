Return-Path: <linux-kernel+bounces-225739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A89134AA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95251C20310
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8D16FF48;
	Sat, 22 Jun 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS0DvQam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB4155CBD;
	Sat, 22 Jun 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068855; cv=none; b=KkscBOiKj5+O2kIjuASq8BY/FG0K4En8MEPJLL27TenT/411pTFl/7+OsFHES9UmQz/1QoqC5320jyLQ3X80AT7MHKEAFyRTemOaIBUsiYJL9HxTzupo4MYpUsYr3yVpKJ2MKsDrkiOxYdMwRbhhypXL9zSa8q2PxBo+hEszlrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068855; c=relaxed/simple;
	bh=FWOQ6uEddi1Oy8wHfoQsKuHKsTCcCzZHsfD/pnViTac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwSljYrFQOcdmGgB4uw6q3SzDEWQlttP1QnXby9a7F/cSr6sVgh9f+page28I5fpCdYeGEx/2Rc8avRqEoWQPrdDPmI7LYZIAdwW3aA6fssHn0O6rJHOCwKhvFHhoG+cVs1oCPN9YRaiYCqRaTz7jZhMQfRIxifAdqfNnETxIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS0DvQam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA65C3277B;
	Sat, 22 Jun 2024 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719068854;
	bh=FWOQ6uEddi1Oy8wHfoQsKuHKsTCcCzZHsfD/pnViTac=;
	h=From:To:Cc:Subject:Date:From;
	b=TS0DvQamfYX/dVr7XVqUP1xp2TZ7oUbIjoyz1KkXX5zA3GTrNPy3MjJJAC0A+Pcsy
	 2Ar3B+E2rQ2/PPirQA9SLDc44epwaN5CP0OQTMk/p5LP4toltVBnn4qM6u6M2gJbRL
	 2mrWfewcBFV9frySlAwT1iZM03K53ujSdMkGAALtVprN5SY4vZ99pp61wGb/SyoqKJ
	 qdfCN4RGE3nXZpgrXHghPE2AOmBNOrhRw/84E+Act8DJsODy8PqXzkAJdyI4bo8tjO
	 SqOr5vry5S0Ei9iHK4qRyKbmTtc1h/G4Ue7D8c2ctBCtv4MJqK9oWq5UqgOcTzBdKB
	 u/SkcRY1Xc+Qw==
Received: by wens.tw (Postfix, from userid 1000)
	id 9A9065FFA4; Sat, 22 Jun 2024 23:07:32 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] riscv: allwinner: ClockworkPi and DevTerm devicetrees
Date: Sat, 22 Jun 2024 23:07:28 +0800
Message-Id: <20240622150731.1105901-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi folks,

Here are a couple patches that were originally sent by Samuel, but later
dropped due to the system LDO regulator bindings not getting merged. The
regulator bindings were recently resent and landed [1], so now is the time
to get the rest of the stragglers in.

Patch 1 and 3 were originally part of Samuel's D1 device tree submission [2].

Patch 2 was part of the system LDO series [3].

These have been rebased onto v6.10-rc1 and have been compile tested
only.

I plan to land these in the coming week for 6.11.


Regards
ChenYu


[1] https://lore.kernel.org/linux-sunxi/171532213496.2045034.2645456500780291742.b4-ty@kernel.org/
[2] https://lore.kernel.org/linux-sunxi/20221231233851.24923-1-samuel@sholland.org/
[3] https://lore.kernel.org/linux-sunxi/20221208084127.17443-1-samuel@sholland.org/

Chen-Yu Tsai (1):
  riscv: dts: allwinner: d1s-t113: Add system LDOs

Samuel Holland (2):
  dt-bindings: sram: sunxi-sram: Add regulators child
  riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees

 .../allwinner,sun4i-a10-system-control.yaml   |  28 ++
 arch/riscv/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 252 ++++++++++++++++++
 .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  11 +
 5 files changed, 329 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts

-- 
2.39.2


