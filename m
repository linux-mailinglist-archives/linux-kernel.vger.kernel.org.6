Return-Path: <linux-kernel+bounces-326710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0272976C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847AE284B66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34E1BC06D;
	Thu, 12 Sep 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="PnMS2fKW"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFA1BAEF1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151185; cv=none; b=WsfWedcI+DMzY/X+e27c0/V/BF8H+anfEJ0QD/kobt08TDmHC+aUcvwCbS0Mb1R2mlarM2mIr8uDASNgfRl43TC5rt5ZyVJPONkIjgWvypc7iFEph8CDQtQxXlH05bv+LkqEdBy4A8NBu1rxd3e6N9eAqmQ9D/rh6GHqbdDC2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151185; c=relaxed/simple;
	bh=xU6lCVd7JMgGzN64i/PH95a7uv8SV20ack91HmiXy4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESfEwetnH1M49TjL6c7qxYlRFSoVOBdEqJMVU6DcT0DYzCBZVB3WwB0Hei8QRFkzht1EGDEQIxAP6SphlF4s70N3Osbpxmr0uS3FLr62F3XpRSw8Q2ItmLLs3809lVmzL1ScfBnfSKcOleNBdy+16Mpf3YKnK5djUDK7dQZzPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=PnMS2fKW; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id ofgLs4bZB1zuHokm1spDkX; Thu, 12 Sep 2024 14:26:17 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id oklwsubeLV2ivoklys7uOd; Thu, 12 Sep 2024 14:26:14 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66e2fa06
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=EaEq8P2WXUwA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8 a=VwQbUJbxAAAA:8
 a=rT7NhT99x2eMfdz9cs0A:9 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7QXESs+8CADDwMHBZ3VYC8ztM/9Ainl2kfcfyQYyWuQ=; b=PnMS2fKWQUhAx4yHxWHjoFae52
	SeWWxPzAluF1D9reXvhcx7lU5SPgYr2znc7T0z12i7uX0fj1vLR3RUJKD6qbQSC3yiGR52p1LaBJe
	NdPq+mqKpO/G2smQaLERjTs2BtdXF45AHSXHpi3+PCs2PpwnFWx51oduYd4UIcV+mrGvFGWKv1a8I
	Ey+O3/xGELxCwhxGupuL0Afr4W5UT85DhQgkduJRGH5+TVyHd1LHnPej+r7CO+x2COW7EU4NLxQC4
	9XM9d9ZciHUBFIUJgD7bsBxV05mgDoOiwWzLNyZVSE6/xI0V+m/NZKaOx9ZcJg2mFjYxFjfCmgFDW
	4YsSux1g==;
Received: from [122.165.245.213] (port=41006 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1soklu-003n4z-2t;
	Thu, 12 Sep 2024 19:56:10 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Subject: [PATCH v3 0/6] Add support Relfor Saib board which is based on Rockchip RV1109 SoC
Date: Thu, 12 Sep 2024 19:54:45 +0530
Message-Id: <20240912142451.2952633-1-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1soklu-003n4z-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:41006
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 5
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI2g51xJD9hSEUmqLD3plOzkjkqAzhygBdPHjpRxV5hVVrGdhdoUyeuiMEDwS3NHmAhlnDnDLlW9byrzChQIwfIgzbuUpN/AkzP0HegoPRSqZvhpDqEk
 uCa2jczIEvLQrCvSyuri18Xlbxoxk7es8iSLhEkJzuEkKv2ASoNyxClTenoW8/uva+DXhYeTqhPTtp3XTBMDiZ0EKywFaJ7Lz4s3aGjmgK7vG5ulXRWw5fRM

Rockchip RV1109 is compatible with Rockchip RV1126.
In this series, adding required missing peripheral in
RV1126 and its pin mux.

Relfor Saib board is equipped with 1GB of RAM and 4GB of eMMC
Pheripherals like Bluetooth 4.2, Wifi 5G, audio-codec,
ir transmitter and receiver, etc

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
Changes in v3:
- Align to the comments
- Rebased with master
- Drop first 3 commit from v2, since it got applied
- Link to v2: https://lore.kernel.org/all/20240903105245.715899-1-karthikeyan@linumiz.com

Changes in v2:
 - Align to the comments
 - Rebased with master
 - Link to v1: https://lore.kernel.org/all/20240823153528.3863993-1-karthikeyan@linumiz.com

---
Karthikeyan Krishnasamy (6):
  dt-bindings: watchdog: rockchip: Add rockchip,rv1126-wdt string
  ARM: dts: rockchip: Add watchdog node for RV1126
  dt-bindings: rtc: microcrystal,rv3028: add #clock-cells property
  dt-bindings: vendor-prefixes: Add Relfor labs
  dt-bindings: arm: rockchip: Add Relfor Saib
  ARM: dts: rockchip: Add Relfor Saib board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/rtc/microcrystal,rv3028.yaml     |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../bindings/watchdog/snps,dw-wdt.yaml        |   1 +
 arch/arm/boot/dts/rockchip/Makefile           |   1 +
 .../boot/dts/rockchip/rv1109-relfor-saib.dts  | 422 ++++++++++++++++++
 arch/arm/boot/dts/rockchip/rv1126.dtsi        |   8 +
 7 files changed, 442 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts

-- 
2.39.2


