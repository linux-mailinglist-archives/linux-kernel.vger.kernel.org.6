Return-Path: <linux-kernel+bounces-312580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C7196986B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB12282C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C301AD241;
	Tue,  3 Sep 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="UJh5feOF"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629571C7697;
	Tue,  3 Sep 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354772; cv=none; b=diCoHXpKXZD3PnXh0pEpNpvBv2SEII0rwkeLKbY6qvqg9Jsja7kP4sNh9O8F121dn0HwIyLIiuLjpaopeFoLjns9J2hRCqS0uPsvA2X+S2T8Pz/y+wlScYqkBE8JovrPp3vm6hSWpZMqBlldm+OFjOIOz7zrmDmpUkmK/yDRDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354772; c=relaxed/simple;
	bh=vGwP0yWHIRZQh5ybTnwESUm3/xJyNJD/bJzGLmfxUp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z1LPNqboxYJAjH/vFY5K3CbwkJeVb+PGxAPbcWz3JTrwYFmvcH8F9IzN8f9IInz9vKHBsW8YoTXJP890uYYD2CpcQ1YIgcApLRfoy9falcojx2CgEXVZ/PEzjxIib88aZZcPOzNZKlOQ4sqsN0ULnCTqgnKRuC1qpJEuLbio59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=UJh5feOF; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id D6922211FF;
	Tue,  3 Sep 2024 11:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725354762;
	bh=TKa+NUiDEXY9sgVcRsX2pMmhkw/pTOpi2QU6kSg6znk=; h=From:To:Subject;
	b=UJh5feOFXFMi6N7GarscxJQKZlYPWQVrKoueVMUAX2RfO76XFDAX+MimsB5b0sdCP
	 o5OplpWzQrJ9lMTq+xkcG8ZwTASz+b4wH5VGRrW1huM8Ar9z7myE0eAN8193mb1Oe+
	 5Brg1pxGhboBePn6vywoAX9e2/qUE8/eZEySWRmV+jqjXRZnrOAI1TTtdgoOqa+GLE
	 AdBoY+WsFpz7Rw9OLY6wP8HCAZp8hst9LVNedqwonWhsse8KEUMwbA8KuYMMkFRMs0
	 DXSBXNSLdbf04DOdLyvTtFoXGt6SzGpLKK1XDKXlhudnb9LuAoEKKrhWXra20FylOe
	 Xn33quKQJ9Ulw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: dts: imx8-apalis: Various improvements and additions
Date: Tue,  3 Sep 2024 11:12:26 +0200
Message-Id: <20240903091231.20035-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series improves Toradex Apalis iMX8Q support adding:
 - correct thermal zones
 - analogue audio
 - USB Host (Apalis USBH4 interface)

In addition to these it also removes the adma_pwm from the i.MX8QM SoC dtsi, as
this IP is not available on this specific SoC.

v2:
 - Keep I2C nodes sorted by address

v1: https://lore.kernel.org/all/20240826221541.15669-1-francesco@dolcini.it/

Andrejs Cainikovs (2):
  arm: dts: imx8qm: Remove adma pwm
  arm64: dts: imx8-apalis: Set thermal thresholds

Hiago De Franco (1):
  arm64: dts: imx8-apalis: Add nau8822 audio-codec to apalis eval v1.2

João Paulo Gonçalves (2):
  arm64: dts: imx8-apalis: Add audio support
  arm64: dts: imx8-apalis: Add usb4 host support

 .../dts/freescale/imx8-apalis-eval-v1.2.dtsi  |  69 +++++++++
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  31 +++-
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  31 +++-
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  31 +++-
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 135 ++++++++++++++++--
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     |   3 +
 6 files changed, 273 insertions(+), 27 deletions(-)

-- 
2.39.2


