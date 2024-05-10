Return-Path: <linux-kernel+bounces-175485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B18C2054
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564BD1C218EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2596D165FAF;
	Fri, 10 May 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="sFvw6Y9l"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7C77119;
	Fri, 10 May 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332195; cv=none; b=gXwLWEs0piGNs7A8TjFNXhdycIDYQP46rKhMKBdGLfoDESFRndPoMxCNQpsALoV/EGERm4N5LJMWaW62XSz+T2egjqS/JsvWqUDmKgc2k5b3V7QEfYLem9bPzXAgb5osFhppKKteBWPehnZ5lVJx8Z4bZ5yVO65lihOVpl8eIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332195; c=relaxed/simple;
	bh=Yv050DptdkKKoNNuup7N3qcGrSu/0n9z/vq27wUDTyU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi8/PDIM7FVl0LF1v41DAkErMD3q4QPD71i6QujaHRoTkSmsfhY/i9UUJqOSRvV5wU7i/gH/JQgx9LAyki0DtsyVgpZPH7ediFvWzXhDwacGsRJdJAb8b1nk/+/Ep68HMwRVHfxLuoGqOFATVHpQYvSR/mQXAlcBypjsVOwoj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=sFvw6Y9l; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C78FF100003;
	Fri, 10 May 2024 12:09:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C78FF100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332181;
	bh=jZ4Ttk3n3/X3+60djZL+GZdLJyOvPAKAnJ6WGlawQZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=sFvw6Y9lxgC2XKIk/yfeJYYMWXdIGWDgd+ZfLPiJVvWDqlotp3QkHyDEnEpMUxv3C
	 P9Kwy63qDjqFrVZZUHrG+a5vWh6LRPMv21J+UL9WeOFb56HuTgzLRxx24yA0y7ktAl
	 ocNIYq+cTPvv2+tRDw58erxKOo4vufIE2ewnPy6ZMqc6NGLVPnac4P7Y6QEOBZM4D4
	 3cjW51KPB+1myDH469h+StzCxQr4mnXqvAZm6WlUyYOf65PQ4No7v4wUfIgxWdkXs2
	 VDboofDUuwgmpsnZm8W0dKt7L8xizx0RXDP35ySwyk1RhIOn2INEIGFrv+c8tH8i9U
	 eY5m9P+9l1Ulg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:09:41 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:09:41 +0300
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
Subject: [PATCH v2 0/7] clk: meson: introduce Amlogic A1 SoC Family CPU clock controller driver
Date: Fri, 10 May 2024 12:08:52 +0300
Message-ID: <20240510090933.19464-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185158 [May 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/10 08:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/10 08:36:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
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

Dmitry Rokosov (7):
  clk: meson: introduce 'INIT_ONCE' flag to eliminate init for enabled
    PLL
  dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
  clk: meson: a1: pll: support 'syspll' general-purpose PLL for CPU
    clock
  dt-bindings: clock: meson: a1: peripherals: support sys_pll_div16
    input
  clk: meson: a1: peripherals: support 'sys_pll_div16' clock as GEN
    input
  dt-bindings: clock: meson: add A1 CPU clock controller bindings
  clk: meson: a1: add Amlogic A1 CPU clock controller driver

 .../bindings/clock/amlogic,a1-cpu-clkc.yaml   |  64 ++++
 .../clock/amlogic,a1-peripherals-clkc.yaml    |   7 +-
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   7 +-
 drivers/clk/meson/Kconfig                     |  10 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1-cpu.c                    | 331 ++++++++++++++++++
 drivers/clk/meson/a1-peripherals.c            |   4 +-
 drivers/clk/meson/a1-pll.c                    |  79 +++++
 drivers/clk/meson/a1-pll.h                    |   6 +
 drivers/clk/meson/clk-pll.c                   |  37 +-
 drivers/clk/meson/clk-pll.h                   |   1 +
 .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   |  19 +
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |   2 +
 13 files changed, 546 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-cpu.c
 create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h

-- 
2.43.0


