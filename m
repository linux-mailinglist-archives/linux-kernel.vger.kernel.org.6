Return-Path: <linux-kernel+bounces-176198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032838C2B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DE4B236C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32013B592;
	Fri, 10 May 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="E66hm8Sd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQokH6+B"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2B13B58E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375549; cv=none; b=uX985oy1Q4AWffvy1015PwDAc6UGVgd/puipC6IYpHdT4J8db5eJwHHdlaJvfXx2iPpDgjQjACePKzotT4zti/eJvBDllxbkvBK50i4JJjj9CkgMnIZqKpcyihKvGTUAHG8OCoGo2cSKL5L8a6n0FdSHMw5LB+X5Fh043ENe9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375549; c=relaxed/simple;
	bh=f86+TxzGn13rWLjGd3H4EE3V3H3eUAa6Y5fUqK4cnZ0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DqMAwyPH6noUd0t/UYIn0xdySOG67ypXZK7kLvrPJmzAwLTjmQJ/IvMC7bjeQ9qan3G3lruwxkaAlcmcWRGOqcUZ87uMUkHnYxI2BwFp7zQCkIwmelifaI8csHyNWqeaYLPcVMrR2UNurpDShCmrOuPZ8fq9/u9AKfC33V3LynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=E66hm8Sd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQokH6+B; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5DAB211400D1;
	Fri, 10 May 2024 17:12:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715375546;
	 x=1715461946; bh=gvy9XXWpPyTBtkhqbuYtmp/akVCc8NeJRR+SxVZyIQY=; b=
	E66hm8SdFZZ9L8P18HTELj3HnNG3a+vK1fbH8CnDLuJNmMseijyGeOajRFIHFcXG
	XETcn/99OD0zokDzxca5bxKOIKb6KY0tXbifzRwGbmiQv2PJ5I+3Tw3TpfY/C7a9
	m18h95CTGl1mW0T1I+qcuu4EfnwbN9XdFFHrMyQO7Vtto/jxKcbXF2FzGIIFGt4g
	m81aMU2KJco7kOH/4OsJd40xdwMUEcgeTRO3mZ/qayIUGeQt8Gc4j7Zm4Fe+j3Ef
	6dU3b+7Y9e59o6z7S+atTjg6JUct7+jKF8lE9lwR/O/Z5UoGceEGoilu47JlDX4n
	uCxESXnbICzTyz2kqNsjLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715375546; x=
	1715461946; bh=gvy9XXWpPyTBtkhqbuYtmp/akVCc8NeJRR+SxVZyIQY=; b=g
	QokH6+BzMUivLSYSzwMPxhIBhXqJw3bb6f/ApVVk6QsVA69BAgYDOjQydGffu3JI
	0mKz+BqOhNHd2JVfn8Em0ehV0B1VKuzUS2g+MAunullB71mdw78+uSr0y1PIHGHD
	uWdv6oJ+Hi4I1Aav8i5zIbVgtNhDDwcBOwbxWRzW6E+2DlikKimehUkIMLLxQUpJ
	PGKd4rq2QU7SRf8JJUkT+cfO866b4AVHL0UD4DTWRzCFfdQBYF3+QSvlMus/ht6Q
	hodOXA/W98/uFyzdCrD0PT6ULZrcMan8z36Rbgskngrp5hR+VOTqK4976RyLK7Sb
	6aqHMoTr3rEB948cXE6ug==
X-ME-Sender: <xms:uo0-ZmNofBA1oQZag5LpvsnF5AEFANwNTfsAl14yyA3Sk-XeS6IWWQ>
    <xme:uo0-Zk-A-yeyCneUZlnd40ZJwFFgmGZXEfBWvqaot2W-OaDnrql06mLoxXjS6sDWI
    QswsirOCy3IcpaTjMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepieefffeujeehfeegteffgfejvedukeeftefgtdekheejteeliedvkeeu
    hfeigfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpd
    hlihhnrghrohdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:uo0-ZtTzkL3W3JywVLMoqTi4VDKw1h9FQ6ETLgjwps31-M7bmekE3w>
    <xmx:uo0-Zmu1G9axuQCVIDKUffq7LlRbJPnQmwNdwV52oW_lfWCVt7HO-g>
    <xmx:uo0-ZuckslM--hmqpEqvOdaguL6dWAsiNTPOHNwFWpZLiNmJL93X0A>
    <xmx:uo0-Zq3c24cXVmpx_VbeHjjroD1FJgcVNJvTRi38tsJQ-SlD2-h1ng>
    <xmx:uo0-Zu5KEE_sRhENL1N80eZL3hVKvj6QplAVRjUOS5KM6wOUmCl5jeFX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1B4B6B6008D; Fri, 10 May 2024 17:12:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1cba2868-92f1-45af-be93-2ad6cb59e86a@app.fastmail.com>
In-Reply-To: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
Date: Fri, 10 May 2024 23:12:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/4] soc: drivers for 6.10
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit fec50db7033ea478773b159e0e2efb135270e=
3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.10

for you to fetch changes up to 1c97fe39fbac69b2e1070ace7f625a8224116ffd:

  Merge tag 'qcom-drivers-for-6.10-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/drivers (2024-05-08 08:45:26 +0200)

----------------------------------------------------------------
soc: drivers for 6.10

As usual, these are updates for drivers that are specific to certain
SoCs or firmware running on them. Notable updates include

 - The new STMicroelectronics STM32 "firewall" bus driver that is
   used to provide a barrier between different parts of an SoC

 - Lots of updates for the Qualcomm platform drivers, in particular
   SCM, which gets a rewrite of its initialization code

 - Firmware driver updates for Arm FF-A notification interrupts
   and indirect messaging, SCMI firmware support for pin control
   and vendor specific interfaces, and TEE firmware interface
   changes across multiple TEE drivers

 - A larger cleanup of the Mediatek CMDQ driver and some related bits

 - Kconfig changes for riscv drivers to prepare for adding Kanaan
   k230 support

 - Multiple minor updates for the TI sysc bus driver, memory controllers,
   hisilicon hccs and more

----------------------------------------------------------------
Abel Vesa (3):
      dt-bindings: arm: qcom,ids: Add SoC ID for X1E80100
      soc: qcom: socinfo: Add X1E80100 SoC ID table entry
      soc: qcom: socinfo: Add SMB2360 PMIC

Andrew Davis (3):
      firmware: ti_sci: Use devm_register_restart_handler()
      firmware: ti_sci: Unconditionally register reset handler
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer m=
essage

AngeloGioacchino Del Regno (3):
      soc: mediatek: socinfo: Advertise about unknown MediaTek SoC
      soc: mediatek: mtk-mutex: Add support for MT8188 VPPSYS
      soc: mediatek: mtk-socinfo: Add entry for MT8395AV/ZA Genio 1200

Arnd Bergmann (17):
      firmware: arm_scmi: Avoid non-constant printk format strings
      Merge tag 'renesas-drivers-for-v6.10-tag1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'hisi-drivers-for-6.10' of https://github.com/hisilicon/=
linux-hisi into soc/drivers
      Merge tag 'stm32-bus-firewall-for-v6.10-1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/atorgue/stm32 into soc/drivers
      Merge tag 'tegra-for-6.10-soc' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.10' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'drivers-ti-sysc-for-v6.10-signed' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/drivers
      Merge tag 'memory-controller-drv-6.10' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'mtk-soc-for-v6.10' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'optee-convert-platform-remove-callback-for-v6.10' of ht=
tps://git.linaro.org/people/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'tee-ts-for-v6.10' of https://git.linaro.org/people/jens=
wiklander/linux-tee into soc/drivers
      Merge tag 'scmi-updates-6.10' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'ffa-updates-6.10' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'arm-soc/for-6.10/drivers' of https://github.com/Broadco=
m/stblinux into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.10' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'riscv-config-for-v6.10' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.10-2' of https://git.kernel.org/pub/=
scm/linux/kernel/git/qcom/linux into soc/drivers

Balint Dobszay (4):
      tee: optee: Move pool_op helper functions
      tee: tstee: Add Trusted Services TEE driver
      Documentation: tee: Add TS-TEE driver
      MAINTAINERS: tee: tstee: Add entry

Bjorn Andersson (4):
      Merge branch 'drivers-for-6.10' onto 'v6.9-rc1'
      MAINTAINERS: Split Qualcomm SoC and linux-arm-msm entries
      soc: qcom: pmic_glink: Make client-lock non-sleeping
      firmware: qcom: uefisecapp: Allow on sc8180x Primus and Flex 5G

Chun-Kuang Hu (7):
      soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE
      soc: mediatek: cmdq: Add parameter shift_pa to cmdq_pkt_jump()
      soc: mediatek: cmdq: Rename cmdq_pkt_jump() to cmdq_pkt_jump_abs()
      soc: mediatek: cmdq: Add cmdq_pkt_jump_rel() helper function
      soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper function
      soc: mediatek: cmdq: Remove cmdq_pkt_flush_async() helper function
      soc: mediatek: cmdq: Refine cmdq_pkt_create() and cmdq_pkt_destroy=
()

Conor Dooley (4):
      RISC-V: Drop unused SOC_CANAAN
      RISC-V: drop SOC_MICROCHIP_POLARFIRE for ARCH_MICROCHIP
      RISC-V: drop SOC_SIFIVE for ARCH_SIFIVE
      RISC-V: drop SOC_VIRT for ARCH_VIRT

Cristian Marussi (6):
      include: trace: Widen the tag buffer in trace_scmi_dump_msg
      firmware: arm_scmi: Add helper to trace bad messages
      firmware: arm_scmi: Add message dump traces for bad and unexpected=
 replies
      firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
      firmware: arm_scmi: Use dev_err_probe to bail out
      firmware: arm_scmi: Add support for multiple vendors custom protoc=
ols

Dan Carpenter (2):
      firmware: arm_ffa: Fix memory corruption in ffa_msg_send2()
      bus: stm32_firewall: fix off by one in stm32_firewall_get_firewall=
()

Dmitry Baryshkov (2):
      soc: qcom: pmic_glink: don't traverse clients list without a lock
      soc: qcom: pmic_glink: notify clients about the current state

Gabor Juhos (2):
      firmware: qcom_scm: disable clocks if qcom_scm_bw_enable() fails
      firmware: qcom_scm: remove IS_ERR() checks from qcom_scm_bw_{en,di=
s}able()

Gatien Chevallier (7):
      dt-bindings: treewide: add access-controllers description
      dt-bindings: bus: document RIFSC
      dt-bindings: bus: document ETZPC
      firewall: introduce stm32_firewall framework
      of: property: fw_devlink: Add support for "access-controller"
      bus: rifsc: introduce RIFSC firewall controller driver
      bus: etzpc: introduce ETZPC firewall controller driver

Geert Uytterhoeven (1):
      soc: renesas: Enable TMU support on R-Car Gen2

Huisong Li (2):
      soc: hisilicon: kunpeng_hccs: Add the check for obtaining complete=
 port attribute
      soc: hisilicon: kunpeng_hccs: replace MAILBOX dependency with PCC

Jason-JH.Lin (4):
      soc: mediatek: mtk-cmdq: Add specific purpose register definitions=
 for GCE
      soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move() function
      soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr() function
      soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event() function

Jason-ch Chen (1):
      soc: mediatek: mtk-socinfo: Correct the marketing name for MT8188GV

Jens Wiklander (2):
      firmware: arm_ffa: Skip creation of the notification bitmaps
      firmware: arm_ffa: Add support for handling notification pending i=
nterrupt(NPI)

Johan Hovold (1):
      dt-bindings: soc: qcom,wcnss: fix bluetooth address example

Jon Hunter (1):
      soc/tegra: pmc: Add EQOS wake event for Tegra194 and Tegra234

Justin Stitt (1):
      soc: qcom: cmd-db: replace deprecated strncpy with strtomem

Krzysztof Kozlowski (6):
      dt-bindings: memory-controllers: add Samsung S5Pv210 SoC DMC
      firmware: qcom: qcm: fix unused qcom_scm_qseecom_allowlist
      bus: brcmstb_gisb: fix module autoloading
      memory: brcmstb_memc: fix module autoloading
      memory: mtk-smi: fix module autoloading
      soc: qcom: mention intentionally broken module autoloading

Lad Prabhakar (1):
      soc: renesas: Add identification support for RZ/V2H SoC

Luca Weiss (1):
      dt-bindings: soc: qcom: qcom,pmic-glink: document QCM6490 compatib=
le

Maulik Shah (3):
      soc: qcom: Update init level to core_initcall() for cmd-db and rpm=
h-rsc
      soc: qcom: qcom_stats: Add DSPs and apss subsystem stats
      soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request

Mukesh Ojha (5):
      firmware: qcom: scm: Remove log reporting memory allocation failure
      firmware: qcom: scm: Remove redundant scm argument from qcom_scm_w=
aitq_wakeup()
      firmware: qcom: scm: Rework dload mode availability check
      firmware: qcom: scm: Fix __scm and waitq completion variable initi=
alization
      firmware: qcom: scm: Modify only the download bits in TCSR register

N=C3=ADcolas F. R. A. Prado (1):
      soc: mediatek: cmdq: Don't log an error when gce-client-reg is not=
 found

Oleksii Moisieiev (1):
      dt-bindings: document generic access controllers

Peng Fan (5):
      firmware: arm_scmi: Log the perf domain names in the error paths
      firmware: arm_scmi: Introduce get_max_msg_size() helper/accessor
      dt-bindings: firmware: Support SCMI pinctrl protocol
      firmware: arm_scmi: Add basic support for SCMI v3.2 pincontrol pro=
tocol
      pinctrl: Implementation of the generic scmi-pinctrl driver

Sudeep Holla (5):
      firmware: arm_ffa: Refactor SRI handling in prepartion to add NPI =
support
      firmware: arm_ffa: Fix kernel warning about incorrect SRI/NPI
      firmware: arm_ffa: Stash the partition properties for query purpos=
es
      firmware: arm_ffa: Add support for FFA_MSG_SEND2
      firmware: arm_ffa: Avoid queuing work when running on the worker q=
ueue

Sumit Garg (1):
      tee: Refactor TEE subsystem header files

Tony Lindgren (5):
      bus: ti-sysc: Move check for no-reset-on-init
      bus: ti-sysc: Add a description and copyrights
      bus: ti-sysc: Drop legacy quirk handling for uarts
      bus: ti-sysc: Drop legacy quirk handling for smartreflex
      bus: ti-sysc: Drop legacy idle quirk handling

Ulf Hansson (1):
      dt-bindings: firmware: arm,scmi: Update examples for protocol@13

Uwe Kleine-K=C3=B6nig (1):
      tee: optee: smc: Convert to platform remove callback returning void

Yangyu Chen (6):
      riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
      soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
      clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
      pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
      reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
      riscv: config: enable ARCH_CANAAN in defconfig

wangkaiyuan (1):
      soc: qcom: icc-bwmon: Convert to use maple tree register cache

 .../access-controllers/access-controllers.yaml     |  84 ++
 .../devicetree/bindings/bus/st,stm32-etzpc.yaml    |  96 +++
 .../bindings/bus/st,stm32mp25-rifsc.yaml           | 105 +++
 .../devicetree/bindings/crypto/st,stm32-cryp.yaml  |   4 +
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |   4 +
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |   4 +
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |   4 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  54 +-
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |   4 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   4 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |   4 +
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  |   4 +
 .../bindings/media/cec/st,stm32-cec.yaml           |   4 +
 .../devicetree/bindings/media/st,stm32-dcmi.yaml   |   4 +
 .../memory-controllers/samsung,s5pv210-dmc.yaml    |  33 +
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |   4 +
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   4 +
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |   4 +
 .../devicetree/bindings/mmc/arm,pl18x.yaml         |   4 +
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |   4 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   4 +
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   4 +
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |   4 +
 .../devicetree/bindings/rng/st,stm32-rng.yaml      |   4 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   4 +
 .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |   4 +-
 .../devicetree/bindings/sound/st,stm32-i2s.yaml    |   4 +
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |   4 +
 .../bindings/sound/st,stm32-spdifrx.yaml           |   4 +
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   4 +
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |   4 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   4 +
 Documentation/tee/index.rst                        |   1 +
 Documentation/tee/ts-tee.rst                       |  71 ++
 MAINTAINERS                                        |  51 +-
 arch/arm/mach-stm32/Kconfig                        |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/riscv/Kconfig.socs                            |  22 +-
 arch/riscv/Makefile                                |   2 +-
 arch/riscv/configs/defconfig                       |   7 +-
 arch/riscv/configs/nommu_k210_defconfig            |   3 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |   3 +-
 arch/riscv/configs/nommu_virt_defconfig            |   2 +-
 drivers/bus/Kconfig                                |  10 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/brcmstb_gisb.c                         |   1 +
 drivers/bus/stm32_etzpc.c                          | 141 ++++
 drivers/bus/stm32_firewall.c                       | 294 +++++++
 drivers/bus/stm32_firewall.h                       |  83 ++
 drivers/bus/stm32_rifsc.c                          | 252 ++++++
 drivers/bus/ti-sysc.c                              | 165 +---
 drivers/clk/Kconfig                                |   4 +-
 drivers/firmware/arm_ffa/driver.c                  | 187 ++++-
 drivers/firmware/arm_scmi/Makefile                 |   3 +-
 drivers/firmware/arm_scmi/common.h                 |  11 +
 drivers/firmware/arm_scmi/driver.c                 | 269 +++++-
 drivers/firmware/arm_scmi/mailbox.c                |   3 +
 drivers/firmware/arm_scmi/notify.c                 |  30 +-
 drivers/firmware/arm_scmi/perf.c                   |  15 +-
 drivers/firmware/arm_scmi/pinctrl.c                | 916 ++++++++++++++=
+++++++
 drivers/firmware/arm_scmi/protocols.h              |  18 +
 drivers/firmware/qcom/qcom_scm.c                   |  81 +-
 drivers/firmware/ti_sci.c                          |  24 +-
 drivers/memory/brcmstb_memc.c                      |   1 +
 drivers/memory/mtk-smi.c                           |   2 +
 drivers/of/property.c                              |   2 +
 drivers/pinctrl/Kconfig                            |  15 +-
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 571 +++++++++++++
 drivers/reset/Kconfig                              |   4 +-
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/canaan/Kconfig                         |   4 +-
 drivers/soc/hisilicon/Kconfig                      |   2 +-
 drivers/soc/hisilicon/kunpeng_hccs.c               |   6 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 163 +++-
 drivers/soc/mediatek/mtk-mutex.c                   |  41 +
 drivers/soc/mediatek/mtk-socinfo.c                 |  14 +-
 drivers/soc/qcom/cmd-db.c                          |  41 +-
 drivers/soc/qcom/icc-bwmon.c                       |   8 +-
 drivers/soc/qcom/pmic_glink.c                      |  26 +-
 drivers/soc/qcom/pmic_pdcharger_ulog.c             |   4 +
 drivers/soc/qcom/qcom_stats.c                      |   4 +
 drivers/soc/qcom/rpm_master_stats.c                |   4 +
 drivers/soc/qcom/rpmh-rsc.c                        |   5 +-
 drivers/soc/qcom/socinfo.c                         |   2 +
 drivers/soc/renesas/Kconfig                        |   6 +
 drivers/soc/renesas/renesas-soc.c                  |  20 +-
 drivers/soc/tegra/pmc.c                            |   2 +
 drivers/soc/ti/wkup_m3_ipc.c                       |   7 +-
 drivers/tee/Kconfig                                |   1 +
 drivers/tee/Makefile                               |   1 +
 drivers/tee/amdtee/amdtee_private.h                |   2 +-
 drivers/tee/amdtee/call.c                          |   2 +-
 drivers/tee/amdtee/core.c                          |   3 +-
 drivers/tee/amdtee/shm_pool.c                      |   2 +-
 drivers/tee/optee/call.c                           |   2 +-
 drivers/tee/optee/core.c                           |  66 +-
 drivers/tee/optee/device.c                         |   2 +-
 drivers/tee/optee/ffa_abi.c                        |   8 +-
 drivers/tee/optee/notif.c                          |   2 +-
 drivers/tee/optee/optee_private.h                  |  14 +-
 drivers/tee/optee/rpc.c                            |   2 +-
 drivers/tee/optee/smc_abi.c                        |  17 +-
 drivers/tee/tee_core.c                             |   2 +-
 drivers/tee/tee_private.h                          |  35 -
 drivers/tee/tee_shm.c                              |  67 +-
 drivers/tee/tee_shm_pool.c                         |   2 +-
 drivers/tee/tstee/Kconfig                          |  11 +
 drivers/tee/tstee/Makefile                         |   3 +
 drivers/tee/tstee/core.c                           | 480 +++++++++++
 drivers/tee/tstee/tstee_private.h                  |  92 +++
 include/dt-bindings/arm/qcom,ids.h                 |   1 +
 include/linux/arm_ffa.h                            |  27 +
 include/linux/bus/stm32_firewall_device.h          | 142 ++++
 include/linux/platform_data/ti-sysc.h              |   1 -
 include/linux/scmi_protocol.h                      |  86 +-
 include/linux/soc/mediatek/mtk-cmdq.h              | 139 +++-
 include/linux/tee_core.h                           | 306 +++++++
 include/linux/tee_drv.h                            | 285 +------
 include/soc/qcom/cmd-db.h                          |  10 +-
 include/trace/events/scmi.h                        |   6 +-
 include/uapi/linux/tee.h                           |   1 +
 tools/testing/kunit/qemu_configs/riscv.py          |   2 +-
 .../selftests/wireguard/qemu/arch/riscv32.config   |   2 +-
 .../selftests/wireguard/qemu/arch/riscv64.config   |   2 +-
 125 files changed, 5116 insertions(+), 819 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/access-controllers=
/access-controllers.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/st,stm32-etzpc=
yaml
 create mode 100644 Documentation/devicetree/bindings/bus/st,stm32mp25-r=
ifsc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/samsung,s5pv210-dmc.yaml
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/bus/stm32_etzpc.c
 create mode 100644 drivers/bus/stm32_firewall.c
 create mode 100644 drivers/bus/stm32_firewall.h
 create mode 100644 drivers/bus/stm32_rifsc.c
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h
 create mode 100644 include/linux/bus/stm32_firewall_device.h
 create mode 100644 include/linux/tee_core.h

