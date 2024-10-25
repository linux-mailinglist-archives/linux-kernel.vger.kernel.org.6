Return-Path: <linux-kernel+bounces-381684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D239B0291
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E4B22431
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F61F7575;
	Fri, 25 Oct 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cMRfcKgN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6951F7554;
	Fri, 25 Oct 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859798; cv=none; b=ts7Sb1nxkvZKsNcLS5G1VK8+8p+v48POvkgROHuT7k9MNjb7pvsQAkguKsVHP7u35KGllq3sqWPOsP3xyUQjqLTowycWuKTNdVj0Xbzfx91RSLFu+TQv0YzMd4rDAtrtPnCAsLyb/BjUy4K11cclk+6J9VQDb49AhX9kwu4aV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859798; c=relaxed/simple;
	bh=QawCFqr5BT6CrXbkDHPVmxbNPAmvASHSPaF+S3p29tU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=buzCZ766frBhNZrXjhoPxVjYwS4+ND0QvoGuh3VGv7Qp9iMyZPcFFbASNhnEBDgX4aCyIQZXv88SsqnGTCvg83SWGvNHJXLTloQyKFQ98kWOuyM4LydLL/xhNkBUrb2+tR4EjvMO7ZgdjUozdXXoFZDdyEnR22CuoZdoMbQHP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cMRfcKgN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729859797; x=1761395797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QawCFqr5BT6CrXbkDHPVmxbNPAmvASHSPaF+S3p29tU=;
  b=cMRfcKgNcVOM9P68LS47bhYPkNlTUmW8R788ga+dqlEJqMWlZ1KzLV+N
   i+qaD3oiVbshIo6JRed+/Lt1SjGhARf4tnBBUdX8X/6pABLsZj5LRNGZk
   djP79bYpbdH4tn3/sslQrxeoIRFV0kPaNXJmDnWcYKQWgLIIl2VAqPtwm
   Luvft3/BvIu19Bk8WVH+oPuJsG0NjP6GAdXdcYeCc9IMONta4g8mLeSyI
   9hHD+zJ//KPaN53tnsA7WeydlolwuhfXn5dgZvFsIAg7NBpSlk83B3A2U
   ViOqoDLJzg482WFPdkeK5vVQUxXBaYLOo9/Shc3m4dTev49Faeg9R74aI
   Q==;
X-CSE-ConnectionGUID: X92f2WlyQymcF1jpVGgAqw==
X-CSE-MsgGUID: N+DaUVr+Rratp8G4QRKpvg==
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="33481559"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2024 05:36:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 25 Oct 2024 05:35:44 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 25 Oct 2024 05:35:42 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterlin@andestech.com>, <conor.dooley@microchip.com>,
	<conor+dt@kernel.org>, <ycliang@andestech.com>, <dminus@andestech.com>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <jassisinghbrar@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 0/3] Add Microchip IPC mailbox
Date: Fri, 25 Oct 2024 13:51:07 +0100
Message-ID: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
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

I am submitting this v2 with the IPC mailbox patches and without the
IPC remoteproc drivers, as suggested in v1 [1].

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
dts after the initial upstreaming [2].

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20240912170025.455167-1-valentina.fernandezalanis@microchip.com/
[2] https://patchwork.kernel.org/project/linux-riscv/patch/20240725121609.13101-18-pierre-henry.moussay@microchip.com/


changes since v1:
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

Valentina Fernandez (3):
  riscv: sbi: vendorid_list: Add Microchip Technology to the vendor list
  dt-bindings: mailbox: add binding for Microchip IPC mailbox controller
  mailbox: add Microchip IPC support

 .../bindings/mailbox/microchip,sbi-ipc.yaml   | 108 ++++
 arch/riscv/include/asm/vendorid_list.h        |   1 +
 drivers/mailbox/Kconfig                       |  13 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-mchp-ipc-sbi.c        | 537 ++++++++++++++++++
 include/linux/mailbox/mchp-ipc.h              |  23 +
 6 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
 create mode 100644 drivers/mailbox/mailbox-mchp-ipc-sbi.c
 create mode 100644 include/linux/mailbox/mchp-ipc.h

-- 
2.34.1


