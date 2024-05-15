Return-Path: <linux-kernel+bounces-180286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8EE8C6C71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9681F214FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBD15B967;
	Wed, 15 May 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RMma/IwA"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0472E622;
	Wed, 15 May 2024 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799086; cv=none; b=lRon+GNB4mL6bXQBqM9BazxQDBzRiZDADIpYdgHpQJ6VMrVQvOt/I7ZqLCitwBiQmbCoH7PqpbTyIC1ICeRzeOB9vLslpH9LteImcXb2RV0049kbCv43smrLrsXWlg/uhRIIwe024QZaXnK3HXC4/r6XVe2ZDD8Xiod5U6sHKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799086; c=relaxed/simple;
	bh=2cRQ6cZ5LVRwtfIO9jnyuzovDmMAYNZagT/xJCA1agM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eeaL/bIfLlRCa4zWh9eKzTanoHVAkRpk82QYce/i9yJle7sMgYy+s4dvOiL/FB35QbiF+slsMeqc5h6WnL2k48UMtwkoKSYQNHnRyA95vEPpIG/SZUQBIVRabZB6sdabycsSHfVy1n/GBn+TrRljLAD9mGPKQd2lJ0tnA2auaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RMma/IwA; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4898D120028;
	Wed, 15 May 2024 21:51:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4898D120028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715799072;
	bh=ZyqQQyPWlX2imp1zQ5BuZ3BU1RSvHcPZrRiLbxR7aMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RMma/IwAPeXCjTIvZGsKqD4XNjBIhecK1citXeeLeTJpYTbnwg4kTXDA1DuPi7/Zi
	 HAD8/pAVynvyNXOiR7Cpz8yNVvetCFZlH1n/Tr1hTI0GweT3ugE9jTep3qoS4khsXB
	 fkNENPuKcIK3cuGVC4DCpJ9X5bO3jA6TF2Q2DK99CworS1RS4VpuMUQxUt4g+YiUP0
	 DvVOto/eXRuNmMmzSvvb0RhLvHouuebXiUeJ1nkMIPjL4xzZMT1X8mXDmn+qtiycvq
	 iHYVq2t4cWXrSr+4eaIZugBgQxOOVD8hdVZZvwdxQGFNj8iL/Y/w45ozyScsEisASP
	 DJfNV5mytMY1Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 21:51:12 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 15 May 2024 21:51:11 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <jian.hu@amlogic.com>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v3 0/7] clk: meson: introduce Amlogic A1 SoC Family CPU clock controller driver
Date: Wed, 15 May 2024 21:47:23 +0300
Message-ID: <20240515185103.20256-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185260 [May 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/15 12:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/15 12:57:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
X-KSMG-AntiVirus-Status: Clean, skipped

The CPU clock controller plays a general role in the Amlogic A1 SoC
family by generating CPU clocks. As an APB slave module, it offers the
capability to inherit the CPU clock from two sources: the internal fixed
clock known as 'cpu fixed clock' and the external input provided by the
A1 PLL clock controller, referred to as 'syspll'.

It is important for the driver to handle the cpu_clk rate switching
effectively by transitioning to the CPU fixed clock to avoid any
potential execution freezes.

Validation:
* to double-check all clk flags, run the below helper script:

```
pushd /sys/kernel/debug/clk
for f in *; do
    if [[ -f "$f/clk_flags" ]]; then
        flags="$(cat $f/clk_flags | awk '{$1=$1};1' | sed ':a;N;$!ba;s/\n/ | /g')"
        echo -e "$f: $flags"
    fi
done
popd
```

* to trace the current clks state, use the
  '/sys/kernel/debug/clk/clk_dump' node with jq post-processing:

```
$ cat /sys/kernel/debug/clk/clk_dump | jq '.' > clk_dump.json
```

* to see the CPU clock hierarchy, use the
'/sys/kernel/debug/clk/clk_summary' node with jq post-processing:

```
$ cat /sys/kernel/debug/clk/clk_summary | jq '.' > clk_dump.json
```

when cpu_clk is inherited from sys_pll, it should be:

```
syspll_in    1  1  0  24000000    0  0  50000  Y  deviceless                 no_connection_id
  sys_pll    2  2  0  1200000000  0  0  50000  Y  deviceless                 no_connection_id
    cpu_clk  1  1  0  1200000000  0  0  50000  Y  cpu0                       no_connection_id
                                                  cpu0                       no_connection_id
                                                  fd000000.clock-controller  dvfs
                                                  deviceless                 no_connection_id
```

and from cpu fixed clock:

```
fclk_div3_div           1  1  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
  fclk_div3             4  4  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
    cpu_fsource_sel0    1  1  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
      cpu_fsource_div0  1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
        cpu_fsel0       1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
          cpu_fclk      1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
            cpu_clk     1  1  0  128000000  0  0  50000  Y  cpu0                       no_connection_id
                                                            cpu0                       no_connection_id
                                                            fd000000.clock-controller  dvfs
                                                            deviceless                 no_connection_id
```

* to debug cpu clk rate propagation and proper parent switching, compile
  kernel with the following definition:
    $ sed -i "s/undef CLOCK_ALLOW_WRITE_DEBUGFS/define CLOCK_ALLOW_WRITE_DEBUGFS/g" drivers/clk/clk.c
  after that, clk_rate debug node for each clock will be available for
  write operation

Changes v3 since v2 at [2]:
    - rename CLK_MESON_PLL_INIT_ONCE to CLK_MESON_PLL_NOINIT_ENABLED to
      accurately describe the behavior when we don't run the
      initialization sequence for an already enabled PLL
    - provide accurate comment about CLK_MESON_PLL_NOINIT_ENABLED flag
      to meson_clk_pll_init() and A1 sys_pll clock definition
    - tag syspll_in and sys_pll input clocks as optional in the a1-pll
      and a1-peripherals clkc bindings per Conor and Rob suggestion
    - move sys_pll_div16 clock from a1-pll clkc to a1-peripherals clkc
      as Jerome suggested

Changes v2 since v1 at [1]:
    - introduce new 'INIT_ONCE' flag to eliminate init for already
      enabled PLL
    - explain why we need to break ABI for a1-pll driver by adding
      sys_pll connections
    - implement sys_pll init sequence, which is applicable when sys_pll
      is disabled
    - remove CLK_IS_CRITICAL from sys_pll
    - move sys_pll_div16 binding to the end per Rob's suggestion
    - add Rob's RvB
    - remove holes from the beginning of the cpu clock controller regmap
    - move a1-cpu.h registers offsets definition to a1-cpu.c
    - set CLK_SET_RATE_GATE for parallel cpu fixed clock source trees
      per Martin's and Jerome's suggestion
    - redesign clock notifier block from cpu_clk to sys_pll to keep
      cpu_clock working continuously (the same implementation is located
      in the g12a clock driver)

Links:
    [1] https://lore.kernel.org/all/20240329205904.25002-1-ddrokosov@salutedevices.com/
    [2] https://lore.kernel.org/all/20240510090933.19464-1-ddrokosov@salutedevices.com/

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Dmitry Rokosov (7):
  clk: meson: add 'NOINIT_ENABLED' flag to eliminate init for enabled
    PLL
  dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
  clk: meson: a1: pll: support 'syspll' general-purpose PLL for CPU
    clock
  dt-bindings: clock: meson: a1: peripherals: support sys_pll input
  clk: meson: a1: peripherals: support 'sys_pll_div16' clock as GEN
    input
  dt-bindings: clock: meson: add A1 CPU clock controller bindings
  clk: meson: a1: add Amlogic A1 CPU clock controller driver

 .../bindings/clock/amlogic,a1-cpu-clkc.yaml   |  64 ++++
 .../clock/amlogic,a1-peripherals-clkc.yaml    |   9 +-
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   9 +-
 drivers/clk/meson/Kconfig                     |  10 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1-cpu.c                    | 331 ++++++++++++++++++
 drivers/clk/meson/a1-peripherals.c            |  18 +-
 drivers/clk/meson/a1-pll.c                    |  72 ++++
 drivers/clk/meson/a1-pll.h                    |   6 +
 drivers/clk/meson/clk-pll.c                   |  40 ++-
 drivers/clk/meson/clk-pll.h                   |   1 +
 .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   |  19 +
 .../clock/amlogic,a1-peripherals-clkc.h       |   1 +
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |   1 +
 14 files changed, 560 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-cpu.c
 create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h

-- 
2.43.0


