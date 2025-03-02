Return-Path: <linux-kernel+bounces-540496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF6A4B156
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8F41892073
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5E1E0E0C;
	Sun,  2 Mar 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="EpekGFJv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H36YEWhv"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54E1D5CDE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916696; cv=none; b=KDcQoqBlbTyuIRpoqBQp+Gh1uX0XjXNEOUfLs1tfJ2hM+BiJBbKQdkR+E/gIzH5fUid2LzycEkuR0zxHJscmBZcxba7MRXgZToK5j5x3OdA9wiVFFSc5og9T37nvxyNb8tn/kSB+r7fe0sE0Rp3wga29rX7+wuNhiV1B9oEjQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916696; c=relaxed/simple;
	bh=nWGi7cfqhp9mA4Uz0WOPpEi/Lcd5mG7GIiDgPrI/IsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BIr2d+Vw8NIwJFkruQMiB/6jvrMyfH/DHYH4aNUIWVIL4EX4MPffQL2RVanynSKTrD9HiTJ7Tkkpt0uyj8fzSJjb2Guvs/3H2YyndiOdFJZSQHZuVP3bguLxTnUGM8PlFS2GR39ltO4QcMtIQVqIigIJJpB2+TXqou6guc/7Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=EpekGFJv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H36YEWhv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BE6211400D3;
	Sun,  2 Mar 2025 06:58:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 02 Mar 2025 06:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1740916693; x=1741003093; bh=Y3u4DWgtOR
	alPu24x88ZUnj6vgWYBg8l4GEw4QA6sbA=; b=EpekGFJvrLGE+03/WtqX5UWDM+
	6X3NJ8AdTKF8ZsLhrw7FL3yzJ6OHBGezB4ihLraOYyYK0wcmlVRVPj3uXCCDsk0e
	YjHpoHp+BpM3ThdHq8RwYkfD1ULr6svs/llcbUKVLkTEZSKbqRU4T8hmkt3icZtY
	/8k+JamQtyyAmGRiwX5tynoDdo67Qh7Jmxg0fbPFNckFUQ97T0a7/2Xpc0bzT+VY
	efaiZxY+1vS4USYcNHJeUCw+PV92EnnyFaRTVJX6VL5qi4M7LBAXKUM/33nzWkr7
	RcJKrNVoC/n2gm81sEIx7bCsLi3UCFQFmJa4apyaLatkImmpRgQVhQn83NZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740916693; x=1741003093; bh=Y3u4DWgtORalPu24x88ZUnj6vgWYBg8l4GE
	w4QA6sbA=; b=H36YEWhvfvvslR5HJbOH7bTx18EJhND4/C3v+1Hl0c9W3AmJUlH
	IetkbzI6sILc2h0SB7EV/90ZaDYQHPmyrYyy6+bQHaNPWZoL7NAOTAI1/HdFyB1p
	spegx9cqIQTo9OV1jg5XEf/scOO+Aib6ZdGXmcz22Yyws7yn/jf2a1SCtf5+L+WV
	L5x9BmF2jw+jK0PYuiEfTwC5P1HjSPU9jMTKrJ0LwPEkpo3aoNVtcISjHIu+fmvA
	JFcezBjQOEIXY2GldMdyJrVmmF/pyPGFgZULk1ROfs3nkHOOQ8K1G8YN4h4HOO2i
	o9FhjXKmwm77gGx6hK1Mi0OZ4N7rRvNNzuQ==
X-ME-Sender: <xms:1EfEZ-3e0_h6TTVnwpNGplagjkyd8iKqQ5DC5ItdHMwEpIr8_AZxQw>
    <xme:1EfEZxH18JxFq296P4Stq60EdMR5LaFw9kTfmov2xOFVouiaGRzcU0erN1LeGNhim
    N80gF-yzTQhujta_oQ>
X-ME-Received: <xmr:1EfEZ2720e9C3IIvC6rYvpN9lxuM8kExdW5dyd8l6ak0tOjK5YoM3Z-1stM9jBvFX3_nwmCsXWNkU8xiDWkzUKeEN3N1-4Oqf7egZTdQoryBWIiC-_NOYc1b59imz5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvghtvghruceoshhv
    vghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpeejleevffdvfe
    egueetfeeuteeggefhleevveehueegffdtleeluedufeevhfeileenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    hotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegrshgrhhhisehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvg
    hlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1EfEZ_0sGJZhlPKZ67zooJnFfl8O0hZz24Va5r-pgXW6qc797FK2Ow>
    <xmx:1EfEZxE6NrxmExxnqYi-Ok4zlpkAva3xHq2z0oocNGS9CR0PRWevhA>
    <xmx:1EfEZ4-b1KF07u4Y_1ewjxECA6sSprdGXepPNa8ru5x3DIz4RCHKxw>
    <xmx:1EfEZ2lHuseW8anZf92RBHmIH3VYyhNTuC-IcYKClsMW23y_5VcfKw>
    <xmx:1UfEZ1j6e09AJOwlb1054JA8DWo55C8YRH3BN5hE4RDjahzXvEkcJpd_>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Mar 2025 06:58:11 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: soc@lists.linux.dev
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Second batch of Apple SoC DT updates for v6.15
Date: Sun,  2 Mar 2025 12:58:08 +0100
Message-Id: <20250302115808.59172-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is the second batch of device tree updates for Apple SoCs based
on the first PR sent earlier [1].
This one adds nodes for SPI controller, SPI NOR flash and NVRAM partitions
for M1 and M2 devices. The SPI controller driver has been merged for a while
already and we just forgot to pick the device tree changes up.
It also adds the touchbar digitizer nodes. The corresponding driver and
dt-bindings are already in -next and should be part of the 6.15 merge window
as well.


Best,

Sven


[1] https://lore.kernel.org/soc/20250209135558.8243-1-sven@svenpeter.dev/

The following changes since commit ca96d759d8d24d90b1726c2cc7c568ff4728bb42:

  arm64: dts: apple: t8015: Add cpufreq nodes (2025-02-09 11:50:13 +0000)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-6.15-v2

for you to fetch changes up to 44db68dee1f77260d7037319e911e9883a6ffe0e:

  arm64: dts: apple: Add touchbar digitizer nodes (2025-02-26 15:33:46 +0000)

----------------------------------------------------------------
Apple SoC DT updates for 6.15, second batch:

- Added a missing p-state for iPad mini 4
- Added SPI controller nodes for M1 and M2 devices
- Added SPI NOR flash nodes and NVRAM partitions
- Added touchbar digitizer nodes for M1 and M2 devices

----------------------------------------------------------------
Hector Martin (1):
      arm64: dts: apple: t8103: Fix spi4 power domain sort order

Janne Grunau (4):
      arm64: dts: apple: t8103: Add spi controller nodes
      arm64: dts: apple: t8112: Add spi controller nodes
      arm64: dts: apple: t600x: Add spi controller nodes
      arm64: dts: apple: Add SPI NOR nvram partition to all devices

Nick Chan (1):
      arm64: dts: apple: t7000: Add missing CPU p-state 7 for J96 and J97

Sasha Finkelstein (1):
      arm64: dts: apple: Add touchbar digitizer nodes

 arch/arm64/boot/dts/apple/spi1-nvram.dtsi      | 39 +++++++++++++
 arch/arm64/boot/dts/apple/t600x-common.dtsi    |  7 +++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      | 28 ++++++++++
 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi | 14 +++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi |  2 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi     |  4 ++
 arch/arm64/boot/dts/apple/t7000.dtsi           |  6 ++
 arch/arm64/boot/dts/apple/t8103-j293.dts       | 27 +++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi      | 18 +++---
 arch/arm64/boot/dts/apple/t8103.dtsi           | 76 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j493.dts       | 23 ++++++++
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8112.dtsi           | 44 ++++++++++++++-
 15 files changed, 284 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/spi1-nvram.dtsi

