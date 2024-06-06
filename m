Return-Path: <linux-kernel+bounces-203843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F688FE11B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1668A1F24E04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E291913D8BB;
	Thu,  6 Jun 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJlV4+gs"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FB13D890;
	Thu,  6 Jun 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662976; cv=none; b=JxtdLc/6Dj3FerdgOJcP7snU0/7VeKyGG6Nryz/ML6pRUazpFCrj8j3kvn6boA9kmCOxfjXKbp5kok0ayxsFj1fmygja6NhD9CnqKFNnpCphMfU68teZ0KzTNqxdRdS00BasGWn7SAHKuqv2efgXwww5o7022K2i56pJQiGLFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662976; c=relaxed/simple;
	bh=HbezAgu3orx2sG+dhV3jBNnTilhBUtJu83lkA/Gdp/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4whR2bdX4N/gOaAqHZzd9v5P05ugiNhXNjQ+ftQdV1jjYTW2JQ4RAa6TdyyljdYNfhrLe2FPiD8tADsdKY6P0emYrIob3Kuc/WvHayUWJEdBqjd28v7FgwR9eg2WnFRWboLTvrxZZ8vIfb594TvaJh21CdDahDjsCogLGx0A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJlV4+gs; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2509f93959bso264541fac.1;
        Thu, 06 Jun 2024 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717662974; x=1718267774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/J1TIi/7S4IHb480Bty9F4Vdib6r6GgqM8DD5E175o=;
        b=nJlV4+gsr3CL1BLDLH5LgZcb56GXSZ+PXu4UUPGRIazJMnUH5gWqnFDwdhArhhUEry
         9y6Ys11CpdIzkcEKW+1NItNAKK/MU9yCdUucQUXk2ldwqzc16LVdAvpvVwDukZDLo9Qy
         L1b3uzNtjj4PGG4rInzWlL8sazWKUJsOXzUaUP1OyLz9USlp6WWYgwOHQMyspah3rnd4
         Y++oY34LC2jwYew+3svmGXewB86I0JBC7p9E+LYFIQeRJ9iUtGYot7W4CZ+H+ocHhL2A
         jCTDHcCXsuk8xBF7KyQjYT6GTGGT0zn6PzwEl3vO5kWfLpqidUb1Trl4Nt/acJZecax2
         rouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662974; x=1718267774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/J1TIi/7S4IHb480Bty9F4Vdib6r6GgqM8DD5E175o=;
        b=febBMvfPTZl5svzwCr1Lmr+Iyy4LdcEK8o1J7ARe9VgXADHEkVMtmU1vDQpLHoFucA
         aEVqWqTPAhE9hllkAo5mzo5rAkr6115HxyapijgCclZhb02JTQuw4JF7YotR7ZhodBp8
         gWgnUsKv+5Dgp8WPBjTsJcRiuUe3/kXBltwGlbjMgbDM0qrCzSZQRTJK92fDoPoMc1ey
         JlKghj+C93RiueA2KEqJRwZmYk3cEw9uRBC2DB6Lmo/eFSpSsqo2GVphNAe/BiUMiR95
         K9WIU5wp8Sfcpaky7+erVh4eJxfAKYyplz7K3+A59AQWWRXzePhkm4jvHHovca9XS1au
         f7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWnerW5qkGWvFoYJr9jLOa/vpRNgsMg3c3CfpLL1hwYRbEa/nm6ZT0fBpk+orv8QNkm0pJ2LwHxh4OL7ufECQrRGhTOvvqyfS3Msq/Inh7sZSKmp9AWYTGMI3QGqMGcFeoq0CJQAl3ijgCgZEIwG/o4tw/IOl2C2Kda+zfZ2xW1qwjPcA==
X-Gm-Message-State: AOJu0YyXrpl1tKZ/k+FgHGJXPejyGw/jftLliXSJyd41p7AChBDube+o
	Nwxi/YWvOLtxqRHlGWAX5sXZZ434d/U9EunHFvhGUsgq0V4hRX0b
X-Google-Smtp-Source: AGHT+IF35oLFaWQj+hx8WmPQ4FtMX7jukB9MjmKafgBVECEtPc5fpKtMXkXT+P0QtvixG3SwQGYS6A==
X-Received: by 2002:a05:6870:9613:b0:24c:a8cd:c0fa with SMTP id 586e51a60fabf-2544077953cmr953560fac.21.1717662973990;
        Thu, 06 Jun 2024 01:36:13 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25447eb8f8bsm267977fac.27.2024.06.06.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:36:13 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v16 0/5] riscv: sophgo: add clock support for sg2042
Date: Thu,  6 Jun 2024 16:36:04 +0800
Message-Id: <cover.1717661798.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This series adds clock controller support for sophgo sg2042.

Thanks,
Chen

---

Changes in v16:

  The patch series is based on v6.10-rc1.

  Improved the dirvier code as per comments from Emil Renner Berthing.
  - Split driver source file into three and change from built-in to module.
  - Directly use status/enable pll register, no need to store them.
  - Use FIELD_PREP/FIELD_GET to simplify the code.
  - Some misc code improvements, such as for macro and local variables.

Changes in v15:

  The patch series is based on v6.9-rc5. You can simply review or test the
  patches at the link [16].

  Improved the dirvier code as per 3rd review comments from Stephen Boyd.
  - Converted all parents described by strings to use clk_parent_data or
    clk_hw directly.
  - Just use struct clk_init_data::parent_hws when only have a clk_hw.
  - Removed extra cleanup when use devm.
  - Some misc code improvements.

Changes in v14:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [15].

  Improved the dirvier code as per 2nd review comments from Stephen Boyd.
  - Inline the header file into source file.
  - Use devm_xxx functions for pll/div/gate registeration.
  - Use clk_parent_data for mux clocks initialization.
  - Use u32 for registers readl/writel.
  - Use devm_platform_ioremap_resource instead of devm_of_iomap.
  - Cleanup some dead code and add definitions for some magic numbers.
  - Add include files missed.
  - Use kernel-doc to improve comments for some structure and functions.
  - Other misc code cleanup work as per input from reviewers.

Changes in v13:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [14].

  Just added a minor fix for clk driver which was missed in v12.

Changes in v12:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [13].

  Improved the dirvier code as per review comments from Stephen Boyd.
  - Remove default y for CLK_SOPHGO_SG2042.
  - Optimize sg2042_pll_get_postdiv_1_2, move postdiv1_2 to the function.
    scope and add more explaniation.
  - Optimize sg2042_get_pll_ctl_setting.
  - Switch to platform driver.
  - Use clk_hw for initialization of struct clks.
  - Don't use ignore_unused when using critical.
  - Other code cleanup as per input form the reviewers.

Changes in v11:

  The patch series is based on v6.8-rc5. You can simply review or test the
  patches at the link [12].

  Quick fixed some dt_binding_check errors reported by Rob.

Changes in v10:

  The patch series is based on v6.8-rc4. You can simply review or test the
  patches at the link [11].

  Add input clocks for rpgate & clkgen.

Changes in v9:
  The patch series is based on v6.8-rc2. You can simply review or test the
  patches at the link [10].

  From this version, drop the system-controller node due to there is no actual
  device corresponding to it in IC design. SYS_CTRL is just a registers segment
  defined on TRM for misc functions. Now three clock-controllers are defined for
  SG2042, the control registers of the three clock-controllers are scattered in
  different memory address spaces:
  - the first one is for pll clocks;
  - the second one is for gate clocks for RP subsystem;
  - the third one is for div/mux, and gate clocks working for other subsystem
    than RP subsystem.

Changes in v8:
  The patch series is based on v6.7. You can simply review or test the
  patches at the link [9].
  
  In this version, the main change is to split one clock provider into two.
  Strictly follow the hardware instructions, in the memoymap, the control
  registers of some clocks are defined in the SYS_CTRL segment, and the
  control registers of other clocks are defined in the CLOCK segment.
  Therefore, the new design defines two clock controllers, one as a child
  node of the system control and the other as an independent clock controller
  node.

  This modification involves a major modification to the binding files, so
  the reviewed-by tags has been deleted.

Changes in v7:
  The patch series is based on v6.7. You can simply review or test the
  patches at the link [8].
  - fixed initval issue.
  - fixed pll clk crash issue.
  - fixed warning reported by <lkp@intel.com>
  - code optimization as per review comments.
  - code cleanup and style improvements as per review comments and checkpatch
    with "--strict"

Changes in v6:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [7].
  - fixed some warnings/errors reported by kernel test robot <lkp@intel.com>.

Changes in v5:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [6].
  - dt-bindings: improved yaml, such as:
    - add vendor prefix for system-ctrl property for clock generator.
    - Add explanation for system-ctrl property.
  - move sophgo,sg2042-clkgen.yaml to directly under clock folder.
  - fixed bugs for driver Makefile/Kconfig
  - continue cleaning-up debug print for driver code.

Changes in v4:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [5].
  - dt-bindings: fixed a dt_binding_check error.

Changes in v3:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [3].
  - DTS: don't use syscon but define sg2042 specific system control node. More
    background info can read [4].
  - Updating minor issues in dt-bindings as per input from reviews.

Changes in v2:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [2].
  - Squashed the patch adding clock definitions with the patch adding the
    binding for the clock controller.
  - Updating dt-binding for syscon, remove oneOf for property compatible;
    define clock controller as child of syscon.
  - DTS changes: merge sg2042-clock.dtsi into sg2042.dtsi; move clock-frequency
    property of osc to board devicethree due to the oscillator is outside the
    SoC.
  - Fixed some bugs in driver code during testing, including removing warnings
    for rv32_defconfig.
  - Updated MAINTAINERS info.

Changes in v1:
  The patch series is based on v6.7-rc1. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1699879741.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1701044106.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-riscv/cover.1701691923.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-riscv/MA0P287MB03329AE180378E1A2E034374FE82A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/ [4]
Link: https://lore.kernel.org/linux-riscv/cover.1701734442.git.unicorn_wang@outlook.com/ [5]
Link: https://lore.kernel.org/linux-riscv/cover.1701938395.git.unicorn_wang@outlook.com/ [6]
Link: https://lore.kernel.org/linux-riscv/cover.1701997033.git.unicorn_wang@outlook.com/ [7]
Link: https://lore.kernel.org/linux-riscv/cover.1704694903.git.unicorn_wang@outlook.com/ [8]
Link: https://lore.kernel.org/linux-riscv/cover.1705388518.git.unicorn_wang@outlook.com/ [9]
Link: https://lore.kernel.org/linux-riscv/cover.1706854074.git.unicorn_wang@outlook.com/ [10]
Link: https://lore.kernel.org/linux-riscv/cover.1708223519.git.unicorn_wang@outlook.com/ [11]
Link: https://lore.kernel.org/linux-riscv/cover.1708397315.git.unicorn_wang@outlook.com/ [12]
Link: https://lore.kernel.org/linux-riscv/cover.1711527932.git.unicorn_wang@outlook.com/ [13]
Link: https://lore.kernel.org/linux-riscv/cover.1711692169.git.unicorn_wang@outlook.com/ [14]
Link: https://lore.kernel.org/linux-riscv/cover.1713164546.git.unicorn_wang@outlook.com/ [15]
Link: https://lore.kernel.org/linux-riscv/cover.1714101547.git.unicorn_wang@outlook.com/ [16]

---

Chen Wang (5):
  dt-bindings: clock: sophgo: add pll clocks for SG2042
  dt-bindings: clock: sophgo: add RP gate clocks for SG2042
  dt-bindings: clock: sophgo: add clkgen for SG2042
  clk: sophgo: Add SG2042 clock driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../bindings/clock/sophgo,sg2042-clkgen.yaml  |   61 +
 .../bindings/clock/sophgo,sg2042-pll.yaml     |   53 +
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  |   49 +
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   55 +-
 drivers/clk/sophgo/Kconfig                    |   28 +
 drivers/clk/sophgo/Makefile                   |    4 +
 drivers/clk/sophgo/clk-sg2042-clkgen.c        | 1152 +++++++++++++++++
 drivers/clk/sophgo/clk-sg2042-pll.c           |  570 ++++++++
 drivers/clk/sophgo/clk-sg2042-rpgate.c        |  291 +++++
 drivers/clk/sophgo/clk-sg2042.h               |   18 +
 .../dt-bindings/clock/sophgo,sg2042-clkgen.h  |  111 ++
 include/dt-bindings/clock/sophgo,sg2042-pll.h |   14 +
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  |   58 +
 14 files changed, 2475 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 drivers/clk/sophgo/clk-sg2042-clkgen.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042-pll.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042-rpgate.c
 create mode 100644 drivers/clk/sophgo/clk-sg2042.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.25.1


