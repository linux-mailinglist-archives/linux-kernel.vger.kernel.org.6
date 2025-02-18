Return-Path: <linux-kernel+bounces-518740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E20A393F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48A27A15DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAB1C831A;
	Tue, 18 Feb 2025 07:42:45 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED91B87F2;
	Tue, 18 Feb 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864565; cv=none; b=Y0bsS0JzFawAEm3E3h2i46z0kqa44yo2Yp/14eShbqY2pkx4XGvxC5XbCH3arc3+aKk2DHzkEc68L24pJJOvVMoVLFtHkmTN6nMKxyGBGtg/4hYh027tFi4lUPB8HCjg7GXktinGLyXN8nTeGwQI2zCLf18OylvfHB/j9cx7jE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864565; c=relaxed/simple;
	bh=Sv7OpvWVnoTbdrLqgyozPjPevDJINMfc5S0difeF9MY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sb4X5Jxf0ldQZwZnHd5l0HB7JOsZI4i6H1OwCIFC7M4+Dwn7JZ0C16CGldrJBMiRFZ0jONUhT5eHnPdvHNmoKsKhQgraXfbiewDG/FlgI7M/NMaD3mrnJdLHVJo7uur/MexFEF8B6bPveLXDpNZ3jPZGZ7Q31XPhbmgheeTBa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFc-00G0MD-30;
	Tue, 18 Feb 2025 08:42:40 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v3 00/15] Update PHYTEC's i.MX8MM DTSs
Date: Tue, 18 Feb 2025 08:41:41 +0100
Message-Id: <20250218074156.807214-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi all,

these patches aim to get PHYTEC downstream kernel device-tree changes
into the mainline for the phyCORE-i.MX8MM SoM and boards (phyBOARD-Polis
and phyGATE-Tauri-L).

Changes mainly fix suspending/resuming with different wakeup-sources and
add missing regulators. Last 4 patches add additional overlays. Some are
meant to be used with PHYTEC's "option tree" to add/disable optional SoM
components (idea behind it is outlined in [1]).

[1] https://lore.kernel.org/all/4e7dd467-20be-43ce-936d-200ede6d511b@phytec.de/

v1 at: https://lore.kernel.org/all/20241125081814.397352-1-andrej.picej@norik.com/
v2 at: https://lore.kernel.org/all/20241202072052.2195283-1-andrej.picej@norik.com/

Change log in corresponding patches (the only notable v3 change is in
- [PATCH 13/15] arm64: dts: imx8mm-phycore-som: Add overlay for rproc 
where we fixed DTS check warning. Other changes just updated overlays copyright
year to 2025.

Best regards,
Andrej

Andrej Picej (3):
  arm64: dts: imx8mm-phycore-som: Fix bluetooth wakeup source
  arm64: dts: imx8mm-phyboard-polis: Set RTC as wakeup-source
  arm64: dts: imx8mm-phygate-tauri-l: Set RTC as wakeup-source

Dominik Haller (1):
  arm64: dts: imx8mm-phycore-som: Add overlay for rproc

Janine Hagemann (1):
  arm64: dts: imx8mm-phyboard-polis: Add overlay for PEB-EVAL-01

Teresa Remmet (5):
  arm64: dts: imx8mm-phycore-som: Keep LDO3 on in suspend
  arm64: dts: imx8mm-phycore-som: Remove magic-packet property
  arm64: dts: imx8mm-phyboard-polis: Add support for PEB-AV-10
  arm64: dts: imx8mm-phycore-som: Add no-eth phy overlay
  arm64: dts: imx8mm-phycore-som: Add overlay to disable SPI NOR flash

Yannic Moog (3):
  arm64: dts: imx8mm-phycore-som: add descriptions to nodes
  arm64: dts: imx8mm-phyboard-polis: add RTC description
  arm64: dts: imx8mm: move bulk of rtc properties to carrierboards

Yashwanth Varakala (2):
  arm64: dts: imx8mm-phycore-som: Assign regulator for dsi to lvds
    bridge
  arm64: dts: imx8mm-phyboard-polis: Assign missing regulator for
    bluetooth

 arch/arm64/boot/dts/freescale/Makefile        |  13 +
 .../imx8mm-phyboard-polis-peb-av-10.dtso      | 237 ++++++++++++++++++
 .../imx8mm-phyboard-polis-peb-eval-01.dtso    |  72 ++++++
 .../freescale/imx8mm-phyboard-polis-rdk.dts   |  17 +-
 .../dts/freescale/imx8mm-phycore-no-eth.dtso  |  12 +
 .../freescale/imx8mm-phycore-no-spiflash.dtso |  16 ++
 .../dts/freescale/imx8mm-phycore-rpmsg.dtso   |  58 +++++
 .../dts/freescale/imx8mm-phycore-som.dtsi     |  22 +-
 .../dts/freescale/imx8mm-phygate-tauri-l.dts  |  11 +
 9 files changed, 442 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso

-- 
2.34.1


