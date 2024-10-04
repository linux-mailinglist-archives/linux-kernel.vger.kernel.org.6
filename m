Return-Path: <linux-kernel+bounces-350308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CEF99033B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458041C214E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298C1D6DCC;
	Fri,  4 Oct 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="NVVLVauI"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A21D61B4;
	Fri,  4 Oct 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045939; cv=none; b=UYZ0dPmRy2hSDTnU/ZMHp4P6lVtcuypRb6amP91KpbKj58RfYmEDXbg+Tnbp5gXY5FRAMEyiQdONC/gQrf9m72vwQ9n982Yv8JvyUMgBJHOSvN+TPewuLs1y98iaq263THpcybIZAZwHTNuMtC3l1z6ebPAQ+IqYygrZOEcfyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045939; c=relaxed/simple;
	bh=bLiZ17QogmoYNpekAVvTYq5nak/lRaC//PESCaNH/1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rfTUBam71qjNMu5C+RuMX9WT/C8qbp47cIgyCanMMDzgZPOtKAXrFiv5JuPb0WI7/ip4aQ630vQ/RClbA2W73vgQUnXAuEIzVDES/SJJKgBFk2J2q09A1SQ7VwiHvubg6Ve4yYxxc3ypaZSGbhX+zXUiuKuaosnD7pM5BO4Tgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=NVVLVauI; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7CDEF20A71;
	Fri,  4 Oct 2024 14:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728045926;
	bh=m/7lmsfv2cSSlkpUMqssSE0ohnTgHs23i0Fm3MR7Qcw=; h=From:To:Subject;
	b=NVVLVauIZMWoghX6X42ePZJ1Zu90dzeRVemPdQ34RdY7aPGqcARlMSxRjM2wVTuRr
	 ZlfMCMZ4WUA/UZEqOaVeei4RxN0VwN+h7m/87eOGNh1VKgDLi65BXBQmT2qiTWaZ5t
	 ABGR5njQjYmn08Eu+s9uUMGN6USPp1SngQfeRUjJq4QrcU46GM3ZXV8RlcgMWGzbPt
	 AUyBIoOpLRFppIU/A4VcgC5Nay3VqvxpNBADpmx92YcJtZYmqep8OLCtHL6EhFHo6J
	 08rELYvNYN55aZJDhN2szYP5rKx3kevvcuBcxNQcp0j8p+6abds2AX55K6aOH/xe4J
	 xeYXwd0HDN7YQ==
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
Subject: [PATCH v1 0/2] USB: xhci: add support for PWRON polarity invert (TI TUSB73x0)
Date: Fri,  4 Oct 2024 14:45:19 +0200
Message-Id: <20241004124521.53442-1-francesco@dolcini.it>
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
TUSB7340 supports up to four. It supports to configure the polarity of
the PWRONx# signals, which are used to control other peripherals.
In some systems, the default polarity needs to be inverted, which is
supported by the given hardware through the software configuration. This
patch series introduces TUSB73x0 PCIe device tree bindings and modifies the 
USB XHCI PCI driver to handle PWRONx# polarity via a device tree property.

TUSB73x0 datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf

Parth Pancholi (2):
  dt-bindings: usb: add TUSB73x0 PCIe
  USB: xhci: add support for PWRON polarity invert

 .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  3 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

-- 
2.39.5


