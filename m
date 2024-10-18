Return-Path: <linux-kernel+bounces-371541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26039A3C70
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5761C226BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11C2038D0;
	Fri, 18 Oct 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="IXFrDYY7"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47120127B;
	Fri, 18 Oct 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248917; cv=none; b=MJ5heBOh15UXBK+OH0tno3uJumbq/W05IqRAjAEbTiNytJL+e9TlDGf34EU9Ow7qEP5DLCZTnzikIaeTFXpSM0TZRC4HstulUMK3kvaG2Q0tBtuobrricJz/x+uysYmHajdgx+cfprZjIZmnIsCZixHMlIZY10m7yUEk9ZYuXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248917; c=relaxed/simple;
	bh=3RLG839WJ+uQerJG8XDx6MlD4Q2QrL+B6e6HYViYqIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj+OwlPp4NJM+4qYB8lVGRJyZWg2heIYNnVCkj09A2oppZF80RdsoF6jvUIRoaVDwN780ol2w76m6yHRAoV6ufB1D4GYwYHKrgxXZvlnZHBiEFlEHwS3/wlVi7AhflWKAcajqIe3HXX0Atz5rrEaafWwNvArG/cW2YS34gLAmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=IXFrDYY7; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B3D271FAB1;
	Fri, 18 Oct 2024 12:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729248913;
	bh=0+UVarAfWVCipiZ18p0z4XLpCq8pCStwtFOTwNqFkbI=; h=From:To:Subject;
	b=IXFrDYY7K0shIMZ34z8Cu4pMZ1YqkLDzYN2qgnJe++oChLCqV93uhqXIF79xY6zHf
	 kHcyYNKVT/TARHZGaf84P+uZWrA+1hmsvSquyIL2D601JYJ2wj04SBlNfgmlZfhq+q
	 JHNgjAsCV8M8MRv6XOCpt1eTxLQdhNdjMZZdrYauCR649mN5scMSwSmNjHVT0aBcF0
	 t9GlR6HAEr+GWajp8Wjz3x3ROXInn4vr8oALwXQRxxf0iLWdg+wqUksiOdB1YnFTha
	 UEWDtT8J2xN53P6GjkHDGLnIIXbipkXDPQU97bombkbfDGvA/ESYKh36XYroenQZvh
	 Pbrjx3oeQVHGg==
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
Subject: [PATCH v3 2/2] USB: xhci: add support for PWRON active high
Date: Fri, 18 Oct 2024 12:55:05 +0200
Message-Id: <20241018105505.28005-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018105505.28005-1-francesco@dolcini.it>
References: <20241018105505.28005-1-francesco@dolcini.it>
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
v3: no changes
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


