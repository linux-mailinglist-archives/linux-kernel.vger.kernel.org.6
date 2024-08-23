Return-Path: <linux-kernel+bounces-299208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C49695D18A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB031C221EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00D189B87;
	Fri, 23 Aug 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="EISDbXjY"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB9188A1A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427361; cv=none; b=BfIwvwGxMIwTg1GMRix1LmHXwhakX0cVj5hG2CP7TCWgkQmclhF8Qn4vpyH71qQBjM4dEILhop9o1h/eX94mfPxpqNl03N+dJOHFHkK/jR5fmXU3421f/kMyb6/L4J9iwu2fBW30cLrAFgCXWLfQq3lBntSGr1csehBpCuNxPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427361; c=relaxed/simple;
	bh=PtoljGyGYBy/KDvUX6FpLHZIPw/27FmdMfT+WN7dQ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPF3O9xthI9IUpLLRowZTGnJmXfAy0QnQg9i6Ka6AcUxz7dsG7CE6K9Qfg5A9dbYzE7rCQlb4pDIJAC9PbwF9Jczi7DBYJPtmFGeYqT4FD5TSl3EWAeh7jnd8DSXuhXD53y4HVEIZ9Vuwxfxtda0ndxmnePaY6uFu274Ku45myY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=EISDbXjY; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id hTYLseWeAiA19hWKOs8u4S; Fri, 23 Aug 2024 15:35:52 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id hWKKsdm47wUH5hWKMsvxpz; Fri, 23 Aug 2024 15:35:50 +0000
X-Authority-Analysis: v=2.4 cv=Yci75RRf c=1 sm=1 tr=0 ts=66c8ac56
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=yoJbH4e0A30A:10 a=Hh393OduLPAXkTOZqikA:9 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FIxz5wswnZxJlIqs+c8ONwSGEnRq3jkU9qJL095u6eM=; b=EISDbXjYOIv1wiSu1BT2TQLH3g
	Ol7kgEF3jRqjk63WyYPKmChdKNR9oqUkCrGPe8Bll0388tPPA9xfEQ5n3NxsM+VnmS8l6VElXeK7J
	fnmWq8MfuAIKdBQ+zZPL1LKU7VUE5ouMs/Dnl2ltnPV5KG9GOZnIGDVh7G9qWO3Ldvv89aWVTqss6
	rsqo75dApH0kiWW9jJ3p0FAtlU1CWkJgPWDGJ1QaiD+AaP1ew65eOjHRLAhDURbTiZXFh9VpqzXf9
	vFE6UNQ5oEsx8lDFloyA9yiHOChTacmbb8wgwOjL0bwlc2nPmzHWPe/+WA2UiUjxS10noiN7eKQF/
	aYqz7uhQ==;
Received: from [122.165.245.213] (port=53684 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1shWKJ-000GB4-0P;
	Fri, 23 Aug 2024 21:05:47 +0530
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
Subject: [PATCH 0/8] Add support Relfor Saib board which is based on Rockchip RV1109 SoC
Date: Fri, 23 Aug 2024 21:05:20 +0530
Message-Id: <20240823153528.3863993-1-karthikeyan@linumiz.com>
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
X-Exim-ID: 1shWKJ-000GB4-0P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:53684
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 2
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAsA+DEPwi4TTEcUJ58BXkDFzVJ3S1ASh3gX+ZT3kwxXNL+OdrBPDq4aEeUTTQhuKh+rJyjATz5a6/Zg4En8kkKOuG2u7AxyEsaHYdgHpdOgehWoHPe2
 ofFbEawj55WJQtQKX3cZ2u7+L0BcC8sdLKuOXjYjEXpXWVz8GD7r5UR1q6xfG5/HZSSiSaiDep0uHBk6YE5lxLBnD4tA6N8OEARTl5A78AcbH+5hfXQZhqAx

Rockchip RV1109 is compatible with Rockchip RV1126.
Relfor Saib board is equipped with 1GB of RAM and 4GB of eMMC
Pheripherals like Bluetooth 4.2, Wifi 5G, audio-codec,
ir transmitter and receiver, etc

Karthikeyan Krishnasamy (8):
  ARM: dts: rockchip: Add i2c3 node for RV1126
  ARM: dts: rockchip: Add i2s0 node for RV1126
  ARM: dts: rockchip: Add pwm node for RV1126
  ARM: dts: rockchip: Add watchdog node for RV1126
  Documentation: bindings: rtc: add clock-cells property
  dt-bindings: vendor-prefixes: Add Relfor labs
  dt-bindings: arm: rockchip: Add Relfor Saib
  ARM: dts: rockchip: Add Relfor Saib board

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 .../bindings/rtc/microcrystal,rv3028.yaml     |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/rockchip/Makefile           |   1 +
 .../boot/dts/rockchip/rv1109-relfor-saib.dts  | 439 ++++++++++++++++++
 .../arm/boot/dts/rockchip/rv1126-pinctrl.dtsi | 256 ++++++++++
 arch/arm/boot/dts/rockchip/rv1126.dtsi        | 159 +++++++
 7 files changed, 866 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts

-- 
2.39.2


