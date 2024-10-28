Return-Path: <linux-kernel+bounces-384771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E449B2E35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7121F21851
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578F1D5171;
	Mon, 28 Oct 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tUI/dh5U"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDA1DC1B2;
	Mon, 28 Oct 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112873; cv=none; b=CtvTEtT3W5NB3O5AYwYFbKRFIcf/68i0mYNujPd99foP/37mU1x8U0/fC7JScN3B5pFriNAMri4wdhIE3TF+FjpqrQNwQso2qGwUTkznqT+D6ogJe+gpn/Ciktd9OmlPmOGAVZQKiuIt0klAMhne6ElxdDIUkJQUzfC4FvgmrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112873; c=relaxed/simple;
	bh=WWM5j4iyr5uf9zwNqp3cN4Hkp2o454JK/QH2zlUNTck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8zr6+8f69Zo2Q+C/3IB6sVxa8ibqzF1A2jO+NqGSvpwx2IPrImD8KWAjHZB6A8etZBDZAgaaMFwp8BlMLVAhtZjvNrMq51wikJifw9gr6Th4udHiNPX+T1QWyUSqKBLaVVcwcsIXpWz4n0bPfmVn0+Bge5V+bMJEC6Gd4Egpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tUI/dh5U; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 621741F935;
	Mon, 28 Oct 2024 11:54:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730112862;
	bh=Lh7fePJXXUmxKfVX2o4rq/UZ/vQBYBldJd5mNKxr/A4=; h=From:To:Subject;
	b=tUI/dh5UrbTqI2w3m+gLhHOZd859Cft13v5ayaFkLG1GfnG3el/n/axi81YVHqjOy
	 xio154WS2x1vP57HxbpUNcSogGVK7qQrpvmDHG/i8WgNRFdaaqEH//Jeowo9qwa91T
	 YicDv8HBKZE3kexeJ83vknWpgsNZgvYE//XRi87tW2kV2h6RfpWgcYaqyNSLv4rJxx
	 RhI0BlNhGB4tpYDl0sUjF1eESatdAsvXIMZcH5V2L+VAxUEVJ4rgcUd6wleqUTpWCd
	 mRD70dwd2xNHH+udP2WGgiFir9QsJ+r/LsmYLGJlI9fyv55OqVbeFnEO/7RlkOko0i
	 rafToiE6WxLEA==
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
Subject: [PATCH v4 2/2] USB: xhci: add support for PWRON active high
Date: Mon, 28 Oct 2024 11:54:13 +0100
Message-Id: <20241028105413.146510-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028105413.146510-1-francesco@dolcini.it>
References: <20241028105413.146510-1-francesco@dolcini.it>
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
v4: no changes
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


