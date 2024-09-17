Return-Path: <linux-kernel+bounces-331856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9195697B214
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D82288B69
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246121D017C;
	Tue, 17 Sep 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="B98xYqHO"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295961D0143;
	Tue, 17 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586389; cv=none; b=OBA4jQChsbxE7I2eq65eu7YftnTTArLpe1GSMWCoN3FRFSXqt+GMINL4dF0amOuDZz7f+QI7CoNIIPfTKklnOLEOmXd382KJuoO7LaOLbE4TBHwSteu4GJIKdOAbdwarqkEBF4WIwwbHHDSbKTJGxmZaJ+35vh76rHO8OuSn91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586389; c=relaxed/simple;
	bh=pa485UOUkElKygnxw79IBPNMjoDl+Ap2Tje5OinibaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7p0hatVQUoIKFdOshiS44AXMrxFg5y3h2SIYxD5ZuBopEgcnFTKkvJUot/K6bW2aKn7GG3z3N0YF7urXPrAKFfAKwDHyG4pdY81ua6IaneZ/4L9eEa7IFT0kec+JVUE6jIGsWFpM5HatHs3tgwGA8WkeBKYr4ZcpMYYHR/6OQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=B98xYqHO; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726585839;
	bh=AAPF2+cdPzfUKD00WoAQzPpdJ/0u3TYSCKdZMRoyuLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=B98xYqHOPffcTL14JM2hywqoYqe2HFWtBcjLqt3kkhH+y67JZm+tYpznPnv8uM6R0
	 DAXM/LLNSioMi7mZquKO23GBRfBefiSdqSqxPqntI7XGt7gt0Vsl/zsWdFog9Q1xaq
	 d6ZU1UHgxCpAKNNg2TzNGr4FEWVggOaEuDWXEvDk=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 731CCA0548;
	Tue, 17 Sep 2024 17:10:39 +0200 (CEST)
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
Subject: [PATCH 0/4] Add support for new IMX8MP based board
Date: Tue, 17 Sep 2024 17:09:57 +0200
Message-ID: <20240917151001.1289399-1-michal.vokac@ysoft.com>
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
 .../bindings/usb/diodes,pi5usb30213a.yaml     |  95 ++++
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 521 ++++++++++++++++++
 4 files changed, 618 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts

-- 
2.43.0


