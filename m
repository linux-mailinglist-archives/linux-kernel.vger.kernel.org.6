Return-Path: <linux-kernel+bounces-577498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F1A71DED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DBC188F847
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C824C079;
	Wed, 26 Mar 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="l2dmXFCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhciMl9T"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1F23E34C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012141; cv=none; b=QP6VqtKXahUMn7G7DvUiYT2xOo9PP6PeDUSvJ0fqonwYMTaeOp5uMWy/rHCrn+AGs+Rg7b2zuPQaw5dtXUetT2VenAKoeMYhlbaJ+4h76Aa+cUHFQq2kDB2ZQmNc+8hUS5xPJyY4EQQL0uKGfoYRpElbn3S/0zE+QTilQtYofoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012141; c=relaxed/simple;
	bh=biad3HzuhaFgGu9xfqSfJN5c/l/g3QaTrs2tMs0K1iY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Eatsf1D2DB+CKOM9Cu9sdqf7AQzVrT7z6LYD6Dj+TM9r+tg8MfGxP/AuajaClJFVCJhgIFQ8gX62MU31RYH5BQiRpZvltVUKlqBQ4UwNCzhsksTJvTwjRU7stQpmye8T3UiOM+8x/3q/tbvOjuuSWmlFSBsDZaw0ewf0ryrMbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=l2dmXFCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhciMl9T; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 564C6114009D;
	Wed, 26 Mar 2025 14:02:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 14:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743012137;
	 x=1743098537; bh=folkTxEknBV+MSNwPp+JwEhz/PCaLSgjK8cYy1qLXnQ=; b=
	l2dmXFCRSCDD4bFaUdSI8p0ec49KydsSXTThF74zItpryxzyVQ39Vb6F8o+juSsw
	JyOTbySNceP+6MWzOu+EYtXHsvRPjGo77xtYHEDb6TnOP8vlWtGncKYbkD+ISLke
	LruntGcc36lZ4mAl1TmYq5N/gmdqENGyrQNtnXhce8G6SlPFSVcsw6hcubL6CqVq
	u7adRLOHbv2lAlmlKY5HthOssMoAoIYHLbnf9SMDcCEWddCt4J7uRONvXiTldWwX
	U15EfkhLQiGTb9/51Wn1r+htwe13zp3cZQLDPelKQ2sTxCrvbLUT1hhCszQrRpza
	Ht7lg+Eyl7Em6KM//MhsWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743012137; x=
	1743098537; bh=folkTxEknBV+MSNwPp+JwEhz/PCaLSgjK8cYy1qLXnQ=; b=v
	hciMl9TAaq8UEVLS8DIvCuYKeCjRufB7R+GItc+cD1H58NkKTXxuh4keI32d6QcH
	ArjkMqulP8o8y0EJxkVG7uzPZj/2Gkhw0i0ynsaGJJiQ8pWuOTms6x4bmGyaPZCn
	pOUqb168S/p5AUYGdFuhdtPZ/sQP7UEupUAEWFNkWF/nKeIHPaooujp+Hj0iHYHu
	SmN7m+hEXWiEPmvW1242BDSP93krBYTroknt8Sg7XNd71sxHH35rOW3MBU5MCBa2
	jrhXnzHmAm3VQXjDJBiOhxp6eV47ax6A6EhzBPmtCQx5gHw1kwJqXbxIqMCwdvkU
	pkVd2sUl4UFKRD3FaJQFQ==
X-ME-Sender: <xms:KEHkZ5dduo_CbMB3J5zxAwBuxEgjeDBaonBv0hWZjoaBD7QNfFyLVQ>
    <xme:KEHkZ3OfmSOaPatpRog1quWKb6-WrwdvjafMs0hWu1O5P0m2B4V_WDwLBgeMg3WHr
    PhggVCUTmVDjmEFpj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfeltdejgfeitdeuffefieelgfffvdejiefh
    uddvffelffduuddvffevueetueejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmpdhpvghnghhuthhrohhnihigrdguvgenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhr
    vhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KUHkZyiODt2s6TplGG7pyMEYxrx2v9aXXarmXJLnvqYCuWWlgWf5KQ>
    <xmx:KUHkZy_jrTTMQiKF5UsW0imO1rUsMoeYf4PiJC04tgA3fPoRYaTzOA>
    <xmx:KUHkZ1u5vRVaXoZgWHThumQ6TGHRMC80zWNyuBzfdKz8lddNvJ361w>
    <xmx:KUHkZxFKGgH5q0nfHkMQ71Yn0IuHTdKiEUnZmYsbjwEDQO1BonDZ1g>
    <xmx:KUHkZ9KAgaHKZPZLg-yH3eoiXhP5FFI2ZnaprneGejNfMRBY5bY8IJjN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E49B72220073; Wed, 26 Mar 2025 14:02:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2e1b8447a49b63d2
Date: Wed, 26 Mar 2025 19:00:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <ab627300-24c0-46fb-a236-f94751afffc1@app.fastmail.com>
In-Reply-To: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
References: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
Subject: [GIT PULL 2/4] soc: driver updates for 6.15, part 1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.15-1

for you to fetch changes up to 2124055fb5c6554cab0fdd7a09235526cacaac23:

  Merge tag 'zynqmp-soc-for-6.15' of https://github.com/Xilinx/linux-xlnx into soc/drivers (2025-03-20 17:53:38 +0100)

----------------------------------------------------------------
soc: driver updates for 6.15, part 1

These are the updates for SoC specific drivers and related subsystems:

 - Firmware driver updates for SCMI, FF-A and SMCCC firmware interfaces,
   adding support for additional firmware features including SoC
   identification and FF-A SRI callbacks as well as various bugfixes

 - Memory controller updates for Nvidia and Mediatek

 - Reset controller support for microchip sam9x7 and imx8qxp/imx8qm

 - New hardware support for multiple Mediatek, Renesas and Samsung Exynos chips

 - Minor updates on Zynq, Qualcomm, Amlogic, TI, Samsung, Nvidia and Apple chips

There will be a follow up with a few more driver updates that are still
causing build regressions at the moment.

----------------------------------------------------------------
Ahmad Fatoum (1):
      MAINTAINERS: match mxc in file names by IMX / MXC entry

Alexey Minnekhanov (1):
      soc: qcom: pd-mapper: Add support for SDM630/636

Andrew Davis (1):
      soc: ti: k3-socinfo: Do not use syscon helper to build regmap

AngeloGioacchino Del Regno (8):
      soc: mediatek: mtk-mutex: Add DPI1 SOF/EOF to MT8188 mutex tables
      soc: mediatek: mtk-mmsys: Fix MT8188 VDO1 DPI1 output selection
      soc: mediatek: mtk-mmsys: Add compile time check for mmsys routes
      soc: mediatek: mt8188-mmsys: Migrate to MMSYS_ROUTE() macro
      soc: mediatek: mt8167-mmsys: Fix missing regval in all entries
      soc: mediatek: mt8365-mmsys: Fix routing table masks and values
      soc: mediatek: mmsys: Migrate all tables to MMSYS_ROUTE() macro
      soc: mediatek: mt8188-mmsys: Add support for DSC on VDO0

Arnd Bergmann (21):
      Merge tag 'renesas-drivers-for-v6.15-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'asahi-soc-rtkit-6.15' of https://github.com/AsahiLinux/linux into soc/drivers
      Merge tag 'smccc-update-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'ffa-updates-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/drivers
      firmware: arm_scmi: use ioread64() instead of ioread64_hi_lo()
      Merge tag 'mtk-soc-for-v6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into soc/drivers
      soc: samsung: include linux/array_size.h where needed
      reset: imx: fix incorrect module device table
      Merge tag 'tegra-for-6.15-soc' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.15-firmware' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'samsung-drivers-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'samsung-soc-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'imx-drivers-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'reset-for-v6.15' of git://git.pengutronix.de/pza/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.15-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'zynqmp-soc-for-6.15' of https://github.com/Xilinx/linux-xlnx into soc/drivers

Asahi Lina (2):
      soc: apple: rtkit: Check & log more failures
      soc: apple: rtkit: Pass the crashlog to the crashed() callback

Chenyuan Yang (1):
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()

Christophe JAILLET (2):
      bus: qcom-ssc-block-bus: Remove some duplicated iounmap() calls
      bus: qcom-ssc-block-bus: Fix the error handling path of qcom_ssc_block_bus_probe()

Claudiu Beznea (2):
      soc: renesas: Add SYSC driver for Renesas RZ family
      soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver

Colin Ian King (1):
      firmware: Exynos ACPM: Fix spelling mistake "Faile" -> "Failed"

Fei Shao (1):
      soc: mediatek: mtk-socinfo: Restructure SoC attribute information

Frank Li (2):
      dt-bindings: firmware: imx: add property reset-controller
      reset: imx: Add SCU reset driver for i.MX8QXP and i.MX8QM

Guillaume La Roque (1):
      firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver

Harshit Mogalapalli (1):
      soc: apple: rtkit: Fix use-after-free in apple_rtkit_crashlog_rx()

Hector Martin (1):
      soc: apple: rtkit: Implement OSLog buffers properly

Ivaylo Ivanov (7):
      dt-bindings: soc: samsung: usi: add USIv1 and samsung,exynos8895-usi
      soc: samsung: usi: add a routine for unconfiguring the ip
      soc: samsung: usi: implement support for USIv1 and exynos8895
      dt-bindings: soc: samsung: exynos-sysreg: add sysreg compatibles for exynos2200
      dt-bindings: soc: samsung: exynos-pmu: add exynos2200 compatible
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos2200 compatible
      soc: samsung: exynos-chipid: add exynos2200 SoC support

Janne Grunau (3):
      soc: apple: rtkit: Add and use PWR_STATE_INIT instead of _ON
      soc: apple: rtkit: Use high prio work queue
      soc: apple: rtkit: Cut syslog messages after the first '\0'

Jishnu Prakash (1):
      dt-bindings: soc: qcom: qcom,pmic-glink: Document SM8750 compatible

John Madieu (3):
      soc: renesas: rz-sysc: Add support for RZ/G3E family
      soc: renesas: rz-sysc: Move RZ/V2H SoC detection to the SYS driver
      soc: renesas: r9a09g057-sys: Add a callback to print SoC-specific extra features

Kaustabh Chakraborty (3):
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos7870-chipid compatible
      dt-bindings: soc: samsung: exynos-pmu: add exynos7870-pmu compatible
      soc: samsung: exynos-chipid: add support for exynos7870

Krzysztof Kozlowski (7):
      memory: tegra20-emc: Drop redundant platform_get_irq() error printk
      soc: samsung: Use syscon_regmap_lookup_by_phandle_args
      soc: qcom: Use str_enable_disable-like helpers
      Merge branch 'for-v6.15/samsung-soc-dt-bindings' into next/drivers
      soc: qcom: Do not expose internal servreg_location_entry_ei array
      soc/tegra: pmc: Use str_enable_disable-like helpers
      dt-bindings: soc: samsung: exynos-usi: Drop unnecessary status from example

Louis-Alexis Eyraud (4):
      soc: mediatek: mtk-socinfo: Add entry for MT8370AV/AZA Genio 510
      soc: mediatek: mtk-socinfo: Add entry for MT8390AV/AZA Genio 700
      soc: mediatek: mtk-socinfo: Avoid using machine attribute in SoC detection log
      soc: mediatek: mtk-socinfo: Add extra entry for MT8395AV/ZA Genio 1200

Paul Benoit (1):
      firmware: smccc: Support optional Arm SMCCC SOC_ID name

Rayyan Ansari (1):
      dt-bindings: power: qcom,kpss-acc-v2: add qcom,msm8916-acc compatible

Siva Durga Prasad Paladugu (1):
      firmware: xilinx: Dont send linux address to get fpga config get status

Sudeep Holla (24):
      firmware: arm_scmi: Relax duplicate name constraint across protocol ids
      firmware: arm_scmi: Add name and protocol id attributes
      firmware: arm_scmi: Emit modalias for SCMI devices
      firmware: arm_ffa: Replace SCMI by FF-A in the macro
      firmware: arm_ffa: Replace UUID buffer to standard UUID format
      firmware: arm_ffa: Align sync_send_receive{,2} function prototypes
      firmware: arm_ffa: Fix big-endian support in __ffa_partition_info_get()
      firmware: arm_ffa: Fix big-endian support in __ffa_partition_info_regs_get()
      firmware: arm_ffa: Handle the presence of host partition in the partition info
      firmware: arm_ffa: Unregister the FF-A devices when cleaning up the partitions
      firmware: arm_ffa: Helper to check if a partition can receive REQUEST2 messages
      firmware: arm_ffa: Add support for passing UUID in FFA_MSG_SEND2
      firmware: arm_ffa: Upgrade FF-A version to v1.2 in the driver
      firmware: arm_ffa: Reject higher major version as incompatible
      firmware: arm_ffa: Remove unnecessary declaration of ffa_partitions_cleanup()
      firmware: arm_ffa: Refactoring to prepare for framework notification support
      firmware: arm_ffa: Stash ffa_device instead of notify_type in notifier_cb_info
      firmware: arm_ffa: Add support for {un,}registration of framework notifications
      firmware: arm_ffa: Add support for handling framework notifications
      firmware: arm_ffa: Allow multiple UUIDs per partition to register SRI callback
      firmware: arm_ffa: Handle ffa_notification_get correctly at virtual FF-A instance
      firmware: arm_ffa: Explicitly cast return value from FFA_VERSION before comparison
      firmware: arm_ffa: Explicitly cast return value from NOTIFICATION_INFO_GET
      firmware: arm_ffa: Skip the first/partition ID when parsing vCPU list

Thomas Zimmermann (1):
      ARM: s3c: Do not include <linux/fb.h>

Tudor Ambarus (7):
      soc: qcom: ice: introduce devm_of_qcom_ice_get
      mmc: sdhci-msm: fix dev reference leaked through of_qcom_ice_get
      scsi: ufs: qcom: fix dev reference leaked through of_qcom_ice_get
      soc: qcom: ice: make of_qcom_ice_get() static
      dt-bindings: firmware: add google,gs101-acpm-ipc
      firmware: add Exynos ACPM protocol driver
      MAINTAINERS: add entry for the Samsung Exynos ACPM mailbox protocol

Varshini Rajendran (1):
      dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7

Viken Dadhaniya (1):
      dt-bindings: qcom: geni-se: Add 'firmware-name' property for firmware loading

Viresh Kumar (2):
      firmware: arm_ffa: Refactor addition of partition information into XArray
      firmware: arm_ffa: Set dma_mask for ffa devices

Xianwei Zhao (2):
      dt-bindings: interrupt-controller: Add support for Amlogic A4 and A5 SoCs
      irqchip: Add support for Amlogic A4 and A5 SoCs

Xueqi Zhang (1):
      memory: mtk-smi: Add ostd setting for mt8192

Zhu Jun (1):
      firmware: tegra: bpmp: Fix typo in bpmp-abi.h

 .../devicetree/bindings/firmware/fsl,scu.yaml      |  12 +
 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  50 ++
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |   2 +
 .../amlogic,meson-gpio-intc.yaml                   |  19 +-
 .../bindings/power/qcom,kpss-acc-v2.yaml           |   4 +-
 .../bindings/reset/atmel,at91sam9260-reset.yaml    |   4 +
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   5 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   1 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |   2 +
 .../bindings/soc/samsung/exynos-usi.yaml           | 100 ++-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |   5 +
 MAINTAINERS                                        |  11 +
 arch/arm/mach-s3c/devs.c                           |   1 -
 arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c         |   1 -
 drivers/bus/qcom-ssc-block-bus.c                   |  34 +-
 drivers/firmware/Kconfig                           |   2 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_ffa/bus.c                     |  14 +-
 drivers/firmware/arm_ffa/driver.c                  | 532 ++++++++++----
 drivers/firmware/arm_scmi/bus.c                    |  69 +-
 drivers/firmware/arm_scmi/driver.c                 |  10 -
 drivers/firmware/samsung/Kconfig                   |  14 +
 drivers/firmware/samsung/Makefile                  |   4 +
 drivers/firmware/samsung/exynos-acpm-pmic.c        | 224 ++++++
 drivers/firmware/samsung/exynos-acpm-pmic.h        |  29 +
 drivers/firmware/samsung/exynos-acpm.c             | 769 +++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm.h             |  23 +
 drivers/firmware/smccc/soc_id.c                    |  80 +++
 drivers/firmware/xilinx/zynqmp.c                   |   6 +-
 drivers/irqchip/irq-meson-gpio.c                   |  48 +-
 drivers/memory/mtk-smi.c                           |  33 +
 drivers/memory/tegra/tegra20-emc.c                 |   4 +-
 drivers/mmc/host/sdhci-msm.c                       |   2 +-
 drivers/nvme/host/apple.c                          |   2 +-
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-imx-scu.c                      | 101 +++
 drivers/soc/apple/rtkit-internal.h                 |   1 +
 drivers/soc/apple/rtkit.c                          | 112 ++-
 drivers/soc/mediatek/mt8167-mmsys.h                |  31 +-
 drivers/soc/mediatek/mt8173-mmsys.h                |  99 ++-
 drivers/soc/mediatek/mt8183-mmsys.h                |  50 +-
 drivers/soc/mediatek/mt8186-mmsys.h                |  88 +--
 drivers/soc/mediatek/mt8188-mmsys.h                | 266 ++++---
 drivers/soc/mediatek/mt8192-mmsys.h                |  71 +-
 drivers/soc/mediatek/mt8195-mmsys.h                | 632 ++++++++---------
 drivers/soc/mediatek/mt8365-mmsys.h                |  84 +--
 drivers/soc/mediatek/mtk-mmsys.h                   |  14 +
 drivers/soc/mediatek/mtk-mutex.c                   |   6 +
 drivers/soc/mediatek/mtk-socinfo.c                 |  22 +-
 drivers/soc/qcom/ice.c                             |  51 +-
 drivers/soc/qcom/pdr_internal.h                    |   1 -
 drivers/soc/qcom/qcom_aoss.c                       |   3 +-
 drivers/soc/qcom/qcom_pd_mapper.c                  |  12 +
 drivers/soc/qcom/qcom_pdr_msg.c                    |   3 +-
 drivers/soc/renesas/Kconfig                        |  18 +
 drivers/soc/renesas/Makefile                       |   4 +
 drivers/soc/renesas/r9a08g045-sysc.c               |  23 +
 drivers/soc/renesas/r9a09g047-sys.c                |  67 ++
 drivers/soc/renesas/r9a09g057-sys.c                |  67 ++
 drivers/soc/renesas/renesas-soc.c                  |  33 +-
 drivers/soc/renesas/rz-sysc.c                      | 137 ++++
 drivers/soc/renesas/rz-sysc.h                      |  46 ++
 drivers/soc/samsung/exynos-asv.c                   |   1 +
 drivers/soc/samsung/exynos-chipid.c                |   5 +
 drivers/soc/samsung/exynos-pmu.c                   |   1 +
 drivers/soc/samsung/exynos-usi.c                   | 108 ++-
 drivers/soc/samsung/exynos3250-pmu.c               |   1 +
 drivers/soc/samsung/exynos5250-pmu.c               |   1 +
 drivers/soc/samsung/exynos5420-pmu.c               |   1 +
 drivers/soc/tegra/pmc.c                            |   3 +-
 drivers/soc/ti/k3-socinfo.c                        |  13 +-
 drivers/ufs/host/ufs-qcom.c                        |   2 +-
 include/dt-bindings/soc/samsung,exynos-usi.h       |  17 +-
 include/linux/arm-smccc.h                          |  40 ++
 include/linux/arm_ffa.h                            |  22 +-
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  49 ++
 include/linux/soc/apple/rtkit.h                    |   2 +-
 include/soc/qcom/ice.h                             |   3 +-
 include/soc/tegra/bpmp-abi.h                       |   2 +-
 80 files changed, 3325 insertions(+), 1113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
 create mode 100644 drivers/firmware/samsung/Kconfig
 create mode 100644 drivers/firmware/samsung/Makefile
 create mode 100644 drivers/firmware/samsung/exynos-acpm-pmic.c
 create mode 100644 drivers/firmware/samsung/exynos-acpm-pmic.h
 create mode 100644 drivers/firmware/samsung/exynos-acpm.c
 create mode 100644 drivers/firmware/samsung/exynos-acpm.h
 create mode 100644 drivers/reset/reset-imx-scu.c
 create mode 100644 drivers/soc/renesas/r9a08g045-sysc.c
 create mode 100644 drivers/soc/renesas/r9a09g047-sys.c
 create mode 100644 drivers/soc/renesas/r9a09g057-sys.c
 create mode 100644 drivers/soc/renesas/rz-sysc.c
 create mode 100644 drivers/soc/renesas/rz-sysc.h
 create mode 100644 include/linux/firmware/samsung/exynos-acpm-protocol.h

