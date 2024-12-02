Return-Path: <linux-kernel+bounces-426999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C89DFB11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8904281C37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A71F9ED4;
	Mon,  2 Dec 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="kQMJhEtZ"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D01F9A95;
	Mon,  2 Dec 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124083; cv=none; b=l49HcHbynXzp2DTShOiZR0q8i7BAqCIrW80FHX2mWvc4f52ArJUWiQ/5R54W608XjngMsh38qP1QzH8Vc3iQ14Ij+e+W8kgllK+B2Q0jnwCuOSiTURE8ULclnAXS9sGk0jeua10NnnStNDCKygz9jwZv+AXoGRLNOwMt2T+sLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124083; c=relaxed/simple;
	bh=YjKduTy15lZBVE/9pqMa5ERoezVAixGMlcudWE4nxVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QNsRbWmRUdqpQFc/vN+mI/1kW2YCoQmky0V2oCLGlQHZhgy7A1yK9vSLHhJttUX8s9POge6iqvSc1TMREQbqLcpci7RdFOgfIucwcxNPruk/kjzYOS8Eh5yRcVhpg/+9oXZrgGRvhMnOC0u/jIemV94H6L+N2yIbxNJH7T3Tp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=kQMJhEtZ; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7hNJpGuTc3/rYKS53bsFYQIckkwK3MXNB6qlUliODKU=; b=kQMJhEtZbjvgyNfewkNxNaK2lZ
	5FDzotMG7mBgaWA1+RgGRTse8Tc5zLGbcbaaHF3JJxgHt9CFJBBlENhEDgBbojd9GvOMkxewatDGa
	3+BFnBNPXB7Irvg+lgz/WRKgNR4gvhuoKrhL58hHP1CTB4c4kU7bsbJe2CnIt6Z+wSfGc9+d31WlK
	WXYIVxUNFnBLscnrXStpeAvsOtI1+j8JKILF/cUuhHVsI2U7rgP7vdi1yRdkwhcbEbntakTWhW5ju
	lP0LbsxiQyP/pjRehNW+9c0vXkRJd8pdfjFSc4sS8SdxIub5bKCFZ8HDJ+lv8c4S83aYmRxniKc+O
	jHdTeyXA==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0k4-007Bva-2L;
	Mon, 02 Dec 2024 08:21:12 +0100
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
Subject: [PATCH v2 00/15] Update PHYTEC's i.MX8MM DTSs
Date: Mon,  2 Dec 2024 08:20:37 +0100
Message-Id: <20241202072052.2195283-1-andrej.picej@norik.com>
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
v2 changes in corresponding patches.

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
 .../dts/freescale/imx8mm-phycore-rpmsg.dtso   |  55 ++++
 .../dts/freescale/imx8mm-phycore-som.dtsi     |  22 +-
 .../dts/freescale/imx8mm-phygate-tauri-l.dts  |  11 +
 9 files changed, 439 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso

-- 
2.34.1


