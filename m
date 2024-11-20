Return-Path: <linux-kernel+bounces-416400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4BA9D4441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10466B213EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE21586C8;
	Wed, 20 Nov 2024 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YAk6I8zN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vXqrLVxI"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF381BC097
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143703; cv=none; b=L6UCc5a++pUEWVrN1TtMSqfeOYwHbkWxMvPh6mQv3O8mREej6tqOPOEpuT5o18KVhrXHjYqc63G7cdSt2zMuku+BYdTvZ3GswH+0mtKl0xEXwDEAMxuKqeq38s+Hz3swkz4rs1i+KkMl9wkge2437XwIbNe9UFowoeAsr8AIKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143703; c=relaxed/simple;
	bh=odCl4rngO+Jr11TXEzuqntRbY15dvn9eRn7Rq8yzLUI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hjXG5Fw/wad/wKxhCZRHz8rM6REPJSKuwntnmnhDs5a3L5LMUyJaaTnMGlZSYKu3mSEahMWdeUxPxRLR1Lu/9p2trWJeLAF/32lfFwfyKCCI0y1v/MdgEFz6UsOcgW2Q8TgFfMavFP10wSSNGpv9GMVue//wXZe6dNIIKbelQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YAk6I8zN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vXqrLVxI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 66B2C138024F;
	Wed, 20 Nov 2024 18:01:40 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 18:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732143700;
	 x=1732230100; bh=JkSQzdxZR0eUhkdqjYv9fjHNDZi97MgPjMRaPX6jnmA=; b=
	YAk6I8zNq2NbCL5EBBUd4PNcaVouDuL33EdxqVKWO2Fp7h4s1BMnhsxkjkaWqWwp
	5TvuwMzikrMr7rogWyfZ1+z1hWhu6Mx2oL2bsIW+8OT1HTW1FwKv2rumLNfXI2JR
	9dTd9ZdXnYvS8AF/u3XAK1wjp3hq8qy1WYG0bDXNkcynNOQzxmF/IAiC3XUf1dHm
	lhSUMNG3FI54gA51PyhzyRdZPyxaDSVGgHXLHmcNldYUYTSP0Fk2C/DQJujVTv0H
	mezEIQVRWXaH9yGhECIbrg9cAwoWtvZcnVxCnWXVupgOBvqEV0dizDMFS+uWOu+1
	pibJUj0z37F/UV7xNBlJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732143700; x=
	1732230100; bh=JkSQzdxZR0eUhkdqjYv9fjHNDZi97MgPjMRaPX6jnmA=; b=v
	XqrLVxIJgiAHmQMaXxhiNcjo8GVM9uqOUtA+U2pJGxwbX18ptu3GvOBAY2v/z6Zy
	F0mV4uedO0mnKHXgs0AP5WcKyNiYpVXoMDUBVAyv0NELPqqpHJwpJ/EsyTbJEZ36
	Y/ItMAIba68Rq/QsMnQX28y3yUDgUrEbb63e4fLoXubRx4L89AKKg1Tc1gHW+Eue
	FmfVnxOE14BqgxY6AADE+FX0j5enpVSUSCaApMSs4Hq7IHEkA3u81DPYIs0pV27m
	N7vC4oTCtZfWfKCzs0mdzUaZMUnuqOEPotiTePGVNmNmnuky6ZuQX9L5J6Dmxr4k
	+ypXBUZ7ZsPe+Gb22fSzw==
X-ME-Sender: <xms:VGo-Z18B7jaSH3FNRE7zMtqsH8mpGthhCnw5ptbTbnAGtGTO4gSMxQ>
    <xme:VGo-Z5sLHCZ-Z9LVMkKURcSjWydwb3INqH6nKJMe81lgAAcC-1kHpUbv3q1KDnv_H
    R3Fl6TBw-bFQmtlYqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeejfefhleeigfevudekleekkeeujeeutdeigefgveek
    tdejieffudegtdejueelueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhdpphgvnhhguhhtrhhonhhigidruggvnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghl
    ughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VGo-ZzCLooCvpTp9VZhrIcGhvUpKruZqFfwIqzk-I7ZKeLnR61l3oA>
    <xmx:VGo-Z5fPZQMAsRW3N5HhQWBA6uDn9AAIyL-9kDO4fWOUJmAPYHahQQ>
    <xmx:VGo-Z6PRUnhE7d0iJDd0Lp-2Gi_5lzTgVlcR5nXWiMzXVgwBpXiQdA>
    <xmx:VGo-Z7lQxsAnweHJ3rv8gh_ZRrdUMB8W5pLpEVQaS9Z5GWlPvgE0JA>
    <xmx:VGo-Z3q0GH05AgDBa2ywocR6eI8EUweLb08jzdii27sH5hIHAiXHmM7z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A4B72220073; Wed, 20 Nov 2024 18:01:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 00:01:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <0fe1a527-1c58-4ae5-963a-3becfb8ba28a@app.fastmail.com>
In-Reply-To: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
Subject: [GIT PULL 2/4] soc: driver updates for 6.12
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600=
924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.13

for you to fetch changes up to b77587ac51d2fe4b9d5751662ddc083d19153662:

  Merge tag 'soc_fsl-6.13-1' of https://github.com/chleroy/linux into so=
c/drivers (2024-11-15 15:19:47 +0100)

----------------------------------------------------------------
soc: driver updates for 6.12

Nothing particular important in the SoC driver updates, just the usual
improvements to for drivers/soc and a couple of subsystems that don't
fit anywhere else:

 - The largest set of updates is for Qualcomm SoC drivers, extending the
   set of supported features for additional SoCs in the QSEECOM, LLCC
   and socinfo drivers.a

 - The ti_sci firmware driver gains support for power managment

 - The drivers/reset subsystem sees a rework of the microchip
   sparx5 and amlogic reset drivers to support additional chips,
   plus a few minor updates on other platforms

 - The SCMI firmware interface driver gains support for two protocol
   extensions, allowing more flexible use of the shared memory area
   and new DT binding properties for configurability.

 - Mediatek SoC drivers gain support for power managment on the MT8188
   SoC and a new driver for DVFS.

 - The AMD/Xilinx ZynqMP SoC drivers gain support for system reboot
   and a few bugfixes

 - The Hisilicon Kunpeng HCCS driver gains support for configuring
   lanes through sysfs

Finally, there are cleanups and minor fixes for drivers/soc, drivers/bus,
and drivers/memory, including changing back the .remove_new callback
to .remove, as well as a few other updates for freescale (powerpc)
soc drivers, NXP i.MX soc drivers, cznic turris platform driver, memory
controller drviers, TI OMAP SoC drivers, and Tegra firmware drivers

----------------------------------------------------------------
Aleksandrs Vinarskis (1):
      firmware: qcom: scm: Allow QSEECOM on Dell XPS 13 9345

Alessandro Zanni (1):
      soc: ti: knav_qmss_queue: Drop redundant continue statement

Andrew Davis (1):
      firmware: ti_sci: Remove use of of_match_ptr() helper

Andrew Kreimer (1):
      thermal/ti-soc-thermal: Fix typos

AngeloGioacchino Del Regno (4):
      dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8=
195
      soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
      soc: mediatek: mtk-cmdq: Move mask build and append to function
      soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration

Arnd Bergmann (13):
      Merge tag 'hisi-drivers-for-6.13' of https://github.com/hisilicon/=
linux-hisi into arm/drivers
      Merge tag 'tegra-for-6.13-firmware' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into arm/drivers
      Merge tag 'memory-controller-drv-6.13' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'zynqmp-soc-for-6.13' of https://github.com/Xilinx/linux=
-xlnx into arm/drivers
      Merge tag 'qcom-drivers-for-6.13' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into arm/drivers
      Merge tag 'imx-drivers-6.13' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/shawnguo/linux into arm/drivers
      Merge tag 'mtk-soc-for-v6.13' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/mediatek/linux into arm/drivers
      Merge tag 'omap-for-v6.13/drivers-signed' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/khilman/linux-omap into arm/drivers
      Merge tag 'scmi-updates-6.13' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'reset-for-v6.13' of git://git.pengutronix.de/pza/linux =
into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.13' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.13-2' of https://git.kernel.org/pub/=
scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'soc_fsl-6.13-1' of https://github.com/chleroy/linux int=
o soc/drivers

Bjorn Andersson (3):
      soc: qcom: pd-mapper: Add QCM6490 PD maps
      firmware: qcom: scm: Introduce CP_SMMU_APERTURE_ID
      drm/msm/adreno: Setup SMMU aparture for per-process page table

Cl=C3=A9ment L=C3=A9ger (2):
      reset: mchp: sparx5: Allow building as a module
      reset: mchp: sparx5: set the dev member of the reset controller

Cristian Marussi (8):
      firmware: arm_scmi: Reject clear channel request on A2P
      dt-bindings: firmware: arm,scmi: Add missing vendor string
      firmware: arm_scmi: Use vendor string in max-rx-timeout-ms
      firmware: arm_scmi: Account for SHMEM memory overhead
      firmware: arm_scmi: Calculate virtio PDU max size dynamically
      dt-bindings: firmware: arm,scmi: Introduce more transport properti=
es
      firmware: arm_scmi: Use max_msg and max_msg_size devicetree proper=
ties
      firmware: arm_scmi: Relocate atomic_threshold to scmi_desc

Dan Carpenter (1):
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()

Dave Gerlach (1):
      firmware: ti_sci: Introduce Power Management Ops

Dmitry Baryshkov (7):
      dt-bindings: arm: qcom,ids: add SoC ID for SAR2130P and SAR1130P
      soc: qcom: socinfo: add SoC IDs for SAR1130P and SAR2130P
      dt-bindings: firmware: qcom,scm: Add SAR2130P compatible
      dt-bindings: soc: qcom,aoss-qmp: Add SAR2130P compatible
      dt-bindings: cache: qcom,llcc: document SAR2130P and SAR1130P
      soc: qcom: llcc: use deciman integers for bit shift values
      soc: qcom: llcc: add support for SAR2130P and SAR1130P

Esben Haabendal (1):
      arm64: defconfig: Update defconfig with now user-visible CONFIG_FS=
L_IFC

Florian Fainelli (2):
      dt-bindings: sram: Document reg-io-width property
      firmware: arm_scmi: Support 'reg-io-width' property for shared mem=
ory

Frank Li (1):
      dt-bindings: memory-controllers: fsl,ifc: split child node differe=
nces

Gaosheng Cui (1):
      drivers: soc: xilinx: add the missing kfree in xlnx_add_cb_for_sus=
pend()

Georgi Vlaev (1):
      firmware: ti_sci: Add support for querying the firmware caps

Herve Codina (7):
      misc: Add support for LAN966x PCI device
      MAINTAINERS: Add the Microchip LAN966x PCI driver entry
      reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x
      reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency
      misc: lan966x_pci: Fix dtc warns 'missing or empty reg/ranges prop=
erty'
      misc: lan966x_pci: Fix dtc warn 'Missing interrupt-parent'
      soc: fsl: cpm1: qmc: Set the ret error code on platform_get_irq() =
failure

Huisong Li (6):
      soc: hisilicon: kunpeng_hccs: Fix a PCC typo
      soc: hisilicon: kunpeng_hccs: Return failure on having not die or =
port information
      soc: hisilicon: kunpeng_hccs: Add the check for base address and s=
ize of shared memory
      soc: hisilicon: kunpeng_hccs: Fix the 'lane_mode' field name in po=
rt info structure to 'max_lane_num'
      soc: hisilicon: kunpeng_hccs: Add used HCCS types sysfs
      soc: hisilicon: kunpeng_hccs: Support low power feature for the sp=
ecified HCCS type

Javier Carrasco (2):
      soc: fsl: cpm1: tsa: switch to for_each_available_child_of_node_sc=
oped()
      soc: fsl: rcpm: fix missing of_node_put() in copy_ippdexpcr1_setti=
ng()

Jerome Brunet (9):
      reset: amlogic: convert driver to regmap
      reset: amlogic: use generic data matching function
      reset: amlogic: make parameters unsigned
      reset: amlogic: add driver parameters
      reset: amlogic: use reset number instead of register count
      reset: amlogic: add reset status support
      reset: amlogic: move drivers to a dedicated directory
      reset: amlogic: split the device core and platform probe
      reset: amlogic: add auxiliary reset driver support

Jingyi Wang (3):
      dt-bindings: soc: qcom: add qcom,qcs8300-imem compatible
      dt-bindings: cache: qcom,llcc: Document the QCS8300 LLCC
      soc: qcom: llcc: Add LLCC configuration for the QCS8300 platform

Jinjie Ruan (2):
      soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
      soc: ti: knav_qmss_queue: Use IRQF_NO_AUTOEN flag in request_irq()

Joe Hattori (1):
      soc: qcom: ice: Remove the device_link field in qcom_ice

Julia Lawall (1):
      soc: qcom: qmi: Reorganize kerneldoc parameter names

J=C3=A9r=C3=B4me de Bretagne (1):
      firmware: qcom: scm: Allow QSEECOM on Microsoft Surface Pro 9 5G

Kevin Hilman (1):
      firmware: ti_sci: add CPU latency constraint management

Konrad Dybcio (3):
      soc: qcom: llcc: Use designated initializers for LLC settings
      soc: qcom: smem: Fix up kerneldoc
      soc: qcom: llcc: Flip the manual slice configuration condition

Krzysztof Kozlowski (5):
      qcom: MAINTAINERS: add linux-msm IRC on OFTC
      soc: qcom: pbs: simplify locking with guard()
      soc: qcom: smem_state: simplify locking with guard()
      dt-bindings: soc: qcom: aoss-qmp: Add SM8750
      Revert "firmware: tegra: bpmp: Use scoped device node handling to =
simplify error paths"

Kyle Deng (1):
      dt-bindings: soc: qcom,aoss-qmp: Document the QCS8300 AOSS channel

Lijuan Gao (2):
      dt-bindings: arm: qcom,ids: add SoC ID for QCS615
      soc: qcom: socinfo: Add QCS615 SoC ID table entry

Luo Qiu (1):
      firmware: arm_scpi: Check the DVFS OPP count returned by the firmw=
are

Manikanta Mylavarapu (2):
      dt-bindings: arm: qcom,ids: add SoC ID for IPQ5424/IPQ5404
      soc: qcom: socinfo: add IPQ5424/IPQ5404 SoC ID

Marek Beh=C3=BAn (3):
      firmware: turris-mox-rwtm: Document the driver private data struct=
ure
      platform: cznic: turris-omnia-mcu: Document the driver private dat=
a structure
      platform: cznic: turris-omnia-mcu: Rename variable holding GPIO li=
ne names

Marek Vasut (3):
      soc: imx8m: Probe the SoC driver as platform driver
      soc: imx8m: Remove global soc_uid
      soc: imx8m: Use devm_* to simplify probe failure handling

Markus Elfring (1):
      soc: mediatek: mtk-svs: Call of_node_put(np) only once in svs_get_=
subsys_device()

Markus Schneider-Pargmann (1):
      PM: QoS: Export dev_pm_qos_read_value

Maya Matuszczyk (1):
      firmware: qcom: scm:  Allow QSEECOM on Lenovo Yoga Slim 7x

Melody Olvera (1):
      dt-bindings: firmware: qcom,scm: Document sm8750 SCM

Nikunj Kela (4):
      dt-bindings: firmware: qcom,scm: document support for SA8255p
      dt-bindings: soc: qcom: aoss-qmp: document support for SA8255p
      dt-bindings: arm: qcom: add the SoC ID for SA8255P
      soc: qcom: socinfo: add support for SA8255P

Pablo Sun (1):
      soc: mediatek: mediatek-regulator-coupler: Support mt8188

Philipp Zabel (4):
      reset: amlogic: Fix small whitespace issue
      reset: replace boolean parameters with flags parameter
      reset: Add devres helpers to request pre-deasserted reset controls
      reset: uniphier-glue: Use devm_reset_control_bulk_get_shared_deass=
erted()

Ronak Jain (5):
      firmware: xilinx: Add missing debug firmware interfaces
      firmware: xilinx: use u32 for reset ID in reset APIs
      firmware: xilinx: add a warning print for unsupported feature
      firmware: xilinx: add support for new SMC call format
      firmware: xilinx: fix feature check logic for TF-A specific APIs

Sibi Sankar (1):
      firmware: qcom: uefisecapp: Allow X1E Devkit devices

Song Xue (2):
      dt-bindings: cache: qcom,llcc: Document the QCS615 LLCC
      soc: qcom: llcc: Add configuration data for QCS615

Tengfei Fan (2):
      dt-bindings: arm: qcom,ids: add SoC ID for QCS9100
      soc: qcom: socinfo: add QCS9100 ID

Uwe Kleine-K=C3=B6nig (2):
      soc: Switch back to struct platform_driver::remove()
      bus: Switch back to struct platform_driver::remove()

Vibhore Vardhan (1):
      firmware: ti_sci: Add system suspend and resume call

Xinqi Zhang (1):
      firmware: arm_scmi: Fix slab-use-after-free in scmi_bus_notifier()

Zhang Zekun (3):
      soc: qcom: rpmh-rsc: Simplify code with dev_err_probe()
      soc: qcom: smem: Simplify code with dev_err_probe()
      soc: qcom: smp2p: Simplify code with dev_err_probe()

Zhenhua Huang (1):
      dt-bindings: firmware: qcom,scm: document SCM on QCS8300 SoCs

 .../testing/sysfs-devices-platform-kunpeng_hccs    |   45 +
 .../devicetree/bindings/cache/qcom,llcc.yaml       |   32 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |   17 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    6 +
 .../bindings/memory-controllers/fsl/fsl,ifc.yaml   |   32 +-
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml       |   83 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    4 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
 Documentation/devicetree/bindings/sram/sram.yaml   |    6 +
 MAINTAINERS                                        |    9 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/base/power/qos.c                           |    1 +
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |    2 +-
 drivers/bus/hisi_lpc.c                             |    2 +-
 drivers/bus/omap-ocp2scp.c                         |    2 +-
 drivers/bus/omap_l3_smx.c                          |    2 +-
 drivers/bus/qcom-ssc-block-bus.c                   |    2 +-
 drivers/bus/simple-pm-bus.c                        |    2 +-
 drivers/bus/sun50i-de2.c                           |    2 +-
 drivers/bus/sunxi-rsb.c                            |    2 +-
 drivers/bus/tegra-aconnect.c                       |    2 +-
 drivers/bus/tegra-gmi.c                            |    2 +-
 drivers/bus/ti-pwmss.c                             |    2 +-
 drivers/bus/ti-sysc.c                              |    2 +-
 drivers/bus/ts-nbus.c                              |    2 +-
 drivers/firmware/arm_scmi/bus.c                    |    7 +-
 drivers/firmware/arm_scmi/common.h                 |   47 +-
 drivers/firmware/arm_scmi/driver.c                 |   52 +-
 drivers/firmware/arm_scmi/shmem.c                  |   85 +-
 drivers/firmware/arm_scmi/transports/mailbox.c     |   15 +-
 drivers/firmware/arm_scmi/transports/optee.c       |   19 +-
 drivers/firmware/arm_scmi/transports/smc.c         |   13 +-
 drivers/firmware/arm_scmi/transports/virtio.c      |   15 +-
 drivers/firmware/arm_scpi.c                        |    3 +
 drivers/firmware/qcom/qcom_scm.c                   |   30 +
 drivers/firmware/qcom/qcom_scm.h                   |    1 +
 drivers/firmware/tegra/bpmp.c                      |   14 +-
 drivers/firmware/ti_sci.c                          |  489 ++-
 drivers/firmware/ti_sci.h                          |  143 +-
 drivers/firmware/turris-mox-rwtm.c                 |   23 +-
 drivers/firmware/xilinx/zynqmp-debug.c             |  162 +-
 drivers/firmware/xilinx/zynqmp.c                   |  153 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   11 +
 drivers/misc/Kconfig                               |   24 +
 drivers/misc/Makefile                              |    3 +
 drivers/misc/lan966x_pci.c                         |  215 ++
 drivers/misc/lan966x_pci.dtso                      |  177 ++
 drivers/pci/quirks.c                               |    1 +
 drivers/platform/cznic/turris-omnia-mcu-gpio.c     |    4 +-
 drivers/platform/cznic/turris-omnia-mcu.h          |   42 +-
 drivers/reset/Kconfig                              |   19 +-
 drivers/reset/Makefile                             |    3 +-
 drivers/reset/amlogic/Kconfig                      |   27 +
 drivers/reset/amlogic/Makefile                     |    4 +
 .../reset/{ =3D> amlogic}/reset-meson-audio-arb.c    |    0
 drivers/reset/amlogic/reset-meson-aux.c            |  136 +
 drivers/reset/amlogic/reset-meson-common.c         |  142 +
 drivers/reset/amlogic/reset-meson.c                |  105 +
 drivers/reset/amlogic/reset-meson.h                |   28 +
 drivers/reset/core.c                               |  119 +-
 drivers/reset/reset-meson.c                        |  159 -
 drivers/reset/reset-microchip-sparx5.c             |   38 +-
 drivers/reset/reset-uniphier-glue.c                |   24 +-
 drivers/soc/aspeed/aspeed-lpc-ctrl.c               |    2 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c              |    2 +-
 drivers/soc/aspeed/aspeed-p2a-ctrl.c               |    2 +-
 drivers/soc/aspeed/aspeed-uart-routing.c           |    2 +-
 drivers/soc/fsl/dpaa2-console.c                    |    2 +-
 drivers/soc/fsl/qe/qmc.c                           |    6 +-
 drivers/soc/fsl/qe/tsa.c                           |   30 +-
 drivers/soc/fsl/rcpm.c                             |    1 +
 drivers/soc/fujitsu/a64fx-diag.c                   |    2 +-
 drivers/soc/hisilicon/Kconfig                      |    7 +-
 drivers/soc/hisilicon/kunpeng_hccs.c               |  516 +++-
 drivers/soc/hisilicon/kunpeng_hccs.h               |   33 +-
 drivers/soc/imx/soc-imx8m.c                        |  174 +-
 drivers/soc/ixp4xx/ixp4xx-npe.c                    |    2 +-
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                   |    2 +-
 drivers/soc/litex/litex_soc_ctrl.c                 |    2 +-
 drivers/soc/loongson/loongson2_guts.c              |    2 +-
 drivers/soc/mediatek/Kconfig                       |   11 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             |  230 +-
 drivers/soc/mediatek/mtk-devapc.c                  |    2 +-
 drivers/soc/mediatek/mtk-dvfsrc.c                  |  545 ++++
 drivers/soc/mediatek/mtk-mmsys.c                   |    2 +-
 drivers/soc/mediatek/mtk-regulator-coupler.c       |    1 +
 drivers/soc/mediatek/mtk-socinfo.c                 |    2 +-
 drivers/soc/mediatek/mtk-svs.c                     |    4 +-
 drivers/soc/microchip/mpfs-sys-controller.c        |    2 +-
 drivers/soc/pxa/ssp.c                              |    2 +-
 drivers/soc/qcom/icc-bwmon.c                       |    2 +-
 drivers/soc/qcom/ice.c                             |    6 +-
 drivers/soc/qcom/llcc-qcom.c                       | 3265 +++++++++++++=
+++++--
 drivers/soc/qcom/ocmem.c                           |    2 +-
 drivers/soc/qcom/pmic_glink.c                      |    2 +-
 drivers/soc/qcom/qcom-geni-se.c                    |    3 +-
 drivers/soc/qcom/qcom-pbs.c                        |   22 +-
 drivers/soc/qcom/qcom_aoss.c                       |    2 +-
 drivers/soc/qcom/qcom_gsbi.c                       |    2 +-
 drivers/soc/qcom/qcom_pd_mapper.c                  |    1 +
 drivers/soc/qcom/qcom_stats.c                      |    2 +-
 drivers/soc/qcom/qmi_interface.c                   |    2 +-
 drivers/soc/qcom/ramp_controller.c                 |    4 +-
 drivers/soc/qcom/rmtfs_mem.c                       |    2 +-
 drivers/soc/qcom/rpm-proc.c                        |    2 +-
 drivers/soc/qcom/rpm_master_stats.c                |    2 +-
 drivers/soc/qcom/rpmh-rsc.c                        |    9 +-
 drivers/soc/qcom/smem.c                            |   18 +-
 drivers/soc/qcom/smem_state.c                      |   12 +-
 drivers/soc/qcom/smp2p.c                           |   11 +-
 drivers/soc/qcom/smsm.c                            |    6 +-
 drivers/soc/qcom/socinfo.c                         |    9 +-
 drivers/soc/rockchip/io-domain.c                   |    8 +-
 drivers/soc/samsung/exynos-chipid.c                |    4 +-
 drivers/soc/tegra/cbb/tegra194-cbb.c               |    2 +-
 drivers/soc/ti/k3-ringacc.c                        |    2 +-
 drivers/soc/ti/knav_dma.c                          |    4 +-
 drivers/soc/ti/knav_qmss_queue.c                   |    8 +-
 drivers/soc/ti/pm33xx.c                            |    2 +-
 drivers/soc/ti/pruss.c                             |    4 +-
 drivers/soc/ti/smartreflex.c                       |    6 +-
 drivers/soc/ti/wkup_m3_ipc.c                       |    2 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |    6 +-
 drivers/soc/xilinx/zynqmp_power.c                  |    2 +-
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    |    4 +-
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |    8 +-
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  |    4 +-
 include/dt-bindings/arm/qcom,ids.h                 |    7 +
 include/linux/firmware/qcom/qcom_scm.h             |    2 +
 include/linux/firmware/xlnx-zynqmp.h               |   39 +-
 include/linux/reset.h                              |  274 +-
 include/linux/soc/mediatek/dvfsrc.h                |   36 +
 include/linux/soc/mediatek/mtk_sip_svc.h           |    3 +
 include/linux/soc/qcom/llcc-qcom.h                 |   12 +
 include/linux/soc/ti/ti_sci_protocol.h             |   30 +
 include/soc/amlogic/reset-meson-aux.h              |   23 +
 137 files changed, 7215 insertions(+), 1067 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/media=
tek,mt8183-dvfsrc.yaml
 create mode 100644 drivers/misc/lan966x_pci.c
 create mode 100644 drivers/misc/lan966x_pci.dtso
 create mode 100644 drivers/reset/amlogic/Kconfig
 create mode 100644 drivers/reset/amlogic/Makefile
 rename drivers/reset/{ =3D> amlogic}/reset-meson-audio-arb.c (100%)
 create mode 100644 drivers/reset/amlogic/reset-meson-aux.c
 create mode 100644 drivers/reset/amlogic/reset-meson-common.c
 create mode 100644 drivers/reset/amlogic/reset-meson.c
 create mode 100644 drivers/reset/amlogic/reset-meson.h
 delete mode 100644 drivers/reset/reset-meson.c
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 include/linux/soc/mediatek/dvfsrc.h
 create mode 100644 include/soc/amlogic/reset-meson-aux.h

