Return-Path: <linux-kernel+bounces-292021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93A956A41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CF1C234DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0B1684A7;
	Mon, 19 Aug 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MFlTAbKD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VAK/aC6n"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DA13DBA0;
	Mon, 19 Aug 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069022; cv=none; b=kOAuVbtZftIELmy/DNOG1coGnFP8grUJsz9NwJ0QY4Z4/8tZ9bavQMcVLIz77kB7ls4wEPhef9g7u3w2A5jYSv4i9MZbYcXzwxm3phVpdmnUS1NQYsPF4aZBLY5SPwbIzeX/+QibErv9/6hJ/gHosijYoclyNAKuskREqactG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069022; c=relaxed/simple;
	bh=Amg6pxpvYJV2YWjLKJfNIaYtUJYY2QMCpB9VDZRbVyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPyXt1BSd65HDaKLE+2X6ybgPTTIdKEARN3hizdZ1cWRjbhkm1BASGtuj6n/kBLNYlrG6zqN1/yfy5spiRw9oxZ658/kkYTmgj4SuZMdZR6g6mfV2/75jlKu+kh5EavIFu+PsDidpIFwglUU4K9WKt+JKFqxGneaX7l0N5mdabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MFlTAbKD; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VAK/aC6n reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069019; x=1755605019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DN/3w1Vft6D1vjJdLnyjCTRab2bmOne6epqUwo+9k8=;
  b=MFlTAbKD4Iqn7Wa5UrOHnRRfqsscV6+BCa0Z9hVcSiRdwp+MPpBpyEOo
   j8e4+85RxN96BW8qy8AhbvB3ofF2x8hytKnodnAN9naKRl+CC6EuiKaGA
   N1yeoPpTYYDNDEIG2QV732HETjIAEecHrmIpeRbXGlm5f2dVXGnf10kGE
   9s+vUSKA1GpLVuaBBHWHX94xgqw2+ladOO6QPfsSo6nPPxQPaPTVMjPDd
   cCPkrHX9uE3nGFzCODVryHT051sarFkc+Y/LTBN7sLN7yegn2nNGOi9HK
   VbrPA5xxoTeIrd+rasbYOKDIF4vPIeuglmXMSdAyr/YWpBYWQ08XLtjmQ
   w==;
X-CSE-ConnectionGUID: aeFCxebrTbGb9SW5j2yc/A==
X-CSE-MsgGUID: lc8KNtI2QOiz6OcRpuNqMQ==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467097"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:03:36 +0200
X-CheckPoint: {66C33498-16-45EF2B36-F6E28480}
X-MAIL-CPID: 9997A2AE3CF88BAD4F45DA2E8345DA57_0
X-Control-Analysis: str=0001.0A782F24.66C33498.00B2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E209163E34;
	Mon, 19 Aug 2024 14:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069012; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8DN/3w1Vft6D1vjJdLnyjCTRab2bmOne6epqUwo+9k8=;
	b=VAK/aC6nJik2PLaTULLyb39jt/Jh5rI98EraOtS/ou1NjFsgI4tJOOr6QMRRVi/Z0jANcs
	VftS14Dwg0kN6PkWEEBlAWLST141eD2ESsdZQTIe1vQJJcFgys88LsuvJCXUaFMns8lRpx
	VYG28KMTi2mPilS86z17g+3aLrj8fd/+QfZ5wHnyS7Uz9pMVdwR6JXSXSxaRBh48AZ+FjD
	Qb5yBpY9wN81rjFTd4iB5sD5cQVAxRfab1s1ndW9095g4Y2zMxg535BibX3D74kwixvMSr
	+rrnfPBHiMN8M82N04uUlU1g/xAYtmZ0lUnwOlfT90oPRsssiJKvDe1l5UadtA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] TQMa93xx improvements
Date: Mon, 19 Aug 2024 14:03:14 +0200
Message-Id: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

this is the 2nd version of the series add improvements for the TQMa93xx
series.
Despite changes for pad configuration as requested form hardware team, this also
adds the PMIC node which allows to specify correct supplies for e.g. eMMC.
Also GPIO lin enames are added for userspace usage using e.g. libgpiod.
This series also includes a workaround for USDHCI errata.

Changes in v2:
* Collected R-b
* Fix whitespace typos
* Split (old) patch 6/14 into patches
  * Fixing pad config
  * Adding LPSPI6 interface
  * Adding IRQ for temperature sensor
  * Adding missing pad configurations
* Split (old) patch 12/14 into patches
  * Adding IRQ for RTC and temperature sensor
  * Fixing pad config

Best regards,
Alexander

Alexander Stein (7):
  arm64: dts: freescale: imx93-tqma9352: Add PMIC node
  arm64: dts: freescale: imx93-tqma9352: add eMMC regulators
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: enable LPSPI6
    interface
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: add missing pad
    configurations
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: Add ethernet aliases
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: add missing pad
    configurations
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: Add ethernet aliases

Markus Niebel (7):
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: improve pad
    configuration
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: add irq for temp
    sensor
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: add GPIO line names
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: add RTC / temp sensor
    IRQ
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: improve pad
    configuration
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: add GPIO line names
  arm64: dts: freescale: imx93-tqma9352: set SION for cmd and data pad
    of USDHC

 .../freescale/imx93-tqma9352-mba93xxca.dts    | 299 +++++++++++-----
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 318 +++++++++++++-----
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 134 ++++++--
 3 files changed, 568 insertions(+), 183 deletions(-)

-- 
2.34.1


