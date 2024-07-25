Return-Path: <linux-kernel+bounces-262005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D6793BF45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EA61C208E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE13913BC3D;
	Thu, 25 Jul 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="hZdsN0DP"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE113C809
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900773; cv=none; b=VwkQ/j/UHpSVsWLJpt7n0GoQH0KTik1GSOPTviG7Cu+hEwfWcqeLl9xIUc7asZVvpsnw2DWPC1YmUC4Er73IYbr5DOxjhW+12E0rKBkK+qgt3kRoM4e4vrctJIk+nxlc0VbLVkSFTRKwcDAyCD+3E/5jipj2M7l/L/o051c6ipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900773; c=relaxed/simple;
	bh=xJbE3/+oDT4lzzvGx9f9iayJZeqlQwh8BmnzVVqNqV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjtrgBRKRN0hD6v8sovS+xkV2oqdbZ5ZPMGQMRSFJwvVfv4PISA4d4UWs61NSlCrzXaMFZAU81laa4yhC2H5tg5K5AEBBn7tLtom9AQmLvNkSw+ilTeF3odfRcDoPvVYcHuRiUXuA8kDfUfIXsKvwF94uy4CBDJ6zjG6KXaJUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=hZdsN0DP; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1721900762; x=1724492762;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xJbE3/+oDT4lzzvGx9f9iayJZeqlQwh8BmnzVVqNqV0=;
	b=hZdsN0DPdXxzTdESLOrkWpNwdHNLlUqtg6nVIT1KwibvedsK+BQ4vVRqfvPRPs4M
	r0hidalpr3ko0+J9gLfbWYrW1qrYTUgsOCbiEZ/49SI37/gExXgS9oGYelVMmBmv
	Zy/XeTTr8l0+8Y9nioxDlq8o0gcE62t+qQOPeB93aaI=;
X-AuditID: ac14000a-03e52700000021bc-ed-66a21ed93aac
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A3.CC.08636.9DE12A66; Thu, 25 Jul 2024 11:46:01 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 25 Jul
 2024 11:46:01 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH 0/3] arm64: dts: freescale: imx8mp-phycore: Add devicetree overlays
Date: Thu, 25 Jul 2024 11:44:54 +0200
Message-ID: <20240725094457.37739-1-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWyRpKBV/eW3KI0g78bWSzW7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNov/e3awW/zdvonF4sUWcYvud+oOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyevR3t7B69P818Pi8SS6APYrLJiU1J7MstUjfLoEr48DJn6wF
	q9gqdu38xdjAuJG1i5GTQ0LAROLk/S72LkYuDiGBJUwSE35fB0sICTxllDgwVRjEZhPQl1ix
	bhErSJGIwDJGiW+nu1lAHGaB7YwSJya+Y+pi5OAQFgiW+LDeB6SBRUBVYt+Ck2wgNq+ApcTs
	l2uhtslL7D94lhkiLihxcuYTFhCbGSjevHU2M4QtIXHwxQtmiCMUJd4/7GCH6Z127jUzhB0q
	MX/Nd/YJjAKzkIyahWTULCSjFjAyr2IUys1Mzk4tyszWK8ioLElN1ktJ3cQIig4RBq4djH1z
	PA4xMnEwHmKU4GBWEuFddn9hmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe1R3BqUIC6Yklqdmp
	qQWpRTBZJg5OqQZGp5o5f6Z1cj6Q6/13lue7qpr6zqUfbkq1RK8/kV1i6qE98cuFg9vYQnKj
	bm+ZtfIj25P4NWUp5v0zN3LwFoay1TQ+WWJ53Gn36r6V4Zmiu1kYp86UaHgo5sqYfNdRv6xh
	+f9z/580yR4Q131xqnDlXZmoCyu9Hxh4PzGTZZrz7mvvpIbZpwQ5lViKMxINtZiLihMBq3XS
	+XwCAAA=

Adding overlays for the phyboard imx8mp and updating them in
the Makefile.

Yashwanth Varakala (3):
  arm64: dts: freescale: imx8mp-phycore: Add no-rtc overlay
  arm64: boot: dts: freescale: Add no-spiflash overlay
  arm64: dts: Add phyBOARD-Pollux dts for rpmsg

 arch/arm64/boot/dts/freescale/Makefile        |  6 ++
 .../dts/freescale/imx8mp-phycore-no-rtc.dtso  | 12 ++++
 .../freescale/imx8mp-phycore-no-spiflash.dtso | 16 ++++++
 .../dts/freescale/imx8mp-phycore-rpmsg.dtso   | 57 +++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-spiflash.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso

-- 
2.34.1


