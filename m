Return-Path: <linux-kernel+bounces-384772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398E9B2E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940321C24217
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313C1DD0EE;
	Mon, 28 Oct 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XsK0TyBv"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946B1DC1A7;
	Mon, 28 Oct 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112874; cv=none; b=UoCQjD/yQlNOs4h/kTEHuW8ad3OdVKbevA2k1S/HccZ9H+LBaKe9MYvIVcfVewwKVIEJ1OnMTwFGAeUBqQ+tWOdnRgVUlfgXZzGFV/xxZ3WIdcR+uOehV5Wltq9FnF0bEiTjDDwroheMqVTrLIn8BK9tt8Lf2Pd5QwFJgKU63Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112874; c=relaxed/simple;
	bh=SsSlpUpEv76nMrEJCbfiVmYermONdCXH6UiHOCjsCfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SW1OE39tE3usdkjtHZiCGKxNlWp3Qhol7ukSYIXRTG60F+dLI44diCubBVbWP6Q61M0vujj3+kItLrp3GWwmAsaYyGBtSBoBIMyiJklK70HZ3fbh6TXNGSZtwUIv3N/6TwomHPYHwMH2QxaaCsgGt0sGbbHNFJx+4A9KPbPzhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XsK0TyBv; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 441491F91F;
	Mon, 28 Oct 2024 11:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730112861;
	bh=0msPWt501zLWNCU+SV3sGc8fEv6GGOoWNeA5Ni4Teuk=; h=From:To:Subject;
	b=XsK0TyBvT/kTILKmlnSXVlJZSSDww+LtxW3wDsIbRw6QqikcgaFdOcm7F099l2uQL
	 wVoPaBxx66vb4GksYpMRcq0PCRRQYvQ3DPkWipgATfZSaird3E0gt0gqzbT1kw71rz
	 ex/MqUT2XzVEbbieKBJNEU/HGrvqFxz6lEWyiQDrVIYUbbD1JoEsUgR/RS+5/OyqDh
	 yxwOIxfdf2NYG227lxRZAa/DzZcxXgK+w9VC5QIMZXvhqYDxwfLTBZ3J3lhoTkSA6j
	 Sxi2lzZGBbsbh4+ovqCqbTDxHaYbLZE71xaFJj1d9311GRC2Ma0FluNFpBiUSbg7xj
	 hpoUc38iuLZEQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] USB: xhci: add support for PWRON polarity invert (TI TUSB73x0)
Date: Mon, 28 Oct 2024 11:54:11 +0100
Message-Id: <20241028105413.146510-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The TUSB73x0 is a USB 3.0 xHCI Host Controller Hub using a PCIe x1 Gen2
interface. The TUSB7320 supports up to two downstream ports, and the
TUSB7340 supports up to four. It includes a feature to configure the
polarity of the PWRONx# signals, which are used to control other peripherals.
In some systems, the default polarity needs to be inverted, which is
supported by the hardware through software configuration. This patch
series introduces TUSB73x0 PCIe device tree bindings and modifies the
USB XHCI PCI driver to handle PWRONx# polarity via a device tree property.

TUSB73x0 datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf

v4:
 - DT binding: revise example, add $ref: usb-xhci.yaml

v3: https://lore.kernel.org/all/20241018105505.28005-1-francesco@dolcini.it/
 - Correct the compatible string as "pci104c,8241" (uppercase hex to lowercase)

v2: https://lore.kernel.org/all/20241007093205.27130-1-francesco@dolcini.it/
 - Change the property type from bool to flag
 - Rename the property as ti,tusb7320-pwron-active-high

v1: https://lore.kernel.org/all/20241004124521.53442-1-francesco@dolcini.it/

Parth Pancholi (2):
  dt-bindings: usb: add TUSB73x0 PCIe
  USB: xhci: add support for PWRON active high

 .../bindings/usb/ti,tusb73x0-pci.yaml         | 55 +++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  3 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

-- 
2.39.5


