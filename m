Return-Path: <linux-kernel+bounces-427673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4769E04A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587CC16B01F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57B20370B;
	Mon,  2 Dec 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="poSWkFtL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF01FA15B;
	Mon,  2 Dec 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148676; cv=none; b=sESfJ/3PkgNst43XCDY9231BHRlU4CoFKvUbAzj5GAbKx7LOYwInO3B2dqIM7hqz+FnUZAQlFxiHLUY1elIw2osfSWsK/f9G/CMnTOnWI34jSEGaSObVpfb0OrMv/uUtUaDpPxcyir7qNQoKNxzTS6FPnfTBMDcEE7nY+XX0NJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148676; c=relaxed/simple;
	bh=yRbOjZ2hD0leE2tDAokT732AMFTPg2jdC93fXQD4wyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aXQw58eVWB4zyJZah7p9FlRpWVAyVuDdCzNqHN2QM/oxDHAfKb3464naLihH7dKa5yktdfXQeVeW+M/QO+QGg/LHowOZnksFcXFWgPMJ7ShmtzjV95zJZa1+U6LTxF58kSRdURDZEdRYRbTsRAiEYISEtNJ8yTclP2kvYnJVAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=poSWkFtL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733148675; x=1764684675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yRbOjZ2hD0leE2tDAokT732AMFTPg2jdC93fXQD4wyI=;
  b=poSWkFtL4GlHPBU6Hl6HHgMekxJ8QNSCfKgv4VBe2EtoII3VIkg3kF25
   4AiowzDfi39cPmnYxioF+3LAWM6C3R6bnvORGcXiOuRWREafk/s1fgiqx
   k0qb/W9Y4Ky8sxtJnZueKVOoeoj4azNLUGl+Of0FywNPx/88ZBLT011o4
   rQcYbrfgKoAyMVrLoS5zZKLphTGtXs3J+h4pmR4vIRMW0wrzhmGqrLJRh
   4eF+N/ZHvWXtCv/dac8D2qxj0lnOGZ7gO5oRwoniMi7W4LkqZoJUmB7Kw
   uNWlU2UUwjnRBHCTAXzUr8OZLAyAYruMfl/hvsJOTjAhQn0Ca4wvfz76j
   g==;
X-CSE-ConnectionGUID: 2KutSU5NQueuFpBXpCyxJA==
X-CSE-MsgGUID: HEOvJCBSQFuLbWAqGes20Q==
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="266205958"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2024 07:11:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Dec 2024 07:10:50 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Dec 2024 07:10:49 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v5 0/4] Add Microchip IPC mailbox
Date: Mon, 2 Dec 2024 14:11:03 +0000
Message-ID: <20241202141107.193809-1-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hello all,

This series adds support for the Microchip Inter-Processor Communication
(IPC) mailbox driver.

Microchip's family of RISC-V SoCs typically has one or more clusters
that can be configured to run in Asymmetric Multi-Processing (AMP) mode.

The Microchip IPC is used to send messages between processors using
an interrupt signaling mechanism. The driver uses the RISC-V Supervisor
Binary Interface (SBI) to communicate with software running in machine
mode (M-mode) to access the IPC hardware block.

Additional details on the Microchip vendor extension and the IPC
function IDs described in the driver can be found in the following
documentation:

https://github.com/linux4microchip/microchip-sbi-ecall-extension

The PIC64GX MPU has a Mi-V IHC block, this will be added to the PIC64GX
dts after the initial upstreaming [1].

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20240725121609.13101-18-pierre-henry.moussay@microchip.com/

Changes in v5:
- change interrup-names property to use a list instead of pattern
- move assitionalProperties after allOf : block
- update reg property in dt binding example to use lowercase hex

Changes in v4:
- specify that microchip,miv-ihc-rtl-v2 is intended for use with MIV IHC Soft IP
- drop items array and use const value for compatible strings
- add a contraint to microchip,ihc-chan-disabled-mask property
- minor improvements to "'#mbox-cells' description

Changes in v3:
- Fix incorrent formatting around '=' in dt binding examples
- Add per compatible descriptions in dt binding
- Add '>' in certain dt binding descriptions to keep paragraphs maintained
- export __cpuid_to_hartid_map to compile mailbox driver as module
- Drop unused enum ipc_irq_type
- rename struct mchp_ipc_probe to mchp_ipc_mbox_info
- rename struct ipc_chan_info to mchp_ipc_sbi_chan
- rename struct microchip_ipc to mchp_ipc_sbi_mbox
- use phys_addr_t for __pa()
- drop mchp_ipc_get_chan_id function
- use num_chans in mbox_controller
- Fix buf_base_tx and buf_base_rx sizes using max and kmalloc

Changes in v2:
- use kmalloc and __pa() instead of DMA API
- fix size of buf_base to avoid potential buffer overflow
- add kernel doc for exported functions (mchp_ipc_get_chan_id)
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
- drop unnecessary blank line and fix alignment issues
- drop of_match_ptr
- move MODULE_DEVICE_TABLE next to the definition
- reword subject from riscv: asm: vendorid_list to riscv: sbi: vendorid_list
- remove the word "driver" from dt-binding commit subject
- make interrupt-names a required property for all cases
- add dependency on COMPILE_TEST and ARCH_MICROCHIP

Regards,
Valentina

Valentina Fernandez (4):
  riscv: sbi: vendorid_list: Add Microchip Technology to the vendor list
  riscv: export __cpuid_to_hartid_map
  dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
  mailbox: add Microchip IPC support

 .../bindings/mailbox/microchip,sbi-ipc.yaml   | 117 ++++
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 arch/riscv/kernel/smp.c                       |   1 +
 drivers/mailbox/Kconfig                       |  13 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-mchp-ipc-sbi.c        | 504 ++++++++++++++++++
 include/linux/mailbox/mchp-ipc.h              |  33 ++
 7 files changed, 671 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
 create mode 100644 drivers/mailbox/mailbox-mchp-ipc-sbi.c
 create mode 100644 include/linux/mailbox/mchp-ipc.h

-- 
2.34.1


