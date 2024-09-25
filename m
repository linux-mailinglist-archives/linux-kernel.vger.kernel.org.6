Return-Path: <linux-kernel+bounces-339102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E22986053
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDBD1F26982
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC61A2C34;
	Wed, 25 Sep 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="JC8ybgvy"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBE1A2857;
	Wed, 25 Sep 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268578; cv=none; b=JwI+AgFiUc+E01KzElFtRrRgIK7xRTaF9MNOWvoojjVdLGek82uc+BEP5S7362vKXZnDPOkPcWG9gpCDIlc1ouMYEHn8w+ayhy4QoBRIt1r9oMwFIlVU+EkQp8mpsaMqjOh/SQlbSwHx9NLlEgBGzAi1RgZjJND+wN93l8vgNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268578; c=relaxed/simple;
	bh=dNP4cVkYeMVPCUAl6V9ZNPpmFdKOOmK3mbBZjBEMtfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rfKgSpgqHeJ5J8Jbv6gS33RCQY3ag56glscBPdmSNU4NvLHBZre2xmVoAvE77L8z/GdZ13sV+Q2D2pjHWW7d72DGowOb3yhsQrdVyImdOnduX8N+46VH2KdZid1IVXOoBrZCRfMJ1pSF/KzFARfZcZ4b2B/uJZQ5FqNtdiv8TBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=JC8ybgvy; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727268574;
	bh=b/byf2gL4R1q3RchD94jm7yV/wDyD9oU7cKPxmILi+0=;
	h=From:To:Cc:Subject:Date:From;
	b=JC8ybgvySmpK0QTK1RuXuKxQJz7gkfiC68gRZmsUtBnMorZeBIMrNI6FKznrbGAgy
	 Gpe43NAooAxMt+V5rsh7oqsCryfr/4RPLbwOizw8V85bmOuwHSMOZI+s9hIeJkzCvw
	 8g6VyGjtWw1tjQ+S4mIDM+XQN/KKBTEgKYoKueJg=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 2CCFDA025E;
	Wed, 25 Sep 2024 14:49:34 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Petr Benes <petr.benes@ysoft.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v5 0/2] Add support for new IMX8MP based board
Date: Wed, 25 Sep 2024 14:49:01 +0200
Message-ID: <20240925124903.1837869-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
this series adds support for a new member in our IOTA platform.
The board is based on the i.MX8MP SoC. It adds support for most
of the board functionality except USB Type-C port and some other
minor things.

This series originally included the dt-binding for that Type-C
port controller but I finally removed it based on a good comment
from Krzysztof. I will post the Type-C binding including the driver
in a followup series.

Michal

Michal Vokáč (2):
  dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
  arm64: dts: imx: Add imx8mp-iota2-lumpy board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 423 ++++++++++++++++++
 3 files changed, 425 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts

-- 
2.43.0


