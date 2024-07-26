Return-Path: <linux-kernel+bounces-263668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6693D8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138A92817BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C44779D;
	Fri, 26 Jul 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3wi38W0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA724205;
	Fri, 26 Jul 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021360; cv=none; b=OI6karsot3NkfS4Pa2BMgswFH/yI1mtmfNxzO/XbAnPcr+8gZbZI9M/701alnNGB184Fo5Rq/C8rJPHyH8ps8HqaWMafJgrPaI66YE9ffwRgjJT9f91E8uLHEyPV80lnMf4I3ouPFsKI1l2X+ompYFwqVYVTCzbihWOXvqAZK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021360; c=relaxed/simple;
	bh=pDOSXMepXbUmRvL5kOGQExRmVA5TknrX/ZBy4egmSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WX4MRBNUdTAVv8GYc1cr2ALRRjcLRBQorUpWocfTnJAPxac2S5K60wMlhQue2xK41g91jwnWo3o66ev/5LuCoFzg0XIH45YltExEfAgC1pvi9YuKc8sGzqfgoq/iDQOZo3ujhpI/zj560599aVg7KaOZYIpM44A+tFgNiUylx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3wi38W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89199C32782;
	Fri, 26 Jul 2024 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722021359;
	bh=pDOSXMepXbUmRvL5kOGQExRmVA5TknrX/ZBy4egmSXo=;
	h=Date:From:To:Cc:Subject:From;
	b=g3wi38W0+clK4gCQcr0UqZE71ZofhLsCiItgRZhsgoR+ATrdQV4z/cvBIQq49FUzZ
	 A0jcaFPepeLGk2i9co/1xHQrjRU2K6fDKkeCowfQypBO6GtdKWypuVDzBfafWg7hJZ
	 nAfCX+LgzUa7fbBlNvkyv2SHn2ij0gAUwglMwlzTZPHzrx4ithB7Q9a38Sk9cBDoX+
	 3BAPnRudwOcqssmRPiJ2bHzz3XGU7b0kPXlOyK6+qIQyjGpO41ly/uDLz5hccH0cgz
	 OCOQ4HM7s7sf1ye+i9qb1XHTlbpKh6wxQyfL2phzJkHtar1Kt7IFpQG+M2uoMUkDeT
	 EtXcIL/JfrgwQ==
Date: Fri, 26 Jul 2024 14:15:58 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.11, part 2
Message-ID: <20240726191558.GA1888978-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull 2nd batch of DT updates for 6.11. Most of it is a treewide 
change to of_property_for_each_u32() which was small enough to do in one 
go before rc1 and avoids the need to create 
of_property_for_each_u32_some_new_name().

Rob


The following changes since commit c33ffdb70cc6df4105160f991288e7d2567d7ffa:

  Merge tag 'phy-for-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy (2024-07-24 13:11:28 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.11-1

for you to fetch changes up to 6dc55268f64b780eb8774de3705f791b689853bb:

  dt-bindings: iio: adc: ad7192: Fix 'single-channel' constraints (2024-07-26 13:53:20 -0500)

----------------------------------------------------------------
Devicetree fixes for 6.11, part 1

- Treewide conversion of of_property_for_each_u32() to drop internal
  arguments making struct property opaque

- Add binding for Amlogic A4 SoC watchdog

- Fix constraints for AD7192 'single-channel' property

----------------------------------------------------------------
Huqiang Qin (1):
      dt-bindings: watchdog: add support for Amlogic A4 SoCs

Luca Ceresoli (1):
      of: remove internal arguments from of_property_for_each_u32()

Rob Herring (Arm) (1):
      dt-bindings: iio: adc: ad7192: Fix 'single-channel' constraints

 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |  5 +--
 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |  1 +
 arch/powerpc/sysdev/xive/native.c                  |  4 +-
 arch/powerpc/sysdev/xive/spapr.c                   |  3 +-
 drivers/bus/ti-sysc.c                              |  4 +-
 drivers/clk/clk-conf.c                             |  4 +-
 drivers/clk/clk-si5351.c                           | 43 +++++++++++++---------
 drivers/clk/clk.c                                  | 12 +++---
 drivers/clk/qcom/common.c                          |  4 +-
 drivers/clk/sunxi/clk-simple-gates.c               |  4 +-
 drivers/clk/sunxi/clk-sun8i-bus-gates.c            |  4 +-
 drivers/clocksource/samsung_pwm_timer.c            |  4 +-
 drivers/gpio/gpio-brcmstb.c                        |  5 +--
 drivers/iio/adc/ti_am335x_adc.c                    |  4 +-
 drivers/irqchip/irq-atmel-aic-common.c             |  4 +-
 drivers/irqchip/irq-pic32-evic.c                   |  4 +-
 drivers/mfd/ti_am335x_tscadc.c                     |  4 +-
 drivers/pinctrl/nxp/pinctrl-s32cc.c                |  4 +-
 drivers/pinctrl/pinctrl-k210.c                     |  4 +-
 drivers/pwm/pwm-samsung.c                          |  4 +-
 drivers/tty/sysrq.c                                |  4 +-
 drivers/usb/misc/usb251xb.c                        |  4 +-
 include/linux/of.h                                 | 15 ++++----
 sound/soc/codecs/arizona.c                         | 12 +++---
 24 files changed, 64 insertions(+), 96 deletions(-)

