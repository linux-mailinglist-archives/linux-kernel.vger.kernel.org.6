Return-Path: <linux-kernel+bounces-294387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4A958D14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38F01F20FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F51BD515;
	Tue, 20 Aug 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="TnrEFjCC"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086394085D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174365; cv=none; b=WfAr3VgMps1IWVn5r2Gvigfs+srX6n1xk3QsjPIQlW5vUgwQxiLuXt1xxKt0iNVs1r1SqSItZhpd6DXVuK1R7WhY5R/O2+YFtb4qWFCasOi8x/2DWyEMa3p9Z/H0l4ZGjRoiUbq4yNd6rvl//2Y1WbAK/jreHnK0HdG6x5F1No0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174365; c=relaxed/simple;
	bh=f2BbHSTTA7R5FuseVuUWZQUx64iouUehZmPyL6EwSss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BGAyOHo4ZtgIKostoxvXk/hPVx2puO1+r8zCTS8Op1gqc8v/Rzf/jl8NWCk8EsFTIBTa1vWkDyQH9oTnFhyvTlFY4tXfAZQur15N8M487NmlqliHWdZ4WtDzcrdx5gqqNPdsvbyAwlcgvi/FMFHtDkjnnfBYYnbGbbLqxTdbH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=TnrEFjCC; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724174355; x=1726766355;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f2BbHSTTA7R5FuseVuUWZQUx64iouUehZmPyL6EwSss=;
	b=TnrEFjCCye0wIEqJbxlmBzfrglroa5tMhkJ4dLvGxsBQPPnOjt7UOWIX8cMQZcrO
	lUUp+Ue1/4SKCdKE2aiafdNJWyphWNYfep4y/9U1uTARofjBVfk50wOJUcKkNpVI
	9jz9ofMof9Vfs7SgedgWznLffrzLV7dnRUQmYOGHHNY=;
X-AuditID: ac14000a-03e52700000021bc-15-66c4d0138a9a
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 6F.60.08636.310D4C66; Tue, 20 Aug 2024 19:19:15 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 19:19:15 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH v2 0/3] Add overlays for imx8mp
Date: Tue, 20 Aug 2024 19:18:45 +0200
Message-ID: <20240820171848.177926-1-y.varakala@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWyRpKBV1f4wpE0g0NrdCzW7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNov/e3awW/zdvonF4sUWcYvud+oOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyevR3t7B69P818Pi8SS6APYrLJiU1J7MstUjfLoErY8+z0oIt
	HBWnZ5xmbGCcx97FyMkhIWAi8XfbUiCbi0NIYAmTxOUfnawQzlNGiV+NP5hBqtgE9CVWrFsE
	lhARWMYo8e10NwuIwyywnVHixMR3TCBVwkBVG6+9BbNZBFQlbn47CNbNK2Al8fAbRFxCQF5i
	/8GzUHFBiZMzn7CA2MxA8eats5khbAmJgy9egNlCAooS7x92sMP0Tjv3mhnCDpWYv+Y7+wRG
	gVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgTFhwgD1w7GvjkehxiZOBgP
	MUpwMCuJ8Ha/PJgmxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJ
	g1OqgdFqntvXkLMluvMv9rKrTNrFUV0baLNB/Dlr2uu/m2sX/n/NP2Vb2t1e667zSw2Vve06
	Lyy69+Z6iPvpO7l+nPfPCZudcXX8znLEqI7dw+sJ196n5fd/HVje8Gzu0VMJNjsTnl245Py7
	WVmykWnOHYablrN374+smpyh8feX6ozolOKomYt3bRFUYinOSDTUYi4qTgQAo+GUDn0CAAA=

Add no-rtc, no-spi flash, remoteproc overlays for the imx8mp
and Update Makefile.

Link to v1:
https://lore.kernel.org/all/20240725094457.37739-2-y.varakala@phytec.de/

This patch series is dependent on this no-eth overlay patch:
https://lore.kernel.org/all/20240710-bspimx8m-3180-v3-1-8ef55381172c@phytec.de/

Regards,
yashwanth.

Yashwanth Varakala (3):
  arm64: dts: freescale: imx8mp-phycore: Add no-rtc overlay
  arm64: boot: dts: freescale: Add no-spiflash overlay
  arm64: dts: Add phyBOARD-Pollux dtso for rpmsg

 arch/arm64/boot/dts/freescale/Makefile        |  6 ++
 .../dts/freescale/imx8mp-phycore-no-rtc.dtso  | 12 ++++
 .../freescale/imx8mp-phycore-no-spiflash.dtso | 16 ++++++
 .../dts/freescale/imx8mp-phycore-rpmsg.dtso   | 55 +++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-spiflash.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso

-- 
2.34.1


