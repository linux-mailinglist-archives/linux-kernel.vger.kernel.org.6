Return-Path: <linux-kernel+bounces-386407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEED99B4310
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4585AB22019
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D59202F75;
	Tue, 29 Oct 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Gh9mufD9"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40622022D9;
	Tue, 29 Oct 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186696; cv=none; b=XL5akUWsvgHZN34IVQNBjWHyVVJPJ3j6TVsSAXaouwdTY9B4xUxgWkWlNYbD3qGpxUZY7wsrh0VJ6qppq0E7VTXozVbsX+lkT4tgyojA2cIST5H7gal5MIeWX5k90Z/htGhUVRsVCYeAVu3qon4rAaIe3VSyA4Ft1ZNntmD8itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186696; c=relaxed/simple;
	bh=SsSlpUpEv76nMrEJCbfiVmYermONdCXH6UiHOCjsCfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJ+L1AiWPO0qCG9oPtsu6pjHhCm9Cu1btHid5Tyt2AMASGzaofjbMirZx/YZ7DAQuw4ELG4iccdvasMKcia9XnxB0Sk10incTrHNq7D8XhLRe0hvfFAGMVHmWNs8JDeFKS83A4wUEfwb47a565+N9HP01evTwGYcvqOIldutBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Gh9mufD9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E59371F994;
	Tue, 29 Oct 2024 08:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730186689;
	bh=0msPWt501zLWNCU+SV3sGc8fEv6GGOoWNeA5Ni4Teuk=; h=From:To:Subject;
	b=Gh9mufD96V2apbjGEGjJGm2+99AyWb0ClbXSXI32ep5gRWWecLICMlZjTjiFRtCem
	 2FbQ6XyBjsJtKEcmpZsGYR2LDcnbg2+MF5AaFc3qW124/xybGW6fg5iDNlMC8FS7az
	 aW+WS6+ZxVyYuo8pTquJz8MkJcOmDZnowMCyU7PUK8NreUjr85sv3ieKttkf3+/+DS
	 MJ4jOp2xf0HTBMIKeSy6YxwJsl19VffCUm9mF8xzH9g9oq+MMy5DimdnwOFdbUgiv6
	 M6T0KJv4X5wdrLAixG5j+vRDOYgCiN8X3nM0ZMxwbKhcHI5rX01V+Mk4WViB8WkYvY
	 IrsF+Tm1j6GrQ==
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
Subject: [PATCH v5 0/2] USB: xhci: add support for PWRON polarity invert (TI TUSB73x0)
Date: Tue, 29 Oct 2024 08:24:42 +0100
Message-Id: <20241029072444.8827-1-francesco@dolcini.it>
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


