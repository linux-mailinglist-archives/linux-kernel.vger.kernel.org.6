Return-Path: <linux-kernel+bounces-192825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DD8D22C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC37286C41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837C4503A;
	Tue, 28 May 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="B+ZG/3r8"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180724B2F;
	Tue, 28 May 2024 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918554; cv=none; b=t8xNI8lkm0Tp7WhtSnPxn+TSExZHNdGJylLIT6/9PfGjqEvNNKkYHqXX5EfxEWSerPoPRbH0nOu4UOLOCSkDNhPrs+wM9KsIl3GRavvGY/dV60p1P8wcsSCaavaZrXJGc+OCMaVjJB3mIOi76sCEqWosrwFfIQpDHQpVTaJmXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918554; c=relaxed/simple;
	bh=JCyVnVrJJ8uHiHMW28dYr8y+TMgCCjGyvBxUHj6ZODo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2GAbW0mXTolFmLalgUtF/AKtrUHUZ0zkEpq9/4yIQkWIpvdBK8Y0DxtNF6zeoSUtELkiC0DnYt2xj3BwtdELCGPpxhRxw8nf94LKjwgfWiEdtVzJCsCEkCoGbfy1kz+fbPz0Hdu6qd84aW+p/zXEHyv3kDw7QuWY5a0IS3r1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=B+ZG/3r8; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 96BFB100016;
	Tue, 28 May 2024 20:41:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 96BFB100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716918105;
	bh=U5jiUUaxJmXPUet0vDMhP+OhbC5yo4Ho1nO40crCeco=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=B+ZG/3r8ZKVVzixK86pMjEKbdWHXrTLK/CE4hhHEiJ/ExIGY2WAsFlA1K8dbcz7Od
	 g3u5/Zx2r6ZF3PoiINe+6GNbUYEl0whIU1icoxgmEeWjZnN9crOggX4CmezGsoFnxO
	 DM5HIhuV1kjHYzaBBHS+iHadtFEiOL55zG5uSz5WvcWBan2cA3uDMCUraSMxXiSYKD
	 vD6L03vA2TYfThU6XcVjXiTjtbTwQ4Kc2C/HQcxYci+QaiWAQLdtZiavLvIB9yuHff
	 e+UUg28Pdmtu3ICPqkJ5vvUg4vIfpMkzeOBB2k1ysnrvARDGVCMG0io5P39eYtEIwz
	 NCD/a0TEYWphA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 28 May 2024 20:41:45 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 May
 2024 20:41:45 +0300
Date: Tue, 28 May 2024 20:41:44 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <jian.hu@amlogic.com>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/7] clk: meson: introduce Amlogic A1 SoC Family CPU
 clock controller driver
Message-ID: <20240528174144.v2aiq4zryqdbu6dh@CAB-WSD-L081021>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240515185103.20256-1-ddrokosov@salutedevices.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185554 [May 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/28 12:46:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/28 15:20:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/28 10:03:00 #25311634
X-KSMG-AntiVirus-Status: Clean, skipped

Hello guys!

Kindly reminder :)

On Wed, May 15, 2024 at 09:47:23PM +0300, Dmitry Rokosov wrote:
> The CPU clock controller plays a general role in the Amlogic A1 SoC
> family by generating CPU clocks. As an APB slave module, it offers the
> capability to inherit the CPU clock from two sources: the internal fixed
> clock known as 'cpu fixed clock' and the external input provided by the
> A1 PLL clock controller, referred to as 'syspll'.
> 
> It is important for the driver to handle the cpu_clk rate switching
> effectively by transitioning to the CPU fixed clock to avoid any
> potential execution freezes.
> 
> Validation:
> * to double-check all clk flags, run the below helper script:
> 
> ```
> pushd /sys/kernel/debug/clk
> for f in *; do
>     if [[ -f "$f/clk_flags" ]]; then
>         flags="$(cat $f/clk_flags | awk '{$1=$1};1' | sed ':a;N;$!ba;s/\n/ | /g')"
>         echo -e "$f: $flags"
>     fi
> done
> popd
> ```
> 
> * to trace the current clks state, use the
>   '/sys/kernel/debug/clk/clk_dump' node with jq post-processing:
> 
> ```
> $ cat /sys/kernel/debug/clk/clk_dump | jq '.' > clk_dump.json
> ```
> 
> * to see the CPU clock hierarchy, use the
> '/sys/kernel/debug/clk/clk_summary' node with jq post-processing:
> 
> ```
> $ cat /sys/kernel/debug/clk/clk_summary | jq '.' > clk_dump.json
> ```
> 
> when cpu_clk is inherited from sys_pll, it should be:
> 
> ```
> syspll_in    1  1  0  24000000    0  0  50000  Y  deviceless                 no_connection_id
>   sys_pll    2  2  0  1200000000  0  0  50000  Y  deviceless                 no_connection_id
>     cpu_clk  1  1  0  1200000000  0  0  50000  Y  cpu0                       no_connection_id
>                                                   cpu0                       no_connection_id
>                                                   fd000000.clock-controller  dvfs
>                                                   deviceless                 no_connection_id
> ```
> 
> and from cpu fixed clock:
> 
> ```
> fclk_div3_div           1  1  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
>   fclk_div3             4  4  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
>     cpu_fsource_sel0    1  1  0  512000000  0  0  50000  Y  deviceless                 no_connection_id
>       cpu_fsource_div0  1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
>         cpu_fsel0       1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
>           cpu_fclk      1  1  0  128000000  0  0  50000  Y  deviceless                 no_connection_id
>             cpu_clk     1  1  0  128000000  0  0  50000  Y  cpu0                       no_connection_id
>                                                             cpu0                       no_connection_id
>                                                             fd000000.clock-controller  dvfs
>                                                             deviceless                 no_connection_id
> ```
> 
> * to debug cpu clk rate propagation and proper parent switching, compile
>   kernel with the following definition:
>     $ sed -i "s/undef CLOCK_ALLOW_WRITE_DEBUGFS/define CLOCK_ALLOW_WRITE_DEBUGFS/g" drivers/clk/clk.c
>   after that, clk_rate debug node for each clock will be available for
>   write operation
> 
> Changes v3 since v2 at [2]:
>     - rename CLK_MESON_PLL_INIT_ONCE to CLK_MESON_PLL_NOINIT_ENABLED to
>       accurately describe the behavior when we don't run the
>       initialization sequence for an already enabled PLL
>     - provide accurate comment about CLK_MESON_PLL_NOINIT_ENABLED flag
>       to meson_clk_pll_init() and A1 sys_pll clock definition
>     - tag syspll_in and sys_pll input clocks as optional in the a1-pll
>       and a1-peripherals clkc bindings per Conor and Rob suggestion
>     - move sys_pll_div16 clock from a1-pll clkc to a1-peripherals clkc
>       as Jerome suggested
> 
> Changes v2 since v1 at [1]:
>     - introduce new 'INIT_ONCE' flag to eliminate init for already
>       enabled PLL
>     - explain why we need to break ABI for a1-pll driver by adding
>       sys_pll connections
>     - implement sys_pll init sequence, which is applicable when sys_pll
>       is disabled
>     - remove CLK_IS_CRITICAL from sys_pll
>     - move sys_pll_div16 binding to the end per Rob's suggestion
>     - add Rob's RvB
>     - remove holes from the beginning of the cpu clock controller regmap
>     - move a1-cpu.h registers offsets definition to a1-cpu.c
>     - set CLK_SET_RATE_GATE for parallel cpu fixed clock source trees
>       per Martin's and Jerome's suggestion
>     - redesign clock notifier block from cpu_clk to sys_pll to keep
>       cpu_clock working continuously (the same implementation is located
>       in the g12a clock driver)
> 
> Links:
>     [1] https://lore.kernel.org/all/20240329205904.25002-1-ddrokosov@salutedevices.com/
>     [2] https://lore.kernel.org/all/20240510090933.19464-1-ddrokosov@salutedevices.com/
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> Dmitry Rokosov (7):
>   clk: meson: add 'NOINIT_ENABLED' flag to eliminate init for enabled
>     PLL
>   dt-bindings: clock: meson: a1: pll: introduce new syspll bindings
>   clk: meson: a1: pll: support 'syspll' general-purpose PLL for CPU
>     clock
>   dt-bindings: clock: meson: a1: peripherals: support sys_pll input
>   clk: meson: a1: peripherals: support 'sys_pll_div16' clock as GEN
>     input
>   dt-bindings: clock: meson: add A1 CPU clock controller bindings
>   clk: meson: a1: add Amlogic A1 CPU clock controller driver
> 
>  .../bindings/clock/amlogic,a1-cpu-clkc.yaml   |  64 ++++
>  .../clock/amlogic,a1-peripherals-clkc.yaml    |   9 +-
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   9 +-
>  drivers/clk/meson/Kconfig                     |  10 +
>  drivers/clk/meson/Makefile                    |   1 +
>  drivers/clk/meson/a1-cpu.c                    | 331 ++++++++++++++++++
>  drivers/clk/meson/a1-peripherals.c            |  18 +-
>  drivers/clk/meson/a1-pll.c                    |  72 ++++
>  drivers/clk/meson/a1-pll.h                    |   6 +
>  drivers/clk/meson/clk-pll.c                   |  40 ++-
>  drivers/clk/meson/clk-pll.h                   |   1 +
>  .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   |  19 +
>  .../clock/amlogic,a1-peripherals-clkc.h       |   1 +
>  .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |   1 +
>  14 files changed, 560 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
>  create mode 100644 drivers/clk/meson/a1-cpu.c
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
> 
> -- 
> 2.43.0
> 

-- 
Thank you,
Dmitry

