Return-Path: <linux-kernel+bounces-353082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0F992831
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A174AB22F81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285019923D;
	Mon,  7 Oct 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gudthhh5"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9618BC2D;
	Mon,  7 Oct 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293544; cv=none; b=t+PyaEa9iQguhC435t2QuyQ8DN4E9W1q8oSQx201RDi9e8I6PZP+4M/pZckyJXiksxQL1WUsKTZfmCLRTyr37SnzmCwmnOSkioK0AuaE9IFfyrYT6Ssdg9PJf1JslLcBLQTVNHSx1xeszz4929a7A1lb/KOqjch080nyiPdBHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293544; c=relaxed/simple;
	bh=6u07R4RIZtY2VJTqZEFqHhxEjSJmD31RTu+iKtt9lPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwHKfhV9lBW6wDc5EexSoxILrDbRRtbcOA0t/S6K0Y2RKFNCOSS7Jp0bhNxcCNOE1saO2DUv6IobYqQf8c2rG3DJUaudnMcz8keUYBgzVodH0ye0a6xSBBz8yLKy7CmB/0VBh9ejuaWaR2UOvViNyjMHAbjLZFFfk4vShEYQen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gudthhh5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id F3F2E20B33;
	Mon,  7 Oct 2024 11:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728293540;
	bh=RrIkTi/ymDfvWUGLsl95l01h7JrOaCRIN8ELPQBuWlk=; h=From:To:Subject;
	b=gudthhh5D4g0eZlVDnzqAeGJ+hIwQyhrOBt+/q5SEtpzcoAvcfYV6n4wM9yiIdVM0
	 DARMZKtQSl0shN+eEeSkTG742xASL3maQ90KunG//USDrrgj0+ssEnckMvOfrqU7F5
	 EcWQUBhwFD7bFrnbYushg5HF9fXZoIgxBDM8yRPBDyyoMytx3ZpkJSjeqDlT28gO2M
	 EEKFIoBW2rJoX3s3ElvbVWq7q4gHhnl2r0VW5nG7h5aIDpv5qBOWVuOfrQiWR5PmTX
	 dbVj4CAy17Esugy31oWO4dpwhjtbzDUBfZYyMhkb6R9BMOFEf6cuZBCIvt31cn7nxg
	 1/u1C8H0DpT1w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] USB: xhci: add support for PWRON active high
Date: Mon,  7 Oct 2024 11:32:05 +0200
Message-Id: <20241007093205.27130-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007093205.27130-1-francesco@dolcini.it>
References: <20241007093205.27130-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Some PCIe-to-USB controllers such as TI's TUSB73x0 3.0 xHCI host
controller supports controlling the PWRONx polarity via the USB
control register (E0h). Add support for device tree property
ti,tusb7320-pwron-active-high which indicates PWRONx to be
active high and configure the E0h register accordingly.
This enables the software control for the TUSB73x0's PWRONx
outputs with an inverted polarity from the default configuration
which could be used as USB EN signals for the other hubs or devices.

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: s/polarity-invert/active-high
---
 drivers/usb/host/xhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 91dccd25a551..4bdef01735eb 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -641,6 +641,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
 
+	if (device_property_read_bool(&dev->dev, "ti,tusb7320-pwron-active-high"))
+		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
+
 	return 0;
 
 put_usb3_hcd:
-- 
2.39.5


