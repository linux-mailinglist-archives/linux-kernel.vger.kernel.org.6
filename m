Return-Path: <linux-kernel+bounces-334063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7597D231
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F321F255E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A25D915;
	Fri, 20 Sep 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="gTk0Nu1X"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F418EB1;
	Fri, 20 Sep 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819331; cv=none; b=VdcrR40uuUPtGNZ/iuLMuvCUfRqdmcl9KQ7bwUJiNWFBVWUc6S4yMZl0Af93Gw+WkWJe8D/JW9xFtq9EGO9dZFbQg5BizYO0f9nR2jx3n8ejBxzFDPrkUc70dCkekQQN83SnT5II7ZXDkoGRnl9gOVdAUFVakj3xaiOkKsbdP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819331; c=relaxed/simple;
	bh=4t9FIdG8kcgMmWsigSoI8Jasp4vMsO39N68Dc9kJ7xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4zpF2i2wiY2wgncs2WMrwq/6PelFXL5wRdKVmhHvmRLjBoXX8qLC10asbyQ2UJ6hGcsp1hIgJGjHnMJdkRZZ1us8SA95u/byAZau4TjvIaT+DeeYA4qei+VaE3/mj23TcvIfOY4yQa0pN/omRXbN7wSzXCgn2m9wLhsWw5EJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=gTk0Nu1X; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726819324;
	bh=eNwOUsnTzpWabWCjSD0aAJbn8IKtEXU1rIipDUczE6o=;
	h=From:To:Cc:Subject:Date:From;
	b=gTk0Nu1XyC3Oun7Izllc+bHHB3+nwekV86IrrlXdEyDtDOAVrzbFfNlTysrQngHi5
	 4l4wQD/8lo6Dgpt/cD6JrJy9cgGAFzyE8s4S8AijH2zi7Ur532EBDrlICZfxUqHDmJ
	 xO0GT3hHIYw3p9yi/UpM67dhshbeN8IbzLVyhTAo=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 1F87DA0419;
	Fri, 20 Sep 2024 10:02:04 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Petr Benes <petr.benes@ysoft.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
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
Subject: [PATCH v2 0/4] Add support for new IMX8MP based board
Date: Fri, 20 Sep 2024 10:01:50 +0200
Message-ID: <20240920080154.1595808-1-michal.vokac@ysoft.com>
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
The board is based on the i.MX8MP SoC. The first two patches
add support for most of the board functionality except USB Type-C
port and some other minor things.

[PATCH 3] adds new device tree binding for a Diodes Incorporated
PI5USB30213A Type-C Controller and [PATCH 4] enables that port on
the IOTA2 Lumpy board.

We also wrote a driver for that Type-C port controller. I would like
to get that driver upstream as well but I expect it will take much
more iterations and effort to get it into mainline-ready shape so
I intentionally excluded it from this series. AFAIK it should not
be a problem to accept a device tree binding for a HW that does not
have a driver in the kernel yet.

Michal Vokáč (2):
  dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
  arm64: dts: imx: Add imx8mp-iota2-lumpy board

Petr Benes (2):
  dt-bindings: usb: Add Diodes Incorporated PI5USB30213A Type-C
    Controller
  arm64: dts: imx8mp-iota2: Enable the USB Type-C port

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../bindings/usb/diodes,pi5usb30213a.yaml     |  88 +++
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 518 ++++++++++++++++++
 4 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts

-- 
2.43.0


