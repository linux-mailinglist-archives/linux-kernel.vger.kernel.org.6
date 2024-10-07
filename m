Return-Path: <linux-kernel+bounces-353083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF95992833
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067DC1F2254C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75B19A2B0;
	Mon,  7 Oct 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="EERU6cqV"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028C18BC17;
	Mon,  7 Oct 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293544; cv=none; b=mc2u5Kjcl/OCBmedM9Evci9mseObMiTt4u6fCKuwNBSM4fngaZLU3ZWNfALpNV7zhqNZDjj51niwtOpXTZlXAVdlPRtXtBo/RtizBikNGxO4eGrnqB/AKW4plZfilpa1hBtaVMdCvJGM/nTt6PRtvXuT6HmeO9AK84vEBtfZHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293544; c=relaxed/simple;
	bh=HGta/n0pKXj/TF1bQrK9DqB70iYkW9xlD771iFsj2Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J3PR1q1/lqq/p1/7udU1ZPIiTwJ8tKFtPOvgQFAr0UlWVHZUsJ2Y1Of7zeBEyhwfqpaAAvJO/yjUha8vGTi7Owwcb1kq+lxjFTWoMLmm+C/mRrdYxHfVLuXigrZKlqvRMznP4J5iBiLjFEftoQgANKt99z/VIWdEXZsWljjdr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=EERU6cqV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 043D41F918;
	Mon,  7 Oct 2024 11:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728293539;
	bh=IMLE0i7G8eFk8FaaGybXE/sgW9ePXyU13NLirlrvKnU=; h=From:To:Subject;
	b=EERU6cqV3cv+88PAnChDzig6BLtM52ISQscmF8qbP+LpOomfluMfND/IClCURPTx7
	 wsf6fHCrnGISH+qGkyMQzDnv/w5M+fccD0kKHYS3qAwe7B6P9LtTuvP2otdujIInQe
	 sRirxbFM76vah/0rvhGvpZDAXcOhnIa0iTh0k/hXJzQaQ5IgQ77hCloe4oYkhMDJ6G
	 znkLsFzou9+vPwCd9FIfe3qsiQ/nAyfx7FPED6qe/0m36pUxOw90jY6GZEb8vs4sbt
	 smpxJhExdIlo3OwDBie5CuUF3yHePHe3tKMG7mXzb9h0xSAyriEeil1IyfKwxs/59R
	 JbAQsr4PdEQBA==
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
Subject: [PATCH v2 0/2] USB: xhci: add support for PWRON polarity invert (TI TUSB73x0)
Date: Mon,  7 Oct 2024 11:32:03 +0200
Message-Id: <20241007093205.27130-1-francesco@dolcini.it>
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

v2:
 - Change the property type from bool to flag
 - Rename the property as ti,tusb7320-pwron-active-high

v1: https://lore.kernel.org/all/20241004124521.53442-1-francesco@dolcini.it/

Parth Pancholi (2):
  dt-bindings: usb: add TUSB73x0 PCIe
  USB: xhci: add support for PWRON active high

 .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  3 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

-- 
2.39.5


