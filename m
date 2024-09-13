Return-Path: <linux-kernel+bounces-328767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDF97888D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D891C22177
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1F145B38;
	Fri, 13 Sep 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Dkzflssa"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06A12A14C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254677; cv=none; b=embTwbUzaJ0O+u14oiHYAnI6lSMfc92efvtGHbQKwUq8jYODTBF/iMYd1Efu5q6EMJAl65RHlNroJcqTZB9cuYZxwQEhuf8JV9PdlyNmDhN6bWMN7A3n2ZUoIO1TTavHGz3/yvsD57zeJp8GsFEjHRFo6slx2UA2HvJFORR4H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254677; c=relaxed/simple;
	bh=ecDPfmv5oBvejMprBf0n9OyHO3jkRHKSg8K7ZpLhIXo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=idkHf+B7YzQJyV1PIwH42AKwmQd1Jd3pA7WG9QNVNswoziYax2HkQLConEyyp/25FJkDXzruItQcwQw2cN0lKowdR+kUBIQprSu80VLbjfNiD9kCSMJwDBiqT9vn9a1alXUWCogjYWwF/WZE42vNqpmYGrpPGRPMOeX1MVbFP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Dkzflssa; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726254673; x=1726513873;
	bh=/cB6MnxPg6xRdDI3dYn57hNwohgOxXQxubyUmHswtmo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DkzflssaTuwOcmV2aZjNzlDdhaoPRyHrlZk+UswyurIMxFz70FHS8J6IDTPBD+wMF
	 FrPlzAXS+GOa6WDW59xCByWUicgUpAnjv2QgFtl8q7oMsR5p2tsNp056ykB0ZtMDpZ
	 vEqUlnFEk/IQTqJ9H5OKj1f5YKP0UbKDaYkb5auE+tXbuJRwy+5q47uVE5CbSOt9JO
	 PWEpMp0xOQtk9F3Zkjfj4bGAToSV13BFfybD4nZb14blykAfpvrm5XI72fayF+QK3A
	 xivGa+0jZajvXvPGlBE90QaCjbZDwVWFouVyuXKsb+8mJI4NtP6NZyF1lSURqQA46q
	 oNdCxUDVuq5wQ==
Date: Fri, 13 Sep 2024 19:11:08 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 0/6] clk: clocking-wizard: modernize probe
Message-ID: <20240913191037.2690-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 1a60525dea657e1e8bdb7c85d87494262d45d5f2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Improve utilised clk/notifier APIs, making use of device managed versions
of functions and make dynamic reconfiguration support optional (because it =
is
in hardware).

This is currently untested on hardware, so any help testing this would be
much appreciated!

This patchset is based on a previous one [1] ([PATCH v3 0/9] clk:
clocking-wizard: add user clock monitor support), whereby I was attempting =
to
add support for the user clock monitor functionality. Those three patches (=
DT
binding, clk driver and UIO driver) have now been removed, with the intenti=
on of
getting these simpler tidyup changes merged first, while reworking the desi=
gn of
the user clock monitor support.

Changes from v1 [2]:
- Invert DT property (patch 5/6)
- Update driver with inverted DT property (patch 6/6)

[1] https://lore.kernel.org/20240826123602.1872-1-hpausten@protonmail.com
[2] https://lore.kernel.org/20240831111056.3864-1-hpausten@protonmail.com

Harry Austen (6):
  clk: clocking-wizard: simplify probe/remove with devres helpers
  clk: clocking-wizard: use newer clk_hw API
  clk: clocking-wizard: use devres versions of clk_hw API
  clk: clocking-wizard: move clock registration to separate function
  dt-bindings: clock: xilinx: describe whether dynamic reconfig is
    enabled
  clk: clocking-wizard: move dynamic reconfig setup behind flag

 .../bindings/clock/xlnx,clocking-wizard.yaml  |   6 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c    | 281 ++++++++----------
 2 files changed, 127 insertions(+), 160 deletions(-)

--=20
2.46.0



